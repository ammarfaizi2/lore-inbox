Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264842AbSKNT77>; Thu, 14 Nov 2002 14:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265179AbSKNT77>; Thu, 14 Nov 2002 14:59:59 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:4224 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S264842AbSKNT75>;
	Thu, 14 Nov 2002 14:59:57 -0500
Date: Thu, 14 Nov 2002 21:06:27 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: FW: i386 Linux kernel DoS
Message-ID: <20021114200627.GA1850@vana>
References: <20021114030541.GU31697@dualathlon.random> <Pine.LNX.4.44.0211140956480.1340-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211140956480.1340-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 10:12:53AM -0800, Linus Torvalds wrote:
> 
> (Or path_s_, as I noticed after fixing the bug once already ;^p. We should
> probably try to do this all as common code rather than having two separate
> paths for lcall 0x7 and lcall 0x27 - the code is identical apart from one
> little constant.. This looks like the minimal patch, though.)

What about this? It even generates shorter code in each branch, as 
movl xx(%esp),%yy is 4 byte, while movl xx(%ebx),%yy is 3 byte opcode. 

I also converted "movl %4(%edx),%edx; call *%edx" to "call *4(%edx)", 2 bytes 
and one opcode shorter. I hope that it is also faster...

Appears to work...
							Petr Vandrovec
							vandrove@vc.cvut.cz

---

lcall7 and lcall27 paths differ only in one constant. Let's use constant
first, and execute common code after this.

 entry.S |   47 ++++++++++++-----------------------------------
 1 files changed, 12 insertions(+), 35 deletions(-)

--- linux-2.5.47-c849.dist/arch/i386/kernel/entry.S	2002-11-14 19:38:33.000000000 +0100
+++ linux-2.5.47-c849/arch/i386/kernel/entry.S	2002-11-14 20:53:26.000000000 +0100
@@ -130,12 +130,16 @@
 				# gates, which has to be cleaned up later..
 	pushl %eax
 	SAVE_ALL
-	movl EIP(%esp), %eax	# due to call gates, this is eflags, not eip..
-	movl CS(%esp), %edx	# this is eip..
-	movl EFLAGS(%esp), %ecx	# and this is cs..
-	movl %eax,EFLAGS(%esp)	#
-	movl %edx,EIP(%esp)	# Now we move them to their "normal" places
-	movl %ecx,CS(%esp)	#
+	movl %esp, %ebx
+	pushl %ebx
+	pushl $0x7
+do_lcall:
+	movl EIP(%ebx), %eax	# due to call gates, this is eflags, not eip..
+	movl CS(%ebx), %edx	# this is eip..
+	movl EFLAGS(%ebx), %ecx	# and this is cs..
+	movl %eax,EFLAGS(%ebx)	#
+	movl %edx,EIP(%ebx)	# Now we move them to their "normal" places
+	movl %ecx,CS(%ebx)	#
 
 	#
 	# Call gates don't clear TF and NT in eflags like
@@ -147,13 +151,9 @@
 	pushl %eax
 	popfl
 
-	movl %esp, %ebx
-	pushl %ebx
 	andl $-8192, %ebx	# GET_THREAD_INFO
 	movl TI_EXEC_DOMAIN(%ebx), %edx	# Get the execution domain
-	movl 4(%edx), %edx	# Get the lcall7 handler for the domain
-	pushl $0x7
-	call *%edx
+	call *4(%edx)		# Call the lcall7 handler for the domain
 	addl $4, %esp
 	popl %eax
 	jmp resume_userspace
@@ -163,33 +163,10 @@
 				# gates, which has to be cleaned up later..
 	pushl %eax
 	SAVE_ALL
-	movl EIP(%esp), %eax	# due to call gates, this is eflags, not eip..
-	movl CS(%esp), %edx	# this is eip..
-	movl EFLAGS(%esp), %ecx	# and this is cs..
-	movl %eax,EFLAGS(%esp)	#
-	movl %edx,EIP(%esp)	# Now we move them to their "normal" places
-	movl %ecx,CS(%esp)	#
-
-	#
-	# Call gates don't clear TF and NT in eflags like
-	# traps do, so we need to do it ourselves.
-	# %eax already contains eflags (but it may have
-	# DF set, clear that also)
-	#
-	andl $~(DF_MASK | TF_MASK | NT_MASK),%eax
-	pushl %eax
-	popfl
-
 	movl %esp, %ebx
 	pushl %ebx
-	andl $-8192, %ebx	# GET_THREAD_INFO
-	movl TI_EXEC_DOMAIN(%ebx), %edx	# Get the execution domain
-	movl 4(%edx), %edx	# Get the lcall7 handler for the domain
 	pushl $0x27
-	call *%edx
-	addl $4, %esp
-	popl %eax
-	jmp resume_userspace
+	jmp do_lcall
 
 
 ENTRY(ret_from_fork)
