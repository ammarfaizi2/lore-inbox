Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbTDDUcU (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 15:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbTDDUcU (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 15:32:20 -0500
Received: from enigma.lanl.gov ([128.165.250.185]:32387 "EHLO enigma.lanl.gov")
	by vger.kernel.org with ESMTP id S261353AbTDDUcP (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 15:32:15 -0500
Date: Fri, 4 Apr 2003 13:43:45 -0700
From: hendriks@lanl.gov
To: Christoph Hellwig <hch@infradead.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: Syscall numbers for BProc
Message-ID: <20030404204344.GF15620@lanl.gov>
References: <20030404193218.GD15620@lanl.gov> <20030404203531.A29501@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404203531.A29501@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 08:35:31PM +0100, Christoph Hellwig wrote:
> On Fri, Apr 04, 2003 at 12:32:18PM -0700, Erik Hendriks wrote:
> > Is it possible to get a Linux system call number allocated for BProc?
> > (http://sourceforge.net/projects/bproc) I've been using arbitrary
> > system call numbers for a while but there have been collisions with
> > new kernel features.  I'd like to avoid that in the future.  BProc
> > currently works on 2.4.x kernels on x86, alpha and ppc (32bit).
> 
> Please explain why you need syscalls and the exact APIs.

bproc provides a bunch of transparent remote management for remote
processes in a cluster.  (i.e. 'ps' shows everythign in the cluster,
kills work remotely, etc.)  There are also process migration
mechanisms to place processes on different nodes in the cluster.

The process migration stuff is what I want the system call for.  The
simplest case is the "bproc_move(int x)" call which a process uses to
move itself to another node.  In order to migrate a process to another
node, BProc needs access to ALL the processors's state.  Normally,
this stuff is saved at system call entry and it appears on the stack
for the system call handler.  However, on some architectures
(e.g. alpha) not all the cpu state is saved there.  Some of the
registers (the callee-saved ones - I'm a little fuzzy on terminology
here) are saved elsewhere (to unpredictable locations on the stack)
and I can't get to them anymore if the syscall handler doesn't get
called directly.

As a result, on alpha, I have a special bit of ASM code as the syscall
handler which saves all the registers right away.  This system call
entry is very similar to the special system call entry for fork on
that architecture.

The same problem exists on the receiving end of the process migration
- except in that case the process registers need to be written.

On most architectures you might be able to get away with the
assumption that registers are at offset X from the beginning of the
kernel stack.  I would regard that as pretty ugly though.

- Erik




BProc's process migration and 
The way it's implemented today, the process migration calls depend on
stack build-up at syscall entry.

  Specifically, if bproc is going to
replace the contents of a process it needs to be able to modify all
the registers in the user process.

On some architectures (e.g. alpha) not everything is saved at syscall entry.

- Erik
