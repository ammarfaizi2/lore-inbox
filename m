Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268157AbUH2Utu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268157AbUH2Utu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 16:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266836AbUH2Urm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 16:47:42 -0400
Received: from holomorphy.com ([207.189.100.168]:17840 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268157AbUH2UqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 16:46:09 -0400
Date: Sun, 29 Aug 2004 13:46:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: Roger Luethi <rl@hellgate.ch>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [BENCHMARK] nproc: netlink access to /proc information
Message-ID: <20040829204602.GW5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>, Roger Luethi <rl@hellgate.ch>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	Paul Jackson <pj@sgi.com>
References: <20040828194546.GA25523@k3.hellgate.ch> <20040828195647.GP5492@holomorphy.com> <20040828201435.GB25523@k3.hellgate.ch> <20040829160542.GF5492@holomorphy.com> <20040829170247.GA9841@k3.hellgate.ch> <20040829172022.GL5492@holomorphy.com> <20040829175245.GA32117@k3.hellgate.ch> <20040829181627.GR5492@holomorphy.com> <20040829190050.GA31641@k3.hellgate.ch> <1093810645.434.6859.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093810645.434.6859.camel@cube>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2004 11:16:27 -0700, William Lee Irwin III wrote:
>>> Also, what guarantee is there that the notification
>>> events come sufficiently slowly for a single task to
>>> process, particularly when that task may not have a whole
>>> cpu's resources to marshal to the task?

Roger Luethi writes:
>> A more likely guarantee is that a process that can't
>> keep up with differential updates won't be able to
>> process the whole list, either.

On Sun, Aug 29, 2004 at 04:17:26PM -0400, Albert Cahalan wrote:
> When the reader falls behind, keep supplying differential
> updates as long as practical. When this starts to eat up
> lots of memory, switch to supplying the full list until
> the reader catches up again.

You shouldn't have to try to scan the set of all tasks in any bounded
period of time or rely on differential updates. Scanning some part of
the list of a bounded size, updating the state based on what was
scanned, and reporting the rest as if it hadn't changed is the strategy
I'm describing.


On Sun, 29 Aug 2004 11:16:27 -0700, William Lee Irwin III wrote:
>>> I have a vague notion that userspace should intelligently schedule
>>> inquiries so requests are made at a rate the app can process and so
>>> that the app doesn't consume excessive amounts of cpu. In such an
>>> arrangement screen refresh events don't trigger a full scan of the
>>> tasklist, but rather only an incremental partial rescan of it, whose
>>> work is limited for the above cpu bandwidth concerns.

On Sun, Aug 29, 2004 at 04:17:26PM -0400, Albert Cahalan wrote:
> If you won't scan, why update the display? This boils down
> to simply setting a lower refresh rate or using "nice".

Some updates can be captured, merely not all. Updating the state given
what was captured during the partial scan and then displaying the state
derived from what could be captured in the refresh interval is more
useful than being nonfunctional at the lower refresh intervals or
needlessly beating the kernel in some futile attempt to exhaustively
search an impossibly huge dataset in some time bound that can't be
satisfied.


Roger Luethi writes:
>> While I'm not sure I understand how that partial rescan (or its limits)
>> would be defined, I agree with the general idea. There is indeed plenty
>> of room for improvement in a smart user space. For instance, most apps
>> show only the top n processes. So if an app shows the top 20 memory
>> users, it could use nproc to get a complete list of pid+vmrss, and then
>> request all the expensive fields only for the top 20 in that list.

On Sun, Aug 29, 2004 at 04:17:26PM -0400, Albert Cahalan wrote:
> This is crummy. It's done for wchan, since that is so horribly
> expensive, but I'm not liking the larger race condition window.
> Remember that PIDs get reused. There isn't a generation counter
> or UUID that can be checked.

One shouldn't really need to care; periodically rechecking the fields
of an active pid should suffice. You don't really care whether it's the
same task or not, just that the fields are up-to-date and whether any
task with that pid exists.


Roger Luethi writes:
>> Uhm... Optimized string parsing would require updated user space
>> anyway. OTOH, I can buy the legacy kernel argument, so if you want to
>> rewrite the user space tools, go wild :-). You may find that there are
>> issues more serious than string parsing:
[...]

On Sun, Aug 29, 2004 at 04:17:26PM -0400, Albert Cahalan wrote:
> While "pid" makes a nice extreme example, note that ps must
> handle arbitrary cases like "pmem,comm,wchan,ppid,session".
> Now, I direct your attention to "Introduction to Algorithms",
> by Cormen, Leiserson, and Rivest. Find the section entitled
> "The set-covering problem". It's page 974, section 37.3, in
> my version of the book. An example of this would be the
> determination of the minimum set of /proc files needed to
> supply some required set of process attributes.
> Look familiar? It's NP-hard. To me, that just sounds bad. :-)
> While there are decent (?) approximations that run in
> polynomial time, they are generally overkill. It is very
> common to need both the stat and status files. Selection,
> sorting, and display all may require data.
> But hey, we can go ahead and compute NP-hard problems in
> userspace if that makes the kernel less complicated. :-)
> Just remember that if I say "this is hard", I mean it.

Actually, the problem size is so small it shouldn't be problematic.
There are only 13 /proc/ files associated with a process, so exhaustive
search over 2**13 - 1 == 8191 nonempty subsets, e.g. queueing by size
and checking for the satisfiability of the reporting, will suffice.


-- wli
