Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312573AbSDSUVs>; Fri, 19 Apr 2002 16:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312586AbSDSUVr>; Fri, 19 Apr 2002 16:21:47 -0400
Received: from ausxc10.us.dell.com ([143.166.98.229]:23571 "EHLO
	ausxc10.us.dell.com") by vger.kernel.org with ESMTP
	id <S312573AbSDSUVr>; Fri, 19 Apr 2002 16:21:47 -0400
Message-ID: <7425061BF9693F4F8C74BA48F43856900DD5A2@AUSXMPS310.aus.amer.dell.com>
From: Robert_Hentosh@Dell.com
To: linux-kernel@vger.kernel.org
Cc: johnsonm@redhat.com, alan@redhat.com, arjanv@redhat.com
Subject: [PATCH] reboot=bios is invalidating cache incorrectly
Date: Fri, 19 Apr 2002 15:21:39 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When specifying the kernel parameter reboot=bios the assembly code that is
executed to switch to real mode and call the bios vector contains an error.
This causes rebooting via bios to hang in certain conditions.

The hand assembled routine contained in the array "real_mode_switch"
contains INVD which invalidates the CPU caches, unfortunately the routine
was just previously copied via memcpy and is contained in the cache. This
leads to unexpected results. The following patch replaces INVD with WBINVD
which will make sure that the routine is written to RAM before invalidating
the cache, providing more reliable reboots.

This patch applies cleanly to 2.4.18 and 2.5.8.  It probably also works with
all 2.2.X, 2.4.X and 2.5.X kernels.

This fixes a long standing bug that prevented reliable reboots on some
platforms.


Regards,
Robert Hentosh


--
Robert Hentosh
Sr. Software Engineer
Dell Linux Solutions www.dell.com/linux


--- linux-2.4.18.orig/arch/i386/kernel/process.c	Fri Apr 19 14:37:21
2002
+++ linux-2.4.18/arch/i386/kernel/process.c	Fri Apr 19 14:41:11 2002
@@ -253,7 +253,7 @@
 	0x66, 0x0f, 0x20, 0xc3,			/*    movl  %cr0,%ebx
*/
 	0x66, 0x81, 0xe3, 0x00, 0x00, 0x00, 0x60,	/*    andl
$0x60000000,%ebx */
 	0x74, 0x02,				/*    jz    f
*/
-	0x0f, 0x08,				/*    invd
*/
+	0x0f, 0x09,				/*    wbinvd
*/
 	0x24, 0x10,				/* f: andb  $0x10,al
*/
 	0x66, 0x0f, 0x22, 0xc0			/*    movl  %eax,%cr0
*/
 };
