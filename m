Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbTIZPwl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 11:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbTIZPwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 11:52:41 -0400
Received: from sprocket.loran.com ([209.167.240.9]:64754 "EHLO
	willy.ottawa.loran.com") by vger.kernel.org with ESMTP
	id S261345AbTIZPwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 11:52:38 -0400
Subject: Re: route cache and messed up network
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1064518793.42554.93.camel@dlacoste.ottawa.loran.com>
References: <1064518793.42554.93.camel@dlacoste.ottawa.loran.com>
Content-Type: text/plain
Message-Id: <1064591600.84549.1.camel@dlacoste.ottawa.loran.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 26 Sep 2003 11:53:21 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Originally sent to linux-net, but that list seems to
be almost zero traffic lately :)

I'm trying to get a system working where Linux's network
route cache is causing problems.

Essentially, the linux side of the problem appears to be that
/proc/sys/net/ipv4/gc_timeout (for ICMP redirect entries) times
out not on how long it's been in the cache but on how long it's
been idle : if the entry is not idle it will never time out.

I verified this behaviour by setting the timeout to 20 seconds
and testing it with ping :

echo '20' > /proc/sys/net/ipv4/gc_timeout
ping ip_address once
   Redirect message appears in output
ping ip_address again (once)
   Redirect does not appear
sleep 30
ping ip_address again (once)
   Redirect message appears in output
ping for 30 seconds
ping ip_address again (once)
   Redirect does not appear
sleep 30
ping ip_address again (once)
   Redirect message appears in output

So it only expires the cache if it's not active.

Can I change this?  I notice that net/ipv4/route.c has a line
that says :
               /* Entry is expired even if it is in use */
(kernel 2.4.22, stock, line 408)

Can I force it to timeout entries that are in use?

Here's the situation :

System A is a linux server
System B is a Cisco router
System C is a PIX firewall

Subnet X has the linux server, Cisco router, and PIX firewall
Subnet Y is an internal network connected via System B
Subnet Z is the internet, behind the PIX

System A (linux) has a single default route to System B (cisco
router) for all traffic.

System B (cisco router) has static routes for (is connected to)
Subnets X and Y, and a default route to System C (the firewall.)

Sometimes the connection to Subnet Y on System B (cisco router)
will go down when System A (Linux server) tries to communicate
with a system in Subnet Y.  It for some unknown and really
bass-ackwards reason decides then that the default route (to
System C, the firewall) is where the packets should be going,
so it sends them there along with an ICMP redirect back to
System A (the linux box,) to let it know that it would be more
efficient to send the packet to System C (the firewall) than to
System B (the cisco router.)

Well, System C (the firewall) doesn't route packets from the
internal network to the internal network : it just throws them
away.  So the packets from System A (linux server) to Subnet Y
(internal network) don't arrive.  As the gc_timeout is set to
300 seconds and the linux kernel only times out on idle routes,
and System A (the linux server) tries to reconnect every minute,
the (bad) route cache entry never expires and the packets never
reach their destination again.

I've proposed that the cisco box shouldn't send ICMP redirects
for subnets which it has a local connection to if no other connection
to that subnet exists, and that the PIX firewall should be intelligent
enough to do another ICMP redirect back to the cisco router,
but instead it just throws all the packets away and I'm not
allowed to change either of these things.

Which means I can only change the linux box.  Is there a way I can
change it so that it does a timeout on all route cache entries,
wether they're used or not?

Thanks

Dana Lacoste
Ottawa, Canada

