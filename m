Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267601AbUIUM1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267601AbUIUM1q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 08:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267618AbUIUM1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 08:27:46 -0400
Received: from nat.ecole.ensicaen.fr ([193.49.200.25]:23969 "EHLO
	e450.ensicaen.ismra.fr") by vger.kernel.org with ESMTP
	id S267601AbUIUM1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 08:27:33 -0400
From: "Jean Delvare" <khali@linux-fr.org>
To: Michael Hunold <hunold@linuxtv.org>
Cc: sensors@Stimpy.netroedge.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH][2.6] Add command function to struct i2c_adapter
Date: Tue, 21 Sep 2004 14:28:24 +0100
Message-Id: <20040921115442.M18286@linux-fr.org>
In-Reply-To: <41500BED.8090607@linuxtv.org>
References: <41500BED.8090607@linuxtv.org>
X-Mailer: Open WebMail 2.10 20030617
X-OriginatingIP: 62.23.212.160 (delvare)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

See my various questions inline.

> the attached patch adds a command function to struct i2c_adapter,
> similar to the command function that is already there for struct
> i2c_client.

I didne't even know that. Is this command function in struct i2c_client used
somewhere? What for?

> The reason behind this is as follows:
> In the DVB subsystem, the tuners are accessed via normal kernel i2c
> drivers. One big problem is, that tuners can be wired very differently
> depending on the surrounding hardware. Currently, we need to keep
> specific settings which are unique to a hardware design in the
> independent i2c tuner driver. This is both very ugly and makes it
> impossible to support DVB drivers which are not in the official Linux
> kernel tree, but could otherwise use in-kernel frontend driver.

What is the i2c tuner driver "independent" of? Do you simply mean that it
holds the common code for all DVB adapters?

> If the struct i2c_adapter has a command function, it would be possible
> to get additional informations from the adapter in the i2c client's
> attach_adapter() function *before* probing the device and guessing
> things like i2c addresses or other hardware settings.

I see what you want to do, but I don't exactly see how it solves your problem.
Your new command callback function will provide an adapter-specific interface
to adapter internal data. You will have to fill the data before you can access
it, so there still is hardware-specific data involved. Is your point that this
data would be located in (and split among) adapter drivers instead of the
common tuner driver as is now?

I am interested in your proposal because we (the sensors side of the i2c bus)
are facing a similar problem with hardware monitoring chips on motherboads.
The same chip can be wired differently on various motherboads, and most of the
time there is no way to guess (either because the hardware just doesn't
provide any way, or because the BIOS failed to do its job properly). We have
not come to any solution yet, and most of the time users have to use
user-space tools (such as i2cset) prior to loading the drivers. Looks like the
problem you are dealing with is of similar nature.

My initial thoughts about this were that we could use DMI data and/or PCI
information to identify systems, and trigger motherboard-specific code
whenever needed. It's really just a wild guess, I don't know if it is the
correct way. Wouldn't it work for you as well?

I would appreciate if you could show us some (pseudo)code with explanations on
what you have for now, and what you would have after the change. I have some
difficulties to understand what the change would actually change, most
probably because the video and sensors sides of the i2c subsystem work rather
differently.

On a completely different matter, what about the i2c subsystem class flags and
checking mechanism? You had come with a first step some months ago (adding a
class member to i2c clients), and your proposal (generalized check of i2c
client class against adapter class) looked very good to me, but then we did
not finish the job. What about it? I am willing to help on the sensors front
if you are going into this again someday. If I remember correctly, step 2 was
about clearing manual class checks and filling all class members, and step 3
was about implementing the generalized check in i2c-core. Am I right?

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/

