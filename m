Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315448AbSEBWj3>; Thu, 2 May 2002 18:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315449AbSEBWj2>; Thu, 2 May 2002 18:39:28 -0400
Received: from melancholia.rimspace.net ([210.23.138.19]:7184 "EHLO
	melancholia.danann.net") by vger.kernel.org with ESMTP
	id <S315448AbSEBWj0>; Thu, 2 May 2002 18:39:26 -0400
To: Andrew Morton <akpm@zip.com.au>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.12 severe ext3 filesystem corruption warning!
In-Reply-To: <3CD191C5.AC09B1F4@zip.com.au>
	<Pine.GSO.4.21.0205021530010.16530-100000@weyl.math.psu.edu>
	<3CD1A2E2.A240823C@zip.com.au>
From: Daniel Pittman <daniel@rimspace.net>
Organization: Not today, thank you, Mother.
Date: Fri, 03 May 2002 08:39:18 +1000
Message-ID: <87u1pq18fd.fsf@enki.rimspace.net>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.5 (bamboo,
 i686-pc-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 May 2002, Andrew Morton wrote:
> Alexander Viro wrote:
>> On Thu, 2 May 2002, Andrew Morton wrote:
>> > A few things..

[...]

>> I suspect that you had screwed the truncate exclusion warranties up. 
>> If _any_ IO happens in the area currently manipulated by ->truncate()
>> - you are screwed and results would look pretty much like the things
>> mentioned in bug report.
> 
> OK, thanks.  That's something to go on.
> 
> The only change which comes to mind is discard_buffer() - it's
> no longer clearing BH_Uptodate.  Because for the partial page
> at the end of the mapping, buffers outside i_size were zeroed
> in truncate_partial_page().  But with (presumed) 4k blocksize,
> it can't be that.
> 
> ext3_writepage() can hold a reference against the buffers
> after the page has come unlocked, so a try_to_free in the
> right window will fail, which will leave the page floating
> about on the page LRU, not mapped into any address_space,
> clean, not uptodate, but with uptodate buffers.  Nobody
> but the VM should ever find that page, but it does make more
> sense to mark that buffer not uptodate.  This would only
> happen on super-heavy SMP loads.

Oh, it's a laptop, so SMP is right out of the picture. ;)
        Daniel

-- 
Many of my favorite shamans are rock stars. They probably don't even know
they're shamans but they know how to get to ecstasy and back, and how to take
others with them. They may not have a license, but they know how how to drive.
        -- Gabrielle Roth, _Maps to Ecstasy_
