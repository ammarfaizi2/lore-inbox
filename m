Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292289AbSDABY3>; Sun, 31 Mar 2002 20:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292588AbSDABYU>; Sun, 31 Mar 2002 20:24:20 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:36674 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S292289AbSDABYK>; Sun, 31 Mar 2002 20:24:10 -0500
Date: Mon, 1 Apr 2002 03:24:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
Subject: Re: Linux 2.4.19-pre5
Message-ID: <20020401032400.O1331@dualathlon.random>
In-Reply-To: <20020330135333.A16794@rushmore> <3CA616B2.1F0D8A76@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2002 at 11:49:06AM -0800, Andrew Morton wrote:
> That's rather irrational, because most of the dirty buffers
> will be in ZONE_HIGHMEM.  So hmmmm.  Probably we should go

You're right it's not the best, but it's intentional and correct. We've
just one single balance_dirty(void) and it has to balance metadata and
data, data will be in highmem too, but metadata will be in normal zone
for most filesystems (even ext[23], modulo direntries for ext2) and
that's why we've to consider only the normal zone as a certain target of
the allocation, to be sure not to overstimate for metadata. OTOH in
particular to take full advantage of the point of view watermarks it
would be really nicer to say if we've to balance_dirty on the normal
zone or on the highmem zone (currently we could overstimate a bit the
amount of ram we can take from the normal zone with an highmem
allocation (we look at the the high watermark from the "normal" point of
view), but OTOH we always understimate the amount of potential highmem
free), so the current way is mostly ok for now (not a showstopper). To
improve that bit we simply need a kind of "zone" argument to
balance_dirty() API, done that the other changes should be a formality.

Andrea
