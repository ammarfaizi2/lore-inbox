Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWCCWEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWCCWEl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 17:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWCCWEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 17:04:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38815 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750746AbWCCWEk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 17:04:40 -0500
Date: Fri, 3 Mar 2006 14:04:21 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: David Howells <dhowells@redhat.com>, akpm@osdl.org, mingo@redhat.com,
       jblunck@suse.de, bcrl@linux.intel.com, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linuxppc64-dev@ozlabs.org
Subject: Re: Memory barriers and spin_unlock safety
In-Reply-To: <1141419966.3888.67.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0603031357110.22647@g5.osdl.org>
References: <32518.1141401780@warthog.cambridge.redhat.com> 
 <Pine.LNX.4.64.0603030823200.22647@g5.osdl.org> <1141419966.3888.67.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Mar 2006, Benjamin Herrenschmidt wrote:
> 
> The main problem I've had in the past with the ppc barriers is more a
> subtle thing in the spec that unfortunately was taken to the word by
> implementors, and is that the simple write barrier (eieio) will only
> order within the same storage space, that is will not order between
> cacheable and non-cacheable storage.

If so, a simple write barrier should be sufficient. That's exactly what 
the x86 write barriers do too, ie stores to magic IO space are _not_ 
ordered wrt a normal [smp_]wmb() (or, as per how this thread started, a 
spin_unlock()) at all.

On x86, we actually have this "CONFIG_X86_OOSTORE" configuration option 
that gets enable for you select a WINCHIP device, because that allows a 
weaker memory ordering for normal memory too, and that will end up using 
an "sfence" instruction for store buffers. But it's not normally enabled.

So the eieio should be sufficient,then.

Of course, the x86 store buffers do tend to flush out stuff after a 
certain cycle-delay too, so there may be drivers that technically are 
buggy on x86, but where the store buffer in practice is small and flushes 
out quickly enough that you'll never _see_ the bug.

> Actually, the ppc's full barrier (sync) will generate bus traffic, and I
> think in some case eieio barriers can propagate to the chipset to
> enforce ordering there too depending on some voodoo settings and wether
> the storage space is cacheable or not.

Well, the regular kernel ops definitely won't depend on that, since that's 
not the case anywhere else.

		Linus
