Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263570AbTE0M4N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 08:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263589AbTE0M4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 08:56:13 -0400
Received: from mail.convergence.de ([212.84.236.4]:49317 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263570AbTE0MzR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 08:55:17 -0400
Message-ID: <3ED3634A.2000608@convergence.de>
Date: Tue, 27 May 2003 15:08:26 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030408
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: DVB updates, 2nd try
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

thanks for all the suggestions regarding the dvb code, this is now my 
2nd try... ;-)

Again, it's a patchset of 9 patches, which tries to sync the linuxtv.org 
CVS with the kernel driver.

Due to the size of some of the patches, I don't post them on the list. 
Please have a look at them at:
http://www.gdv.uni-hannover.de/~hunold1/dvb/

Below is a summary of what these patches actually do. I tried to 
preserve everything that wasn't changed through the linuxtv.org's CVS, 
so I hope I did not wipe something out again.

I understand that this is a big load Linus will most likely refuse to 
merge at once. So I'd like to ask other users to have a look at these 
patches and ask the maintainers (Christoph Hellwig, Alan Cox) to 
actually do the merge.

@ Christoph Hellwig:

I hope I followed all your suggestions. These were:
- remove the DVB_DEVFS_ONLY completly
- remove all #ifdef LINUX_KERNEL magic
- remove all *internal* typedefs for structs and enums
- use c99 initializers
- use linux/errno.h instead of asm/errno.h
- follow the new devfs api

Still left:
- fix up dprintk() usage

CU
Michael.

--------------------------------------------------------------------------------
[1-09] update the firmware of the av7110 dvb driver

[2-09] update the generic saa7146 driver
- remove some #if LINUX_VERSION_CODE constructions
- sync with the interrupt handler changes in 2.5.69
- add a missing kfree() call which caused the kernel to
   leak 32kB of kmalloc()ed memory. iieek!
- fixed the capture code to handle cards that have swapped fields
- added and fixed some debug messages
- changed from kmalloc() to pci_consistent()
- many small changes necessary to fix warnings/problems
   when compiled for ppc64 for example

[3-09] update dvb subsystem core
- switched from user-land types like __u8 to u8 and uint16_t to u16
this makes the patch rather large.
- updated the dvr (digital videorecording) facility
- renamed some structures, like "struct dmxdev_s" to "struct dmxdev"
- introduced dvb_functions.[ch], where some linux-kernel specific
functions are encapsulated. by this, the dvb subsystem stays quite
independent from deeper linux kernel functions.
- moved dvb_usercopy() to dvb_functions.c -- this is essentially
video_usercopy() which should be generic_usercopy() instead...
- Made the dvb-core in dvbdev.c work with devfs again.
- remove all typedefs from structs
- remove all typedefs from enums

[4-09] update the av7110 and budget drivers
- replaced ddelay() wait function with generic dvb_delay() implementation
- new DATA_MPEG_VIDEO_EVENT for direct mpeg2 video playback
- added support for DVB-C cards with MSP3400 mixer and analog tuner
- fixed up the av7110_ir handler and especially the write_proc() 
function; this fixed the bug the Stanford Checker has found

[5-09] update dvb frontend drivers
- C99 initializers
- fix up some includes
- various bugfixes

[6-09] add a new dvb frontend driver
- add a new driver for the cx24110 frontend by Peter Hettkamp
<peter.hettkamp@t-online.de>

[7-09] add dvb subsystem as a crc32 lib user

[8-09] update analog saa7146 drivers mxb and dpc7146
- add MODULE_DEVICE_TABLE entries, so that /sbin/hotplug can handle the 
devices
- fixup due to the latest i2c changes

[9-09] correct the i2c address of the saa7111
- corrects the i2c address from "34>>1" to 0x24 and 0x25. Believe me -- 
or look at the data sheet, for example from
http://www.gdv.uni-hannover.de/~hunold1/linux/saa7146/specs/saa7111a.pdf
Page 41 says: "Slave address read = 49H or 4BH; note 2 write = 48H or 
4AH" They use 8-bit addresses here, but i2c addresses are 7-bit,
ie. 0x48>>1 == 0x24 and 0x4a>>1 = 0x25
--------------------------------------------------------------------------------


