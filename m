Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129321AbRBPSha>; Fri, 16 Feb 2001 13:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130821AbRBPShU>; Fri, 16 Feb 2001 13:37:20 -0500
Received: from [62.172.234.2] ([62.172.234.2]:48231 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129321AbRBPShR>; Fri, 16 Feb 2001 13:37:17 -0500
Date: Fri, 16 Feb 2001 18:36:58 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Manfred Spraul <manfred@colorfullife.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        bcrl@redhat.com
Subject: Re: x86 ptep_get_and_clear question
In-Reply-To: <20010216183707.A4821@pcep-jamie.cern.ch>
Message-ID: <Pine.LNX.4.21.0102161810350.1977-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2001, Jamie Lokier wrote:
> 
> > And check the Pentium III erratas. There is one with the tlb
> > that's only triggered if 4 instruction lie in a certain window and all
> > access memory in the same way of the tlb (EFLAGS incorrect if 'andl
> > mask,<memory_addr>' causes page fault)).
> 
> Nasty, but I don't see what an obscure and impossible to work around
> processor bug has to do with this thread.  It doesn't actually change
> page fault handling, does it?

Obscure but not nasty: the copy of EFLAGS pushed onto the stack when
taking the fault is wrong, but once the instruction is restarted it
all sorts itself out (as I understand from the Spec Update).
Possible to work around, but just not worth the effort.

Nastier was its precursor, Pentium Pro Erratum #63, generated under
similar conditions: where the wrong (carry bit of) EFLAGS when faulting
in the middle of ADC, SBB, RCR or RCL could cause a wrong arithmetic
result when restarted.  Perfectly possible to work around (only lower
permissions of a pte visible on another CPU while that CPU is pulled
into the kernel with an IPI), and necessary to work around it back
then (4 years ago) when the Pentium Pro was at the leading edge;
but I doubt it's worth redesigning now to suit an old erratum.

These errata do make the point that, whatever x86 specs say should
happen, Intel sometimes fails to match them; and the SMP TLB area
was certainly prone to errata at the time of the Pentium Pro -
but hopefully that means Intel exercise greater care there now.

Hugh

