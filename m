Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269770AbRIJOJr>; Mon, 10 Sep 2001 10:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270705AbRIJOJh>; Mon, 10 Sep 2001 10:09:37 -0400
Received: from ns.muni.cz ([147.251.4.33]:65230 "EHLO aragorn.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S269770AbRIJOJ2>;
	Mon, 10 Sep 2001 10:09:28 -0400
Date: Mon, 10 Sep 2001 16:09:49 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: Converting the drivers/sound/mad16.c to ISAPnP
Message-ID: <20010910160949.Y20031@informatics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

	I've got a three problems while converting the drivers/sound/mad16.c
driver for my OPTi 931 soundcard to the kernel ISAPnP interface. I need
help from some ISAPnP guru.

1. I do something like this in my driver:

	bus = isapnp_find_card(vendor, device, NULL)
	audio_dev = isapnp_find_dev(bus, audio_vendor, audio_function, NULL);
	audio_dev->prepare(audio_dev);
	if (!audio_dev->active)
		audio_dev->activate(audio_dev);
	mpu_dev = isapnp_find_dev(bus, mpu_vendor, mpu_function, NULL);
	mpu_dev->prepare(mpu_dev);
	if (!mpu_dev->active)
		/* [1] */
		mpu_dev->activate(mpu_dev);

	Now the problem is that I cannot activate() the MPU successfuly;
the mpu_dev->activate() fails with -2 (-ENOENT). With a non-PnP driver,
the uart 401 uses I/O base address 0x300 and IRQ 10. So when I add
the following two lines before [1] (before mpu_dev->activate(mpu_dev)),
the mpu_dev->activate() function succeeds:

+                isapnp_resource_change(&mpu_dev->resource[0], 0x300, 2);
+                isapnp_resource_change(&mpu_dev->irq_resource[0], 10, 1);

	Why the activate() function does work for the first device (audio
interface) and not the second one (MPU 401 UART)? Why this works when I add
the explicit resource settings?

2. The contents of /proc/isapnp looks strange after the mad16.o
	is loaded. After the system boot, it has the following
	content:

Card 1 'OPT0931:OPTi Audio 16' PnP version 1.0
  Logical device 0 'OPTffff:AUX0'
    Device is not active
  Logical device 1 'OPT9310:OPTi Audio 16'
    Device is not active
    Active port ,0xe00
    Resources 0
      Priority acceptable
      Port 0x534-0x608, align 0x3, size 0x4, 16-bit address decoding
      Port 0x380-0x3f0, align 0xf, size 0xc, 16-bit address decoding
      Port 0x220-0x240, align 0x1f, size 0x10, 16-bit address decoding
      Port 0xe0c-0xffc, align 0x3, size 0x4, 16-bit address decoding
      IRQ 5,7,10 High-Edge
      DMA 0,1,3 8-bit byte-count type-A
      DMA 0,1,3,5,6 8-bit&16-bit byte-count word-count type-A
      Alternate resources 0:1
[...]
      Alternate resources 0:2
[...]
      Alternate resources 0:3
[...]
      Alternate resources 0:4
[...]
  Logical device 2 'OPT0001:Game Port'
    Device is not active
    Resources 0
      Priority preferred
      Port 0x200-0x20f, align 0x0, size 0x1, 16-bit address decoding
  Logical device 3 'OPT0002:MPU401'
    Device is not active
    Resources 0
      Priority preferred
      Port 0x300-0x360, align 0xf, size 0x2, 16-bit address decoding
      IRQ 5,7,2/9,10,11 High-Edge

	When I insmod mad16.o, which does the isapnp calls mentioned
above, the /proc/isapnp changes to this (note the many 0xffff's):

Card 1 'OPT0931:OPTi Audio 16' PnP version 1.0
  Logical device 0 'OPTffff:AUX0'
    Device is active
    Active port 0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff
    Active IRQ 255 [0xff],255 [0xff]
    Active DMA 255,255
    Active memory 0xffffffff,0xffffffff,0xffffffff,0xffffffff
  Logical device 1 'OPT9310:OPTi Audio 16'
    Device is active
    Active port 0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff
    Active IRQ 255 [0xff],255 [0xff]
    Active DMA 255,255
    Active memory 0xffffffff,0xffffffff,0xffffffff,0xffffffff
    Resources 0
      Priority acceptable
      Port 0x534-0x608, align 0x3, size 0x4, 16-bit address decoding
      Port 0x380-0x3f0, align 0xf, size 0xc, 16-bit address decoding
      Port 0x220-0x240, align 0x1f, size 0x10, 16-bit address decoding
      Port 0xe0c-0xffc, align 0x3, size 0x4, 16-bit address decoding
      IRQ 5,7,10 High-Edge
      DMA 0,1,3 8-bit byte-count type-A
      DMA 0,1,3,5,6 8-bit&16-bit byte-count word-count type-A
      Alternate resources 0:1
[... the same as above ...]
  Logical device 2 'OPT0001:Game Port'
    Device is active
    Active port 0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff
    Active IRQ 255 [0xff],255 [0xff]
    Active DMA 255,255
    Active memory 0xffffffff,0xffffffff,0xffffffff,0xffffffff
    Resources 0
      Priority preferred
      Port 0x200-0x20f, align 0x0, size 0x1, 16-bit address decoding
  Logical device 3 'OPT0002:MPU401'
    Device is active
    Active port 0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff
    Active IRQ 255 [0xff],255 [0xff]
    Active DMA 255,255
    Active memory 0xffffffff,0xffffffff,0xffffffff,0xffffffff
    Resources 0
      Priority preferred
      Port 0x300-0x360, align 0xf, size 0x2, 16-bit address decoding
      IRQ 5,7,2/9,10,11 High-Edge

3. The last problem is: the non-PnP driver uses the base addresss of
	0x530. The ISAPnP reports (as above) the audio function base
	address as 0x534. The non-PnP driver uses the ports 0x530-0x533
	to set up the card, and the ports 0x534+ as the base address
	of ad1848-like device. Why the region between 0x530 and 0x533
	is not visible via the isapnp interface?

	Thanks,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|\    Do not meddle in the affairs of sysadmins, for they are quick to    /|
|\\   anger and have not need for subtlety.    (stolen from some /.er)   //|
