Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVBFR5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVBFR5a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 12:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVBFR5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 12:57:30 -0500
Received: from mail.suse.de ([195.135.220.2]:20707 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261255AbVBFR5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 12:57:09 -0500
Date: Sun, 6 Feb 2005 18:56:19 +0100
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, drepper@redhat.com
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
Message-ID: <20050206175619.GA18245@wotan.suse.de>
References: <20050206125002.GF30109@wotan.suse.de> <1107694800.22680.90.camel@laptopd505.fenrus.org> <20050206130152.GH30109@wotan.suse.de> <20050206130650.GA32015@infradead.org> <20050206131130.GJ30109@wotan.suse.de> <20050206133239.GA4483@elte.hu> <20050206134640.GB30476@wotan.suse.de> <20050206140802.GA6323@elte.hu> <20050206142936.GC30476@wotan.suse.de> <Pine.LNX.4.58.0502060907220.2165@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502060907220.2165@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 09:08:47AM -0800, Linus Torvalds wrote:
> 
> 
> On Sun, 6 Feb 2005, Andi Kleen wrote:
> > 
> > Force READ_IMPLIES_EXEC for all 32bit processes to fix
> > the 32bit source compatibility.
> 
> Andi, stop this. We're _not_ going to say "32-bit executables don't need 
> PROT_EXEC. The executables would need to be marked broken per-executable, 
> not some kind of "we don't do this globally" setting.

The thing I'm annoyed about is that all the testing for this
change seems to go towards the x86-64 32bit emulation
(because effectively near nobody uses 32bit PAE+NX right now) 

And the main job of the 32bit emulation is not to prove 
as a testing ground for experimental stuff, but to be compatible.

And changes like this break it and cause me a lot of additional work.

Here's a slightly different patch to only turn it off for 32bit x86-64.

If the 32bit experimental security people can get their stuff tested
properly and 32bit NX CPUs are actually used widely 
and all the third party sources fixed I can probably follow in a few months. 

But I really don't have the capacity to track third party software fixes for 
stuff that really has nothing to do with compatible 32bit emulation.

Please consider applying this patch. It only touches x86-64. Thanks: 

-Andi

Always enable PROT_READ implies PROT_EXEC for 32bit programs
running on x86-64.  This reverts behaviour back to what 2.6.9 did.

Signed-off-by: Andi Kleen <ak@suse.de>


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

