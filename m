Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbVDWVXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbVDWVXZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 17:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVDWVXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 17:23:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:25043 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261786AbVDWVWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 17:22:54 -0400
Date: Sat, 23 Apr 2005 14:22:20 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB bugfixes for 2.6.12-rc3
Message-ID: <20050423212220.GA20189@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hm, my tools are getting better, so here's an almost automated merge
email...

Here are a number of USB bugfixes for 2.6.12-rc3.  They include the big
build problem that everyone is noticing in the usb scanner driver, along
with a number of other things.  Almost all of these patches have been in
the past few -mm releases.

Pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

Diffstat is below, along with the long changelog entry.  I hope someone
is working on fixing up the "shortlog" tool for the new format of these
changelog messages (if not, I'll attack it next week.)

Full patches will be sent to the linux-usb-devel mailing list, if anyone
wants to see them.

thanks,

greg k-h

 drivers/usb/core/usb.c              |    6 
 drivers/usb/image/microtek.c        |    2 
 drivers/usb/input/ati_remote.c      |    2 
 drivers/usb/input/usbkbd.c          |    3 
 drivers/usb/media/pwc/pwc-ctrl.c    |   78 +++---
 drivers/usb/media/pwc/pwc-if.c      |    2 
 drivers/usb/media/pwc/pwc.h         |    6 
 drivers/usb/media/sn9c102_core.c    |    4 
 drivers/usb/media/sn9c102_sensor.h  |    2 
 drivers/usb/misc/sisusbvga/sisusb.c |    1 
 drivers/usb/net/usbnet.c            |  427 ++++++++++++++++++++++--------------
 drivers/usb/net/zd1201.c            |   20 -
 drivers/usb/serial/Kconfig          |    9 
 drivers/usb/serial/Makefile         |    1 
 drivers/usb/serial/hp4x.c           |  111 ++++++++-
 drivers/usb/storage/unusual_devs.h  |   22 +
 scripts/mod/file2alias.c            |  111 +++++++--
 17 files changed, 547 insertions(+), 260 deletions(-)

--------------------------

commit 9719b0c298bd6a4a608843dc989a5f94cd0a7c13
tree 72abe7e0dd4b4135ca8b2d6f4e7cb81bd173a437
parent f3fae6ed6aafe71826e03876ad3d4e1d3f238ec8
author Patrick Boettcher <patrick.boettcher@desy.de> Sun, 24 Apr 2005 03:16:15 -0700
committer Greg KH <gregkh@suse.de> Sun, 24 Apr 2005 03:16:15 -0700

[PATCH] USB: Fix for ati_remote

when stealing code from ati_remote for a GPL-driver of my usbradio (because of
its neat usb int transfers) I found out, that the inbuf is freed twice.

I don't have the ati-remote, so I don't know it is a problem at all, but it
looks strange to me anyway. Also I don't know if it has been fixed already in
newer kernel versions.


From: Patrick Boettcher <patrick.boettcher@desy.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


--------------------------
commit f3fae6ed6aafe71826e03876ad3d4e1d3f238ec8
tree 9c85c51031ae67ef9e8448a57ba4037d95899ccc
parent 7ea13c9c0e40d24c5f45a3a6bee8a2a39bfb1df4
author David Brownell <david-b@pacbell.net> Sat, 23 Apr 2005 05:07:02 -0700
committer Greg KH <gregkh@suse.de> Sat, 23 Apr 2005 05:07:02 -0700

[PATCH] USB: better usbnet zaurus/mdlm/... fix

This is a somewhat more comprehensive fix for the problem of devices
like the newer Zaurii ... or in this case some Motorola cell phones.

To recap, the problem's root cause is that these devices aren't using
standard USB class specifications for their network links, and so far
we've had to add lots of device-specific driver entries.  The vendor
fix abuses the CDC MDLM descriptors (they _could_ have conformed to
the spec, but didn't) and defines a "Belcarra firmware" pseudo-class.

This patch recognizes that pseudo-class by the GUIDs in those descriptors,
and handles the devices that just use the Zaurus framing.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


--------------------------
commit 7ea13c9c0e40d24c5f45a3a6bee8a2a39bfb1df4
tree b8a64ad2f988b45cc9183d07cbfe33432c03be20
parent fb3b4ebc0be618dbcc2326482a83c920d51af7de
author David Hollis <dhollis@davehollis.com> Sat, 23 Apr 2005 05:07:02 -0700
committer Greg KH <gregkh@suse.de> Sat, 23 Apr 2005 05:07:02 -0700

[PATCH] usbnet: Convert ASIX code to use new status infrastructure

Modify the ASIX USB Ethernet code to make use of the new status
infrastructure in usbnet.

Additionally, add a link_reset() handler to the struct usbnet
structure to provide a generic means for a driver to perform link
reset tasks such as a determining link speed and setting
device flags accordingly.


Signed-off-by: David Hollis <dhollis@davehollis.com>
Acked-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>



--------------------------
commit fb3b4ebc0be618dbcc2326482a83c920d51af7de
tree e0b4c9bc6eacf08028041e3f7c25adb3e9638a00
parent b19dcd9341a81ff6e04fcec396f77eeb91570584
author Roman Kagan <rkagan@mail.ru> Sat, 23 Apr 2005 05:07:01 -0700
committer Greg KH <gregkh@suse.de> Sat, 23 Apr 2005 05:07:01 -0700

[PATCH] USB: MODALIAS change for bcdDevice

The patch below adjusts the MODALIAS generated by the usb hotplug
function to match the proposed change to scripts/mod/file2alias.c.

Signed-off-by: Roman Kagan <rkagan@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>



--------------------------
commit b19dcd9341a81ff6e04fcec396f77eeb91570584
tree f2eebbf7142d5d36ffb44d365ad3eca539ff5127
parent 2e0a6b8cd27375089f8356e7f1ce2319059696eb
author Roman Kagan <rkagan@mail.ru> Sat, 23 Apr 2005 05:07:01 -0700
committer Greg KH <gregkh@suse.de> Sat, 23 Apr 2005 05:07:01 -0700

[PATCH] USB: scripts/mod/file2alias.c: handle numeric ranges for USB bcdDevice

Another attempt at that...

The attached patch fixes the longstanding problem with USB bcdDevice
numeric ranges incorrectly converted into patterns for MODULE_ALIAS
generation.  Previously it put both the lower and the upper limits into
the pattern, dlXdhY, making it impossible to fnmatch against except for
a few special cases, like dl*dh* or dlXdhX.

The patch makes it generate multiple MODULE_ALIAS lines covering the
whole range with fnmatch-able patterns.  E.g. for a range between 0x0001
and 0x8345 it gives the following patterns:

000[1-9]
00[1-9]*
0[1-9]*
[1-7]*
8[0-2]*
83[0-3]*
834[0-5]

Since bcdDevice is 2 bytes wide = 4 digits in hex representation, the
max no. of patters is 2 * 4 - 1 = 7.

The values are BCD (binary-coded decimals) and not hex, so patterns
using a dash seem to be safe regardless of locale collation order.

The patch changes bcdDevice part of the alias from dlXdhY to dZ, but
this shouldn't have big compatibility issues because fnmatch()-based
modprobing hasn't yet been widely used.  Besides, the most common (and
almost the only working) case of dl*dh* becomes d* and thus continues to
work.

The patch is against 2.6.12-rc2, applies to -mm3 with an offset.  The
matching patch to fix the MODALIAS environment variable now generated by
the usb hotplug function follows.

Signed-off-by: Roman Kagan <rkagan@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>



--------------------------
commit 2e0a6b8cd27375089f8356e7f1ce2319059696eb
tree 958f2dd42626fd18ba5f85b7bab1eb4a7680ff75
parent 2c47e7f37830cc83e7c77f0d5b7d4ac15105475b
author Adrian Bunk <bunk@stusta.de> Sat, 23 Apr 2005 05:07:01 -0700
committer Greg KH <gregkh@suse.de> Sat, 23 Apr 2005 05:07:01 -0700

[PATCH] USB: drivers/usb/net/zd1201.c: make some code static

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>



--------------------------
commit be5e3383a95446e933be198d3025df10a072794b
tree 1bd89cd23ee98127f08ccd076f4485a2e8138df7
parent cef11127ea59cc5ac8fb956c355727999c6796dc
author Adrian Bunk <bunk@stusta.de> Sat, 23 Apr 2005 05:07:00 -0700
committer Greg KH <gregkh@suse.de> Sat, 23 Apr 2005 05:07:00 -0700

[PATCH] USB: drivers/usb/input/usbkbd.c: make a function static

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


--------------------------
commit 7107627b04b46bce8212e6a6811add5eb8bcb476
tree 494ce4cfa89021907ce4e212a4a768aace5a3584
parent be5e3383a95446e933be198d3025df10a072794b
author Adrian Bunk <bunk@stusta.de> Sat, 23 Apr 2005 05:07:00 -0700
committer Greg KH <gregkh@suse.de> Sat, 23 Apr 2005 05:07:00 -0700

[PATCH] USB: drivers/usb/media/sn9c102_core.c: make 2 functions static

This patch makes two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>



--------------------------
commit 2c47e7f37830cc83e7c77f0d5b7d4ac15105475b
tree 051be37e98b7f5a1fe590818c1044ea3aac3f42a
parent 7107627b04b46bce8212e6a6811add5eb8bcb476
author Adrian Bunk <bunk@stusta.de> Sat, 23 Apr 2005 05:07:00 -0700
committer Greg KH <gregkh@suse.de> Sat, 23 Apr 2005 05:07:00 -0700

[PATCH] USB: drivers/usb/media/pwc/: make code static

This patch makes needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>



--------------------------
commit cef11127ea59cc5ac8fb956c355727999c6796dc
tree 349a6201e2acbac49d9f87e0ee102c031bab2e16
parent 35ecc486a3f1811b85b7b22196b8b7422d713b51
author Thomas Winischhofer <thomas@winischhofer.net> Sat, 23 Apr 2005 05:06:59 -0700
committer Greg KH <gregkh@suse.de> Sat, 23 Apr 2005 05:06:59 -0700

[PATCH] USB: new SiS device id

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


--------------------------
commit 36045fb77cb8b4043063ea54067907a1afd317b4
tree f997f900af829aeb155ee74fe7b187bd9c7cbce1
parent 35f4a0c4416b4fd789f94328dc5940e79e1507b0
author Arthur Huillet <arthur.huillet@agoctrl.org> Sat, 23 Apr 2005 05:06:59 -0700
committer Greg KH <gregkh@suse.de> Sat, 23 Apr 2005 05:06:59 -0700

[PATCH] USB: add HP49G+ Calculator USB Serial support

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


--------------------------
commit 35ecc486a3f1811b85b7b22196b8b7422d713b51
tree fc0c453f6a02b8c36ca49e337c55864832b04128
parent 36045fb77cb8b4043063ea54067907a1afd317b4
author Greg KH <gregkh@suse.de> Sat, 23 Apr 2005 05:06:59 -0700
committer Greg KH <gregkh@suse.de> Sat, 23 Apr 2005 05:06:59 -0700

[PATCH] USB: fix up the HP49G+ Calculator USB Serial driver

Fix compiler warnings, and remove unneeded #includes

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


--------------------------
commit 35f4a0c4416b4fd789f94328dc5940e79e1507b0
tree 3e581a7766d64b3c067a11371da7870f0795e0a2
parent 275cfdf412aee2367883b6cd764e06c07bd37a79
author Sven Anderson <sven@anderson.de> Sat, 23 Apr 2005 05:06:58 -0700
committer Greg KH <gregkh@suse.de> Sat, 23 Apr 2005 05:06:58 -0700

[PATCH] USB: clean up all iPod models in unusual_devs.h

Phil Dibowitz wrote:
> 1. You're adding product IDs 1202, 1203, 1204, and 1205. 1203 was
> already there, but you remove it, OK, but 1205 is already there, so
> you'll need to fix that.

I was not removing 1203, it's just the extension of the bcd range. You are 
right about 1205, as I wrote, it was a patch against 2.6.11.7. Attached is 
a patch against 2.6.12-rc2.

> 2. I'm OK with the full bcd range if Apple is changing it on firmware
> revs... fine, but it's bcd, not hex... 0x9999 =)

I just copied from other entries. There're a lot 0xffffs in unusual_dev.h, 
so I assumed it is correct. I changed it to 0x9999.

> 3. It's rather obnoxious to take the original submitter's credit away.

I didn't remove it, I changed it to "based on...". Because I changed 
something (the range) in his entry, I thought it is the best to take the 
responsibility but keep the origin. Anyway, in the new patch I did it in a 
different way.

> 4. Your /proc/bus/usb/devices shows 1204, but I see no evidence 1202 is
> really an iPod.

I don't have an old iPod mini, but you find a lot of evidence here:

http://www.google.com/search?q=0x1202+ipod

Especially this one:

http://www.qbik.ch/usb/devices/showdescr.php?id=2737

> It also looks like 1205's entry is getting mangled, but I haven't
> attempted to apply the patch, so I'm not sure.

No, the patch was ok, but I agree it looks strange. It's not very 
readable, because I cannot tell diff to work blockwise instead of 
linewise. Because of the similarity of the entries, diff splits and merges 
them. Anyway, the new patch "looks" better. ;-)

Signed-off-by: Sven Anderson <sven-linux@anderson.de>
Signed-off-by: Phil Dibowitz <phil@ipom.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>




--------------------------
commit 275cfdf412aee2367883b6cd764e06c07bd37a79
tree 5f8d84c637125859001957cd72de85870e11628a
parent efab7739d99eae948971140b2aa3dddf7f72c900
author Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org> Sat, 23 Apr 2005 05:06:58 -0700
committer Greg KH <gregkh@suse.de> Sat, 23 Apr 2005 05:06:58 -0700

[PATCH] USB: compilation failure on usb/image/microtek.c

maybe typo?

Signed-off-by: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


--------------------------
