Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289504AbSAVWfw>; Tue, 22 Jan 2002 17:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289498AbSAVWfP>; Tue, 22 Jan 2002 17:35:15 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:59658 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289497AbSAVWfE>; Tue, 22 Jan 2002 17:35:04 -0500
Message-ID: <3C4DE825.1030406@namesys.com>
Date: Wed, 23 Jan 2002 01:31:01 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Chris Mason <mason@suse.com>, Andreas Dilger <adilger@turbolabs.com>,
        Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.33L.0201221818140.32617-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let's try a non-reiserfs sub-cache example.  Suppose you have a cache of 
objects that are smaller than a page.  These might be dcache entries, 
these might be struct inodes, these might be all sorts of things in the 
kernel.

Suppose that there is absolutely no correlation in access between the 
objects that are on the same page.  Suppose that this subcache has 
methods for freeing however many of them it wants to free, and it can 
squeeze them together into fewer pages whenever it wants to.  Suppose it 
can track accesses to the objects, and it could age them also, if we 
wrote the code to do it.

If we age with page granularity as you ask us to, we are doing 
fundamentally the wrong thing.  Aging with page granularity means that 
we keep in the cache every object that happens to land on the same page 
with a frequently accessed object even if  those objects are never 
accessed again ever.

Another wrong way:  Ok, so suppose we have methods for shrinking the 
cache ala the old 2.2 dcache shrinking code.  Suppose we invoke those 
whenever the cache gets "too large", or the other caches are failing to 
free pages because things have gotten SO pathologically inbalanced that 
they have nothing they can free.  This is also bad.  It results in 
unbalanced caches, and makes our VM maintainer think that subcaches are 
inherently bad.

If we don't have a master VM pushing proportionally to their size on all 
subcaches, and telling them how many pages worth of aging to apply, we 
either have unused objects staying in memory because they happen to land 
on a page with a frequently used object, or we have unbalanced caches 
that know what to free but not how much to free.

We need a master VM that says how much aging pressure to apply, and 
subcaches that respond to that.  We need a VM that doesn't just 
delegate, but delegates skillfully enough that the subcaches know what 
they need to know to act on it.

Hans


Rik van Riel wrote:

>On Tue, 22 Jan 2002, Hans Reiser wrote:
>
>>Rik van Riel wrote:
>>
>>>On Tue, 22 Jan 2002, Chris Mason wrote:
>>>
>
>>>>The FS doesn't know how long a page has been dirty, or how often it
>>>>gets used,
>>>>
>>>In an efficient system, the FS will never get to know this, either.
>>>
>>I don't understand this statement.  If dereferencing a vfs op for
>>every page aging is too expensive, then ask it to age more than one
>>page at a time.  Or do I miss your meaning?
>>
>
>Please repeat after me:
>
> "THE  FS  DOES  NOT  SEE  THE  MMU  ACCESSED  BITS"
>
We can't borrow whatever pair of glasses the master VM is using?

>
>
>Also, if a piece of data is in the page cache, it is accessed
>without calling the filesystem code.
>
>
>This means the filesystem doesn't know how often pages are or
>are not used, hence it cannot make the decisions the VM make.
>
>Or do you want to have your own ReiserVM and ReiserPageCache ?
>
>regards,
>
>Rik
>



