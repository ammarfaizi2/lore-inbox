Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWEGTHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWEGTHP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 15:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWEGTHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 15:07:15 -0400
Received: from smtpout.mac.com ([17.250.248.186]:26596 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751231AbWEGTHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 15:07:14 -0400
In-Reply-To: <m3mzdum448.fsf@defiant.localdomain>
References: <mj+md-20060504.211425.25445.atrey@ucw.cz> <20060505210614.GB7365@kroah.com> <9e4733910605051415o48fddbafpf0f8b096f971e482@mail.gmail.com> <20060505222738.GA8985@kroah.com> <9e4733910605051705j755ad61dm1c07c66c2c24c525@mail.gmail.com> <21d7e9970605051857l4415a04ai7d1b1f886bb01cee@mail.gmail.com> <9e4733910605052039n7d2debbse0fd07e0d1d059fb@mail.gmail.com> <m3d5er729f.fsf@defiant.localdomain> <9e4733910605060608l57c1a215pa300c326ef1eef4b@mail.gmail.com> <m34q036n46.fsf@defiant.localdomain> <9e4733910605061124u6b1c4b88nd84faa914c72521f@mail.gmail.com> <m33bfm4ud2.fsf@defiant.localdomain> <9E6FFBE8-39F0-4C3D-8D6C-B0EC59AD5D22@mac.com> <m3mzdum448.fsf@defiant.localdomain>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E4FD2AAC-98AA-42EF-951D-02757C24550C@mac.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, Dave Airlie <airlied@gmail.com>,
       Greg KH <greg@kroah.com>, Ian Romanick <idr@us.ibm.com>,
       Dave Airlie <airlied@linux.ie>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Date: Sun, 7 May 2006 15:07:08 -0400
To: Krzysztof Halasa <khc@pm.waw.pl>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 7, 2006, at 08:05:59, Krzysztof Halasa wrote:
> Kyle Moffett <mrmacman_g4@mac.com> writes:
>> Jon Smirl gave a great description of exactly how to write such a  
>> "driver".  I seem to recall that we already have the ability to  
>> trigger manual PCI binding by bus:slot number; in combination with  
>> an appropriate "write EEPROM with firmware file" driver that has  
>> no default list of PCI devices; you could easily manually trigger  
>> a bind of the device.
>
> Writing EEPROM is not a problem and can be done safely from user  
> space (mmap /dev/mem).

This is *exactly* what we don't want to do!  The whole point of this  
thread is to prevent the need to use /dev/mem and /dev/kmem for  
anything except debugging.

> Doing it in the kernel seems like an overkill, especially if you do  
> the operation once in few years it's much easier to just download a  
> (statically linked?) binary than messing with the kernel.

Ewww, I certainly wouldn't trust a binary statically-linked binary  
program that mmaps /dev/mem or /dev/kmem, and I certainly bet that  
90% of the people on this list would feel likewise.  We'd much prefer  
a program which does this:

   #! /bin/sh
   cp firmware.bin /lib/firmware/some_firmware_file.bin
   echo -n eeprom_load_driver >/sys/device/$PCI_ID/bind
   echo -n 1 >/sys/device/$PCI_ID/unbind

Simple, obviously correct, and uses a nice reuseable driver too!

> It doesn't even interfere with the "main" driver and can be done  
> while the device is operating (given that previous EEPROM made  
> sense, otherwise the driver would not load).

No!  That would be even worse!  You're then having userspace poke at  
the driver while a kernel driver is loaded, which is *exactly* what X  
is getting into trouble for doing.  If you want to add firmware  
update capability, add it to the preexisting primary driver.

>> In any case what you really need for all those cases is a  
>> simplistic stub driver that provides some sort of in-kernel mutual  
>> exclusion.
>
> Right. I.e., "enable" interface with, possibly, locking mechanism,  
> instead of some per-class "driver".

No, not an "enable" interface.  In this case the kernel should do  
basically all of the poking at PCI resources for you.  If you  
_really_ want to do that kind of update in userspace, write a stub  
driver which just enables the device on bind, disables it on unbind,  
and mmap and write to the sysfs "rom" file.

Cheers,
Kyle Moffett

