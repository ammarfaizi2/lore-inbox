Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283101AbRLDPgh>; Tue, 4 Dec 2001 10:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276759AbRLDPgb>; Tue, 4 Dec 2001 10:36:31 -0500
Received: from mail.spylog.com ([194.67.35.220]:61585 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S283204AbRLDPgF>;
	Tue, 4 Dec 2001 10:36:05 -0500
Date: Tue, 4 Dec 2001 18:36:24 +0300
From: Peter Zaitsev <pz@spylog.ru>
X-Mailer: The Bat! (v1.53d)
Reply-To: Peter Zaitsev <pz@spylog.ru>
Organization: SpyLOG
X-Priority: 3 (Normal)
Message-ID: <16498470022.20011204183624@spylog.ru>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@zip.com.au>, theowl@freemail.c3.hu, theowl@freemail.hu,
        <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re[2]: your mail on mmap() to the kernel list
In-Reply-To: <20011204151549.U3447@athlon.random>
In-Reply-To: <3C082244.8587.80EF082@localhost>,
 <3C082244.8587.80EF082@localhost> <61437219298.20011201113130@spylog.ru>
 <3C08A4BD.1F737E36@zip.com.au> <20011204151549.U3447@athlon.random>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea,

Tuesday, December 04, 2001, 5:15:49 PM, you wrote:


AA> the vma lookup overhead is nothing compared to the walking of the linked
AA> list (not of the tree) to find the first available slot above
AA> TASK_UNMAPPED_BASE. In the vma lookup engine rewrite I only cared about
AA> find_vma, not about optimizing the search of a free vma over
AA> TASK_UNMAPPED_BASE.  Such list-loop is really evil.
Sure.

>> What appears to be happening is that the VMA tree has degenerated
>> into a monstrous singly linked list.  All those little 4k mappings

AA> actually it's not that the tree degenerated into a list. It's that we
AA> need to walk all the vma to check if there is a large enough hole to
AA> place the new dynamic mapping and so walk we use the list, not the tree,
AA> because it needs less mem resources and it's simpler and faster.

AA> You can fix the problem in userspace by using a meaningful 'addr' as
AA> hint to mmap(2), or by using MAP_FIXED from userspace, then the kernel
AA> won't waste time searching the first available mapping over
AA> TASK_UNMAPPED_BASE.
Well. Really you can't do this, because you can not really track all of
the mappings in user program as glibc and probably other libraries
use mmap for their purposes. This may work only at the program start
there you may almost be shure only low addresses are used yet.
In my case I'm implementing a cache of mmaped chunks so there are
always some mmaps/munmaps going.   Also I can't use "random" addresses
with a high probability it's so as my application mmaps about 50% of
user address space (meaning 3.5G your patches).

>> The reason you don't see it with an anonymous map is, I think, that
>> the kernel will merge contiguous anon mappings into a single one,

AA> Yes. But actually merging also file backed vmas would be a goodness
AA> indipendently of the arch_get_unmapped_area loop. It's not possible
AA> right now because the anonymous memory case it's much simpler: no
AA> i_shared_locks etc... but I'd like if in the long run also the file
AA> backed vma will be mergeable. The side effect of the goodness is that
AA> also the loop would run faster of course.
Do you think it's the big chance the two close mappings will belong to the
different parts of one file. I think this should be true only for some
specific workloads.
AA>  But technically to really kill
AA> the evil complexity of the loop (for example if every vma belongs to a
AA> different file so it cannot be merged anyways) we'd need a tree of
AA> "holes" indexed in function of the size of the hole. but it seems a very
AA> dubious optimization...
Are there much problems with this approach ? Much memory usage or cpu
overhead somethere ?
AA>  Complexity wise it makes sense, but in practice
AA> the common case should matter more I guess, and of course userspace can
AA> just fix this without any kernel modification by passing an helpful
AA> "addr", to the mmap syscall with very very little effort.  Untested
AA> patch follows:

Could you please explain a bit how this the hint works ? Does it tries
only specified address or also tries to look up the free space from
this point ?


-- 
Best regards,
 Peter                            mailto:pz@spylog.ru

