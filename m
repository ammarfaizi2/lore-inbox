Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030524AbWFVMHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030524AbWFVMHm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 08:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030620AbWFVMHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 08:07:42 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:14766 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1030524AbWFVMHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 08:07:41 -0400
Date: Thu, 22 Jun 2006 16:08:36 +0400
From: Vitaly Wool <vitalywool@gmail.com>
To: Ben Dooks <ben-linux@fluff.org>
Cc: i2c@lm-sensors.org, linux-arm-kernel@lists.arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] I2C bus driver for Philips ARM boards
Message-Id: <20060622160836.9c0640e6.vitalywool@gmail.com>
In-Reply-To: <20060622114506.GF2028@trinity.fluff.org>
References: <20060622153146.2ae56e33.vitalywool@gmail.com>
	<20060622114506.GF2028@trinity.fluff.org>
X-Mailer: Sylpheed version 2.2.1 (GTK+ 2.8.13; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 12:45:06 +0100
Ben Dooks <ben-linux@fluff.org> wrote:

> > +
> > +	pr_debug("%s: Timer armed at %lu plus %u jiffies.\n",
> > +		 __FUNCTION__, jiffies, TIMEOUT);
> how about using the dev_dbg() macros?

Okay.

> > +struct i2c_regs {
> > +	/* LSB */
> > +	union {
> > +		const u32 rx;	/* Receive FIFO Register - Read Only */
> > +		u32 tx;		/* Transmit FIFO Register - Write Only */
> > +	} fifo;
> > +	u32 sts;		/* Status Register - Read Only */
> > +	u32 ctl;		/* Control Register - Read/Write */
> > +	u32 ckl;		/* Clock divider low  - Read/Write */
> > +	u32 ckh;		/* Clock divider high - Read/Write */
> > +	u32 adr;		/* I2C address (optional) - Read/Write */
> > +	const u32 rfl;		/* Rx FIFO level (optional) - Read Only */
> > +	const u32 _unused;	/* Tx FIFO level (optional) - Read Only */
> > +	const u32 rxb;		/* Number of bytes received (opt.) - Read Only */
> > +	const u32 txb;		/* Number of bytes transmitted (opt.) - Read Only */
> > +	u32 txs;		/* Tx Slave FIFO register - Write Only */
> > +	const u32 stfl;		/* Tx Slave FIFO level - Read Only */
> > +	/* MSB */
> > +};
> 
> ARGH, using structs to represent register sets is not good
> practice, and worse, you've marked items in there const, so god
> knows wether the compiler is going to cache results in the
> cpu registers.

The structure is used as volatile throughout.
I personally didn't ever like to use structures for registers, but this is actually an old driver written first at the time ARM compilers produced more optimal code when the registers were accessed through structures.

> > +	sprintf(name, "i2c%d_ck", pdev->id);
> 
> abuse of the clock system, you should pass the device as the first
> argument, so the clk_get() implementor can differentiate between
> different device's clocks of the same name!
> 
> ie:
> 	clk_get(&pdev->dev, "i2c");

Agreed.

> > +
> > +	sprintf(name, "i2c%d_ck", pdev->id);
> > +	clk = clk_get(0, name);
> 
> why not keep the struct clk with your adapter? this seems to
> get re-used in several places, so keep the `struct clk *` since
> you've got an implicit ref-lock on it by calling clk_get() it
> isn't going anywhere!

The reason behind that is that the other target which has this bus has absolutely different clock layout so it's hard to combine those. Therefore clock stuff was pus into arch-specific part.
 
> > +	if (!IS_ERR(clk)) {
> > +		clk_set_rate(clk, 1);
> > +		clk_put(clk);
> > +	} else
> > +		retval = -ENOENT;
> > +#endif
> > +	return retval;
> > +}
> > +
> 
> These could have easily gone into the main driver, any
> reason for keeping them seperate?

Well, the reason is the same as mentioned above.

Vitaly
