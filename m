Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264633AbTEPX3D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 19:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264634AbTEPX3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 19:29:03 -0400
Received: from mail.casabyte.com ([209.63.254.226]:46598 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S264633AbTEPX2u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 19:28:50 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "David Ashley" <dash@xdr.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Problem in ARP 2.4.20 kernel
Date: Fri, 16 May 2003 16:41:42 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGCEPMCLAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <200305162202.h4GM2LGN024925@xdr.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the below is good in theory, but it probably needs to be checked
against the proxy-arp behavior of some routing applications before it is
accepted as cannon.

(i.e. consider the bridging code...?)

I don't have such an application here, nor is this my best level of
abstraction.  It just seems like the most likely scenario for colliding with
the below.

Rob.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of David Ashley
Sent: Friday, May 16, 2003 3:02 PM
To: linux-kernel@vger.kernel.org
Subject: Problem in ARP 2.4.20 kernel


I'm working on a mechanism to load balance across multiple 100 mbit
interfaces
using the 2.4.20 linux kernel + custom server software. I have several
interfaces all on the same subnet with different IP addresses. They are
all connected to the same multi-port switch.

The intent is that a client can connect to any of the IP addresses
specifically and only burden that one. Some clients can connect to #1,
others
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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

