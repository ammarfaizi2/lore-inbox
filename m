Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268305AbUIWHlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268305AbUIWHlr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 03:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268306AbUIWHlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 03:41:47 -0400
Received: from smtp06.web.de ([217.72.192.224]:55744 "EHLO smtp06.web.de")
	by vger.kernel.org with ESMTP id S268305AbUIWHlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 03:41:44 -0400
Message-ID: <41527E1B.4040605@web.de>
Date: Thu, 23 Sep 2004 09:41:15 +0200
From: Michael Hunold <hunold-ml@web.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Cox <adrian@humboldt.co.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sensors@Stimpy.netroedge.com, Jon Smirl <jonsmirl@gmail.com>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH][2.6] Add command function to struct i2c_adapter
References: <414F111C.9030809@linuxtv.org>	 <20040921154111.GA13028@kroah.com>	 <41506099.8000307@web.de>	 <41506D78.6030106@web.de> <1095843365.18365.48.camel@localhost>	 <20040922102938.M15856@linux-fr.org> <1095854048.18365.75.camel@localhost>	 <20040922122848.M14129@linux-fr.org> <1095877951.18365.232.camel@localhost>
In-Reply-To: <1095877951.18365.232.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22.09.2004 20:32, Adrian Cox wrote:
>>Aha, this is an interesting point (which was missing from your previous
>>explanation). The base of your proposal would be to have several small i2c
>>"trees" (where a tree is a list of adapters and a list of clients) instead of
>>a larger, unique one. This would indeed solve a number of problems, and I
>>admit that it is somehow equivalent to Michael's classes in that it
>>efficiently prevents the hardware monitoring clients from probing the video
>>stuff. The rest is just details internal to each "tree". As I understand it,
>>each video device would be a tree on itself, while the whole hardware
>>monitoring stuff would constitute one (bigger) tree. Correct?

> I've been rereading the code, and it could be even simpler. How about
> this:
> 
> 1) The card driver defines an i2c_adapter structure, but never calls
> i2c_add_adapter(). The only extra thing it needs to do is to initialise
> the semaphores in the structure.
> 2) The frontend calls i2c_transfer() directly.
> 3) The i2c core never gets involved, and there is never any i2c_client
> structure.
> 
> This gives us the required reuse of the I2C algo-bit code, without any
> of the list walking or device probing being required.

This is the way the linux-dvb guys are currently favouring.

In some cases there should be an adapter that has been registered with 
i2c_add_adapter() because there can always be other drivers (audio/video 
multiplexes and the like) that you cannot get your hands on because they 
are provided by the manufacturer of some embedded platform.

For some cards (mostly bt8x8 based, ie. the core parts are driven by the 
"bttv" driver) and hybrid cards (ie. dvb cards that have a separate 
analog video input) the common i2c bus cannot go away, but it should be 
protected by proper .class entries in both the clients and adapters.

We think about splitting the frontend drivers into library parts, ie. 
library functions for demodulators (the current frontend drivers) and 
h/w dependent plls (or tuners).

Because of the fact the pci device knows which devices are present on 
the bus, it can register and configure the demod, pll and other specific 
dvb devices with direct i2c_transfer()s directly. If there are multiple 
combinations possible, it can use the library to probe as well.

The question we are currently facing is: are the frontend or demod i2c 
drivers real and independent i2c clients like thermal sensors or are 
they part of a h/w dependent design that should better be configured on 
a library basis?

If they are independend, then we need i2c bus types and type-safe 
client<=>adapter communication to exchange configuration and control 
informations, because the ioctl interface currently works from the 
adapter to the client and is not type safe.
Another question is, if this is probably too bloated. Think of simple 
matrix switch chipsets: the only "interface" they have is "set input a 
to output b".

> - Adrian Cox
> Humboldt Solutions Ltd.

CU
Michael.
