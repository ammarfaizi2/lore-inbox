Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbTJTPSZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 11:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbTJTPSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 11:18:25 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:41160 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S262598AbTJTPSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 11:18:21 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] prevent "dd if=/dev/mem" crash
Date: Mon, 20 Oct 2003 09:17:10 -0600
User-Agent: KMail/1.5.3
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200310171610.36569.bjorn.helgaas@hp.com> <20031017165543.2f7e9d49.akpm@osdl.org> <16272.34681.443232.246020@napali.hpl.hp.com>
In-Reply-To: <16272.34681.443232.246020@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310200917.11074.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 October 2003 6:21 pm, David Mosberger wrote:
> What about memory-mapped device registers?  Isn't all memory
> physically contiguous on x86 and that's why the "p >=
> __pa(high_memory)" test saves you from that?

As others have mentioned, using read/write on /dev/mem to get at
memory-mapped registers is unlikely to work on ia64 anyway, because
read/write use cacheable mappings.  Using mmap does work (using
uncacheable mappings), and my patch doesn't change that path.

>   >> On ia64, a read to non-existent physical memory causes the processor
>   >> to time out and take a machine check.  I'm not sure it's even possible
>   >> to recover from that.
> 
>   Andrew> ick.  That would be very poor form.
> 
> Reasonable people can disagree on that.  One philosophy states that if
> your kernel touches random addresses, it's better to signal a visible
> error (machine-check) than to risk silent data corruption.

It occurred to me over the weekend that part of this confusion is
related to the fact that ia64 doesn't have page tables for the
kernel identity-mapped segments.  (We're talking about reading
physical memory, but read/write_mem() actually convert the address
using __va() before doing the copy.)

I bet that ia32 does have page tables for this case, and that
an attempt to read non-existent physical memory will cause a TLB
miss from which copy_*_user() can easily recover.

On ia64, the same TLB miss would occur, but since there are no page
tables, the miss handler assumes the kernel knows what it is doing
and happily synthesizes a mapping that points nowhere.

Bjorn

