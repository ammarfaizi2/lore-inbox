Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWIKAzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWIKAzc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 20:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWIKAzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 20:55:32 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:12997 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S964866AbWIKAzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 20:55:31 -0400
In-Reply-To: <200609101725.49234.jbarnes@virtuousgeek.org>
References: <17666.11971.416250.857749@cargo.ozlabs.ibm.com> <1157916919.23085.24.camel@localhost.localdomain> <1157923513.31071.256.camel@localhost.localdomain> <200609101725.49234.jbarnes@virtuousgeek.org>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0828ADEB-0F0E-49FC-82BE-CFA15B7D3829@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, David Miller <davem@davemloft.net>,
       jeff@garzik.org, paulus@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Opinion on ordering of writel vs. stores to RAM
Date: Mon, 11 Sep 2006 02:54:29 +0200
To: Jesse Barnes <jbarnes@virtuousgeek.org>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>  - writel/readl become totally ordered (including vs. memory).
>> Basically x86-like. Expensive (very expensive even on some
>> architectures) but also very safe.
>
> This approach will minimize driver changes, and would imply the  
> removal
> of some existing mmiowb() and wmb() macros.

Like I tried to explain already, in my competing approach, no drivers
would need changes either.  And you could remove those macro's (or
their more-verbosely-saying-what-their-doing, preferably bus-specific
as well) as well -- but you'll face the wrath of those who care about
performance of those drivers on non-x86 platforms.

> This is what mmiowb() is supposed to be, though only for writes.  I.e.
> two writes from different CPUs may arrive out of order if you don't  
> use
> mmiowb() carefully.  Do you also need a mmiorb() macro or just a
> stronger mmiob()?

I'd name this barrier pci_cpu_to_cpu_barrier() -- what it is supposed
to do is order I/O accesses from the same device driver to the same
device, from different CPUs.  The same driver is never concurrently
running on more than one CPU right now, which is a fine model.

I include "pci_" in the name, so that we can distinguish between
different bus types, which after all have different ordering rules.
PCI is a very common bus type of course, which explains why there
is mmiowb() and no ..rb() -- this is simply not needed on PCI
(PCI MMIO reads are _always_ slow -- non-posted accesses, in PCI
terminology).

> mmiowb() could be written as io_to_io_write_barrier() if we wanted  
> to be
> extra verbose.  AIUI it's the same thing as smb_wmb() but for MMIO
> space.

Except that "main-memory" ("coherent domain") accesses are always
atomic as far as this ordering is concerned -- starting a transaction
and having its result are not separately observable.  For I/O this
is different -- the whole point of mmiowb() was that although without
it the device drivers _start_ the transactions in the right order just
fine, the order the I/O adapters see them might be different (because
there are multiple paths from different CPUs to the same I/O adapter, or
whatnot).

Hence my proposal of calling it pci_cpu_to_cpu_barrier() -- what it
orders is accesses from separate CPUs.  Oh, and it's bus-specific,
of course.


Segher

