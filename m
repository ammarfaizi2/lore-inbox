Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317955AbSFNQwO>; Fri, 14 Jun 2002 12:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317957AbSFNQwN>; Fri, 14 Jun 2002 12:52:13 -0400
Received: from h-64-105-136-45.SNVACAID.covad.net ([64.105.136.45]:59281 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317955AbSFNQwL>; Fri, 14 Jun 2002 12:52:11 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 14 Jun 2002 09:52:02 -0700
Message-Id: <200206141652.JAA26744@adam.yggdrasil.com>
To: axboe@suse.de
Subject: Re: bio_chain: proposed solution for bio_alloc failure and large IO simplification
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jun 2002 Jens Axboe wrote:
>On Thu, Jun 13 2002, Adam J. Richter wrote:
[...]
>> 	newbio = bio_chain(oldbio);
[...]
>> 	I realize there may be locking issues in implementing this.

>but I think that statement is very naive :-)

>Essentially you are keeping a cookie to the old bio submitted, so that
>you can merge new bio with it fairly cheaply (it's still not very cheap,
>although you do eliminate the biggest offender, the list merge scan).
>The first problem is that once you submit the bio, there are some things
>that are not yours to touch anymore. You cannot change bi_next for
>instance, you have no idea what state the bio is in wrt I/O completion.
>Sure you can hold a reference to the bio, but all that really gets you
>in this situation is a handle to it, nothing more. How do you decide
>when to invalidate this cookie that you have?

	At any time, there could be only one "hinted" bio in a
request: the last bio in the request.  So you only have to
clear the hint when:

		1. you merge bio's,
		2. elv_next_request is called,
		3. newbio is submitted.

	In all three cases q->queue_lock gets taken, so we should
not need to add any additional spin_lock_irq's, and the two lines
to clear the hint pointers should be trivial.

>So what do I like? As I see it, the only nice way to make sure that a
>bio always has the best possible size is to just ask 'can we put another
>page into this bio'. That way we can apply the right (and not just
>minimum) limits every time.

	That would be pretty nice too, but that lacks three potential
advantages of my bio_chain appoach, in order of importance:

		1. bio_chain is avoids memory allocation failures,
		2. bio_chain can start the first IO slightly sooner,
		3. bio_chain makes bio submitters slightly simpler.

	The disadvantage of my single I/O vector bio_chain apprach is
that it results in another procedure call per vector.  We also already
have code that builds multiple IO vectors in ll_rw_kio and the mpage.c
routines.

	I think I would be happy enough with your approach, but, just
to eliminate possibilities of memory allocation failure, I think I
want to still have some kind of bio_chain, perhaps without the merge
hinting, but with a parameter to allow for allocating a bio up to the
size of oldbio, like so:

struct bio *bio_chain(struct bio *oldbio, int gfp_mask,
		       int nvecs /* <= oldbio->bi_max */);

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
