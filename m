Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315245AbSFOKaI>; Sat, 15 Jun 2002 06:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315257AbSFOKaH>; Sat, 15 Jun 2002 06:30:07 -0400
Received: from h-64-105-136-45.SNVACAID.covad.net ([64.105.136.45]:28061 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S315245AbSFOKaG>; Sat, 15 Jun 2002 06:30:06 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 15 Jun 2002 03:30:01 -0700
Message-Id: <200206151030.DAA01140@adam.yggdrasil.com>
To: axboe@suse.de
Subject: Re: bio_chain: proposed solution for bio_alloc failure and large IO simplification
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>       If it is unclear what I mean, perhaps I really need to code it
>> up to explain it. and we can discuss it from there.
>
>go ahead and code it up if you want and we can discuss it some more.

	As embassing as it is to have offered to put up or shut up
and then not put up, I have to admit that I now see a problem with
my proposal.

	The answer that I gave to you about the /dev/loop scenario
for bio_chain was incorrect.  The correct answer was that bi_hint
would just never be set by bio_chain for queue that use
blk_queue_make_request like /dev/loop.

	That scenario made me think, and I now see it as a pretty
substantial drawback that the bio_chain hints would be ignored or
not generated from a "stacked" device like /dev/loop or raid.
I thought about allowing the bi_hint field to propoagate down
to the underlying device under /dev/loop/n, but that scheme would
not work for interleaved raid schemes.  In comparison, raid really
shines in the scenario where the higher level software submits its
IO as one big request.  And the people who care the most about
block IO performance usually care a lot about raid.

	So, I think I'll abandon my proposal and think about you
your idea of some kind of incremental accounting function, which
perhaps could be implemented as:

	q->bio_one_more_bvec(q, bio, page, offset, len)	/* boolean */

	...in the hopes of accomodating complex IO size limitations,
such as for interleaved raid.

	Come to think of it, an earlier patch that I posted for
ll_rw_kio and the mpage routines kind of did something similar
to bio_chain for this.  It had a routine like q->bio_one_more_bvec
that was not a boolean, but rather would either stick the new
bvec in the bio, or submit the current bio, allocate a fresh bio,
stick this new bvec in that, and return the new bio.  To illustrate
in incorrect C syntax, I mean:

	newbio = q->one_more_bvec(q, bio, page, offset, len);

	The advantage of this is that it simplify bio generators about
as much as my bio_chain proposal would, but it would impliment your
"can we put another page into this bio" model.

	It would be easy enough to code this up up conservatively
(I think I basically have that in a previous patch) and then refine
the implementation to think about phys_mergeable, virt_mergeable,
etc.  It should at least help with maintenance if "can we put
another page into this bio" is a routine rather than complex
logic replicated in each bio producer.

	I would be interested in knowing what you think of this.
I think I'd be willing to try to provide at least a "conservative"
implimentation of this if you want.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
