Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbVFVToG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVFVToG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 15:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbVFVToG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 15:44:06 -0400
Received: from nproxy.gmail.com ([64.233.182.198]:37177 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261917AbVFVTno convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 15:43:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tBx0ZlCOlZigyORyvi2cx6HttcGaMDbl/0mxqVqFDu2o7jdtiC93shBRYDIOUuwwjBa/RHeuLr0b1Z6pTUyhpIj/JAxOH8sGCCb6bUrggxznmpMFYE6EBQIY//tsZ69HTt+h/brFrHxP0wYpvtw1xikl4TeNiOLfOxgRKmd7H/k=
Message-ID: <84144f020506221243163d06a2@mail.gmail.com>
Date: Wed, 22 Jun 2005 22:43:40 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: "Bouchard, Sebastien" <Sebastien.Bouchard@ca.kontron.com>
Subject: Re: Patch of a new driver for kernel 2.4.x that need review
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Lorenzini, Mario" <mario.lorenzini@ca.kontron.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <5009AD9521A8D41198EE00805F85F18F067F6A36@sembo111.teknor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5009AD9521A8D41198EE00805F85F18F067F6A36@sembo111.teknor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some comments below. Please note that I am more familiar with 2.6 so
some of these might not apply.

                       Pekka

On 6/22/05, Bouchard, Sebastien <Sebastien.Bouchard@ca.kontron.com> wrote:
> --- 2.4.31-ori/drivers/char/tlclk.c     Wed Dec 31 19:00:00 1969
> +++ 2.4.31-mod/drivers/char/tlclk.c     Wed Jun 22 09:43:10 2005
> +/* Telecom clock I/O register definition */
> +#define TLCLK_BASE 0xa08
> +#define TLCLK_REG0 TLCLK_BASE
> +#define TLCLK_REG1 TLCLK_BASE+1
> +#define TLCLK_REG2 TLCLK_BASE+2
> +#define TLCLK_REG3 TLCLK_BASE+3
> +#define TLCLK_REG4 TLCLK_BASE+4
> +#define TLCLK_REG5 TLCLK_BASE+5
> +#define TLCLK_REG6 TLCLK_BASE+6
> +#define TLCLK_REG7 TLCLK_BASE+7

Please use enums instead.

> +/*
> +*  Function : Module I/O functions
> +*  Description : Almost all the control stuff is done here, check I/O dn
> for help.
> +*/

Please use kerneldoc format.

> +static struct file_operations tlclk_fops = {
> +       read:tlclk_read,
> +       write:tlclk_write,
> +       ioctl:tlclk_ioctl,
> +       open:tlclk_open,
> +       release:tlclk_release,

Please use C99 struct initializers.

> +
> +};
> +/*
> +* Function : Module Initialisation
> +* Description : Called at module loading,
> +* all the OS registering stuff is her
> +*/
> +static int __init
> +tlclk_init(void)
> +{
> +       alarm_events = kmalloc(sizeof (struct tlclk_alarms), GFP_KERNEL);
> +
> +       if(!alarm_events)
> +                  return -EBUSY;
> +
> +   memset(alarm_events, 0, sizeof (struct tlclk_alarms));
> +
> +/* Read telecom clock IRQ number (Set by BIOS) */
> +
> +       telclk_interrupt = (inb(TLCLK_REG7) & 0x0f);
> +
> +       printk(KERN_WARNING "telclock: Reserving I/O region...\n");
> +
> +       if (check_region(TLCLK_BASE, 8)) {
> +               printk(KERN_ERR
> +                      "telclock: I/O region already used by another
> driver!\n");
> +               return -EBUSY;

You're leaking alarm_events here.

> +       } else {
> +               request_region(TLCLK_BASE, 8, "telclock");

Please put nominal case first (i.e. make this the first block). 

> +       }
> +
> +/* DEVFS or NOT? */
> +
> +#ifdef CONFIG_DEVFS_FS
> +       devfs_handle = devfs_register(NULL, "telclock",
> +                                     DEVFS_FL_AUTO_DEVNUM, TLCLK_MAJOR,
> +                                     0,
> +                                     S_IFCHR | S_IRUGO | S_IWUGO,
> +                                     &tlclk_fops, NULL);
> +       if (!devfs_handle)
> +               return -EBUSY;

You're leaking alarm_events and reserved region here. (Use gotos for
error handling, btw.)

> +#else
> +       tlclk_major = register_chrdev(tlclk_major, "telclock", &tlclk_fops);
> +
> +       if (tlclk_major < 0) {
> +               printk(KERN_ERR "telclock: can't get major! %d\n",
> tlclk_major);
> +               return tlclk_major;

Same as before plus leaking devfs handle.

> +       }
> +#endif
> +
> +       init_timer(&switchover_timer);
> +       switchover_timer.function = switchover_timeout;
> +       switchover_timer.data = 0;
> +
> +       return 0;
> +}

> diff -ruN 2.4.31-ori/drivers/char/tlclk.h 2.4.31-mod/drivers/char/tlclk.h
> --- 2.4.31-ori/drivers/char/tlclk.h     Wed Dec 31 19:00:00 1969
> +++ 2.4.31-mod/drivers/char/tlclk.h     Wed Jun 22 09:43:10 2005
> +/* Ioctl definitions  */
> +
> +/* Use 0xA1 as magic number */
> +#define TLCLK_IOC_MAGIC 0xA1
> +
> +/*Hardware Reset of the PLL */
> +
> +#define RESET_ON 0x00
> +#define RESET_OFF 0x01

Please use enums instead (applies to other parts of this file too).
