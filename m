Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281445AbRKHEdo>; Wed, 7 Nov 2001 23:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281451AbRKHEdZ>; Wed, 7 Nov 2001 23:33:25 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:33532 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281445AbRKHEdP>;
	Wed, 7 Nov 2001 23:33:15 -0500
Date: Wed, 7 Nov 2001 21:32:18 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: "David S. Miller" <davem@redhat.com>
Cc: tim@physik3.uni-rostock.de, jgarzik@mandrakesoft.com, andrewm@uow.edu.au,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        netdev@oss.sgi.com, ak@muc.de, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] net/ipv4/*, net/core/neighbour.c jiffies cleanup
Message-ID: <20011107213218.U5922@lynx.no>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	tim@physik3.uni-rostock.de, jgarzik@mandrakesoft.com,
	andrewm@uow.edu.au, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com, netdev@oss.sgi.com, ak@muc.de,
	kuznet@ms2.inr.ac.ru
In-Reply-To: <Pine.LNX.4.30.0111080003320.29364-100000@gans.physik3.uni-rostock.de> <20011107.160950.57890584.davem@redhat.com> <20011107173626.S5922@lynx.no> <20011107.164426.35502643.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011107.164426.35502643.davem@redhat.com>; from davem@redhat.com on Wed, Nov 07, 2001 at 04:44:26PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 07, 2001  16:44 -0800, David S. Miller wrote:
> Why do they these cases that are actually in the code need to cast to
> a signed value to get a correct answer?  They are not like your
> example.
> 
> Almost all of these cases are:
> 
> 	(jiffies - SOME_VALUE_KNOWN_TO_BE_IN_THE_PAST) > 5 * HZ
> 
> So you say if we don't cast to signed, this won't get it right on
> wrap-around?  I disagree, let's say "long" is 32-bits and jiffies
> wrapped around to "0x2" and SOME_VALUE... is 0xfffffff8.  The
> subtraction above yields 10, and that is what we want.

OK, in this code it mostly appears that the wraparound is correct, but
in some cases it is very hard to say without specific knowledge of the code:

	neigh->confirmed = jiffies - (n->parms->base_reachable_time<<1);
	.
	.
	.
	if ((state&NUD_VALID) &&
	    now - neigh->confirmed < neigh->parms->reachable_time) {

How are we to know that the above calculation won't be wrong because of
jiffies wrap?

> Please show me a bad case where casting to signed is necessary.

I don't know enough about the net code to say for sure, but for example
in drivers/sound/sb_common.c:

	limit = jiffies + HZ / 10;      /* Timeout */

	for (i = 0; i < 500000 && (limit-jiffies)>0; i++)

Since limit and jiffies are both unsigned, the value will always be > 0,
unless they are equal.

> I actually ran through the tree the other night myself starting to
> convert these things, then I noticed that I couldn't even convince
> myself that the code was incorrect.

I don't disagree that it is possible to make correct code without the
macros, but it is easier to guarantee that it IS correct with the macros.
Rather than evaluate each jiffies usage on a case-by-case basis, it is
much easier to do a code audit and fix all comparisons.  I don't see that
it harms anything to use the macros instead.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

