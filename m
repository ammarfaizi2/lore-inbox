Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271652AbRHUNRG>; Tue, 21 Aug 2001 09:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271653AbRHUNQq>; Tue, 21 Aug 2001 09:16:46 -0400
Received: from chiara.elte.hu ([157.181.150.200]:47634 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S271652AbRHUNQf>;
	Tue, 21 Aug 2001 09:16:35 -0400
Date: Tue, 21 Aug 2001 15:14:22 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "Peter J. Braam" <braam@clusterfilesystem.com>
Cc: TUX Development Mailing List <tux-list@redhat.com>,
        <intermezzo-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: large & fragmented TUX requests
In-Reply-To: <20010802161214.E1498@lustre.clusterfilesystem.com>
Message-ID: <Pine.LNX.4.33.0108211505470.4500-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2 Aug 2001, Peter J. Braam wrote:

> I have two basic questions about the code (looking at 2.4.6-3.1)
>
> 1) input.c
>
> If a request arrives in multiple pieces, req->proto->parse_message
> returns 0 and read_request is called multiple times.  Why is read
> request not overwriting data that was already received?

because the parser uses linear strings. Parsers are one of the main cause
of security problems, so i tried to keep the TUX parser as simple and
robust as possible.

> 2) large requests
>
> Some of the RPC's I want to handle are for receiving file data. Would
> it make sense when it is known that a large page aligned buffer with
> file data is coming, to simply allocate buffers of the right size (say
> up to 64K max) and point req->req_headers at it?
>
> In that way I can read the chunk in and later map the pages into a
> file to get it to disk.

there is /proc/sys/net/tux/max_header_len, which you can set to any
(reasonable) size. Right now the interface is kmalloc(), which has a
per-CPU cache so allocation/deallocation is very fast and SMP-friendly.
You can set the value of max_header_len to 64k, but there could be kmalloc
related fragmentation issues. (If you ever encounter this fragmentation
problem then we can cache header buffers within the tux-request cache,
and/or can fall back to vmalloc().)

right now TUX assumes that req_headers is a kmalloc-ed buffer, so you
cannot simply replace the pointer with a page-aligned (and possible
gfp()-allocated) memory buffer.

> There is no standard "recv_file" (ala sendfile) api, right?

there is none at the moment - but TUX does an effective zero-copy
recv_file() for small requests: it takes the raw skbs and parses them, if
the skb is 'simple' (nonfragmented, nonoffsetted). (which they are in 99%
of the cases)

	Ingo

