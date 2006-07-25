Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWGYSSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWGYSSU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 14:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWGYSSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 14:18:20 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:5639 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S964805AbWGYSST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 14:18:19 -0400
Date: Tue, 25 Jul 2006 14:17:33 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Jim Gettys <jg@laptop.org>
Cc: linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org,
       Keith Packard <keithp@keithp.com>
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
Message-ID: <20060725181733.GC4608@hmsreliant.homelinux.net>
References: <20060725174100.GA4608@hmsreliant.homelinux.net> <1153850431.5872.104.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153850431.5872.104.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 02:00:31PM -0400, Jim Gettys wrote:
> Actually, it was Keith Packard who asked for this (and we've asked for
> it before in the past).
> 
> I will note, that if my memory serves me right, the first X driver we
> ever did (1984) had this feature.
> 
>                              Regards,
>                                        - Jim
> 
> ("X is an exercise in avoiding system calls.")
> 
> P.S. my name is spelled "Gettys".
> 
Sorry, my bad (fat fingers).
Neil

> 
> On Tue, 2006-07-25 at 13:41 -0400, Neil Horman wrote:
> > Hey-
> > 	At OLS last week, During Dave Jones Userspace Sucks presentation, Jim
> > Geddys and some of the Xorg guys noted that they would be able to stop using gettimeofday
> > so frequently, if they had some other way to get a millisecond resolution timer
> > in userspace, one that they could perhaps read from a memory mapped page.  I was
> > right behind them and though that seemed like a reasonable request,  so I've
> > taken a stab at it.  This patch allows for a page to be mmaped from /dev/rtc
> > character interface, the first 4 bytes of which provide a regularly increasing
> > count, once every rtc interrupt.  The frequency is of course controlled by the
> > regular ioctls provided by the rtc driver. I've done some basic testing on it,
> > and it seems to work well.
> > 
> > Thanks And Regards
> > Neil
> > 
> > Signed-off-by: Neil Horman
> > 
> > 
> >  
> >  rtc.c |   41 ++++++++++++++++++++++++++++++++++++++++-
> >  1 files changed, 40 insertions(+), 1 deletion(-)
> > 
> > 
> > diff --git a/drivers/char/rtc.c b/drivers/char/rtc.c
> > index 6e6a7c7..4ed673e 100644
> > --- a/drivers/char/rtc.c
> > +++ b/drivers/char/rtc.c
> > @@ -48,9 +48,10 @@
> >   *		CONFIG_HPET_EMULATE_RTC
> >   *	1.12a	Maciej W. Rozycki: Handle memory-mapped chips properly.
> >   *	1.12ac	Alan Cox: Allow read access to the day of week register
> > + *	1.12b   Neil Horman: Allow memory mapping of /dev/rtc	
> >   */
> >  
> > -#define RTC_VERSION		"1.12ac"
> > +#define RTC_VERSION		"1.12b"
> >  
> >  /*
> >   *	Note that *all* calls to CMOS_READ and CMOS_WRITE are done with
> > @@ -183,6 +184,8 @@ static int rtc_proc_open(struct inode *i
> >   */
> >  static unsigned long rtc_status = 0;	/* bitmapped status byte.	*/
> >  static unsigned long rtc_freq = 0;	/* Current periodic IRQ rate	*/
> > +#define BUF_SIZE (PAGE_SIZE/sizeof(unsigned long))
> > +static unsigned long rtc_irq_buf[BUF_SIZE] __attribute__ ((aligned (PAGE_SIZE)));
> >  static unsigned long rtc_irq_data = 0;	/* our output to the world	*/
> >  static unsigned long rtc_max_user_freq = 64; /* > this, need CAP_SYS_RESOURCE */
> >  
> > @@ -230,6 +233,7 @@ static inline unsigned char rtc_is_updat
> >  
> >  irqreturn_t rtc_interrupt(int irq, void *dev_id, struct pt_regs *regs)
> >  {
> > +	unsigned long *count_ptr = (unsigned long *)rtc_irq_buf;
> >  	/*
> >  	 *	Can be an alarm interrupt, update complete interrupt,
> >  	 *	or a periodic interrupt. We store the status in the
> > @@ -265,6 +269,7 @@ irqreturn_t rtc_interrupt(int irq, void 
> >  
> >  	kill_fasync (&rtc_async_queue, SIGIO, POLL_IN);
> >  
> > +	*count_ptr = (*count_ptr)++;
> >  	return IRQ_HANDLED;
> >  }
> >  #endif
> > @@ -389,6 +394,37 @@ static ssize_t rtc_read(struct file *fil
> >  #endif
> >  }
> >  
> > +static int rtc_mmap(struct file *file, struct vm_area_struct *vma)
> > +{
> > +        unsigned long rtc_addr;
> > +	unsigned long *count_ptr = rtc_irq_buf;
> > +
> > +        if (vma->vm_end - vma->vm_start != PAGE_SIZE)
> > +                return -EINVAL;
> > +
> > +        if (vma->vm_flags & VM_WRITE)
> > +                return -EPERM;
> > +
> > +        if (PAGE_SIZE > (1 << 16))
> > +                return -ENOSYS;
> > +
> > +        vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > +
> > +        rtc_addr = __pa(rtc_irq_buf);
> > +        rtc_addr &= ~(PAGE_SIZE - 1);
> > +        rtc_addr &= -1;
> > +
> > +        if (remap_pfn_range(vma, vma->vm_start, rtc_addr >> PAGE_SHIFT,
> > +                                        PAGE_SIZE, vma->vm_page_prot)) {
> > +                printk(KERN_ERR "remap_pfn_range failed in rtc.c\n");
> > +                return -EAGAIN;
> > +        }
> > +
> > +	*count_ptr = 0;
> > +        return 0;
> > +
> > +}
> > +
> >  static int rtc_do_ioctl(unsigned int cmd, unsigned long arg, int kernel)
> >  {
> >  	struct rtc_time wtime; 
> > @@ -890,6 +926,7 @@ static const struct file_operations rtc_
> >  	.owner		= THIS_MODULE,
> >  	.llseek		= no_llseek,
> >  	.read		= rtc_read,
> > +	.mmap		= rtc_mmap,
> >  #ifdef RTC_IRQ
> >  	.poll		= rtc_poll,
> >  #endif
> > @@ -1082,6 +1119,8 @@ no_irq:
> >  no_irq2:
> >  #endif
> >  
> > +	memset(rtc_irq_buf,0,PAGE_SIZE);
> > +
> >  	(void) init_sysctl();
> >  
> >  	printk(KERN_INFO "Real Time Clock Driver v" RTC_VERSION "\n");
> -- 
> Jim Gettys
> One Laptop Per Child
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
