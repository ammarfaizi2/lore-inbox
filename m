Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267200AbTBRKft>; Tue, 18 Feb 2003 05:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267289AbTBRKft>; Tue, 18 Feb 2003 05:35:49 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:4107 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267200AbTBRKfr>; Tue, 18 Feb 2003 05:35:47 -0500
Date: Tue, 18 Feb 2003 10:45:47 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.61 (5/26) char device
Message-ID: <20030218104547.C11969@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Osamu Tomita <tomita@cinet.co.jp>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20030217134333.GA4734@yuzuki.cinet.co.jp> <20030217135603.GE4799@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030217135603.GE4799@yuzuki.cinet.co.jp>; from tomita@cinet.co.jp on Mon, Feb 17, 2003 at 10:56:03PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +static struct lp_struct lp = {
> +	/* Following `TAG: INITIALIZER' notations are GNU CC extension. */

This comment doesn't make sense anymore :)

> +	.flags	= LP_EXIST | LP_ABORTOPEN,
> +	.chars	= LP_INIT_CHAR,
> +	.time	= LP_INIT_TIME,
> +	.wait	= LP_INIT_WAIT,
> +};
> +
> +static	int	dc1_check	= 0;
> +static spinlock_t lp_old98_lock = SPIN_LOCK_UNLOCKED;
> +
> +
> +#undef LP_OLD98_DEBUG
> +
> +#ifdef CONFIG_PC9800_OLDLP_CONSOLE
> +static struct console lp_old98_console;		/* defined later */
> +static __typeof__(lp_old98_console.flags) saved_console_flags;

Please directly use the actual type here.

> +#endif
> +
> +static DECLARE_WAIT_QUEUE_HEAD (lp_old98_waitq);
> +
> +static void lp_old98_timer_function(unsigned long data);

This prototype is superflous.

> +	__const_udelay(lp.wait * 4);

Why do you use __const_udelay instead of udelay?

> +#if LINUX_VERSION_CODE < 0x20200
> +static long lp_old98_write(struct inode * inode, struct file * file,
> +			   const char * buf, unsigned long count)
> +#else
> +static ssize_t lp_old98_write(struct file * file,
> +			      const char * buf, size_t count,
> +			      loff_t *dummy)
> +#endif    

Do you really need that compat code?  I don't think it makes much sense to
keep 2.0 code around in 2.5.

> +static int lp_old98_open(struct inode * inode, struct file * file)
> +{
> +	if (minor(inode->i_rdev) != 0)
> +		return -ENXIO;
> +
> +	if (!try_module_get(THIS_MODULE))
> +		return -EBUSY;

This is broken - the upper layer does this for you swhen you set the owner fild
of struct file_operations.

> +	module_put(THIS_MODULE);

Dito.

> +static struct file_operations lp_old98_fops = {
> +	.owner		= THIS_MODULE,

See, you already set it..

> +	.llseek		= no_llseek,
> +	.read		= NULL,

Remove this line.

> +	if (request_region(LP_PORT_DATA,   1, "lp_old98")) {
> +	    if (request_region(LP_PORT_STATUS, 1, "lp_old98")) {
> +		if (request_region(LP_PORT_STROBE, 1, "lp_old98")) {
> +		    if (request_region(LP_PORT_EXTMODE, 1, "lp_old98")) {
> +			if (register_chrdev(LP_MAJOR, "lp", &lp_old98_fops)) {

Using gotos for error handling here might make the code quite a bit more
readable :)

