Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316677AbSFUQXg>; Fri, 21 Jun 2002 12:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316678AbSFUQXe>; Fri, 21 Jun 2002 12:23:34 -0400
Received: from [213.23.20.221] ([213.23.20.221]:15786 "EHLO starship")
	by vger.kernel.org with ESMTP id <S316677AbSFUQXZ>;
	Fri, 21 Jun 2002 12:23:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Helge Hafting <helgehaf@aitel.hist.no>, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] Re: Shrinking ext3 directories
Date: Fri, 21 Jun 2002 18:23:13 +0200
X-Mailer: KMail [version 1.3.2]
References: <20020619113734.D2658@redhat.com> <E17LF65-0001K4-00@starship> <3D12CFC5.38DD9245@aitel.hist.no>
In-Reply-To: <3D12CFC5.38DD9245@aitel.hist.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17LRBp-0001ar-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 June 2002 09:03, Helge Hafting wrote:
> Daniel Phillips wrote:
> 
> > I ran a bakeoff between your new half-md4 and dx_hack_hash on Ext2.  As
> > predicted, half-md4 does produce very even bucket distributions.  For 200,000
> > creates:
> > 
> >    half-md4:        2872 avg bytes filled per 4k block (70%)
> >    dx_hack_hash:    2853 avg bytes filled per 4k block (69%)
> > 
> > but guess which was faster overall?
> > 
> >    half-md4:        user 0.43 system 6.88 real 0:07.33 CPU 99%
> >    dx_hack_hash:    user 0.43 system 6.40 real 0:06.82 CPU 100%
> > 
> > This is quite reproducible: dx_hack_hash is always faster by about 6%.  This
> > must be due entirely to the difference in hashing cost, since half-md4
> > produces measurably better distributions.  Now what do we do?
> 
> No surprise that the worse distribution is faster - you get less
> io when fewer blocks are used.  Which means a bad distribution beats 
> a good one _until_ blocks start to really fill up and collide. 2.8K per
> 4K block is only 70% full.  I guess the better hash wins
> if you force a higher fill rate?

Hashing in htree doesn't work like that - what you're thinking about
is a traditional fixed-size hash table.  HTree is a btree that uses
hashes of names as keys.  Each block has a variable amount of the key
space assigned to it, initially just one block for the entire key
space.  When that block fills up, its entries and its key space are
split into two, then those blocks start to fill up, get split, and
so on.

So more even key distribution means the key space gets split more
evenly, and blocks are more likely to fill up evenly, meaning less
splitting, fewer blocks in total, and less IO.

A hash function that distributes keys better should give somewhat
better performance, and that has indeed been my experience.  But
in the case of half-MD4, the improvement we get from better
distribution is wiped out by the higher cost of computing the hash
function.[1]  Which is not to say that the work is without value.
The beautiful distribution given by the half-MD4 hash gives us
something to aim at, we just have to be more efficient about it.

I should note that HTree isn't hugely sensitive to bad hash
functions, at least not at the outset when a directory is growing.
The worst that happens is every leaf block ends up half-full with
a performance hit of just a few percent.  However, over time with
many insertions and deletions the hash space can get cut up into 
smaller and smaller pieces, so leaf blocks become less and less
full.  A more uniform hash function will slow this process down a
great deal, but it will not stop it completely.  The proper way
to deal with long term key space fragmentation is to implement
coalesce-on-delete, which is in progress.

[1] CPU cost in filesystem operations *is* important - a lot more
important than commonly thought.  Here we have yet another example
where CPU cost in filesystem operations dominates IO time, and
indeed, since directory operations are performed almost entirely
in cache, the quadratic cost of linear directory lookup is almost
entirely CPU cost.

-- 
Daniel

