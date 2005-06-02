Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVFBUxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVFBUxB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 16:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVFBUwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 16:52:08 -0400
Received: from fire.osdl.org ([65.172.181.4]:1447 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261331AbVFBUtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 16:49:40 -0400
Date: Thu, 2 Jun 2005 13:50:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org, ak@suse.de,
       nanhai.zou@intel.com, rohit.seth@intel.com, rajesh.shah@intel.com
Subject: Re: [Patch] x86_64: TASK_SIZE fixes for compatibility mode
 processes
Message-Id: <20050602135013.4cba3ae2.akpm@osdl.org>
In-Reply-To: <20050602133256.A14384@unix-os.sc.intel.com>
References: <20050602133256.A14384@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
>
> +#define TASK_SIZE_OF(child) 	((test_tsk_thread_flag(child, TIF_IA32)) ? IA32_PAGE_OFFSET : TASK_SIZE64)

The task size is an attribute of the task's mm_struct, not of the task.

The place where this tends to come unstuck is when a 32-bit task holds a
reference on a 64-bit tasks's task_struct via a read of a /proc file.  If
the 64-bit task exits then it is the 32-bit task who does the final freeing
of the 64-bit tasks's task_struct and mm_struct.  (and all vice-versa, of
course).  Will your patch handle this race scenario correctly?

I don't have much confidence that we'll get all this stuff right until we
move the task-size info into the mm_struct proper.  Testing the "size" of a
task would then be done via:

	if (task->mm->mm_size == MM_SIZE_32)

or whatever.  Although I suspect the number of places where we need to work
out the "size" of a task would fall markedly.
