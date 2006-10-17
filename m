Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWJQXNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWJQXNY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 19:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbWJQXNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 19:13:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:57187 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751070AbWJQXNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 19:13:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V2kc37Cwa0x40+ODALQd02ziI2juoYO58wFn0NrI/dtaK9w+t1wS0NqIBY6q9NnY79yukcSFQVVGAaY8z3NWeTtk+iF7IJgqw6M+WJmwYqhyDZH8cgZKTNZXzARL/qjkpvNluhaslraidUCQQmmL+XuJjL2gwovjbEsjFcZki/0=
Message-ID: <4807377b0610171613i5df25ddekb8c470d767a11005@mail.gmail.com>
Date: Tue, 17 Oct 2006 16:13:20 -0700
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Tejun Heo" <htejun@gmail.com>
Subject: Re: [PATCH] libata: skip reset on bus not a device
Cc: "Joe Jin" <lkmaillist@gmail.com>, linux-ide@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>, "Jeff Garzik" <jgarzik@pobox.com>
In-Reply-To: <20061009070652.GE10832@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <215036450609292206pd16c7cxa1c5c77ee52c050e@mail.gmail.com>
	 <451E7BD2.7020002@gmail.com>
	 <215036450609301849h64551749uf6b4a3e48c57fe15@mail.gmail.com>
	 <4529BCC4.8060906@gmail.com>
	 <215036450610082354q34b906bdp54a3b9cee52a5855@mail.gmail.com>
	 <4529F391.3030504@gmail.com> <20061009070652.GE10832@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/06, Tejun Heo <htejun@gmail.com> wrote:
> On Mon, Oct 09, 2006 at 04:00:33PM +0900, Tejun Heo wrote:
> > Joe Jin wrote:
> > >>SRST failure would have still occurred but 30sec timeout should have
> > >>gone.  Can you post full dmesg?
> > >
> > >Yes it is.
> > >attachment is the output of dmesg
> >
> > Great.
> >
> > >>Also, please test the patch in the following mail.  You can use either
> > >>git or download the full kernel tarball to get the modified kernel.
> > >>
> > >
> > >Did the pathc against 2.6.19-rc1?
> > >I have test it, but it have not any change and timeout also appeared :(
> >
> > It's against libata development tree.  So, you downloaded the tar.gz and
> > tested it?
>
> And, one more thing to try.  The following patch should fix your
> problem.  It's against v2.6.18.
>
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index 427b73a..3bc7f57 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -2271,11 +2271,14 @@ static inline void ata_tf_to_host(struct
>   *     Sleep until ATA Status register bit BSY clears,
>   *     or a timeout occurs.
>   *
> - *     LOCKING: None.
> + *     LOCKING:
> + *     Kernel thread context (may sleep).
> + *
> + *     RETURNS:
> + *     0 on success, -errno otherwise.
>   */
> -
> -unsigned int ata_busy_sleep (struct ata_port *ap,
> -                            unsigned long tmout_pat, unsigned long tmout)
> +int ata_busy_sleep(struct ata_port *ap,
> +                  unsigned long tmout_pat, unsigned long tmout)
>  {
>         unsigned long timer_start, timeout;
>         u8 status;
> @@ -2283,25 +2286,30 @@ unsigned int ata_busy_sleep (struct ata_
>         status = ata_busy_wait(ap, ATA_BUSY, 300);
>         timer_start = jiffies;
>         timeout = timer_start + tmout_pat;
> -       while ((status & ATA_BUSY) && (time_before(jiffies, timeout))) {
> +       while (status != 0xff && (status & ATA_BUSY) &&
> +              time_before(jiffies, timeout)) {
>                 msleep(50);
>                 status = ata_busy_wait(ap, ATA_BUSY, 3);
>         }
>
> -       if (status & ATA_BUSY)
> +       if (status != 0xff && (status & ATA_BUSY))
>                 ata_port_printk(ap, KERN_WARNING,
>                                 "port is slow to respond, please be patient\n");
>
>         timeout = timer_start + tmout;
> -       while ((status & ATA_BUSY) && (time_before(jiffies, timeout))) {
> +       while (status != 0xff && (status & ATA_BUSY) &&
> +              time_before(jiffies, timeout)) {
>                 msleep(50);
>                 status = ata_chk_status(ap);
>         }
>
> +       if (status == 0xff)
> +               return -ENODEV;
> +
>         if (status & ATA_BUSY) {
>                 ata_port_printk(ap, KERN_ERR, "port failed to respond "
>                                 "(%lu secs)\n", tmout / HZ);
> -               return 1;
> +               return -EBUSY;
>         }
>
>         return 0;
> @@ -2392,10 +2400,8 @@ static unsigned int ata_bus_softreset(st
>          * the bus shows 0xFF because the odd clown forgets the D7
>          * pulldown resistor.
>          */
> -       if (ata_check_status(ap) == 0xFF) {
> -               ata_port_printk(ap, KERN_ERR, "SRST failed (status 0xFF)\n");
> -               return AC_ERR_OTHER;
> -       }
> +       if (ata_check_status(ap) == 0xFF)
> +               return 0;
>
>         ata_bus_post_reset(ap, devmask);
>
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 66c3100..eb7d90f 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -702,9 +702,8 @@ extern int ata_host_set_suspend(struct a
>                                 pm_message_t mesg);
>  extern void ata_host_set_resume(struct ata_host_set *host_set);
>  extern int ata_ratelimit(void);
> -extern unsigned int ata_busy_sleep(struct ata_port *ap,
> -                                  unsigned long timeout_pat,
> -                                  unsigned long timeout);
> +extern int ata_busy_sleep(struct ata_port *ap,
> +                         unsigned long timeout_pat, unsigned long timeout);
>  extern void ata_port_queue_task(struct ata_port *ap, void (*fn)(void *),
>                                 void *data, unsigned long delay);
>  extern u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
> @@ -1019,7 +1018,7 @@ static inline u8 ata_busy_wait(struct at
>                 udelay(10);
>                 status = ata_chk_status(ap);
>                 max--;
> -       } while ((status & bits) && (max > 0));
> +       } while (status != 0xff && (status & bits) && (max > 0));
>
>         return status;
>  }
> @@ -1040,7 +1039,7 @@ static inline u8 ata_wait_idle(struct at
>  {
>         u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
>
> -       if (status & (ATA_BUSY | ATA_DRQ)) {
> +       if (status != 0xff && (status & (ATA_BUSY | ATA_DRQ))) {
>                 unsigned long l = ap->ioaddr.status_addr;
>                 if (ata_msg_warn(ap))
>                         printk(KERN_WARNING "ATA: abnormal status 0x%X on port 0x%lX\n",
>
> -

Is this patch going to go upstream?  I've been testing 2.6.18 on a
couple different systems and seen the same issue.  I haven't tested
the patch yet.
