Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316173AbSEVPpM>; Wed, 22 May 2002 11:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316213AbSEVPpM>; Wed, 22 May 2002 11:45:12 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:18856 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S316173AbSEVPpK>; Wed, 22 May 2002 11:45:10 -0400
Date: Wed, 22 May 2002 08:44:25 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>,
        "M. Edward Borasky" <znmeb@aracnet.com>
cc: linux-kernel@vger.kernel.org, andrea@suse.de, riel@surriel.com,
        torvalds@transmeta.com, akpm@zip.com.au
Subject: Re: Have the 2.4 kernel memory management problems on large machines been fixed?
Message-ID: <1403412981.1022057064@[10.10.2.3]>
In-Reply-To: <20020522143651.GA14918@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, May 22, 2002 at 07:00:11AM -0700, M. Edward Borasky wrote:
>> A few months ago, there was a flurry of reports from people having
>> difficulties with memory management on large machines (ia32 over 4 GB). I've
>> seen a lot of 2.4.x-yy kernels go by and much VM discussion, but what I'm
>> *not* seeing is reports of either catastrophic behavior or its absence on
>> large machines. I haven't had a chance to run my own test cases on the
>> 2.4.18 kernel from Red Hat 7.3 yet, so I can't make any personal
>> contribution to this discussion.

I wouldn't bother using RedHat's kernel for this at the moment, 
Andrea's tree is where the development work for this area has all
been happening recently. He's working on integrating O(1) sched
right now, which will get rid of the biggest issue I have with -aa
at the moment (the issue being that I'm too idle^H^H^H^Hbusy to
merge it ;-)).

> The catastrophic failures are still happening, in fact, the last
> lse-tech conference call a week or two ago was dedicated at least in
> part to them. The number of different ways in which these failures
> occur is large, so it's taking a while for the iterations of whack-a-mole
> game to converge to kernel stability. Andrea has probably been doing the
> most visible stuff on this front with the recent bh/inode exhaustion
> patches, with due credit to akpm as well for the unconditional bh
> stripping patch.

The problems we're seeing are mainly KVA exhaustion. The top hitlist
for me at the moment are:

1. PTEs (5000 tasks sharing a 2Gb SGA = 10GB of PTEs).
	We have two different implementations of highpte, Andrea's
	latest seems to work fairly well, and is much more scalable
	than earlier versions. We need to have shared	PTEs as well.
	I'd encourage people to benchmark the hell out of each
	solution, and help us come down to one, or a hybrid of both.
2. rmap pte_chains. 
	As far as I can see, these consume twice as much space as 
	the PTEs (ie 20Gb in the case above).
3. buffer_heads
	I have over 1Gb of bufferheads in (an enlarged) ZONE_NORMAL
	right now. akpm has given me a patch to prune them pretty
	viciously on an ongoing basis, Andrea has a patch to prune
	them under memory pressure. I have slight concerns about
	fragmentation under Andrea's approach, but both patches seem
	to work fine - performance still needs to be worked out.
4. struct page
	Bill Irwin has already done great things in shrinking this
	somewhat, but I think we need to be even more drastic at 
	some point, and only map the PTEs we need for each process,
	into a task (well address-space) specific KVA area, which
	I call user-kernel address space or UKVA (search back for
	my proposal to do this a couple of months ago).
5. kmap
	Persistent kmap sucks, and the global systemwide TLB flushes
	scale as O(1/N^2) with the number of CPUs. Enlarging the kmap 
	area helps a little, but really we need to stop doing this to
	ourselves. I will have a patch (hopefully within a week) to do 
	per-task kmap, based on the	UKVA patch that Dave McCracken has
	already implemented.
6. vmalloc
	Vmalloc space gets quickly exhausted, I think a large part of
	that is threads allocating 64K LDTs ... and 2.5 has a recent
	fix for that that we need to backport.

There are various other general scalability problems (eg. I'd like to
see Ingo's scheduler put into mainline 2.4 sometime soon, both 2.5 and
our benchmarking teams have kicked the hell out of it, and it stands
up well), but the above list is the things I can think of at the moment
that are specific to 32-bit machines (though some of those would also
help 64 bit).

M.
