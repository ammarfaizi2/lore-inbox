Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285506AbRLSV2T>; Wed, 19 Dec 2001 16:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285507AbRLSV2K>; Wed, 19 Dec 2001 16:28:10 -0500
Received: from [62.47.19.152] ([62.47.19.152]:40065 "HELO twinny.dyndns.org")
	by vger.kernel.org with SMTP id <S285506AbRLSV2D>;
	Wed, 19 Dec 2001 16:28:03 -0500
Message-ID: <3C21051E.DB2FB56@webit.com>
Date: Wed, 19 Dec 2001 22:22:38 +0100
From: Thomas Winischhofer <tw@webit.com>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-GB,en-US,de-AT,de-DE,de-CH,sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, xpert@XFree86.Org
Subject: SiS 630 - framebuffer fixed
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

after five days of struggle with reverse-engineered assembler code
transformed to C, I could fix the SiS framebuffer driver for use with
some LCD displays using a LVDS (Chromtel) video bridge. That is what
most laptops use, as for example the Gericoms (and some Claveos I have
heard).

Since I had to re-write a large part of the (totally uncommented) code,
I have not yet made a patch (which would be _huge_). Instead, you can
find the complete source on 

   http://members.aon.at/~twinisch/sisfb.tar.gz

for download. Just cd to /usr/src/linux/drivers/video/sis/ and extract
the archive there. I based the code on the one contained in kernel
2.4.16 (I saw no sisfb updated in 2.4.17-preX/rcX so this should do.)

To select a mode, either

a) append a kernel parameter, eg. video=sisfb:mode:1024x768x16

or

b) insmod it with the command line "insmod sisfb mode=1024x768x16"

Default mode is 800x600x8 which has problems on LCD panels (see below).

Caveats and issues:

1) I had to change the driver in its very basics for make it work on
LVDS/Chromtel bridges. LVDS data tables were empty in the driver, so
this couldn't have worked by any means. I re-wrote large parts of the
code (hopefully not touching anything not-LVDS-related) to make the
driver read the data contained in the BIOS. This implys the following
issue:

The driver relies - if an LVDS bridge (with or without Chromtel/Trumpion
TV converter) is to be used - on a machine with a BIOS. It will _not_
work with LinuxBIOS. As I believe that LinuxBIOS is not widely used
anyway, I think we could live with that.

2) The driver currently only displays 16bpp modes correctly on LCD
screens (using LVDS bridges, that is). I am working on this and will
release a patch as soon as I found the problem. (VGA is OK). Currently,
the image is very dark on the LCD and - as it seems - in black & white
(???).

3) The current X driver from CVS does work in combination with the
framebuffer driver, but there seems to be at least one problem (not
leading into further trouble on my machine, yet) with the hardware
cursor. I don't know whether this is memory management related or not,
however, to fix this is beyond my scape of knowledge.

4) DRM works fine, as long as you set the memory to more than 16MB.
Below that I saw occasional screen corruption (which again makes me
believe that it's a memory management problem).

5) TV-out doesn't work. The tables in the driver are empty and I have no
idea where to find the data in the BIOS.

6) If you intend to use DRM under X, a word on this: It works. BUT:

 a) If the sisfb is compiled as a module and not insmod'ed _before_ the
X driver takes over (so to say), it for some reasons is not able to
detect the video bridge type. This is possibly a hardware problem; it
seems the X driver did something odd that leads into wrong data in the
SiS hardware registers. 

 b) If the sisfb is compiled into the kernel or insmod'ed _before_ X
starts, this problem does not occure.

 c) Always set the video memory to the maximum available. Low mem
situations are not handled well by DRM/DRI.

Now my list of "pleases":

A) Please test the driver and report the result to me. Always include
the corresponding part of the syslog and describe exactly what modes
with what depth you used and what you saw on the screen. Report's like
"I used your driver and I saw nothing" are completely useless.

B) Please report also _when_it_works_. I have no idea how many of you
actually use a SiS chipset so that's interesting to know either.

C) A final please: People _not_ using an LVDS bridge should also test
the code. As said, I tried not to touch anything not-LVDS-related, but
.. ya' never know...

Thomas

PS: Marcello/Linus: If you insist, I would make a patch as well.

PPS: After those five days I need to do something else. Like play Qu*ake
III ... on my SiS 630 :)

-- 
Thomas Winischhofer
Vienna/Austria
mailto:tw@webit.com              *** http://www.webit.com/tw
