Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262135AbSIYWyJ>; Wed, 25 Sep 2002 18:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262139AbSIYWyJ>; Wed, 25 Sep 2002 18:54:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28800 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262135AbSIYWyI>;
	Wed, 25 Sep 2002 18:54:08 -0400
Date: Wed, 25 Sep 2002 15:52:46 -0700 (PDT)
Message-Id: <20020925.155246.41632313.davem@redhat.com>
To: nf@hipac.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification
 for Netfilter
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200209260041.56374.nf@hipac.org>
References: <200209260041.56374.nf@hipac.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: nf@hipac.org
   Date: Thu, 26 Sep 2002 00:41:56 +0200
   
   We have the results of some basic performance tests available on our web page. 
   The test compares the performance of the iptables filter table to the 
   performance of nf-hipac. Results are pretty impressive :-)

You missed the real trick, extending the routing tables to
do packet filter rule lookup.  That's where the real
performance gains can be found, and how we intend to eventually
make all firewalling/encapsulation/et al. work.

Such a scheme can even obviate socket lookup if implemented properly.
It'd basically be a flow cache, much like route lookups but with an
expanded key set and the capability to stack routes.  Such a flow
cache could even be two level, with the top level being %100 cpu local
on SMP (ie. no shared cache lines).

We have to do the route lookup anyways, if it got you to the packet
filtering tables (or ipsec encap information, or TCP socket, etc etc)
as a side effect, lots of netfilter becomes superfluous because all it
is doing is maintaining these lookup tables etc. which is what you are
optimizing.

Everyone looks to optimize these things on such a local level, and
that's not where the real improvements live.  Think globally, and the
more powerful solutions are much more evident.

Everything, from packet forwarding, to firewalling, to TCP socket
packet receive, can be described with routes.  It doesn't make sense
for forwarding, TCP, netfilter, and encapsulation schemes to duplicate
all of this table lookup logic and in fact it's entirely superfluous.

This stackable routes idea being worked on, watch this space over the
next couple of weeks :-)
