Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267304AbUJONZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267304AbUJONZx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 09:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267447AbUJONZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 09:25:53 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:34489 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267304AbUJONZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 09:25:49 -0400
Subject: Re: per-process shared information
From: Albert Cahalan <albert@users.sf.net>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrea Arcangeli <andrea@novell.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Albert Cahalan <albert@users.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0410151207140.5682-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0410151207140.5682-100000@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1097846353.2674.13298.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 15 Oct 2004 09:19:13 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-15 at 07:56, Hugh Dickins wrote:
> On Fri, 15 Oct 2004, Andrea Arcangeli wrote:
> > On Thu, Oct 14, 2004 at 10:49:28PM +0100, Hugh Dickins wrote:

> > if you can suggest a not-horrid approach to avoid breaking binary
> > compatibility to 2.4 you're welcome ;)
> 
> I hope that's what my patch would be sufficient to achieve.
> 
> It would be unfair to say 2.4's numbers were actually a bug, but
> certainly peculiar: I'm about as interested in exactly reproducing
> their oddities as in building a replica of some antique furniture.

Most other people believe that Linux should have a
stable ABI so that apps don't break left and right.
Even if people have source code, they lose it. Even
if they don't lose it, they don't want to retest.
The developers may have gone on to better things.

People actually rely on Linux to work. Didn't OSDL
just add app+ABI testing? This is why.

> > > we know an anon page may actually be shared between several mms of the
> > > fork group, whereas it won't be counted in "shared" with this patch. But
> > > the old definition of "shared" was considerably more stupid, wasn't it?
> > > for example, a private page in pte and swap cache got counted as shared.
> > 
> > just checking mapcount > 1 would do it right in 2.6.
> 
> Interesting idea, and now (well, 2.6.9-mm heading to 2.6.10) we have
> atomic_inc_return and atomic_dec_return supported on all architectures,
> it should be possible to adjust an mm->shared_rss each time mapcount
> goes up from 1 or down to 1, as well as adjusting nr_mapped count
> as we do when it goes up from 0 or down to 0.
> 
> Though I think I prefer the anon_rss count in yesterday's patch,
> which is at least well-defined.  And will usually give you numbers
> much closer to 2.4's than shared_rss (since, as noted above, 2.4
> counted a page shared between pagetable and pagecache as shared,
> which mapcount 1 would not).

I don't see why it is such trouble to provide the old data.
If new data is useful, provide that too.

> > > shouldn't change that now, but add your statm_phys_shared; whatever,
> > 
> > the only reason to add statm_phys_shared was to keep ps xav fast, if you
> > don't slowdown pa xav you can add another field at the end of statm.
> 
> We should ask Albert which he prefers: /proc/pid/statm "shared" field
> revert to an rss-like count as in 2.4, subset of "resident", while size,
> text and data fields remain extents; or leave that third field as in
> earlier 2.6 and add a shared-rss field on the end?

I display the data as a column in "top". Docomentation is
much easier to deal with if it doesn't have lots of special
cases for different kernel versions.

I guess I'd prefer that the fields of Linux 2.4 be restored,
and that any new fields be added on the end. Note that the
text and data fields are supposed to be rss-like as well.
Except for the size, they're all supposed to be that way.
This data was created to match what BSD provides.

If adding a new file to /proc, please pick a short name
that is friendly toward tab completion. "phymem" is OK.


