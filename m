Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbSKMVEc>; Wed, 13 Nov 2002 16:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263143AbSKMVEc>; Wed, 13 Nov 2002 16:04:32 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:47018 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263137AbSKMVEa>; Wed, 13 Nov 2002 16:04:30 -0500
Subject: RE: FW: i386 Linux kernel DoS (clarification)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Leif Sawyer <lsawyer@gci.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <BF9651D8732ED311A61D00105A9CA3150B45FBB0@berkeley.gci.com>
References: <BF9651D8732ED311A61D00105A9CA3150B45FBB0@berkeley.gci.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Nov 2002 21:36:54 +0000
Message-Id: <1037223414.12445.149.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try this

(In the Linus Torvalds tradition its not tested)

--- arch/i386/kernel/entry.S~	2002-11-13 21:30:37.000000000 +0000
+++ arch/i386/kernel/entry.S	2002-11-13 21:29:47.000000000 +0000
@@ -126,6 +126,7 @@
 ENTRY(lcall7)
 	pushfl			# We get a different stack layout with call
 				# gates, which has to be cleaned up later..
+	andl $~0x4500, (%esp)	# Clear NT since we are doing an iret
 	pushl %eax
 	SAVE_ALL
 	movl EIP(%esp), %eax	# due to call gates, this is eflags, not eip..
@@ -148,6 +149,7 @@
 ENTRY(lcall27)
 	pushfl			# We get a different stack layout with call
 				# gates, which has to be cleaned up later..
+	andl $~0x4500, (%esp)	# Clear NT since we are doing an iret
 	pushl %eax
 	SAVE_ALL
 	movl EIP(%esp), %eax	# due to call gates, this is eflags, not eip..
@@ -390,6 +392,9 @@
 	pushl $do_divide_error
 	ALIGN
 error_code:
+	pushfl
+	andl $~0x4500, (%esp)		# NT must be clear, do a cld for free
+	popfl
 	pushl %ds
 	pushl %eax
 	xorl %eax, %eax
@@ -400,7 +405,6 @@
 	decl %eax			# eax = -1
 	pushl %ecx
 	pushl %ebx
-	cld
 	movl %es, %ecx
 	movl ORIG_EAX(%esp), %esi	# get the error code
 	movl ES(%esp), %edi		# get the function address
