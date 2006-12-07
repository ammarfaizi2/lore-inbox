Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031839AbWLGIVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031839AbWLGIVM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 03:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031840AbWLGIVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 03:21:12 -0500
Received: from outbound0.mx.meer.net ([209.157.153.23]:1042 "EHLO
	outbound0.sv.meer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031839AbWLGIVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 03:21:11 -0500
Subject: [PATCH 4/5 -mm] fault-injection: optimize and simplify
	should_fail()
From: Don Mullis <dwm@meer.net>
To: akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Akinobu Mita <akinobu.mita@gmail.com>
In-Reply-To: <1165478812.2706.8.camel@localhost.localdomain>
References: <1165478812.2706.8.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 07 Dec 2006 00:21:06 -0800
Message-Id: <1165479666.2706.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial optimization and simplification of should_fail().

Do cheaper disqualification tests first (performance gain not quantified).
Simplify logic; eliminate goto.

Signed-off-by: Don Mullis <dwm@meer.net>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
---
 lib/fault-inject.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

Index: linux-2.6.18/lib/fault-inject.c
===================================================================
--- linux-2.6.18.orig/lib/fault-inject.c
+++ linux-2.6.18/lib/fault-inject.c
@@ -142,9 +142,6 @@ bool should_fail(struct fault_attr *attr
 	if (attr->task_filter && !fail_task(attr, current))
 		return false;
 
-	if (!fail_stacktrace(attr))
-		return false;
-
 	if (atomic_read(&attr->times) == 0)
 		return false;
 
@@ -159,12 +156,12 @@ bool should_fail(struct fault_attr *attr
 			return false;
 	}
 
-	if (attr->probability > random32() % 100)
-		goto fail;
+	if (attr->probability <= random32() % 100)
+		return false;
 
-	return false;
+	if (!fail_stacktrace(attr))
+		return false;
 
-fail:
 	fail_dump(attr);
 
 	if (atomic_read(&attr->times) != -1)


