Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266239AbUA2Qkf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 11:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266240AbUA2Qke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 11:40:34 -0500
Received: from bay1-f53.bay1.hotmail.com ([65.54.245.53]:48905 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S266239AbUA2QkQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 11:40:16 -0500
X-Originating-IP: [169.204.239.122]
X-Originating-Email: [highwind747@hotmail.com]
From: "raymond jennings" <highwind747@hotmail.com>
To: reiser@namesys.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [IDEA] - run-length compaction of block numbers
Date: Thu, 29 Jan 2004 08:40:11 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F53zy8z4diCQW400053b5f@hotmail.com>
X-OriginalArrivalTime: 29 Jan 2004 16:40:11.0253 (UTC) FILETIME=[90018250:01C3E686]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, here's the basic idea.  There are four types of "block runs":

Direct runs
Indirect runs
Null runs
Zero runs

struct blockrun_t {
   blocknum_t logstart, loglength;
   blocknum_t phystart, phylength;
}

Direct runs are determined by nonzero and equal logical and physical 
numbers.  The only way this can happen is for the run to directly reference 
data blocks (I think, some crazy cases can be guarded against).

Indirect runs have a larger logical count than the physical count, meaning 
that the referenced blocks actually comprise a list of more block runs.  
Functionally equivalent to an indirect block.

Null runs have a zero logical length and are useful as padding.  The logical 
start should be consistent with surrounding runs to allow binary searching.

Zero runs are a quick and dirty implementation of sparse files.  They are 
given by a PHYSICAL zero, meaning that the actual data blocks are not stored 
on disk.  reads of these "blocks" return zeroes.

The top level inode contains eight or so of these runs, listed in logical 
block start order (binary searchable).  The indirect runs thereof reference 
other runs, which may reference others (and so on).  Blocks could be as 
small as 512 (saves space)

these top level block runs form what is a block chain.  It could be as large 
or as small as needed.

The superblock contains a blockchain of its own, but this "block chain" 
references the dynamic inode space, thus, inodes are only limited by the 
range of an inode number (probably 2G), or the amount of space.  Unused 
inodes could even be sparsified.

fsck.rle will have its work cut out for it however.  I suggest that block 
chains be abstracted.  Manipulating the raw block runs should be left to the 
discretion of the rlefs library (if there is one).

If this has already been implemented, feel free to use my suggestions to 
improve them (or not).  I am unfortunate enough to not have enough space to 
unpack my kernel source, so I can't very well keep up :(.  I'm running a 
system on a mere 212MB hard disk, with gcc, g++, ncurses (devel too), jed, 
joe, init, initscripts, mingetty, and midnight commander, and I only have 
7.5MB of space left.  Naturally, I can't afford swap space :O.  This only 
happened because my stupid 2GB HD suffered a short circuit, which caused the 
dreaded head crash.  That's my sob story.  Thank's for listening.

Is the

>From: Hans Reiser <reiser@namesys.com>
>To: Valdis.Kletnieks@vt.edu
>CC: raymond jennings <highwind747@hotmail.com>,  
>linux-kernel@vger.kernel.org
>Subject: Re: [IDEA] - run-length compaction of block numbers
>Date: Fri, 16 Jan 2004 23:47:55 +0300
>
>Valdis.Kletnieks@vt.edu wrote:
>
>>On Fri, 16 Jan 2004 11:38:59 PST, raymond jennings 
>><highwind747@hotmail.com>  said:
>>
>>
>>>Is there any value in creating a new filesystem that encodes long 
>>>contiguous blocks as a single block run instead of multiple block 
>>>numbers?  A long file may use only a few block runs instead of many block 
>>>numbers if there is little fragmentation (usually the case).
>>>
>This is already done, they are called "extent"s.  Reiser4 uses them, XFS 
>uses them, I think Veritas may have been the first to use them but I am not 
>sure of this, maybe it was IBM.
>
>>>Also dynamic allocation of inodes...etc.
>>>
>ReiserFS does dynamic allocation of stat data (what stat() returns), we 
>don't have inodes.  Many filesystems do dynamic allocation of inodes.
>
>>>  The details are long; anyone interested can e-mail me privately.
>>>
>>>
>>
>>Only question I have is how you make an efficient scheme for finding the 
>>block
>>number for an offset several gigabytes into the file.
>>
>Use a tree to store everything in.  See www.namesys.com for extensive 
>details.
>
>>  You either get to run
>>through the list linearly (gaak) or you need to stick a tree or hash on 
>>the
>>front to allow semi-random access to a starting point to scan linearly 
>>from, at
>>which point you've probably blown any space savings unless you have a VERY 
>>low
>>fragmentation rate...
>>
>>On the other hand, dynamic allocation of inodes is interesting, as it 
>>means
>>you're not screwed if over time, the NBPI value for the filesystem changes 
>>(or
>>if you simply guessed wrong at mkfs time) and you run out of inodes when 
>>you
>>still have space free.  Reiserfs V3 already does this, in fact...
>>
>>
>>
>Cheers,
>
>--
>Hans
>
>

_________________________________________________________________
Check out the coupons and bargains on MSN Offers! 
http://shopping.msn.com/softcontent/softcontent.aspx?scmId=1418

