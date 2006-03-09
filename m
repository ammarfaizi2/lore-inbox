Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932682AbWCIAzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932682AbWCIAzd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 19:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932685AbWCIAzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 19:55:33 -0500
Received: from detroit.securenet-server.net ([209.51.153.26]:61928 "EHLO
	detroit.securenet-server.net") by vger.kernel.org with ESMTP
	id S932682AbWCIAzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 19:55:31 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
Date: Wed, 8 Mar 2006 16:55:13 -0800
User-Agent: KMail/1.9.1
Cc: David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Alan Cox <alan@redhat.com>, akpm@osdl.org, mingo@redhat.com,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0603081115300.32577@g5.osdl.org> <19984.1141846302@warthog.cambridge.redhat.com> <17423.30789.214209.462657@cargo.ozlabs.ibm.com>
In-Reply-To: <17423.30789.214209.462657@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603081655.13672.jbarnes@virtuousgeek.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - detroit.securenet-server.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - virtuousgeek.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 8, 2006 4:35 pm, Paul Mackerras wrote:
> David Howells writes:
> > On NUMA PowerPC, should mmiowb() be a SYNC or an EIEIO instruction
> > then? Those do inter-component synchronisation.
>
> We actually have quite heavy synchronization in read*/write* on PPC,
> and mmiowb can safely be a no-op.  It would be nice to be able to have
> lighter-weight synchronization, but I'm sure we would see lots of
> subtle driver bugs cropping up if we did.  write* do a full memory
> barrier (sync) after the store, and read* explicitly wait for the data
> to come back before.
>
> If you ask me, the need for mmiowb on some platforms merely shows that
> those platforms' implementations of spinlocks and read*/write* are
> buggy...

Or maybe they just wanted to keep them fast.  I don't know why you 
compromised so much in your implementation of read/write and 
lock/unlock, but given how expensive synchronization is, I'd think it 
would be better in the long run to make the barrier types explicit (or 
at least a subset of them) to maximize performance.  The rules for using 
the barriers really aren't that bad... for mmiowb() you basically want 
to do it before an unlock in any critical section where you've done PIO 
writes.  

Of course, that doesn't mean there isn't confusion about existing 
barriers.  There was a long thread a few years ago (Jes worked it all 
out, iirc) regarding some subtle memory ordering bugs in the tty layer 
that ended up being due to ia64's very weak spin_unlock ordering 
guarantees (one way memory barrier only), but I think that's mainly an 
artifact of how ill defined the semantics of the various arch specific 
routines are in some cases.

That's why I suggested in an earlier thread that you enumerate all the 
memory ordering combinations on ppc and see if we can't define them all.  
Then David can roll the implicit ones up into his document, or we can 
add the appropriate new operations to the kernel.  Really getting 
barriers right shouldn't be much harder than getting DMA mapping right, 
from a driver writers POV (though people often get that wrong I guess).

Jesse
