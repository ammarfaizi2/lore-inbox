Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268337AbUH2VrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268337AbUH2VrO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 17:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268340AbUH2VrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 17:47:14 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:4258 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268337AbUH2VrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 17:47:04 -0400
Subject: Re: [BENCHMARK] nproc: netlink access to /proc information
From: Albert Cahalan <albert@users.sf.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Roger Luethi <rl@hellgate.ch>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Paul Jackson <pj@sgi.com>
In-Reply-To: <20040829204602.GW5492@holomorphy.com>
References: <20040828194546.GA25523@k3.hellgate.ch>
	 <20040828195647.GP5492@holomorphy.com>
	 <20040828201435.GB25523@k3.hellgate.ch>
	 <20040829160542.GF5492@holomorphy.com>
	 <20040829170247.GA9841@k3.hellgate.ch>
	 <20040829172022.GL5492@holomorphy.com>
	 <20040829175245.GA32117@k3.hellgate.ch>
	 <20040829181627.GR5492@holomorphy.com>
	 <20040829190050.GA31641@k3.hellgate.ch> <1093810645.434.6859.camel@cube>
	 <20040829204602.GW5492@holomorphy.com>
Content-Type: text/plain
Organization: 
Message-Id: <1093815946.431.6890.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 29 Aug 2004 17:45:47 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-29 at 16:46, William Lee Irwin III wrote:
> On Sun, Aug 29, 2004 at 04:17:26PM -0400, Albert Cahalan wrote:
> > When the reader falls behind, keep supplying differential
> > updates as long as practical. When this starts to eat up
> > lots of memory, switch to supplying the full list until
> > the reader catches up again.
> 
> You shouldn't have to try to scan the set of all tasks in any bounded
> period of time or rely on differential updates. Scanning some part of
> the list of a bounded size, updating the state based on what was
> scanned, and reporting the rest as if it hadn't changed is the strategy
> I'm describing.

That's defective. Users will not like it.

> > If you won't scan, why update the display? This boils down
> > to simply setting a lower refresh rate or using "nice".
> 
> Some updates can be captured, merely not all. Updating the
> state given what was captured during the partial scan and
> then displaying the state derived from what could be
> captured in the refresh interval is more useful than being
> nonfunctional at the lower refresh intervals or needlessly
> beating the kernel in some futile attempt to exhaustively
> search an impossibly huge dataset in some time bound that
> can't be satisfied.

nice -n 19 top

> Roger Luethi writes:
> >> While I'm not sure I understand how that partial rescan (or its limits)
> >> would be defined, I agree with the general idea. There is indeed plenty
> >> of room for improvement in a smart user space. For instance, most apps
> >> show only the top n processes. So if an app shows the top 20 memory
> >> users, it could use nproc to get a complete list of pid+vmrss, and then
> >> request all the expensive fields only for the top 20 in that list.
> 
> On Sun, Aug 29, 2004 at 04:17:26PM -0400, Albert Cahalan wrote:
> > This is crummy. It's done for wchan, since that is so horribly
> > expensive, but I'm not liking the larger race condition window.
> > Remember that PIDs get reused. There isn't a generation counter
> > or UUID that can be checked.
> 
> One shouldn't really need to care; periodically rechecking the fields
> of an active pid should suffice. You don't really care whether it's the
> same task or not, just that the fields are up-to-date and whether any
> task with that pid exists.

People use the procps tools to kill processes.
Bad data leads to bad decisions.

> On Sun, Aug 29, 2004 at 04:17:26PM -0400, Albert Cahalan wrote:
> > While "pid" makes a nice extreme example, note that ps must
> > handle arbitrary cases like "pmem,comm,wchan,ppid,session".
> > Now, I direct your attention to "Introduction to Algorithms",
> > by Cormen, Leiserson, and Rivest. Find the section entitled
> > "The set-covering problem". It's page 974, section 37.3, in
> > my version of the book. An example of this would be the
> > determination of the minimum set of /proc files needed to
> > supply some required set of process attributes.
> > Look familiar? It's NP-hard. To me, that just sounds bad. :-)
> > While there are decent (?) approximations that run in
> > polynomial time, they are generally overkill. It is very
> > common to need both the stat and status files. Selection,
> > sorting, and display all may require data.
> > But hey, we can go ahead and compute NP-hard problems in
> > userspace if that makes the kernel less complicated. :-)
> > Just remember that if I say "this is hard", I mean it.
> 
> Actually, the problem size is so small it shouldn't be problematic.
> There are only 13 /proc/ files associated with a process, so exhaustive
> search over 2**13 - 1 == 8191 nonempty subsets, e.g. queueing by size
> and checking for the satisfiability of the reporting, will suffice.

Nice! Checking for satisfiability is only NP-complete...

I do get your point, but I expect to see more /proc files
as time passes. Also, there is the issue of maintainability.

Example 1: It has crossed my mind to add separate files
for the least security-critical data, so that an SE Linux
system with moderate security could provide some minimal
amount of basic info to normal users.

Example 2: There could be files containing only data
that is easy to generate or that needs the same locking.

Even with the "ps -o pid" example given, opening /proc/*/stat
is required to get the tty. Opening /proc/*/status is nearly
required; one can do stat() on the directory to get that
via st_uid though.


