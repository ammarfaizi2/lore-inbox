Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274766AbRIZBgu>; Tue, 25 Sep 2001 21:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274767AbRIZBgk>; Tue, 25 Sep 2001 21:36:40 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:55303 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S274766AbRIZBgd>;
	Tue, 25 Sep 2001 21:36:33 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH][RFC] Allow net devices to contribute to /dev/random
Date: 26 Sep 2001 01:36:56 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9orbfo$jca$1@abraham.cs.berkeley.edu>
In-Reply-To: <1001461026.9352.156.camel@phantasy> <9or70g$i59$1@abraham.cs.berkeley.edu> <1001465531.10701.61.camel@phantasy>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1001468216 19850 128.32.45.153 (26 Sep 2001 01:36:56 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 26 Sep 2001 01:36:56 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok.  Since the default is 'off', I agree that this patch is unlikely
to lead to cryptographic failures in the 'off' setting.  At worst,
/dev/random will block forever, or more likely, block longer than it
otherwise would.  There is still a question in my mind about whether, by
turning off all network collection (and thus doing less entropy collection
than today's kernels do), this patch might be making the situation worse
for the average user.  However, I agree that at least this is fail-safe,
not fail-open, which is a useful property.

I certainly agree that insufficient entropy is indeed an important
problem for some installations.  However, I must admit that am not yet
convinced that this patch is the right solution for those installations:
it seems that the cure might well be worse than the disease in some cases.
I'll give some further discussion about my concerns below.  But before
I do, let me be clear about the worst case: With this patch set to
'on', the system might silently fail open and become insecure, but with
this patch in the default 'off' setting, at worst it just freezes, if
I understand correctly.  In other words, the reservations about being
too generous with the entropy counter only apply to the non-default 'on'
setting, so the rest of my comments only apply to this limited setting
where the user has already been warned.


Robert Love  wrote:
>On Tue, 2001-09-25 at 20:20, David Wagner wrote:
>> Incrementing the entropy counter based on externally observable
>> values is dangerous.
>
>However, the actual end result -- that the output of /dev/random can be
>predicted -- is theoretical, because of the fact the output is one-way
>hashed.

I didn't follow this part.  One concern is that, if we are too
generous with the entropy count, _all_ of the inputs to the randomness
pool might be known or predictable.  In this situation, the SHA
hash doesn't help at all.  I don't know how likely it is that this
situation will arise -- once we get 160 bits of good randomness
into the pool, we're safe as long as SHA is secure -- but the
whole reason that /dev/random exists is to be extremely conservative
about security.  Being overly generous with the entropy count invalidates
the warranty on /dev/random.  And for those who don't need an extremely
conservative solution, there's no reason to use /dev/random in the
first place: just grab 160 good bits and use /dev/urandom from then on.

>I do not want to get into another full discussion of this, but
>a thread exists about a month back that discussed it.

Yes, I followed that thread, and would not have posted my note about
this revision of the patch if I did not still have some questions.

>To summarize: the patch is a risk if and only if: SHA-1 is cracked, an
>attacker can observe the state of network packets, and it contributes
>enough to the pool that enough of its state is learned.

Well, maybe I could suggest that this statement should be extended
a bit.  Your statement is absolutely correct if we have gotten 160
good bits of true randomness into the pool at some point since booting,
but it is not quite correct if all of the inputs to /dev/random since
booting were predictable.

Thus, it might be more accurate to say that /dev/random is at risk
if SHA-1 is cracked, OR if the attacker can observe or predict all
the inputs to the randomness pool, OR if (SHA is cracked and the
attacker can observe or control the state of network packets and
these packets contribute enough to the pool).  Any of these three
cases are sufficient to invalidate security.

One concern might be that the patch could increase the risk of the
second failure mode by being overly generous with the entropy count
when in the 'on' setting.  /dev/random wasn't designed to be secure
when we feed it predictable values to add_interrupt_randomness(), and
it seems unreasonable to expect it to be reliably safe in this scenario.

>Some diskless machines really have _zero_ entropy.  This patch does them
>good.  If you don't want net devices to contribute, don't enable them.

Again, one concern is that for some devices, this patch might be
making the problem worse by turning off entropy collection for a
number of network devices.

>Hell, without this patch, some network devices do contribute!  It
>actually standardizes the whole thing.

Yes, but my understanding is that the devices that do contribute in
the current kernel were chosen according to some security analysis,
to ensure that they actually provide at least as much entropy as the
/dev/random entropy estimator expects.  My impression was that Ted
Ts'o had looked at this pretty carefully.  Was this impression incorrect?
Has anyone done a similar security analysis for the devices this
patch enables?
