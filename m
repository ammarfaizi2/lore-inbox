Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbVH2PHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbVH2PHQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 11:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVH2PHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 11:07:16 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:3733 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751226AbVH2PHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 11:07:14 -0400
Subject: Re: [PATCH] make radix tree gang lookup faster by using a bitmap
	search
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4312830C.8000308@yahoo.com.au>
References: <1125159996.5159.8.camel@mulgrave>
	 <20050827105355.360bd26a.akpm@osdl.org> <1125276312.5048.22.camel@mulgrave>
	 <20050828175233.61cada23.akpm@osdl.org> <1125278389.5048.30.camel@mulgrave>
	 <20050828183531.0b4d6f2d.akpm@osdl.org> <1125285994.5048.40.camel@mulgrave>
	  <4312830C.8000308@yahoo.com.au>
Content-Type: text/plain
Date: Mon, 29 Aug 2005 10:01:58 -0500
Message-Id: <1125327718.5089.28.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-29 at 13:37 +1000, Nick Piggin wrote:
> But the page tree is indexed by file offset rather than virtual
> address, and we try to span the file's pagecache with the smallest
> possible tree. So it will tend to make the trees taller.

Well, OK, I concede that one.

However, my contention that it's better to do it this way is rooted in
the simplicity argument:  a bitmap lookup obviously can move straight to
the slot you're looking for.  However, we've always had that loop (which
wastes time) because no-one could get the bitmap code right.  The reason
for this is that variable length bitmaps are hard to manage and
introduce a lot of complexity into what should really be simple code.

I think simplicity is better (for ease of understanding and maintenance)
unless it has an unacceptable cost.  In this case, that cost would be
shown by the benchmarks.  If what I've done is slower on 32 bits than
what we had previously then I'll recode it all with variable length
bitmaps so we can increase the 32 bin index bits to 6 again.

> > Well .. OK .. If the benchmarks say I've slowed us down on 32 bits, I'll
> > put the variable sizing back in the tag array.

> I'm curious: what do the benchmarks say about your gang lookup?

That's why I tried to cc the mm list; I'm not sure what you use for
benchmarks of this type of thing.  My guess would be a mmap of a file,
read followed by some writes, then munmap again?

James


