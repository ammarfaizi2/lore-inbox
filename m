Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265162AbTFRLfs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 07:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265163AbTFRLfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 07:35:48 -0400
Received: from mail.convergence.de ([212.84.236.4]:9141 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S265162AbTFRLfn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 07:35:43 -0400
Message-ID: <3EF051AF.1060006@convergence.de>
Date: Wed, 18 Jun 2003 13:49:03 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030408
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Holger Waechtler <holger@convergence.de>,
       Johannes Stezenbach via CVS <js@convergence.de>
Subject: DVB updates, 3rd try
References: <3ED3634A.2000608@convergence.de> <20030528111202.A27811@infradead.org>
In-Reply-To: <20030528111202.A27811@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus, Alan, Christoph,

again I hope to get the LinuxTV.org CVS "dvb-kernel" driver in
sync with the latest 2.5 kernel.

The main project page is http://www.linuxtv.org.

It's a patchset of 10 patches -- due to the size of some of the
patches, I don't post them on the list again.

Please have a look at them at:

http://www.gdv.uni-hannover.de/~hunold1/dvb/

I fixed my last patchset, so that it applies to 2.5.72 and added
a new patch that hopefully clean up the things according to the
comments on kernel mailing list (mainly by Christoph Hellwig).

The patch "10-clean-up.diff" is new and tries to fix the stuff
that was broken before or that I have broken with patches 1 - 9.

I'd like to ask you one last time to accept this patchset
as one big blob. It does not affect other subsystems beside /media/video
and /media/dvb, so it won't clash with other changes at all.

If there still are issues, then I can fix them up with a later patchset.

Thanks
Michael Hunold.

--------------------------------------------------------------------------
Below are the main comments for the last patchset:

 > 01-av7110-firware.diff
 >
 >  - looks fine (obsiously :)).  If the old driver works with the
 >    new firware I'd suggets sending it to Linux now

Yes, the firmware would work with the old driver as well. So this
one can safely applied.

 > 02-saa7146-core.diff
 >
 >  - the WRITE_RPS0 macro is ugly as hell, you probably want to
 >     replace it with a proper inline.  But you can leave this to
 >     a later patch.  If it doesn't need the other updates I'd
 >     suggest submitting it now.

Fixed.

 > 03-dvb-core.diff
 >
 >  - okay, this is a big one..  Could you submit the typedef removal
 >    as a first separate patch so thed actual changes are reviewable
 >    more easily?

I'm very sorry, but as I already wrote to you (Christoph),
this is hardly possible, because there has been such a long time
beetwen the last patchset, the typedef changes and this new patchset.

 >  - please use <linux/types.h> not <asm/types.h> everywhere
 >  - please include <asm/*.h> headers after <linux/*.h> ones
 >  - This is wrong:
 > -static struct dvb_device dvbdev_dvr = {
 > +static
 > +struct dvb_device dvbdev_dvr = {
 >    instead of breaking the indention rather fix the reamining parts
 >    of the driver

Fixed.

 >  - dvb_kernel_thread_setup doesn't need the BKL
 >
 > 04-dvb-drivers.diff
 >
 >  - looks ok
 >
 > 05-update-frontends.diff
 >
 >  - looks ok
 >
 > 06-new-frontend.diff
 >
 >  - looks ok (except for the above mentioned indentation issues)
 >
 > 07-dvb-core-lib-user.diff
 >
 >  - looks ok (obviously)
 >
 > 08-analog-saa7146-update.diff
 >
 >  - looks ok (obviously)
 >
 > 09-saa7111-i2c-fix.diff
 >
 >  - looks ok (obviously)

Fixed the indentation in many other files as well.

--------------------------------------------------------------------------
This is the README for both the old patches and the new patch:

[1-10] update the firmware of the av7110 dvb driver

[2-10] update the generic saa7146 driver
- remove some #if LINUX_VERSION_CODE constructions
- sync with the interrupt handler changes in 2.5.69
- add a missing kfree() call which caused the kernel to
   leak 32kB of kmalloc()ed memory. iieek!
- fixed the capture code to handle cards that have swapped
   field order (odd and even fields)
- added and fixed some debug messages
- changed from kmalloc() to pci_consistent()
- many small changes necessary to fix warnings/problems
   when compiled for ppc64 for example

[3-10] update dvb subsystem core
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

[4-10] update the av7110 and budget drivers
- replaced ddelay() wait function with generic dvb_delay() implementation
- new DATA_MPEG_VIDEO_EVENT for direct mpeg2 video playback
- added support for DVB-C cards with MSP3400 mixer and analog tuner
- fixed up the av7110_ir handler and especially the write_proc() function; this
fixed the bug the Stanford Checker has found

[5-10] update dvb frontend drivers
- C99 initializers
- fix up some includes
- various bugfixes

[6-10] add a new dvb frontend driver
- add a new driver for the cx24110 frontend by Peter Hettkamp
<peter.hettkamp@t-online.de>

[7-10] add dvb subsystem as a crc32 lib user

[8-10] update analog saa7146 drivers mxb and dpc7146
- add MODULE_DEVICE_TABLE entries, so that /sbin/hotplug can handle the devices
- fixup due to the latest i2c changes

[9-10] correct the i2c address of the saa7111
- corrects the i2c address from "34>>1" to 0x24 and 0x25. Believe me -- or
look at the data sheet, for example from
http://www.gdv.uni-hannover.de/~hunold1/linux/saa7146/specs/saa7111a.pdf
Page 41 says: "Slave address read = 49H or 4BH; note 2 write = 48H or 4AH"
They use 8-bit addresses here, but i2c addresses are 7-bit,
ie. 0x48>>1 == 0x24 and 0x4a>>1 = 0x25

[10-10] clean up the parts according to the comments on kernel mailing list
(mainly by Christoph Hellwig)
- ugly WRITE_RPS0 define in saa7146_hlp.c has been replaced by a proper inline (I hope)
- use <linux/types.h> not <asm/types.h> everywhere
- include <asm/*.h> headers after <linux/*.h> ones
- revert the indentation from "static <newline> xxx to "static xxx"

