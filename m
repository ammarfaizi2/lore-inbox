Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbRAIPVn>; Tue, 9 Jan 2001 10:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130870AbRAIPVd>; Tue, 9 Jan 2001 10:21:33 -0500
Received: from zeus.kernel.org ([209.10.41.242]:3044 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129742AbRAIPV2>;
	Tue, 9 Jan 2001 10:21:28 -0500
Date: Tue, 9 Jan 2001 15:17:25 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Rik van Riel <riel@conectiva.com.br>,
        "David S. Miller" <davem@redhat.com>, hch@caldera.de,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010109151725.D9321@redhat.com>
In-Reply-To: <20010109141806.F4284@redhat.com> <Pine.LNX.4.30.0101091532150.4368-100000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.30.0101091532150.4368-100000@e2>; from mingo@elte.hu on Tue, Jan 09, 2001 at 03:40:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 09, 2001 at 03:40:56PM +0100, Ingo Molnar wrote:
> 
> i'd love to first see these kinds of applications (under Linux) before
> designing for them.

Things like Beowulf have been around for a while now, and SGI have
been doing that sort of multimedia stuff for ages.  I don't think that
there's any doubt that there's a demand for this.
 
> Eg. if an IO operation (eg. streaming video webcast)
> does a DMA from a camera card to an outgoing networking card, would it be
> possible to access the packet data in case of a TCP retransmit? 

I'm not thinking about pci-to-pci as much as pci-to-memory-to-pci
with no memory-to-memory copies.  That's no different to writepage:
doing a zero-copy writepage on a page cache page still gives you the
problem of maintaining retransmit semantics if a user mmaps the file
or writes to it after your initial transmit.

And if you want other examples, we have applications such as Oracle
who want to do raw disk IO in chunks of at least 128K.  Going through
a page-by-page interface for large IOs is almost as bad as the
existing buffer_head-by-buffer_head interface, and we have already
demonstrated that to be a bottleneck in the block device layer.

Jes has also got hard numbers for the performance advantages of
jumbograms on some of the networks he's been using, and you ain't
going to get udp jumbograms through a page-by-page API, ever.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
