Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWDCSAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWDCSAw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 14:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWDCSAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 14:00:52 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:33562 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S964823AbWDCSAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 14:00:51 -0400
Date: Mon, 3 Apr 2006 11:01:43 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: "Mark A. Greer" <mgreer@mvista.com>, Andrew Morton <akpm@osdl.org>,
       lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-mm1 3/3] rtc: add support for m41t81 & m41t85 chips to m41t00 driver
Message-ID: <20060403180142.GB10779@mag.az.mvista.com>
References: <20060323210856.f1bfd02b.khali@linux-fr.org> <20060323203843.GA18912@mag.az.mvista.com> <20060324012406.GE9560@mag.az.mvista.com> <20060326145840.5e578fa4.akpm@osdl.org> <20060328002625.GE21077@mag.az.mvista.com> <20060328175450.f207effa.khali@linux-fr.org> <20060328181111.GB14170@mag.az.mvista.com> <20060328203008.5910ead6.khali@linux-fr.org> <20060328231201.GA7907@mag.az.mvista.com> <20060401192040.90015055.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060401192040.90015055.khali@linux-fr.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On Sat, Apr 01, 2006 at 07:20:40PM +0200, Jean Delvare wrote:

<snip>

> > I either need to have a bunch of returns in that routine (frowned
> > upon) or I have to get rid of the dev_err msgs which I think are
> > useful.  If you have a better way, let me know.
> 
> No immediate idea and I don't quite have the time to work on it. If
> anyone is unhappy with it, that person gets to suggest a better way ;)

Works for me!

> > Other than that, I think I have addressed all of your concerns.
> > Sorry for all of the iterations.
> 
> No worry about the iterations, good patches go that path, methinks. And
> I take my part of responsability for the slow processing.
> 
> I'm fine with almost everything now, except for a couple things below,
> which I'll change myself if you're OK with my suggestions, before
> pushing the patch upwards:
> 
> >  m41t00_probe(struct i2c_adapter *adap, int addr, int kind)
> >  {
> >  	struct i2c_client *client;
> > -	int rc;
> > +	int rc = -EINVAL;
> >  
> > -	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
> > -	if (!client)
> > -		return -ENOMEM;
> > +	if (!i2c_check_functionality(adap, I2C_FUNC_I2C
> > +			| I2C_FUNC_SMBUS_BYTE_DATA))
> > +		goto early_err;
> 
> Good check, but bad return value, given the way the i2c subsystem works
> for now. There is no error at this point, your i2c driver is simply not
> compatible with one of the i2c busses which exist on the system. You
> must return 0 (no error.)
> 
> > +
> > +	if (!(client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
> > +		rc = -ENOMEM;
> > +		goto early_err;
> > +	}
> 
> And this change doesn't really win anything compared to the original
> code. So I'd suggest:
> 
> @@ -170,23 +286,72 @@
>  	struct i2c_client *client;
>  	int rc;
>  
> +	if (!i2c_check_functionality(adap, I2C_FUNC_I2C
> +			| I2C_FUNC_SMBUS_BYTE_DATA))
> +		return 0;
> +
>  	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
>  	if (!client)
>  		return -ENOMEM;
> 
> This minimizes the changes while doing the right thing.

I'm happy with that.

> > --- linux-2.6.16-mm1-cleanup/include/linux/m41t00.h	1969-12-31 17:00:00.000000000 -0700
> > +++ linux-2.6.16-mm1-newsupp/include/linux/m41t00.h	2006-03-28 14:36:56.000000000 -0700
> > @@ -0,0 +1,50 @@
> > +/*
> > + * Definitions for the ST M41T00 family of i2c rtc chips.
> > + *
> > + * Author: Mark A. Greer <mgreer@mvista.com>
> > + *
> > + * 2005 (c) MontaVista Software, Inc. This file is licensed under
> 
> Still no 2006? You added it to the driver file so I guess you want to
> do the same here.

Oops, missed that one.  My bad.

> > +/* SQW output disabled, this is default value by power on*/
> > +#define SQW_FREQ_DISABLE	(0)
> > +
> > +#define SQW_FREQ_32KHZ	(1<<4)		/* 32.768 KHz */
> > +#define SQW_FREQ_8KHZ	(2<<4)		/* 8.192 KHz */
> > +#define SQW_FREQ_4KHZ	(3<<4)		/* 4.096 KHz */
> > +#define SQW_FREQ_2KHZ	(4<<4)		/* 2.048 KHz */
> > +#define SQW_FREQ_1KHZ	(5<<4)		/* 1.024 KHz */
> > +#define SQW_FREQ_512HZ	(6<<4)		/* 512 Hz */
> > +#define SQW_FREQ_256HZ	(7<<4)		/* 256 Hz */
> > +#define SQW_FREQ_128HZ	(8<<4)		/* 128 Hz */
> > +#define SQW_FREQ_64HZ	(9<<4)		/* 64 Hz */
> > +#define SQW_FREQ_32HZ	(10<<4)		/* 32 Hz */
> > +#define SQW_FREQ_16HZ	(11<<4)		/* 16 Hz */
> > +#define SQW_FREQ_8HZ	(12<<4)		/* 8 Hz */
> > +#define SQW_FREQ_4HZ	(13<<4)		/* 4 Hz */
> > +#define SQW_FREQ_2HZ	(14<<4)		/* 2 Hz */
> > +#define SQW_FREQ_1HZ	(15<<4)		/* 1 Hz */
> 
> It just hit me that, given that these defines are in a header file,
> they should have a M41T00_ prefix. Don't you think?

I agree. 

> If so, in order not
> to make the symbol names too long, we can probably remove the FREQ
> part, which doesn't really add anything. So I'd go with:
> 
> +/* SQW output disabled, this is default value by power on */
> +#define M41T00_SQW_DISABLE     (0)
> +
> +#define M41T00_SQW_32KHZ       (1<<4)          /* 32.768 KHz */
> +#define M41T00_SQW_8KHZ                (2<<4)          /* 8.192 KHz */
> +#define M41T00_SQW_4KHZ                (3<<4)          /* 4.096 KHz */
> +#define M41T00_SQW_2KHZ                (4<<4)          /* 2.048 KHz */
> +#define M41T00_SQW_1KHZ                (5<<4)          /* 1.024 KHz */
> +#define M41T00_SQW_512HZ       (6<<4)          /* 512 Hz */
> +#define M41T00_SQW_256HZ       (7<<4)          /* 256 Hz */
> +#define M41T00_SQW_128HZ       (8<<4)          /* 128 Hz */
> +#define M41T00_SQW_64HZ                (9<<4)          /* 64 Hz */
> +#define M41T00_SQW_32HZ                (10<<4)         /* 32 Hz */
> +#define M41T00_SQW_16HZ                (11<<4)         /* 16 Hz */
> +#define M41T00_SQW_8HZ         (12<<4)         /* 8 Hz */
> +#define M41T00_SQW_4HZ         (13<<4)         /* 4 Hz */
> +#define M41T00_SQW_2HZ         (14<<4)         /* 2 Hz */
> +#define M41T00_SQW_1HZ         (15<<4)         /* 1 Hz */
> 
> That's it. If you're OK with my changes, just tell so and we go with my
> version. If anything isn't OK, no problem, but then you get to resend a
> full patch with everything the way you want.

I'm happy with all your changes.  Thanks again for you time, Jean.

Mark
