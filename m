Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbUDDNGK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 09:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUDDNGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 09:06:10 -0400
Received: from mail.convergence.de ([212.84.236.4]:64997 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262368AbUDDNFw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 09:05:52 -0400
Message-ID: <40700823.7030802@convergence.de>
Date: Sun, 04 Apr 2004 15:05:39 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
CC: Greg KH <greg@kroah.com>
Subject: Re: [RFC|PATCH][2.6] Additional i2c adapter flags for i2c client
 isolation
References: <40686476.7020603@convergence.de>	<20040330213418.195dc972.khali@linux-fr.org>	<406EBA38.1030203@gmx.de> <20040403163031.122b5df8.khali@linux-fr.org>
In-Reply-To: <20040403163031.122b5df8.khali@linux-fr.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 03.04.2004 16:30, Jean Delvare wrote:
> Michael Hunold wrote:

>>Hm, perhaps we should add another method where an adapter can specify 
>>the I2C_DRIVERID_*s from the clients it's expecting. The rationale 
>>behind this is, that most PCI cards can be identified uniquely by
>>their vendor/subvendor ids, so the driver author definately knows
>>which i2c clients are on the card and what are expected to be present.
>>No need to probe every i2c client.
>>
>>What do you think?

> I'm a bit surprised because I thought such a function already existed.
> After a quick glance I couldn't find it though. This would tend to prove
> that the chip driver IDs were never used anywhere (since this is the
> only use I can think of for them).
> 
> I think I remember Greg was even thinking of getting rid of them.

Ok.

> I'm not sure that the function you propose would be really useful. I
> guess that most people don't load i2c chip drivers they don't need. The
> class filter you propose, added to the different I2C addresses, should
> do the rest.
> 
> On the hardware monitoring side, we usually have a detection function in
> all chip drivers, which has the responsability to make sure that the
> chip is actually one which the driver is supposed to support. I admit
> it's not necessarily easy since there is no official ID such as for the
> PCI cards. But we do it and in most cases it's efficient. Maybe you
> don't have such a mechanism for the video i2c chip drivers? This would
> explain why you feel the need of such a function when I do not.

Well, the problem is that the check is on the wrong side to solve my
problem: it's ok that the driver checks if it's on the adapter it
expects. But I'd like to have a feature that an adapter can reject a
driver if the adapter knows that the chipset isn't on the bus for sure
(for example when the adapter knows the exact type of card via pci ids
and the i2c clients are well known)

As I already have explained, there are DVB cards that have a very
delicate i2c bus. The number of i2c tuners is still increasing and all
these tuners have I2C_ADAP_CLASS_TV_DIGITAL set, so they will be probed
even on the delicate i2c busses, even if I know for sure that they are
not on this particular bus for sure.

Hm, this is running in a completly different direction now. 8-)

> I don't really see where/how such a function be, but if you want to take
> a try and propose a patch, I'll take a look.
> 
> That said, it seems to be something different from the class bitfields
> we were discussing so far, so it would be better to first go on with the
> classes, and see the ids later.

Yes, agreed. Let's get the first thing straight before.

> Greg, any comment? Is the approach I suggested OK with you, or do you
> prefer Michael's one (with the additional flag)?

I have though about this and grepped through the kernel a bit. I now 
have the opinion that we should fix all adapters and drivers in the 
kernel to keep a consistent scheme without the akward flag is proposed.

Here are some statistics:

Ok, adapters which specify I2C_ADAP_CLASS_TV_ANALOG
./drivers/media/video/saa7134/saa7134-i2c.c
./drivers/media/video/bttv-i2c.c

Ok, adapters which specify I2C_ADAP_CLASS_TV_ANALOG (these are my 
drivers and I plan to patch them accordingly)
./drivers/media/video/hexium_orion.c
./drivers/media/video/mxb.c
./drivers/media/video/hexium_gemini.c
./drivers/media/video/dpc7146.c

Ok, adapters which specify I2C_ADAP_CLASS_CAM_DIGITAL,
./drivers/usb/media/w9968cf.c

Ok, adapters which specify I2C_ADAP_CLASS_SMBUS,
./drivers/i2c/busses/i2c-nforce2.c
./drivers/i2c/busses/i2c-sis630.c
./drivers/i2c/busses/i2c-piix4.c
./drivers/i2c/busses/i2c-sis96x.c
./drivers/i2c/busses/i2c-i801.c
./drivers/i2c/busses/i2c-ali15x3.c
./drivers/i2c/busses/i2c-isa.c
./drivers/i2c/busses/i2c-viapro.c
./drivers/i2c/busses/i2c-amd8111.c
./drivers/i2c/busses/i2c-amd756.c
./drivers/i2c/busses/i2c-parport-light.c
./drivers/i2c/busses/i2c-parport.c

The following drivers implement adapters and don't have a type 
specified. (6)

./drivers/i2c/busses/i2c-ali1535.c
./drivers/i2c/busses/i2c-iop3xx.c
./drivers/i2c/busses/i2c-sis5595.c
./drivers/i2c/busses/scx200_acb.c
./drivers/i2c/busses/i2c-keywest.c
./drivers/i2c/busses/i2c-ibm_iic.c
Are all of these I2C_ADAP_CLASS_SMBUS?

Ok, now come some special cases, where busses are registered through a 
helper function and don't have a type set. (my guesses are in paranthesis)

=> i2c_bit_add_bus() users with no class entry (16)
./drivers/i2c/busses/i2c-frodo.c
./drivers/i2c/busses/i2c-philips-par.c
./drivers/i2c/busses/i2c-prosavage.c
./drivers/i2c/busses/scx200_i2c.c
./drivers/i2c/busses/i2c-savage4.c
./drivers/i2c/busses/i2c-via.c
./drivers/i2c/busses/i2c-elv.c
./drivers/i2c/busses/i2c-velleman.c
./drivers/i2c/busses/i2c-hydra.c
./drivers/video/aty/radeon_i2c.c
./drivers/ieee1394/pcilynx.c
./drivers/acorn/char/i2c.c
./drivers/i2c/busses/i2c-i810.c (I2C_CLASS_DDC|I2C_CLASS_TV_ANALOG?)
./drivers/i2c/busses/i2c-voodoo3.c (I2C_CLASS_DDC|I2C_CLASS_TV_ANALOG?)
./drivers/video/matrox/i2c-matroxfb.c (I2C_CLASS_DDC?)
./drivers/media/video/zoran_card.c (I2C_CLASS_TV_ANALOG?)

=> i2c_pcf_add_bus() users with no class entry
./drivers/i2c/busses/i2c-elektor.c (I2C_CLASS_ALL?)

=> i2c_iic_add_bus() users with no class entry
./drivers/i2c/busses/i2c-ite.c (I2C_CLASS_ALL?)

Now to the other side, the client drivers. As we have discussed, they 
will all need to define a class type. My proposals are above each section:

I2C_CLASS_SMBUS
./drivers/i2c/chips/w83781d.c
./drivers/i2c/chips/lm75.c
./drivers/i2c/chips/adm1021.c
./drivers/i2c/chips/via686a.c
./drivers/i2c/chips/lm85.c
./drivers/i2c/chips/eeprom.c
./drivers/i2c/chips/it87.c
./drivers/i2c/chips/lm78.c
./drivers/i2c/chips/lm83.c
./drivers/i2c/chips/asb100.c
./drivers/i2c/chips/lm90.c
./drivers/i2c/chips/w83l785ts.c
./drivers/i2c/chips/fscher.c
./drivers/i2c/chips/gl518sm.c

I2C_CLASS_TV_ANALOG
./drivers/media/video/tea6420.c
./drivers/media/video/tea6415c.c
./drivers/media/video/tda9840.c
./drivers/media/video/tuner.c
./drivers/media/video/saa5249.c
./drivers/media/video/saa5246a.c
./drivers/media/video/saa7110.c
./drivers/media/video/tda9887.c
./drivers/media/video/saa7134/saa6752hs.c
./drivers/media/video/bt856.c
./drivers/media/video/saa7185.c
./drivers/media/video/bt819.c
./drivers/media/video/saa7111.c
./drivers/media/video/tuner-3036.c
./drivers/media/video/tda9875.c
./drivers/media/video/vpx3220.c
./drivers/media/video/msp3400.c
./drivers/media/video/tda7432.c
./drivers/media/video/bt832.c
./drivers/media/video/saa7114.c
./drivers/media/video/tvmixer.c
./drivers/media/video/adv7175.c
./drivers/media/video/adv7170.c
./drivers/media/video/tvaudio.c

I2C_CLASS_TV_DIGITAL
./drivers/media/dvb/bt8xx/dvb-bt8xx.c

I2C_CLASS_DDC
./drivers/video/matrox/matroxfb_maven.c

No idea about these. Do we need some new classes for them?
./drivers/i2c/i2c-dev.c
./drivers/macintosh/therm_adt7467.c
./drivers/macintosh/therm_pm72.c
./drivers/macintosh/therm_windtunnel.c
./drivers/acorn/char/pcf8583.c
./sound/oss/dmasound/dac3550a.c
./sound/oss/dmasound/tas_common.c
./sound/ppc/keywest.c
./drivers/media/video/ir-kbd-i2c.c

> Thanks.

So, to get the whole stuff consistent through the kernel, 24 adapter 
drivers and 49 client drivers need to be touched.

CU
Michael.




