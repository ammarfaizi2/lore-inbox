Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129145AbQKXSbM>; Fri, 24 Nov 2000 13:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129231AbQKXSbD>; Fri, 24 Nov 2000 13:31:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1552 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S129145AbQKXSay>;
        Fri, 24 Nov 2000 13:30:54 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011241756.eAOHutB16267@flint.arm.linux.org.uk>
Subject: Recent patch to cfi.h screws MTD CFI layer
To: linux-kernel@vger.kernel.org
Date: Fri, 24 Nov 2000 17:56:54 +0000 (GMT)
Cc: dwmw2@redhat.com
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The recent patch in 2.4.0-test11 causes MTD to oops the kernel:

diff -u --recursive --new-file v2.4.0-test10/linux/include/linux/mtd/cfi.h linux/include/linux/mtd/cfi.
h
--- v2.4.0-test10/linux/include/linux/mtd/cfi.h Tue Jul  4 10:12:34 2000
+++ linux/include/linux/mtd/cfi.h       Tue Nov  7 10:46:04 2000
@@ -92,6 +92,7 @@
        int numchips;
        unsigned long chipshift; /* Because they're of the same type */
        struct flchip chips[0];  /* per-chip data structure for each chip */
+       const char *im_name;     /* inter_module name for cmdset_setup */
 };

 #define MAX_CFI_CHIPS 8 /* Entirely arbitrary to avoid realloc() */

This is what happens to chips[].start during initialisation:

chip 0 start 0
chip 1 start 800000
chip 2 start 1000000
chip 3 start 1800000
 Intel/Sharp Extended Query Table at 0x0031
chip 0 start c013b45c		<--- overwritten by write to im_name
chip 1 start 800000
chip 2 start 1000000
chip 3 start 1800000
chip 0 start c013b45c
chip 1 start 800000
chip 2 start 1000000
chip 3 start 1800000
number of CFI chips: 4
chip 0 start c013b45c
chip 1 start 800000
chip 2 start 1000000
chip 3 start 1800000

Here is a patch that fixes the problem, and includes a warning to tell
people not to add extra fields after the "chips" element.

--- linux.orig/include/linux/mtd/cfi.h	Sat Nov 18 21:54:02 2000
+++ linux/include/linux/mtd/cfi.h	Fri Nov 24 17:57:06 2000
@@ -209,8 +209,9 @@
 				  must be of the same type. */
 	int numchips;
 	unsigned long chipshift; /* Because they're of the same type */
-	struct flchip chips[0];  /* per-chip data structure for each chip */
 	const char *im_name;	 /* inter_module name for cmdset_setup */
+	struct flchip chips[0];  /* per-chip data structure for each chip */
+	/* do not add extra fields after "chips" */
 };
 
 #define MAX_CFI_CHIPS 8 /* Entirely arbitrary to avoid realloc() */

   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
