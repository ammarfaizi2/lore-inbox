Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267689AbUHWVyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267689AbUHWVyc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 17:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267841AbUHWVxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 17:53:04 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:56462 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S268128AbUHWVjN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 17:39:13 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 23 Aug 2004 14:39:06 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Andi Kleen <ak@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] lazy TSS's I/O bitmap copy ...
In-Reply-To: <20040823233249.09e93b86.ak@suse.de>
Message-ID: <Pine.LNX.4.58.0408231436370.3222@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.58.0408231311460.3221@bigblue.dev.mdolabs.com>
 <20040823233249.09e93b86.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2004, Andi Kleen wrote:

> On Mon, 23 Aug 2004 14:23:35 -0700 (PDT)
> Davide Libenzi <davidel@xmailserver.org> wrote:
> 
> > 
> > The following patch implements a lazy I/O bitmap copy for the i386 
> > architecture. With I/O bitmaps now reaching considerable sizes, if the 
> > switched task does not perform any I/O operation, we can save the copy 
> > altogether. In my box X is working fine with the following patch, even if 
> > more test would be required.
> 
> IMHO this needs benchmarks first to prove that the additional 
> exception doesn't cause too much slow down.

Yes, of course.


> >  asmlinkage void do_general_protection(struct pt_regs * regs, long error_code)
> >  {
> > +	int cpu = smp_processor_id();
> > +	struct tss_struct *tss = init_tss + cpu;
> > +	struct task_struct *tsk = current;
> > +	struct thread_struct *tsk_th = &tsk->thread;
> > +
> > +	/*
> > +	 * Perform the lazy TSS's I/O bitmap copy. If the TSS has an
> > +	 * invalid offset set (the LAZY one) and the faulting thread has
> > +	 * a valid I/O bitmap pointer, we copy the I/O bitmap in the TSS
> > +	 * and we set the offset field correctly. Then we let the CPU to
> > +	 * restart the faulting instruction.
> > +	 */
> 
> I don't like it very much that most GPFs will be executed twice now
> when the process has ioperm enabled.
> This will confuse debuggers and could have other bad side effects.
> Checking the EIP would be better.

The eventually double GPF would happen only on TSS-IObmp-lazy tasks, ie 
tasks using the I/O bitmap. The check for the I/O opcode can certainly be 
done though, even if it'd make the code a little bit more complex.



- Davide

