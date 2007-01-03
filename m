Return-Path: <linux-kernel-owner+w=401wt.eu-S1752334AbXACArl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbXACArl (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 19:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752433AbXACArl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 19:47:41 -0500
Received: from gate.crashing.org ([63.228.1.57]:36948 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752334AbXACArk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 19:47:40 -0500
In-Reply-To: <20070102.140504.71092282.davem@davemloft.net>
References: <24a109a8fa0f45011daf3e2b55172392@kernel.crashing.org> <1167768735.6165.68.camel@localhost.localdomain> <bb0d56f649449edb8b5cc0e1c12ede29@kernel.crashing.org> <20070102.140504.71092282.davem@davemloft.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f07fd44aab26bf553ecdab5be5ee962e@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, devel@laptop.org, dmk@flex.com,
       benh@kernel.crashing.org, wmb@firmworks.com, jg@laptop.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Date: Wed, 3 Jan 2007 01:48:02 +0100
To: David Miller <davem@davemloft.net>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> Not single thread -- but a "global OF lock" yes.  Not that
>>>> it matters too much, (almost) all property accesses are init
>>>> time anyway (which is effectively single threaded).
>>>
>>> Not that true anymore. A lot of driver probe is being threaded
>>> nowadays,
>>> either bcs of the new multithread probing bits, or because they get
>>> loaded by userland from some initramfs etc..
>>
>> The kernel doesn't care if one CPU is in OF land while the others
>> are doing other stuff -- well you have to make sure the OF won't
>> try to use a hardware device at the same time as the kernel, true.
>
> True, but at the very least you have to prevent multiple cpus
> from enterring OFW.  In fact this is very important.

Yes.  "Global OF lock".

> OFW is not multi-threaded

You are not _guaranteed_ it is multithreaded, and you don't
know it's threading model (or how to do thread synchronisation).

> therefore you can't let multiple CPUs call
> into OFW at one time.  You must use some kind of locking mechanism,
> and that locking mechanism is not simple because it has to not just
> stop the other cpus, it has to be able to stop the other cpus yet
> still allow them to receive SMP cross-calls from the firmware if the
> OFW call is 'stop' or similar.

YOu don't need to *stop* the other CPUs, you just need to
prevent them from entering the client interface.  Put a lock
in front.

>> I'm a bit concerned about the 100kB or so of data duplication
>> (on a *quite big* device tree), and the extra code you need
>> (all changes have to be done to both tree copies).  Maybe
>> I shouldn't be worried; still, it's obviously not a great
>> idea to *require* any arch to get and keep a full copy of
>> the tree -- it's wasteful and unnecessary.
>
> The largest amount of memory I've ever seen consumed on sparc64
> was 76K and this is 1) 64-bit and 2) an ENORMOUS machine with
> lots of cpus and devices.  And I know because sparc64 prints
> a kernel message at boot which states how much memory was
> consumed by the in-kernel device tree copy.

The in-OF tree uses a bit more memory, depending on implementation.
It's hard to tell though, it contains so much more than the
properties-only tree, perhaps you're right.

> Please let's get over this memory consumption non-issue and move
> on to more productive talk.

Okay -- so answer the second part of my concern please: if you keep
a copy, you need to keep both in sync -- that means every change
by the kernel has to be done twice, and you won't ever be told about
changes by the OF, so you have to get a full fresh copy every single
time you return from an OF client call that could have changed a
property.


Segher

