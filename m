Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWGaH1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWGaH1c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 03:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWGaH1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 03:27:32 -0400
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:25248 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932151AbWGaH1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 03:27:31 -0400
Date: Mon, 31 Jul 2006 03:22:42 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] x86_64: fix is_at_popf() for compat tasks
To: Andi Kleen <ak@suse.de>
Cc: Albert Cahalan <acahalan@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200607310325_MC3-1-C691-D76B@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When testing for the REX instruction prefix, first check
for a 32-bit task because in compat mode the REX prefix is an
increment instruction.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

---

Compiled and booted but needs a test case...

--- 2.6.18-rc2-64.orig/arch/x86_64/kernel/ptrace.c
+++ 2.6.18-rc2-64/arch/x86_64/kernel/ptrace.c
@@ -141,8 +141,11 @@ static int is_at_popf(struct task_struct
 		case 0xf0: case 0xf2: case 0xf3:
 			continue;
 
-		/* REX prefixes */
 		case 0x40 ... 0x4f:
+			if (is_compat_task())
+				/* register increment */
+				return 0;
+			/* REX prefix */
 			continue;
 
 			/* CHECKME: f0, f2, f3 */
-- 
Chuck
