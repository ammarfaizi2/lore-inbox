Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbUKLHPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbUKLHPR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 02:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbUKLHPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 02:15:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:47819 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261968AbUKLHPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 02:15:06 -0500
Date: Thu, 11 Nov 2004 23:15:02 -0800
From: Chris Wright <chrisw@osdl.org>
To: Florian Heinz <heinz@cronon-ag.de>, linux-kernel@vger.kernel.org
Cc: Chris Wright <chrisw@osdl.org>
Subject: Re: a.out issue
Message-ID: <20041111231502.M2357@build.pdx.osdl.net>
References: <20041111220906.GA1670@dereference.de> <20041111192727.R14339@build.pdx.osdl.net> <20041112035112.GA2075@kurtwerks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041112035112.GA2075@kurtwerks.com>; from kwall@kurtwerks.com on Thu, Nov 11, 2004 at 10:51:12PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kurt Wall (kwall@kurtwerks.com) wrote:
> On Thu, Nov 11, 2004 at 07:27:27PM -0800, Chris Wright took 39 lines to write:
> > * Florian Heinz (heinz@cronon-ag.de) wrote:
> > > seems like find_vma_prepare does not what insert_vm_struct expects when
> > > the whole addresspace is occupied.
> > 
> > The setup_arg_pages() is inserting an overlapping region.  If nothing
> > else, this will fix that problem.   Perhaps there's a better solution.
> 
> It solves the oops here (I didn't get the oops at first because I didn't
> have CONFIG_BINFMT_AOUT set).

Heh, you're better off with it config'd off ;-)

> Sort of. Now I just get "Killed" with
> vm.overcommit_memory set to 1; with it set to 0 I get a seg fault.

Yeah, it should generate a SIGKILL and terminate the program.  Thanks for
testing.  The patch below should fixup that segfault as well.

-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net


===== fs/binfmt_aout.c 1.25 vs edited =====
--- 1.25/fs/binfmt_aout.c	2004-10-18 22:26:36 -07:00
+++ edited/fs/binfmt_aout.c	2004-11-11 22:28:58 -08:00
@@ -43,13 +43,18 @@
 	.min_coredump	= PAGE_SIZE
 };
 
-static void set_brk(unsigned long start, unsigned long end)
+#define BAD_ADDR(x)	((unsigned long)(x) >= TASK_SIZE)
+
+static int set_brk(unsigned long start, unsigned long end)
 {
 	start = PAGE_ALIGN(start);
 	end = PAGE_ALIGN(end);
-	if (end <= start)
-		return;
-	do_brk(start, end - start);
+	if (end > start) {
+		unsigned long addr = do_brk(start, end - start);
+		if (BAD_ADDR(addr))
+			return addr;
+	}
+	return 0;
 }
 
 /*
@@ -413,7 +418,11 @@
 beyond_if:
 	set_binfmt(&aout_format);
 
-	set_brk(current->mm->start_brk, current->mm->brk);
+	retval = set_brk(current->mm->start_brk, current->mm->brk);
+	if (retval < 0) {
+		send_sig(SIGKILL, current, 0);
+		return retval;
+	}
 
 	retval = setup_arg_pages(bprm, EXSTACK_DEFAULT);
 	if (retval < 0) { 
