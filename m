Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266544AbUGKJzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266544AbUGKJzz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 05:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266543AbUGKJzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 05:55:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16591 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266541AbUGKJzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 05:55:38 -0400
Date: Sun, 11 Jul 2004 05:52:59 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: davidm@hpl.hp.com
cc: suresh.b.siddha@intel.com, jun.nakajima@intel.com,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: serious performance regression due to NX patch
In-Reply-To: <Pine.LNX.4.58.0407110536130.2248@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.58.0407110550340.4229@devserv.devel.redhat.com>
References: <200407100528.i6A5SF8h020094@napali.hpl.hp.com>
 <Pine.LNX.4.58.0407110437310.26065@devserv.devel.redhat.com>
 <Pine.LNX.4.58.0407110536130.2248@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 11 Jul 2004, Ingo Molnar wrote:

> > ok, agreed. I'll check that it still does the right thing on x86.
> 
> it doesnt seem to do the right thing for !PT_GNU_STACK applications on 
> x86:

how about the patch below? This way we recognize the fact that x86 didnt
have any executability check previously at the point where we discover
that it's a 'legacy' binary.

	Ingo

--- linux/fs/binfmt_elf.c.orig3	
+++ linux/fs/binfmt_elf.c	
@@ -627,8 +627,14 @@ static int load_elf_binary(struct linux_
 				executable_stack = EXSTACK_DISABLE_X;
 			break;
 		}
+#ifdef __i386_
+	/*
+	 * Legacy x86 binaries have an expectation of executability for
+	 * virtually all their address-space - turn executability on:
+	 */
 	if (i == elf_ex.e_phnum)
 		def_flags |= VM_EXEC | VM_MAYEXEC;
+#endif
 
 	/* Some simple consistency checks for the interpreter */
 	if (elf_interpreter) {
