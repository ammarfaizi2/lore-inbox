Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264478AbTFQAbo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 20:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbTFQAbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 20:31:33 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:41392 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264478AbTFQAas (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 20:30:48 -0400
Subject: Re: patch for common networking error messages
To: "David S. Miller" <davem@redhat.com>
Cc: Daniel Stekloff <stekloff@us.ibm.com>, janiceg@us.ibm.com,
       jgarzik@pobox.com, Larry Kessler <lkessler@us.ibm.com>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, niv@us.ibm.com
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFDD16F58E.35149C65-ON85256D47.0081D564@us.ibm.com>
From: Janice Girouard <girouard@us.ibm.com>
Date: Mon, 16 Jun 2003 19:44:22 -0500
X-MIMETrack: Serialize by Router on D01ML063/01/M/IBM(Release 6.0.1 w/SPRs JHEG5JQ5CD, THTO5KLVS6, JHEG5HMLFK, JCHN5K5PG9|March
 27, 2003) at 06/16/2003 20:44:27
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: David S. Miller" <davem@redhat.com>
   Date: Mon, 16 Jun 2003 17:50:08 -0500

   If you want events, standardize events and push them over
   a queueing based communications channel to userspace, namely
   using netlink sockets.


It sounds like you are proposing a new family for the netlink
subsystem.  I've included a list of the families I see in 2.5.70
the end of this note.   I'm trying to understand which family handles
events such as link state changes or device initialization failure?
It sounds like you're proposing somethink equivalent to
NETLINK_TCP_DIAG.  Is that right?

There seems to be some overlap between netlink and netdev notifier
events.  Netdev notifier reports many key events.  One event I don't
see reported is any indication that device initialization failed.
#define NETDEV_UP               0x0001
#define NETDEV_DOWN             0x0002
#define NETDEV_REBOOT           0x0003
#define NETDEV_CHANGE           0x0004
#define NETDEV_REGISTER         0x0005
#define NETDEV_UNREGISTER       0x0006
#define NETDEV_CHANGEMTU        0x0007
#define NETDEV_CHANGEADDR       0x0008
#define NETDEV_GOING_DOWN       0x0009
#define NETDEV_CHANGENAME       0x000A

One issue with netdev, is that it doesn't seem to allow
for the flexibility of the information passed that netlink has.
For example, when you issue a NETDEV_CHANGE, it's not clear
from the event what the specific change was.


==============================
NETLINK 2.5.70

netlink.h

#define NETLINK_ROUTE           0       /* Routing/device hook                          */
#define NETLINK_SKIP            1       /* Reserved for ENskip                          */
#define NETLINK_USERSOCK        2       /* Reserved for user mode socket protocols      */
#define NETLINK_FIREWALL        3       /* Firewalling hook                             */
#define NETLINK_TCPDIAG         4       /* TCP socket monitoring                        */
#define NETLINK_NFLOG           5       /* netfilter/iptables ULOG */
#define NETLINK_XFRM            6       /* ipsec */
#define NETLINK_ARPD            8
#define NETLINK_ROUTE6          11      /* af_inet6 route comm channel */
#define NETLINK_IP6_FW          13
#define NETLINK_DNRTMSG         14      /* DECnet routing messages */
#define NETLINK_TAPBASE         16      /* 16 to 31 are ethertap */

Descriptions for many of these events can be found at
http://www.europe.redhat.com/documentation/man-pages/man7/netlink.7.php3

                                                                            
 NETLINK_ROUTE                                                              
       Receives routing updates and may be used                             
       to modify the IPv4 routing table (see                                
 NETLINK_FIREWALL                                                           
       Receives packets sent by the IPv4 firewall code.                     
 NETLINK_ARPD                                                               
       For managing the arp table in user space.                            
 NETLINK_ROUTE6                                                             
       Receives and sends IPv6 routing table updates.                       
 NETLINK_IP6_FW                                                             
       to receive packets that failed the IPv6 firewall                     
       checks (currently not implemented).                                  
 NETLINK_TAPBASE...NETLINK_TAPBASE+15                                       
       are the instances of the ethertap device. Ethertap                   
       is a pseudo network tunnel device that allows an                     
       ethernet driver to be simulated from user space.                     
 NETLINK_SKIP                                                               
       Reserved for ENskip.                                                 
 NETLINK_USERSOCK                                                           
       is reserved for future user space protocols.                         
                                                                            







