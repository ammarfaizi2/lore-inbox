Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWI1Xda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWI1Xda (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 19:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWI1Xda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 19:33:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63369 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751138AbWI1Xd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 19:33:29 -0400
Date: Thu, 28 Sep 2006 16:32:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>,
       Hugh Dickens <hugh@veritas.com>,
       Michael Ellerman <michael@ellerman.id.au>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH RFC 1/4] Generic BUG handling.
Message-Id: <20060928163256.aa53b8d7.akpm@osdl.org>
In-Reply-To: <20060928225452.229936605@goop.org>
References: <20060928225444.439520197@goop.org>
	<20060928225452.229936605@goop.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 15:54:45 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> This patch adds common handling for kernel BUGs, for use by
> architectures as they wish.  The code is derived from arch/powerpc.
> 
> The advantages of having common BUG handling are:
>  - consistent BUG reporting across architectures
>  - shared implementation of out-of-line file/line data
> 
> This means that in inline impact of BUG is just the illegal
> instruction itself, which is an improvement for i386 and x86-64.
> 
> A BUG is represented in the instruction stream as an illegal
> instruction, which has file/line/function information associated with
> it.  This extra information is stored in the __bug_table section in
> the ELF file.
> 
> When the kernel gets an illegal instruction, it first confirms it
> might possibly be from a BUG (ie, in kernel mode, the right illegal
> instruction).  It then calls report_bug().  This searches __bug_table
> for a matching instruction pointer, and if found, prints the
> corresponding file/line/function information.
> 
> Some architectures (powerpc) implement WARN using the same mechanism;
> if the illegal instruction was the result of a WARN, then report_bug()
> returns 1; otherwise it returns 0.

Neato.

> lib/bug.c keeps a list of loaded modules which can be searched for
> __bug_table entries.  The architecture must call
> module_bug_finalize()/module_bug_cleanup() from its corresponding
> module_finalize/cleanup functions.

What is the locking for these lists?  I don't see much in here.  It has
implications for code which wants to do BUG while holding that lock..

> This patch also converts i386, x86-64 and powerpc to use this
> infrastructure.  I have only tested i386; x86-64 and powerpc are not
> even compile-tested in this patch.
> 
> Because powerpc also records the function name, I added this to i386
> and x86-64 for consistency.  Strictly speaking the function name is
> redundant with kallsyms, so perhaps it can be dropped from powerpc.

I agree that the function name is a rather gratuitous space-consumer.

> +#ifdef CONFIG_GENERIC_BUG
> +	/* Support for BUG */
> +	struct list_head bug_list;
> +	struct bug_entry *bug_table;
> +	unsigned num_bugs;

Shouldn't this be u64? ;)

