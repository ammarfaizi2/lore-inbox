Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVDZLJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVDZLJS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 07:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVDZLJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 07:09:18 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:51088 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261487AbVDZLIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 07:08:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17006.8479.605536.507619@cargo.ozlabs.ibm.com>
Date: Tue, 26 Apr 2005 21:08:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: benh@kernel.crashing.org, trini@kernel.crashing.org,
       kumar.gala@freescale.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc32: Fix address checking on lmw/stmw align exception
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The handling of misaligned load/store multiple instructions did not
check to see if the address was ok to access before using
__{get,put}_user().

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

---
diff -Nru a/arch/ppc/kernel/align.c b/arch/ppc/kernel/align.c
--- a/arch/ppc/kernel/align.c	2005-04-12 01:00:10 -05:00
+++ b/arch/ppc/kernel/align.c	2005-04-12 01:00:10 -05:00
@@ -290,6 +290,10 @@
 			/* lwm, stmw */
 			nb = (32 - reg) * 4;
 		}
+
+		if (!access_ok((flags & ST? VERIFY_WRITE: VERIFY_READ), addr, nb+nb0))
+			return -EFAULT;	/* bad address */
+
 		rptr = (unsigned char *) &regs->gpr[reg];
 		if (flags & LD) {
 			for (i = 0; i < nb; ++i)
