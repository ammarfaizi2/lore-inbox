Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268119AbRGWBLx>; Sun, 22 Jul 2001 21:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268120AbRGWBLn>; Sun, 22 Jul 2001 21:11:43 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:1870 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268119AbRGWBLd>; Sun, 22 Jul 2001 21:11:33 -0400
Date: Mon, 23 Jul 2001 03:11:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.7pre8aa1
Message-ID: <20010723031146.D23517@athlon.random>
In-Reply-To: <200107192245.f6JMjcR08865@karaya.com> <20010720033749.J31850@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010720033749.J31850@athlon.random>; from andrea@suse.de on Fri, Jul 20, 2001 at 03:37:49AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, Jul 20, 2001 at 03:37:49AM +0200, Andrea Arcangeli wrote:
> On Thu, Jul 19, 2001 at 06:45:38PM -0400, Jeff Dike wrote:
> > > Only in 2.4.7pre6aa1: 51_uml-ac-to-aa-2.bz2
> > > Only in 2.4.7pre8aa1/: 51_uml-ac-to-aa-3.bz2
> > >         Moved part of it in the tux directory so it can compile
> > >         without tux (in reality I got errno compilation error
> > >         but it's low prio and I'll sort it out later, Jeff Dike any
> > >         hint is welcome ;).
> > 
> > This is the patch I sent to Alan a while back which works around the problem.
> > 
> > rmk suggested a better way which I'll add at some point.
> > 
> > 				Jeff
> > 
> > 
> > diff -Naur -X exclude-files ac_cur/arch/um/Makefile ac/arch/um/Makefile
> > --- ac_cur/arch/um/Makefile	Mon Jul  9 13:05:03 2001
> > +++ ac/arch/um/Makefile	Mon Jul  9 13:26:21 2001
> > @@ -20,6 +20,8 @@
> >  LINK_PROFILE = $(PROFILE) -Wl,--wrap,__monstartup
> >  endif
> >  
> > +CFLAGS := $(subst -fno-common,,$(CFLAGS))
> > +
> >  SUBDIRS += $(ARCH_DIR)/fs $(ARCH_DIR)/drivers $(ARCH_DIR)/kernel \
> >  	$(ARCH_DIR)/sys-$(SUBARCH)
> 
> works fine thanks! Of course I agree with rmk it would be better not to

I should have said "compiles" fine (not "works" fine :).

__initdata is broken in uml and the kernel deadlocks because the wait
list is empty in complete() despite wait_for_completion actually
registered correctly into it. This because wait_for_completion runs in
a different address space than complete() and the virtual memory is not
shared across the two address spaces (it is not rempped in a MAP_SHARED
so it generates a cow). The registration is basically only private to
the entity that is registrating and it will never get visible to the
waker task that will do nothing. This is a severe bug not just for the
completion code in 2.4.7. here the fix (plus the ptrace bit):

--- ./arch/um/kernel/ptrace.c.~1~	Fri Jul 20 17:23:16 2001
+++ ./arch/um/kernel/ptrace.c	Fri Jul 20 17:43:56 2001
@@ -43,7 +43,7 @@
 	if (request == PTRACE_ATTACH) {
 		if (child == current)
 			goto out_tsk;
-		if ((!child->dumpable ||
+		if ((!ptrace_dumpable(child) ||
 		     (current->uid != child->euid) ||
 		     (current->uid != child->suid) ||
 		     (current->uid != child->uid) ||
--- ./arch/um/link.ld.in.~1~	Fri Jul 20 17:23:16 2001
+++ ./arch/um/link.ld.in	Mon Jul 23 03:06:40 2001
@@ -45,7 +45,6 @@
   . = ALIGN(4096);		/* Init code and data */
   __init_begin = .;
   .text.init : { *(.text.init) }
-  .data.init : { *(.data.init) }
   . = ALIGN(16);
   __setup_start = .;
   .setup.init : { *(.setup.init) }
@@ -92,6 +91,7 @@
     . = ALIGN(16384);		/* init_task */
     *(.data.init_task)
     *(.data)
+    *(.data.init)
     *(.gnu.linkonce.d*)
     CONSTRUCTORS
   }


(I didn't update the init_begin/end logic since there's no logic at all
in uml because we don't free that memory anyways so there's no side
effect because of that change)

> disable -fno-common but this is ok for now ;) (after all we would catch
> any potential important name collision during the compiles of the other
> targets)
> 
> Andrea


Andrea
