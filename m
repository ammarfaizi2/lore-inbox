Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbTJRCBX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 22:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbTJRCBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 22:01:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:13218 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261267AbTJRCBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 22:01:20 -0400
Date: Fri, 17 Oct 2003 19:01:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: davidm@hpl.hp.com
Cc: bjorn.helgaas@hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] prevent "dd if=/dev/mem" crash
Message-Id: <20031017190104.6bf53ea1.akpm@osdl.org>
In-Reply-To: <16272.39921.537615.433272@napali.hpl.hp.com>
References: <200310171610.36569.bjorn.helgaas@hp.com>
	<20031017155028.2e98b307.akpm@osdl.org>
	<200310171725.10883.bjorn.helgaas@hp.com>
	<20031017165543.2f7e9d49.akpm@osdl.org>
	<16272.34681.443232.246020@napali.hpl.hp.com>
	<20031017174955.6c710949.akpm@osdl.org>
	<16272.39921.537615.433272@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger <davidm@napali.hpl.hp.com> wrote:
>
> >>>>> On Fri, 17 Oct 2003 17:49:55 -0700, Andrew Morton <akpm@osdl.org> said:
> 
>   Andrew> We _want_ to be able to read mmio ranges via /dev/mem, don't
>   Andrew> we?  I guess it has never come up because everyone uses
>   Andrew> kmem.
> 
> I just don't see how making a "dd if=/dev/mem" safe and allowing
> access to arbitrary physical memory can go to together.  Given that
> /dev/mem _is_ being used for accessing mmio space, is it really worth
> bothering trying to make such a "dd" safe?

Possibly not.  I thought that simply oopsing the kernel was a bit rude, and
fixing ia32 to not do that was relatively simple.

We should, within reason, handle it as gracefully as possible, yes?

>   Andrew> If the hardware doesn't give the system programmer a choice
>   Andrew> then the hardware is poorly designed, surely?
> 
> Emh, we're talking about _physical_ memory accesses here.  AFAIK,
> failures on physical memory accesses are never signaled with
> synchronous faults (not on any reasonably modern high performance
> architecture, at least).  Loads probably _could_ be signalled
> synchronously, but consider stores: would you really want to wait with
> retiring a store until it has made it all the way to some slow ISA
> device?  I think not (IN/OUT do that).  No, modern CPUs check the
> TLB/page-table and if that check passes, they'll _assume_ the memory
> access will complete without errors.  If it doesn't, they signal an
> asynchronous failure (e.g., via an MCA).

If the not-present memory is marked cacheable and/or writeback then yes,
but that would be an odd thing to do, wouldn't it?

It the memory is mapped noncacheable then a synchronous error on a read
sounds reasonable.  A synchronous error on a write would assume that the
noncacheability affects the write buffers and IIRC that usually doesn't
happen(?).

