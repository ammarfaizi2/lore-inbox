Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbRALBpa>; Thu, 11 Jan 2001 20:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132403AbRALBpU>; Thu, 11 Jan 2001 20:45:20 -0500
Received: from zeus.kernel.org ([209.10.41.242]:29897 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129742AbRALBpB>;
	Thu, 11 Jan 2001 20:45:01 -0500
Date: Fri, 12 Jan 2001 01:42:47 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010112014247.S25375@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0101081603080.21675-100000@duckman.distro.conectiva> <20010109113145.A28758@caldera.de> <200101091031.CAA01242@pizda.ninka.net> <20010109122810.A3115@caldera.de> <93fnve$250$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <93fnve$250$1@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Jan 09, 2001 at 11:14:54AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 09, 2001 at 11:14:54AM -0800, Linus Torvalds wrote:
> In article <20010109122810.A3115@caldera.de>,
> 
> kiobufs are crap. Face it. They do NOT allow proper multi-page scatter
> gather, regardless of what the kiobuf PR department has said.

It's not surprising, since they were designed to solve a totally
different problem.

Kiobufs were always intended to represent logical buffers --- a virtual
address range from some process, or a region of a cached file.  The
purpose behind them was, if you remember, to allow something like
map_user_kiobuf() to produce a list of physical pages from the user VA
range.

This works exactly as intended.  The raw IO device driver may build a
kiobuf to represent a user VA range, and the XFS filesystem may build
one for its pagebuf abstraction to represent a range within a file in
the page cache.  The lower level IO routines just don't care where the
buffers came from.

There are still problems here --- the encoding of block addresses in
the list, dealing with a stack of completion events if you push these
buffers down through various layers of logical block device such as
raid/lvm, carving requests up and merging them if you get requirest
which span a raid or LVM stripe, for example.  Kiobufs don't solve
those, but neither do skfrags, and neither does the MSG_MORE concept.

If you want a scatter-gather list capable of taking individual
buffer_heads and merging them, then sure, kiobufs won't do the trick
as they stand now: they were never intended to.  The whole point of
kiobufs was to encapsulate one single buffer in the higher layers, and
to allow lower layers to work on that buffer without caring where the
memory came from.  

But adding the sub-page sg lists is a simple extension.  I've got a
number of raw IO fixes pending, and we've just traced the source of
the last problem that was holding it up, so if you want I'll add the
per-page offset/length with those. 

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
