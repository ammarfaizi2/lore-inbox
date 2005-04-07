Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262564AbVDGXRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbVDGXRG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 19:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbVDGXRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 19:17:05 -0400
Received: from smtp.seznam.cz ([212.80.76.43]:25001 "HELO smtp.seznam.cz")
	by vger.kernel.org with SMTP id S262564AbVDGXQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 19:16:50 -0400
Date: Fri, 8 Apr 2005 01:16:50 +0200
To: Jean Delvare <khali@linux-fr.org>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>,
       James Chapman <jchapman@katalix.com>
Subject: Re: [PATCH] i2c: new driver for ds1337 RTC
Message-ID: <20050407231650.GA27226@orphique>
References: <20050407111631.GA21190@orphique> <hOrXV5wl.1112879260.3338120.khali@localhost> <20050407142804.GA11284@orphique> <20050407232908.418d8878.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050407232908.418d8878.khali@linux-fr.org>
User-Agent: Mutt/1.5.6+20040907i
From: Ladislav Michl <ladis@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean,

I'll comment your mail first and then send separate patches (somehow
I can't sleep this night :))

On Thu, Apr 07, 2005 at 11:29:08PM +0200, Jean Delvare wrote:
> > * Move NULL argument checking from get/set date functions to
> >   ds1337_command function, so it is only at one place. Note that other
> >   drivers do not this checking at all and I think it is pointess,
> >   because you have to know that you are passing struct rtc_time
> >   anyway.
> 
> I am not certain these are the right things to do (moving the check or
> removing it). I am not a specialist of ioctl, but it looks to me that
> ds1337_command acts as a dispatcher, branching to various functions
> depending on the value of cmd. I can imagine that some functions take an
> argument, and some don't, so checking for NULL pointer in the dispatcher
> doesn't make much sense. Now it is correct that for now all (two)
> functions need a parameter, but what if later a function is added, which
> takes no parameter? You'd have to undo your change and move the check in
> each function again.
> 
> As for the check itself, the pointer somehow comes from user-space as I
> understand it, so you can't tell whether it's NULL or not - so checking
> makes full sense to me. If you take a look at the rtc8564 driver you'll
> see it *does* check for NULL pointers too.

You can't tell if memory it points to is valid. Okay, probably better
than nothing.

> > @@ -95,60 +96,38 @@
> >   */
> >  static int ds1337_get_datetime(struct i2c_client *client, struct
> >  rtc_time *dt) {
> > -	struct ds1337_data *data = i2c_get_clientdata(client);
> > -	int result;
> > -	u8 buf[7];
> > -	u8 val;
> > -	struct i2c_msg msg[2];
> > -	u8 offs = 0;
> > -
> > -	if (!dt) {
> > -		dev_dbg(&client->adapter->dev, "%s: EINVAL: dt=NULL\n",
> > -			__FUNCTION__);
> > -
> > -		return -EINVAL;
> > -	}
> > -
> > -	msg[0].addr = client->addr;
> > -	msg[0].flags = 0;
> > -	msg[0].len = 1;
> > -	msg[0].buf = &offs;
> > -
> > -	msg[1].addr = client->addr;
> > -	msg[1].flags = I2C_M_RD;
> > -	msg[1].len = sizeof(buf);
> > -	msg[1].buf = &buf[0];
> > +	unsigned char buf[7] = { 0, }, addr[1] = { 0 };
> > +	struct i2c_msg msgs[2] = {
> > +		{ client->addr, 0,        1, addr },
> > +		{ client->addr, I2C_M_RD, 7, buf  }
> > +	};
> > +	int result = i2c_transfer(client->adapter, msgs, 2);
> >  
> > -	result = client->adapter->algo->master_xfer(client->adapter,
> > -						    &msg[0], 2);
> 
> You are doing much more than just using i2c_transfer instead of
> master_xfer. You are also rewriting the way the message data is
> initialized. I see no reason to do that, as the previous code was
> correct as far as I can see.

Right, I just made it shorter. One more point for you, my way is not
struct i2c_msg change proof. I'll drop it.

> > -	if (result >= 0) {
> (...)
> > +	if (result < 0) {
> 
> By changing this you are making your patch much bigger and harder to
> review. Why do you do that?

Here you need to look at patched code. Now conditions in both
ds1337_get_datetime and ds1337_set_datetime look similar, so code is
IHMO easily readable. I'm fine with droping this change.

> > -		val = buf[2] & 0x3f;
> > -		dt->tm_hour = BCD_TO_BIN(val);
> (...)
> > +		dt->tm_hour = BCD2BIN(buf[2] & 0x3f);
> 
> No, James is correct. BCD2BIN (or BCD_TO_BIN for that matter) is a
> macro which evaluates its argument more than once. Using a temporary
> variable makes sense.

Agree.

> > +	unsigned char buf[8];
> >  	int result;
> > -	u8 buf[8];
> 
> Wow, what a useful change. Please please please... Focus on making your
> patch compact, have it do just the thing it is supposed (and advertised)
> to do. You know, I'll repeat it until you get it. No matter how many
> tries it takes.

Save your time I got it. buf is supposed to be char, that's what function
expects. I wrongly made it unsigned. u8, u16 etc. are used in case
when you for example need to generate say 8 bit bus access or need same 
width on all architectures. Neither is case here and using u8 makes no
sense. Anyway, will drop change. 

> >  	if (dt->tm_year >= 2000) {
> > -		val = dt->tm_year - 2000;
> >  		buf[6] |= (1 << 7);
> > -	} else {
> > -		val = dt->tm_year - 1900;
> > -	}
> > -	buf[7] = BIN_TO_BCD(val);
> > +		buf[7] = BIN2BCD(dt->tm_year - 2000);
> > +	} else
> > +		buf[7] = BIN2BCD(dt->tm_year - 1900);
> 
> Same as before, the use of a temporary variable makes full sense, don't
> change that. And you're again adding noise by dropping a pair of curly
> braces.

That's only because I read mail by jgarzik suggesting to remove such
braces few hours ago :) Also, i'll drop this change.

Best regards,
	ladis
