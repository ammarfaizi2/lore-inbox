Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbVK3Rfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbVK3Rfs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 12:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbVK3RfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 12:35:07 -0500
Received: from 81-179-233-34.dsl.pipex.com ([81.179.233.34]:34511 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751483AbVK3RfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 12:35:04 -0500
Date: Wed, 30 Nov 2005 17:34:50 +0000
To: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>,
       linuxppc64-dev@ozlabs.org, Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 1/2] powerpc powermac adb fix dependancy on btext_drawchar
Message-ID: <20051130173450.GA851@shadowen.org>
References: <exportbomb.1133372080@pinky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <exportbomb.1133372080@pinky>
User-Agent: Mutt/1.5.9i
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

powerpc: powermac, adb fix dependancy on btext_drawchar

udbg_adb_init() has become dependant on btext_drawchar, even when
BOOTX_TEXT support is not selected.  This leads to the error below.
Make the check dependant on BOOTX_TEXT.

      LD      .tmp_vmlinux1
    arch/powerpc/platforms/built-in.o(.toc1+0xa40): undefined
					reference to `btext_drawchar'

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff -upN reference/arch/powerpc/platforms/powermac/udbg_adb.c current/arch/powerpc/platforms/powermac/udbg_adb.c
--- reference/arch/powerpc/platforms/powermac/udbg_adb.c
+++ current/arch/powerpc/platforms/powermac/udbg_adb.c
@@ -171,9 +171,12 @@ int udbg_adb_init(int force_btext)
 	udbg_adb_old_getc_poll = udbg_getc_poll;
 
 	/* Check if our early init was already called */
-	if (udbg_adb_old_putc == udbg_adb_putc ||
-	    udbg_adb_old_putc == btext_drawchar)
+	if (udbg_adb_old_putc == udbg_adb_putc)
 		udbg_adb_old_putc = NULL;
+#ifdef CONFIG_BOOTX_TEXT
+	if (udbg_adb_old_putc == btext_drawchar)
+		udbg_adb_old_putc = NULL;
+#endif
 
 	/* Set ours as output */
 	udbg_putc = udbg_adb_putc;
