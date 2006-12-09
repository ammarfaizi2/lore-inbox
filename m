Return-Path: <linux-kernel-owner+w=401wt.eu-S1947571AbWLIA20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947571AbWLIA20 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 19:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947574AbWLIA20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 19:28:26 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:47606 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1947571AbWLIA2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 19:28:25 -0500
Date: Fri, 8 Dec 2006 16:28:14 -0800
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       ak@suse.de, clameter@sgi.com
Subject: Re: [PATCH] cpuset - rework cpuset_zone_allowed api
Message-Id: <20061208162814.0ea505c8.pj@sgi.com>
In-Reply-To: <6599ad830612080851q55fe8c95m9f00a2a9a3779dc4@mail.gmail.com>
References: <20061208112152.12631.67436.sendpatchset@jackhammer.engr.sgi.com>
	<6599ad830612080851q55fe8c95m9f00a2a9a3779dc4@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul M wrote:
> While you're changing this, is there a good reason not to check
> is_mem_exclusive() *before* taking callback_mutex and calling
> nearest_exclusive_ancestor()?
> 
> something like:
> 
> rcu_read_lock();
> exc = is_mem_exclusive(rcu_dereference(current->cs));
> rcu_read_unlock();
> if (exc)
>   return 1;

Hmmm ...  Interesting suggestion, but I'm not sure this is a good idea.

For one thing, shouldn't that be "return 0", not "return 1".  If the
current tasks cpuset is mem_exclusive, and if we've already determined
that it doesn't allow the node in question, and if we've also just
determined that it is itself our nearest mem_exclusive ancestor,
then can't we conclude that the node in question is -not- allowed in
our nearest mem_exclusive ancestor?

And for another thing, it extends the RCU locking use just a teeny
bit.  Until now, we just RCU to let us check whether the cpuset
mems_generation was changed or not, without risking an invalid memory
reference.  The above proposal makes stronger demands, as follows.

Say for instance, another task changed our tasks cpuset just as we
were running this cpuset_zone_allowed() check, from a cpuset whose
-parent- would have allowed the node in question and which parent was
the nearest enclosing mem_exclusive cpuset, to a different cpuset
which would itself have allowed the node in question and which was
marked mem_exclusive.  Either the old or the new cpuset would have
allowed the node, but if we flip at just the wrong instant, after
we realize the node isn't allowed in the current cpuset, before we
check to see if that cpuset is mem_exclusive, we would conclude that
the node is not allowed.

I can't imagine even a micro benchmark test case that would detect
the above race failing, not to mention a real world noticable impact.
But it is a lost race.  Better not to code races, than to learn two
years later why they might matter.

For a third thing, this adds a little more kernel text, in order
to optimize the case that the current cpuset is mem_exclusive, at
the expense of a slightly longer code path for the case that it is
some ancestor that is the nearest enclosing mem_exclusive cpuset.

I guess it is workload and cpuset config dependent whether or not
such a tradeoff is an improvement, or a step backward.  Lacking a
persuasive argument that the case for which this optimizes is
enough more frequent than the other case to matter, I'm inclined
to pick the solution with the least code -- what's there now.

What am I missing?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
