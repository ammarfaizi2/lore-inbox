Return-Path: <linux-kernel-owner+w=401wt.eu-S932420AbXAGGUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbXAGGUL (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 01:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbXAGGUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 01:20:11 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:58548 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932420AbXAGGUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 01:20:09 -0500
Date: Sat, 6 Jan 2007 22:19:47 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: segher@kernel.crashing.org, akpm <akpm@osdl.org>
Subject: [PATCH] math-emu/setcc: avoid gcc extension
Message-Id: <20070106221947.8e01d404.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Brightmail-Tracker: AAAAAQAAAAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

setcc() in math-emu is written as a gcc extension statement expression
macro that returns a value.  However, it's not used that way and it's
not needed like that, so just make it a do-while non-extension macro
so that we don't use an extension when it's not needed.

All 4 .c files that use setcc() produce the same code after this patch.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 arch/i386/math-emu/status_w.h        |    5 +++--

---
 arch/i386/math-emu/status_w.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2620-rc2.orig/arch/i386/math-emu/status_w.h
+++ linux-2620-rc2/arch/i386/math-emu/status_w.h
@@ -48,9 +48,10 @@
 
 #define status_word() \
   ((partial_status & ~SW_Top & 0xffff) | ((top << SW_Top_Shift) & SW_Top))
-#define setcc(cc) ({ \
+#define setcc(cc) do { \
   partial_status &= ~(SW_C0|SW_C1|SW_C2|SW_C3); \
-  partial_status |= (cc) & (SW_C0|SW_C1|SW_C2|SW_C3); })
+  partial_status |= (cc) & (SW_C0|SW_C1|SW_C2|SW_C3); } \
+	while (0)
 
 #ifdef PECULIAR_486
    /* Default, this conveys no information, but an 80486 does it. */


---
