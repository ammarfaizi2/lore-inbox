Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751918AbWI1Pc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbWI1Pc3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 11:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbWI1Pc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 11:32:29 -0400
Received: from excu-mxob-1.symantec.com ([198.6.49.12]:27073 "EHLO
	excu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S965057AbWI1Pc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 11:32:28 -0400
Date: Thu, 28 Sep 2006 16:30:19 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Andi Kleen <ak@muc.de>
cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Put the BUG __FILE__ and __LINE__ info out of line
In-Reply-To: <20060928103853.GB99906@muc.de>
Message-ID: <Pine.LNX.4.64.0609281626001.25939@blonde.wat.veritas.com>
References: <451B64E3.9020900@goop.org> <20060927233509.f675c02d.akpm@osdl.org>
 <451B708D.20505@goop.org> <20060928000019.3fb4b317.akpm@osdl.org>
 <20060928071731.GB84041@muc.de> <20060928002610.05e61321.akpm@osdl.org>
 <20060928101555.GA99906@muc.de> <451BA434.9020409@goop.org>
 <20060928103853.GB99906@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 28 Sep 2006 15:30:11.0978 (UTC) FILETIME=[FCF9BEA0:01C6E312]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006, Andi Kleen wrote:
> On Thu, Sep 28, 2006 at 03:30:12AM -0700, Jeremy Fitzhardinge wrote:
> > Andi Kleen wrote:
> > >But no out of line section. So overall it's smaller, although the cache 
> > >footprint
> > >is 2 bytes larger. But then is 2 bytes larger really an issue? We don't 
> > >have
> > >_that_ many BUGs anyways.
> > >  
> > 
> > I think the out of line section is a feature; no point in crufting up 
> > the icache with BUG gunk, especially since a number of them are on 
> > fairly hot paths.
> 
> It's 10 bytes per BUG. 

Or 9 bytes per BUG: I protested about the disassembly problem back
when the minimized BUG() first went in, and have been using "ljmp"
in my i386 builds ever since:

--- 2.6.18-git9/arch/i386/kernel/traps.c	2006-09-28 12:03:47.000000000 +0100
+++ linux/arch/i386/kernel/traps.c	2006-09-28 16:23:56.000000000 +0100
@@ -422,10 +422,10 @@ static void handle_BUG(struct pt_regs *r
 		char *file;
 		char c;
 
-		if (probe_kernel_address((unsigned short __user *)(eip + 2),
+		if (probe_kernel_address((unsigned short __user *)(eip + 7),
 					line))
 			break;
-		if (__get_user(file, (char * __user *)(eip + 4)) ||
+		if (__get_user(file, (char * __user *)(eip + 3)) ||
 		    (unsigned long)file < PAGE_OFFSET || __get_user(c, file))
 			file = "<bad filename>";
 
--- 2.6.18-git9/include/asm-i386/bug.h	2006-09-20 04:42:06.000000000 +0100
+++ linux/include/asm-i386/bug.h	2006-09-28 16:23:56.000000000 +0100
@@ -13,9 +13,11 @@
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 #define BUG()				\
  __asm__ __volatile__(	"ud2\n"		\
-			"\t.word %c0\n"	\
-			"\t.long %c1\n"	\
-			 : : "i" (__LINE__), "i" (__FILE__))
+			"\t.byte 0xea\n" \
+			"\t.long %c0\n"	\
+			"\t.word %c1\n"	\
+			 : : "i" (__FILE__), "i" (__LINE__))
+	/* "ljmp long short" so disassemblers can make sense of it */
 #else
 #define BUG() __asm__ __volatile__("ud2\n")
 #endif
