Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291162AbSAaRTo>; Thu, 31 Jan 2002 12:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291163AbSAaRTe>; Thu, 31 Jan 2002 12:19:34 -0500
Received: from holomorphy.com ([216.36.33.161]:13442 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S291162AbSAaRTX>;
	Thu, 31 Jan 2002 12:19:23 -0500
Date: Thu, 31 Jan 2002 09:19:04 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@conectiva.com.br>,
        Momchil Velikov <velco@fadata.bg>, John Stoffel <stoffel@casc.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Message-ID: <20020131171904.GB834@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Rik van Riel <riel@conectiva.com.br>,
	Momchil Velikov <velco@fadata.bg>, John Stoffel <stoffel@casc.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020131033345.X1309@athlon.random> <Pine.LNX.4.33L.0201311155010.32634-100000@imladris.surriel.com> <20020131153607.C1309@athlon.random> <20020131163934.GA834@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020131163934.GA834@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 08:39:34AM -0800, William Lee Irwin III wrote:
> The radix tree forest worst case space usage for fixed-precision search
> keys is where each leaf node of a radix tree is occupied by a unique page,
> and furthermore, each radix tree contains a single page (otherwise the
> shared root conserves a small amount of space).
> key precision = D^B = wordsize (e.g. 2^32 or 2^64)
> D = depth
> B = branch factor
> Each leaf node lies within a chain of D nodes, where all but the root
> nodes are of size B words. This is (D-1)*B + 1 words per file, hence
> per-page. Variable branch factors don't complicate this significantly:
> 1 + \sum_{0 \leq k \leq D} B_k words per page.

On Thu, Jan 31, 2002 at 08:39:34AM -0800, William Lee Irwin III wrote:
> For a branch factor of 128 on i386, this ends up as 1 + 7 + 7 + 6 = 21
> words per file. So for 500K inodes each with one page, 42MB (Douglas
> Adams fan?). Offsets of 10GB don't work here. Sounds like either an
> interesting patch or a 64-bit machine if they work for you. =)

As just pointed out to me the minute I did a substitution I went wrong:

A branch factor of 128 leads to 
1 + (7 + 7 + 6)*128 words = 2561 words per file, which is somewhat
more severe. =(

More corrections are welcome.


On Thu, Jan 31, 2002 at 03:36:07PM +0100, Andrea Arcangeli wrote:
>> Otherwise for an unix fs developer usage (the small files ala dbench)
>> the rbtree was much nicer data structure than the hash in first place
>> (and it eats less ram than the radix tree if only one page is queued
>> etc...).

On Thu, Jan 31, 2002 at 08:39:34AM -0800, William Lee Irwin III wrote:
> And the pointer links in struct page? Sounds like more RAM to me...
> 4000 open files (much more realistic than 500K) each with one page
> leads to 48000 words of radix tree overhead. 3 words per page of
> pointer links and > 16000 pages of RAM and the rbtree eats more, not
> less. And 16000 pages is just 64MB on i386.

This doesn't quite hold up after the the correction above. 4K open
files ends up having 10.5K words or 40MB of overhead.


Cheers,
Bill
