Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVCKBY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVCKBY4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 20:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbVCKBY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 20:24:56 -0500
Received: from ozlabs.org ([203.10.76.45]:27617 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261481AbVCKBYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 20:24:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
Date: Fri, 11 Mar 2005 12:24:54 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org, davej@redhat.com
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: AGP bogosities
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

I see that you did a cset -x on a changeset from Dave Jones that added
a bogus test for which AGP bridge a device is under.  That has left us
with code in agp_collect_device_status that will never find any device
(just take a look and you'll see).

In fact there are other bogosities in drivers/char/agp/generic.c.  I
can't believe Dave ever tested that code with an AGP 3.0 device.  If
you pass in a mode that has the AGP 3.0 bit set, agp_v3_parse_one()
will first clear that bit (and print a message), and then complain
because you haven't got that bit set in the mode, with a message that
the caller is broken.  Furthermore, if the mode passed in has both the
4x and 8x bits set, the new code will give you 4x where the old code
would give you 8x (which is what the caller wanted).

The patch below fixes these problems.  It will work in the 99.99% of
cases where we have one AGP bridge and one AGP video card.  We should
eventually cope with multiple AGP bridges, but doing the matching of
bridges to video cards is a hard problem because the video card is not
necessarily a child or sibling of the PCI device that we use for
controlling the AGP bridge.  I think we need to see an actual example
of a system with multiple AGP bridges first.

Oh, and by the way, I have 3D working relatively well on my G5 with a
64-bit kernel (and 32-bit X server and clients), which is why I care
about AGP 3.0 support. :)

Paul.

diff -urN linux-2.5/drivers/char/agp/agp.h g5-bad/drivers/char/agp/agp.h
--- linux-2.5/drivers/char/agp/agp.h	2005-03-07 14:01:44.000000000 +1100
+++ g5/drivers/char/agp/agp.h	2005-03-11 11:54:54.000000000 +1100
@@ -322,7 +322,7 @@
 #define AGPCTRL_GTLBEN		(1<<7)
 
 #define AGP2_RESERVED_MASK 0x00fffcc8
-#define AGP3_RESERVED_MASK 0x00ff00cc
+#define AGP3_RESERVED_MASK 0x00ff00c4
 
 #define AGP_ERRATA_FASTWRITES 1<<0
 #define AGP_ERRATA_SBA	 1<<1
diff -urN linux-2.5/drivers/char/agp/generic.c g5-bad/drivers/char/agp/generic.c
--- linux-2.5/drivers/char/agp/generic.c	2005-03-11 11:47:37.000000000 +1100
+++ g5/drivers/char/agp/generic.c	2005-03-11 12:08:29.000000000 +1100
@@ -515,13 +515,9 @@
 		printk (KERN_INFO PFX "%s tried to set rate=x0. Setting to AGP3 x4 mode.\n", current->comm);
 		*requested_mode |= AGPSTAT3_4X;
 	}
-	if (tmp == 3) {
-		printk (KERN_INFO PFX "%s tried to set rate=x3. Setting to AGP3 x4 mode.\n", current->comm);
-		*requested_mode |= AGPSTAT3_4X;
-	}
-	if (tmp >3) {
-		printk (KERN_INFO PFX "%s tried to set rate=x%d. Setting to AGP3 x8 mode.\n", current->comm, tmp);
-		*requested_mode |= AGPSTAT3_8X;
+	if (tmp >= 3) {
+		printk (KERN_INFO PFX "%s tried to set rate=x%d. Setting to AGP3 x8 mode.\n", current->comm, tmp * 4);
+		*requested_mode = (*requested_mode & ~7) | AGPSTAT3_8X;
 	}
 
 	/* ARQSZ - Set the value to the maximum one.
@@ -642,11 +638,6 @@
 			return 0;
 		}
 		cap_ptr = pci_find_capability(device, PCI_CAP_ID_AGP);
-		if (!cap_ptr) {
-			pci_dev_put(device);
-			continue;
-		}
-			cap_ptr = 0;
 	}
 
 	/*
