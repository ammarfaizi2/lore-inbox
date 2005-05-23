Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVEWXpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVEWXpI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 19:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVEWXbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 19:31:38 -0400
Received: from fire.osdl.org ([65.172.181.4]:51078 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261151AbVEWXak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 19:30:40 -0400
Date: Mon, 23 May 2005 16:30:02 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, ak@suse.de
Subject: [patch 13/16] x86_64: Fix canonical checking for segment registers in ptrace
Message-ID: <20050523233002.GY27549@shell0.pdx.osdl.net>
References: <20050523231529.GL27549@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050523231529.GL27549@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] x86_64: Fix canonical checking for segment registers in ptrace

Allowed user programs to set a non canonical segment base, which would cause
oopses in the kernel later.

Credit-to: Alexander Nyberg <alexn@dsv.su.se>

 For identifying and reporting this bug.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---

 ptrace.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

Index: release-2.6.11/arch/x86_64/kernel/ptrace.c
===================================================================
--- release-2.6.11.orig/arch/x86_64/kernel/ptrace.c
+++ release-2.6.11/arch/x86_64/kernel/ptrace.c
@@ -129,13 +129,13 @@ static int putreg(struct task_struct *ch
 			value &= 0xffff;
 			return 0;
 		case offsetof(struct user_regs_struct,fs_base):
-			if (!((value >> 48) == 0 || (value >> 48) == 0xffff))
-				return -EIO; 
+			if (value >= TASK_SIZE)
+				return -EIO;
 			child->thread.fs = value;
 			return 0;
 		case offsetof(struct user_regs_struct,gs_base):
-			if (!((value >> 48) == 0 || (value >> 48) == 0xffff))
-				return -EIO; 
+			if (value >= TASK_SIZE)
+				return -EIO;
 			child->thread.gs = value;
 			return 0;
 		case offsetof(struct user_regs_struct, eflags):
