Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbVEZWV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVEZWV3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 18:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVEZWV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 18:21:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25237 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261831AbVEZWVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 18:21:21 -0400
Date: Thu, 26 May 2005 15:21:13 -0700
Message-Id: <200505262221.j4QMLDgF010735@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: "Michael Kerrisk" <mtk-lkml@gmx.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] i386: fix prevent_tail_call
In-Reply-To: Michael Kerrisk's message of  Wednesday, 18 May 2005 10:20:47 +0200 <24601.1116404447@www71.gmx.net>
Emacs: Our Lady of Perpetual Garbage Collection
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We fixed this bug before, but it didn't take.  It may have been the case
that the problem was first noticed to occur in a CONFIG_REGPARM compile.
But it's not regparm functions that need not to make tail calls, it's
asmlinkage functions called with a user pt_regs frame on the stack
supplying their arguments.  prevent_tail_call probably doesn't do anything
at all in regparm functions (your argument registers are going to be
clobbered, period).  It was a braino to conditionalize that definition in
the first place.

Signed-off-by: Roland McGrath <roland@redhat.com>

---
commit 20da6762d8c1921800686ce31b1563e3ac24880d
tree cffaf6d5044bb44f13bb540d750f1e44562901e4
parent 3b54f47d661b933498f0709e5ce215d0f285e928
author Roland McGrath <roland@redhat.com> Thu, 26 May 2005 15:19:26 -0700
committer Roland McGrath <roland@redhat.com> Thu, 26 May 2005 15:19:26 -0700

 asm-i386/linkage.h |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

Index: include/asm-i386/linkage.h
===================================================================
--- a2dc8eec0e30ffa0f39d2f835e018ee86387ff61/include/asm-i386/linkage.h  (mode:100644)
+++ cffaf6d5044bb44f13bb540d750f1e44562901e4/include/asm-i386/linkage.h  (mode:100644)
@@ -5,9 +5,7 @@
 #define FASTCALL(x)	x __attribute__((regparm(3)))
 #define fastcall	__attribute__((regparm(3)))
 
-#ifdef CONFIG_REGPARM
-# define prevent_tail_call(ret) __asm__ ("" : "=r" (ret) : "0" (ret))
-#endif
+#define prevent_tail_call(ret) __asm__ ("" : "=r" (ret) : "0" (ret))
 
 #ifdef CONFIG_X86_ALIGNMENT_16
 #define __ALIGN .align 16,0x90
