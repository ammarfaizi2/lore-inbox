Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbUCEU3J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 15:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbUCEU3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 15:29:09 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:54026
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262694AbUCEU3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 15:29:04 -0500
Date: Fri, 5 Mar 2004 21:29:42 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Ingo Molnar <mingo@elte.hu>, Peter Zaitsev <peter@mysql.com>,
       Andrew Morton <akpm@osdl.org>, riel@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040305202941.GT4922@dualathlon.random>
References: <1078370073.3403.759.camel@abyss.local> <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040305103308.GA5092@elte.hu> <20040305141504.GY4922@dualathlon.random> <20040305143210.GA11897@elte.hu> <20040305145837.GZ4922@dualathlon.random> <39960000.1078512175@flay> <20040305191329.GR4922@dualathlon.random> <56050000.1078516505@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56050000.1078516505@flay>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2004 at 11:55:05AM -0800, Martin J. Bligh wrote:
> Didn't used to in SLES8 at least. maybe it does in 2.6 now, I know Andrew
> worked on that a lot.

it should in every SLES8 kernel out there too (it wasn't in mainline
until very recently), see the related bhs stuff.

> In 2.6, I think the task struct is outside the kernel stack either way.
> Maybe you were pointing out something else? not sure.

I meant that making the kernel stack 4k pretty much requires removing
the task_struct, making it 4k w/o removing the task_struct sounds too
small.

> > The main thing you didn't mention is the overhead in the per-cpu data
> > structures, that alone generates an overhead of several dozen mbytes
> > only in the page allocator, without accounting the slab caches,
> > pagetable caches etc.. putting an high limit to the per-cpu caches
> > should make a 32-way 32G work fine with 3:1 too though. 8-way is
> > fine with 32G currently.
> 
> Humpf. Do you have a hard figure on how much it actually is per cpu?

not a definitive one, but it's sure more than 2m per cpu, could be 3m
per cpu.

> > other relevant things are the fs stuff like file handles per task and
> > other pinned slab things.
> 
> Yeah, that was a huge one we forgot ... sysfs. Particularly with large
> numbers of disks, IIRC, though other resources might generate similar
> issues.

which doesn't need to be mounted during production and hotplug should
mount read it and unmount. It's worthless to leave it mounted. Only
root-only hardware related stuff should be in sysfs, everything else
that has been abstracted at the kernel level (transparent to
applications) should remain in /proc. unmounting /proc hurts the
production systems, unmounting sysfs should not.

> You mean with the 8cpu box you mentioned above? Yes, probably 5K. Larger 
> boxes will get progressively scarier ;-)

yes.

> What scares me more is that we can sit playing counting games all day,
> but there's always something we will forget. So I'm not keen on playing
> brinkmanship games with customers systems ;-)

this is true for 4:4 too. Also with 2.4 the system will return -ENOMEM,
not like 2.6 that lockup the box. so it's not a fatal thing if a certain
kernel can't sustain a certain workload in a certain hardware, just like
it's not a fatal thing if your run out of memory for the pagetables on a
64bit architecture with 64bit kernel. My only object is to make it feasible
to run the most high end workloads in the most high end hardware with a
good safety margin, knowing if something goes wrong the worst that can
happen is that a syscall returns -ENOMEM. There will always be a
malicious workload able to fill the zone-normal, if you fork off a tons
of tasks, and you open a gazzillon of sockets and you flood all of them
at the same time to fill all receive windows you'll fill your cool 4G
zone-normal of 4:4 in half a second with a 10gigabit NIC.
