Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWCHT1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWCHT1P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 14:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbWCHT1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 14:27:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51654 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932450AbWCHT1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 14:27:13 -0500
Date: Wed, 8 Mar 2006 11:26:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Alan Cox <alan@redhat.com>, akpm@osdl.org, mingo@redhat.com,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #2] 
In-Reply-To: <14275.1141844922@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0603081115300.32577@g5.osdl.org>
References: <20060308184500.GA17716@devserv.devel.redhat.com> 
 <20060308173605.GB13063@devserv.devel.redhat.com> <20060308145506.GA5095@devserv.devel.redhat.com>
 <31492.1141753245@warthog.cambridge.redhat.com> <29826.1141828678@warthog.cambridge.redhat.com>
 <9834.1141837491@warthog.cambridge.redhat.com> <11922.1141842907@warthog.cambridge.redhat.com>
  <14275.1141844922@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Mar 2006, David Howells wrote:

> Alan Cox <alan@redhat.com> wrote:
> 
> > 	spin_lock(&foo->lock);
> > 	writel(0, &foo->regnum);
> 
> I presume there only needs to be an mmiowb() here if you've got the
> appropriate CPU's I/O memory window set up to be weakly ordered.

Actually, since the different NUMA things may have different paths to the 
PCI thing, I don't think even the mmiowb() will really help. It has 
nothing to serialize _with_.

It only orders mmio from within _one_ CPU and "path" to the destination. 
The IO might be posted somewhere on a PCI bridge, and and depending on the 
posting rules, the mmiowb() just isn't relevant for IO coming through 
another path.

Of course, to get into that deep doo-doo, your IO fabric must be separate 
from the memory fabric, and the hardware must be pretty special, I think. 

So for example, if you are using an Opteron with it's NUMA memory setup 
between CPU's over HT links, from an _IO_ standpoint it's not really 
anything strange, since it uses the same fabric for memory coherency and 
IO coherency, and from an IO ordering standpoint it's just normal SMP.

But if you have a separate IO fabric and basically two different CPU's can 
get to one device through two different paths, no amount of write barriers 
of any kind will ever help you.

So in the really general case, it's still basically true that the _only_ 
thing that serializes a MMIO write to a device is a _read_ from that 
device, since then the _device_ ends up being the serialization point.

So in the exteme case, you literally have to do a read from the device 
before you release the spinlock, if ordering to the device from two 
different CPU's matters to you. The IO paths simply may not be 
serializable with the normal memory paths, so spinlocks have absolutely 
_zero_ ordering capability, and a write barrier on either the normal 
memory side or the IO side doesn't affect anything.

Now, I'm by no means claiming that we necessarily get this right in 
general, or even very commonly. The undeniable fact is that "big NUMA" 
machines need to validate the drivers they use separately. The fact that 
it works on a normal PC - and that it's been tested to death there - does 
not guarantee much anything.

The good news, of course, is that you don't use that kind of "big NUMA" 
system the same way you'd use a regular desktop SMP. You don't plug in 
random devices into it and just expect them to work. I'd hope ;)

		Linus
