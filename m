Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWAQArq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWAQArq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 19:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWAQArq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 19:47:46 -0500
Received: from hera.kernel.org ([140.211.167.34]:22742 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751284AbWAQArp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 19:47:45 -0500
Date: Mon, 16 Jan 2006 20:41:15 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Kumar Gala <galak@gate.crashing.org>
Cc: wim@iguana.be, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, iinuxppc-embedded@gate.crashing.org,
       dave@cray.org, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Add support for the MPC83xx watchdog
Message-ID: <20060116224115.GB17275@dmt.cnet>
References: <Pine.LNX.4.44.0601131618020.26648-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0601131618020.26648-100000@gate.crashing.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +static unsigned long wdt_is_open;
> +static spinlock_t wdt_spinlock;
> +
> +static void mpc83xx_wdt_keepalive(void)
> +{
> +	/* Ping the WDT */
> +	spin_lock(&wdt_spinlock);
> +	out_be16(&wd_base->swsrr, 0x556c);
> +	out_be16(&wd_base->swsrr, 0xaa39);
> +	spin_unlock(&wdt_spinlock);
> +}
> +
> +static ssize_t mpc83xx_wdt_write(struct file * file, const char __user * buf,
> +				 size_t count, loff_t * ppos)
> +{
> +	if(count)
> +		mpc83xx_wdt_keepalive();
> +	return count;
> +}
> +
> +static int mpc83xx_wdt_open(struct inode * inode, struct file * file)
> +{
> +	u32 tmp = SWCRR_SWEN;
> +	if (test_and_set_bit(0, &wdt_is_open))
> +		return -EBUSY;

Hi Kumar,

What do you need the spinlock for if the device can't be opened 
by more than one process?

