Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVCAAgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVCAAgJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 19:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVCAAeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 19:34:03 -0500
Received: from mailfe09.tele2.se ([212.247.155.1]:58033 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261157AbVCAAdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 19:33:17 -0500
X-T2-Posting-ID: icQHdNe7aEavrnKIz+aKnQ==
Subject: [PATCH] SELinux: Leak in error path
From: Alexander Nyberg <alexn@dsv.su.se>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jmorris@redhat.com, sds@epoch.ncsc.mil
Content-Type: text/plain
Date: Tue, 01 Mar 2005 01:32:52 +0100
Message-Id: <1109637172.3839.11.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's a leak here in the first error path.

Found by the Coverity tool.

Signed-off-by: Alexander Nyberg <alexn@dsv.su.se>

===== security/selinux/ss/conditional.c 1.3 vs edited =====
--- 1.3/security/selinux/ss/conditional.c	2005-01-05 03:48:22 +01:00
+++ edited/security/selinux/ss/conditional.c	2005-02-23 21:22:25 +01:00
@@ -401,8 +401,10 @@ static int cond_read_node(struct policyd
 		expr->expr_type = le32_to_cpu(buf[0]);
 		expr->bool = le32_to_cpu(buf[1]);
 
-		if (!expr_isvalid(p, expr))
+		if (!expr_isvalid(p, expr)) {
+			kfree(expr);
 			goto err;
+		}
 
 		if (i == 0) {
 			node->expr = expr;


