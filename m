Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWHJUGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWHJUGk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbWHJUE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:04:26 -0400
Received: from cantor.suse.de ([195.135.220.2]:57744 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932637AbWHJTgl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:41 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [83/145] x86_64: fix is_at_popf() for compat tasks
Message-Id: <20060810193640.19AB513C22@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:40 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Chuck Ebbert <76306.1226@compuserve.com>

When testing for the REX instruction prefix, first check
for 32-bit mode because in compat mode the REX prefix is an
increment instruction.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/ptrace.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

Index: linux/arch/x86_64/kernel/ptrace.c
===================================================================
--- linux.orig/arch/x86_64/kernel/ptrace.c
+++ linux/arch/x86_64/kernel/ptrace.c
@@ -141,8 +141,11 @@ static int is_at_popf(struct task_struct
 		case 0xf0: case 0xf2: case 0xf3:
 			continue;
 
-		/* REX prefixes */
 		case 0x40 ... 0x4f:
+			if (regs->cs != __USER_CS)
+				/* 32-bit mode: register increment */
+				return 0;
+			/* 64-bit mode: REX prefix */
 			continue;
 
 			/* CHECKME: f0, f2, f3 */
