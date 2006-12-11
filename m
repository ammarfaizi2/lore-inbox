Return-Path: <linux-kernel-owner+w=401wt.eu-S937650AbWLKUnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937650AbWLKUnb (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 15:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937605AbWLKUnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 15:43:31 -0500
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:29966 "HELO
	smtp101.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S937651AbWLKUna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 15:43:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=aSnpUPz5whS0626/ucHpZ9njZkxM4BVGHC62m5OT6cF0yA6PF1Cnz9mSfxuIa4+/sLINAI76z8kO/wGR7+ANWb6TWnu/CbVoL2esn4DiwtHVCRvNmcAmXGXbpjptT7WVYTWM78k/qFlsqvxwWWbVdGPn+K4JfZ42EvhpnQXu1cw=  ;
X-YMail-OSG: L3weWmEVM1mGZgFEgqaN2W5YmKXhpSf5GgbJR18ui3L94WB0bxtRsg1DVUzOvo2UeYzVyEA4KvEHfaQwCyBylc2WEun3dgUQKsk77mLFtPhAsBiLKs18HZzFhXH84tAKvkQXAtwW9IbxNtOgIFijKkC0cQmEMSvntmAM8EHJbQ617uvxdDtNskGCKOXN
From: David Brownell <david-b@pacbell.net>
To: "Voipio Riku" <Riku.Voipio@movial.fi>
Subject: Re: [patch 2.6.19-git] rts-rs5c372 updates:  more chips, alarm, 12hr mode, etc
Date: Mon, 11 Dec 2006 11:55:08 -0800
User-Agent: KMail/1.7.1
Cc: rtc-linux@googlegroups.com,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Alessandro Zummo" <alessandro.zummo@towertech.it>
References: <200612081859.42995.david-b@pacbell.net> <42002.80.222.56.248.1165818454.squirrel@webmail.movial.fi>
In-Reply-To: <42002.80.222.56.248.1165818454.squirrel@webmail.movial.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612111155.09435.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 December 2006 10:27 pm, Voipio Riku wrote:
> > Update the rtc-rs5c372 driver:
> > I suspect the
> > issue wasn't that "mode 1" didn't work on that board; the original
> > code to fetch the trim was broken.  If "mode 1" really won't work,
> > that's almost certainly a bug in that board's I2C driver.
> 
> It was not related to trim fetching. Yes, it very likely that the boards
> i2c controller (i2c-iop3xx) is has a bug, but I'm not competent enough to
> find out what it is actually sending out to the wire.

I'd expect that would be the controller _driver_ ... although it would
not surprise me to know there were also (unfixed) silicon bugs to cope
with, like version-specific differences.  One hopes errata are published
for the chip you're using, and that they don't lie.

Have you asked around for anyone who may have insights about i2c-iop3xx
driver bugs?  Maybe the driver maintainers, or arm-linux folk, or on
the i2c list.  I did notice the changelog for that driver included
changes (e.g. July 1 this year) for chip-specific differences ... there
could easily be issues like that still lingering.


> With your patch, the rtc acts like the chip would completely ignore the
> "address" transfer, and starts reading from the last (default) register
> anyway. Thus all the regs look shifted by one in the driver.

That's quite strange.  The docs on the RTC are quite clear about what's
supposed to happen with what I2C messages.  And I'd expect them to be
right ... especially since they behaved for me, and the original author
of that code!  That makes me suspect that your particular I2C controller
driver must not be issuing the protocol requests it should be, at least
on your hardware and revision.


> > +	/* this implements the first (most portable) reading method
> > +	 * specified in the datasheet.
> >  	 */
> 
> Why is this method considered more portable? Howabout making the read
> method a module parameter?

Of the three methods, #2 depends on messages that not all I2C masters
are necessarily going to be able to issue, and #3 assumes that there's
no other I2C master accessing that chip.

Plus, if I understand things correctly, using mode #3 would break when
writing e.g. just REG_CTRL1 to enable alarms or force an uninitialized
chip into 24 hr mode ... or when writing the alarm.  Because, just as
with the multi-master case, the implicit register pointer would no
longer stay at "15" all the time.  So I don't see how having an option
to choose the mode would be a good solution.

- Dave


