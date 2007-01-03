Return-Path: <linux-kernel-owner+w=401wt.eu-S1750864AbXACPXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbXACPXe (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 10:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbXACPXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 10:23:34 -0500
Received: from gate.crashing.org ([63.228.1.57]:46944 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863AbXACPXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 10:23:34 -0500
In-Reply-To: <20070102.203417.102576086.davem@davemloft.net>
References: <bb0d56f649449edb8b5cc0e1c12ede29@kernel.crashing.org> <20070102.140504.71092282.davem@davemloft.net> <f07fd44aab26bf553ecdab5be5ee962e@kernel.crashing.org> <20070102.203417.102576086.davem@davemloft.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1a41c67ddc85c317d358b32a274babdf@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, devel@laptop.org, dmk@flex.com,
       benh@kernel.crashing.org, wmb@firmworks.com, jg@laptop.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Date: Wed, 3 Jan 2007 16:23:53 +0100
To: David Miller <davem@davemloft.net>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> therefore you can't let multiple CPUs call
>>> into OFW at one time.  You must use some kind of locking mechanism,
>>> and that locking mechanism is not simple because it has to not just
>>> stop the other cpus, it has to be able to stop the other cpus yet
>>> still allow them to receive SMP cross-calls from the firmware if the
>>> OFW call is 'stop' or similar.
>>
>> YOu don't need to *stop* the other CPUs, you just need to
>> prevent them from entering the client interface.  Put a lock
>> in front.
>
> That's not the issue.
>
> If the global OFW lock disables interrupts,

Why would it?

> other cpus trying to get
> that lock can't receive CPU cross calls since they are delivered via
> interrupts, get it?  That's the issue you need to be careful about.

Yes I "get it", thank you.  I don't see it as an insurmountable
problem though, even if it exists at all.

>> Okay -- so answer the second part of my concern please: if you keep
>> a copy, you need to keep both in sync -- that means every change
>> by the kernel has to be done twice, and you won't ever be told about
>> changes by the OF, so you have to get a full fresh copy every single
>> time you return from an OF client call that could have changed a
>> property.
>
> Sure, you need to call OFW when a property is changed, and we have
> code to handle that perfectly fine in the sparc of_*() code.
>
> There are mechanisms on the OFW implementations that do hot plugging
> to learn about the OFW tree changes.  On some sparc64 platforms,
> for example, you have to do a "SUNW,foo-operation" OFW call when a
> board is hot-plugged in an Ex000 enterprise box, and after that call
> finishes successfully, you know where the new board is in the OFW
> tree so you import everything underneath.  You do the opposite for
> a hot-unplug sequence.
>
> Every platform is going to handle this differently.

Yes.

> But there is nothing about it that precludes doing an in-kernel
> OFW tree.

Nothing _precludes_ doing that of course.  And it is good
to have an in-kernel tree obviously, you pretty much need
one to make the connection between the OF device tree and
the kernel notion of devices.  I'm just saying that you
shouldn't consider the kernel copy the "master", unless of
course you killed OF.

> Even the most brute-force implementation is possible.  When any
> hot-plug event occurs, validate the current in-kernel tree.  It's that
> easy.

On more events than just hot-plug, but yes.  Now consider the
consequences: no part of the kernel can hang on to a reference
to a property, or a device node, while any such event can happen
(at least if it requires the data in there to still be valid ;-) )

This means that anything that uses the device tree always should
go over some accessor functions and get all the info they need
at once, not wait until later.

> I guess it's good to have someone like you, the dissenter in the
> group, but Ben and I will snuff you out completely soon enough :-)))

Heh.  I guess I look at the problem more from the OF side, and
you more from the SPARC kernel side, and Ben of course more from
the PowerPC kernel side.  That doesn't make me a "dissenter", we
all have (mostly) the same goal in the end.


Segher

