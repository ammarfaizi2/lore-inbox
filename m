Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbWCCRDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWCCRDV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 12:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbWCCRDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 12:03:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9647 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030240AbWCCRDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 12:03:20 -0500
Date: Fri, 3 Mar 2006 09:03:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: akpm@osdl.org, mingo@redhat.com, jblunck@suse.de, bcrl@linux.intel.com,
       matthew@wil.cx, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: Memory barriers and spin_unlock safety 
In-Reply-To: <1146.1141404346@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0603030856260.22647@g5.osdl.org>
References: <32518.1141401780@warthog.cambridge.redhat.com> 
 <1146.1141404346@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Mar 2006, David Howells wrote:

> David Howells <dhowells@redhat.com> wrote:
> 
> > 	WRITE mtx
> > 	--> implies SFENCE
> 
> Actually, I'm not sure this is true. The AMD64 Instruction Manual's writeup of
> SFENCE implies that writes can be reordered, which sort of contradicts what
> the AMD64 System Programming Manual says.

Note that _normal_ writes never need an SFENCE, because they are ordered 
by the core.

The reason to use SFENCE is because of _special_ writes.

For example, if you use a non-temporal store, then the write buffer 
ordering goes away, because there is no write buffer involved (the store 
goes directly to the L2 or outside the bus).

Or when you talk to weakly ordered memory (ie a frame buffer that isn't 
cached, and where the MTRR memory ordering bits say that writes be done 
speculatively), you may want to say "I'm going to do the store that starts 
the graphics pipeline, all my previous stores need to be done now". 

THAT is when you need to use SFENCE.

So SFENCE really isn't about the "smp_wmb()" kind of fencing at all. It's 
about the much weaker ordering that is allowed by the special IO memory 
types and nontemporal instructions.

(Actually, I think one special case of non-temporal instruction is the 
"repeat movs/stos" thing: I think you should _not_ use a "repeat stos" to 
unlock a spinlock, exactly because those stores are not ordered wrt each 
other, and they can bypass the write queue. Of course, doing that would 
be insane anyway, so no harm done ;^).

> If this isn't true, then x86_64 at least should do MFENCE before the store in
> spin_unlock() or change the store to be LOCK'ed. The same may also apply for
> Pentium3+ class CPUs with the i386 arch.

No. But if you want to make sure, you can always check with Intel 
engineers. I'm pretty sure I have this right, though, because Intel 
engineers have certainly looked at Linux sources and locking, and nobody 
has ever said that we'd need an SFENCE.

		Linus
