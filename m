Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281005AbRK3UDc>; Fri, 30 Nov 2001 15:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283772AbRK3UDW>; Fri, 30 Nov 2001 15:03:22 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:35273 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S281005AbRK3UDN>; Fri, 30 Nov 2001 15:03:13 -0500
Message-Id: <200111302002.fAUK2t407011@eng4.beaverton.ibm.com>
To: Victor Yodaiken <yodaiken@fsmlabs.com>
cc: Alexander Viro <viro@math.psu.edu>,
        "David C. Hansen" <haveblue@us.ibm.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from drivers' release functions 
In-Reply-To: Your message of "Fri, 30 Nov 2001 05:41:26 MST."
             <20011130054126.A18099@hq2> 
Date: Fri, 30 Nov 2001 12:02:55 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    People seem to believe that BKL is worse than added spin-locks, but
    I very much doubt this is always true.

Depends, to some extent, on your definition of "worse". To address
two: the BKL (in general) encourages "worse" design and promotes
"worse" performance. Combine these with a general lack of comments
where clever and subtle code is being employed and the pervasive use of
the BKL can make debugging (or design change) difficult.

The BKL *is* a spinlock, with some questionable special handling in
other parts of the code which permits and encourages poor programming
(like automatically releasing it before you go to sleep, and allowing
you to "acquire" it multiple times).  In general, if you do not need
the special handling, there are compelling reasons to replace it with a
purpose-specific lock (or locking mechanism).

Setting aside architectural and academic issues of "locking design",
the main thing the current practice does, from a performance
standpoint, is create a generic bottleneck.  "One lock to rule them all
..." It creates strange effects like heavy activity in one subsystem
suddenly bogging down a completely disjoint subsystem.  Two separate
locks, in that case, would allow one subsystem to be very busy without
affecting the other.

The advantages gained become more evident on multiple-cpu machines.
Since this is not your most common desktop variant :) the trick is to
introduce changes which allow that hardware to excel while not
impacting the more common case: the single cpu desktop or laptop.  This
is sometimes easy; often, however, it is not, and so the work goes
slowly.

Locks should have clearly defined purpose and scope, just like any
other component of a software system.  The BKL has evolved/mutated
beyond its original scope and needs to be trimmed back.  When it is
trimmed back to either one or zero purposes then, I believe, we can put
down the weed-whackers and stop trimming.

Rick
