Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbTIJJoU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 05:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbTIJJoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 05:44:20 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:55009 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261273AbTIJJoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 05:44:19 -0400
Date: Wed, 10 Sep 2003 11:44:15 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Luca Veraldi <luca.veraldi@katamail.com>
Cc: arjanv@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Efficient IPC mechanism on Linux
Message-ID: <20030910114414.B14352@devserv.devel.redhat.com>
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <20030909175821.GL16080@Synopsys.COM> <001d01c37703$8edc10e0$36af7450@wssupremo> <20030910064508.GA25795@Synopsys.COM> <015601c3777c$8c63b2e0$5aaf7450@wssupremo> <1063185795.5021.4.camel@laptop.fenrus.com> <01c601c3777f$97c92680$5aaf7450@wssupremo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <01c601c3777f$97c92680$5aaf7450@wssupremo>; from luca.veraldi@katamail.com on Wed, Sep 10, 2003 at 11:40:33AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 11:40:33AM +0200, Luca Veraldi wrote:
> To set the accessed or dirty bit you use
> 
> 38         __asm__ __volatile__( LOCK_PREFIX
> 39                 "btsl %1,%0"
> 40                 :"=m" (ADDR)
> 41                 :"Ir" (nr));
> 
> which is a ***SINGLE CLOCK CYCLE*** of cpu.
> I don't think really that on any machine Firmware 
> a btsl will require 4000 cycles.
> Neither on Intel x86.

For fun do the measurement on a pIV cpu. You'll be surprised.
The microcode "mark dirty" (which is NOT a btsl, it gets done when you do a write
memory access to the page content) result will be in the 2000 to 4000 range I
predict. There are things like SMP synchronisation to do, but also
if the cpu marks a page dirty in the page table, that means the page table
changes which means the pagetable needs to be marked in the
PMD. Which means the PMD changes, which means the PGD needs the PMD marked
dirty. Etc Etc. It's microcode. It'll take several 1000 cycles.



> > Changing pagetable content is even more because all the
> > tlb's and internal cpu state will need to be flushed... which is also a
> > microcode operation for the cpu. 
> 
> Good. The same overhead you will find accessing a message 
> after a read form a pipe. There will occur many TLB faults.
> And the same apply copying the message to the pipe.
> Many many TLB faults.

A TLB fault in the normal case is about 7 cycles. But that's for a TLB not
being present. For TLB that IS present being written to means going to
microcode.

> 
> > And it's deadly in an SMP environment.
> 
> You say "tlb's and internal cpu state will need to be flushed".
> The other cpus in an SMP environment can continue to work, indipendently.
> TLBs and cpu state registers are ***PER-CPU*** resorces.

if you change a page table, you need to flush the TLB on all other cpus
that have that same page table mapped, like a thread app running
on all cpu's at once with the same pagetables.

> Probably, it is worse the case of copying a memory page,
> because you have to hold some global lock all the time.

why would you need a global lock for copying memory ?

