Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVBFO34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVBFO34 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 09:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVBFO34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 09:29:56 -0500
Received: from cantor.suse.de ([195.135.220.2]:47071 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261171AbVBFO3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 09:29:41 -0500
Date: Sun, 6 Feb 2005 15:29:36 +0100
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, drepper@redhat.com
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
Message-ID: <20050206142936.GC30476@wotan.suse.de>
References: <20050206120244.GA28061@elte.hu> <20050206124523.GA762@elte.hu> <20050206125002.GF30109@wotan.suse.de> <1107694800.22680.90.camel@laptopd505.fenrus.org> <20050206130152.GH30109@wotan.suse.de> <20050206130650.GA32015@infradead.org> <20050206131130.GJ30109@wotan.suse.de> <20050206133239.GA4483@elte.hu> <20050206134640.GB30476@wotan.suse.de> <20050206140802.GA6323@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206140802.GA6323@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 03:08:02PM +0100, Ingo Molnar wrote:
> * Andi Kleen <ak@suse.de> wrote:
> 
> > > RWE. But if it triggers it shows up immediately so it's not like you
> > > have no sign that something wrong is going on. Only grub-install
> > > triggers it and no boot/install kernel i know of defaults to
> > > PAE-enabled, that's what caused grub-install being used in an NX
> > > scenario so infrequently.)
> > > 
> > > anyway, this particular flamewar might have made more sense last Summer.
> > 
> > Last summer nobody did change the 32bit ABI on x86-64.
> > 
> > I only started it because the bug reports are appearing now and it's
> > clear now that we have a problem. 
> 
> the vanilla 2.6.10 x64 kernel, using 32-bit fedora userland boots fine
> here, and gives a noexec stack:

I'm not too concerned about the noexec stack (PT_GNU_STACK seems 
to handle that well enough), more about the no exec heap which
seems to cause all the problems.  The stack change is not very
nice, but at least doesn't seem to cause wide spread breakage.

Anyways, you're right I double checked and the problem was already
in 2.6.10. I can just say that I didn't get any reports, maybe
nobody tried grub with 2.6.10 or they didn't report it the problem
properly.

Probably my original patch was a bit too radical too, just setting 
READ_IMPLIES_EXEC on all 32bit process unconditionally should be good enough. 

I still think it's something that needs to be addressed for 2.6.11.

Here's a new patch that just sets READ_IMPLIES_EXEC unconditionally.

It still has a bug that you cannot change it with personality()
without getting overwritten later
(that is a bug that was in the original changes, you would really 
need two independent bits for this). But I'm not going to change
that now so late in the game. It implies that you cannot 
use personality to force READ_IMPLIES_EXEC for a 64bit process.

-Andi


Force READ_IMPLIES_EXEC for all 32bit processes to fix
the 32bit source compatibility.

Signed-off-by: Andi Kleen <ak@suse.de>

diff -u linux-2.6.11rc3/include/asm-i386/elf.h-o linux-2.6.11rc3/include/asm-i386/elf.h
--- linux-2.6.11rc3/include/asm-i386/elf.h-o	2004-10-19 01:55:33.000000000 +0200
+++ linux-2.6.11rc3/include/asm-i386/elf.h	2005-02-06 15:27:13.000000000 +0100
@@ -117,7 +117,8 @@
 #define AT_SYSINFO_EHDR		33
 
 #ifdef __KERNEL__
-#define SET_PERSONALITY(ex, ibcs2) do { } while (0)
+#define SET_PERSONALITY(ex, ibcs2) \
+	do { current->personality |= READ_IMPLIES_EXEC; } while (0)
 
 /*
  * An executable for which elf_read_implies_exec() returns TRUE will
diff -u linux-2.6.11rc3/arch/x86_64/kernel/process.c-o linux-2.6.11rc3/arch/x86_64/kernel/process.c
--- linux-2.6.11rc3/arch/x86_64/kernel/process.c-o	2005-02-04 09:12:52.000000000 +0100
+++ linux-2.6.11rc3/arch/x86_64/kernel/process.c	2005-02-06 15:26:45.000000000 +0100
@@ -577,6 +577,11 @@
 
 	/* Make sure to be in 64bit mode */
 	clear_thread_flag(TIF_IA32); 
+
+	/* Clear in case it was set from a 32bit parent.
+	   Bug: this overwrites the user choice. Would need
+	   a second bit too. */
+	current->personality &= ~READ_IMPLIES_EXEC;
 }
 
 asmlinkage long sys_fork(struct pt_regs *regs)
diff -u linux-2.6.11rc3/arch/x86_64/ia32/ia32_binfmt.c-o linux-2.6.11rc3/arch/x86_64/ia32/ia32_binfmt.c
--- linux-2.6.11rc3/arch/x86_64/ia32/ia32_binfmt.c-o	2005-02-04 09:12:52.000000000 +0100
+++ linux-2.6.11rc3/arch/x86_64/ia32/ia32_binfmt.c	2005-02-06 15:23:33.000000000 +0100
@@ -262,6 +262,7 @@
 		set_thread_flag(TIF_ABI_PENDING);		\
 	else							\
 		clear_thread_flag(TIF_ABI_PENDING);		\
+	current->personality |= READ_IMPLIES_EXEC; 		\
 } while (0)
 
 /* Override some function names */


