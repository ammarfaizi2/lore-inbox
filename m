Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVEWXk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVEWXk5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 19:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVEWXcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 19:32:13 -0400
Received: from fire.osdl.org ([65.172.181.4]:47238 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261184AbVEWXaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 19:30:10 -0400
Date: Mon, 23 May 2005 16:29:18 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, ak@suse.de
Subject: [patch 12/16] x86_64: check if ptrace RIP is canonical
Message-ID: <20050523232918.GX27549@shell0.pdx.osdl.net>
References: <20050523231529.GL27549@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050523231529.GL27549@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] x86_64: check if ptrace RIP is canonical

This works around an AMD Erratum.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---

 ptrace.c |    5 +++++
 1 files changed, 5 insertions(+)

Index: release-2.6.11/arch/x86_64/kernel/ptrace.c
===================================================================
--- release-2.6.11.orig/arch/x86_64/kernel/ptrace.c
+++ release-2.6.11/arch/x86_64/kernel/ptrace.c
@@ -149,6 +149,11 @@ static int putreg(struct task_struct *ch
 				return -EIO;
 			value &= 0xffff;
 			break;
+		case offsetof(struct user_regs_struct, rip):
+			/* Check if the new RIP address is canonical */
+			if (value >= TASK_SIZE)
+				return -EIO;
+			break;
 	}
 	put_stack_long(child, regno - sizeof(struct pt_regs), value);
 	return 0;
