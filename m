Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290075AbSAWUw6>; Wed, 23 Jan 2002 15:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290078AbSAWUwv>; Wed, 23 Jan 2002 15:52:51 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:55305 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S290075AbSAWUwl>; Wed, 23 Jan 2002 15:52:41 -0500
Message-ID: <3C4F218F.1070706@namesys.com>
Date: Wed, 23 Jan 2002 23:48:15 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@zip.com.au>,
        Andreas Dilger <adilger@turbolabs.com>, Chris Mason <mason@suse.com>,
        Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: Possible Idea with filesystem buffering.
In-Reply-To: <3C4DB256.172F8D6A@zip.com.au> <Pine.LNX.4.33L.0201221649430.32617-100000@imladris.surriel.com> <20020123203500.L1930@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen C. Tweedie wrote:

>Hi,
>
>On Tue, Jan 22, 2002 at 05:03:02PM -0200, Rik van Riel wrote:
>
>>On Tue, 22 Jan 2002, Andrew Morton wrote:
>>
>>>Hans Reiser wrote:
>>>
>>>Note that writepage() doesn't get used much.  Most VM-initiated
>>>filesystem writeback activity is via try_to_release_page(), which
>>>has somewhat more vague and flexible semantics.
>>>
>>We may want to change this though, or at the very least get
>>rid of the horrible interplay between ->writepage and
>>try_to_release_page() ...
>>
>
>This is actually really important --- writepage on its own cannot
>distinguish between requests to flush something to disk (eg. msync or
>fsync), and requests to evict dirty data from memory.
>
>This is really important for ext3's data journaling mode --- syncing
>to disk only requires flushing as far as the journal, but evicting
>dirty pages requires a full writeback too.  That's one place where our
>traditional VM notion of writepage just isn't quite fine-grained
>enough.
>
>Cheers,
> Stephen
>
>
I think this is a good point Stephen is making.

So we have:

* write this particular page at this particular memory address (for DMA 
setup or other reasons).

* write the data on this page

* apply X units of aging pressure to the subcache if it is distinct from 
the general cache and supports a pressure operation.

as the three distinct needs we are needing to serve in the design of the 
interface.


Rik, are you comfortable now with this cache plugin approach I am 
advocating now that I have explained it is motivated by the need to 
handle objects that are not flushed in pages?  You have had another day 
to think about it, and you didn't quite say yes (though it did seem you 
no longer think me crazy).

Hans

