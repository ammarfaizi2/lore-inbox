Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265065AbSKUWqX>; Thu, 21 Nov 2002 17:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265074AbSKUWqX>; Thu, 21 Nov 2002 17:46:23 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:12440 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S265065AbSKUWqV> convert rfc822-to-8bit; Thu, 21 Nov 2002 17:46:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Failover in NFS
Date: Thu, 21 Nov 2002 16:52:52 -0600
User-Agent: KMail/1.4.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1021121154055.10456C-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1021121154055.10456C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211211652.53065.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 November 2002 02:58 pm, Bill Davidsen wrote:
> On Mon, 18 Nov 2002, Jesse Pollard wrote:
> > It would actually be better to use two floating IP numbers. That way
> > during normal operation, both servers would be functioning simultaneously
> > (based on the shared storage on two nodes).
> >
> > Then during failover, the floating IP of the failed node is activated on
> > the remaining node (total of 3 IP numbers now, one real, two floating).
> > The NFS recovery cycle should then cause the clients to remount the
> > filesystem from the backup server.
> >
> > When the failed node is recovered, the active server should then disable
> > the floating IP associated with the recovered server, causing only the
> > mounts using that IP number to fall back to the proper node, balancing
> > the load again.
>
> That works for stateless connections, but for stateful connections like
> POP, NNTP, SMTP, etc, you will lose all the connections currently
> actively.

yes. That is the point. NFS v3/4 CAN use TCP connections. The only way
I know to force them back to the recovered server IS to kill the connection.

> A proper solution is the have the recovered server accept ESTABLISHED and
> --syn packets, then DNAT the rest to the fallback server, while the
> fallback server takes and new (--syn) packets and does DNAT to the
> recovered server.

ahhh no. that doesn't work. The current connections have to be terminated
since what you are describing sounds like a fallback to a fallback.

If you want something like this you have to perform load balancing at
a router (with NAT/DNAT)  where the load balancing implementation is
independant of the host. Then each host in the cluster (since there may
be more than two) has to inform the router of the current load (say once
every 5, 10, or 15 seconds). If you are in a high availability configuration,
I would expect that there would need to be at least two load balancing
routers (a primary and backup). Then if a router fails, the higher up network
router would select an alternate path which would end up at the backup load
balancer.

TCP context would be saved in that situation. Even traffic loads could
be balanced between the two routers. This works because the "state"
information is only source/destination routes for packets, not TCP.

If a host node fails (not a router), then NEW connections can be redirected.
Unfortunately, the context of existing connections to the failed host is lost.

> I'm not sure iptables can do this right, you probably need a program to
> get the DNAT part just correct. There may be some one of the experimental
> patches which adds that capability, since people do load balancing with
> Linux. It might take source routing, and certainly will be harder than
> just turning off the alias ;-)

I don't think the host itself CAN do it, since you then get into the case
of a destination also being a router. It also means the load really doesn't
get balanced since the host must still carry the load of forwarding traffic
to the real server.

This can get really nasty in a cluster if it becomes necessary to reboot
various nodes. Suddenly the nodes start forwarding traffic around and
not doing the work.

If you are describing the use of a Linux router, however, you are back
in the second discussion with the load balancing router, and I think
(based on other discussion, not personal knowlege) iptables might
do it, with a little user land assist (the load balancing computations
could dynamically change the iptables entries for destinations).

This all started without a load balancing router, and how to get NFS
to switch servers. This, I think, is not that complicated other than
the tricky IP enable/disable between the two servers; and does ASSUME
(yes I know - "ass out of you and me" :-) a stateless communication
protocol. 

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
