Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283676AbRLCXq1>; Mon, 3 Dec 2001 18:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282283AbRLCXlh>; Mon, 3 Dec 2001 18:41:37 -0500
Received: from mail.spylog.com ([194.67.35.220]:24745 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S284397AbRLCKKB>;
	Mon, 3 Dec 2001 05:10:01 -0500
Date: Mon, 3 Dec 2001 13:10:18 +0300
From: Peter Zaitsev <pz@spylog.ru>
X-Mailer: The Bat! (v1.53d)
Reply-To: Peter Zaitsev <pz@spylog.ru>
Organization: SpyLOG
X-Priority: 3 (Normal)
Message-ID: <483118814.20011203131018@spylog.ru>
To: Andrew Morton <akpm@zip.com.au>
Cc: theowl@freemail.c3.hu, theowl@freemail.hu, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re[2]: your mail on mmap() to the kernel list
In-Reply-To: <3C0ABA9E.5E652392@zip.com.au>
In-Reply-To: <3C08A4BD.1F737E36@zip.com.au>,  <3C082244.8587.80EF082@localhost>,
 <3C082244.8587.80EF082@localhost> <61437219298.20011201113130@spylog.ru>
 <3C08A4BD.1F737E36@zip.com.au> <142576153324.20011203020702@spylog.ru>
 <3C0ABA9E.5E652392@zip.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

Monday, December 03, 2001, 2:34:54 AM, you wrote:

AM> Peter Zaitsev wrote:
>> 
>> ...

AM> It's very simple.  The kernel has a linked list of vma's for your
AM> process.  It is kept in address order.  Each time you request a
AM> new mapping, the kernel walks down that list looking for an address
AM> at which to place the new mapping.  This data structure is set up
AM> for efficient find-by-address, not for efficient find-a-gap.

Yes. I see. I've tried some other load patterns like random
allocation/deallocation  but still see the speed degrades then a
number of mapped blocks increases :(

The other thing is  I do not get the thing with anonymous mapping -
I've now tried the simple thing - Quite the same program but every
second mapping was anonymous to prevent merging of the calls but still
I see the speed gain:

1) Non-anonymous
  5000  Time: 1 Mapped: 4999 Unmapped: 1661
  10000  Time: 2 Mapped: 9999 Unmapped: 3311 
  15000  Time: 6 Mapped: 14999 Unmapped: 4957 
  20000  Time: 9 Mapped: 19999 Unmapped: 6620 
  25000  Time: 12 Mapped: 24999 Unmapped: 8290 
  30000  Time: 15 Mapped: 29999 Unmapped: 9975 
  35000  Time: 17 Mapped: 34999 Unmapped: 11643 
  40000  Time: 20 Mapped: 39999 Unmapped: 13287 
  45000  Time: 23 Mapped: 44999 Unmapped: 14953 
  50000  Time: 26 Mapped: 49999 Unmapped: 16618 
  55000  Time: 28 Mapped: 54999 Unmapped: 18311 
  60000  Time: 31 Mapped: 59999 Unmapped: 20013 

2) Every second is anonymous
  5000  Time: 1 Mapped: 4999 Unmapped: 1661
  10000  Time: 1 Mapped: 9999 Unmapped: 3311 
  15000  Time: 3 Mapped: 14999 Unmapped: 4957 
  20000  Time: 6 Mapped: 19999 Unmapped: 6620 
  25000  Time: 8 Mapped: 24999 Unmapped: 8290 
  30000  Time: 9 Mapped: 29999 Unmapped: 9975 
  35000  Time: 12 Mapped: 34999 Unmapped: 11643 
  40000  Time: 13 Mapped: 39999 Unmapped: 13287 
  45000  Time: 15 Mapped: 44999 Unmapped: 14953 
  50000  Time: 18 Mapped: 49999 Unmapped: 16618 
  55000  Time: 18 Mapped: 54999 Unmapped: 18311 
  60000  Time: 21 Mapped: 59999 Unmapped: 20013


Any question is why ? Does the anonymous mapping is made separate way
to be always able to merge ?  This is important for me as I can stand
slowed down mmaping of files but really do not want for memory
allocation to slow down (mmap is used with multi threaded program)

AM> Question is: do we need to optimise for this case?

I hope you would. Or at least some patches would exist for this :)

AM> If it's just a single file, then you'd be better off just mapping the
AM> whole thing.   If you need to map lots and lots of files then
AM> you'll hit the maximum file limit fairly early and the mmap()
AM> performance will be not great, but maybe acceptable.

Well. I need much of small files. These files contain different
clients data and so they should not be merged.
I will not hit the open file limit - I've recently tested the  500.000
of open files - it seems to work and with no real speed penalty.

So this is really the strange case - I'm able to open 500.000+ of
files effective way but can't  effectively map more than 20.000 of
them :(

AM> One scenario where this could be a problem is for a file
AM> which is too large to be mapped in its entirety, but the
AM> application needs access to lots of bits of it at the same
AM> time.  There doesn't seem to be much alternative to setting
AM> up a distinct mapping for each access window in this case.

Yes.  I also found what migrating to small number of bug files will
not help much there will produce some other problems :)

>> Also As you see other patterns also show fast performance degradation
>> over increasing number of pages. I can also test random allocation and
>> freeing but something tells me the result will be the same.

AM> Is this proving to be a problem in a real-world application?
AM> What are you trying to do here?

I had two problems which I tried to solve with mmaping a lot of files.
My application works with a lot of data - 2G+ there not really all of
it are often accessed so some of it can be swapped out without any
problem for the application but I got two problems
1) User Address space on Intel  is 3.5G   (with Andrea's patches) - I
can't afford to migrate to 64bit environment as there are a lot of
mashies running the application. So I've set up the cache of mapped
pieces. As some of them are accessed rather rare it work only with
relatively small number of mapped chunks.
2) The second problem is more complicated - My program may work
effective way with only 20% of data present in memory, therefore I
must save things to the disk periodically. So with  read/write this
leads to a lot of swapping as a page must be swapped in before being
able to written to the disk.  And even more - only small persent of
pages really change  and so need to be saved, therefore it is hard to
track this and mmap should theoretically handle this automatically.




-- 
Best regards,
 Peter                            mailto:pz@spylog.ru

