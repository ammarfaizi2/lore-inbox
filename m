Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbTJRAuj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 20:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbTJRAuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 20:50:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:11756 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261267AbTJRAuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 20:50:24 -0400
Date: Fri, 17 Oct 2003 17:49:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: davidm@hpl.hp.com
Cc: bjorn.helgaas@hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] prevent "dd if=/dev/mem" crash
Message-Id: <20031017174955.6c710949.akpm@osdl.org>
In-Reply-To: <16272.34681.443232.246020@napali.hpl.hp.com>
References: <200310171610.36569.bjorn.helgaas@hp.com>
	<20031017155028.2e98b307.akpm@osdl.org>
	<200310171725.10883.bjorn.helgaas@hp.com>
	<20031017165543.2f7e9d49.akpm@osdl.org>
	<16272.34681.443232.246020@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger <davidm@napali.hpl.hp.com> wrote:
>
> >>>>> On Fri, 17 Oct 2003 16:55:43 -0700, Andrew Morton <akpm@osdl.org> said:
> 
>   >> If we really believe copy_*_user() must correctly handle *all* faults,
>   >> isn't the "p >= __pa(high_memory)" test superfluous?
> 
>   Andrew> This code was conceived before my time and I don't recall seeing much
>   Andrew> discussion, so this is all guesswork..
> 
>   Andrew> I'd say that the high_memory test _is_ superfluous and that
>   Andrew> if anyone cared, we would remove it and establish a
>   Andrew> temporary pte against the address if it was outside the
>   Andrew> direct-mapped area.  But nobody cares enough to have done
>   Andrew> anything about it.
> 
> What about memory-mapped device registers?  Isn't all memory
> physically contiguous on x86 and that's why the "p >=
> __pa(high_memory)" test saves you from that?

We _want_ to be able to read mmio ranges via /dev/mem, don't we?  I guess
it has never come up because everyone uses kmem.

>   >> On ia64, a read to non-existent physical memory causes the processor
>   >> to time out and take a machine check.  I'm not sure it's even possible
>   >> to recover from that.
> 
>   Andrew> ick.  That would be very poor form.
> 
> Reasonable people can disagree on that.

nah ;)

> One philosophy states that if
> your kernel touches random addresses, it's better to signal a visible
> error (machine-check) than to risk silent data corruption.

An access to an illegal address should generate a fault, period.  This puts
the processing into the hands of software.  If software chooses to silently
ignore the fault (ie: "silent data corruption") then it is poorly designed.

If the hardware doesn't give the system programmer a choice then the
hardware is poorly designed, surely?

