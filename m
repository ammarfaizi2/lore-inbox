Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317331AbSGDEt3>; Thu, 4 Jul 2002 00:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317334AbSGDEt2>; Thu, 4 Jul 2002 00:49:28 -0400
Received: from [24.114.147.133] ([24.114.147.133]:25734 "EHLO starship")
	by vger.kernel.org with ESMTP id <S317331AbSGDEt1>;
	Thu, 4 Jul 2002 00:49:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [Ext2-devel] Re: Shrinking ext3 directories
Date: Thu, 4 Jul 2002 06:48:45 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@zip.com.au>,
       Christopher Li <chrisl@gnuchina.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
References: <20020619113734.D2658@redhat.com> <E17LF65-0001K4-00@starship> <20020621160659.C2805@redhat.com>
In-Reply-To: <20020621160659.C2805@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17PyXt-0000hm-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I wrote this about 10 days ago and somehow didn't get around to posting it)

(please note my new, permanent email address)

On Friday 21 June 2002 17:06, Stephen C. Tweedie wrote:
> Hi,
> 
> On Fri, Jun 21, 2002 at 05:28:28AM +0200, Daniel Phillips wrote:
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
> I want to get this thing tested!  

Yes :-)

> There are far too many factors for this to be resolved very quickly.
> In reality, there will be a lot of disk cost under load which you
> don't see in benchmarks, too.  We also know for a fact that the early
> hashes used in Reiserfs were quick but were vulnerable to terribly bad
> behaviour under certain application workloads.  With the half-md4, at
> least we can expect decent worst-case behaviour unless we're under
> active attack (ie. only maliscious apps get hurt).

OK, anti-hash-attack is on the list of things to do, and it's fairly
clear how to go about it:

  - When we create a volume, generate and store some number of bits of
    random seed in the superblock, or if we are creating the first-ever
    index on an existing volume, generate the seed at that time.

  - Every dx_hash starts by seeding the hash function from the value in
    the superblock.

The width of the superblock seed doesn't have to match the value needed
by the directory hash exactly since we can easily widen the value by
seeding a pseudo-random generator with the smaller seed.  If the
superblock seed is wider than we need, we can fold it down via xor, or
better, just take as much as we need (all bits of our seed are supposed
to be eually random, so xoring parts of the seed together does't make
the result any more random).

We would do whatever seed-adjusting we need to at mount time, so the
process of seeding the per-dirop hash is just a memory->memory or
memory->register move.  This part of the hashing process, at least,
should impose no measurable overhead.

Originally, I'd put aside the 'reserve_zero' field in the per-directory
dx_info for this purpose, but I later realized that it doesn't make
sense to do this anti-hash-attack protection at any finer granuality
than a volume, plus we save valuable real estate in the directory root
and gain a little efficiency.  Putting it in the superblock is a clear
win.

By the way, the dx_info area is not hardwired to 8 bytes.  The current
code is written so that dx_info can be expanded without breaking
forward compatibility.  At least it's supposed to be written that way.
We should put that on the list of things to test.

> I think the md4 is a safer bet until we know more, so I'd vote that we
> stick with the ext3 cvs code which uses hash version #1 for that, and
> defer anything else until we've seen more --- the hash versioning lets
> us do that safely.

Yes, I agree we should err on the side of safety.  The 6% overhead I see
in my stripped down test will certainly be diluted quite a bit under real
loads.  Hash version #1 does not have to be the release version.  We can
reasonably require a fsck at the end of the alpha-testing period, which
would rebuild all the hash indexes with the final, release hash.  This
would have the added advantage of enlisting our alpha-testers to test
Ted's new e2fsck code as well.

I think we're making progress here.  An 'aha' I had while working with
this new hash code is that there's a one statistical property we're
looking for more than any other in a good hash: the hash value should
yield as little information as possible about the input string.  Then
any statistical change in input strings over time won't cause a
statistical change in output hash values over time - precisely the
property htree wants, in order to keep leaf blocks filled uniformly
and slow the hash range fragmentation rate.  This is why cryptographic
hash analysis is the right approach to this problem.

-- 
Daniel

P.S., in retrospect, pretty much all of the above survived scrutiny
at Ottawa.

