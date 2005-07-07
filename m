Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVGGGA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVGGGA2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 02:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVGGGA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 02:00:28 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:38820 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261157AbVGGGAT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 02:00:19 -0400
References: <5009AD9521A8D41198EE00805F85F18F067F6A36@sembo111.teknor.com>
            <courier.42BA3791.000006F9@courier.cs.helsinki.fi>
            <20050623044952.GA21017@alpha.home.local>
            <200507061411.57725.mgross@linux.intel.com>
In-Reply-To: <200507061411.57725.mgross@linux.intel.com>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Mark Gross <mgross@linux.intel.com>
Cc: Willy Tarreau <willy@w.ods.org>, Pekka Enberg <penberg@gmail.com>,
       "Bouchard, Sebastien" <Sebastien.Bouchard@ca.kontron.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Lorenzini, Mario" <mario.lorenzini@ca.kontron.com>
Subject: Re: Patch of a new driver for kernel 2.4.x that need review
Date: Thu, 07 Jul 2005 09:00:17 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42CCC4F1.000037C0@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Gross writes:
> diff -urN -X dontdiff_osdl vanilla/linux-2.4.31/drivers/char/tlclk.c linux-2.4/drivers/char/tlclk.c
> --- vanilla/linux-2.4.31/drivers/char/tlclk.c	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.4/drivers/char/tlclk.c	2005-07-06 13:21:24.000000000 -0700
> @@ -0,0 +1,459 @@
> +
> +/* Telecom clock I/O register definition */
> +#define TLCLK_BASE 0xa08            
> +#define TLCLK_REG0 TLCLK_BASE
> +#define TLCLK_REG1 (TLCLK_BASE+1)
> +#define TLCLK_REG2 (TLCLK_BASE+2)
> +#define TLCLK_REG3 (TLCLK_BASE+3)
> +#define TLCLK_REG4 (TLCLK_BASE+4)
> +#define TLCLK_REG5 (TLCLK_BASE+5)
> +#define TLCLK_REG6 (TLCLK_BASE+6)
> +#define TLCLK_REG7 (TLCLK_BASE+7)

Enums are preferred. 

> +
> +#define SET_PORT_BITS(port, mask, val) outb(((inb(port) & mask) | val), port)

Static inline functions are preferred. 

> +
> +/* 0 = Dynamic allocation of the major device number */
> +#define TLCLK_MAJOR 252

Enums, please. 

> +spinlock_t event_lock = SPIN_LOCK_UNLOCKED;

For 2.6, DEFINE_SPINLOCK is preferred. 

> +
> +/* DEVFS support or not */
> +#ifdef CONFIG_DEVFS_FS
> +devfs_handle_t devfs_handle;
> +#else
> +static int tlclk_major = TLCLK_MAJOR;
> +#endif
> +
> +static void switchover_timeout(unsigned long data);
> +void tlclk_interrupt(int irq, void *dev_id, struct pt_regs *regs);

Please try to avoid forward declarations as much as possible. The function 
definitions can be moved further up. 

> +
> +DECLARE_WAIT_QUEUE_HEAD(wq);
> +/*
> +*  Function : Module I/O functions
> +*  Description : Almost all the control stuff is done here, check I/O dn for
> +*  help.
> +*/

Use kerneldoc format instead of inventing your own. (Appears in other places 
as well.) 

> +
> +/*
> +*  Function : Module Opening
> +*  Description : Called when a program open the 
> +*  /dev/telclock file related to the module.
> +*/
> +static int
> +tlclk_open(struct inode *inode, struct file *filp)
> +{
> +	int result;
> +#ifdef MODULE
> +	if (!MOD_IN_USE) {
> +		MOD_INC_USE_COUNT;
> +#endif
> +		/* Make sure there is no interrupt pending will 
> +		   *  initialising interrupt handler */
> +		inb(TLCLK_REG6);
> +
> +		result = request_irq(telclk_interrupt, &tlclk_interrupt,
> +					SA_SHIRQ, "telclock", tlclk_interrupt);
> +		printk("\ntelclock: Reserving IRQ%d...\n", telclk_interrupt);
> +		if (result == -EBUSY) {

request_irq() can return other error codes too. It returns zero when it 
succeeds so check only for that. 

> +			printk(KERN_ERR
> +				"telclock: Interrupt can't be reserved!\n");
> +			return -EBUSY;

It's better to propagate the error code here. 

> +/*
> +*  Function : Interrupt Handler 
> +*  Description :
> +*  Handling of alarms interrupt.
> +*  
> +*/
> +void
> +tlclk_interrupt(int irq, void *dev_id, struct pt_regs *regs)
> +{

Why isn't this static? 

> diff -urN -X dontdiff_osdl vanilla/linux-2.4.31/drivers/char/tlclk.h linux-2.4/drivers/char/tlclk.h
> --- vanilla/linux-2.4.31/drivers/char/tlclk.h	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.4/drivers/char/tlclk.h	2005-07-06 12:30:28.000000000 -0700
> @@ -0,0 +1,167 @@
> +/* Ioctl definitions  */
> +
> +/* Use 0xA1 as magic number */
> +#define TLCLK_IOC_MAGIC 0xA1
> +
> +/*Hardware Reset of the PLL */
> +
> +#define RESET_ON 0x00
> +#define RESET_OFF 0x01
> +#define IOCTL_RESET _IO(TLCLK_IOC_MAGIC,  1)
> +
> +#define IOCTL_REFALIGN _IO(TLCLK_IOC_MAGIC,  2)
> +
> +/* MODE SELECT */
> +
> +#define NORMAL_MODE 0x00
> +#define HOLDOVER_MODE 0x10
> +#define FREERUN_MODE 0x20
> +

[snip, snip] 

Enums, please. 
