Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266309AbUFPVca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266309AbUFPVca (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 17:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266311AbUFPVca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 17:32:30 -0400
Received: from mail.dif.dk ([193.138.115.101]:13476 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S266309AbUFPVcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 17:32:06 -0400
Date: Wed, 16 Jun 2004 23:31:13 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] check_/request_region fixes & request for enlightenment
Message-ID: <Pine.LNX.4.56.0406162245320.11954@jjulnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Trying to get rid of the last few users of the deprecated check_region and
replace with request_region.

I've picked two initial targets that looked resonably simple to fix-up,
and I think I grok request_region to a resonable degree, but I'd like some
confirmation that my understanding is correct before handling the
remaining cases. So if someone could read the following + the patches and
comment I'd appreciate it.

As I understand it check_region was originally used to see if a IO port
range was already in use and returned zero if it was free, non-zero if in
use. if check_region indicated that a region was free to use it could the
safely be allocated with request_region. release_region is subsequently
used to free a previously acquired region when it's no longer needed.
I assume the reason to merge the check & request bits where that if a
piece of code got preempted between the two calls then the request_region
could fail on a region the code thought was available. So now
request_region is called to both verify the region is available and lock
it at the same time and the return value of request_region can then be
tested for success or failure.
Is my understanding of that correct?

Assuming I got the above right I attempted to fix-up the following two
uses of check_region :
drivers/cdrom/isp16.c:124: warning: `check_region' is deprecated (declared at include/linux/ioport.h:121)
drivers/ide/pci/trm290.c:376: warning: `check_region' is deprecated (declared at include/linux/ioport.h:121)

in the isp16.c case the region is free'ed in isp16_exit(), but one thing I
don't understand is is I'm supposed to preserve the pointer returned by
request_region and later pass that to release_region as well to make sure
the right resource is free'ed? I see __release_region() taking 3
parameters, but the release_region #define only takes two??? Could someone
explain to me how that works?
For now I assumed the current release_region in isp16_exit() is OK, and
the code compiles fine with my changes, but I can't test it since I don't
have the hardware.
Here's the patch against 2.6.7 for that file - comments are very welcome :

--- linux-2.6.7-orig/drivers/cdrom/isp16.c	2004-06-16 07:20:04.000000000 +0200
+++ linux-2.6.7/drivers/cdrom/isp16.c	2004-06-16 22:36:52.000000000 +0200
@@ -121,7 +121,7 @@ int __init isp16_init(void)
 		return (0);
 	}

-	if (check_region(ISP16_IO_BASE, ISP16_IO_SIZE)) {
+	if (!request_region(ISP16_IO_BASE, ISP16_IO_SIZE, "isp16")) {
 		printk("ISP16: i/o ports already in use.\n");
 		return (-EIO);
 	}


Now, in trm290.c it seems that the region it tries to access is already
requested in probe_hwif() in ide-probe.c, so the check_region is only used
as an extra check to print an error message.  I see no code in trm290.c
that ever tries to release the region, is that wrong, or does it simply
rely on the code in ide-probe.c to release the region for it?
How can it be that the check_region doesn't always fail if it has already
been locked in ide-probe.c ?  And if it doesn't always fail, shouldn't the
driver release it itself right after doing it's check (now) with
request_region?

Here's what I came up with initially - just replacing check_region with
request_region - but I have a feeling it's not that simple.
Would anyone care to clarify?

--- linux-2.6.7-orig/drivers/ide/pci/trm290.c	2004-06-16 07:19:01.000000000 +0200
+++ linux-2.6.7/drivers/ide/pci/trm290.c	2004-06-16 22:57:24.000000000 +0200
@@ -373,12 +373,12 @@ void __devinit init_hwif_trm290(ide_hwif
 			/* leave lower 10 bits untouched */
 			compat += (next_offset += 0x400);
 #  if 1
-			if (check_region(compat + 2, 1))
-				printk(KERN_ERR "%s: check_region failure at 0x%04x\n",
+			if (!request_region(compat + 2, 1, "trm290"))
+				printk(KERN_ERR "%s: request_region failure at 0x%04x\n",
 					hwif->name, (compat + 2));
 			/*
 			 * The region check is not needed; however.........
-			 * Since this is the checked in ide-probe.c,
+			 * Since this is checked in ide-probe.c,
 			 * this is only an assignment.
 			 */
 #  endif


I've been digging for a while looking for some documentation on this, but
found nothing more than brief mentions about it in Documentation/
Searching lkml archives and reading the
check_region/request_region code provided enough info to give me the
understanding I described above, but if someone has knowledge of some
documentation/explanation on this I'd love a pointer so I can read up.


--
Jesper Juhl <juhl-lkml@dif.dk>

