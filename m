Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130792AbRAIKYb>; Tue, 9 Jan 2001 05:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131184AbRAIKYV>; Tue, 9 Jan 2001 05:24:21 -0500
Received: from chiara.elte.hu ([157.181.150.200]:268 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130792AbRAIKYH>;
	Tue, 9 Jan 2001 05:24:07 -0500
Date: Tue, 9 Jan 2001 11:23:41 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "David S. Miller" <davem@redhat.com>, <hch@caldera.de>,
        <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <Pine.LNX.4.21.0101081603080.21675-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.30.0101091051460.1159-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 Jan 2001, Rik van Riel wrote:

> I really think the zerocopy network stuff should be ported to kiobuf
> proper.

yep, we talked to Stephen Tweedie about this already, but it involves some
changes in kiovec support and we didnt want to touch too much code for
2.4. In any case, the zerocopy code is 'kiovec in spirit' (uses vectors of
struct page *, offset, size entities), so transition to a finalized kiovec
framework (or whatever other mechanizm) is trivial. Right now kiovecs are
*way* too bloated for the purposes of skb fragments.

> The usefulness of the patch you posted is rather .. umm .. limited.
> [...]

i violently disagree :-) The upcoming TUX release is based on David's and
Alexey's cleaned-up zerocopy framework. [thus TUX and zerocopy are
separated.] David's patch adds a *very* scalable implementation of
zerocopy sendfile() and zerocopy sendmsg(), the panacea of fileserver
(webserver) scalability - it can be used by Apache, Samba and other
fileservers. The new zerocopy networking code DMA-s straight out of the
pagecache, natively supports hardware-checksumming and highmem (64-bit DMA
on 32-bit systems) zerocopy as well and multi-fragment DMA - no
limitations. We can saturate a gigabit link with TCP traffic, at about 20%
CPU usage on a 500 MHz x86 UP system. David and Alexey's patch is cool -
check it out!

> Having proper kiobuf support would make it possible to, for example,
> do zerocopy network->disk data transfers and lots of other things.

i used to think that this is useful, but these days it isnt. It's a waste
of PCI bandwidth resources, and it's much cheaper to keep a cache in RAM
instead of doing direct disk=>network DMA *all the time* some resource is
requested.

> Furthermore, by using kiobuf for the network zerocopy stuff there's a
> good chance the networking code will be integrated.

David and Alexey are TCP/IP networking code maintainers. So if you see a
'test this' networking framework patch from them on l-k, it has quite high
chances of being integrated into the networking code :-)

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
