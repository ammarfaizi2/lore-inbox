Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932968AbWFZTgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932968AbWFZTgg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 15:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932965AbWFZTgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 15:36:35 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61571 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932957AbWFZTge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 15:36:34 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Daniel Lezcano <dlezcano@fr.ibm.com>, Andrey Savochkin <saw@swsoft.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       dev@sw.ru, devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
References: <20060609210202.215291000@localhost.localdomain>
	<20060609210625.144158000@localhost.localdomain>
	<20060626134711.A28729@castle.nmd.msu.ru>
	<449FF5A0.2000403@fr.ibm.com> <20060626192751.A989@castle.nmd.msu.ru>
	<44A00215.2040608@fr.ibm.com>
	<m1hd27uaxw.fsf@ebiederm.dsl.xmission.com>
	<20060626183649.GB3368@MAIL.13thfloor.at>
Date: Mon, 26 Jun 2006 13:35:15 -0600
In-Reply-To: <20060626183649.GB3368@MAIL.13thfloor.at> (Herbert Poetzl's
	message of "Mon, 26 Jun 2006 20:36:49 +0200")
Message-ID: <m1u067r9qk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> writes:

> On Mon, Jun 26, 2006 at 10:40:59AM -0600, Eric W. Biederman wrote:
>> Daniel Lezcano <dlezcano@fr.ibm.com> writes:
>> 
>> >> Then you lose the ability for each namespace to have its own
>> >> routing entries. Which implies that you'll have difficulties with
>> >> devices that should exist and be visible in one namespace only
>> >> (like tunnels), as they require IP addresses and route.
>> >
>> > I mean instead of having the route tables private to the namespace, the
> routes
>> > have the information to which namespace they are associated.
>> 
>> Is this an implementation difference or is this a user visible
>> difference? As an implementation difference this is sensible, as it is
>> pretty insane to allocate hash tables at run time.
>>
>> As a user visible difference that affects semantics of the operations
>> this is not something we want to do.
>
> well, I guess there are even more options here, for
> example I'd like to propose the following idea, which
> might be a viable solution for the policy/isolation
> problem, with the actual overhead on the setup part
> not the hot pathes for packet and connection handling
>
> we could use the multiple routing tables to provide
> a single routing table for each guest, which could
> be used inside the guest to add arbitrary routes, but
> would allow to keep the 'main' policy on the host, by
> selecting the proper table based on IPs and guest tags
>
> similar we could allow to have a separate iptables
> chain for each guest (or several chains), which are
> once again directed by the host system (applying the
> required prolicy) which can be managed and configured
> via normal iptable interfaces (both on the guest and
> host) but actually provide at least to layers

I have real concerns about the complexity of the route you
have described.

> note: this does not work for hierarchical network
> contexts, but I do not see that the yet proposed
> implementations would do, so I do not think that
> is of concern here ...

Well we are hierarchical in the sense that a parent
can have a different network namespace then a child.
So recursive containers work fine.  So this is like
the uts namespace or the ipc namespace rather than
like the pid namespace.

I really do not believe we have a hotpath issue, if this
is implemented properly. Benchmarks of course need to be taken,
to prove this.

There are only two places a sane implementation should show issues.
- When the access to a pointer goes through a pointer to find
  that global variable.
- When doing a lookup in a hash table we need to look at an additional
  field to verify a hash match.  Because having a completely separate
  hash table is likely too expensive.

If that can be shown to really slow down packets on the hot path
I am willing to consider other possibilities.  Until then I think
we are on path to the simplest and most powerful version of building
a network namespace usable by containers.

The routing between network namespaces does have the potential to
be more expensive than just a packet trivially coming off the wire
into a socket.  However that is fundamentally from a lack of hardware.
If the rest works smarter filters in the drivers should enable to
remove the cost.

Basically it is just a matter of:
if (dest_mac == my_mac1) it is for device 1.
If (dest_mac == my_mac2) it is for device 2.
etc.

At a small count of macs it is trivial to understand it will go
fast for a larger count of macs it only works with a good data
structure.  We don't hit any extra cache lines of the packet,
and the above test can be collapsed with other routing lookup tests.

Eric

