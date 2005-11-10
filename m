Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbVKJX14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbVKJX14 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 18:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbVKJX14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 18:27:56 -0500
Received: from verein.lst.de ([213.95.11.210]:10973 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932271AbVKJX1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 18:27:55 -0500
Date: Fri, 11 Nov 2005 00:27:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] use ptrace_get_task_struct in various places
Message-ID: <20051110232711.GA18831@lst.de>
References: <20051108053049.GA9422@lst.de> <20051107221149.08aa0820.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107221149.08aa0820.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 10:11:49PM -0800, Andrew Morton wrote:
> Christoph Hellwig <hch@lst.de> wrote:
> >
> > The ptrace_get_task_struct() helper that I added as part of the ptrace
> > consolidation is usefull in variety of places that currently opencode
> > it.  Switch them to the common helper.
> 
> If we're going to export ptrace_get_task_struct() to the world it would be
> nice to document it too - things like returning zero and a NULL *childp is
> a little obscure.

done, patch below.

> In arch/ia64/ia32/sys_ia32.c this patch will cause PTRACE_TRACEME requests
> to be handled by ptrace_request()

you mean ptrace_get_task_struct?

> rather than by sys_ptrace(), which is a
> not-obviously-correct change.

sys_ptrace has the same code for it, in fact just about every ptrace
implementation uses ptrace_get_task_struct to handle that code,
but ptrace_get_task_struct can't be used by ia64 because some oddness
in the !PTRACE_TRACEME codepath.

> Was the omission of arch/ia64/kernel/ptrace.c:sys_ptrace() deliberate?

yes.  it has some oddness about finding the 'right' task_struct of a
multi-threaded process.


Index: linux-2.6/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/kernel/ptrace.c	2005-11-10 15:36:12.000000000 +0100
+++ linux-2.6/kernel/ptrace.c	2005-11-10 15:46:05.000000000 +0100
@@ -407,6 +407,23 @@
 	return ret;
 }
 
+/**
+ * ptrace_get_task_struct  --  grab a task struct reference for ptrace
+ * @long:	ptrace request type
+ * @pid:	process to work on
+ * @childp:	task struct returned
+ *
+ * This function is a helper for ptrace implementations.  It checks
+ * permissions and then grabs a task struct for use of the actual
+ * ptrace implementation.  As a special case also handles PTRACE_TRACEME
+ * completely (as it's trivial and doesn't need a task_struct reference.
+ *
+ * The calling convention is a little bit odd: negative return value
+ * means failure, positive one sucess.  But even when this function
+ * suceeds @childp can be NULL and the calling ptrace implementation
+ * should return sucessfully immediately afterwards.  This is to support
+ * the PTRACE_TRACEME special case.
+ */
 int ptrace_get_task_struct(long request, long pid, struct task_struct **childp)
 {
 	struct task_struct *child;
