Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWGDAWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWGDAWb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 20:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWGDAWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 20:22:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30422 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751331AbWGDAWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 20:22:30 -0400
Date: Mon, 3 Jul 2006 17:22:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Straub, Michael" <Michael.Straub@avocent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 9/13] Equinox SST driver: tty interface
Message-Id: <20060703172227.4f38f82d.akpm@osdl.org>
In-Reply-To: <4821D5B6CD3C1B4880E6E94C6E70913E01B7110E@sun-email.corp.avocent.com>
References: <4821D5B6CD3C1B4880E6E94C6E70913E01B7110E@sun-email.corp.avocent.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 09:20:28 -0400
"Straub, Michael" <Michael.Straub@avocent.com> wrote:

> Adds Equinox multi-port serial (SST) driver.
> 
> Part 9: new source file: drivers/char/eqnx/sst_tty.c.  Provides the
> standard
> TTY interface routines for the SST driver.
> 
> ...
>
> +/* defer call to write_wakeup */
> +int eqnx_write_wakeup_deferred = 0;

Please don't initilise static storage to zero - the C runtime environment
does that.  <entire patchset>

> +#define	MY_GROUP()	(process_group(current))

Remove this, open-code it at the callsite.

> +extern int SSTMINOR(unsigned int, unsigned int);
> +/**********************************************************************
> *****/
> +/* external variable and routines
> */
> +/**********************************************************************
> *****/
> +
> +extern int eqnx_nssps;
> +extern struct mpdev eqnx_dev[MAXSSP];
> +extern struct mpchan *eqnx_chan;
> +extern struct datascope eqnx_dscope[2];
> +extern char *eqnx_tmpwritebuf;
> +extern struct semaphore eqnx_tmpwritesem;
> +
> +extern void eqnx_megaparam(int);
> +extern int eqnx_modem(int, int);
> +extern void eqnx_frame_wait(struct mpchan *, int);
> +extern void eqnx_chnl_sync(struct mpchan *);
> +extern int SSTMINOR(unsigned int, unsigned int);
> +extern u32 eqnx_get_modem_info(struct mpchan *);
> +extern void eqnx_set_modem_info(struct mpchan *, unsigned int, unsigned
> int,
> +				struct tty_struct *);

In all patches, move all extern declarations to header files which are
shared by both the declaration site and by all users.

> +
> +		return (-ENODEV);

I'd second previous comments wrt overparenthesization.

> +	mpc->refcount++;

WHat's the locking for this field?

> +			mpc->openwaitcnt++;

Ditto.

> +		if (!page)
> +			return (-ENOMEM);

Please try to make all non-trivial functions have a single `return'
statement.  This driver like to sprinkle returns all over the place, and
that's an invitation to missed unlocks, resource leaks and duplicated
error-recovery code.  We use gotos for this.

> +	mpc->pgrp = MY_GROUP();

Why does this driver need to know about process groups?

> +void eqnx_close(struct tty_struct *tty, struct file *filp)
> +{
> +	struct mpchan *mpc;
> +	struct mpdev *mpd;
> +	int nchan, d;
> +	unsigned long flags;
> +	u16 attn;
> +
> +	/* channel validity checks */
> +	if (tty == (struct tty_struct *)NULL)
> +		return;
> +	mpc = (struct mpchan *)tty->driver_data;
> +	if (mpc == (struct mpchan *)NULL)
> +		return;

Please review the whole driver for unneeded typecasts of void*, remove them.

> +		(unsigned int)SSTMINOR(mpc->mpc_major, mpc->mpc_minor),
> count);

Remove SSTMINOR, open-code it.

> +/*
> + * delay_jiffies(len)
> + *
> + * Delay by the specified number of jiffies.
> + *
> + * len	= jiffies to delay.
> + */
> +static void delay_jiffies(int len)
> +{
> +	if (len > 0) {
> +		msleep(jiffies_to_msecs(len));
> +	}
> +}

It's unusual for a driver to want to sleep for a number of jiffies. 
Because HZ jiffies can vary by an order of magnitude.  msleep() is a better
interface to use.

This function is an obfuscated version of schedule_timeout_uninterruptible().

