Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbTEPVt1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 17:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbTEPVt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 17:49:26 -0400
Received: from ns.xdr.com ([209.48.37.1]:39892 "EHLO xdr.com")
	by vger.kernel.org with ESMTP id S262138AbTEPVtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 17:49:24 -0400
Date: Fri, 16 May 2003 15:02:21 -0700
From: David Ashley <dash@xdr.com>
Message-Id: <200305162202.h4GM2LGN024925@xdr.com>
To: linux-kernel@vger.kernel.org
Subject: Problem in ARP 2.4.20 kernel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on a mechanism to load balance across multiple 100 mbit interfaces
using the 2.4.20 linux kernel + custom server software. I have several
interfaces all on the same subnet with different IP addresses. They are
all connected to the same multi-port switch.

The intent is that a client can connect to any of the IP addresses
specifically and only burden that one. Some clients can connect to #1, others
to #2, etc.

The problem I ran into was the kernel's handling of ARP requests. What linux
does is each interface receives the arp request, and every single one
answers the request. So it becomes a race condition which response gets to
the client, and the client will have usually an incorrect mac address/ip
address arp entry.

I fixed this problem by modifying net/ipv4/arp.c:
//add to top of file in the #includes
#include <linux/inetdevice.h> // (DA) 20030515 to fix arp problem
//...then later in function arp_process()
		if (addr_type == RTN_LOCAL) {
			n = neigh_event_ns(&arp_tbl, sha, &sip, dev);
			if (n) {
+				struct in_device *ind;
				int dont_send = 0;
				if (IN_DEV_ARPFILTER(in_dev))
					dont_send |= arp_filter(sip,tip,dev); 
+// (DA) 20030515 only send arp response if dev's IP address matches
+				if((ind=__in_dev_get(dev))) {
+					struct in_ifaddr *ifa;
+					ifa=ind->ifa_list;
+					while(ifa)
+					{
+						if(ifa->ifa_address==tip) break;
+						ifa=ifa->ifa_next;
+					}
+					if(!ifa) dont_send=1;
+				}
				if (!dont_send)
					arp_send(ARPOP_REPLY,ETH_P_ARP,sip,dev,tip,sha,dev->dev_addr,sha);

				neigh_release(n);
			}
			goto out;

Before sending the arp response, the requested IP address is checked against
the interface's configured IP address, and only if there is a match will an
ARP response be sent.

I think the the check is harmless in any case. It's not clear to me if you'd
ever want each interface answering the ARP requests, and it is clear there
is a valid reason for wanting to wire up a computer this way. Enjoy!

-Dave

