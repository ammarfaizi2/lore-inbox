Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268010AbUHWVlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268010AbUHWVlm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 17:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268148AbUHWVjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 17:39:51 -0400
Received: from cantor.suse.de ([195.135.220.2]:65237 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268010AbUHWVc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 17:32:56 -0400
Date: Mon, 23 Aug 2004 23:32:49 +0200
From: Andi Kleen <ak@suse.de>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [patch] lazy TSS's I/O bitmap copy ...
Message-Id: <20040823233249.09e93b86.ak@suse.de>
In-Reply-To: <Pine.LNX.4.58.0408231311460.3221@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.58.0408231311460.3221@bigblue.dev.mdolabs.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2004 14:23:35 -0700 (PDT)
Davide Libenzi <davidel@xmailserver.org> wrote:

> 
> The following patch implements a lazy I/O bitmap copy for the i386 
> architecture. With I/O bitmaps now reaching considerable sizes, if the 
> switched task does not perform any I/O operation, we can save the copy 
> altogether. In my box X is working fine with the following patch, even if 
> more test would be required.

IMHO this needs benchmarks first to prove that the additional 
exception doesn't cause too much slow down.

>  asmlinkage void do_general_protection(struct pt_regs * regs, long error_code)
>  {
> +	int cpu = smp_processor_id();
> +	struct tss_struct *tss = init_tss + cpu;
> +	struct task_struct *tsk = current;
> +	struct thread_struct *tsk_th = &tsk->thread;
> +
> +	/*
> +	 * Perform the lazy TSS's I/O bitmap copy. If the TSS has an
> +	 * invalid offset set (the LAZY one) and the faulting thread has
> +	 * a valid I/O bitmap pointer, we copy the I/O bitmap in the TSS
> +	 * and we set the offset field correctly. Then we let the CPU to
> +	 * restart the faulting instruction.
> +	 */

I don't like it very much that most GPFs will be executed twice now
when the process has ioperm enabled.
This will confuse debuggers and could have other bad side effects.
Checking the EIP would be better.

-Andi
