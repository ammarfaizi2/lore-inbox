Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290216AbSA3R2H>; Wed, 30 Jan 2002 12:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290063AbSA3R0y>; Wed, 30 Jan 2002 12:26:54 -0500
Received: from bitmover.com ([192.132.92.2]:28326 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S290069AbSA3RZa>;
	Wed, 30 Jan 2002 12:25:30 -0500
Date: Wed, 30 Jan 2002 09:25:29 -0800
From: Larry McVoy <lm@bitmover.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Larry McVoy <lm@bitmover.com>, Rik van Riel <riel@conectiva.com.br>,
        Tom Rini <trini@kernel.crashing.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        Rob Landley <landley@trommello.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130092529.O23269@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Ingo Molnar <mingo@elte.hu>, Larry McVoy <lm@bitmover.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Tom Rini <trini@kernel.crashing.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Alexander Viro <viro@math.psu.edu>,
	Rob Landley <landley@trommello.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020130084331.K23269@work.bitmover.com> <Pine.LNX.4.33.0201301943050.11581-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0201301943050.11581-100000@localhost.localdomain>; from mingo@elte.hu on Wed, Jan 30, 2002 at 07:48:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 07:48:35PM +0100, Ingo Molnar wrote:
> eg. i sent 8 different scheduler update patches 5 days ago:
> 
>  [patch] [sched] fork-fix 2.5.3-pre5
>  [patch] [sched] yield-fixes 2.5.3-pre5
>  [patch] [sched] SCHED_RR fix, 2.5.3-pre5
>  [patch] [sched] set_cpus_allowed() fix, 2.5.3-pre5
>  [patch] [sched] entry.S offset fix, 2.5.3-pre5.
>  [patch] [sched] cpu_logical_map fixes, balancing, 2.5.3-pre5
>  [patch] [sched] compiler warning fix, 2.5.3-pre3
>  [patch] [sched] unlock_task_rq() cleanup, 2.5.3-pre3
> 
> these patches, while many of them are touching the same file (sched.c) are
> functionally orthogonal, and can be applied in any order. Linus has
> applied all of them, but he might have omitted any questionable one and
> still apply the rest.
> 
> how would such changes be expressed via BK, and would it be possible for
> Linus to reject/accept an arbitrary set of these patches?

There is a way to do this in BK that would work just fine.  It pushes some
work back onto the developer, but if you are willing to do it, we have no
problem doing what you want with BK in its current form and I suspect that
the work is very similar to what you are already doing.

In your list above, all of the patches are against 2.5.3-pre5.  If you did
the work for each patch against the 2.5.3-pre5 baseline, checking it in,
saving the BK patch, removing that changeset from the tree, and then going
onto the next change, what you'd have is exactly the same set of patches
as you have no.  Literally.  You could type the appropriate command to BK
and you should be able to generate a bit for bit identical patch.

In BK's mind, what you have done is to make a very "bushy" set of changes,
they are all "side by side".  If you think of a graph of changes, you started
with

			[older changes]
			      v
			  [2.5.3-pre4]
			      v
			  [2.5.3-pre5]

and then you added one change below that, multiple times.  If you were to
combine all of those changes in a BK tree, it would look like

			[older changes]
			      v
			  [2.5.3-pre4]
			      v
			  [2.5.3-pre5]
  [sched1] [sched2] [sched3] [sched4] [sched5] [sched6] [sched7]

and BK would be happy to allow you to send any subset of the sched changes
to Linus and it would work *exactly* how you want it to work.  If we could
get people to work like this, there are no problems.  Just to make it really
clear you would do this

	for p in patch_list
	do	bk vi sched.c	# that will lock it if isn't
		hack, debug, test
		bk citool	# check it in and make a changeset
		bk makepatch -r+ > ~/bk-patches/patch.$p
		bk undo -fr+	# get back to the same baseline
	done

Here's what people actually do.  They make the first change, then make
the second change in the same tree that already has the first change,
and so on.  BitKeeper faithfully records the linear sequence of changes
and enforces that the changes propogate as that linear sequence.  You can
skip some at the end but you can't skip any in the middle.

In your particular case, we really need out of order changesets to allow
the second type of work flow and cherry picking.  However, a fairly common
case is that the changes are all in unrelated files and *even then* 
BitKeeper enforces the linearity.  That's the problem I think we need to
fix first, it's not a complete solution, but it is the 80-90% solution.
Until we give you a 100% solution, you have to realize that you are making
side by side changes and actually do it that way.

If any of this is not clear to anyone, please speak up and I'll try and 
draw some pictures and add some explanation.  
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
