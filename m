Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAIS23>; Tue, 9 Jan 2001 13:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129805AbRAIS2T>; Tue, 9 Jan 2001 13:28:19 -0500
Received: from ns.caldera.de ([212.34.180.1]:41228 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129383AbRAIS2L>;
	Tue, 9 Jan 2001 13:28:11 -0500
Date: Tue, 9 Jan 2001 19:27:07 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rik van Riel <riel@conectiva.com.br>, "David S. Miller" <davem@redhat.com>,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010109192707.A20536@caldera.de>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Rik van Riel <riel@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010109113145.A28758@caldera.de> <Pine.LNX.4.30.0101091132520.1159-100000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.30.0101091132520.1159-100000@e2>; from mingo@elte.hu on Tue, Jan 09, 2001 at 12:05:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 12:05:59PM +0100, Ingo Molnar wrote:
> 
> On Tue, 9 Jan 2001, Christoph Hellwig wrote:
> 
> > > 2.4. In any case, the zerocopy code is 'kiovec in spirit' (uses
> > > vectors of struct page *, offset, size entities),
> 
> > Yep. That is why I was so worried aboit the writepages file op.
> 
> i believe you misunderstand. kiovecs (in their current form) are simply
> too bloated for networking purposes.

Stop.  I NEVER said you should use them internally.
My concern is too use a file operation with a kiobuf ** as main argument
instead of page *.  With a little more bloat it allows you to do the same
you do now.  But it also offers a real advantage:  you don't have to call
into the network stack for every single page, and this fits easily in Ben's
AIO stuff, so your stuff is very well integrated into the (futur) asynch IO
framework. (he latter was my main concern).

You pay 116 bytes and a few cycles for a _lot_ more abstraction and
integration.  Exactly such a design principle (design vs speed) is the cause
why UNIX survived so long.


> Due to its nature and nonpersistency,
> networking is very lightweight and memory-footprint-sensitive code (as
> opposed to eg. block IO code), right now an 'struct skb_shared_info'
> [which is roughly equivalent to a kiovec] is 12+4*6 == 36 bytes, which
> includes support for 6 distinct fragments (each fragment can be on any
> page, any offset, any size). A *single* kiobuf (which is roughly
> equivalent to an skb fragment) is 52+16*4 == 116 bytes. 6 of these would
> be 696 bytes, for a single TCP packet (!!!). This is simply not something
> to be used for lightweight zero-copy networking.

This doesn't matter, because rw_kiovec can easily take only one kiobuf,
and you don't really need the different fragments there.

> so it's easy to say 'use kiovecs', but right now it's simply not
> practical. kiobufs are a loaded concept, and i'm not sure whether it's
> desirable at all to mix networking zero-copy concepts with
> block-IO/filesystem zero-copy concepts.

I didn't wnat to suggest that - I'm to clueless concerning networking to
even consider an internal design for network zero-copy IO.
I'm just talking about the VFS interface to the rest of the kernel.

> we talked (and are talking) to Stephen about this problem, but it's a
> clealy 2.5 kernel issue. Merging to a finalized zero-copy framework will
> be easy. (The overwhelming percentage of zero-copy code is in the
> networking code itself and is insensitive to any kiovec issues.)

Agreed.

> > It's rather hackish (only write, looks usefull only for networking)
> > instead of the proposed rw_kiovec fop.
> 
> i'm not sure what you are trying to say. You mean we should remove
> sendfile() as well? It's only write, looks useful mostly for networking. A
> substantial percentage of kernel code is useful only for networking :-)

No.  But it looks like a recvmsg syscall wouldn't too bad either ...

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
