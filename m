Return-Path: <linux-kernel-owner+w=401wt.eu-S1754239AbXACEeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239AbXACEeT (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 23:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754244AbXACEeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 23:34:19 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:48979
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754238AbXACEeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 23:34:19 -0500
Date: Tue, 02 Jan 2007 20:34:17 -0800 (PST)
Message-Id: <20070102.203417.102576086.davem@davemloft.net>
To: segher@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, devel@laptop.org, dmk@flex.com,
       benh@kernel.crashing.org, wmb@firmworks.com, jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: David Miller <davem@davemloft.net>
In-Reply-To: <f07fd44aab26bf553ecdab5be5ee962e@kernel.crashing.org>
References: <bb0d56f649449edb8b5cc0e1c12ede29@kernel.crashing.org>
	<20070102.140504.71092282.davem@davemloft.net>
	<f07fd44aab26bf553ecdab5be5ee962e@kernel.crashing.org>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Wed, 3 Jan 2007 01:48:02 +0100

> > therefore you can't let multiple CPUs call
> > into OFW at one time.  You must use some kind of locking mechanism,
> > and that locking mechanism is not simple because it has to not just
> > stop the other cpus, it has to be able to stop the other cpus yet
> > still allow them to receive SMP cross-calls from the firmware if the
> > OFW call is 'stop' or similar.
> 
> YOu don't need to *stop* the other CPUs, you just need to
> prevent them from entering the client interface.  Put a lock
> in front.

That's not the issue.

If the global OFW lock disables interrupts, other cpus trying to get
that lock can't receive CPU cross calls since they are delivered via
interrupts, get it?  That's the issue you need to be careful about.

> > Please let's get over this memory consumption non-issue and move
> > on to more productive talk.
> 
> Okay -- so answer the second part of my concern please: if you keep
> a copy, you need to keep both in sync -- that means every change
> by the kernel has to be done twice, and you won't ever be told about
> changes by the OF, so you have to get a full fresh copy every single
> time you return from an OF client call that could have changed a
> property.

Sure, you need to call OFW when a property is changed, and we have
code to handle that perfectly fine in the sparc of_*() code.

There are mechanisms on the OFW implementations that do hot plugging
to learn about the OFW tree changes.  On some sparc64 platforms,
for example, you have to do a "SUNW,foo-operation" OFW call when a
board is hot-plugged in an Ex000 enterprise box, and after that call
finishes successfully, you know where the new board is in the OFW
tree so you import everything underneath.  You do the opposite for
a hot-unplug sequence.

Every platform is going to handle this differently.

But there is nothing about it that precludes doing an in-kernel
OFW tree.

Even the most brute-force implementation is possible.  When any
hot-plug event occurs, validate the current in-kernel tree.  It's that
easy.

I guess it's good to have someone like you, the dissenter in the
group, but Ben and I will snuff you out completely soon enough :-)))
