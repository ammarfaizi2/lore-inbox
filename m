Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbTIIOEh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 10:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264144AbTIIOEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 10:04:37 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:9607 "EHLO smtp.bitmover.com")
	by vger.kernel.org with ESMTP id S264147AbTIIOEP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 10:04:15 -0400
Date: Tue, 9 Sep 2003 07:04:09 -0700
From: Larry McVoy <lm@bitmover.com>
To: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: bkcvs vs. -test5 diff
Message-ID: <20030909140409.GC1990@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20030909120706.GA12391@elf.ucw.cz> <20030909134331.GB1990@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030909134331.GB1990@work.bitmover.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's fine both here and on kernel.bkbits.net.  You probably got burned
by some CVS timestamp bug.  Do another checkout.

+ VALIDATE=2.5
+ rm -rf /tmp/CMP
+ mkdir -p /tmp/CMP/cvs
+ cd /tmp/CMP/cvs
+ cvs -Q -d /tmp/linux-2.5-cvs checkout -P .
+ cd /tmp/linux-2.5
+ bk export -tplain /tmp/CMP/bk
+ cd /tmp/CMP
+ diff -r --exclude=CVS --exclude=BitKeeper --exclude=ChangeSet cvs/linux-2.5 bk
+ '[' -s DIFFS ']'
+ VALIDATE=2.5
+ cd /tmp/linux-2.5-cvs
+ PID=17838
+ find linux-2.5 -type f -name '*,v'
+ sort
+ xargs sum
+ ssh root@kernel 'cd /home/cvs; find linux-2.5 -type f -name '\''*,v'\'' | xargs sum'
+ sort +2
+ wait 17838
+ diff SUMS SUMS.k
+ test -s DIFFS

On Tue, Sep 09, 2003 at 06:43:31AM -0700, Larry McVoy wrote:
> I'll look after I've had some coffee.
> 
> On Tue, Sep 09, 2003 at 02:07:06PM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > I did diff between 2.6.0-test5 and bkcvs, and it seems there are some
> > differences. Is it my fault or something wrong in bkcvs?
> > 
> > 								Pavel
> > 
> > --- clean/drivers/pcmcia/tcic.c	2003-08-27 12:00:29.000000000 +0200
> > +++ /usr/src/linux-cvs/drivers/pcmcia/tcic.c	2003-07-14 01:47:01.000000000 +0200
> > @@ -372,6 +372,9 @@
> >  static struct platform_device tcic_device = {
> >  	.name = "tcic-pcmcia",
> >  	.id = 0,
> > +	.dev = {
> > +		.name = "tcic-pcmcia",
> > +	},
> >  };
> >  
> >  
> > @@ -379,6 +382,15 @@
> >  {
> >      int i, sock, ret = 0;
> >      u_int mask, scan;
> > +    servinfo_t serv;
> > +
> > +    DEBUG(0, "%s\n", version);
> > +    pcmcia_get_card_services_info(&serv);
> > +    if (serv.Revision != CS_RELEASE_CODE) {
> > +	printk(KERN_NOTICE "tcic: Card Services release "
> > +	       "does not match!\n");
> > +	return -1;
> > +    }
> >  
> >      if (driver_register(&tcic_driver))
> >  	return -1;
> > --- clean/drivers/pcmcia/yenta_socket.h	2003-09-09 12:45:29.000000000 +0200
> > +++ /usr/src/linux-cvs/drivers/pcmcia/yenta_socket.h	2003-06-30 22:34:07.000000000 +0200
> > @@ -95,15 +95,6 @@
> >   */
> >  #define CB_MEM_PAGE(map)	(0x40 + (map))
> >  
> > -struct yenta_socket;
> > -
> > -struct cardbus_type {
> > -	int	(*override)(struct yenta_socket *);
> > -	void	(*save_state)(struct yenta_socket *);
> > -	void	(*restore_state)(struct yenta_socket *);
> > -	int	(*sock_init)(struct yenta_socket *);
> > -};
> > -
> >  struct yenta_socket {
> >  	struct pci_dev *dev;
> >  	int cb_irq, io_irq;
> > @@ -111,13 +102,9 @@
> >  	struct timer_list poll_timer;
> >  
> >  	struct pcmcia_socket socket;
> > -	struct cardbus_type *type;
> >  
> >  	/* A few words of private data for special stuff of overrides... */
> >  	unsigned int private[8];
> > -
> > -	/* PCI saved state */
> > -	u32 saved_state[18];
> >  };
> >  
> >  
> > --- clean/usr/initramfs_data.S	2003-07-27 22:31:46.000000000 +0200
> > +++ /usr/src/linux-cvs/usr/initramfs_data.S	2003-07-20 21:11:39.000000000 +0200
> > @@ -1,30 +1,2 @@
> > -/*
> > -  initramfs_data includes the compressed binary that is the
> > -  filesystem used for early user space.
> > -  Note: Older versions of "as" (prior to binutils 2.11.90.0.23
> > -  released on 2001-07-14) dit not support .incbin.
> > -  If you are forced to use older binutils than that then the
> > -  following trick can be applied to create the resulting binary:
> > -
> > -
> > -  ld -m elf_i386  --format binary --oformat elf32-i386 -r \
> > -  -T initramfs_data.scr initramfs_data.cpio.gz -o initramfs_data.o
> > -   ld -m elf_i386  -r -o built-in.o initramfs_data.o
> > -
> > -  initramfs_data.scr looks like this:
> > -SECTIONS
> > -{
> > -       .init.ramfs : { *(.data) }
> > -}
> > -
> > -  The above example is for i386 - the parameters vary from architectures.
> > -  Eventually look up LDFLAGS_BLOB in an older version of the
> > -  arch/$(ARCH)/Makefile to see the flags used before .incbin was introduced.
> > -
> > -  Using .incbin has the advantage over ld that the correct flags are set
> > -  in the ELF header, as required by certain architectures.
> > -*/
> > -
> > -.section .init.ramfs,"a"
> > +	.section .init.ramfs,"a"
> >  .incbin "usr/initramfs_data.cpio.gz"
> > -
> > Only in /usr/src/linux-cvs/usr: initramfs_data.cpio
> > Only in /usr/src/linux-cvs/usr: initramfs_data.cpio.gz
> > 
> > -- 
> > When do you have a heart between your knees?
> > [Johanka's followup: and *two* hearts?]
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -- 
> ---
> Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
