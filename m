Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267696AbUIUOkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267696AbUIUOkc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 10:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267730AbUIUOkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 10:40:32 -0400
Received: from mail.convergence.de ([212.227.36.84]:49593 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S267696AbUIUOkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 10:40:07 -0400
Message-ID: <41503CFD.9020207@linuxtv.org>
Date: Tue, 21 Sep 2004 16:38:53 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
CC: sensors@Stimpy.netroedge.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, linux-dvb <linux-dvb@linuxtv.org>
Subject: Re: [PATCH][2.6] Add command function to struct i2c_adapter
References: <41500BED.8090607@linuxtv.org> <20040921115442.M18286@linux-fr.org>
In-Reply-To: <20040921115442.M18286@linux-fr.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(because I think this will be an in-depth discussion I trimmed the CC 
list a litte bit)

On 21.09.2004 15:28, Jean Delvare wrote:
>>the attached patch adds a command function to struct i2c_adapter,
>>similar to the command function that is already there for struct
>>i2c_client.

> I didne't even know that. Is this command function in struct i2c_client used
> somewhere? What for?

Please have a look at Video4Linux driver drivers/media/video/mxb.c. This 
driver needs various helper chipsets: tuner, tea6145c, tea6420, tda9840, 
saa7111.

For example the tea6415c is a simple video matrix chipset. If the user 
request a change of the input, the video matrix needs to be re-programmed.

For this, the tea6415 driver has the TEA6415C_SWITCH ioctl function, 
which is called through the i2c_client command() function.
 > mxb->tea6415c->driver->command(mxb->tea6415c,TEA6415C_SWITCH, &vm);

Otherwise there would be no way the mxb driver could tell the tea6415c 
that the configuration should be changed.

>>The reason behind this is as follows:
>>In the DVB subsystem, the tuners are accessed via normal kernel i2c
>>drivers. One big problem is, that tuners can be wired very differently
>>depending on the surrounding hardware. Currently, we need to keep
>>specific settings which are unique to a hardware design in the
>>independent i2c tuner driver. This is both very ugly and makes it
>>impossible to support DVB drivers which are not in the official Linux
>>kernel tree, but could otherwise use in-kernel frontend driver.

> What is the i2c tuner driver "independent" of? Do you simply mean that it
> holds the common code for all DVB adapters?

The tuner is called frontend in dvb terms, because it holds more that 
just a simple tuner.

Some parts are hardware-independent and are in the right place in the 
frontend drivers. But manufacturers are free to use different plls (the 
actual tuners). Unfortunately, they nearly all sit on the same i2c 
address, are really dumb, write only and therefore not very distinguishable.

Currently the frontend drivers do a strcmp() on the adapter name. If it 
is "SkyStar2" for example, then it is a TechniSat card with a  Samsung 
TBMU24112IMB pll.

With that solution, it's not possible to support dvb drivers outside of 
the kernel which could theoretically use the in-kernel frontend drivers, 
because h/w dependend things need to coded into every frontend driver.

>>If the struct i2c_adapter has a command function, it would be possible
>>to get additional informations from the adapter in the i2c client's
>>attach_adapter() function *before* probing the device and guessing
>>things like i2c addresses or other hardware settings.

> I see what you want to do, but I don't exactly see how it solves your problem.
> Your new command callback function will provide an adapter-specific interface
> to adapter internal data.

Not adapter internal data, but frontend specific data, that only the 
manufacturer knows (which can be distinguished by subsystem pci ids).

 > You will have to fill the data before you can access
 > it, so there still is hardware-specific data involved. Is your point
 > that this
 > data would be located in (and split among) adapter drivers instead of
 > the
 > common tuner driver as is now?

Yes. With that approach, it's possible to support dvb drivers outside of 
the kernel, because all necessary information about the frontends is 
inside the dvb driver, not the frontend driver.

> I am interested in your proposal because we (the sensors side of the i2c bus)
> are facing a similar problem with hardware monitoring chips on motherboads.
> The same chip can be wired differently on various motherboads, and most of the
> time there is no way to guess (either because the hardware just doesn't
> provide any way, or because the BIOS failed to do its job properly). We have
> not come to any solution yet, and most of the time users have to use
> user-space tools (such as i2cset) prior to loading the drivers. Looks like the
> problem you are dealing with is of similar nature.

Yes, it's basically the same.

> My initial thoughts about this were that we could use DMI data and/or PCI
> information to identify systems, and trigger motherboard-specific code
> whenever needed. It's really just a wild guess, I don't know if it is the
> correct way. Wouldn't it work for you as well?

This is how it will work. In our case, we only need pci ids, but it's 
possible to use other information sources as well.

Let's say the user loads the stv0299 frontend driver and later the 
dvb-ttpci device driver.

The dvb-ttpci driver exports an i2c_adapter, the stv0299 
i2c_attach_adapter() function will be called. Ideally, if this isn't a 
bus from the digitial tv subsystem, then bail out (This needs to be 
implemented, see below).

If we are on a digital tv i2c bus the stv0299 uses the i2c adapter 
command() callback and asks the i2c adapter, if this frontend can be on 
that bus at all and asks for further informations.

dvb-ttpci knows the pci ids and can tell different hardware versions. 
For example, cable dvb cards have different pci ids than satellite dvb 
cards. The stv0299 is a satellite frontend, so if the bus is on a dvb 
cable card then dvb-ttpci can simply tell the stv0299 driver not to do 
anything.

If the stv0299 can be found on that system in theory, either the correct 
hardware stv0299 dependent informations are supplied completely or 
probing informations are supplied.

> I would appreciate if you could show us some (pseudo)code with explanations on
> what you have for now, and what you would have after the change. I have some
> difficulties to understand what the change would actually change, most
> probably because the video and sensors sides of the i2c subsystem work rather
> differently.

Please have a look at drivers/media/dvb/frontends/stv0299.c

At the top you'll notice a lot of defines:
#define PHILIPS_SU1278_TUA      3 // SU1278 with TUA6100 synth

In lots of functions there are switch/case statements to distinguish 
different plls, for example in pll_set_tv_freq().  stv0299_init() is 
ugly, too. The init-data for different hardware is hardcoded into the 
frontend driver. *shiver*

With the command() function, probe_tuner() with the ugly strcmp() stuff 
and i2c probing can be killed completely.

In other places, common i2c_adapter commands can be used to pull 
frontend device specific data from the dvb device (for example frequency 
boundaries) or trigger h/w dependend thinks that only the dvb driver 
knows, like setting a frequency in the pll with command(SET_PLL).

Sorry, I just have some proof-of-concept code, that doesn't use all the 
things I explained above. Some dvb people would like to give up the 
strong separation due to the kernel i2c interface and have something 
more "dvbish".

> On a completely different matter, what about the i2c subsystem class flags and
> checking mechanism? You had come with a first step some months ago (adding a
> class member to i2c clients), and your proposal (generalized check of i2c
> client class against adapter class) looked very good to me, but then we did
> not finish the job. What about it? I am willing to help on the sensors front
> if you are going into this again someday. If I remember correctly, step 2 was
> about clearing manual class checks and filling all class members, and step 3
> was about implementing the generalized check in i2c-core. Am I right?

I'll answer that in a separate mail.

> Thanks.

CU
Michael.
