Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751798AbWJFE4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbWJFE4Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 00:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbWJFE4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 00:56:23 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:50357 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1751798AbWJFE4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 00:56:23 -0400
Subject: [PATCH 1/5] ioremap balanced with iounmap for drivers/char/epca.c
From: Amol Lad <amol@verismonetworks.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 10:27:05 +0530
Message-Id: <1160110625.19143.83.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ioremap must be balanced by an iounmap and failing to do so can result
in a memory leak.

Tested (compilation only):
- using allmodconfig
- making sure the files are compiling without any warning/error due to
new changes

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
 epca.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)
---
diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/drivers/char/epca.c linux-2.6.19-rc1/drivers/char/epca.c
--- linux-2.6.19-rc1-orig/drivers/char/epca.c	2006-10-05 14:00:42.000000000 +0530
+++ linux-2.6.19-rc1/drivers/char/epca.c	2006-10-05 14:50:00.000000000 +0530
@@ -1474,8 +1474,11 @@ static void post_fep_init(unsigned int c
 	if ((bd->type == PCXEVE || bd->type == PCXE) && (readw(memaddr + XEPORTS) < 3))
 		shrinkmem = 1;
 	if (bd->type < PCIXEM)
-		if (!request_region((int)bd->port, 4, board_desc[bd->type]))
+		if (!request_region((int)bd->port, 4, board_desc[bd->type])) {
+			iounmap(bd->re_map_membase);
+			bd->re_map_membase = NULL;
 			return;		
+		}
 	memwinon(bd, 0);
 
 	/*  --------------------------------------------------------------------


