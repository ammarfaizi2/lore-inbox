Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbSLJIO0>; Tue, 10 Dec 2002 03:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266708AbSLJIO0>; Tue, 10 Dec 2002 03:14:26 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:59133 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S262604AbSLJIOY>;
	Tue, 10 Dec 2002 03:14:24 -0500
Message-ID: <3DF5A3C3.1E395B4E@mvista.com>
Date: Tue, 10 Dec 2002 00:20:19 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Daniel Jacobowitz <dan@debian.org>, Jim Houston <jim.houston@ccur.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       ralf@gnu.org, willy@debian.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
References: <Pine.LNX.4.44.0212091051120.1282-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------17292DAD0F344CC3AB29DAE9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------17292DAD0F344CC3AB29DAE9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On Mon, 9 Dec 2002, Martin Schwidefsky wrote:
> >
> > I had been looking at 2.5.50, we had a different meaning of current.
> > If you are saying that for any implementation of nanosleep I have to implement
> > the -ERESTART_RESTARTBLOCK thingy anyway, then I better start with it.
> 
> You don't _have_ to. An architecture for which restarting is just too
> painful can just always choose to return -EINTR, that should be ok. That's
> how nanosleep() used to work before - it may not be 100% SuS compliant,
> but it's not as if anybody really cares, I suspect.
> 
>                 Linus
> 
You know, if we unwind to where we started all this, Jim was
saying that nanosleep did not know it was being restarted. 
You then introduced the restart block AND the new system
call.  What if we take a more conservative approach, i.e.
keep the restart block, toss the restart syscall and the
"fn" entry in favor of a "restart" flag.  This flag would be
cleared ALWAYS in the deliver path.  We could use the
current -ENOHAND and what it does in the no delivery path
(i.e. backs up PC).  What we would then have is a restarted
system call with a way to KNOW it was restarted AND a way to
save info it needs to do the restart.  

Attached is a patch to take 2.5.50-bk7 to what I am
suggesting.  -ERESTART_RESTARTBLOCK is no longer used (I did
not remove the definition), but rather the system call would
return one of the restart system call error codes (-ENOHAND
comes to mind) and at the same time set up the restart
block.  On each entry the system call would check to see if
the restart_block.fl was set and if so, do the restart thing
using the saved info.  It would be required to clear
restart_block.fl once it found it set...
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
--------------17292DAD0F344CC3AB29DAE9
Content-Type: text/plain; charset=us-ascii;
 name="restart-2.5.50-bk7.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="restart-2.5.50-bk7.patch"

--- /usr/src/linux-2.5.50-bk7-posix/arch/i386/kernel/signal.c~	Sat Dec  7 21:36:11 2002
+++ /usr/src/linux-2.5.50-bk7-posix/arch/i386/kernel/signal.c	Tue Dec 10 00:06:10 2002
@@ -505,9 +505,8 @@
 	/* Are we from a system call? */
 	if (regs->orig_eax >= 0) {
 		/* If so, check system call restarting.. */
+                current_thread_info()->restart_block.fl = 0;
 		switch (regs->eax) {
-		        case -ERESTART_RESTARTBLOCK:
-				current_thread_info()->restart_block.fn = do_no_restart_syscall;
 			case -ERESTARTNOHAND:
 				regs->eax = -EINTR;
 				break;
@@ -591,10 +590,6 @@
 		    regs->eax == -ERESTARTSYS ||
 		    regs->eax == -ERESTARTNOINTR) {
 			regs->eax = regs->orig_eax;
-			regs->eip -= 2;
-		}
-		if (regs->eax == -ERESTART_RESTARTBLOCK){
-			regs->eax = __NR_restart_syscall;
 			regs->eip -= 2;
 		}
 	}
--- /usr/src/linux-2.5.50-bk7-posix/include/linux/thread_info.h~	Sat Dec  7 21:36:43 2002
+++ /usr/src/linux-2.5.50-bk7-posix/include/linux/thread_info.h	Tue Dec 10 00:12:31 2002
@@ -11,7 +11,7 @@
  * System call restart block. 
  */
 struct restart_block {
-	long (*fn)(struct restart_block *);
+	long fl;
 	unsigned long arg0, arg1, arg2;
 };
 
--- /usr/src/linux-2.5.50-bk7-posix/include/asm-i386/thread_info.h~	Sat Dec  7 21:36:41 2002
+++ /usr/src/linux-2.5.50-bk7-posix/include/asm-i386/thread_info.h	Tue Dec 10 00:09:32 2002
@@ -68,7 +68,7 @@
 	.preempt_count	= 1,			\
 	.addr_limit	= KERNEL_DS,		\
 	.restart_block = {			\
-		.fn = do_no_restart_syscall,	\
+		.fl = 0,			\
 	},					\
 }
 


--------------17292DAD0F344CC3AB29DAE9--

