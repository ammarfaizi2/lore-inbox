Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266731AbUHIQuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266731AbUHIQuU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 12:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266740AbUHIQuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 12:50:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1154 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266731AbUHIQuJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 12:50:09 -0400
Date: Mon, 9 Aug 2004 12:50:09 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Vladislav Bolkhovitin <vst@vlnb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 bitops.h commentary on instruction reordering
Message-ID: <20040809155009.GB6361@logos.cnet>
References: <20040805200622.GA17324@logos.cnet> <411392E0.6080507@vlnb.net> <20040806143359.GC20911@logos.cnet> <4113A579.5060702@vlnb.net> <20040806155328.GA21546@logos.cnet> <4113B752.7050808@vlnb.net> <20040806170931.GA21683@logos.cnet> <411794E8.6000806@vlnb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411794E8.6000806@vlnb.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 07:14:48PM +0400, Vladislav Bolkhovitin wrote:
> Marcelo Tosatti wrote:
> >>>Yes correct. *mb() usually imply barrier(). 
> >>>
> >>>About the flush, each architecture defines its own instruction for doing 
> >>>so,
> >>>PowerPC has  "sync" and "isync" instructions (to flush the whole cache 
> >>>and instruction cache respectively), MIPS has "sync" and so on..
> >>
> >>So, there is no platform independent way for doing that in the kernel?
> >
> >
> >Not really. x86 doesnt have such an instruction.
> 
> But how then spin_lock() works? It guarantees memory sync between CPUs, 
> doesn't it? Otherwise how can it prevent possible races with concurrent 
> data modifications?

It makes use of the "lock" instruction to lock the bus before the "dec" instruction:
                                                                                                                                                                                   
#define spin_lock_string \
        "\n1:\t" \
        "lock ; decb %0\n\t" \
        "js 2f\n" \

That way it prevent races wrt other CPUs. atomic accesses which need to modify 
(atomic_inc, atomic_dec, etc) data also use the "lock" to prevent other CPUs 
from reading the data. 

grep for "lock" in include/asm-i386/.

As hpa said, most x86 instructions (except SSE-related ones) are
strictly ordered (except the cases Alan pointed, which were not known 
to me).

Thats why there is no "sync"-like instruction on x86 (again, except SSE-related 
ones).

This is just a simple and short explanation of how this works. It gets more complex
you think about cache coherency between processors, etc. For more details 
the best book probably is "UNIX Systems for Modern Architectures. 
Symmetric Multiprocessing and Caching for Kernel Programming" - Curt Schimmel (which 
has been suggested here over and over).

I hope that helps.

