Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265437AbTFSQ2m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 12:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265752AbTFSQ2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 12:28:42 -0400
Received: from ns.suse.de ([213.95.15.193]:59396 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265437AbTFSQ2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 12:28:37 -0400
To: Ray Bryant <raybry@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Bug in __pollwait() can cause select() and poll() to hang in   2.4.21
References: <3EF1D830.F12113D@sgi.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 19 Jun 2003 18:42:31 +0200
In-Reply-To: <3EF1D830.F12113D@sgi.com.suse.lists.linux.kernel>
Message-ID: <p733ci65894.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Bryant <raybry@sgi.com> writes:
> 
>      select() and poll() call a common routine: __pollwait().  On the
> first call to __pollwait(), it calls __get_free_page(GFP_KERNEL) to
> allocate a table to hold wait queues.  In the natural course of things,
> this calls into __alloc_pages().  In low memory situations, the process
> can then end up in the rebalance code at the bottom of __alloc_pages()
> where there is a call to yield().  If the process makes this call, this
> is a bad thing [tm], since the process state at that point is
> TASK_INTERRUPTIBLE.  There is no wait queue yet for the process (that is
> done later in __pollwait()) and no schedule timeout event has yet been
> created (that is done later in select()) so the process will never
> return from the call to yield().

Nasty bug. How about adding a BUG() for current->state != TASK_RUNNING at 
the beginning of __alloc_pages unless GFP_ATOMIC is set?

-Andi
