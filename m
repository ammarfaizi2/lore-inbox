Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264540AbUGMEBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbUGMEBM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 00:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbUGMEBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 00:01:02 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4232 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263847AbUGMEAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 00:00:46 -0400
Date: Mon, 12 Jul 2004 23:58:06 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Jakub Jelinek <jakub@redhat.com>, davidm@hpl.hp.com,
       suresh.b.siddha@intel.com, jun.nakajima@intel.com,
       Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: serious performance regression due to NX patch
In-Reply-To: <Pine.LNX.4.58.0407121315170.1764@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0407122354280.13111@devserv.devel.redhat.com>
References: <200407100528.i6A5SF8h020094@napali.hpl.hp.com>
 <Pine.LNX.4.58.0407110437310.26065@devserv.devel.redhat.com>
 <Pine.LNX.4.58.0407110536130.2248@devserv.devel.redhat.com>
 <Pine.LNX.4.58.0407110550340.4229@devserv.devel.redhat.com>
 <20040711123803.GD21264@devserv.devel.redhat.com>
 <Pine.LNX.4.58.0407121402160.2451@devserv.devel.redhat.com>
 <Pine.LNX.4.58.0407121315170.1764@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Jul 2004, Linus Torvalds wrote:

> > so ... this should be #ifndef ia64?
> 
> No. Make it a CONFIG_DEFAULT_NOEXEC and make the relevant architectures do
> a
> 
> 	define_bool DEFAULT_NOEXEC y
> 
> in their Kconfig files.
> 
> In general, we should _never_ use an architecture-define. They just
> always end up becoming more and more hairy, and less and less obvious
> what they are all about.
> 
> So instead, make a readable and explicit config define, and let each
> architecture just set it (or not) as they wish.

ok - patch below. ia64 can now define it - the default is that legacy
binaries have executability expectations.

	Ingo

--- linux/fs/binfmt_elf.c.orig
+++ linux/fs/binfmt_elf.c
@@ -627,8 +627,14 @@ static int load_elf_binary(struct linux_
 				executable_stack = EXSTACK_DISABLE_X;
 			break;
 		}
+#ifndef CONFIG_DEFAULT_NOEXEC
+	/*
+	 * Legacy binaries (unless the arch defaults to noexec) have an
+	 * expectation of executability - turn it on:
+	 */
 	if (i == elf_ex.e_phnum)
 		def_flags |= VM_EXEC | VM_MAYEXEC;
+#endif
 
 	/* Some simple consistency checks for the interpreter */
 	if (elf_interpreter) {
