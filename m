Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268298AbUIWHKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268298AbUIWHKa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 03:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268301AbUIWHKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 03:10:30 -0400
Received: from mail.convergence.de ([212.227.36.84]:14243 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S268298AbUIWHKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 03:10:17 -0400
Message-ID: <41527696.5060002@linuxtv.org>
Date: Thu, 23 Sep 2004 09:09:10 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Cox <adrian@humboldt.co.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sensors@Stimpy.netroedge.com, Jon Smirl <jonsmirl@gmail.com>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH][2.6] Add command function to struct i2c_adapter
References: <414F111C.9030809@linuxtv.org>	 <20040921154111.GA13028@kroah.com>	 <41506099.8000307@web.de>	 <41506D78.6030106@web.de> <1095843365.18365.48.camel@localhost>	 <20040922102938.M15856@linux-fr.org> <1095854048.18365.75.camel@localhost>
In-Reply-To: <1095854048.18365.75.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22.09.2004 13:54, Adrian Cox wrote:
> Not in the current Linux DVB code. A frontend driver registers itself
> onto a list, and whenever a DVB card registers its I2C adapter the
> available frontends are probed. My solution would throw away all the
> list handling in dvb_i2c.c entirely.

Kernels including 2.6.9-rc2-mm1 have the proprietary dvb_i2c 
implementation inside, ie. no kernel i2c at all. I have recently sent a 
patch to Andrew that converts all dvb drivers and frontends to fully use 
kernel i2c. The current discussion is completely about the 
not-yet-officially-released dvb subsystem using kernel-i2c.

>>All in all I don't see how we can solve the problem without either a "do not
>>probe" flag in the adapter structure or a class bitfield in both the adapter
>>and the client structures. I would be fine with either option unless someone
>>explains how one is better than the other in any particular case.

> What I want is a way for a card driver to create a private I2C adapter,
> and private instances of I2C clients, for purposes of code reuse. The
> card driver would be responsible for attaching those clients to the bus
> and cleaning up the objects on removal. The bus wouldn't be visible in
> sysfs, or accessible from user-mode.

We're having a similar discussion on the linux-dvb mailing list and I 
have made a similar suggestion. There shouldn't be such a thing as a 
generic i2c bus at all - at least not for specific PCI or AGP cards 
having an i2c bus, because you really now what's there.

The adapters should be able to create a specific i2c bus. This bus then 
should have a well-defined client<->adapter interface. The adapter 
provides an interface clients can use for example to query h/w dependent 
informations, like "Is it possible to have chipset XY on your bus?". For 
DVB this question can be answered using pci subvendor/subdevice 
informations. This avoids the need to add a command() function to struct 
i2c_adapter.

If the adapter wants a client to join the bus and the client is really 
found, then the client must provide a well-defined set of functions as 
well. The adapter can then control the device in a type-safe manner and 
doesn't have to control it using the current ioctl interface.

> - Adrian Cox
> Humboldt Solutions Ltd.

We need to keep in mind, that the adapter interface must be a per-client 
interface. On PCI devices it's simple: you have a i2c bus bound to a dvb 
card and know which chipsets can be there. The bus is dvb specific.

On embedded platforms, however, you usually have one one i2c bus, where 
everything is present: dvb frontends, audio/video multiplexers, 
digital/analog audio converters, stuff like that.

So if you create *the* i2c bus and invite i2c client to participate at 
the party, you need to provide different interfaces to the different 
chipsets.

CU
Michael.
