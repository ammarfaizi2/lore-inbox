Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267160AbTAKINl>; Sat, 11 Jan 2003 03:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267162AbTAKINl>; Sat, 11 Jan 2003 03:13:41 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:23314 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267160AbTAKINi>; Sat, 11 Jan 2003 03:13:38 -0500
Date: Sat, 11 Jan 2003 08:22:23 +0000
From: Christoph Hellwig <hch@infradead.org>
To: GertJan Spoelman <kl@gjs.cc>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] i2c-isa and w83871d sensors support
Message-ID: <20030111082222.A20116@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	GertJan Spoelman <kl@gjs.cc>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200212280303.gBS33o628113@hera.kernel.org> <1041076002.1485.2.camel@laptop.fenrus.com> <20021228123655.A31843@infradead.org> <200301051844.55795.kl@gjs.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301051844.55795.kl@gjs.cc>; from kl@gjs.cc on Sun, Jan 05, 2003 at 06:44:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 05, 2003 at 06:44:55PM +0100, GertJan Spoelman wrote:
> This patch adds the i2c-isa pseudo ISA adapter and the w8387* series
> sensors support to 2.5.54 (tested on bk1 and bk3).
> 
> I've just took the code from the lm_sensor package and changed it
> to be more or less consistent with the lm75 and amd* patches Christoph
> has done.
> Christoph, maybe you could check this because I don't really understand
> all of the code and maybe it needs some more changes.

Looks fine in principle.  A few nitpicks:

> +static struct i2c_algorithm isa_algorithm = {
> +	.name		= "ISA bus algorithm",
> +	.id		= I2C_ALGO_ISA,
> +	.smbus_xfer	= NULL,
> +	.functionality	= &isa_func,
> +};

There's no need to initialize a struct member to zero/NULL.

> +static int __init isa_init(void)
> +{
> +	int res;
> +	if (isa_initialized) {
> +		pr_debug(DRV_NAME
> +		    ": i2c-isa.o: Oops, isa_init called a second time!\n");
> +		return -EBUSY;
> +	}
> +	isa_initialized = 0;
> +	if ((res = i2c_add_adapter(&isa_adapter))) {
> +		printk(KERN_ERR DRV_NAME
> +		       ": Adapter registration failed, module not inserted\n.");
> +		isa_cleanup();
> +		return res;
> +	}
> +	isa_initialized++;
> +	printk("i2c-isa.o: ISA bus access for i2c modules initialized.\n");
> +	return 0;

Please remove the <foo>_initialized handling.  It just obsfucates the code.

> +static void __exit isa_exit(void)
> +{
> +	isa_cleanup();
> +}

Just move the code from isa_cleanup into isa_exit directly.

