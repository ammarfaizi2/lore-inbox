Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRAILGh>; Tue, 9 Jan 2001 06:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129534AbRAILG2>; Tue, 9 Jan 2001 06:06:28 -0500
Received: from chiara.elte.hu ([157.181.150.200]:3084 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129436AbRAILGW>;
	Tue, 9 Jan 2001 06:06:22 -0500
Date: Tue, 9 Jan 2001 12:05:59 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Christoph Hellwig <hch@caldera.de>
Cc: Rik van Riel <riel@conectiva.com.br>, "David S. Miller" <davem@redhat.com>,
        <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <20010109113145.A28758@caldera.de>
Message-ID: <Pine.LNX.4.30.0101091132520.1159-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jan 2001, Christoph Hellwig wrote:

> > 2.4. In any case, the zerocopy code is 'kiovec in spirit' (uses
> > vectors of struct page *, offset, size entities),

> Yep. That is why I was so worried aboit the writepages file op.

i believe you misunderstand. kiovecs (in their current form) are simply
too bloated for networking purposes. Due to its nature and nonpersistency,
networking is very lightweight and memory-footprint-sensitive code (as
opposed to eg. block IO code), right now an 'struct skb_shared_info'
[which is roughly equivalent to a kiovec] is 12+4*6 == 36 bytes, which
includes support for 6 distinct fragments (each fragment can be on any
page, any offset, any size). A *single* kiobuf (which is roughly
equivalent to an skb fragment) is 52+16*4 == 116 bytes. 6 of these would
be 696 bytes, for a single TCP packet (!!!). This is simply not something
to be used for lightweight zero-copy networking.

so it's easy to say 'use kiovecs', but right now it's simply not
practical. kiobufs are a loaded concept, and i'm not sure whether it's
desirable at all to mix networking zero-copy concepts with
block-IO/filesystem zero-copy concepts. Just to make it even more clear:
although i do believe it to be desirable from an architectural point of
view, i'm not sure at all whether it's possible, based on the experience
we gathered while implementing TCP-zerocopy.

we talked (and are talking) to Stephen about this problem, but it's a
clealy 2.5 kernel issue. Merging to a finalized zero-copy framework will
be easy. (The overwhelming percentage of zero-copy code is in the
networking code itself and is insensitive to any kiovec issues.)

> It's rather hackish (only write, looks usefull only for networking)
> instead of the proposed rw_kiovec fop.

i'm not sure what you are trying to say. You mean we should remove
sendfile() as well? It's only write, looks useful mostly for networking. A
substantial percentage of kernel code is useful only for networking :-)

> > zerocopy sendfile() and zerocopy sendmsg(), the panacea of fileserver
> > (webserver) scalability - it can be used by Apache, Samba and other
> > fileservers. The new zerocopy networking code DMA-s straight out of the
> > The new zerocopy networking code DMA-s straight out of the
> > pagecache, natively supports hardware-checksumming and highmem (64-bit
> > DMA on 32-bit systems) zerocopy as well and multi-fragment DMA - no
> > limitations. We can saturate a gigabit link with TCP traffic, at about
> > 20% CPU usage on a 500 MHz x86 UP system. David and Alexey's patch is
> > cool - check it out!

> Yuck. A new file_opo just to get a few benchmarks right ...

no. As David said, it's direct sendfile() support. It's completely
isolated, it's 20 lines of code, it does not impact filesystems, it only
shows up in sendfile(). So i truly dont understand your point. This
interface has gone through several iterations and was actually further
simplified.

	Ingo

ps1. "first they say it's impossible, then they ridicule you, then they
     oppose you, finally they say it's self-evident". Looks like, after
     many many years, zero-copy networking for Linux is now finally in
     phase III. :-)

ps2. i'm joking :-)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
