Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268259AbUH2USr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268259AbUH2USr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 16:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268280AbUH2USr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 16:18:47 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:26033 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268259AbUH2USn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 16:18:43 -0400
Subject: Re: [BENCHMARK] nproc: netlink access to /proc information
From: Albert Cahalan <albert@users.sf.net>
To: Roger Luethi <rl@hellgate.ch>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Paul Jackson <pj@sgi.com>
In-Reply-To: <20040829190050.GA31641@k3.hellgate.ch>
References: <20040827122412.GA20052@k3.hellgate.ch>
	 <20040827162308.GP2793@holomorphy.com>
	 <20040828194546.GA25523@k3.hellgate.ch>
	 <20040828195647.GP5492@holomorphy.com>
	 <20040828201435.GB25523@k3.hellgate.ch>
	 <20040829160542.GF5492@holomorphy.com>
	 <20040829170247.GA9841@k3.hellgate.ch>
	 <20040829172022.GL5492@holomorphy.com>
	 <20040829175245.GA32117@k3.hellgate.ch>
	 <20040829181627.GR5492@holomorphy.com>
	 <20040829190050.GA31641@k3.hellgate.ch>
Content-Type: text/plain
Organization: 
Message-Id: <1093810645.434.6859.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 29 Aug 2004 16:17:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Roger Luethi writes:
> On Sun, 29 Aug 2004 11:16:27 -0700, William Lee Irwin III wrote:
>> On Sun, Aug 29, 2004 at 07:52:45PM +0200, Roger Luethi wrote:

>>> I am confident that this problem (as far as process
>>> monitoring is concerned) could be addressed with
>>> differential notification.
...
>> Also, what guarantee is there that the notification
>> events come sufficiently slowly for a single task to
>> process, particularly when that task may not have a whole
>> cpu's resources to marshal to the task?
>
> A more likely guarantee is that a process that can't
> keep up with differential updates won't be able to
> process the whole list, either.

When the reader falls behind, keep supplying differential
updates as long as practical. When this starts to eat up
lots of memory, switch to supplying the full list until
the reader catches up again.

>> I have a vague notion that userspace should intelligently schedule
>> inquiries so requests are made at a rate the app can process and so
>> that the app doesn't consume excessive amounts of cpu. In such an
>> arrangement screen refresh events don't trigger a full scan of the
>> tasklist, but rather only an incremental partial rescan of it, whose
>> work is limited for the above cpu bandwidth concerns.

If you won't scan, why update the display? This boils down
to simply setting a lower refresh rate or using "nice".

> While I'm not sure I understand how that partial rescan (or its limits)
> would be defined, I agree with the general idea. There is indeed plenty
> of room for improvement in a smart user space. For instance, most apps
> show only the top n processes. So if an app shows the top 20 memory
> users, it could use nproc to get a complete list of pid+vmrss, and then
> request all the expensive fields only for the top 20 in that list.

This is crummy. It's done for wchan, since that is so horribly
expensive, but I'm not liking the larger race condition window.
Remember that PIDs get reused. There isn't a generation counter
or UUID that can be checked.

> Uhm... Optimized string parsing would require updated user space
> anyway. OTOH, I can buy the legacy kernel argument, so if you want to
> rewrite the user space tools, go wild :-). You may find that there are
> issues more serious than string parsing:
>
> $ ps --version
> procps version 3.2.3
> $ ps -o pid
>   PID
>  2089
>  2139
> $ strace ps -o pid 2>&1|grep 'open("/proc/'|wc -l
> 325
>
> <whine>

While "pid" makes a nice extreme example, note that ps must
handle arbitrary cases like "pmem,comm,wchan,ppid,session".

Now, I direct your attention to "Introduction to Algorithms",
by Cormen, Leiserson, and Rivest. Find the section entitled
"The set-covering problem". It's page 974, section 37.3, in
my version of the book. An example of this would be the
determination of the minimum set of /proc files needed to
supply some required set of process attributes.

Look familiar? It's NP-hard. To me, that just sounds bad. :-)

While there are decent (?) approximations that run in
polynomial time, they are generally overkill. It is very
common to need both the stat and status files. Selection,
sorting, and display all may require data.

But hey, we can go ahead and compute NP-hard problems in
userspace if that makes the kernel less complicated. :-)
Just remember that if I say "this is hard", I mean it.



