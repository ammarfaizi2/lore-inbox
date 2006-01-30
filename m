Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWA3FMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWA3FMc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 00:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWA3FMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 00:12:32 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:41129 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932104AbWA3FMb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 00:12:31 -0500
Date: Sun, 29 Jan 2006 21:11:56 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: dipankar@in.ibm.com, Lee Revell <rlrevell@joe-job.com>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: RCU latency regression in 2.6.16-rc1
Message-ID: <20060130051156.GK16585@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1138224506.3087.22.camel@mindpipe> <20060126191809.GC6182@us.ibm.com> <1138388123.3131.26.camel@mindpipe> <20060128170302.GB5633@in.ibm.com> <1138471203.2799.13.camel@mindpipe> <1138474283.2799.24.camel@mindpipe> <20060128193412.GH5633@in.ibm.com> <43DBCB62.7030308@cosmosbay.com> <20060130043604.GF16585@us.ibm.com> <43DD9C49.4000000@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43DD9C49.4000000@cosmosbay.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2006 at 05:55:37AM +0100, Eric Dumazet wrote:
> Paul E. McKenney a écrit :
> >On Sat, Jan 28, 2006 at 08:52:02PM +0100, Eric Dumazet wrote:

[ . . . ]

> >>Some machines have millions of entries in their route cache.
> >>
> >>I suspect we cannot queue all them (or only hash heads as your previous 
> >>patch) by RCU. Latencies and/or OOM can occur.
> >>
> >>What can be done is :
> >>
> >>in rt_run_flush(), allocate a new empty hash table, and exchange the hash 
> >>tables.
> >>
> >>Then wait a quiescent/grace RCU period (may be the exact term is not this 
> >>one, sorry, I'm not RCU expert)
> >>
> >>Then free all the entries from the old hash table (direclty of course, no 
> >>need for RCU grace period), and free the hash table.
> >>
> >>As the hash table can be huge, we might need allocate it at boot time, 
> >>just in case a flush is needed (it usually is :) ). If we choose dynamic 
> >>allocation and this allocation fails, then fallback to what is done today.
> >
> >Interesting approach!
> >
> >If I remember correctly, the point of all of this is to perturb the hash
> >function periodically in order to avoid DoS attacks.  It will likely
> >be necessary to avoid a big performance hit during the transition.
> >One way of doing this, given your two-table scheme, would be to:
> >
> >o	Allocate both tables at boot time, as you suggest above.
> >
> >o	Keep the following additional state:
> >
> >	o	Pointer to the table that is the current table.
> >
> >	o	First valid index (fvl) into the current table -- all
> >		indexes below the fvl correspond to hash buckets that
> >		have been transferred into the non-current table.
> >		In the normal case where the tables are not being
> >		switched, fvl==-1.
> >
> >		(To make the RCU searches work without requiring
> >		tons of explicit memory barriers, there needs to
> >		be a separate fvl for each of the tables.)
> >
> >	o	Parameters defining the hash functions for the current
> >		table and for the non-current table.
> >
> >o	When it is time to switch tables, start removing the entries
> >	in hash bucket #fvl of the current table.  Optionally put them
> >	into the non-current table (or just let them be added as they
> >	are needed.  Only remove a limited number of entries (or,
> >	alternatively, stop removing them after a limited amount of
> >	time).
> >
> >	When the current hash bucket has been completely emptied,
> >	increment fvl, and, if we have not already hit the limit,
> >	continue on the new hash bucket.
> >
> >	When fvl runs off the end of the table, you are done with
> >	the switch.  Update the pointer to reference the other
> >	table.  Important -- do -not- start another switch until
> >	a grace period has elapsed!!!  Otherwise, you will end
> >	up fatally confusing slow readers.
> >
> >o	When searching, if the hash function gives a value less
> >	than fvl, search the non-current table.
> >
> >	If the hash function gives a value equal to fvl, search
> >	the current table, and, if not found, search the non-current
> >	table.
> >
> >	If the hash function gives a value greater than fvl, search
> >	only the current table.  (It may also be necessary to search
> >	the non-current table to allow for races with fvl update.)
> >
> >Does this seem reasonable?
> >
> >						Thanx, Paul
> 
> Well, if as a bonus we are able to expand the size of the hash table, it 
> could be very very good : As of today, the boot time sizing of this hash 
> table is somewhat problematic.
> 
> If the size is expanded by a 2 factor (or a power of too), can your 
> proposal works ?

Yep!!!

Add the following:

o	Add a size variable for each of the tables.  It works best
	if the per-table state is stored with the table itself, for
	example:

	struct hashtbl {
		int size;
		int fvl;
		struct hash_param params;
		struct list_head buckets[0];
	};

o	When switching tables, allocate a new one of the desired size
	and free up the non-current one.  (But remember to wait at least
	one grace period after the last switch before starting this!!!)

o	Compute hash parameters suitable for the new table size.

o	Continue as before.

Note that you are not restricted to power-of-two expansion -- the
hash parameters should handle any desired difference, and in fact
handle contraction as well as expansion.

						Thanx, Paul
