Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267395AbTBLOdd>; Wed, 12 Feb 2003 09:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267393AbTBLOdd>; Wed, 12 Feb 2003 09:33:33 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:55566 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267395AbTBLOda>; Wed, 12 Feb 2003 09:33:30 -0500
Date: Wed, 12 Feb 2003 14:43:07 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.60 (3/34) AC#3
Message-ID: <20030212144307.A8563@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Osamu Tomita <tomita@cinet.co.jp>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20030212131737.GA1551@yuzuki.cinet.co.jp> <20030212132549.GD1551@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030212132549.GD1551@yuzuki.cinet.co.jp>; from tomita@cinet.co.jp on Wed, Feb 12, 2003 at 10:25:49PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 10:25:49PM +0900, Osamu Tomita wrote:
> +ifneq ($(CONFIG_PC9800),y)
>  obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
> +else
> +obj-$(CONFIG_BLK_DEV_FD)	+= floppy98.o
> +endif

Please use a different config option for your floppy driver, i.e.
CONFIG_BLK_DEV_FD98

> +#if !defined(CONFIG_PC9800) && !defined(CONFIG_PC98)
> +#error This driver works only for NEC PC-9800 series
> +#endif

this shoiuld be handled by the config system..

> +
> +#if LINUX_VERSION_CODE < 0x20200
> +# define LP_STATS
> +#endif
> +
> +#if LINUX_VERSION_CODE >= 0x2030b
> +# define CONFIG_RESOURCE98
> +#endif

it would be nice if you could get rid of those obsolete version ifdefs for a
new port..

> +	/* Following `TAG: INITIALIZER' notations are GNU CC extension. */
> +	flags:	LP_EXIST | LP_ABORTOPEN,
> +	chars:	LP_INIT_CHAR,
> +	time:	LP_INIT_TIME,
> +	wait:	LP_INIT_WAIT,
> +};

please use C99-style initializers here.

> +static inline void nanodelay(unsigned long nanosecs)	/* Evil ? */

yes.

> +static long long lp_old98_llseek(struct file * file,
> +				long long offset, int whence)
> +{
> +	return -ESPIPE;	/* cannot seek like pipe */
> +}

use no_llseek instead.

> +		unsigned long eflags;
> +
> +		save_flags(eflags);
> +		cli();		/* interrupts while check is fairly bad */

use proper spinlocking.

> +
> +		if (!lp_old98_char(DC1)) {
> +			restore_flags(eflags);
> +			return -EBUSY;

you don't free an buffer allocated above here

> +static int lp_old98_release(struct inode * inode, struct file * file)
> +{
> +	kfree(lp.lp_buffer);
> +	lp.lp_buffer = NULL;
> +	lp.flags &= ~LP_BUSY;
> +#ifdef CONFIG_PC9800_OLDLP_CONSOLE
> +	lp_old98_console.flags = saved_console_flags;
> +#endif
> +	MOD_DEC_USE_COUNT;

please use fops.owner based refcounting instead.

> +/*
> + *  Many use of `put_user' macro enlarge code size...
> + */
> +static /* not inline */ int lp_old98_put_user(int val, int *addr)
> +{
> +	return put_user(val, addr);
> +}

umm..

> +#ifdef MODULE
> +#define lp_old98_init init_module
> +#endif
> +
> +int __init lp_old98_init(void)

use module_init/module_exit instead.

> +	if (check_region(LP_PORT_DATA, 1) || check_region(LP_PORT_STATUS, 1)
> +	    || check_region(LP_PORT_STROBE, 1)
> +#ifdef	PC98_HW_H98
> +	    || ((pc98_hw_flags & PC98_HW_H98)
> +		&& check_region(LP_PORT_H98MODE, 1))
> +#endif
> +	    || check_region(LP_PORT_EXTMODE, 1)) {
> +		printk(KERN_ERR
> +		       "lp_old98: I/O ports already occupied, giving up.\n");
> +		return -EBUSY;
> +	}

check_region is obsolete, use the return value from request_region instead.

> +static long long rtc_llseek(struct file *file, loff_t offset, int origin)
> +{
> +	return -ESPIPE;
> +}

again, use no_llseek

> +EXPORT_NO_SYMBOLS;

EXPORT_NO_SYMBOLS is obsolete, don't use it in 2.5.

