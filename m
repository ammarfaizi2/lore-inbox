Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWIKBtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWIKBtY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 21:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWIKBtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 21:49:24 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:63702 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S932110AbWIKBtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 21:49:23 -0400
In-Reply-To: <1157937023.31071.289.camel@localhost.localdomain>
References: <17666.11971.416250.857749@cargo.ozlabs.ibm.com> <1157916919.23085.24.camel@localhost.localdomain> <1157923513.31071.256.camel@localhost.localdomain> <200609101725.49234.jbarnes@virtuousgeek.org> <0828ADEB-0F0E-49FC-82BE-CFA15B7D3829@kernel.crashing.org> <1157937023.31071.289.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <21EFB791-B046-4EE0-8D93-8D0BA37C1D46@kernel.crashing.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, David Miller <davem@davemloft.net>,
       jeff@garzik.org, paulus@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Opinion on ordering of writel vs. stores to RAM
Date: Mon, 11 Sep 2006 03:48:47 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Hence my proposal of calling it pci_cpu_to_cpu_barrier() -- what it
>> orders is accesses from separate CPUs.  Oh, and it's bus-specific,
>> of course.
>
> I disagree on that one, as I disagree on Jesse terminology too :)
>
> Ordering between stores issued by different CPUs has no meaning
> whatsoever unless you have locks. That is you have some kind of
> synchronisation primitive between the 2 CPUs.

And that's exactly what mmiowb() does right now -- it makes sure
the I/O ends up at some I/O hub that will keep the accesses in
order, before it allows the current CPU to continue.

> Outside of that, the
> concept of ordering doesn't make any sense.
>
> Thus the problem is really only of MMIO stores leaking out of locks,
> thus it's really a MMIO vs. lock barrier, and it's a lot easier to
> understand that way imho.

MMIO-as-seen-by-its-target vs. whatever-the-cpus-that-originated-those-
I/Os-think-the-order-is, sure.

The CPU running the "mmiowb()" needs to make sure that the mmiowb()
finished before it allows another CPU to run code that does I/O to the
same device.  I thought (most of) this was automatic in Linux (except
for the difference between a CPU doing the access, and the I/O device
seeing it, which is what mmiowb() is meant to solve)?  Or are
we just safe from all kinds of similar issues, because driver code
tends to run under interrupt locks?

Aaaaaaaanyway...  the question of what to call mmiowb() and what its
exact semantics would become, is a bit of a side issue right now, let's
discuss it later...


Segher

