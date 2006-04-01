Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWDAUhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWDAUhm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 15:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWDAUhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 15:37:42 -0500
Received: from silver.veritas.com ([143.127.12.111]:63393 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932190AbWDAUhl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 15:37:41 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.03,154,1141632000"; 
   d="scan'208"; a="36688515:sNHT25139048"
Date: Sat, 1 Apr 2006 21:37:26 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Dan Aloni <da-x@monatomic.org>
cc: Keith Owens <kaos@sgi.com>, Nathan Scott <nathans@sgi.com>,
       kdb@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Announce: kdb v4.4 is available for kernel 2.6.16
In-Reply-To: <20060401170430.GA14715@localdomain>
Message-ID: <Pine.LNX.4.64.0604012127260.7239@blonde.wat.veritas.com>
References: <28258.1142920764@kao2.melbourne.sgi.com> <20060401170430.GA14715@localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 01 Apr 2006 20:37:41.0110 (UTC) FILETIME=[1F28E160:01C655CC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Apr 2006, Dan Aloni wrote:
> 
> Thanks for this new version, however I'm looking forward to see
> kdb maintained also for the x86_64 architecture. Currently I have 
> got as far as forward-porting it to a level where it "works" except 
> for one annoying issue where setjmp/longjmp looks to be broken:
> 
> Kernel configured with CONFIG_FRAME_POINTER=y,

I've not tried latest kdb, but you should find the patch below still
works (removing that unnecessary KDB_STATE_SET(LONGJMP) is probably
irrelevant, just something I did on the way, and which does no harm).

Hugh

--- 2.6.13-kdb/arch/x86_64/kdb/kdbasupport.c	2005-09-09 12:34:43.000000000 +0100
+++ fixed/arch/x86_64/kdb/kdbasupport.c	2005-08-30 15:10:20.000000000 +0100
@@ -1035,14 +1004,15 @@ kdba_setjmp(kdb_jmp_buf *jb)
 {
 #if defined(CONFIG_FRAME_POINTER)
 	__asm__("movq %rbx, (0*8)(%rdi);"
-		"movq %rbp, (1*8)(%rdi);"
+		"movq (%rsp), %rax;"
+		"movq %rax, (1*8)(%rdi);"
 		"movq %r12, (2*8)(%rdi);"
 		"movq %r13, (3*8)(%rdi);"
 		"movq %r14, (4*8)(%rdi);"
 		"movq %r15, (5*8)(%rdi);"
 		"leaq 16(%rsp), %rdx;"
 		"movq %rdx, (6*8)(%rdi);"
-		"movq (%rsp), %rax;"
+		"movq 8(%rsp), %rax;"
 		"movq %rax, (7*8)(%rdi)");
 #else	 /* CONFIG_FRAME_POINTER */
 	__asm__("movq %rbx, (0*8)(%rdi);"
@@ -1056,7 +1026,6 @@ kdba_setjmp(kdb_jmp_buf *jb)
 		"movq (%rsp), %rax;"
 		"movq %rax, (7*8)(%rdi)");
 #endif   /* CONFIG_FRAME_POINTER */
-	KDB_STATE_SET(LONGJMP);
 	return 0;
 }
 
