Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbULPOAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbULPOAp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 09:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbULPOAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 09:00:45 -0500
Received: from almesberger.net ([63.105.73.238]:31243 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262660AbULPN55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 08:57:57 -0500
Date: Thu, 16 Dec 2004 10:57:47 -0300
From: Werner Almesberger <werner@almesberger.net>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: [RFC] Generalized prio_tree, revisited
Message-ID: <20041216105747.T1229@almesberger.net>
References: <20041216053118.M1229@almesberger.net> <41C16D8D.7020702@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C16D8D.7020702@umich.edu>; from vrajesh@umich.edu on Thu, Dec 16, 2004 at 06:12:13AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajesh Venkatasubramanian wrote:
> The "raw" prio_tree can only handle unique intervals, i.e., we cannot
> insert two intervals with the same indices.

Yes, I admit that I found it convenient (laziness is a survival
trait :-) to preserve this property of the underlying code.

In fact, I'm not so sure if we should really offer alternatives at
that level, since it seems that adding a conflict resolution layer
on top of prio_tree (or including it in the user) is about as much
work as including one inside, and the former could be tailored to
the specific needs of the user, e.g.

 - new entry is rejected
 - new entry replaces old entry
 - entries are somehow merged (reference count, add partial
   content, etc.)
 - entries neutralize each other
 - both entries are kept, in a list (like VMA and the ABISS
   elevator do)
 - both entries are kept, ordered by some other key
 - action depends on context

and so on. So it seems to me that we're just at the level of
abstraction that gives us the most narrow interface and that
doesn't hide any information we need to implement the other
cases. And it's just the "engine" that would be used in all
cases anyway.

Besides, handling of non-unique entries shouldn't such a big
deal that the user whould be seriously inconvenienced by having
to do it. E.g. in the case of red-black trees, we also expect
the user to do a lot for us.

> Maybe in your case you don't have to worry about storing multiple
> identical intervals.

I just build a list that's usually read in FIFO order. In
my case, any kind of overlap needs special handling, so
non-unique entries aren't much extra work.

If I was really ambitious, I could try to combine non-unique
requests if they all are writes (but then, having a lot of
these is probably an indication of problems elsewhere).

Thanks,
- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
