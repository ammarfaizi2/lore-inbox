Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274553AbRITQOt>; Thu, 20 Sep 2001 12:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274555AbRITQOj>; Thu, 20 Sep 2001 12:14:39 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:17317 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S274553AbRITQOX>; Thu, 20 Sep 2001 12:14:23 -0400
Importance: Normal
Subject: [PATCH] strict interface arp patch for Linux 2.4.2
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3  March 21, 2000
Message-ID: <OFF5C2EACC.84AC7208-ON85256ACD.0058E6BB@raleigh.ibm.com>
From: "Allen Lau" <pflau@us.ibm.com>
Date: Thu, 20 Sep 2001 12:12:53 -0400
X-MIMETrack: Serialize by Router on D04NMS38/04/M/IBM(Release 5.0.8 |June 18, 2001) at
 09/20/2001 12:14:16 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I want to bring your attention to a Linux ARP patch we plan to use for load balancing and server
clustering.  The available arp filter and hidden patch are not completely satisfactory. The following
post by Julian Anastasov and Bernd Eckenfels described the virtual server clustering problem.

      http://www.uwsg.indiana.edu/hypermail/linux/kernel/0101.3/0188.html

To generalize, each real server may have multiple nic's of different types. The task becomes one of
maintaining strict identity of each of the real and virtual ip addresses.  The Linux ARP has the
following behaviors which are problematic for maintaining strict interface identify.

   1) box responds to arp on all interfaces on the same wire for an IP address (arp race)
   2) interface responds to arp requests for any of its IP addresses (loopback not hidden)
   3) box responds to arp request for downed interface IP address
   4) interface uses as source (in arp request) IP address from any other interface (arp flux)

The proposed strict interface arp patch tackles the strict interface identify problem by explicitly
binding arp request and response to the interface (i.e. an interface uses as source and responds to
ARPs for an IP address only if the address is configured on the interface).

The strict_interface_arp patch can be enabled for individual or all interfaces.
   1) to enable for eth0 dynamically
      [/root]# echo 1 > /proc/sys/net/ipv4/conf/eth0/strict_interface_arp

   2) to enable for all interfaces on boot using /etc/sysctl.conf
      [/root]# cat /etc/sysctl.conf
      # Enable strict_interface_arp :
      net.ipv4.conf.all.strict_interface_arp = 1

Your comments are sincerely appreciated.

Allen Lau
IBM Storage Network Division
Research Triangle Park, NC  27709
email : pflau@us.ibm.com

diff -Naur linux-2.4.2-2/Documentation/filesystems/proc.txt linux-2.4.2-2-strict_interface_arp/Documentation/filesystems/proc.txt
--- linux-2.4.2-2/Documentation/filesystems/proc.txt    Sat Sep  8 22:08:40 2001
+++ linux-2.4.2-2-strict_interface_arp/Documentation/filesystems/proc.txt   Mon Sep 10 12:33:30 2001
@@ -1578,6 +1578,14 @@

 Determines whether to send ICMP redirects to other hosts.

+strict_interface_arp
+--------------------
+
+Bind arp request and response to the interface (i.e. an interface uses as source
+and responds to ARPs for an IP address only if the address is configured on the
+interface).
+
+
 Routing settings
 ----------------

diff -Naur linux-2.4.2-2/include/linux/inetdevice.h linux-2.4.2-2-strict_interface_arp/include/linux/inetdevice.h
--- linux-2.4.2-2/include/linux/inetdevice.h  Sat Sep  8 22:08:40 2001
+++ linux-2.4.2-2-strict_interface_arp/include/linux/inetdevice.h      Mon Sep 10 12:33:30 2001
@@ -17,6 +17,7 @@
     int  forwarding;
     int  mc_forwarding;
     int  tag;
+    int  strict_interface_arp;
     void *sysctl;
 };

@@ -47,6 +48,7 @@
 #define IN_DEV_TX_REDIRECTS(in_dev)     (ipv4_devconf.send_redirects || (in_dev)->cnf.send_redirects)
 #define IN_DEV_SEC_REDIRECTS(in_dev)    (ipv4_devconf.secure_redirects || (in_dev)->cnf.secure_redirects)
 #define IN_DEV_IDTAG(in_dev)      ((in_dev)->cnf.tag)
+#define IN_DEV_STRICT_INTF_ARP(in_dev)  (ipv4_devconf.strict_interface_arp || (in_dev)->cnf.strict_interface_arp)

 #define IN_DEV_RX_REDIRECTS(in_dev) \
     ((IN_DEV_FORWARD(in_dev) && \
diff -Naur linux-2.4.2-2/include/linux/sysctl.h linux-2.4.2-2-strict_interface_arp/include/linux/sysctl.h
--- linux-2.4.2-2/include/linux/sysctl.h      Sat Sep  8 22:08:40 2001
+++ linux-2.4.2-2-strict_interface_arp/include/linux/sysctl.h     Mon Sep 10 12:33:30 2001
@@ -327,7 +327,8 @@
     NET_IPV4_CONF_ACCEPT_SOURCE_ROUTE=9,
     NET_IPV4_CONF_BOOTP_RELAY=10,
     NET_IPV4_CONF_LOG_MARTIANS=11,
-    NET_IPV4_CONF_TAG=12
+    NET_IPV4_CONF_TAG=12,
+    NET_IPV4_CONF_STRICT_INTERFACE_ARP=13
 };

 /* /proc/sys/net/ipv6 */
diff -Naur linux-2.4.2-2/net/ipv4/arp.c linux-2.4.2-2-strict_interface_arp/net/ipv4/arp.c
--- linux-2.4.2-2/net/ipv4/arp.c   Sat Sep  8 22:08:40 2001
+++ linux-2.4.2-2-strict_interface_arp/net/ipv4/arp.c   Mon Sep 10 12:33:30 2001
@@ -314,16 +314,43 @@

 static void arp_solicit(struct neighbour *neigh, struct sk_buff *skb)
 {
+    u32 sip;
+    int onlink = 0;
+    struct in_device *in_dev = NULL;
+
     u32 saddr;
     u8  *dst_ha = NULL;
     struct net_device *dev = neigh->dev;
     u32 target = *(u32*)neigh->primary_key;
     int probes = atomic_read(&neigh->probes);

-    if (skb && inet_addr_type(skb->nh.iph->saddr) == RTN_LOCAL)
-         saddr = skb->nh.iph->saddr;
-    else
+    /* if strict_interface_arp then bind arp request saddr to the interface. i.e. saddr must
+     * be on dev where arp request is sent - pflau 06-29-2001 */
+    if (skb) {
+            sip = skb->nh.iph->saddr;
+         in_dev = in_dev_get(dev);
+
+                if (IN_DEV_STRICT_INTF_ARP(in_dev)) {
+              read_lock(&in_dev->lock);
+              for_ifa(in_dev) {
+                   if ((onlink = !(sip ^ ifa->ifa_local)) != 0)
+                                  break;
+              } endfor_ifa(in_dev);
+              read_unlock(&in_dev->lock);
+         } else if (inet_addr_type(skb->nh.iph->saddr) == RTN_LOCAL)
+              onlink = 1;
+
+         if (in_dev)
+              in_dev_put(in_dev);
+    }
+
+
+    if (onlink) {
+         saddr = skb->nh.iph->saddr;
+    } else {
          saddr = inet_select_addr(dev, target, RT_SCOPE_LINK);
+    }
+

     if ((probes -= neigh->parms->ucast_probes) < 0) {
          if (!(neigh->nud_state&NUD_VALID))
@@ -571,6 +598,7 @@
     int addr_type;
     struct in_device *in_dev = in_dev_get(dev);
     struct neighbour *n;
+    int onlink;

 /*
  *  The hardware length of the packet should match the hardware length
@@ -725,8 +753,21 @@
     /* Special case: IPv4 duplicate address detection packet (RFC2131) */
     if (sip == 0) {
          if (arp->ar_op == __constant_htons(ARPOP_REQUEST) &&
-             inet_addr_type(tip) == RTN_LOCAL)
-              arp_send(ARPOP_REPLY,ETH_P_ARP,tip,dev,tip,sha,dev->dev_addr,dev->dev_addr);
+             inet_addr_type(tip) == RTN_LOCAL) {
+              onlink = 0;
+              if (IN_DEV_STRICT_INTF_ARP(in_dev)) {
+                   read_lock(&in_dev->lock);
+                   for_ifa(in_dev) {
+                        if ((onlink = !(tip ^ ifa->ifa_local)) != 0)
+                             break;
+                   } endfor_ifa(in_dev);
+                   read_unlock(&in_dev->lock);
+              } else
+                   onlink = 1;
+
+              if (onlink)
+                   arp_send(ARPOP_REPLY,ETH_P_ARP,tip,dev,tip,sha,dev->dev_addr,dev->dev_addr);
+         }
          goto out;
     }

@@ -739,7 +780,22 @@
          if (addr_type == RTN_LOCAL) {
               n = neigh_event_ns(&arp_tbl, sha, &sip, dev);
               if (n) {
-                   arp_send(ARPOP_REPLY,ETH_P_ARP,sip,dev,tip,sha,dev->dev_addr,sha);
+                   /* if strict_interface_arp then bind arp response to the interface. */
+                   /* reply only if tip is on dev where arp request is received - 2/5/2001 pflau */
+                   onlink = 0;
+                   if (IN_DEV_STRICT_INTF_ARP(in_dev)) {
+                        read_lock(&in_dev->lock);
+                        for_ifa(in_dev) {
+                             if ((onlink = !(tip ^ ifa->ifa_local)) != 0)
+                                  break;
+                        } endfor_ifa(in_dev);
+                        read_unlock(&in_dev->lock);
+                   } else
+                        onlink = 1;
+
+                   if (onlink) {
+                        arp_send(ARPOP_REPLY,ETH_P_ARP,sip,dev,tip,sha,dev->dev_addr,sha);
+                   }
                    neigh_release(n);
               }
               goto out;
diff -Naur linux-2.4.2-2/net/ipv4/devinet.c linux-2.4.2-2-strict_interface_arp/net/ipv4/devinet.c
--- linux-2.4.2-2/net/ipv4/devinet.c     Sat Sep  8 22:08:40 2001
+++ linux-2.4.2-2-strict_interface_arp/net/ipv4/devinet.c    Mon Sep 10 12:33:30 2001
@@ -737,6 +737,7 @@
          read_lock(&in_dev->lock);
          for_primary_ifa(in_dev) {
               if (ifa->ifa_scope != RT_SCOPE_LINK &&
+                  !IN_DEV_STRICT_INTF_ARP(in_dev) &&
                   ifa->ifa_scope <= scope) {
                    read_unlock(&in_dev->lock);
                    read_unlock(&inetdev_lock);
@@ -1016,7 +1017,7 @@
 static struct devinet_sysctl_table
 {
     struct ctl_table_header *sysctl_header;
-    ctl_table devinet_vars[13];
+    ctl_table devinet_vars[14];
     ctl_table devinet_dev[2];
     ctl_table devinet_conf_dir[2];
     ctl_table devinet_proto_dir[2];
@@ -1058,6 +1059,9 @@
          &proc_dointvec},
     {NET_IPV4_CONF_TAG, "tag",
      &ipv4_devconf.tag, sizeof(int), 0644, NULL,
+     &proc_dointvec},
+    {NET_IPV4_CONF_TAG, "strict_interface_arp",
+     &ipv4_devconf.strict_interface_arp, sizeof(int), 0644, NULL,
      &proc_dointvec},
      {0}},


