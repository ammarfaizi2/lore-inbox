Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVABUNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVABUNX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 15:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVABUNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 15:13:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:59840 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261314AbVABUMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 15:12:08 -0500
Date: Sun, 2 Jan 2005 12:11:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Georg C. F. Greve" <greve@fsfeurope.org>,
       Hans Ulrich Niedermann <vserver@n-dimensional.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Herbert Poetzl <herbert@13thfloor.at>, Nick Warne <nick@linicks.net>,
       Len Brown <len.brown@intel.com>
Subject: Re: PROBLEM: Kernel 2.6.10 crashing repeatedly and hard
In-Reply-To: <m3zmzvl9x1.fsf@reason.gnu-hamburg>
Message-ID: <Pine.LNX.4.58.0501021147260.2280@ppc970.osdl.org>
References: <m3is6k4oeu.fsf@reason.gnu-hamburg> <Pine.LNX.4.58.0412301239160.22893@ppc970.osdl.org>
 <m3zmzvl9x1.fsf@reason.gnu-hamburg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I think I chased this one down. Very nasty indeed, and the only reason I
was able to find it was pure luck: I just happened to be able to reproduce
the problem on a laptop (but not on my main machine, or indeed, any other
machine I had access to).

Even so, it took thousands of reboots to pinpoint it (I'm not kidding, I
had the thing auto-reboot until it would crash or until I decided some
configuration was crash-proof, and thank God for fast reboot times).

If your problem is the same thing, then it's due to ACPI video enumeration
overwriting an adjacent slab entry at bootup, and depending on just what
happened to follow it it might be harmless or it might totally destroy the
slab cache data structures.

I'll hereby ask the ACPI people to verify whether this was the only such
allocation problem in ACPI - it's a stupid lack of allocation for the
final terminating entry, and maybe other instances of this exist (and I
just found one of them).

As far as I can tell, this bug would only trigger if ACPI Video reported
exactly four (possibly eight, but that is getting very unlikely) video
heads, since anything else would have enough padding in the allocation
that it wouldn't matter that it allocated too little. Again, just pure
luck that I happened to have something that fit that criteria.

DaveJ: this may explain the "Mobile Radeon" reports. Not because of
anything Radeon-specific, but simply because they'd have four ports (CRT,
LVDS TFT panel, tv-out, and tv-in, I think - ACPI doesn't tell me enough
to be sure).

Of course, there might be another independent bug, so there's nothing to
say that this will fix what others are seeing...

Patch appended, and also pushed out to the BK trees.

			Linus

----
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/01/02 11:45:13-08:00 torvalds@evo.osdl.org 
#   acpi video device enumeration: fix incorrect device list allocation
#   
#   It didn't allocate space for the final terminating entry,
#   which caused it to overwrite the next slab entry, which in turn
#   sometimes ended up being a slab array cache pointer. End result:
#   total slab cache corruption at a random time afterwards. Very
#   nasty.
# 
# drivers/acpi/video.c
#   2005/01/02 11:45:03-08:00 torvalds@evo.osdl.org +1 -1
#   acpi video device enumeration: fix incorrect device list allocation
#   
#   It didn't allocate space for the final terminating entry,
#   which caused it to overwrite the next slab entry, which in turn
#   sometimes ended up being a slab array cache pointer. End result:
#   total slab cache corruption at a random time afterwards. Very
#   nasty.
# 
diff -Nru a/drivers/acpi/video.c b/drivers/acpi/video.c
--- a/drivers/acpi/video.c	2005-01-02 12:10:23 -08:00
+++ b/drivers/acpi/video.c	2005-01-02 12:10:23 -08:00
@@ -1524,7 +1524,7 @@
 		dod->package.count));
 
 	active_device_list= kmalloc(
- 		dod->package.count*sizeof(struct acpi_video_enumerated_device),
+ 		(1+dod->package.count)*sizeof(struct acpi_video_enumerated_device),
 	       	GFP_KERNEL);
 
 	if (!active_device_list) {
