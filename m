Return-Path: <linux-kernel-owner+w=401wt.eu-S1755409AbXABV2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755409AbXABV2h (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 16:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754952AbXABV2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 16:28:37 -0500
Received: from gate.crashing.org ([63.228.1.57]:40318 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754961AbXABV2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 16:28:37 -0500
In-Reply-To: <1167768735.6165.68.camel@localhost.localdomain>
References: <459714A6.4000406@firmworks.com> <20061230.211941.74748799.davem@davemloft.net> <459784AD.1010308@firmworks.com> <1167709992.6165.18.camel@localhost.localdomain> <24a109a8fa0f45011daf3e2b55172392@kernel.crashing.org> <1167768735.6165.68.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <bb0d56f649449edb8b5cc0e1c12ede29@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, devel@laptop.org,
       David Miller <davem@davemloft.net>, David Kahn <dmk@flex.com>,
       Mitch Bradley <wmb@firmworks.com>, jg@laptop.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Date: Tue, 2 Jan 2007 22:28:21 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Not single thread -- but a "global OF lock" yes.  Not that
>> it matters too much, (almost) all property accesses are init
>> time anyway (which is effectively single threaded).
>
> Not that true anymore. A lot of driver probe is being threaded 
> nowadays,
> either bcs of the new multithread probing bits, or because they get
> loaded by userland from some initramfs etc..

The kernel doesn't care if one CPU is in OF land while the others
are doing other stuff -- well you have to make sure the OF won't
try to use a hardware device at the same time as the kernel, true.

>>> Finally, you can't have something as simple as powerpc's 
>>> get_property()
>>> (that just returns a pointer to the property content) with direct OF
>>> access unless you use some magic static buffer or some crap around
>>> those
>>> lines, or add passing of a buffer in, so from a driver pointer of 
>>> view,
>>> the interface provided by powerpc/sparc is nicer.
>>
>> But since you have a _put() function anyway, for your reference
>> counting, having magic (automatically allocated, not static of
>> course) buffers works just fine.
>
> You can maybe create an in-memory cache of all properties in a node 
> from
> whatever function that returns a node pointer and dispose of them on
> _put(), that would allow to keep the get_property semantics as-is with 
> a
> "live" tree, but I still don't see the point

I'm a bit concerned about the 100kB or so of data duplication
(on a *quite big* device tree), and the extra code you need
(all changes have to be done to both tree copies).  Maybe
I shouldn't be worried; still, it's obviously not a great
idea to *require* any arch to get and keep a full copy of
the tree -- it's wasteful and unnecessary.


Segher

