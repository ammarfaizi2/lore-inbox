Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263291AbSKMVHZ>; Wed, 13 Nov 2002 16:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263977AbSKMVHZ>; Wed, 13 Nov 2002 16:07:25 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:2944 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S263291AbSKMVGc>;
	Wed, 13 Nov 2002 16:06:32 -0500
Date: Wed, 13 Nov 2002 22:13:18 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Leif Sawyer <lsawyer@gci.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FW: i386 Linux kernel DoS (clarification)
Message-ID: <20021113211318.GA1962@vana>
References: <76C6E114FA8@vcnet.vc.cvut.cz> <1037221814.12445.126.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037221814.12445.126.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 09:10:14PM +0000, Alan Cox wrote:
> On Wed, 2002-11-13 at 20:36, Petr Vandrovec wrote:
> > 2.5.47-current-bk, run as mere user: Kernel panic: Attempted to kill init!
> > Next time I'll trust you.
> 
> It does the lcall
> The lcall takes an exception
> The exception (TF) has NT set
> iret returns via the task linkage
> 
> I think just clearing the NT bit in both lcall path _and_ in the TF
> exception handler does the trick.

This fixes it for me. I'll have to look at ia32 manual at home, why I
must do pushl %eax & popfl, as NT should be already cleared by
do_debug(). I probably miss something obvious, but I do not think that
adding these three instructions into lcall7/27 fastpath is acceptable.

Without pushl %eax & popfl it behaved much better than originally: 
modprobe started, said that personality-1 does not exist, and then 
system killed init (instead of killing init immediately).
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz

 
diff -urN linux-2.5.47.dist/arch/i386/kernel/entry.S linux-2.5.47/arch/i386/kernel/entry.S
--- linux-2.5.47.dist/arch/i386/kernel/entry.S	2002-11-11 12:26:04.000000000 +0100
+++ linux-2.5.47/arch/i386/kernel/entry.S	2002-11-13 22:02:17.000000000 +0100
@@ -131,6 +131,9 @@
 	movl EIP(%esp), %eax	# due to call gates, this is eflags, not eip..
 	movl CS(%esp), %edx	# this is eip..
 	movl EFLAGS(%esp), %ecx	# and this is cs..
+	andl $~NT_MASK, %eax
+	pushl %eax
+	popfl
 	movl %eax,EFLAGS(%esp)	#
 	movl %edx,EIP(%esp)	# Now we move them to their "normal" places
 	movl %ecx,CS(%esp)	#
@@ -153,6 +156,9 @@
 	movl EIP(%esp), %eax	# due to call gates, this is eflags, not eip..
 	movl CS(%esp), %edx	# this is eip..
 	movl EFLAGS(%esp), %ecx	# and this is cs..
+	andl $~NT_MASK, %eax
+	pushl %eax
+	popfl
 	movl %eax,EFLAGS(%esp)	#
 	movl %edx,EIP(%esp)	# Now we move them to their "normal" places
 	movl %ecx,CS(%esp)	#
diff -urN linux-2.5.47.dist/arch/i386/kernel/traps.c linux-2.5.47/arch/i386/kernel/traps.c
--- linux-2.5.47.dist/arch/i386/kernel/traps.c	2002-11-11 12:26:02.000000000 +0100
+++ linux-2.5.47/arch/i386/kernel/traps.c	2002-11-13 21:54:26.000000000 +0100
@@ -636,7 +636,7 @@
 	return;
 
 clear_TF:
-	regs->eflags &= ~TF_MASK;
+	regs->eflags &= ~(TF_MASK|NT_MASK);
 	return;
 }
 
