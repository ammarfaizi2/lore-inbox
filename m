Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130051AbRBVPbW>; Thu, 22 Feb 2001 10:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130008AbRBVPbM>; Thu, 22 Feb 2001 10:31:12 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:44300 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S129300AbRBVPa6>; Thu, 22 Feb 2001 10:30:58 -0500
Date: Thu, 22 Feb 2001 15:30:47 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: ARP out the wrong interface
In-Reply-To: <Pine.LNX.4.33.0102212050480.22754-100000@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.10.10102221519540.2348-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2001, dean gaudet wrote:

> > 2.2.18 and 2.4 apparently have a patch called "arpfilter"
> > integrated which should allow you to:
> >
> > # sysctl -w net.ipv4.conf.all.arpfilter=1
> >
> > to get much stricter behaviour regarding ARP replies.
> 
> hmm, so i'm working with a 2.4.1-ac20-TUX-P5 kernel and i can't find
> "arpfilter" or "arp.*filter" in any of the files, so it doesn't appear
> to have made it into 2.4.  i've been using the patch attached below
> and it's solving the problem for me for now.  (it could be entirely
> wrong, but it's letting me at least get some other work done :)

Thanks.

Below is what Andi Kleen sent me last time this came up.

Matthew.


>From ak@suse.de Thu Feb 22 15:19:51 2001
Date: Mon, 4 Sep 2000 12:06:02 +0200
From: Andi Kleen <ak@suse.de>
To: Matthew Kirkwood <matthew@hairy.beasts.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
     David Luyer <david_luyer@pacific.net.au>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2 - BSD/OS 4.1 ARP incompatibility

On Mon, Sep 04, 2000 at 10:57:44AM +0100, Matthew Kirkwood wrote:
> > > With both interfaces up, it's impossible to apply anti-martian
> > > rules to the interfaces, since it's hard to predict which card
> > > will answer an ARP request.
> >
> > /proc/sys/net/ipv4/.../hidden
> 
> So when lightning fries the primary ethcard in the machine,
> I have to know the hw address of the second card to get in?
> 
> Also, it can be used to scan through a dual-homed host to
> determine the address range in use on the other side, which
> I'd rather wasn't possible.
> 
> /proc/sys/net/ipv4/\"correct\"_arp_reply_interface_selection
> maybe?

It is called arpfilter. Here is the old 2.2.16 version (applies to 2.4 with
minor changes)

It is useful for various things, one of them being automatic load balancing
for incoming connections using multipath routes.

-Andi


--- linux/include/linux/inetdevice.h.ARPFILTER	Tue Jan  4 19:12:24 2000
+++ linux/include/linux/inetdevice.h	Sat Jun 24 14:02:07 2000
@@ -17,6 +17,7 @@
 	int	forwarding;
 	int	mc_forwarding;
 	int	hidden;
+	int	arp_filter; 
 	void	*sysctl;
 };
 
@@ -51,6 +52,9 @@
 	  (ipv4_devconf.accept_redirects && (in_dev)->cnf.accept_redirects)) \
 	 || (!IN_DEV_FORWARD(in_dev) && \
 	  (ipv4_devconf.accept_redirects || (in_dev)->cnf.accept_redirects)))
+
+#define IN_DEV_ARPFILTER(in_dev)	(ipv4_devconf.arp_filter || \
+					 (in_dev)->cnf.arp_filter)
 
 struct in_ifaddr
 {
--- linux/include/linux/sysctl.h.ARPFILTER	Fri Jun 23 17:47:22 2000
+++ linux/include/linux/sysctl.h	Sat Jun 24 14:02:07 2000
@@ -272,7 +272,8 @@
 	NET_IPV4_CONF_ACCEPT_SOURCE_ROUTE=9,
 	NET_IPV4_CONF_BOOTP_RELAY=10,
 	NET_IPV4_CONF_LOG_MARTIANS=11,
-	NET_IPV4_CONF_HIDDEN=12
+	NET_IPV4_CONF_HIDDEN=12,
+	NET_IPV4_CONF_ARPFILTER=13
 };
 
 /* /proc/sys/net/ipv6 */
--- linux/include/net/snmp.h.ARPFILTER	Fri Jun 23 17:47:05 2000
+++ linux/include/net/snmp.h	Sat Jun 24 14:04:19 2000
@@ -179,6 +179,7 @@
 	unsigned long	OutOfWindowIcmps; 
 	unsigned long	LockDroppedIcmps; 
 	unsigned long	SockMallocOOM; 
+	unsigned long	ArpFilter;
 };
  	
 #endif
--- linux/net/ipv4/proc.c.ARPFILTER	Fri Jun 23 17:47:06 2000
+++ linux/net/ipv4/proc.c	Sat Jun 24 14:03:48 2000
@@ -371,6 +371,10 @@
 		      net_statistics.OutOfWindowIcmps,
 		      net_statistics.LockDroppedIcmps,
 		      net_statistics.SockMallocOOM);
+	len += sprintf(buffer + len, 
+				"IpExt: ArpFilter\n"
+				"IpExt: %lu\n",
+			  net_statistics.ArpFilter); 		
 
 	if (offset >= len)
 	{
--- linux/net/ipv4/arp.c.ARPFILTER	Fri Jun 23 12:19:11 2000
+++ linux/net/ipv4/arp.c	Sat Jun 24 14:02:07 2000
@@ -339,6 +339,22 @@
 		 dst_ha, dev->dev_addr, NULL);
 }
 
+static int arp_filter(__u32 sip, __u32 tip, struct device *dev)
+{
+	struct rtable *rt;
+	int flag = 0; 
+	//unsigned long now; 
+
+	if (ip_route_output(&rt, sip, tip, 0, 0) < 0) 
+		return 1;
+	if (rt->u.dst.dev != dev) { 
+		net_statistics.ArpFilter++; 
+		flag = 1; 
+	} 
+	ip_rt_put(rt); 
+	return flag; 
+} 
+
 /* OBSOLETE FUNCTIONS */
 
 /*
@@ -689,6 +705,7 @@
 		if (addr_type == RTN_LOCAL) {
 			n = neigh_event_ns(&arp_tbl, sha, &sip, dev);
 			if (n) {
+				int dont_send = 0; 
 				if (ipv4_devconf.hidden &&
 				    skb->pkt_type != PACKET_HOST) {
 					struct device *dev2;
@@ -698,12 +715,14 @@
 					    dev2 != dev &&
 					    (in_dev2 = dev2->ip_ptr) != NULL &&
 					    IN_DEV_HIDDEN(in_dev2)) {
-						neigh_release(n);
-						goto out;
-					}
+						dont_send = 1; 
+					}	
 				}
+				if (IN_DEV_ARPFILTER(in_dev))
+					dont_send |= arp_filter(sip,tip,dev); 
 
-				arp_send(ARPOP_REPLY,ETH_P_ARP,sip,dev,tip,sha,dev->dev_addr,sha);
+				if (!dont_send) 
+					arp_send(ARPOP_REPLY,ETH_P_ARP,sip,dev,tip,sha,dev->dev_addr,sha);
 				neigh_release(n);
 			}
 			goto out;
--- linux/net/ipv4/devinet.c.ARPFILTER	Fri Jun 23 17:47:31 2000
+++ linux/net/ipv4/devinet.c	Sat Jun 24 14:02:07 2000
@@ -932,7 +932,7 @@
 static struct devinet_sysctl_table
 {
 	struct ctl_table_header *sysctl_header;
-	ctl_table devinet_vars[13];
+	ctl_table devinet_vars[14];
 	ctl_table devinet_dev[2];
 	ctl_table devinet_conf_dir[2];
 	ctl_table devinet_proto_dir[2];
@@ -974,6 +974,9 @@
          &proc_dointvec},
 	{NET_IPV4_CONF_HIDDEN, "hidden",
          &ipv4_devconf.hidden, sizeof(int), 0644, NULL,
+         &proc_dointvec},
+	{NET_IPV4_CONF_ARPFILTER, "arp_filter",
+         &ipv4_devconf.arp_filter, sizeof(int), 0644, NULL,
          &proc_dointvec},
 	 {0}},
 



> 
> Matthew.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

