Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262288AbRGSPpB>; Thu, 19 Jul 2001 11:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262634AbRGSPow>; Thu, 19 Jul 2001 11:44:52 -0400
Received: from mail.rdsnet.ro ([193.231.236.16]:48520 "HELO rdsnet.ro")
	by vger.kernel.org with SMTP id <S262288AbRGSPon>;
	Thu, 19 Jul 2001 11:44:43 -0400
Date: Thu, 19 Jul 2001 18:44:52 +0300 (EEST)
From: Cornel Ciocirlan <ctrl@rdsnet.ro>
To: linux-kernel@vger.kernel.org
Subject: Request for comments
Message-ID: <Pine.LNX.4.21.0107191757400.17990-100000@groove.rdsnet.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi, 

I was thinking of starting a project to implement a Cisco-like
"NetFlow" architecture for Linux. This would be relevant for edge routers
and/or network monitoring devices.  

What this would do is keep a "cache" of all the "flows" that are passing
through the system; a flow is defined as the set of packets that have the
same headers - or header fields. For example we could choose "ip source,
ip destination, ip protocol, ip source port [if relevant], ip destination
port [ if relevant ], and maintain a cache of all distinct such
"flows" that pass through the system. The flows would have to be
"expired" from the cache (LRU) and there should be a limit on the size of
the cache.

What can we use the cache for: 

a) more efficient packet filtering. After a cache entry is created for a
flow,  we apply the ACLs for the packet and associate the action with the
flow. All subsequent packets belonging to the same flow will be
dropped/accepted without re-appying the packet filtering rules
b) traffic statistics. When expiring a flow in the cache we could send a
special "messagge" to a user-space process with the 
	* flow caracteristics (ip src,ip dest etc)
	* total number of packets that were associated with this flow
	* flow start timestamp, flow last-activity timestamp
	* avg pkts/second while the flow was active
	* total bytes transmitted for this flow 
c) we could make routing decisions by looking at the flow cache, eg when 
  we first create the flow we look into the routing table and save the 
  index of the output interface in the flow cache. Subsequent packets
  matching the flow will not  cause a search through the routing table. 
d) prevent denial-of-service by configuring for example automatic
filtering of a flow that matches more than some-high-value pps (Most flows
will probably be 1000 pps max, while packet floods can be 5k-25k easily)

Problems: 
- some overhead will be added, however if we implement a) and c) above we
can reduce it. d) will also make the system perform better under high
load.
- we need to come up with a pretty efficient data structure to search
through it very quickly - if we route 20k pps, too much overhead will kill
us. I was thinking of a hash table with AVL trees instead of linked lists,
which I think the buffer cache is using; other options: splay trees maybe
useful ?)
- in all cases we'll need something like an expiry thread that actively
removes inactive flows from the cache 

Is it useful at all ? Point b) above could be implemented in userspace
(Actually I've done a basic skeleton a while ago). Are the others worth
the trouble ?

What do you gurus think ?

Kind regards,
Cornel.


