Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317102AbSHJRxD>; Sat, 10 Aug 2002 13:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317107AbSHJRxD>; Sat, 10 Aug 2002 13:53:03 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:5906 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S317102AbSHJRxA>;
	Sat, 10 Aug 2002 13:53:00 -0400
Message-ID: <3D55539F.6000309@namesys.com>
Date: Sat, 10 Aug 2002 21:55:43 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Hans Reiser <reiser@bitshadow.namesys.com>, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: [BK] [PATCH] reiserfs changeset 7 of 7 to include into 2.4 tree
References: <200208091636.g79GadA9007889@bitshadow.namesys.com> <3D542B88.6F7007E4@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Hans Reiser wrote:
>  
>
>>Hello!
>>
>>   This changeset implements new block allocator for reiserfs and adds one
>>   more tail policy. This is a product of continuous NAMESYS research in this
>>   area. This piece of code incorporates work by Alexander Zarochencev,
>>   Jeff Mahoney and Oleg Drokin.
>>    
>>
>
>What Christoph said ;)
>
>Block allocation algorithms are really, really important.  I'd be very interested
>in a description of what this change does, what problems it is solving, how it
>solves them, observed results, testing methodology, etc.   Is such a thing
>available?
>
>Thanks.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
The block allocator code is one of the key remaining pieces we would 
have fixed before 2.4 shipped if we had had time.  The block allocator 
code that shipped is simply ugly.  

The block allocation algorithms in ReiserFS were once extremely simple. 
 They would attempt to allocate a block near to its left neighbor in the 
tree ordering, searching for a free block starting from the block number 
of that neighbor, and doing the search in increasing block number order. 
 (Increasing not decreasing block number order was significant to 
performance we found.)

The problem with this algorithm occurred when there were no free blocks 
anywhere near that neighbor.  It would perform a linear scan of the 
bitmaps, and this scan might consume quite a lot of CPU as it checked 
each bit.  Additionally, if you cannot get a free block near the 
neighbor, then proximity to the neighbor is actually a bad thing to 
achieve, because it means proximity to a full part of the disk.

So long ago I suggested that we try attaching a count to the bitmap, and 
not bother to scan its bits if that count was not zero.  This new code 
does that.

Additionally, Jeff Mahoney wrote code to pick a random bitmap to go to 
if the current bitmap was full, and to try to make it a bitmap that is 
less than 90% full.  This new code does that by default.  (Oleg rewrote 
Jeff's code, and I have lost track of what aspects of it are Jeff's vs. 
Oleg's.)

However, we also tried a whole bunch of other things, and it looks like 
Jeff's/Oleg's code makes those other things not so valuable because 
those other things were achieving value by doing what Jeff's/Oleg's code 
does but less thoroughly or even as an unintended side effect.

In 2.4 we have code that takes all of the formatted nodes, and tries to 
put them into the first 10% of the disk.  This makes me uncomfortable, 
because the 10% number is inflexible.  Maybe I am wrong to dislike this. 
 More experiments are needed, though I may wait for V4.1 to do them.  It 
also does things with displacing things according to a hash function, 
which was a broken hash function at one time (you could tell that it 
didn't work the way that the programmer intended, and that it put things 
near to the start of the disk by accident due to directory ids tending 
to be numerically smaller than the device size in block numbers).  I 
can't remember if that hash function has been fixed in the 2.4.19 code 
tree or if it is only fixed in our new patch.

We experimented with dispersing directories randomly across this disk.  

We experimented with randomly displacing files large enough to have 
unformatted nodes (option in new allocator allows you to displace files 
larger than some arbitrary size).

In the end I decided that the improved bitmap scanning code plus the 
avoidance of 90% full bitmaps when nothing near is free plus starting 
from the left neighbor was close to as good as any other combination, 
and had the advantage of being simpler, so I made it the default, 
because I trust more in the robustness of simpler algorithms that I 
understand more fully.

The default code path is either far simpler than the current code, or 
clearly superior, depending on what part of it one considers.  I do not 
claim that I have found the right answer, but I have probably found the 
best that I will invent for V3.

Almost everything that we at Namesys are going to change in V3 is 
written and going into the next several 2.4.20-pre* releases.  The only 
thing that I know of that remains and is unwritten is to perhaps revert 
to the tail conversion policy used in Linux 2.2.* (the current code is 
very inefficient in its tail handling, and one of us thinks it might 
speed up if we go back to the old way, and I'd be interested to see a 
benchmark of it.)  We would probably like to also junk the 4k at a time 
read code, but most likely that will be done in V4 (Linux 2.5/2.6) not V3.

V3 will probably change very little after 2.4.20, and that is what our 
users need in the period while V4 stabilizes   ---  they need something 
that always just works albeit not as fast as V4.

-- 
Hans



