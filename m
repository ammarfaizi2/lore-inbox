Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312586AbSDSWAP>; Fri, 19 Apr 2002 18:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313070AbSDSWAN>; Fri, 19 Apr 2002 18:00:13 -0400
Received: from smtp5.us.dell.com ([143.166.83.100]:34480 "EHLO
	smtp5.us.dell.com") by vger.kernel.org with ESMTP
	id <S312586AbSDSWAM>; Fri, 19 Apr 2002 18:00:12 -0400
Date: Fri, 19 Apr 2002 17:00:11 -0500 (CDT)
From: Robert Hentosh <robert@dell.com>
X-X-Sender: robert@humbolt.us.dell.com
Reply-To: Robert_Hentosh@dell.com
To: linux-kernel@vger.kernel.org
cc: johnsonm@redhat.com, <alan@redhat.com>, <arjanv@redhat.com>
Subject: [PATCH] reboot=bios is invalidating cache incorrectly
Message-ID: <Pine.LNX.4.44.0204191651160.32269-100000@humbolt.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry for the trashed email and patch.  Apparently Outlook knows better 
than I where to do word wrapping on patches.

Here it is again from pine.



When specifying the kernel parameter reboot=bios the assembly code that is 
executed to switch to real mode and call the bios vector contains an 
error.  This causes rebooting via bios to hang in certain conditions.

The hand assembled routine contained in the array "real_mode_switch" 
contains INVD which invalidates the CPU caches, unfortunately the routine 
was just previously copied via memcpy and is contained in the cache.  This 
leads to unexpected results.  The following patch replaces INVD with 
WBINVD which will insure that the routine is written to RAM before 
invalidating the cache, providing more reliable reboots.

This patch applies cleanly to 2.4.18 and 2.5.8.  It probably also works 
with all 2.2.x, 2.4.x and 2.5.x kernels.

This fixes a long standing bug that prevented reliable reboots on some 
platforms.


Regards,
Robert Hentosh


--
Robert Hentosh
Sr. Software Engineer
Dell Linux Solutions www.dell.com/linux


--- linux-2.4.18.orig/arch/i386/kernel/process.c	Fri Apr 19 14:37:21 2002
+++ linux-2.4.18/arch/i386/kernel/process.c	Fri Apr 19 14:41:11 2002
@@ -253,7 +253,7 @@
 	0x66, 0x0f, 0x20, 0xc3,			/*    movl  %cr0,%ebx        */
 	0x66, 0x81, 0xe3, 0x00, 0x00, 0x00, 0x60,	/*    andl  $0x60000000,%ebx */
 	0x74, 0x02,				/*    jz    f                */
-	0x0f, 0x08,				/*    invd                   */
+	0x0f, 0x09,				/*    wbinvd                 */
 	0x24, 0x10,				/* f: andb  $0x10,al         */
 	0x66, 0x0f, 0x22, 0xc0			/*    movl  %eax,%cr0        */
 };


