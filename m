Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbUKPWAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUKPWAG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 17:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbUKPWAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 17:00:05 -0500
Received: from fmr24.intel.com ([143.183.121.16]:54950 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261851AbUKPVxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 16:53:11 -0500
Date: Tue, 16 Nov 2004 13:52:45 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: akpm@osdl.org
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, ak@suse.de
Subject: [PATCH] Remove data-header and code overlap in boot/setup.S 
Message-ID: <20041116135245.A7475@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bug:
The setup.S data and code is not cleanly separated. The current space 
reserved for setup header is not enough to fit the complete header. As a 
result, part of the header (EDDBUF) will overwrite the initial code.

I haven't seen any negative impact of this bug. As, by the time the setup 
code is overwritten, we would have finished executing it anyway. But, 
I think it is better to separate the header and code and prevent this 
data_overwriting_the_code condition.

The atatched patch adds some space in the header to fit all the data listed
in Documentation/i386/zero-page.txt for both i386 and x86_64 
(and updates zero-page.txt).

Signed-off-by:: "Venkatesh Pallipadi" <venkatesh.pallipadi@intel.com>

--- linux-2.6.10-rc1-bk22//arch/i386/boot/setup.S.org	2004-11-12 16:30:09.000000000 -0800
+++ linux-2.6.10-rc1-bk22//arch/i386/boot/setup.S	2004-11-12 17:46:42.000000000 -0800
@@ -162,7 +162,9 @@ ramdisk_max:	.long (-__PAGE_OFFSET-(512 
 					# the contents of an initrd
 
 trampoline:	call	start_of_setup
-		.space	1024
+		.align 16
+					# The offset at this point is 0x240
+		.space	(0x7ff-0x240+1) # E820 & EDD space (ending at 0x7ff)
 # End of setup header #####################################################
 
 start_of_setup:
--- linux-2.6.10-rc1-bk22//arch/x86_64/boot/setup.S.org	2004-11-12 17:40:56.000000000 -0800
+++ linux-2.6.10-rc1-bk22//arch/x86_64/boot/setup.S	2004-11-12 17:47:59.000000000 -0800
@@ -158,7 +158,9 @@ cmd_line_ptr:	.long 0			# (Header versio
 ramdisk_max:	.long 0xffffffff
 	
 trampoline:	call	start_of_setup
-		.space	1024
+		.align 16
+					# The offset at this point is 0x240
+		.space  (0x7ff-0x240+1)	# E820 & EDD space (ending at 0x7ff)
 # End of setup header #####################################################
 
 start_of_setup:
--- linux-2.6.10-rc1-bk22//Documentation/i386/zero-page.txt.org	2004-11-12 13:46:22.000000000 -0800
+++ linux-2.6.10-rc1-bk22//Documentation/i386/zero-page.txt	2004-11-12 17:48:54.000000000 -0800
@@ -74,6 +74,10 @@ Offset	Type		Description
 0x21c	unsigned long	INITRD_SIZE, size in bytes of ramdisk image
 0x220	4 bytes		(setup.S)
 0x224	unsigned short	setup.S heap end pointer
+0x226   unsigned short	zero_pad
+0x228   unsigned long	cmd_line_ptr
+0x22c   unsigned long	ramdisk_max
+0x230   16 bytes 	trampoline
 0x290 - 0x2cf		EDD_MBR_SIG_BUFFER (edd.S)
 0x2d0 - 0x600		E820MAP
 0x600 - 0x7ff		EDDBUF (edd.S) for disk signature read sector
