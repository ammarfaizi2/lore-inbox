Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbVACV14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbVACV14 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 16:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVACVML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 16:12:11 -0500
Received: from gateway.penguincomputing.com ([64.243.132.186]:43987 "EHLO
	inside.penguincomputing.com") by vger.kernel.org with ESMTP
	id S261867AbVACVLQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 16:11:16 -0500
X-Mda: Mail::Internet Mail::Sendmail Sendmail +mmhack 1.1 on Linux
User-Agent: Mutt/1.4.1i
Subject: Re: Ticket #1851 - PATCH (take 2) for adm1026.c, kernel 2.6.10-bk6
In-Reply-To: <20050103205231.GK9923@schnapps.adilger.int>
Content-Disposition: inline
Date: Mon, 3 Jan 2005 14:12:49 -0800
Message-Id: <20050103221249.GB12765@penguincomputing.com>
References: <41D5D075.4000200@paradyne.com>
 <20050101001205.6b2a44d3.khali@linux-fr.org>
 <20050103194355.GA11979@penguincomputing.com>
 <20050103201056.3c55e330.khali@linux-fr.org>
 <20050103213707.GA12765@penguincomputing.com>
 <20050103205231.GK9923@schnapps.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Content-Transfer-Encoding: 8BIT
From: Justin Thiessen <jthiessen@penguincomputing.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 01:52:31PM -0700, Andreas Dilger wrote:
> On Jan 03, 2005  13:37 -0800, Justin Thiessen wrote:
> > The amount of duplicated code is only a few lines, and I think the result is
> > clearer if it is not extracted into a separate function.  See the following
> > patch.
> 
> > +	value = adm1026_read_value(client, ADM1026_REG_FAN_DIV_0_3)
> > +		| (adm1026_read_value(client, ADM1026_REG_FAN_DIV_4_7)
> > +		<< 8);
> 
> The formatting of this makes it hard to follow the logic.  The "<< 8"
> operation isn't aligned with the nesting parenthesis and at first I
> thought there was an ambiguous order of operation "|" vs "<<".
> 
> How about the following:
> 
> --- linux-2.6.10/drivers/i2c/chips/adm1026.c.orig	2005-01-02 15:21:58.000000000 -0800
> +++ linux-2.6.10/drivers/i2c/chips/adm1026.c	2005-01-02 18:27:40.695689832 -0800
> @@ -452,6 +452,14 @@ void adm1026_init_client(struct i2c_clie
>  		client->id, value);
>  	data->config1 = value;
>  	adm1026_write_value(client, ADM1026_REG_CONFIG1, value);
> +
> +	/* initialize fan_div[] to hardware defaults */
> +	value = adm1026_read_value(client, ADM1026_REG_FAN_DIV_0_3) |
> +		(adm1026_read_value(client, ADM1026_REG_FAN_DIV_4_7) << 8);
> +	for (i = 0;i <= 7;++i) {
> +		data->fan_div[i] = DIV_FROM_REG(value & 0x03);
> +		value >>= 2;
> +	}
>  }
>  
>  void adm1026_print_gpio(struct i2c_client *client)


I'm fine with shifting the CRs around if it makes everyone happier.  I was
lazy when I cut and pasted the snippet of code and did nothing other than
change the number of tabs to match the surrounding code. This, of course, 
is what actually made the reformatting you did possible.  I've read these and 
similar lines so many times I'm not sure if I'd notice whether or not they
were hard or easy to parse.  Feedback is GOOD.

> Also, on a completely "I don't know what the hell I'm talking about" point,
> it seems odd that for values named "0_3" and "4_7" you would upshift the
> "4_7" value 8 bits instead of 4, but it could be just a bad choice of
> variable names.

It's a variable nomenclature that I inherited from the 2.4.X kernel series
driver.  If you look a bit closer the code will make sense.  Remember this:

(1) There are 8 fan divisors stored in 2 byte-size registers.
(2) Each fan divisor is represented by 2 bits.

And the result should be clear.

Justin Thiessen
---------------
jthiessen@penguincomputing.com

