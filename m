Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317232AbSHAV2n>; Thu, 1 Aug 2002 17:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317278AbSHAV2n>; Thu, 1 Aug 2002 17:28:43 -0400
Received: from fmr03.intel.com ([143.183.121.5]:40905 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP
	id <S317232AbSHAV1l>; Thu, 1 Aug 2002 17:27:41 -0400
Message-ID: <39B5C4829263D411AA93009027AE9EBB13299566@fmsmsx35.fm.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
To: "'Mala Anand'" <manand@us.ibm.com>, linux-kernel@vger.kernel.org,
       lse <lse-tech@lists.sourceforge.net>
Cc: Bill Hartner <Bill_Hartner@us.ibm.com>
Subject: RE: [Lse-tech] [RFC]  per cpu slab fix to reduce freemiss
Date: Thu, 1 Aug 2002 14:31:01 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Furthermore I think this design does not take into consideration of
> multiprocessor issues such as cache-bouncing, cache-warmthness etc.,
> And also the original implementation of the slab cache in the Linux
> kernel did not have per cpu support (I am not sure if the paper takes
> into consideration of SMP etc., also). So this assumption needs to be
> examined in the light of SMP, NUMA etc., I would like to explore the
> possibility of changing this assumption if possible in lieu of SMP/NUMA
> cache effects.
>
> In the present design there is a limit on how many free objects are held
> in the per cpu array. So when an object is freed it might end in another
> cpu more often.  The main cost lies in memory latency than execution of
> initializing the fields.  I doubt if we get the same gain as explained in
> the paper by preserving the fields between uses on an SMP/NUMA machines.

Bonwick has a newer paper
(http://www.usenix.org/events/usenix01/bonwick.html)
that describes how per cpu support can be added.  I've forgotten my Usenix
password, so I can't get the full text of the paper online at the moment.
But, if I recall correctly his magazine layer included support to
dynamically
adjust the size of the per-cpu lists.

The question becomes: Are the performance benefits high enough to justify
this extra code complexity?  Especially as tuning using /proc/slabinfo is
already available to mitigate problems that are bad enough for people to
notice.

Can you quantify the SMP/NUMA benefits?  I took some measurements a while
ago that showed that a huge percentage of slab allocations were freed by the
same cpu after a very short lifetime.  I didn't look into how often the
problems that you cite occur.

> I agree that preserving read only variables that can be used between uses
> will help performance. We still can do that by revising the assumption to
> leave the first 4 or whatever bytes needed to store the links. What do you
> think?

You'd need enough bytes to store your pointer (so "whatever" == 8 on 64-bit
architectures).  Users that care to arrange the fields of their structures
in "used together" order for better cache locality tend to put there efforts
into the first elements of a structure.  You might get less resistance to
change
if you use the tail end of the object?  But this is a potentially big
change.
Drivers can create their own slab caches, and if you change the semantics,
then
you may well break something.

-Tony
