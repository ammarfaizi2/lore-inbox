Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751827AbWCILSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbWCILSt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 06:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbWCILSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 06:18:49 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:19585 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751827AbWCILSs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 06:18:48 -0500
Date: Thu, 9 Mar 2006 03:23:24 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Ram Gupta <ram.gupta5@gmail.com>
Subject: [PATCH 2/2] make cap_ptrace enforce PTRACE_TRACME checks
Message-ID: <20060309112324.GB3883@sorel.sous-sol.org>
References: <20060309111651.GA3883@sorel.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060309111651.GA3883@sorel.sous-sol.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PTRACE_TRACEME doesn't have proper capabilities validation when
parent is less privileged than child.  Issue pointed out by
Ram Gupta <ram.gupta5@gmail.com>.

Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Cc: Ram Gupta <ram.gupta5@gmail.com>
---
Note: I haven't identified a strong security issue, and it's a small
ABI change that could break apps that rely on existing behaviour (which
allows parent that is less privileged than child to ptrace when child
does PTRACE_TRACEME).

 security/commoncap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linus-2.6.orig/security/commoncap.c
+++ linus-2.6/security/commoncap.c
@@ -60,8 +60,8 @@ int cap_settime(struct timespec *ts, str
 int cap_ptrace (struct task_struct *parent, struct task_struct *child)
 {
 	/* Derived from arch/i386/kernel/ptrace.c:sys_ptrace. */
-	if (!cap_issubset (child->cap_permitted, current->cap_permitted) &&
-	    !capable(CAP_SYS_PTRACE))
+	if (!cap_issubset(child->cap_permitted, parent->cap_permitted) &&
+	    !__capable(parent, CAP_SYS_PTRACE))
 		return -EPERM;
 	return 0;
 }
