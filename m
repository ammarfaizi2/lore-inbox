Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267799AbTBPWe2>; Sun, 16 Feb 2003 17:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267801AbTBPWe2>; Sun, 16 Feb 2003 17:34:28 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:45721 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S267799AbTBPWe0>; Sun, 16 Feb 2003 17:34:26 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Neil Brown <neilb@cse.unsw.edu.au>
Date: Mon, 17 Feb 2003 09:43:31 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15952.5139.386765.700151@notabene.cse.unsw.edu.au>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Routing problem with udp, and a multihomed host in 2.4.20
In-Reply-To: message from Neil Brown on Friday February 14
References: <15946.54853.37531.810342@notabene.cse.unsw.edu.au>
	<1045120278.5115.0.camel@rth.ninka.net>
	<15947.25922.785515.945307@notabene.cse.unsw.edu.au>
	<20030213.011903.32136660.davem@redhat.com>
	<15948.13879.734412.313081@notabene.cse.unsw.edu.au>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday February 14, neilb@cse.unsw.edu.au wrote:
> 
> It turns out that the problem occurs when send_msg is used to send a
> UDP packet, and the control information contains
>               struct in_pktinfo {
>                   unsigned int   ipi_ifindex;  /* Interface index */
>                   struct in_addr ipi_spec_dst; /* Local address */
>                   struct in_addr ipi_addr;     /* Header Destination address */
>               };
> specifying the address and interface of the message that we are
> replying to.

Well, I took the plunge and hunted in and around the networking
code....

in net/ipv4/route.c, in ip_route_output_slow  there is an if clause:
   if (fib_lookup(&key, &res)) {

In my situation, fib_lookup will fail because key contains a 
non-zero "oif" (output interface), but that interface does not have a
valid route to key.dst.

What should be done in that case?  Well in my situation, the oif is
just a hint, not a requirement (it is, after all, the interface that
the request arrived on.  It is not necessarily the interface that the
reply has to go out on).  So possibly it should clear oif and try
fib_lookup again.  But it doesn't.
This is a branch for "if oif is non-zero", and it is largely a
comment:

		if (oldkey->oif) {
			/* Apparently, routing tables are wrong. Assume,
			   that the destination is on link.

			   WHY? DW.
			   Because we are allowed to send to iface
			   even if it has NO routes and NO assigned
			   addresses. When oif is specified, routing
			   tables are looked up with only one purpose:
			   to catch if destination is gatewayed, rather than
			   direct. Moreover, if MSG_DONTROUTE is set,
			   we send packet, ignoring both routing tables
			   and ifaddr state. --ANK


			   We could make it even if oif is unknown,
			   likely IPv6, but we do not.
			 */

			if (key.src == 0)
				key.src = inet_select_addr(dev_out, 0,
							   RT_SCOPE_LINK);
			res.type = RTN_UNICAST;
			goto make_route;

This comment seems to be considering a case where oif has been set as
an explicit request for the message to go on that interface, which is
not the case for "sendmsg" with an IP_PKTINFO attachment.

Maybe when ip_cmsg_send interprets the IP_PKTINFO and sets ipc->oif,
it should set some flag to say "hint".  And then fib_lookup, or
possibly ip_route_output_slow, could test for that hint and re-try
with no oif if the first try fails..

But even that is not a complete solution.  We would also need to
modify ip_route_output_key which scans a table of recently computed
routes to avoid having to do fib_lookup for every packet.  This table
would need to know about oif's that are hints, and ones that are
requirements.

At about this point it got all a bit too complicated, so I haven't
bothered to try to patch the kernel to make it work right.

Rather, I noticed that if the interface specified does have a route to
the destination, that route will be taken rather than attempting to
directly send to the dest.

So I have added default routes to all of my interfaces, not just the
prefered one, and my symptoms have gone away (and I don't need
proxy-arp on the router any more).

This will satisfy my needs for now, but I feel that something should
be done to fix this problem the "right" way.  I'm just not sure what.

NeilBrown

