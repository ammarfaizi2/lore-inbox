Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264519AbUGFVDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264519AbUGFVDg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 17:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264561AbUGFVDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 17:03:36 -0400
Received: from colin2.muc.de ([193.149.48.15]:60427 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264519AbUGFVDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 17:03:33 -0400
Date: 6 Jul 2004 23:03:31 +0200
Date: Tue, 6 Jul 2004 23:03:31 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_SLAB_DEBUG and NUMA API
Message-ID: <20040706210331.GA29417@muc.de>
References: <20040706063149.GA37299@muc.de> <20040705234945.1f920d1b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040705234945.1f920d1b.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2004 at 11:49:45PM -0700, Andrew Morton wrote:
> Andi Kleen <ak@muc.de> wrote:
> >
> > 
> > I tested 2.6.7-mm6 with NUMA on with CONFIG_SLAB_DEBUG and I didn't see any 
> > oopses. Do you have a recipe to reproduce them?
> > 
> 
> Still happens here.  Booting SLES9.1 with the attached config.

[...]

Here's a patch. The problem was that the kernel exit would allocate
memory to send exit signals after the local mempolicy was already freed, 
but not zeroed.  When the allocator tried to grab more memory it would
fall over.

-Andi

-------------------------------------------------------------

Move the memory policy freeing to later in exit to make sure 
the last memory allocations don't use an uninitialized policy


diff -u linux-2.6.7-mm6/kernel/exit.c-o linux-2.6.7-mm6/kernel/exit.c
--- linux-2.6.7-mm6/kernel/exit.c-o	2004-07-06 05:59:39.000000000 +0200
+++ linux-2.6.7-mm6/kernel/exit.c	2004-07-06 22:58:39.000000000 +0200
@@ -828,9 +828,6 @@
 	__exit_fs(tsk);
 	exit_namespace(tsk);
 	exit_thread();
-#ifdef CONFIG_NUMA
-	mpol_free(tsk->mempolicy);
-#endif
 
 	if (tsk->signal->leader)
 		disassociate_ctty(1);
@@ -841,6 +838,10 @@
 
 	tsk->exit_code = code;
 	exit_notify(tsk);
+#ifdef CONFIG_NUMA
+	mpol_free(tsk->mempolicy);
+	tsk->mempolicy = NULL;
+#endif
 	schedule();
 	BUG();
 	/* Avoid "noreturn function does return".  */
