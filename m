Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265037AbSKNSG6>; Thu, 14 Nov 2002 13:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbSKNSG6>; Thu, 14 Nov 2002 13:06:58 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31248 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265037AbSKNSG5>; Thu, 14 Nov 2002 13:06:57 -0500
Date: Thu, 14 Nov 2002 10:12:53 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>,
       Leif Sawyer <lsawyer@gci.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: FW: i386 Linux kernel DoS
In-Reply-To: <20021114030541.GU31697@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0211140956480.1340-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, the reason for this one is that we don't really emulate a
trap/interrupt gate correctly when taking a lcall. We _do_ set up the 
stack to be identical, but a real trap/interrupt will also clear TF and NT 
in EFLAGS on entry to the kernel (_after_ having saved the value off), and 
our emulation code didn't do that.

So when we returned with an "iret", we had NT set in EFLAGS, causing the
iret to do all the wrong things.

This is my 2.5.x fix, I suspect it applies as-is to 2.4.x too. I don't 
think anything has changed here in a long time. 

Does anybody see anything else we're missing from the emulation path? 

(Or path_s_, as I noticed after fixing the bug once already ;^p. We should
probably try to do this all as common code rather than having two separate
paths for lcall 0x7 and lcall 0x27 - the code is identical apart from one
little constant.. This looks like the minimal patch, though.)

		Linus

-----
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/11/14	torvalds@home.transmeta.com	1.848
# Fix impressive call gate misuse DoS reported on bugtraq.
# --------------------------------------------
# 02/11/14	torvalds@home.transmeta.com	1.849
# Duh. Fix the other lcall entry point too.
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Thu Nov 14 09:59:08 2002
+++ b/arch/i386/kernel/entry.S	Thu Nov 14 09:59:08 2002
@@ -66,7 +66,9 @@
 OLDSS		= 0x38
 
 CF_MASK		= 0x00000001
+TF_MASK		= 0x00000100
 IF_MASK		= 0x00000200
+DF_MASK		= 0x00000400 
 NT_MASK		= 0x00004000
 VM_MASK		= 0x00020000
 
@@ -134,6 +136,17 @@
 	movl %eax,EFLAGS(%esp)	#
 	movl %edx,EIP(%esp)	# Now we move them to their "normal" places
 	movl %ecx,CS(%esp)	#
+
+	#
+	# Call gates don't clear TF and NT in eflags like
+	# traps do, so we need to do it ourselves.
+	# %eax already contains eflags (but it may have
+	# DF set, clear that also)
+	#
+	andl $~(DF_MASK | TF_MASK | NT_MASK),%eax
+	pushl %eax
+	popfl
+
 	movl %esp, %ebx
 	pushl %ebx
 	andl $-8192, %ebx	# GET_THREAD_INFO
@@ -156,6 +169,17 @@
 	movl %eax,EFLAGS(%esp)	#
 	movl %edx,EIP(%esp)	# Now we move them to their "normal" places
 	movl %ecx,CS(%esp)	#
+
+	#
+	# Call gates don't clear TF and NT in eflags like
+	# traps do, so we need to do it ourselves.
+	# %eax already contains eflags (but it may have
+	# DF set, clear that also)
+	#
+	andl $~(DF_MASK | TF_MASK | NT_MASK),%eax
+	pushl %eax
+	popfl
+
 	movl %esp, %ebx
 	pushl %ebx
 	andl $-8192, %ebx	# GET_THREAD_INFO

