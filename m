Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264881AbUIVLzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUIVLzd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 07:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbUIVLzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 07:55:32 -0400
Received: from mail.humboldt.co.uk ([81.2.65.18]:20399 "EHLO
	mail.humboldt.co.uk") by vger.kernel.org with ESMTP id S264917AbUIVLyK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 07:54:10 -0400
Subject: Re: [PATCH][2.6] Add command function to struct i2c_adapter
From: Adrian Cox <adrian@humboldt.co.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sensors@Stimpy.netroedge.com
Cc: Michael Hunold <hunold-ml@web.de>, Jon Smirl <jonsmirl@gmail.com>,
       Greg KH <greg@kroah.com>
In-Reply-To: <20040922102938.M15856@linux-fr.org>
References: <414F111C.9030809@linuxtv.org>
	 <20040921154111.GA13028@kroah.com>	 <41506099.8000307@web.de>
	 <41506D78.6030106@web.de> <1095843365.18365.48.camel@localhost>
	 <20040922102938.M15856@linux-fr.org>
Content-Type: text/plain
Message-Id: <1095854048.18365.75.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 22 Sep 2004 12:54:08 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-22 at 13:08, Jean Delvare wrote:
> On Wed, 22 Sep 2004 09:56:06 +0100, Adrian Cox wrote

> > These .class entries are workarounds that shouldn't be required. For 
> > DVB cards, TV capture cards, monitor detection, and embedded systems 
> > the required behaviour is normally known in advance. Why should the top
> > level driver have to use these workarounds to steer the result of
> > probing when it already has all the information?
> 
> Well, I don't quite follow you here. On the one hand you agree that sensors
> and video/embedded stuff should be handled differently, but then you don't
> want us to tag them according to their function in order to actually behave
> differently.

I don't want them tagged because I don't want them to ever appear on a
system-wide list. They're an internal detail of a particular card, and
don't even need to be in sysfs. The only reason to have any shared I2C
code at all for these cards is to avoid duplicating the implementation
of bit-banging.

> > 2) In the pci probe function of the DVB or capture card, do a 
> > sequence like this: my_dev_priv->i2c_adapter = 
> > i2c_adapter_create(...); my_dev_priv->tea6415 = 
> > tea6415_create(my_dev_priv->i2c_adapter,                             
> >          &my_tea6415_parameters); my_dev_priv->saa7111 = 
> > saa7111_create(my_dev_priv->i2c_adapter);
> > 
> > 3) Then to use the i2c client:
> > tea6415_switch(my_dev_priv->tea6415, &vm);
> 
> As far as I know, this is exactly what video folks already do. The whole issue
> is not with video folks probing adapters, but with them not wanting us (the
> sensors clients) to arbitrarily probe their video i2c busses in search of
> hardware monitoring chips. Michael's proposal is meant to give us a way not to
> do this anymore.

Not in the current Linux DVB code. A frontend driver registers itself
onto a list, and whenever a DVB card registers its I2C adapter the
available frontends are probed. My solution would throw away all the
list handling in dvb_i2c.c entirely.

> All in all I don't see how we can solve the problem without either a "do not
> probe" flag in the adapter structure or a class bitfield in both the adapter
> and the client structures. I would be fine with either option unless someone
> explains how one is better than the other in any particular case.

What I want is a way for a card driver to create a private I2C adapter,
and private instances of I2C clients, for purposes of code reuse. The
card driver would be responsible for attaching those clients to the bus
and cleaning up the objects on removal. The bus wouldn't be visible in
sysfs, or accessible from user-mode.

Some USB webcams have internal I2C busses to connect the sensor to the
USB chip. The drivers for these ignore the I2C core completely, and
invent their own system for reading and writing the sensor registers.
Maybe that's actually the best way of dealing with this.

- Adrian Cox
Humboldt Solutions Ltd.


