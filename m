Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262614AbVDGV3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262614AbVDGV3z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 17:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262612AbVDGV3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 17:29:34 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:45839 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262610AbVDGV2j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 17:28:39 -0400
Date: Thu, 7 Apr 2005 23:29:08 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>,
       James Chapman <jchapman@katalix.com>
Subject: Re: [PATCH] i2c: new driver for ds1337 RTC
Message-Id: <20050407232908.418d8878.khali@linux-fr.org>
In-Reply-To: <20050407142804.GA11284@orphique>
References: <20050407111631.GA21190@orphique>
	<hOrXV5wl.1112879260.3338120.khali@localhost>
	<20050407142804.GA11284@orphique>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ladislav,

> Here is yet another patch this time fixes only.
> CHANGELOG:
> * use i2_tranfer function instead of adapter->algo->master_xfer, so
>   we have proper bus locking.

You are absolutely right. My mistake, I should have noticed when first
reviewing the code, as calling master_xfer directly is unseen - for a
reason.

> * BCD2BIN and BIN2BCD are proper macros to use here, see linux/bcd.h

Looks correct to me as well.

> * Move NULL argument checking from get/set date functions to
>   ds1337_command function, so it is only at one place. Note that other
>   drivers do not this checking at all and I think it is pointess,
>   because you have to know that you are passing struct rtc_time
>   anyway.

I am not certain these are the right things to do (moving the check or
removing it). I am not a specialist of ioctl, but it looks to me that
ds1337_command acts as a dispatcher, branching to various functions
depending on the value of cmd. I can imagine that some functions take an
argument, and some don't, so checking for NULL pointer in the dispatcher
doesn't make much sense. Now it is correct that for now all (two)
functions need a parameter, but what if later a function is added, which
takes no parameter? You'd have to undo your change and move the check in
each function again.

As for the check itself, the pointer somehow comes from user-space as I
understand it, so you can't tell whether it's NULL or not - so checking
makes full sense to me. If you take a look at the rtc8564 driver you'll
see it *does* check for NULL pointers too.

> * dev_dbg should probably print info about device driver we are
>   debugging so client->dev looks as better choice than
>   client->adapter->dev.

You're correct.

My comments to the code itself follows.

> @@ -95,60 +96,38 @@
>   */
>  static int ds1337_get_datetime(struct i2c_client *client, struct
>  rtc_time *dt) {
> -	struct ds1337_data *data = i2c_get_clientdata(client);
> -	int result;
> -	u8 buf[7];
> -	u8 val;
> -	struct i2c_msg msg[2];
> -	u8 offs = 0;
> -
> -	if (!dt) {
> -		dev_dbg(&client->adapter->dev, "%s: EINVAL: dt=NULL\n",
> -			__FUNCTION__);
> -
> -		return -EINVAL;
> -	}
> -
> -	msg[0].addr = client->addr;
> -	msg[0].flags = 0;
> -	msg[0].len = 1;
> -	msg[0].buf = &offs;
> -
> -	msg[1].addr = client->addr;
> -	msg[1].flags = I2C_M_RD;
> -	msg[1].len = sizeof(buf);
> -	msg[1].buf = &buf[0];
> +	unsigned char buf[7] = { 0, }, addr[1] = { 0 };
> +	struct i2c_msg msgs[2] = {
> +		{ client->addr, 0,        1, addr },
> +		{ client->addr, I2C_M_RD, 7, buf  }
> +	};
> +	int result = i2c_transfer(client->adapter, msgs, 2);
>  
> -	result = client->adapter->algo->master_xfer(client->adapter,
> -						    &msg[0], 2);

You are doing much more than just using i2c_transfer instead of
master_xfer. You are also rewriting the way the message data is
initialized. I see no reason to do that, as the previous code was
correct as far as I can see.

> -	dev_dbg(&client->adapter->dev,
> +	dev_dbg(&client->dev,

Yes, that's correct.

> -	if (result >= 0) {
(...)
> +	if (result < 0) {

By changing this you are making your patch much bigger and harder to
review. Why do you do that?

> -		val = buf[2] & 0x3f;
> -		dt->tm_hour = BCD_TO_BIN(val);
(...)
> +		dt->tm_hour = BCD2BIN(buf[2] & 0x3f);

No, James is correct. BCD2BIN (or BCD_TO_BIN for that matter) is a
macro which evaluates its argument more than once. Using a temporary
variable makes sense.

> -		val = buf[5] & 0x7f;
> -		dt->tm_mon = BCD_TO_BIN(val);
(...)
> +		dt->tm_mon  = BCD2BIN(buf[5] & 0x7f) - 1;

Looks to me like you are silently changing the code here. Was there a
bug? If so, please tell so.

> +	unsigned char buf[8];
>  	int result;
> -	u8 buf[8];

Wow, what a useful change. Please please please... Focus on making your
patch compact, have it do just the thing it is supposed (and advertised)
to do. You know, I'll repeat it until you get it. No matter how many
tries it takes.

>  	if (dt->tm_year >= 2000) {
> -		val = dt->tm_year - 2000;
>  		buf[6] |= (1 << 7);
> -	} else {
> -		val = dt->tm_year - 1900;
> -	}
> -	buf[7] = BIN_TO_BCD(val);
> +		buf[7] = BIN2BCD(dt->tm_year - 2000);
> +	} else
> +		buf[7] = BIN2BCD(dt->tm_year - 1900);

Same as before, the use of a temporary variable makes full sense, don't
change that. And you're again adding noise by dropping a pair of curly
braces.

> -	} else {
> +	} else
>  		result = 0;
> -	}

And that's noise again.

Please resubmit your patch without all the noise. Don't change things
just because you like them the other way. Fix things which are broken,
and only these.

Thanks,
-- 
Jean Delvare
