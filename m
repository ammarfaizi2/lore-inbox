Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261491AbSJ1VA7>; Mon, 28 Oct 2002 16:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261492AbSJ1VA7>; Mon, 28 Oct 2002 16:00:59 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:10130 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261491AbSJ1VAh>; Mon, 28 Oct 2002 16:00:37 -0500
From: "David Stevens" <dlstevens@us.ibm.com>
Importance: Normal
Sensitivity: 
To: kuznet@ms2.inr.ac.ru, davem@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OFC909BFEE.F581E26E-ON88256C60.0072A662@boulder.ibm.com>
Date: Mon, 28 Oct 2002 14:06:00 -0700
Subject: [PATCH] anycast support for IPv6, updated to 2.5.44 
X-MIMETrack: Serialize by Router on D03NM035/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 10/28/2002 02:06:02 PM
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=07BBE6F3DFE120F28f9e8a93df938690918c07BBE6F3DFE120F2"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=07BBE6F3DFE120F28f9e8a93df938690918c07BBE6F3DFE120F2
Content-type: text/plain; charset=us-ascii


Below is a patch to add anycast support for IPv6. It's the same patch as
I've posted previously, but updated with comments from Chris Hellwig and
for kernel version 2.5.44.
      My mailer mangles tabs, so I'm including it in-line (for easy
viewing) and as an attachment at the end (for applying to kernels). A
fuller description is available at:
http://marc.theaimsgroup.com/?l=linux-net&m=103057141321548&w=2
      Currently, IPv6 mobile code is the only user of anycasting, but there
won't be users if it isn't supported. Please consider for inclusion in 2.5.

                                    +-DLS

diff -ruN linux-2.5.44/include/linux/in6.h linux-2.5.44AC/include/linux/in6.h
--- linux-2.5.44/include/linux/in6.h      Fri Oct 18 21:01:59 2002
+++ linux-2.5.44AC/include/linux/in6.h    Mon Oct 28 12:38:09 2002
@@ -56,6 +56,8 @@
      int         ipv6mr_ifindex;
 };

+#define ipv6mr_acaddr  ipv6mr_multiaddr
+
 struct in6_flowlabel_req
 {
      struct in6_addr   flr_dst;
@@ -156,6 +158,9 @@
 #define IPV6_MTU_DISCOVER    23
 #define IPV6_MTU       24
 #define IPV6_RECVERR         25
+/* 26 is IPV6_V6ONLY in USAGI code */
+#define IPV6_JOIN_ANYCAST    27
+#define IPV6_LEAVE_ANYCAST   28

 /* IPV6_MTU_DISCOVER values */
 #define IPV6_PMTUDISC_DONT         0
diff -ruN linux-2.5.44/include/linux/ipv6.h linux-2.5.44AC/include/linux/ipv6.h
--- linux-2.5.44/include/linux/ipv6.h     Fri Oct 18 21:02:26 2002
+++ linux-2.5.44AC/include/linux/ipv6.h   Mon Oct 28 12:38:09 2002
@@ -155,6 +155,7 @@
                              pmtudisc:2;

      struct ipv6_mc_socklist *ipv6_mc_list;
+     struct ipv6_ac_socklist *ipv6_ac_list;
      struct ipv6_fl_socklist *ipv6_fl_list;
      __u32             dst_cookie;

diff -ruN linux-2.5.44/include/linux/netdevice.h linux-2.5.44AC/include/linux/netdevice.h
--- linux-2.5.44/include/linux/netdevice.h      Fri Oct 18 21:02:31 2002
+++ linux-2.5.44AC/include/linux/netdevice.h    Mon Oct 28 12:38:09 2002
@@ -464,6 +464,10 @@
 extern void            dev_add_pack(struct packet_type *pt);
 extern void            dev_remove_pack(struct packet_type *pt);
 extern int       dev_get(const char *name);
+extern struct net_device     *dev_getany(unsigned short flags,
+                             unsigned short mask);
+extern struct net_device     *__dev_getany(unsigned short flags,
+                             unsigned short mask);
 extern struct net_device     *dev_get_by_name(const char *name);
 extern struct net_device     *__dev_get_by_name(const char *name);
 extern struct net_device     *dev_alloc(const char *name, int *err);
diff -ruN linux-2.5.44/include/net/addrconf.h linux-2.5.44AC/include/net/addrconf.h
--- linux-2.5.44/include/net/addrconf.h   Fri Oct 18 21:01:18 2002
+++ linux-2.5.44AC/include/net/addrconf.h Mon Oct 28 12:38:09 2002
@@ -58,7 +58,15 @@
 extern int             ipv6_get_saddr(struct dst_entry *dst,
                                     struct in6_addr *daddr,
                                     struct in6_addr *saddr);
+extern int             ipv6_dev_get_saddr(struct net_device *dev,
+                                    struct in6_addr *daddr,
+                                    struct in6_addr *saddr,
+                                    int onlink);
 extern int             ipv6_get_lladdr(struct net_device *dev, struct in6_addr *);
+extern void                  addrconf_join_solict(struct net_device *dev,
+                             struct in6_addr *addr);
+extern void                  addrconf_leave_solict(struct net_device *dev,
+                             struct in6_addr *addr);

 /*
  *   multicast prototypes (mcast.c)
@@ -88,6 +96,26 @@
 extern void                  addrconf_prefix_rcv(struct net_device *dev,
                                        u8 *opt, int len);

+/*
+ *   anycast prototypes (anycast.c)
+ */
+extern int             ipv6_sock_ac_join(struct sock *sk,
+                                     int ifindex,
+                                     struct in6_addr *addr);
+extern int             ipv6_sock_ac_drop(struct sock *sk,
+                                     int ifindex,
+                                     struct in6_addr *addr);
+extern void                  ipv6_sock_ac_close(struct sock *sk);
+extern int             inet6_ac_check(struct sock *sk, struct in6_addr *addr, int ifindex);
+
+extern int             ipv6_dev_ac_inc(struct net_device *dev,
+                                   struct in6_addr *addr);
+extern int             ipv6_dev_ac_dec(struct net_device *dev,
+                                   struct in6_addr *addr);
+extern int             ipv6_chk_acast_addr(struct net_device *dev,
+                                   struct in6_addr *addr);
+
+
 /* Device notifier */
 extern int register_inet6addr_notifier(struct notifier_block *nb);
 extern int unregister_inet6addr_notifier(struct notifier_block *nb);
diff -ruN linux-2.5.44/include/net/if_inet6.h linux-2.5.44AC/include/net/if_inet6.h
--- linux-2.5.44/include/net/if_inet6.h   Fri Oct 18 21:02:34 2002
+++ linux-2.5.44AC/include/net/if_inet6.h Mon Oct 28 12:38:09 2002
@@ -69,6 +69,25 @@
      spinlock_t        mca_lock;
 };

+/* Anycast stuff */
+
+struct ipv6_ac_socklist
+{
+     struct in6_addr         acl_addr;
+     int               acl_ifindex;
+     struct ipv6_ac_socklist *acl_next;
+};
+
+struct ifacaddr6
+{
+     struct in6_addr         aca_addr;
+     struct inet6_dev  *aca_idev;
+     struct ifacaddr6  *aca_next;
+     int               aca_users;
+     atomic_t          aca_refcnt;
+     spinlock_t        aca_lock;
+};
+
 #define    IFA_HOST    IPV6_ADDR_LOOPBACK
 #define    IFA_LINK    IPV6_ADDR_LINKLOCAL
 #define    IFA_SITE    IPV6_ADDR_SITELOCAL
@@ -96,6 +115,7 @@

      struct inet6_ifaddr     *addr_list;
      struct ifmcaddr6  *mc_list;
+     struct ifacaddr6  *ac_list;
      rwlock_t          lock;
      atomic_t          refcnt;
      __u32             if_flags;
diff -ruN linux-2.5.44/net/core/dev.c linux-2.5.44AC/net/core/dev.c
--- linux-2.5.44/net/core/dev.c     Fri Oct 18 21:01:54 2002
+++ linux-2.5.44AC/net/core/dev.c   Mon Oct 28 12:38:09 2002
@@ -541,6 +541,50 @@
 }

 /**
+ *   dev_getany - find any device with given flags
+ *   @if_flags: IFF_* values
+ *   @mask: bitmask of bits in if_flags to check
+ *
+ *   Search for any interface with the given flags. Returns NULL if a device
+ *   is not found or a pointer to the device. The device returned has
+ *   had a reference added and the pointer is safe until the user calls
+ *   dev_put to indicate they have finished with it.
+ */
+
+struct net_device * dev_getany(unsigned short if_flags, unsigned short mask)
+{
+     struct net_device *dev;
+
+     read_lock(&dev_base_lock);
+     dev = __dev_getany(if_flags, mask);
+     if (dev)
+           dev_hold(dev);
+     read_unlock(&dev_base_lock);
+     return dev;
+}
+
+/**
+ *   __dev_getany - find any device with given flags
+ *   @if_flags: IFF_* values
+ *   @mask: bitmask of bits in if_flags to check
+ *
+ *   Search for any interface with the given flags. Returns NULL if a device
+ *   is not found or a pointer to the device. The caller must hold either
+ *   the RTNL semaphore or @dev_base_lock.
+ */
+
+struct net_device *__dev_getany(unsigned short if_flags, unsigned short mask)
+{
+     struct net_device *dev;
+
+     for (dev = dev_base; dev != NULL; dev = dev->next) {
+           if (((dev->flags ^ if_flags) & mask) == 0)
+                 return dev;
+     }
+     return NULL;
+}
+
+/**
  *   dev_alloc_name - allocate a name for a device
  *   @dev: device
  *   @name: name format string
diff -ruN linux-2.5.44/net/ipv6/Makefile linux-2.5.44AC/net/ipv6/Makefile
--- linux-2.5.44/net/ipv6/Makefile  Fri Oct 18 21:02:27 2002
+++ linux-2.5.44AC/net/ipv6/Makefile      Mon Oct 28 12:38:09 2002
@@ -6,7 +6,7 @@

 obj-$(CONFIG_IPV6) += ipv6.o

-ipv6-objs :=     af_inet6.o ip6_output.o ip6_input.o addrconf.o sit.o \
+ipv6-objs :=     af_inet6.o anycast.o ip6_output.o ip6_input.o addrconf.o sit.o \
            route.o ip6_fib.o ipv6_sockglue.o ndisc.o udp.o raw.o \
            protocol.o icmp.o mcast.o reassembly.o tcp_ipv6.o \
            exthdrs.o sysctl_net_ipv6.o datagram.o proc.o \
diff -ruN linux-2.5.44/net/ipv6/addrconf.c linux-2.5.44AC/net/ipv6/addrconf.c
--- linux-2.5.44/net/ipv6/addrconf.c      Fri Oct 18 21:02:31 2002
+++ linux-2.5.44AC/net/ipv6/addrconf.c    Mon Oct 28 12:49:03 2002
@@ -137,21 +137,15 @@

 int ipv6_addr_type(struct in6_addr *addr)
 {
+     int type;
      u32 st;

      st = addr->s6_addr32[0];

-     /* Consider all addresses with the first three bits different of
-        000 and 111 as unicasts.
-      */
-     if ((st & htonl(0xE0000000)) != htonl(0x00000000) &&
-         (st & htonl(0xE0000000)) != htonl(0xE0000000))
-           return IPV6_ADDR_UNICAST;
-
-     if ((st & htonl(0xFF000000)) == htonl(0xFF000000)) {
-           int type = IPV6_ADDR_MULTICAST;
+     if ((st & __constant_htonl(0xFF000000)) == __constant_htonl(0xFF000000)) {
+           type = IPV6_ADDR_MULTICAST;

-           switch((st & htonl(0x00FF0000))) {
+           switch((st & __constant_htonl(0x00FF0000))) {
                  case __constant_htonl(0x00010000):
                        type |= IPV6_ADDR_LOOPBACK;
                        break;
@@ -166,29 +160,53 @@
            };
            return type;
      }
+     /* check for reserved anycast addresses */
+
+     if ((st & __constant_htonl(0xE0000000)) &&
+         ((addr->s6_addr32[2] == __constant_htonl(0xFDFFFFFF) &&
+         (addr->s6_addr32[3] | __constant_htonl(0x7F)) == (u32)~0) ||
+         (addr->s6_addr32[2] == 0 && addr->s6_addr32[3] == 0)))
+           type = IPV6_ADDR_ANYCAST;
+     else
+           type = IPV6_ADDR_UNICAST;
+
+     /* Consider all addresses with the first three bits different of
+        000 and 111 as finished.
+      */
+     if ((st & __constant_htonl(0xE0000000)) != __constant_htonl(0x00000000) &&
+         (st & __constant_htonl(0xE0000000)) != __constant_htonl(0xE0000000))
+           return type;

-     if ((st & htonl(0xFFC00000)) == htonl(0xFE800000))
-           return (IPV6_ADDR_LINKLOCAL | IPV6_ADDR_UNICAST);
+     if ((st & __constant_htonl(0xFFC00000)) == __constant_htonl(0xFE800000))
+           return (IPV6_ADDR_LINKLOCAL | type);

-     if ((st & htonl(0xFFC00000)) == htonl(0xFEC00000))
-           return (IPV6_ADDR_SITELOCAL | IPV6_ADDR_UNICAST);
+     if ((st & __constant_htonl(0xFFC00000)) == __constant_htonl(0xFEC00000))
+           return (IPV6_ADDR_SITELOCAL | type);

      if ((addr->s6_addr32[0] | addr->s6_addr32[1]) == 0) {
            if (addr->s6_addr32[2] == 0) {
-                 if (addr->s6_addr32[3] == 0)
+                 if (addr->in6_u.u6_addr32[3] == 0)
                        return IPV6_ADDR_ANY;

-                 if (addr->s6_addr32[3] == htonl(0x00000001))
-                       return (IPV6_ADDR_LOOPBACK | IPV6_ADDR_UNICAST);
+                 if (addr->s6_addr32[3] == __constant_htonl(0x00000001))
+                       return (IPV6_ADDR_LOOPBACK | type);

-                 return (IPV6_ADDR_COMPATv4 | IPV6_ADDR_UNICAST);
+                 return (IPV6_ADDR_COMPATv4 | type);
            }

-           if (addr->s6_addr32[2] == htonl(0x0000ffff))
+           if (addr->s6_addr32[2] == __constant_htonl(0x0000ffff))
                  return IPV6_ADDR_MAPPED;
      }

-     return IPV6_ADDR_RESERVED;
+     st &= __constant_htonl(0xFF000000);
+     if (st == 0)
+           return IPV6_ADDR_RESERVED;
+     st &= __constant_htonl(0xFE000000);
+     if (st == __constant_htonl(0x02000000))
+           return IPV6_ADDR_RESERVED;    /* for NSAP */
+     if (st == __constant_htonl(0x04000000))
+           return IPV6_ADDR_RESERVED;    /* for IPX */
+     return type;
 }

 static void addrconf_del_timer(struct inet6_ifaddr *ifp)
@@ -224,7 +242,6 @@
      add_timer(&ifp->timer);
 }

-
 /* Nobody refers to this device, we may destroy it. */

 void in6_dev_finish_destroy(struct inet6_dev *idev)
@@ -303,24 +320,91 @@
      return idev;
 }

+void ipv6_addr_prefix(struct in6_addr *prefix,
+     struct in6_addr *addr, int prefix_len)
+{
+     unsigned long mask;
+     int ncopy, nbits;
+
+     memset(prefix, 0, sizeof(*prefix));
+
+     if (prefix_len <= 0)
+           return;
+     if (prefix_len > 128)
+           prefix_len = 128;
+
+     ncopy = prefix_len / 32;
+     switch (ncopy) {
+     case 4:     prefix->s6_addr32[3] = addr->s6_addr32[3];
+     case 3:     prefix->s6_addr32[2] = addr->s6_addr32[2];
+     case 2:     prefix->s6_addr32[1] = addr->s6_addr32[1];
+     case 1:     prefix->s6_addr32[0] = addr->s6_addr32[0];
+     case 0:     break;
+     }
+     nbits = prefix_len % 32;
+     if (nbits == 0)
+           return;
+
+     mask = ~((1 << (32 - nbits)) - 1);
+     mask = htonl(mask);
+
+     prefix->s6_addr32[ncopy] = addr->s6_addr32[ncopy] & mask;
+}
+
+
+static void dev_forward_change(struct inet6_dev *idev)
+{
+     struct net_device *dev;
+     struct inet6_ifaddr *ifa;
+     struct in6_addr addr;
+
+     if (!idev)
+           return;
+     dev = idev->dev;
+     if (dev && (dev->flags & IFF_MULTICAST)) {
+           ipv6_addr_all_routers(&addr);
+
+           if (idev->cnf.forwarding)
+                 ipv6_dev_mc_inc(dev, &addr);
+           else
+                 ipv6_dev_mc_dec(dev, &addr);
+     }
+     for (ifa=idev->addr_list; ifa; ifa=ifa->if_next) {
+           ipv6_addr_prefix(&addr, &ifa->addr, ifa->prefix_len);
+           if (addr.s6_addr32[0] == 0 && addr.s6_addr32[1] == 0 &&
+               addr.s6_addr32[2] == 0 && addr.s6_addr32[3] == 0)
+                 continue;
+           if (idev->cnf.forwarding)
+                 ipv6_dev_ac_inc(idev->dev, &addr);
+           else
+                 ipv6_dev_ac_dec(idev->dev, &addr);
+     }
+}
+
+
 static void addrconf_forward_change(struct inet6_dev *idev)
 {
      struct net_device *dev;

-     if (idev)
+     if (idev) {
+           dev_forward_change(idev);
            return;
+     }

      read_lock(&dev_base_lock);
      for (dev=dev_base; dev; dev=dev->next) {
            read_lock(&addrconf_lock);
            idev = __in6_dev_get(dev);
-           if (idev)
+           if (idev) {
                  idev->cnf.forwarding = ipv6_devconf.forwarding;
+                 dev_forward_change(idev);
+           }
            read_unlock(&addrconf_lock);
      }
      read_unlock(&dev_base_lock);
 }

+
 /* Nobody refers to this ifaddr, destroy it */

 void inet6_ifa_finish_destroy(struct inet6_ifaddr *ifp)
@@ -458,29 +542,20 @@
  *         an address of the attached interface
  *   iii)  don't use deprecated addresses
  */
-int ipv6_get_saddr(struct dst_entry *dst,
-              struct in6_addr *daddr, struct in6_addr *saddr)
+int ipv6_dev_get_saddr(struct net_device *dev,
+              struct in6_addr *daddr, struct in6_addr *saddr, int onlink)
 {
-     int scope;
      struct inet6_ifaddr *ifp = NULL;
      struct inet6_ifaddr *match = NULL;
-     struct net_device *dev = NULL;
      struct inet6_dev *idev;
-     struct rt6_info *rt;
+     int scope;
      int err;

-     rt = (struct rt6_info *) dst;
-     if (rt)
-           dev = rt->rt6i_dev;

-     scope = ipv6_addr_scope(daddr);
-     if (rt && (rt->rt6i_flags & RTF_ALLONLINK)) {
-           /*
-            *    route for the "all destinations on link" rule
-            *    when no routers are present
-            */
+     if (!onlink)
+           scope = ipv6_addr_scope(daddr);
+     else
            scope = IFA_LINK;
-     }

      /*
       *    known dev
@@ -568,6 +643,24 @@
      return err;
 }

+
+int ipv6_get_saddr(struct dst_entry *dst,
+              struct in6_addr *daddr, struct in6_addr *saddr)
+{
+     struct rt6_info *rt;
+     struct net_device *dev = NULL;
+     int onlink;
+
+     rt = (struct rt6_info *) dst;
+     if (rt)
+           dev = rt->rt6i_dev;
+
+     onlink = (rt && (rt->rt6i_flags & RTF_ALLONLINK));
+
+     return ipv6_dev_get_saddr(dev, daddr, saddr, onlink);
+}
+
+
 int ipv6_get_lladdr(struct net_device *dev, struct in6_addr *addr)
 {
      struct inet6_dev *idev;
@@ -660,7 +753,7 @@

 /* Join to solicited addr multicast group. */

-static void addrconf_join_solict(struct net_device *dev, struct in6_addr *addr)
+void addrconf_join_solict(struct net_device *dev, struct in6_addr *addr)
 {
      struct in6_addr maddr;

@@ -671,7 +764,7 @@
      ipv6_dev_mc_inc(dev, &maddr);
 }

-static void addrconf_leave_solict(struct net_device *dev, struct in6_addr *addr)
+void addrconf_leave_solict(struct net_device *dev, struct in6_addr *addr)
 {
      struct in6_addr maddr;

@@ -1554,6 +1647,15 @@
            addrconf_mod_timer(ifp, AC_RS, ifp->idev->cnf.rtr_solicit_interval);
            spin_unlock_bh(&ifp->lock);
      }
+
+     if (ifp->idev->cnf.forwarding) {
+           struct in6_addr addr;
+
+           ipv6_addr_prefix(&addr, &ifp->addr, ifp->prefix_len);
+           if (addr.s6_addr32[0] || addr.s6_addr32[1] ||
+               addr.s6_addr32[2] || addr.s6_addr32[3])
+                 ipv6_dev_ac_inc(ifp->idev->dev, &addr);
+     }
 }

 #ifdef CONFIG_PROC_FS
@@ -1853,6 +1955,14 @@
            break;
      case RTM_DELADDR:
            addrconf_leave_solict(ifp->idev->dev, &ifp->addr);
+           if (ifp->idev->cnf.forwarding) {
+                 struct in6_addr addr;
+
+                 ipv6_addr_prefix(&addr, &ifp->addr, ifp->prefix_len);
+                 if (addr.s6_addr32[0] || addr.s6_addr32[1] ||
+                     addr.s6_addr32[2] || addr.s6_addr32[3])
+                       ipv6_dev_ac_dec(ifp->idev->dev, &addr);
+           }
            if (!ipv6_chk_addr(&ifp->addr, NULL))
                  ip6_rt_addr_del(&ifp->addr, ifp->idev->dev);
            break;
@@ -1875,11 +1985,7 @@
            struct inet6_dev *idev = NULL;

            if (valp != &ipv6_devconf.forwarding) {
-                 struct net_device *dev = dev_get_by_index(ctl->ctl_name);
-                 if (dev) {
-                       idev = in6_dev_get(dev);
-                       dev_put(dev);
-                 }
+                 idev = (struct inet6_dev *)ctl->extra1;
                  if (idev == NULL)
                        return ret;
            } else
@@ -1889,8 +1995,6 @@

            if (*valp)
                  rt6_purge_dflt_routers(0);
-           if (idev)
-                 in6_dev_put(idev);
      }

         return ret;
@@ -1967,6 +2071,7 @@
      for (i=0; i<sizeof(t->addrconf_vars)/sizeof(t->addrconf_vars[0])-1; i++) {
            t->addrconf_vars[i].data += (char*)p - (char*)&ipv6_devconf;
            t->addrconf_vars[i].de = NULL;
+           t->addrconf_vars[i].extra1 = idev; /* embedded; no ref */
      }
      if (dev) {
            t->addrconf_dev[0].procname = dev->name;
diff -ruN linux-2.5.44/net/ipv6/af_inet6.c linux-2.5.44AC/net/ipv6/af_inet6.c
--- linux-2.5.44/net/ipv6/af_inet6.c      Fri Oct 18 21:01:57 2002
+++ linux-2.5.44AC/net/ipv6/af_inet6.c    Mon Oct 28 12:38:09 2002
@@ -76,6 +76,7 @@
 /* IPv6 procfs goodies... */

 #ifdef CONFIG_PROC_FS
+extern int anycast6_get_info(char *, char **, off_t, int);
 extern int raw6_get_info(char *, char **, off_t, int);
 extern int tcp6_get_info(char *, char **, off_t, int);
 extern int udp6_get_info(char *, char **, off_t, int);
@@ -380,6 +381,9 @@
      /* Free mc lists */
      ipv6_sock_mc_close(sk);

+     /* Free ac lists */
+     ipv6_sock_ac_close(sk);
+
      return inet_release(sock);
 }

@@ -694,6 +698,8 @@
            goto proc_sockstat6_fail;
      if (!proc_net_create("snmp6", 0, afinet6_get_snmp))
            goto proc_snmp6_fail;
+     if (!proc_net_create("anycast6", 0, anycast6_get_info))
+           goto proc_anycast6_fail;
 #endif
      ipv6_netdev_notif_init();
      ipv6_packet_init();
@@ -709,6 +715,8 @@
      return 0;

 #ifdef CONFIG_PROC_FS
+proc_anycast6_fail:
+     proc_net_remove("anycast6");
 proc_snmp6_fail:
      proc_net_remove("sockstat6");
 proc_sockstat6_fail:
@@ -744,6 +752,7 @@
      proc_net_remove("udp6");
      proc_net_remove("sockstat6");
      proc_net_remove("snmp6");
+     proc_net_remove("anycast6");
 #endif
      /* Cleanup code parts. */
      sit_cleanup();
diff -ruN linux-2.5.44/net/ipv6/anycast.c linux-2.5.44AC/net/ipv6/anycast.c
--- linux-2.5.44/net/ipv6/anycast.c Wed Dec 31 16:00:00 1969
+++ linux-2.5.44AC/net/ipv6/anycast.c     Mon Oct 28 13:28:07 2002
@@ -0,0 +1,489 @@
+/*
+ *   Anycast support for IPv6
+ *   Linux INET6 implementation
+ *
+ *   Authors:
+ *   David L Stevens (dlstevens@us.ibm.com)
+ *
+ *   based heavily on net/ipv6/mcast.c
+ *
+ *   This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/random.h>
+#include <linux/string.h>
+#include <linux/socket.h>
+#include <linux/sockios.h>
+#include <linux/sched.h>
+#include <linux/net.h>
+#include <linux/in6.h>
+#include <linux/netdevice.h>
+#include <linux/if_arp.h>
+#include <linux/route.h>
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+
+#include <net/sock.h>
+#include <net/snmp.h>
+
+#include <net/ipv6.h>
+#include <net/protocol.h>
+#include <net/if_inet6.h>
+#include <net/ndisc.h>
+#include <net/addrconf.h>
+#include <net/ip6_route.h>
+
+#include <net/checksum.h>
+
+/* Big ac list lock for all the sockets */
+static rwlock_t ipv6_sk_ac_lock = RW_LOCK_UNLOCKED;
+
+/* XXX ip6_addr_match() and ip6_onlink() really belong in net/core.c */
+
+static int
+ip6_addr_match(struct in6_addr *addr1, struct in6_addr *addr2, int prefix)
+{
+     __u32 mask;
+     int   i;
+
+     if (prefix > 128 || prefix < 0)
+           return 0;
+     if (prefix == 0)
+           return 1;
+     for (i=0; i<4; ++i) {
+           if (prefix >= 32)
+                 mask = ~0;
+           else
+                 mask = htonl(~0 << (32 - prefix));
+           if ((addr1->s6_addr32[i] ^ addr2->s6_addr32[i]) & mask)
+                 return 0;
+           prefix -= 32;
+           if (prefix <= 0)
+                 break;
+     }
+     return 1;
+}
+
+static int
+ip6_onlink(struct in6_addr *addr, struct net_device *dev)
+{
+     struct inet6_dev  *idev;
+     struct inet6_ifaddr     *ifa;
+     int   onlink;
+
+     onlink = 0;
+     read_lock(&addrconf_lock);
+     idev = __in6_dev_get(dev);
+     if (idev) {
+           read_lock_bh(&idev->lock);
+           for (ifa=idev->addr_list; ifa; ifa=ifa->if_next) {
+                 onlink = ip6_addr_match(addr, &ifa->addr,
+                             ifa->prefix_len);
+                 if (onlink)
+                       break;
+           }
+           read_unlock_bh(&idev->lock);
+     }
+     read_unlock(&addrconf_lock);
+     return onlink;
+}
+
+
+/*
+ *   socket join an anycast group
+ */
+
+int ipv6_sock_ac_join(struct sock *sk, int ifindex, struct in6_addr *addr)
+{
+     struct ipv6_pinfo *np = inet6_sk(sk);
+     struct net_device *dev = NULL;
+     struct inet6_dev *idev;
+     struct ipv6_ac_socklist *pac;
+     int   ishost = !ipv6_devconf.forwarding;
+     int   err = 0;
+
+     if (ipv6_addr_type(addr) & IPV6_ADDR_MULTICAST)
+           return -EINVAL;
+
+     pac = sock_kmalloc(sk, sizeof(struct ipv6_ac_socklist), GFP_KERNEL);
+     if (pac == NULL)
+           return -ENOMEM;
+     pac->acl_next = NULL;
+     ipv6_addr_copy(&pac->acl_addr, addr);
+
+     if (ifindex == 0) {
+           struct rt6_info *rt;
+
+           rt = rt6_lookup(addr, NULL, 0, 0);
+           if (rt) {
+                 dev = rt->rt6i_dev;
+                 dev_hold(dev);
+                 dst_release(&rt->u.dst);
+           } else if (ishost) {
+                 sock_kfree_s(sk, pac, sizeof(*pac));
+                 return -EADDRNOTAVAIL;
+           } else {
+                 /* router, no matching interface: just pick one */
+
+                 dev = dev_getany(IFF_UP, IFF_UP|IFF_LOOPBACK);
+           }
+     } else
+           dev = dev_get_by_index(ifindex);
+
+     if (dev == NULL) {
+           sock_kfree_s(sk, pac, sizeof(*pac));
+           return -ENODEV;
+     }
+
+     idev = in6_dev_get(dev);
+     if (!idev) {
+           sock_kfree_s(sk, pac, sizeof(*pac));
+           dev_put(dev);
+           if (ifindex)
+                 return -ENODEV;
+           else
+                 return -EADDRNOTAVAIL;
+     }
+     /* reset ishost, now that we have a specific device */
+     ishost = !idev->cnf.forwarding;
+     in6_dev_put(idev);
+
+     pac->acl_ifindex = dev->ifindex;
+
+     /* XXX
+      * For hosts, allow link-local or matching prefix anycasts.
+      * This obviates the need for propagating anycast routes while
+      * still allowing some non-router anycast participation.
+      *
+      * allow anyone to join anycasts that don't require a special route
+      * and can't be spoofs of unicast addresses (reserved anycast only)
+      */
+     if (!ip6_onlink(addr, dev)) {
+           if (ishost)
+                 err = -EADDRNOTAVAIL;
+           else if (!capable(CAP_NET_ADMIN))
+                 err = -EPERM;
+           if (err) {
+                 sock_kfree_s(sk, pac, sizeof(*pac));
+                 dev_put(dev);
+                 return err;
+           }
+     } else if (!(ipv6_addr_type(addr) & IPV6_ADDR_ANYCAST) &&
+              !capable(CAP_NET_ADMIN))
+           return -EPERM;
+
+     err = ipv6_dev_ac_inc(dev, addr);
+     if (err) {
+           sock_kfree_s(sk, pac, sizeof(*pac));
+           dev_put(dev);
+           return err;
+     }
+
+     write_lock_bh(&ipv6_sk_ac_lock);
+     pac->acl_next = np->ipv6_ac_list;
+     np->ipv6_ac_list = pac;
+     write_unlock_bh(&ipv6_sk_ac_lock);
+
+     dev_put(dev);
+
+     return 0;
+}
+
+/*
+ *   socket leave an anycast group
+ */
+int ipv6_sock_ac_drop(struct sock *sk, int ifindex, struct in6_addr *addr)
+{
+     struct ipv6_pinfo *np = inet6_sk(sk);
+     struct net_device *dev;
+     struct ipv6_ac_socklist *pac, *prev_pac;
+
+     write_lock_bh(&ipv6_sk_ac_lock);
+     prev_pac = 0;
+     for (pac = np->ipv6_ac_list; pac; pac = pac->acl_next) {
+           if ((ifindex == 0 || pac->acl_ifindex == ifindex) &&
+                ipv6_addr_cmp(&pac->acl_addr, addr) == 0)
+                 break;
+           prev_pac = pac;
+     }
+     if (!pac) {
+           write_unlock_bh(&ipv6_sk_ac_lock);
+           return -ENOENT;
+     }
+     if (prev_pac)
+           prev_pac->acl_next = pac->acl_next;
+     else
+           np->ipv6_ac_list = pac->acl_next;
+
+     write_unlock_bh(&ipv6_sk_ac_lock);
+
+     dev = dev_get_by_index(pac->acl_ifindex);
+     if (dev) {
+           ipv6_dev_ac_dec(dev, &pac->acl_addr);
+           dev_put(dev);
+     }
+     sock_kfree_s(sk, pac, sizeof(*pac));
+     return 0;
+}
+
+void ipv6_sock_ac_close(struct sock *sk)
+{
+     struct ipv6_pinfo *np = inet6_sk(sk);
+     struct net_device *dev = 0;
+     struct ipv6_ac_socklist *pac;
+     int   prev_index;
+
+     write_lock_bh(&ipv6_sk_ac_lock);
+     pac = np->ipv6_ac_list;
+     np->ipv6_ac_list = 0;
+     write_unlock_bh(&ipv6_sk_ac_lock);
+
+     prev_index = 0;
+     while (pac) {
+           struct ipv6_ac_socklist *next = pac->acl_next;
+
+           if (pac->acl_ifindex != prev_index) {
+                 if (dev)
+                       dev_put(dev);
+                 dev = dev_get_by_index(pac->acl_ifindex);
+                 prev_index = pac->acl_ifindex;
+           }
+           if (dev)
+                 ipv6_dev_ac_dec(dev, &pac->acl_addr);
+           sock_kfree_s(sk, pac, sizeof(*pac));
+           pac = next;
+     }
+     if (dev)
+           dev_put(dev);
+}
+
+int inet6_ac_check(struct sock *sk, struct in6_addr *addr, int ifindex)
+{
+     struct ipv6_ac_socklist *pac;
+     struct ipv6_pinfo *np = inet6_sk(sk);
+     int   found;
+
+     found = 0;
+     read_lock(&ipv6_sk_ac_lock);
+     for (pac=np->ipv6_ac_list; pac; pac=pac->acl_next) {
+           if (ifindex && pac->acl_ifindex != ifindex)
+                 continue;
+           found = ipv6_addr_cmp(&pac->acl_addr, addr) == 0;
+           if (found)
+                 break;
+     }
+     read_unlock(&ipv6_sk_ac_lock);
+
+     return found;
+}
+
+static void aca_put(struct ifacaddr6 *ac)
+{
+     if (atomic_dec_and_test(&ac->aca_refcnt)) {
+           in6_dev_put(ac->aca_idev);
+           kfree(ac);
+     }
+}
+
+/*
+ *   device anycast group inc (add if not found)
+ */
+int ipv6_dev_ac_inc(struct net_device *dev, struct in6_addr *addr)
+{
+     struct ifacaddr6 *aca;
+     struct inet6_dev *idev;
+
+     idev = in6_dev_get(dev);
+
+     if (idev == NULL)
+           return -EINVAL;
+
+     write_lock_bh(&idev->lock);
+     if (idev->dead) {
+           write_unlock_bh(&idev->lock);
+           in6_dev_put(idev);
+           return -ENODEV;
+     }
+
+     for (aca = idev->ac_list; aca; aca = aca->aca_next) {
+           if (ipv6_addr_cmp(&aca->aca_addr, addr) == 0) {
+                 aca->aca_users++;
+                 write_unlock_bh(&idev->lock);
+                 in6_dev_put(idev);
+                 return 0;
+           }
+     }
+
+     /*
+      *    not found: create a new one.
+      */
+
+     aca = kmalloc(sizeof(struct ifacaddr6), GFP_ATOMIC);
+
+     if (aca == NULL) {
+           write_unlock_bh(&idev->lock);
+           in6_dev_put(idev);
+           return -ENOMEM;
+     }
+
+     memset(aca, 0, sizeof(struct ifacaddr6));
+
+     ipv6_addr_copy(&aca->aca_addr, addr);
+     aca->aca_idev = idev;
+     aca->aca_users = 1;
+     atomic_set(&aca->aca_refcnt, 2);
+     aca->aca_lock = SPIN_LOCK_UNLOCKED;
+
+     aca->aca_next = idev->ac_list;
+     idev->ac_list = aca;
+     write_unlock_bh(&idev->lock);
+
+     ip6_rt_addr_add(&aca->aca_addr, dev);
+
+     addrconf_join_solict(dev, &aca->aca_addr);
+
+     aca_put(aca);
+     return 0;
+}
+
+/*
+ *   device anycast group decrement
+ */
+int ipv6_dev_ac_dec(struct net_device *dev, struct in6_addr *addr)
+{
+     struct inet6_dev *idev;
+     struct ifacaddr6 *aca, *prev_aca;
+
+     idev = in6_dev_get(dev);
+     if (idev == NULL)
+           return -ENODEV;
+
+     write_lock_bh(&idev->lock);
+     prev_aca = 0;
+     for (aca = idev->ac_list; aca; aca = aca->aca_next) {
+           if (ipv6_addr_cmp(&aca->aca_addr, addr) == 0)
+                 break;
+           prev_aca = aca;
+     }
+     if (!aca) {
+           write_unlock_bh(&idev->lock);
+           in6_dev_put(idev);
+           return -ENOENT;
+     }
+     if (--aca->aca_users > 0) {
+           write_unlock_bh(&idev->lock);
+           in6_dev_put(idev);
+           return 0;
+     }
+     if (prev_aca)
+           prev_aca->aca_next = aca->aca_next;
+     else
+           idev->ac_list = aca->aca_next;
+     write_unlock_bh(&idev->lock);
+     addrconf_leave_solict(dev, &aca->aca_addr);
+
+     ip6_rt_addr_del(&aca->aca_addr, dev);
+
+     aca_put(aca);
+     in6_dev_put(idev);
+     return 0;
+}
+
+/*
+ *   check if the interface has this anycast address
+ */
+static int ipv6_chk_acast_dev(struct net_device *dev, struct in6_addr *addr)
+{
+     struct inet6_dev *idev;
+     struct ifacaddr6 *aca;
+
+     idev = in6_dev_get(dev);
+     if (idev) {
+           read_lock_bh(&idev->lock);
+           for (aca = idev->ac_list; aca; aca = aca->aca_next)
+                 if (ipv6_addr_cmp(&aca->aca_addr, addr) == 0)
+                       break;
+           read_unlock_bh(&idev->lock);
+           in6_dev_put(idev);
+           return aca != 0;
+     }
+     return 0;
+}
+
+/*

+ *   check if given interface (or any, if dev==0) has this anycast address
+ */
+int ipv6_chk_acast_addr(struct net_device *dev, struct in6_addr *addr)
+{
+     if (dev)
+           return ipv6_chk_acast_dev(dev, addr);
+     read_lock(&dev_base_lock);
+     for (dev=dev_base; dev; dev=dev->next)
+           if (ipv6_chk_acast_dev(dev, addr))
+                 break;
+     read_unlock(&dev_base_lock);
+     return dev != 0;
+}
+
+
+#ifdef CONFIG_PROC_FS
+int anycast6_get_info(char *buffer, char **start, off_t offset, int length)
+{
+     off_t pos=0, begin=0;
+     struct ifacaddr6 *im;
+     int len=0;
+     struct net_device *dev;
+
+     read_lock(&dev_base_lock);
+     for (dev = dev_base; dev; dev = dev->next) {
+           struct inet6_dev *idev;
+
+           if ((idev = in6_dev_get(dev)) == NULL)
+                 continue;
+
+           read_lock_bh(&idev->lock);
+           for (im = idev->ac_list; im; im = im->aca_next) {
+                 int i;
+
+                 len += sprintf(buffer+len,"%-4d %-15s ", dev->ifindex, dev->name);
+
+                 for (i=0; i<16; i++)
+                       len += sprintf(buffer+len, "%02x", im->aca_addr.s6_addr[i]);
+
+                 len += sprintf(buffer+len, " %5d\n", im->aca_users);
+
+                 pos=begin+len;
+                 if (pos < offset) {
+                       len=0;
+                       begin=pos;
+                 }
+                 if (pos > offset+length) {
+                       read_unlock_bh(&idev->lock);
+                       in6_dev_put(idev);
+                       goto done;
+                 }
+           }
+           read_unlock_bh(&idev->lock);
+           in6_dev_put(idev);
+     }
+
+done:
+     read_unlock(&dev_base_lock);
+
+     *start=buffer+(offset-begin);
+     len-=(offset-begin);
+     if(len>length)
+           len=length;
+     if (len<0)
+           len=0;
+     return len;
+}
+
+#endif
diff -ruN linux-2.5.44/net/ipv6/icmp.c linux-2.5.44AC/net/ipv6/icmp.c
--- linux-2.5.44/net/ipv6/icmp.c    Fri Oct 18 21:01:20 2002
+++ linux-2.5.44AC/net/ipv6/icmp.c  Mon Oct 28 12:38:09 2002
@@ -388,7 +388,8 @@

      saddr = &skb->nh.ipv6h->daddr;

-     if (ipv6_addr_type(saddr) & IPV6_ADDR_MULTICAST)
+     if (ipv6_addr_type(saddr) & IPV6_ADDR_MULTICAST ||
+         ipv6_chk_acast_addr(0, saddr))
            saddr = NULL;

      msg.icmph.icmp6_type = ICMPV6_ECHO_REPLY;
diff -ruN linux-2.5.44/net/ipv6/ipv6_sockglue.c linux-2.5.44AC/net/ipv6/ipv6_sockglue.c
--- linux-2.5.44/net/ipv6/ipv6_sockglue.c Fri Oct 18 21:01:09 2002
+++ linux-2.5.44AC/net/ipv6/ipv6_sockglue.c     Mon Oct 28 12:38:09 2002
@@ -351,6 +351,24 @@
                  retv = ipv6_sock_mc_drop(sk, mreq.ipv6mr_ifindex, &mreq.ipv6mr_multiaddr);
            break;
      }
+     case IPV6_JOIN_ANYCAST:
+     case IPV6_LEAVE_ANYCAST:
+     {
+           struct ipv6_mreq mreq;
+
+           if (optlen != sizeof(struct ipv6_mreq))
+                 goto e_inval;
+
+           retv = -EFAULT;
+           if (copy_from_user(&mreq, optval, sizeof(struct ipv6_mreq)))
+                 break;
+
+           if (optname == IPV6_JOIN_ANYCAST)
+                 retv = ipv6_sock_ac_join(sk, mreq.ipv6mr_ifindex, &mreq.ipv6mr_acaddr);
+           else
+                 retv = ipv6_sock_ac_drop(sk, mreq.ipv6mr_ifindex, &mreq.ipv6mr_acaddr);
+           break;
+     }
      case IPV6_ROUTER_ALERT:
            retv = ip6_ra_control(sk, val, NULL);
            break;
diff -ruN linux-2.5.44/net/ipv6/ndisc.c linux-2.5.44AC/net/ipv6/ndisc.c
--- linux-2.5.44/net/ipv6/ndisc.c   Fri Oct 18 21:01:59 2002
+++ linux-2.5.44AC/net/ipv6/ndisc.c Mon Oct 28 13:12:27 2002
@@ -378,7 +378,10 @@
               struct in6_addr *daddr, struct in6_addr *solicited_addr,
               int router, int solicited, int override, int inc_opt)
 {
+     static struct in6_addr tmpaddr;
+     struct inet6_ifaddr *ifp;
         struct sock *sk = ndisc_socket->sk;
+     struct in6_addr *src_addr;
         struct nd_msg *msg;
         int len;
         struct sk_buff *skb;
@@ -400,13 +403,23 @@
            ND_PRINTK1("send_na: alloc skb failed\n");
            return;
      }
+     /* for anycast or proxy, solicited_addr != src_addr */
+     ifp = ipv6_get_ifaddr(solicited_addr, dev);
+     if (ifp) {
+           src_addr = solicited_addr;
+           in6_ifa_put(ifp);
+     } else {
+           if (ipv6_dev_get_saddr(dev, daddr, &tmpaddr, 0))
+                 return;
+           src_addr = &tmpaddr;
+     }

      if (ndisc_build_ll_hdr(skb, dev, daddr, neigh, len) == 0) {
            kfree_skb(skb);
            return;
      }

-     ip6_nd_hdr(sk, skb, dev, solicited_addr, daddr, IPPROTO_ICMPV6, len);
+     ip6_nd_hdr(sk, skb, dev, src_addr, daddr, IPPROTO_ICMPV6, len);

      msg = (struct nd_msg *) skb_put(skb, len);

@@ -426,7 +439,7 @@
            ndisc_fill_option(msg->opt, ND_OPT_TARGET_LL_ADDR, dev->dev_addr, dev->addr_len);

      /* checksum */
-     msg->icmph.icmp6_cksum = csum_ipv6_magic(solicited_addr, daddr, len,
+     msg->icmph.icmp6_cksum = csum_ipv6_magic(src_addr, daddr, len,
                                     IPPROTO_ICMPV6,
                                     csum_partial((__u8 *) msg,
                                                len, 0));
@@ -1133,6 +1146,51 @@
                        }
                  }
                  in6_ifa_put(ifp);
+           } else if (ipv6_chk_acast_addr(dev, &msg->target)) {
+                 struct inet6_dev *idev = in6_dev_get(dev);
+                 int addr_type = ipv6_addr_type(saddr);
+
+                 /* anycast */
+
+                 if (!idev) {
+                       /* XXX: count this drop? */
+                       return 0;
+                 }
+
+                 if (addr_type == IPV6_ADDR_ANY) {
+                       struct in6_addr maddr;
+
+                       ipv6_addr_all_nodes(&maddr);
+                       ndisc_send_na(dev, NULL, &maddr, &msg->target,
+                                   idev->cnf.forwarding, 0, 0, 1);
+                       in6_dev_put(idev);
+                       return 0;
+                 }
+
+                 if (addr_type & IPV6_ADDR_UNICAST) {
+                       int inc = ipv6_addr_type(daddr)&IPV6_ADDR_MULTICAST;
+                       if (inc)
+                             nd_tbl.stats.rcv_probes_mcast++;
+                       else
+                             nd_tbl.stats.rcv_probes_ucast++;
+
+                       /*
+                        *   update / create cache entry
+                        *   for the source adddress
+                        */
+
+                       neigh = neigh_event_ns(&nd_tbl, lladdr, saddr, skb->dev);
+
+                       if (neigh || !dev->hard_header) {
+                             ndisc_send_na(dev, neigh, saddr,
+                                   &msg->target,
+                                     idev->cnf.forwarding, 1, 0, inc);
+                             if (neigh)
+                                   neigh_release(neigh);
+                       }
+                 }
+                 in6_dev_put(idev);
+
            } else {
                  struct inet6_dev *in6_dev = in6_dev_get(dev);
                  int addr_type = ipv6_addr_type(saddr);
diff -ruN linux-2.5.44/net/netsyms.c linux-2.5.44AC/net/netsyms.c
--- linux-2.5.44/net/netsyms.c      Fri Oct 18 21:01:49 2002
+++ linux-2.5.44AC/net/netsyms.c    Mon Oct 28 12:38:09 2002
@@ -469,6 +469,8 @@
 EXPORT_SYMBOL(unregister_netdevice);
 EXPORT_SYMBOL(netdev_state_change);
 EXPORT_SYMBOL(dev_new_index);
+EXPORT_SYMBOL(dev_getany);
+EXPORT_SYMBOL(__dev_getany);
 EXPORT_SYMBOL(dev_get_by_index);
 EXPORT_SYMBOL(__dev_get_by_index);
 EXPORT_SYMBOL(dev_get_by_name);

(See attached file: anycast-2.5.44.patch)

--0__=07BBE6F3DFE120F28f9e8a93df938690918c07BBE6F3DFE120F2
Content-type: application/octet-stream; 
	name="anycast-2.5.44.patch"
Content-Disposition: attachment; filename="anycast-2.5.44.patch"
Content-transfer-encoding: base64

ZGlmZiAtcnVOIGxpbnV4LTIuNS40NC9pbmNsdWRlL2xpbnV4L2luNi5oIGxpbnV4LTIuNS40NEFD
L2luY2x1ZGUvbGludXgvaW42LmgKLS0tIGxpbnV4LTIuNS40NC9pbmNsdWRlL2xpbnV4L2luNi5o
CUZyaSBPY3QgMTggMjE6MDE6NTkgMjAwMgorKysgbGludXgtMi41LjQ0QUMvaW5jbHVkZS9saW51
eC9pbjYuaAlNb24gT2N0IDI4IDEyOjM4OjA5IDIwMDIKQEAgLTU2LDYgKzU2LDggQEAKIAlpbnQJ
CWlwdjZtcl9pZmluZGV4OwogfTsKIAorI2RlZmluZSBpcHY2bXJfYWNhZGRyCWlwdjZtcl9tdWx0
aWFkZHIKKwogc3RydWN0IGluNl9mbG93bGFiZWxfcmVxCiB7CiAJc3RydWN0IGluNl9hZGRyCWZs
cl9kc3Q7CkBAIC0xNTYsNiArMTU4LDkgQEAKICNkZWZpbmUgSVBWNl9NVFVfRElTQ09WRVIJMjMK
ICNkZWZpbmUgSVBWNl9NVFUJCTI0CiAjZGVmaW5lIElQVjZfUkVDVkVSUgkJMjUKKy8qIDI2IGlz
IElQVjZfVjZPTkxZIGluIFVTQUdJIGNvZGUgKi8KKyNkZWZpbmUgSVBWNl9KT0lOX0FOWUNBU1QJ
MjcKKyNkZWZpbmUgSVBWNl9MRUFWRV9BTllDQVNUCTI4CiAKIC8qIElQVjZfTVRVX0RJU0NPVkVS
IHZhbHVlcyAqLwogI2RlZmluZSBJUFY2X1BNVFVESVNDX0RPTlQJCTAKZGlmZiAtcnVOIGxpbnV4
LTIuNS40NC9pbmNsdWRlL2xpbnV4L2lwdjYuaCBsaW51eC0yLjUuNDRBQy9pbmNsdWRlL2xpbnV4
L2lwdjYuaAotLS0gbGludXgtMi41LjQ0L2luY2x1ZGUvbGludXgvaXB2Ni5oCUZyaSBPY3QgMTgg
MjE6MDI6MjYgMjAwMgorKysgbGludXgtMi41LjQ0QUMvaW5jbHVkZS9saW51eC9pcHY2LmgJTW9u
IE9jdCAyOCAxMjozODowOSAyMDAyCkBAIC0xNTUsNiArMTU1LDcgQEAKIAkgICAgICAgICAgICAg
ICAgICAgICAgICBwbXR1ZGlzYzoyOwogCiAJc3RydWN0IGlwdjZfbWNfc29ja2xpc3QJKmlwdjZf
bWNfbGlzdDsKKwlzdHJ1Y3QgaXB2Nl9hY19zb2NrbGlzdAkqaXB2Nl9hY19saXN0OwogCXN0cnVj
dCBpcHY2X2ZsX3NvY2tsaXN0ICppcHY2X2ZsX2xpc3Q7CiAJX191MzIJCQlkc3RfY29va2llOwog
CmRpZmYgLXJ1TiBsaW51eC0yLjUuNDQvaW5jbHVkZS9saW51eC9uZXRkZXZpY2UuaCBsaW51eC0y
LjUuNDRBQy9pbmNsdWRlL2xpbnV4L25ldGRldmljZS5oCi0tLSBsaW51eC0yLjUuNDQvaW5jbHVk
ZS9saW51eC9uZXRkZXZpY2UuaAlGcmkgT2N0IDE4IDIxOjAyOjMxIDIwMDIKKysrIGxpbnV4LTIu
NS40NEFDL2luY2x1ZGUvbGludXgvbmV0ZGV2aWNlLmgJTW9uIE9jdCAyOCAxMjozODowOSAyMDAy
CkBAIC00NjQsNiArNDY0LDEwIEBACiBleHRlcm4gdm9pZAkJZGV2X2FkZF9wYWNrKHN0cnVjdCBw
YWNrZXRfdHlwZSAqcHQpOwogZXh0ZXJuIHZvaWQJCWRldl9yZW1vdmVfcGFjayhzdHJ1Y3QgcGFj
a2V0X3R5cGUgKnB0KTsKIGV4dGVybiBpbnQJCWRldl9nZXQoY29uc3QgY2hhciAqbmFtZSk7Citl
eHRlcm4gc3RydWN0IG5ldF9kZXZpY2UJKmRldl9nZXRhbnkodW5zaWduZWQgc2hvcnQgZmxhZ3Ms
CisJCQkJCXVuc2lnbmVkIHNob3J0IG1hc2spOworZXh0ZXJuIHN0cnVjdCBuZXRfZGV2aWNlCSpf
X2Rldl9nZXRhbnkodW5zaWduZWQgc2hvcnQgZmxhZ3MsCisJCQkJCXVuc2lnbmVkIHNob3J0IG1h
c2spOwogZXh0ZXJuIHN0cnVjdCBuZXRfZGV2aWNlCSpkZXZfZ2V0X2J5X25hbWUoY29uc3QgY2hh
ciAqbmFtZSk7CiBleHRlcm4gc3RydWN0IG5ldF9kZXZpY2UJKl9fZGV2X2dldF9ieV9uYW1lKGNv
bnN0IGNoYXIgKm5hbWUpOwogZXh0ZXJuIHN0cnVjdCBuZXRfZGV2aWNlCSpkZXZfYWxsb2MoY29u
c3QgY2hhciAqbmFtZSwgaW50ICplcnIpOwpkaWZmIC1ydU4gbGludXgtMi41LjQ0L2luY2x1ZGUv
bmV0L2FkZHJjb25mLmggbGludXgtMi41LjQ0QUMvaW5jbHVkZS9uZXQvYWRkcmNvbmYuaAotLS0g
bGludXgtMi41LjQ0L2luY2x1ZGUvbmV0L2FkZHJjb25mLmgJRnJpIE9jdCAxOCAyMTowMToxOCAy
MDAyCisrKyBsaW51eC0yLjUuNDRBQy9pbmNsdWRlL25ldC9hZGRyY29uZi5oCU1vbiBPY3QgMjgg
MTI6Mzg6MDkgMjAwMgpAQCAtNTgsNyArNTgsMTUgQEAKIGV4dGVybiBpbnQJCQlpcHY2X2dldF9z
YWRkcihzdHJ1Y3QgZHN0X2VudHJ5ICpkc3QsIAogCQkJCQkgICAgICAgc3RydWN0IGluNl9hZGRy
ICpkYWRkciwKIAkJCQkJICAgICAgIHN0cnVjdCBpbjZfYWRkciAqc2FkZHIpOworZXh0ZXJuIGlu
dAkJCWlwdjZfZGV2X2dldF9zYWRkcihzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LCAKKwkJCQkJICAg
ICAgIHN0cnVjdCBpbjZfYWRkciAqZGFkZHIsCisJCQkJCSAgICAgICBzdHJ1Y3QgaW42X2FkZHIg
KnNhZGRyLAorCQkJCQkgICAgICAgaW50IG9ubGluayk7CiBleHRlcm4gaW50CQkJaXB2Nl9nZXRf
bGxhZGRyKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIHN0cnVjdCBpbjZfYWRkciAqKTsKK2V4dGVy
biB2b2lkCQkJYWRkcmNvbmZfam9pbl9zb2xpY3Qoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKKwkJ
CQkJc3RydWN0IGluNl9hZGRyICphZGRyKTsKK2V4dGVybiB2b2lkCQkJYWRkcmNvbmZfbGVhdmVf
c29saWN0KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCisJCQkJCXN0cnVjdCBpbjZfYWRkciAqYWRk
cik7CiAKIC8qCiAgKgltdWx0aWNhc3QgcHJvdG90eXBlcyAobWNhc3QuYykKQEAgLTg4LDYgKzk2
LDI2IEBACiBleHRlcm4gdm9pZAkJCWFkZHJjb25mX3ByZWZpeF9yY3Yoc3RydWN0IG5ldF9kZXZp
Y2UgKmRldiwKIAkJCQkJCSAgICB1OCAqb3B0LCBpbnQgbGVuKTsKIAorLyoKKyAqCWFueWNhc3Qg
cHJvdG90eXBlcyAoYW55Y2FzdC5jKQorICovCitleHRlcm4gaW50CQkJaXB2Nl9zb2NrX2FjX2pv
aW4oc3RydWN0IHNvY2sgKnNrLCAKKwkJCQkJCSAgaW50IGlmaW5kZXgsIAorCQkJCQkJICBzdHJ1
Y3QgaW42X2FkZHIgKmFkZHIpOworZXh0ZXJuIGludAkJCWlwdjZfc29ja19hY19kcm9wKHN0cnVj
dCBzb2NrICpzaywKKwkJCQkJCSAgaW50IGlmaW5kZXgsIAorCQkJCQkJICBzdHJ1Y3QgaW42X2Fk
ZHIgKmFkZHIpOworZXh0ZXJuIHZvaWQJCQlpcHY2X3NvY2tfYWNfY2xvc2Uoc3RydWN0IHNvY2sg
KnNrKTsKK2V4dGVybiBpbnQJCQlpbmV0Nl9hY19jaGVjayhzdHJ1Y3Qgc29jayAqc2ssIHN0cnVj
dCBpbjZfYWRkciAqYWRkciwgaW50IGlmaW5kZXgpOworCitleHRlcm4gaW50CQkJaXB2Nl9kZXZf
YWNfaW5jKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCisJCQkJCQlzdHJ1Y3QgaW42X2FkZHIgKmFk
ZHIpOworZXh0ZXJuIGludAkJCWlwdjZfZGV2X2FjX2RlYyhzdHJ1Y3QgbmV0X2RldmljZSAqZGV2
LAorCQkJCQkJc3RydWN0IGluNl9hZGRyICphZGRyKTsKK2V4dGVybiBpbnQJCQlpcHY2X2Noa19h
Y2FzdF9hZGRyKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCisJCQkJCQlzdHJ1Y3QgaW42X2FkZHIg
KmFkZHIpOworCisKIC8qIERldmljZSBub3RpZmllciAqLwogZXh0ZXJuIGludCByZWdpc3Rlcl9p
bmV0NmFkZHJfbm90aWZpZXIoc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuYik7CiBleHRlcm4gaW50
IHVucmVnaXN0ZXJfaW5ldDZhZGRyX25vdGlmaWVyKHN0cnVjdCBub3RpZmllcl9ibG9jayAqbmIp
OwpkaWZmIC1ydU4gbGludXgtMi41LjQ0L2luY2x1ZGUvbmV0L2lmX2luZXQ2LmggbGludXgtMi41
LjQ0QUMvaW5jbHVkZS9uZXQvaWZfaW5ldDYuaAotLS0gbGludXgtMi41LjQ0L2luY2x1ZGUvbmV0
L2lmX2luZXQ2LmgJRnJpIE9jdCAxOCAyMTowMjozNCAyMDAyCisrKyBsaW51eC0yLjUuNDRBQy9p
bmNsdWRlL25ldC9pZl9pbmV0Ni5oCU1vbiBPY3QgMjggMTI6Mzg6MDkgMjAwMgpAQCAtNjksNiAr
NjksMjUgQEAKIAlzcGlubG9ja190CQltY2FfbG9jazsKIH07CiAKKy8qIEFueWNhc3Qgc3R1ZmYg
Ki8KKworc3RydWN0IGlwdjZfYWNfc29ja2xpc3QKK3sKKwlzdHJ1Y3QgaW42X2FkZHIJCWFjbF9h
ZGRyOworCWludAkJCWFjbF9pZmluZGV4OworCXN0cnVjdCBpcHY2X2FjX3NvY2tsaXN0ICphY2xf
bmV4dDsKK307CisKK3N0cnVjdCBpZmFjYWRkcjYKK3sKKwlzdHJ1Y3QgaW42X2FkZHIJCWFjYV9h
ZGRyOworCXN0cnVjdCBpbmV0Nl9kZXYJKmFjYV9pZGV2OworCXN0cnVjdCBpZmFjYWRkcjYJKmFj
YV9uZXh0OworCWludAkJCWFjYV91c2VyczsKKwlhdG9taWNfdAkJYWNhX3JlZmNudDsKKwlzcGlu
bG9ja190CQlhY2FfbG9jazsKK307CisKICNkZWZpbmUJSUZBX0hPU1QJSVBWNl9BRERSX0xPT1BC
QUNLCiAjZGVmaW5lCUlGQV9MSU5LCUlQVjZfQUREUl9MSU5LTE9DQUwKICNkZWZpbmUJSUZBX1NJ
VEUJSVBWNl9BRERSX1NJVEVMT0NBTApAQCAtOTYsNiArMTE1LDcgQEAKIAogCXN0cnVjdCBpbmV0
Nl9pZmFkZHIJKmFkZHJfbGlzdDsKIAlzdHJ1Y3QgaWZtY2FkZHI2CSptY19saXN0OworCXN0cnVj
dCBpZmFjYWRkcjYJKmFjX2xpc3Q7CiAJcndsb2NrX3QJCWxvY2s7CiAJYXRvbWljX3QJCXJlZmNu
dDsKIAlfX3UzMgkJCWlmX2ZsYWdzOwpkaWZmIC1ydU4gbGludXgtMi41LjQ0L25ldC9jb3JlL2Rl
di5jIGxpbnV4LTIuNS40NEFDL25ldC9jb3JlL2Rldi5jCi0tLSBsaW51eC0yLjUuNDQvbmV0L2Nv
cmUvZGV2LmMJRnJpIE9jdCAxOCAyMTowMTo1NCAyMDAyCisrKyBsaW51eC0yLjUuNDRBQy9uZXQv
Y29yZS9kZXYuYwlNb24gT2N0IDI4IDEyOjM4OjA5IDIwMDIKQEAgLTU0MSw2ICs1NDEsNTAgQEAK
IH0KIAogLyoqCisgKglkZXZfZ2V0YW55IC0gZmluZCBhbnkgZGV2aWNlIHdpdGggZ2l2ZW4gZmxh
Z3MKKyAqCUBpZl9mbGFnczogSUZGXyogdmFsdWVzCisgKglAbWFzazogYml0bWFzayBvZiBiaXRz
IGluIGlmX2ZsYWdzIHRvIGNoZWNrCisgKgorICoJU2VhcmNoIGZvciBhbnkgaW50ZXJmYWNlIHdp
dGggdGhlIGdpdmVuIGZsYWdzLiBSZXR1cm5zIE5VTEwgaWYgYSBkZXZpY2UKKyAqCWlzIG5vdCBm
b3VuZCBvciBhIHBvaW50ZXIgdG8gdGhlIGRldmljZS4gVGhlIGRldmljZSByZXR1cm5lZCBoYXMg
CisgKgloYWQgYSByZWZlcmVuY2UgYWRkZWQgYW5kIHRoZSBwb2ludGVyIGlzIHNhZmUgdW50aWwg
dGhlIHVzZXIgY2FsbHMKKyAqCWRldl9wdXQgdG8gaW5kaWNhdGUgdGhleSBoYXZlIGZpbmlzaGVk
IHdpdGggaXQuCisgKi8KKworc3RydWN0IG5ldF9kZXZpY2UgKiBkZXZfZ2V0YW55KHVuc2lnbmVk
IHNob3J0IGlmX2ZsYWdzLCB1bnNpZ25lZCBzaG9ydCBtYXNrKQoreworCXN0cnVjdCBuZXRfZGV2
aWNlICpkZXY7CisKKwlyZWFkX2xvY2soJmRldl9iYXNlX2xvY2spOworCWRldiA9IF9fZGV2X2dl
dGFueShpZl9mbGFncywgbWFzayk7CisJaWYgKGRldikKKwkJZGV2X2hvbGQoZGV2KTsKKwlyZWFk
X3VubG9jaygmZGV2X2Jhc2VfbG9jayk7CisJcmV0dXJuIGRldjsKK30KKworLyoqCisgKglfX2Rl
dl9nZXRhbnkgLSBmaW5kIGFueSBkZXZpY2Ugd2l0aCBnaXZlbiBmbGFncworICoJQGlmX2ZsYWdz
OiBJRkZfKiB2YWx1ZXMKKyAqCUBtYXNrOiBiaXRtYXNrIG9mIGJpdHMgaW4gaWZfZmxhZ3MgdG8g
Y2hlY2sKKyAqCisgKglTZWFyY2ggZm9yIGFueSBpbnRlcmZhY2Ugd2l0aCB0aGUgZ2l2ZW4gZmxh
Z3MuIFJldHVybnMgTlVMTCBpZiBhIGRldmljZQorICoJaXMgbm90IGZvdW5kIG9yIGEgcG9pbnRl
ciB0byB0aGUgZGV2aWNlLiBUaGUgY2FsbGVyIG11c3QgaG9sZCBlaXRoZXIKKyAqCXRoZSBSVE5M
IHNlbWFwaG9yZSBvciBAZGV2X2Jhc2VfbG9jay4KKyAqLworCitzdHJ1Y3QgbmV0X2RldmljZSAq
X19kZXZfZ2V0YW55KHVuc2lnbmVkIHNob3J0IGlmX2ZsYWdzLCB1bnNpZ25lZCBzaG9ydCBtYXNr
KQoreworCXN0cnVjdCBuZXRfZGV2aWNlICpkZXY7CisKKwlmb3IgKGRldiA9IGRldl9iYXNlOyBk
ZXYgIT0gTlVMTDsgZGV2ID0gZGV2LT5uZXh0KSB7CisJCWlmICgoKGRldi0+ZmxhZ3MgXiBpZl9m
bGFncykgJiBtYXNrKSA9PSAwKQorCQkJcmV0dXJuIGRldjsKKwl9CisJcmV0dXJuIE5VTEw7Cit9
CisKKy8qKgogICoJZGV2X2FsbG9jX25hbWUgLSBhbGxvY2F0ZSBhIG5hbWUgZm9yIGEgZGV2aWNl
CiAgKglAZGV2OiBkZXZpY2UKICAqCUBuYW1lOiBuYW1lIGZvcm1hdCBzdHJpbmcKZGlmZiAtcnVO
IGxpbnV4LTIuNS40NC9uZXQvaXB2Ni9NYWtlZmlsZSBsaW51eC0yLjUuNDRBQy9uZXQvaXB2Ni9N
YWtlZmlsZQotLS0gbGludXgtMi41LjQ0L25ldC9pcHY2L01ha2VmaWxlCUZyaSBPY3QgMTggMjE6
MDI6MjcgMjAwMgorKysgbGludXgtMi41LjQ0QUMvbmV0L2lwdjYvTWFrZWZpbGUJTW9uIE9jdCAy
OCAxMjozODowOSAyMDAyCkBAIC02LDcgKzYsNyBAQAogCiBvYmotJChDT05GSUdfSVBWNikgKz0g
aXB2Ni5vCiAKLWlwdjYtb2JqcyA6PQlhZl9pbmV0Ni5vIGlwNl9vdXRwdXQubyBpcDZfaW5wdXQu
byBhZGRyY29uZi5vIHNpdC5vIFwKK2lwdjYtb2JqcyA6PQlhZl9pbmV0Ni5vIGFueWNhc3QubyBp
cDZfb3V0cHV0Lm8gaXA2X2lucHV0Lm8gYWRkcmNvbmYubyBzaXQubyBcCiAJCXJvdXRlLm8gaXA2
X2ZpYi5vIGlwdjZfc29ja2dsdWUubyBuZGlzYy5vIHVkcC5vIHJhdy5vIFwKIAkJcHJvdG9jb2wu
byBpY21wLm8gbWNhc3QubyByZWFzc2VtYmx5Lm8gdGNwX2lwdjYubyBcCiAJCWV4dGhkcnMubyBz
eXNjdGxfbmV0X2lwdjYubyBkYXRhZ3JhbS5vIHByb2MubyBcCmRpZmYgLXJ1TiBsaW51eC0yLjUu
NDQvbmV0L2lwdjYvYWRkcmNvbmYuYyBsaW51eC0yLjUuNDRBQy9uZXQvaXB2Ni9hZGRyY29uZi5j
Ci0tLSBsaW51eC0yLjUuNDQvbmV0L2lwdjYvYWRkcmNvbmYuYwlGcmkgT2N0IDE4IDIxOjAyOjMx
IDIwMDIKKysrIGxpbnV4LTIuNS40NEFDL25ldC9pcHY2L2FkZHJjb25mLmMJTW9uIE9jdCAyOCAx
Mjo0OTowMyAyMDAyCkBAIC0xMzcsMjEgKzEzNywxNSBAQAogCiBpbnQgaXB2Nl9hZGRyX3R5cGUo
c3RydWN0IGluNl9hZGRyICphZGRyKQogeworCWludCB0eXBlOwogCXUzMiBzdDsKIAogCXN0ID0g
YWRkci0+czZfYWRkcjMyWzBdOwogCi0JLyogQ29uc2lkZXIgYWxsIGFkZHJlc3NlcyB3aXRoIHRo
ZSBmaXJzdCB0aHJlZSBiaXRzIGRpZmZlcmVudCBvZgotCSAgIDAwMCBhbmQgMTExIGFzIHVuaWNh
c3RzLgotCSAqLwotCWlmICgoc3QgJiBodG9ubCgweEUwMDAwMDAwKSkgIT0gaHRvbmwoMHgwMDAw
MDAwMCkgJiYKLQkgICAgKHN0ICYgaHRvbmwoMHhFMDAwMDAwMCkpICE9IGh0b25sKDB4RTAwMDAw
MDApKQotCQlyZXR1cm4gSVBWNl9BRERSX1VOSUNBU1Q7Ci0KLQlpZiAoKHN0ICYgaHRvbmwoMHhG
RjAwMDAwMCkpID09IGh0b25sKDB4RkYwMDAwMDApKSB7Ci0JCWludCB0eXBlID0gSVBWNl9BRERS
X01VTFRJQ0FTVDsKKwlpZiAoKHN0ICYgX19jb25zdGFudF9odG9ubCgweEZGMDAwMDAwKSkgPT0g
X19jb25zdGFudF9odG9ubCgweEZGMDAwMDAwKSkgeworCQl0eXBlID0gSVBWNl9BRERSX01VTFRJ
Q0FTVDsKIAotCQlzd2l0Y2goKHN0ICYgaHRvbmwoMHgwMEZGMDAwMCkpKSB7CisJCXN3aXRjaCgo
c3QgJiBfX2NvbnN0YW50X2h0b25sKDB4MDBGRjAwMDApKSkgewogCQkJY2FzZSBfX2NvbnN0YW50
X2h0b25sKDB4MDAwMTAwMDApOgogCQkJCXR5cGUgfD0gSVBWNl9BRERSX0xPT1BCQUNLOwogCQkJ
CWJyZWFrOwpAQCAtMTY2LDI5ICsxNjAsNTMgQEAKIAkJfTsKIAkJcmV0dXJuIHR5cGU7CiAJfQor
CS8qIGNoZWNrIGZvciByZXNlcnZlZCBhbnljYXN0IGFkZHJlc3NlcyAqLworCQorCWlmICgoc3Qg
JiBfX2NvbnN0YW50X2h0b25sKDB4RTAwMDAwMDApKSAmJgorCSAgICAoKGFkZHItPnM2X2FkZHIz
MlsyXSA9PSBfX2NvbnN0YW50X2h0b25sKDB4RkRGRkZGRkYpICYmCisJICAgIChhZGRyLT5zNl9h
ZGRyMzJbM10gfCBfX2NvbnN0YW50X2h0b25sKDB4N0YpKSA9PSAodTMyKX4wKSB8fAorCSAgICAo
YWRkci0+czZfYWRkcjMyWzJdID09IDAgJiYgYWRkci0+czZfYWRkcjMyWzNdID09IDApKSkKKwkJ
dHlwZSA9IElQVjZfQUREUl9BTllDQVNUOworCWVsc2UKKwkJdHlwZSA9IElQVjZfQUREUl9VTklD
QVNUOworCisJLyogQ29uc2lkZXIgYWxsIGFkZHJlc3NlcyB3aXRoIHRoZSBmaXJzdCB0aHJlZSBi
aXRzIGRpZmZlcmVudCBvZgorCSAgIDAwMCBhbmQgMTExIGFzIGZpbmlzaGVkLgorCSAqLworCWlm
ICgoc3QgJiBfX2NvbnN0YW50X2h0b25sKDB4RTAwMDAwMDApKSAhPSBfX2NvbnN0YW50X2h0b25s
KDB4MDAwMDAwMDApICYmCisJICAgIChzdCAmIF9fY29uc3RhbnRfaHRvbmwoMHhFMDAwMDAwMCkp
ICE9IF9fY29uc3RhbnRfaHRvbmwoMHhFMDAwMDAwMCkpCisJCXJldHVybiB0eXBlOwogCQotCWlm
ICgoc3QgJiBodG9ubCgweEZGQzAwMDAwKSkgPT0gaHRvbmwoMHhGRTgwMDAwMCkpCi0JCXJldHVy
biAoSVBWNl9BRERSX0xJTktMT0NBTCB8IElQVjZfQUREUl9VTklDQVNUKTsKKwlpZiAoKHN0ICYg
X19jb25zdGFudF9odG9ubCgweEZGQzAwMDAwKSkgPT0gX19jb25zdGFudF9odG9ubCgweEZFODAw
MDAwKSkKKwkJcmV0dXJuIChJUFY2X0FERFJfTElOS0xPQ0FMIHwgdHlwZSk7CiAKLQlpZiAoKHN0
ICYgaHRvbmwoMHhGRkMwMDAwMCkpID09IGh0b25sKDB4RkVDMDAwMDApKQotCQlyZXR1cm4gKElQ
VjZfQUREUl9TSVRFTE9DQUwgfCBJUFY2X0FERFJfVU5JQ0FTVCk7CisJaWYgKChzdCAmIF9fY29u
c3RhbnRfaHRvbmwoMHhGRkMwMDAwMCkpID09IF9fY29uc3RhbnRfaHRvbmwoMHhGRUMwMDAwMCkp
CisJCXJldHVybiAoSVBWNl9BRERSX1NJVEVMT0NBTCB8IHR5cGUpOwogCiAJaWYgKChhZGRyLT5z
Nl9hZGRyMzJbMF0gfCBhZGRyLT5zNl9hZGRyMzJbMV0pID09IDApIHsKIAkJaWYgKGFkZHItPnM2
X2FkZHIzMlsyXSA9PSAwKSB7Ci0JCQlpZiAoYWRkci0+czZfYWRkcjMyWzNdID09IDApCisJCQlp
ZiAoYWRkci0+aW42X3UudTZfYWRkcjMyWzNdID09IDApCiAJCQkJcmV0dXJuIElQVjZfQUREUl9B
Tlk7CiAKLQkJCWlmIChhZGRyLT5zNl9hZGRyMzJbM10gPT0gaHRvbmwoMHgwMDAwMDAwMSkpCi0J
CQkJcmV0dXJuIChJUFY2X0FERFJfTE9PUEJBQ0sgfCBJUFY2X0FERFJfVU5JQ0FTVCk7CisJCQlp
ZiAoYWRkci0+czZfYWRkcjMyWzNdID09IF9fY29uc3RhbnRfaHRvbmwoMHgwMDAwMDAwMSkpCisJ
CQkJcmV0dXJuIChJUFY2X0FERFJfTE9PUEJBQ0sgfCB0eXBlKTsKIAotCQkJcmV0dXJuIChJUFY2
X0FERFJfQ09NUEFUdjQgfCBJUFY2X0FERFJfVU5JQ0FTVCk7CisJCQlyZXR1cm4gKElQVjZfQURE
Ul9DT01QQVR2NCB8IHR5cGUpOwogCQl9CiAKLQkJaWYgKGFkZHItPnM2X2FkZHIzMlsyXSA9PSBo
dG9ubCgweDAwMDBmZmZmKSkKKwkJaWYgKGFkZHItPnM2X2FkZHIzMlsyXSA9PSBfX2NvbnN0YW50
X2h0b25sKDB4MDAwMGZmZmYpKQogCQkJcmV0dXJuIElQVjZfQUREUl9NQVBQRUQ7CiAJfQogCi0J
cmV0dXJuIElQVjZfQUREUl9SRVNFUlZFRDsKKwlzdCAmPSBfX2NvbnN0YW50X2h0b25sKDB4RkYw
MDAwMDApOworCWlmIChzdCA9PSAwKQorCQlyZXR1cm4gSVBWNl9BRERSX1JFU0VSVkVEOworCXN0
ICY9IF9fY29uc3RhbnRfaHRvbmwoMHhGRTAwMDAwMCk7CisJaWYgKHN0ID09IF9fY29uc3RhbnRf
aHRvbmwoMHgwMjAwMDAwMCkpCisJCXJldHVybiBJUFY2X0FERFJfUkVTRVJWRUQ7CS8qIGZvciBO
U0FQICovCisJaWYgKHN0ID09IF9fY29uc3RhbnRfaHRvbmwoMHgwNDAwMDAwMCkpCisJCXJldHVy
biBJUFY2X0FERFJfUkVTRVJWRUQ7CS8qIGZvciBJUFggKi8KKwlyZXR1cm4gdHlwZTsKIH0KIAog
c3RhdGljIHZvaWQgYWRkcmNvbmZfZGVsX3RpbWVyKHN0cnVjdCBpbmV0Nl9pZmFkZHIgKmlmcCkK
QEAgLTIyNCw3ICsyNDIsNiBAQAogCWFkZF90aW1lcigmaWZwLT50aW1lcik7CiB9CiAKLQogLyog
Tm9ib2R5IHJlZmVycyB0byB0aGlzIGRldmljZSwgd2UgbWF5IGRlc3Ryb3kgaXQuICovCiAKIHZv
aWQgaW42X2Rldl9maW5pc2hfZGVzdHJveShzdHJ1Y3QgaW5ldDZfZGV2ICppZGV2KQpAQCAtMzAz
LDI0ICszMjAsOTEgQEAKIAlyZXR1cm4gaWRldjsKIH0KIAordm9pZCBpcHY2X2FkZHJfcHJlZml4
KHN0cnVjdCBpbjZfYWRkciAqcHJlZml4LAorCXN0cnVjdCBpbjZfYWRkciAqYWRkciwgaW50IHBy
ZWZpeF9sZW4pCit7CisJdW5zaWduZWQgbG9uZyBtYXNrOworCWludCBuY29weSwgbmJpdHM7CisK
KwltZW1zZXQocHJlZml4LCAwLCBzaXplb2YoKnByZWZpeCkpOworCisJaWYgKHByZWZpeF9sZW4g
PD0gMCkKKwkJcmV0dXJuOworCWlmIChwcmVmaXhfbGVuID4gMTI4KQorCQlwcmVmaXhfbGVuID0g
MTI4OworCisJbmNvcHkgPSBwcmVmaXhfbGVuIC8gMzI7CisJc3dpdGNoIChuY29weSkgeworCWNh
c2UgNDoJcHJlZml4LT5zNl9hZGRyMzJbM10gPSBhZGRyLT5zNl9hZGRyMzJbM107CisJY2FzZSAz
OglwcmVmaXgtPnM2X2FkZHIzMlsyXSA9IGFkZHItPnM2X2FkZHIzMlsyXTsKKwljYXNlIDI6CXBy
ZWZpeC0+czZfYWRkcjMyWzFdID0gYWRkci0+czZfYWRkcjMyWzFdOworCWNhc2UgMToJcHJlZml4
LT5zNl9hZGRyMzJbMF0gPSBhZGRyLT5zNl9hZGRyMzJbMF07CisJY2FzZSAwOglicmVhazsKKwl9
CisJbmJpdHMgPSBwcmVmaXhfbGVuICUgMzI7CisJaWYgKG5iaXRzID09IDApCisJCXJldHVybjsK
KworCW1hc2sgPSB+KCgxIDw8ICgzMiAtIG5iaXRzKSkgLSAxKTsKKwltYXNrID0gaHRvbmwobWFz
ayk7CisKKwlwcmVmaXgtPnM2X2FkZHIzMltuY29weV0gPSBhZGRyLT5zNl9hZGRyMzJbbmNvcHld
ICYgbWFzazsKK30KKworCitzdGF0aWMgdm9pZCBkZXZfZm9yd2FyZF9jaGFuZ2Uoc3RydWN0IGlu
ZXQ2X2RldiAqaWRldikKK3sKKwlzdHJ1Y3QgbmV0X2RldmljZSAqZGV2OworCXN0cnVjdCBpbmV0
Nl9pZmFkZHIgKmlmYTsKKwlzdHJ1Y3QgaW42X2FkZHIgYWRkcjsKKworCWlmICghaWRldikKKwkJ
cmV0dXJuOworCWRldiA9IGlkZXYtPmRldjsKKwlpZiAoZGV2ICYmIChkZXYtPmZsYWdzICYgSUZG
X01VTFRJQ0FTVCkpIHsKKwkJaXB2Nl9hZGRyX2FsbF9yb3V0ZXJzKCZhZGRyKTsKKwkKKwkJaWYg
KGlkZXYtPmNuZi5mb3J3YXJkaW5nKQorCQkJaXB2Nl9kZXZfbWNfaW5jKGRldiwgJmFkZHIpOwor
CQllbHNlCisJCQlpcHY2X2Rldl9tY19kZWMoZGV2LCAmYWRkcik7CisJfQorCWZvciAoaWZhPWlk
ZXYtPmFkZHJfbGlzdDsgaWZhOyBpZmE9aWZhLT5pZl9uZXh0KSB7CisJCWlwdjZfYWRkcl9wcmVm
aXgoJmFkZHIsICZpZmEtPmFkZHIsIGlmYS0+cHJlZml4X2xlbik7CisJCWlmIChhZGRyLnM2X2Fk
ZHIzMlswXSA9PSAwICYmIGFkZHIuczZfYWRkcjMyWzFdID09IDAgJiYKKwkJICAgIGFkZHIuczZf
YWRkcjMyWzJdID09IDAgJiYgYWRkci5zNl9hZGRyMzJbM10gPT0gMCkKKwkJCWNvbnRpbnVlOwor
CQlpZiAoaWRldi0+Y25mLmZvcndhcmRpbmcpCisJCQlpcHY2X2Rldl9hY19pbmMoaWRldi0+ZGV2
LCAmYWRkcik7CisJCWVsc2UKKwkJCWlwdjZfZGV2X2FjX2RlYyhpZGV2LT5kZXYsICZhZGRyKTsK
Kwl9Cit9CisKKwogc3RhdGljIHZvaWQgYWRkcmNvbmZfZm9yd2FyZF9jaGFuZ2Uoc3RydWN0IGlu
ZXQ2X2RldiAqaWRldikKIHsKIAlzdHJ1Y3QgbmV0X2RldmljZSAqZGV2OwogCi0JaWYgKGlkZXYp
CisJaWYgKGlkZXYpIHsKKwkJZGV2X2ZvcndhcmRfY2hhbmdlKGlkZXYpOwogCQlyZXR1cm47CisJ
fQogCiAJcmVhZF9sb2NrKCZkZXZfYmFzZV9sb2NrKTsKIAlmb3IgKGRldj1kZXZfYmFzZTsgZGV2
OyBkZXY9ZGV2LT5uZXh0KSB7CiAJCXJlYWRfbG9jaygmYWRkcmNvbmZfbG9jayk7CiAJCWlkZXYg
PSBfX2luNl9kZXZfZ2V0KGRldik7Ci0JCWlmIChpZGV2KQorCQlpZiAoaWRldikgewogCQkJaWRl
di0+Y25mLmZvcndhcmRpbmcgPSBpcHY2X2RldmNvbmYuZm9yd2FyZGluZzsKKwkJCWRldl9mb3J3
YXJkX2NoYW5nZShpZGV2KTsKKwkJfQogCQlyZWFkX3VubG9jaygmYWRkcmNvbmZfbG9jayk7CiAJ
fQogCXJlYWRfdW5sb2NrKCZkZXZfYmFzZV9sb2NrKTsKIH0KIAorCiAvKiBOb2JvZHkgcmVmZXJz
IHRvIHRoaXMgaWZhZGRyLCBkZXN0cm95IGl0ICovCiAKIHZvaWQgaW5ldDZfaWZhX2ZpbmlzaF9k
ZXN0cm95KHN0cnVjdCBpbmV0Nl9pZmFkZHIgKmlmcCkKQEAgLTQ1OCwyOSArNTQyLDIwIEBACiAg
KgkJYW4gYWRkcmVzcyBvZiB0aGUgYXR0YWNoZWQgaW50ZXJmYWNlIAogICoJaWlpKQlkb24ndCB1
c2UgZGVwcmVjYXRlZCBhZGRyZXNzZXMKICAqLwotaW50IGlwdjZfZ2V0X3NhZGRyKHN0cnVjdCBk
c3RfZW50cnkgKmRzdCwKLQkJICAgc3RydWN0IGluNl9hZGRyICpkYWRkciwgc3RydWN0IGluNl9h
ZGRyICpzYWRkcikKK2ludCBpcHY2X2Rldl9nZXRfc2FkZHIoc3RydWN0IG5ldF9kZXZpY2UgKmRl
diwKKwkJICAgc3RydWN0IGluNl9hZGRyICpkYWRkciwgc3RydWN0IGluNl9hZGRyICpzYWRkciwg
aW50IG9ubGluaykKIHsKLQlpbnQgc2NvcGU7CiAJc3RydWN0IGluZXQ2X2lmYWRkciAqaWZwID0g
TlVMTDsKIAlzdHJ1Y3QgaW5ldDZfaWZhZGRyICptYXRjaCA9IE5VTEw7Ci0Jc3RydWN0IG5ldF9k
ZXZpY2UgKmRldiA9IE5VTEw7CiAJc3RydWN0IGluZXQ2X2RldiAqaWRldjsKLQlzdHJ1Y3QgcnQ2
X2luZm8gKnJ0OworCWludCBzY29wZTsKIAlpbnQgZXJyOwogCi0JcnQgPSAoc3RydWN0IHJ0Nl9p
bmZvICopIGRzdDsKLQlpZiAocnQpCi0JCWRldiA9IHJ0LT5ydDZpX2RldjsKIAotCXNjb3BlID0g
aXB2Nl9hZGRyX3Njb3BlKGRhZGRyKTsKLQlpZiAocnQgJiYgKHJ0LT5ydDZpX2ZsYWdzICYgUlRG
X0FMTE9OTElOSykpIHsKLQkJLyoKLQkJICoJcm91dGUgZm9yIHRoZSAiYWxsIGRlc3RpbmF0aW9u
cyBvbiBsaW5rIiBydWxlCi0JCSAqCXdoZW4gbm8gcm91dGVycyBhcmUgcHJlc2VudAotCQkgKi8K
KwlpZiAoIW9ubGluaykKKwkJc2NvcGUgPSBpcHY2X2FkZHJfc2NvcGUoZGFkZHIpOworCWVsc2UK
IAkJc2NvcGUgPSBJRkFfTElOSzsKLQl9CiAKIAkvKgogCSAqCWtub3duIGRldgpAQCAtNTY4LDYg
KzY0MywyNCBAQAogCXJldHVybiBlcnI7CiB9CiAKKworaW50IGlwdjZfZ2V0X3NhZGRyKHN0cnVj
dCBkc3RfZW50cnkgKmRzdCwKKwkJICAgc3RydWN0IGluNl9hZGRyICpkYWRkciwgc3RydWN0IGlu
Nl9hZGRyICpzYWRkcikKK3sKKwlzdHJ1Y3QgcnQ2X2luZm8gKnJ0OworCXN0cnVjdCBuZXRfZGV2
aWNlICpkZXYgPSBOVUxMOworCWludCBvbmxpbms7CisKKwlydCA9IChzdHJ1Y3QgcnQ2X2luZm8g
KikgZHN0OworCWlmIChydCkKKwkJZGV2ID0gcnQtPnJ0NmlfZGV2OworCisJb25saW5rID0gKHJ0
ICYmIChydC0+cnQ2aV9mbGFncyAmIFJURl9BTExPTkxJTkspKTsKKworCXJldHVybiBpcHY2X2Rl
dl9nZXRfc2FkZHIoZGV2LCBkYWRkciwgc2FkZHIsIG9ubGluayk7Cit9CisKKwogaW50IGlwdjZf
Z2V0X2xsYWRkcihzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LCBzdHJ1Y3QgaW42X2FkZHIgKmFkZHIp
CiB7CiAJc3RydWN0IGluZXQ2X2RldiAqaWRldjsKQEAgLTY2MCw3ICs3NTMsNyBAQAogCiAvKiBK
b2luIHRvIHNvbGljaXRlZCBhZGRyIG11bHRpY2FzdCBncm91cC4gKi8KIAotc3RhdGljIHZvaWQg
YWRkcmNvbmZfam9pbl9zb2xpY3Qoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgc3RydWN0IGluNl9h
ZGRyICphZGRyKQordm9pZCBhZGRyY29uZl9qb2luX3NvbGljdChzdHJ1Y3QgbmV0X2RldmljZSAq
ZGV2LCBzdHJ1Y3QgaW42X2FkZHIgKmFkZHIpCiB7CiAJc3RydWN0IGluNl9hZGRyIG1hZGRyOwog
CkBAIC02NzEsNyArNzY0LDcgQEAKIAlpcHY2X2Rldl9tY19pbmMoZGV2LCAmbWFkZHIpOwogfQog
Ci1zdGF0aWMgdm9pZCBhZGRyY29uZl9sZWF2ZV9zb2xpY3Qoc3RydWN0IG5ldF9kZXZpY2UgKmRl
diwgc3RydWN0IGluNl9hZGRyICphZGRyKQordm9pZCBhZGRyY29uZl9sZWF2ZV9zb2xpY3Qoc3Ry
dWN0IG5ldF9kZXZpY2UgKmRldiwgc3RydWN0IGluNl9hZGRyICphZGRyKQogewogCXN0cnVjdCBp
bjZfYWRkciBtYWRkcjsKIApAQCAtMTU1NCw2ICsxNjQ3LDE1IEBACiAJCWFkZHJjb25mX21vZF90
aW1lcihpZnAsIEFDX1JTLCBpZnAtPmlkZXYtPmNuZi5ydHJfc29saWNpdF9pbnRlcnZhbCk7CiAJ
CXNwaW5fdW5sb2NrX2JoKCZpZnAtPmxvY2spOwogCX0KKworCWlmIChpZnAtPmlkZXYtPmNuZi5m
b3J3YXJkaW5nKSB7CisJCXN0cnVjdCBpbjZfYWRkciBhZGRyOworCisJCWlwdjZfYWRkcl9wcmVm
aXgoJmFkZHIsICZpZnAtPmFkZHIsIGlmcC0+cHJlZml4X2xlbik7CisJCWlmIChhZGRyLnM2X2Fk
ZHIzMlswXSB8fCBhZGRyLnM2X2FkZHIzMlsxXSB8fAorCQkgICAgYWRkci5zNl9hZGRyMzJbMl0g
fHwgYWRkci5zNl9hZGRyMzJbM10pCisJCQlpcHY2X2Rldl9hY19pbmMoaWZwLT5pZGV2LT5kZXYs
ICZhZGRyKTsKKwl9CiB9CiAKICNpZmRlZiBDT05GSUdfUFJPQ19GUwpAQCAtMTg1Myw2ICsxOTU1
LDE0IEBACiAJCWJyZWFrOwogCWNhc2UgUlRNX0RFTEFERFI6CiAJCWFkZHJjb25mX2xlYXZlX3Nv
bGljdChpZnAtPmlkZXYtPmRldiwgJmlmcC0+YWRkcik7CisJCWlmIChpZnAtPmlkZXYtPmNuZi5m
b3J3YXJkaW5nKSB7CisJCQlzdHJ1Y3QgaW42X2FkZHIgYWRkcjsKKworCQkJaXB2Nl9hZGRyX3By
ZWZpeCgmYWRkciwgJmlmcC0+YWRkciwgaWZwLT5wcmVmaXhfbGVuKTsKKwkJCWlmIChhZGRyLnM2
X2FkZHIzMlswXSB8fCBhZGRyLnM2X2FkZHIzMlsxXSB8fAorCQkJICAgIGFkZHIuczZfYWRkcjMy
WzJdIHx8IGFkZHIuczZfYWRkcjMyWzNdKQorCQkJCWlwdjZfZGV2X2FjX2RlYyhpZnAtPmlkZXYt
PmRldiwgJmFkZHIpOworCQl9CiAJCWlmICghaXB2Nl9jaGtfYWRkcigmaWZwLT5hZGRyLCBOVUxM
KSkKIAkJCWlwNl9ydF9hZGRyX2RlbCgmaWZwLT5hZGRyLCBpZnAtPmlkZXYtPmRldik7CiAJCWJy
ZWFrOwpAQCAtMTg3NSwxMSArMTk4NSw3IEBACiAJCXN0cnVjdCBpbmV0Nl9kZXYgKmlkZXYgPSBO
VUxMOwogCiAJCWlmICh2YWxwICE9ICZpcHY2X2RldmNvbmYuZm9yd2FyZGluZykgewotCQkJc3Ry
dWN0IG5ldF9kZXZpY2UgKmRldiA9IGRldl9nZXRfYnlfaW5kZXgoY3RsLT5jdGxfbmFtZSk7Ci0J
CQlpZiAoZGV2KSB7Ci0JCQkJaWRldiA9IGluNl9kZXZfZ2V0KGRldik7Ci0JCQkJZGV2X3B1dChk
ZXYpOwotCQkJfQorCQkJaWRldiA9IChzdHJ1Y3QgaW5ldDZfZGV2ICopY3RsLT5leHRyYTE7CiAJ
CQlpZiAoaWRldiA9PSBOVUxMKQogCQkJCXJldHVybiByZXQ7CiAJCX0gZWxzZQpAQCAtMTg4OSw4
ICsxOTk1LDYgQEAKIAogCQlpZiAoKnZhbHApCiAJCQlydDZfcHVyZ2VfZGZsdF9yb3V0ZXJzKDAp
OwotCQlpZiAoaWRldikKLQkJCWluNl9kZXZfcHV0KGlkZXYpOwogCX0KIAogICAgICAgICByZXR1
cm4gcmV0OwpAQCAtMTk2Nyw2ICsyMDcxLDcgQEAKIAlmb3IgKGk9MDsgaTxzaXplb2YodC0+YWRk
cmNvbmZfdmFycykvc2l6ZW9mKHQtPmFkZHJjb25mX3ZhcnNbMF0pLTE7IGkrKykgewogCQl0LT5h
ZGRyY29uZl92YXJzW2ldLmRhdGEgKz0gKGNoYXIqKXAgLSAoY2hhciopJmlwdjZfZGV2Y29uZjsK
IAkJdC0+YWRkcmNvbmZfdmFyc1tpXS5kZSA9IE5VTEw7CisJCXQtPmFkZHJjb25mX3ZhcnNbaV0u
ZXh0cmExID0gaWRldjsgLyogZW1iZWRkZWQ7IG5vIHJlZiAqLwogCX0KIAlpZiAoZGV2KSB7CiAJ
CXQtPmFkZHJjb25mX2RldlswXS5wcm9jbmFtZSA9IGRldi0+bmFtZTsKZGlmZiAtcnVOIGxpbnV4
LTIuNS40NC9uZXQvaXB2Ni9hZl9pbmV0Ni5jIGxpbnV4LTIuNS40NEFDL25ldC9pcHY2L2FmX2lu
ZXQ2LmMKLS0tIGxpbnV4LTIuNS40NC9uZXQvaXB2Ni9hZl9pbmV0Ni5jCUZyaSBPY3QgMTggMjE6
MDE6NTcgMjAwMgorKysgbGludXgtMi41LjQ0QUMvbmV0L2lwdjYvYWZfaW5ldDYuYwlNb24gT2N0
IDI4IDEyOjM4OjA5IDIwMDIKQEAgLTc2LDYgKzc2LDcgQEAKIC8qIElQdjYgcHJvY2ZzIGdvb2Rp
ZXMuLi4gKi8KIAogI2lmZGVmIENPTkZJR19QUk9DX0ZTCitleHRlcm4gaW50IGFueWNhc3Q2X2dl
dF9pbmZvKGNoYXIgKiwgY2hhciAqKiwgb2ZmX3QsIGludCk7CiBleHRlcm4gaW50IHJhdzZfZ2V0
X2luZm8oY2hhciAqLCBjaGFyICoqLCBvZmZfdCwgaW50KTsKIGV4dGVybiBpbnQgdGNwNl9nZXRf
aW5mbyhjaGFyICosIGNoYXIgKiosIG9mZl90LCBpbnQpOwogZXh0ZXJuIGludCB1ZHA2X2dldF9p
bmZvKGNoYXIgKiwgY2hhciAqKiwgb2ZmX3QsIGludCk7CkBAIC0zODAsNiArMzgxLDkgQEAKIAkv
KiBGcmVlIG1jIGxpc3RzICovCiAJaXB2Nl9zb2NrX21jX2Nsb3NlKHNrKTsKIAorCS8qIEZyZWUg
YWMgbGlzdHMgKi8KKwlpcHY2X3NvY2tfYWNfY2xvc2Uoc2spOworCiAJcmV0dXJuIGluZXRfcmVs
ZWFzZShzb2NrKTsKIH0KIApAQCAtNjk0LDYgKzY5OCw4IEBACiAJCWdvdG8gcHJvY19zb2Nrc3Rh
dDZfZmFpbDsKIAlpZiAoIXByb2NfbmV0X2NyZWF0ZSgic25tcDYiLCAwLCBhZmluZXQ2X2dldF9z
bm1wKSkKIAkJZ290byBwcm9jX3NubXA2X2ZhaWw7CisJaWYgKCFwcm9jX25ldF9jcmVhdGUoImFu
eWNhc3Q2IiwgMCwgYW55Y2FzdDZfZ2V0X2luZm8pKQorCQlnb3RvIHByb2NfYW55Y2FzdDZfZmFp
bDsKICNlbmRpZgogCWlwdjZfbmV0ZGV2X25vdGlmX2luaXQoKTsKIAlpcHY2X3BhY2tldF9pbml0
KCk7CkBAIC03MDksNiArNzE1LDggQEAKIAlyZXR1cm4gMDsKIAogI2lmZGVmIENPTkZJR19QUk9D
X0ZTCitwcm9jX2FueWNhc3Q2X2ZhaWw6CisJcHJvY19uZXRfcmVtb3ZlKCJhbnljYXN0NiIpOwog
cHJvY19zbm1wNl9mYWlsOgogCXByb2NfbmV0X3JlbW92ZSgic29ja3N0YXQ2Iik7CiBwcm9jX3Nv
Y2tzdGF0Nl9mYWlsOgpAQCAtNzQ0LDYgKzc1Miw3IEBACiAJcHJvY19uZXRfcmVtb3ZlKCJ1ZHA2
Iik7CiAJcHJvY19uZXRfcmVtb3ZlKCJzb2Nrc3RhdDYiKTsKIAlwcm9jX25ldF9yZW1vdmUoInNu
bXA2Iik7CisJcHJvY19uZXRfcmVtb3ZlKCJhbnljYXN0NiIpOwogI2VuZGlmCiAJLyogQ2xlYW51
cCBjb2RlIHBhcnRzLiAqLwogCXNpdF9jbGVhbnVwKCk7CmRpZmYgLXJ1TiBsaW51eC0yLjUuNDQv
bmV0L2lwdjYvYW55Y2FzdC5jIGxpbnV4LTIuNS40NEFDL25ldC9pcHY2L2FueWNhc3QuYwotLS0g
bGludXgtMi41LjQ0L25ldC9pcHY2L2FueWNhc3QuYwlXZWQgRGVjIDMxIDE2OjAwOjAwIDE5NjkK
KysrIGxpbnV4LTIuNS40NEFDL25ldC9pcHY2L2FueWNhc3QuYwlNb24gT2N0IDI4IDEzOjI4OjA3
IDIwMDIKQEAgLTAsMCArMSw0ODkgQEAKKy8qCisgKglBbnljYXN0IHN1cHBvcnQgZm9yIElQdjYK
KyAqCUxpbnV4IElORVQ2IGltcGxlbWVudGF0aW9uIAorICoKKyAqCUF1dGhvcnM6CisgKglEYXZp
ZCBMIFN0ZXZlbnMgKGRsc3RldmVuc0B1cy5pYm0uY29tKQorICoKKyAqCWJhc2VkIGhlYXZpbHkg
b24gbmV0L2lwdjYvbWNhc3QuYworICoKKyAqCVRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJl
OyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IKKyAqICAgICAgbW9kaWZ5IGl0IHVuZGVy
IHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKKyAqICAgICAgYXMg
cHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9u
CisgKiAgICAgIDIgb2YgdGhlIExpY2Vuc2UsIG9yIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVy
IHZlcnNpb24uCisgKi8KKworI2luY2x1ZGUgPGxpbnV4L2NvbmZpZy5oPgorI2luY2x1ZGUgPGxp
bnV4L21vZHVsZS5oPgorI2luY2x1ZGUgPGxpbnV4L2Vycm5vLmg+CisjaW5jbHVkZSA8bGludXgv
dHlwZXMuaD4KKyNpbmNsdWRlIDxsaW51eC9yYW5kb20uaD4KKyNpbmNsdWRlIDxsaW51eC9zdHJp
bmcuaD4KKyNpbmNsdWRlIDxsaW51eC9zb2NrZXQuaD4KKyNpbmNsdWRlIDxsaW51eC9zb2NraW9z
Lmg+CisjaW5jbHVkZSA8bGludXgvc2NoZWQuaD4KKyNpbmNsdWRlIDxsaW51eC9uZXQuaD4KKyNp
bmNsdWRlIDxsaW51eC9pbjYuaD4KKyNpbmNsdWRlIDxsaW51eC9uZXRkZXZpY2UuaD4KKyNpbmNs
dWRlIDxsaW51eC9pZl9hcnAuaD4KKyNpbmNsdWRlIDxsaW51eC9yb3V0ZS5oPgorI2luY2x1ZGUg
PGxpbnV4L2luaXQuaD4KKyNpbmNsdWRlIDxsaW51eC9wcm9jX2ZzLmg+CisKKyNpbmNsdWRlIDxu
ZXQvc29jay5oPgorI2luY2x1ZGUgPG5ldC9zbm1wLmg+CisKKyNpbmNsdWRlIDxuZXQvaXB2Ni5o
PgorI2luY2x1ZGUgPG5ldC9wcm90b2NvbC5oPgorI2luY2x1ZGUgPG5ldC9pZl9pbmV0Ni5oPgor
I2luY2x1ZGUgPG5ldC9uZGlzYy5oPgorI2luY2x1ZGUgPG5ldC9hZGRyY29uZi5oPgorI2luY2x1
ZGUgPG5ldC9pcDZfcm91dGUuaD4KKworI2luY2x1ZGUgPG5ldC9jaGVja3N1bS5oPgorCisvKiBC
aWcgYWMgbGlzdCBsb2NrIGZvciBhbGwgdGhlIHNvY2tldHMgKi8KK3N0YXRpYyByd2xvY2tfdCBp
cHY2X3NrX2FjX2xvY2sgPSBSV19MT0NLX1VOTE9DS0VEOworCisvKiBYWFggaXA2X2FkZHJfbWF0
Y2goKSBhbmQgaXA2X29ubGluaygpIHJlYWxseSBiZWxvbmcgaW4gbmV0L2NvcmUuYyAqLworCitz
dGF0aWMgaW50CitpcDZfYWRkcl9tYXRjaChzdHJ1Y3QgaW42X2FkZHIgKmFkZHIxLCBzdHJ1Y3Qg
aW42X2FkZHIgKmFkZHIyLCBpbnQgcHJlZml4KQoreworCV9fdTMyCW1hc2s7CisJaW50CWk7CisK
KwlpZiAocHJlZml4ID4gMTI4IHx8IHByZWZpeCA8IDApCisJCXJldHVybiAwOworCWlmIChwcmVm
aXggPT0gMCkKKwkJcmV0dXJuIDE7CisJZm9yIChpPTA7IGk8NDsgKytpKSB7CisJCWlmIChwcmVm
aXggPj0gMzIpCisJCQltYXNrID0gfjA7CisJCWVsc2UKKwkJCW1hc2sgPSBodG9ubCh+MCA8PCAo
MzIgLSBwcmVmaXgpKTsKKwkJaWYgKChhZGRyMS0+czZfYWRkcjMyW2ldIF4gYWRkcjItPnM2X2Fk
ZHIzMltpXSkgJiBtYXNrKQorCQkJcmV0dXJuIDA7CisJCXByZWZpeCAtPSAzMjsKKwkJaWYgKHBy
ZWZpeCA8PSAwKQorCQkJYnJlYWs7CisJfQorCXJldHVybiAxOworfQorCitzdGF0aWMgaW50Citp
cDZfb25saW5rKHN0cnVjdCBpbjZfYWRkciAqYWRkciwgc3RydWN0IG5ldF9kZXZpY2UgKmRldikK
K3sKKwlzdHJ1Y3QgaW5ldDZfZGV2CSppZGV2OworCXN0cnVjdCBpbmV0Nl9pZmFkZHIJKmlmYTsK
KwlpbnQJb25saW5rOworCisJb25saW5rID0gMDsKKwlyZWFkX2xvY2soJmFkZHJjb25mX2xvY2sp
OworCWlkZXYgPSBfX2luNl9kZXZfZ2V0KGRldik7CisJaWYgKGlkZXYpIHsKKwkJcmVhZF9sb2Nr
X2JoKCZpZGV2LT5sb2NrKTsKKwkJZm9yIChpZmE9aWRldi0+YWRkcl9saXN0OyBpZmE7IGlmYT1p
ZmEtPmlmX25leHQpIHsKKwkJCW9ubGluayA9IGlwNl9hZGRyX21hdGNoKGFkZHIsICZpZmEtPmFk
ZHIsCisJCQkJCWlmYS0+cHJlZml4X2xlbik7CisJCQlpZiAob25saW5rKQorCQkJCWJyZWFrOwor
CQl9CisJCXJlYWRfdW5sb2NrX2JoKCZpZGV2LT5sb2NrKTsKKwl9CisJcmVhZF91bmxvY2soJmFk
ZHJjb25mX2xvY2spOworCXJldHVybiBvbmxpbms7Cit9CisKKworLyoKKyAqCXNvY2tldCBqb2lu
IGFuIGFueWNhc3QgZ3JvdXAKKyAqLworCitpbnQgaXB2Nl9zb2NrX2FjX2pvaW4oc3RydWN0IHNv
Y2sgKnNrLCBpbnQgaWZpbmRleCwgc3RydWN0IGluNl9hZGRyICphZGRyKQoreworCXN0cnVjdCBp
cHY2X3BpbmZvICpucCA9IGluZXQ2X3NrKHNrKTsKKwlzdHJ1Y3QgbmV0X2RldmljZSAqZGV2ID0g
TlVMTDsKKwlzdHJ1Y3QgaW5ldDZfZGV2ICppZGV2OworCXN0cnVjdCBpcHY2X2FjX3NvY2tsaXN0
ICpwYWM7CisJaW50CWlzaG9zdCA9ICFpcHY2X2RldmNvbmYuZm9yd2FyZGluZzsKKwlpbnQJZXJy
ID0gMDsKKworCWlmIChpcHY2X2FkZHJfdHlwZShhZGRyKSAmIElQVjZfQUREUl9NVUxUSUNBU1Qp
CisJCXJldHVybiAtRUlOVkFMOworCisJcGFjID0gc29ja19rbWFsbG9jKHNrLCBzaXplb2Yoc3Ry
dWN0IGlwdjZfYWNfc29ja2xpc3QpLCBHRlBfS0VSTkVMKTsKKwlpZiAocGFjID09IE5VTEwpCisJ
CXJldHVybiAtRU5PTUVNOworCXBhYy0+YWNsX25leHQgPSBOVUxMOworCWlwdjZfYWRkcl9jb3B5
KCZwYWMtPmFjbF9hZGRyLCBhZGRyKTsKKworCWlmIChpZmluZGV4ID09IDApIHsKKwkJc3RydWN0
IHJ0Nl9pbmZvICpydDsKKworCQlydCA9IHJ0Nl9sb29rdXAoYWRkciwgTlVMTCwgMCwgMCk7CisJ
CWlmIChydCkgeworCQkJZGV2ID0gcnQtPnJ0NmlfZGV2OworCQkJZGV2X2hvbGQoZGV2KTsKKwkJ
CWRzdF9yZWxlYXNlKCZydC0+dS5kc3QpOworCQl9IGVsc2UgaWYgKGlzaG9zdCkgeworCQkJc29j
a19rZnJlZV9zKHNrLCBwYWMsIHNpemVvZigqcGFjKSk7CisJCQlyZXR1cm4gLUVBRERSTk9UQVZB
SUw7CisJCX0gZWxzZSB7CisJCQkvKiByb3V0ZXIsIG5vIG1hdGNoaW5nIGludGVyZmFjZToganVz
dCBwaWNrIG9uZSAqLworCisJCQlkZXYgPSBkZXZfZ2V0YW55KElGRl9VUCwgSUZGX1VQfElGRl9M
T09QQkFDSyk7CisJCX0KKwl9IGVsc2UKKwkJZGV2ID0gZGV2X2dldF9ieV9pbmRleChpZmluZGV4
KTsKKworCWlmIChkZXYgPT0gTlVMTCkgeworCQlzb2NrX2tmcmVlX3Moc2ssIHBhYywgc2l6ZW9m
KCpwYWMpKTsKKwkJcmV0dXJuIC1FTk9ERVY7CisJfQorCisJaWRldiA9IGluNl9kZXZfZ2V0KGRl
dik7CisJaWYgKCFpZGV2KSB7CisJCXNvY2tfa2ZyZWVfcyhzaywgcGFjLCBzaXplb2YoKnBhYykp
OworCQlkZXZfcHV0KGRldik7CisJCWlmIChpZmluZGV4KQorCQkJcmV0dXJuIC1FTk9ERVY7CisJ
CWVsc2UKKwkJCXJldHVybiAtRUFERFJOT1RBVkFJTDsKKwl9CisJLyogcmVzZXQgaXNob3N0LCBu
b3cgdGhhdCB3ZSBoYXZlIGEgc3BlY2lmaWMgZGV2aWNlICovCisJaXNob3N0ID0gIWlkZXYtPmNu
Zi5mb3J3YXJkaW5nOworCWluNl9kZXZfcHV0KGlkZXYpOworCisJcGFjLT5hY2xfaWZpbmRleCA9
IGRldi0+aWZpbmRleDsKKworCS8qIFhYWAorCSAqIEZvciBob3N0cywgYWxsb3cgbGluay1sb2Nh
bCBvciBtYXRjaGluZyBwcmVmaXggYW55Y2FzdHMuCisJICogVGhpcyBvYnZpYXRlcyB0aGUgbmVl
ZCBmb3IgcHJvcGFnYXRpbmcgYW55Y2FzdCByb3V0ZXMgd2hpbGUKKwkgKiBzdGlsbCBhbGxvd2lu
ZyBzb21lIG5vbi1yb3V0ZXIgYW55Y2FzdCBwYXJ0aWNpcGF0aW9uLgorCSAqCisJICogYWxsb3cg
YW55b25lIHRvIGpvaW4gYW55Y2FzdHMgdGhhdCBkb24ndCByZXF1aXJlIGEgc3BlY2lhbCByb3V0
ZQorCSAqIGFuZCBjYW4ndCBiZSBzcG9vZnMgb2YgdW5pY2FzdCBhZGRyZXNzZXMgKHJlc2VydmVk
IGFueWNhc3Qgb25seSkKKwkgKi8KKwlpZiAoIWlwNl9vbmxpbmsoYWRkciwgZGV2KSkgeworCQlp
ZiAoaXNob3N0KQorCQkJZXJyID0gLUVBRERSTk9UQVZBSUw7CisJCWVsc2UgaWYgKCFjYXBhYmxl
KENBUF9ORVRfQURNSU4pKQorCQkJZXJyID0gLUVQRVJNOworCQlpZiAoZXJyKSB7CisJCQlzb2Nr
X2tmcmVlX3Moc2ssIHBhYywgc2l6ZW9mKCpwYWMpKTsKKwkJCWRldl9wdXQoZGV2KTsKKwkJCXJl
dHVybiBlcnI7CisJCX0KKwl9IGVsc2UgaWYgKCEoaXB2Nl9hZGRyX3R5cGUoYWRkcikgJiBJUFY2
X0FERFJfQU5ZQ0FTVCkgJiYKKwkJICAgIWNhcGFibGUoQ0FQX05FVF9BRE1JTikpCisJCXJldHVy
biAtRVBFUk07CisKKwllcnIgPSBpcHY2X2Rldl9hY19pbmMoZGV2LCBhZGRyKTsKKwlpZiAoZXJy
KSB7CisJCXNvY2tfa2ZyZWVfcyhzaywgcGFjLCBzaXplb2YoKnBhYykpOworCQlkZXZfcHV0KGRl
dik7CisJCXJldHVybiBlcnI7CisJfQorCisJd3JpdGVfbG9ja19iaCgmaXB2Nl9za19hY19sb2Nr
KTsKKwlwYWMtPmFjbF9uZXh0ID0gbnAtPmlwdjZfYWNfbGlzdDsKKwlucC0+aXB2Nl9hY19saXN0
ID0gcGFjOworCXdyaXRlX3VubG9ja19iaCgmaXB2Nl9za19hY19sb2NrKTsKKworCWRldl9wdXQo
ZGV2KTsKKworCXJldHVybiAwOworfQorCisvKgorICoJc29ja2V0IGxlYXZlIGFuIGFueWNhc3Qg
Z3JvdXAKKyAqLworaW50IGlwdjZfc29ja19hY19kcm9wKHN0cnVjdCBzb2NrICpzaywgaW50IGlm
aW5kZXgsIHN0cnVjdCBpbjZfYWRkciAqYWRkcikKK3sKKwlzdHJ1Y3QgaXB2Nl9waW5mbyAqbnAg
PSBpbmV0Nl9zayhzayk7CisJc3RydWN0IG5ldF9kZXZpY2UgKmRldjsKKwlzdHJ1Y3QgaXB2Nl9h
Y19zb2NrbGlzdCAqcGFjLCAqcHJldl9wYWM7CisKKwl3cml0ZV9sb2NrX2JoKCZpcHY2X3NrX2Fj
X2xvY2spOworCXByZXZfcGFjID0gMDsKKwlmb3IgKHBhYyA9IG5wLT5pcHY2X2FjX2xpc3Q7IHBh
YzsgcGFjID0gcGFjLT5hY2xfbmV4dCkgeworCQlpZiAoKGlmaW5kZXggPT0gMCB8fCBwYWMtPmFj
bF9pZmluZGV4ID09IGlmaW5kZXgpICYmCisJCSAgICAgaXB2Nl9hZGRyX2NtcCgmcGFjLT5hY2xf
YWRkciwgYWRkcikgPT0gMCkKKwkJCWJyZWFrOworCQlwcmV2X3BhYyA9IHBhYzsKKwl9CisJaWYg
KCFwYWMpIHsKKwkJd3JpdGVfdW5sb2NrX2JoKCZpcHY2X3NrX2FjX2xvY2spOworCQlyZXR1cm4g
LUVOT0VOVDsKKwl9CisJaWYgKHByZXZfcGFjKQorCQlwcmV2X3BhYy0+YWNsX25leHQgPSBwYWMt
PmFjbF9uZXh0OworCWVsc2UKKwkJbnAtPmlwdjZfYWNfbGlzdCA9IHBhYy0+YWNsX25leHQ7CisK
Kwl3cml0ZV91bmxvY2tfYmgoJmlwdjZfc2tfYWNfbG9jayk7CisKKwlkZXYgPSBkZXZfZ2V0X2J5
X2luZGV4KHBhYy0+YWNsX2lmaW5kZXgpOworCWlmIChkZXYpIHsKKwkJaXB2Nl9kZXZfYWNfZGVj
KGRldiwgJnBhYy0+YWNsX2FkZHIpOworCQlkZXZfcHV0KGRldik7CisJfQorCXNvY2tfa2ZyZWVf
cyhzaywgcGFjLCBzaXplb2YoKnBhYykpOworCXJldHVybiAwOworfQorCit2b2lkIGlwdjZfc29j
a19hY19jbG9zZShzdHJ1Y3Qgc29jayAqc2spCit7CisJc3RydWN0IGlwdjZfcGluZm8gKm5wID0g
aW5ldDZfc2soc2spOworCXN0cnVjdCBuZXRfZGV2aWNlICpkZXYgPSAwOworCXN0cnVjdCBpcHY2
X2FjX3NvY2tsaXN0ICpwYWM7CisJaW50CXByZXZfaW5kZXg7CisKKwl3cml0ZV9sb2NrX2JoKCZp
cHY2X3NrX2FjX2xvY2spOworCXBhYyA9IG5wLT5pcHY2X2FjX2xpc3Q7CisJbnAtPmlwdjZfYWNf
bGlzdCA9IDA7CisJd3JpdGVfdW5sb2NrX2JoKCZpcHY2X3NrX2FjX2xvY2spOworCisJcHJldl9p
bmRleCA9IDA7CisJd2hpbGUgKHBhYykgeworCQlzdHJ1Y3QgaXB2Nl9hY19zb2NrbGlzdCAqbmV4
dCA9IHBhYy0+YWNsX25leHQ7CisKKwkJaWYgKHBhYy0+YWNsX2lmaW5kZXggIT0gcHJldl9pbmRl
eCkgeworCQkJaWYgKGRldikKKwkJCQlkZXZfcHV0KGRldik7CisJCQlkZXYgPSBkZXZfZ2V0X2J5
X2luZGV4KHBhYy0+YWNsX2lmaW5kZXgpOworCQkJcHJldl9pbmRleCA9IHBhYy0+YWNsX2lmaW5k
ZXg7CisJCX0KKwkJaWYgKGRldikKKwkJCWlwdjZfZGV2X2FjX2RlYyhkZXYsICZwYWMtPmFjbF9h
ZGRyKTsKKwkJc29ja19rZnJlZV9zKHNrLCBwYWMsIHNpemVvZigqcGFjKSk7CisJCXBhYyA9IG5l
eHQ7CisJfQorCWlmIChkZXYpCisJCWRldl9wdXQoZGV2KTsKK30KKworaW50IGluZXQ2X2FjX2No
ZWNrKHN0cnVjdCBzb2NrICpzaywgc3RydWN0IGluNl9hZGRyICphZGRyLCBpbnQgaWZpbmRleCkK
K3sKKwlzdHJ1Y3QgaXB2Nl9hY19zb2NrbGlzdCAqcGFjOworCXN0cnVjdCBpcHY2X3BpbmZvICpu
cCA9IGluZXQ2X3NrKHNrKTsKKwlpbnQJZm91bmQ7CisKKwlmb3VuZCA9IDA7CisJcmVhZF9sb2Nr
KCZpcHY2X3NrX2FjX2xvY2spOworCWZvciAocGFjPW5wLT5pcHY2X2FjX2xpc3Q7IHBhYzsgcGFj
PXBhYy0+YWNsX25leHQpIHsKKwkJaWYgKGlmaW5kZXggJiYgcGFjLT5hY2xfaWZpbmRleCAhPSBp
ZmluZGV4KQorCQkJY29udGludWU7CisJCWZvdW5kID0gaXB2Nl9hZGRyX2NtcCgmcGFjLT5hY2xf
YWRkciwgYWRkcikgPT0gMDsKKwkJaWYgKGZvdW5kKQorCQkJYnJlYWs7CisJfQorCXJlYWRfdW5s
b2NrKCZpcHY2X3NrX2FjX2xvY2spOworCisJcmV0dXJuIGZvdW5kOworfQorCitzdGF0aWMgdm9p
ZCBhY2FfcHV0KHN0cnVjdCBpZmFjYWRkcjYgKmFjKQoreworCWlmIChhdG9taWNfZGVjX2FuZF90
ZXN0KCZhYy0+YWNhX3JlZmNudCkpIHsKKwkJaW42X2Rldl9wdXQoYWMtPmFjYV9pZGV2KTsKKwkJ
a2ZyZWUoYWMpOworCX0KK30KKworLyoKKyAqCWRldmljZSBhbnljYXN0IGdyb3VwIGluYyAoYWRk
IGlmIG5vdCBmb3VuZCkKKyAqLworaW50IGlwdjZfZGV2X2FjX2luYyhzdHJ1Y3QgbmV0X2Rldmlj
ZSAqZGV2LCBzdHJ1Y3QgaW42X2FkZHIgKmFkZHIpCit7CisJc3RydWN0IGlmYWNhZGRyNiAqYWNh
OworCXN0cnVjdCBpbmV0Nl9kZXYgKmlkZXY7CisKKwlpZGV2ID0gaW42X2Rldl9nZXQoZGV2KTsK
KworCWlmIChpZGV2ID09IE5VTEwpCisJCXJldHVybiAtRUlOVkFMOworCisJd3JpdGVfbG9ja19i
aCgmaWRldi0+bG9jayk7CisJaWYgKGlkZXYtPmRlYWQpIHsKKwkJd3JpdGVfdW5sb2NrX2JoKCZp
ZGV2LT5sb2NrKTsKKwkJaW42X2Rldl9wdXQoaWRldik7CisJCXJldHVybiAtRU5PREVWOworCX0K
KworCWZvciAoYWNhID0gaWRldi0+YWNfbGlzdDsgYWNhOyBhY2EgPSBhY2EtPmFjYV9uZXh0KSB7
CisJCWlmIChpcHY2X2FkZHJfY21wKCZhY2EtPmFjYV9hZGRyLCBhZGRyKSA9PSAwKSB7CisJCQlh
Y2EtPmFjYV91c2VycysrOworCQkJd3JpdGVfdW5sb2NrX2JoKCZpZGV2LT5sb2NrKTsKKwkJCWlu
Nl9kZXZfcHV0KGlkZXYpOworCQkJcmV0dXJuIDA7CisJCX0KKwl9CisKKwkvKgorCSAqCW5vdCBm
b3VuZDogY3JlYXRlIGEgbmV3IG9uZS4KKwkgKi8KKworCWFjYSA9IGttYWxsb2Moc2l6ZW9mKHN0
cnVjdCBpZmFjYWRkcjYpLCBHRlBfQVRPTUlDKTsKKworCWlmIChhY2EgPT0gTlVMTCkgeworCQl3
cml0ZV91bmxvY2tfYmgoJmlkZXYtPmxvY2spOworCQlpbjZfZGV2X3B1dChpZGV2KTsKKwkJcmV0
dXJuIC1FTk9NRU07CisJfQorCisJbWVtc2V0KGFjYSwgMCwgc2l6ZW9mKHN0cnVjdCBpZmFjYWRk
cjYpKTsKKworCWlwdjZfYWRkcl9jb3B5KCZhY2EtPmFjYV9hZGRyLCBhZGRyKTsKKwlhY2EtPmFj
YV9pZGV2ID0gaWRldjsKKwlhY2EtPmFjYV91c2VycyA9IDE7CisJYXRvbWljX3NldCgmYWNhLT5h
Y2FfcmVmY250LCAyKTsKKwlhY2EtPmFjYV9sb2NrID0gU1BJTl9MT0NLX1VOTE9DS0VEOworCisJ
YWNhLT5hY2FfbmV4dCA9IGlkZXYtPmFjX2xpc3Q7CisJaWRldi0+YWNfbGlzdCA9IGFjYTsKKwl3
cml0ZV91bmxvY2tfYmgoJmlkZXYtPmxvY2spOworCisJaXA2X3J0X2FkZHJfYWRkKCZhY2EtPmFj
YV9hZGRyLCBkZXYpOworCisJYWRkcmNvbmZfam9pbl9zb2xpY3QoZGV2LCAmYWNhLT5hY2FfYWRk
cik7CisKKwlhY2FfcHV0KGFjYSk7CisJcmV0dXJuIDA7Cit9CisKKy8qCisgKglkZXZpY2UgYW55
Y2FzdCBncm91cCBkZWNyZW1lbnQKKyAqLworaW50IGlwdjZfZGV2X2FjX2RlYyhzdHJ1Y3QgbmV0
X2RldmljZSAqZGV2LCBzdHJ1Y3QgaW42X2FkZHIgKmFkZHIpCit7CisJc3RydWN0IGluZXQ2X2Rl
diAqaWRldjsKKwlzdHJ1Y3QgaWZhY2FkZHI2ICphY2EsICpwcmV2X2FjYTsKKworCWlkZXYgPSBp
bjZfZGV2X2dldChkZXYpOworCWlmIChpZGV2ID09IE5VTEwpCisJCXJldHVybiAtRU5PREVWOwor
CisJd3JpdGVfbG9ja19iaCgmaWRldi0+bG9jayk7CisJcHJldl9hY2EgPSAwOworCWZvciAoYWNh
ID0gaWRldi0+YWNfbGlzdDsgYWNhOyBhY2EgPSBhY2EtPmFjYV9uZXh0KSB7CisJCWlmIChpcHY2
X2FkZHJfY21wKCZhY2EtPmFjYV9hZGRyLCBhZGRyKSA9PSAwKQorCQkJYnJlYWs7CisJCXByZXZf
YWNhID0gYWNhOworCX0KKwlpZiAoIWFjYSkgeworCQl3cml0ZV91bmxvY2tfYmgoJmlkZXYtPmxv
Y2spOworCQlpbjZfZGV2X3B1dChpZGV2KTsKKwkJcmV0dXJuIC1FTk9FTlQ7CisJfQorCWlmICgt
LWFjYS0+YWNhX3VzZXJzID4gMCkgeworCQl3cml0ZV91bmxvY2tfYmgoJmlkZXYtPmxvY2spOwor
CQlpbjZfZGV2X3B1dChpZGV2KTsKKwkJcmV0dXJuIDA7CisJfQorCWlmIChwcmV2X2FjYSkKKwkJ
cHJldl9hY2EtPmFjYV9uZXh0ID0gYWNhLT5hY2FfbmV4dDsKKwllbHNlCisJCWlkZXYtPmFjX2xp
c3QgPSBhY2EtPmFjYV9uZXh0OworCXdyaXRlX3VubG9ja19iaCgmaWRldi0+bG9jayk7CisJYWRk
cmNvbmZfbGVhdmVfc29saWN0KGRldiwgJmFjYS0+YWNhX2FkZHIpOworCisJaXA2X3J0X2FkZHJf
ZGVsKCZhY2EtPmFjYV9hZGRyLCBkZXYpOworCisJYWNhX3B1dChhY2EpOworCWluNl9kZXZfcHV0
KGlkZXYpOworCXJldHVybiAwOworfQorCisvKgorICoJY2hlY2sgaWYgdGhlIGludGVyZmFjZSBo
YXMgdGhpcyBhbnljYXN0IGFkZHJlc3MKKyAqLworc3RhdGljIGludCBpcHY2X2Noa19hY2FzdF9k
ZXYoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgc3RydWN0IGluNl9hZGRyICphZGRyKQoreworCXN0
cnVjdCBpbmV0Nl9kZXYgKmlkZXY7CisJc3RydWN0IGlmYWNhZGRyNiAqYWNhOworCisJaWRldiA9
IGluNl9kZXZfZ2V0KGRldik7CisJaWYgKGlkZXYpIHsKKwkJcmVhZF9sb2NrX2JoKCZpZGV2LT5s
b2NrKTsKKwkJZm9yIChhY2EgPSBpZGV2LT5hY19saXN0OyBhY2E7IGFjYSA9IGFjYS0+YWNhX25l
eHQpCisJCQlpZiAoaXB2Nl9hZGRyX2NtcCgmYWNhLT5hY2FfYWRkciwgYWRkcikgPT0gMCkKKwkJ
CQlicmVhazsKKwkJcmVhZF91bmxvY2tfYmgoJmlkZXYtPmxvY2spOworCQlpbjZfZGV2X3B1dChp
ZGV2KTsKKwkJcmV0dXJuIGFjYSAhPSAwOworCX0KKwlyZXR1cm4gMDsKK30KKworLyoKKyAqCWNo
ZWNrIGlmIGdpdmVuIGludGVyZmFjZSAob3IgYW55LCBpZiBkZXY9PTApIGhhcyB0aGlzIGFueWNh
c3QgYWRkcmVzcworICovCitpbnQgaXB2Nl9jaGtfYWNhc3RfYWRkcihzdHJ1Y3QgbmV0X2Rldmlj
ZSAqZGV2LCBzdHJ1Y3QgaW42X2FkZHIgKmFkZHIpCit7CisJaWYgKGRldikKKwkJcmV0dXJuIGlw
djZfY2hrX2FjYXN0X2RldihkZXYsIGFkZHIpOworCXJlYWRfbG9jaygmZGV2X2Jhc2VfbG9jayk7
CisJZm9yIChkZXY9ZGV2X2Jhc2U7IGRldjsgZGV2PWRldi0+bmV4dCkKKwkJaWYgKGlwdjZfY2hr
X2FjYXN0X2RldihkZXYsIGFkZHIpKQorCQkJYnJlYWs7CisJcmVhZF91bmxvY2soJmRldl9iYXNl
X2xvY2spOworCXJldHVybiBkZXYgIT0gMDsKK30KKworCisjaWZkZWYgQ09ORklHX1BST0NfRlMK
K2ludCBhbnljYXN0Nl9nZXRfaW5mbyhjaGFyICpidWZmZXIsIGNoYXIgKipzdGFydCwgb2ZmX3Qg
b2Zmc2V0LCBpbnQgbGVuZ3RoKQoreworCW9mZl90IHBvcz0wLCBiZWdpbj0wOworCXN0cnVjdCBp
ZmFjYWRkcjYgKmltOworCWludCBsZW49MDsKKwlzdHJ1Y3QgbmV0X2RldmljZSAqZGV2OworCQor
CXJlYWRfbG9jaygmZGV2X2Jhc2VfbG9jayk7CisJZm9yIChkZXYgPSBkZXZfYmFzZTsgZGV2OyBk
ZXYgPSBkZXYtPm5leHQpIHsKKwkJc3RydWN0IGluZXQ2X2RldiAqaWRldjsKKworCQlpZiAoKGlk
ZXYgPSBpbjZfZGV2X2dldChkZXYpKSA9PSBOVUxMKQorCQkJY29udGludWU7CisKKwkJcmVhZF9s
b2NrX2JoKCZpZGV2LT5sb2NrKTsKKwkJZm9yIChpbSA9IGlkZXYtPmFjX2xpc3Q7IGltOyBpbSA9
IGltLT5hY2FfbmV4dCkgeworCQkJaW50IGk7CisKKwkJCWxlbiArPSBzcHJpbnRmKGJ1ZmZlcits
ZW4sIiUtNGQgJS0xNXMgIiwgZGV2LT5pZmluZGV4LCBkZXYtPm5hbWUpOworCisJCQlmb3IgKGk9
MDsgaTwxNjsgaSsrKQorCQkJCWxlbiArPSBzcHJpbnRmKGJ1ZmZlcitsZW4sICIlMDJ4IiwgaW0t
PmFjYV9hZGRyLnM2X2FkZHJbaV0pOworCisJCQlsZW4gKz0gc3ByaW50ZihidWZmZXIrbGVuLCAi
ICU1ZFxuIiwgaW0tPmFjYV91c2Vycyk7CisKKwkJCXBvcz1iZWdpbitsZW47CisJCQlpZiAocG9z
IDwgb2Zmc2V0KSB7CisJCQkJbGVuPTA7CisJCQkJYmVnaW49cG9zOworCQkJfQorCQkJaWYgKHBv
cyA+IG9mZnNldCtsZW5ndGgpIHsKKwkJCQlyZWFkX3VubG9ja19iaCgmaWRldi0+bG9jayk7CisJ
CQkJaW42X2Rldl9wdXQoaWRldik7CisJCQkJZ290byBkb25lOworCQkJfQorCQl9CisJCXJlYWRf
dW5sb2NrX2JoKCZpZGV2LT5sb2NrKTsKKwkJaW42X2Rldl9wdXQoaWRldik7CisJfQorCitkb25l
OgorCXJlYWRfdW5sb2NrKCZkZXZfYmFzZV9sb2NrKTsKKworCSpzdGFydD1idWZmZXIrKG9mZnNl
dC1iZWdpbik7CisJbGVuLT0ob2Zmc2V0LWJlZ2luKTsKKwlpZihsZW4+bGVuZ3RoKQorCQlsZW49
bGVuZ3RoOworCWlmIChsZW48MCkKKwkJbGVuPTA7CisJcmV0dXJuIGxlbjsKK30KKworI2VuZGlm
CmRpZmYgLXJ1TiBsaW51eC0yLjUuNDQvbmV0L2lwdjYvaWNtcC5jIGxpbnV4LTIuNS40NEFDL25l
dC9pcHY2L2ljbXAuYwotLS0gbGludXgtMi41LjQ0L25ldC9pcHY2L2ljbXAuYwlGcmkgT2N0IDE4
IDIxOjAxOjIwIDIwMDIKKysrIGxpbnV4LTIuNS40NEFDL25ldC9pcHY2L2ljbXAuYwlNb24gT2N0
IDI4IDEyOjM4OjA5IDIwMDIKQEAgLTM4OCw3ICszODgsOCBAQAogCiAJc2FkZHIgPSAmc2tiLT5u
aC5pcHY2aC0+ZGFkZHI7CiAKLQlpZiAoaXB2Nl9hZGRyX3R5cGUoc2FkZHIpICYgSVBWNl9BRERS
X01VTFRJQ0FTVCkKKwlpZiAoaXB2Nl9hZGRyX3R5cGUoc2FkZHIpICYgSVBWNl9BRERSX01VTFRJ
Q0FTVCB8fAorCSAgICBpcHY2X2Noa19hY2FzdF9hZGRyKDAsIHNhZGRyKSkgCiAJCXNhZGRyID0g
TlVMTDsKIAogCW1zZy5pY21waC5pY21wNl90eXBlID0gSUNNUFY2X0VDSE9fUkVQTFk7CmRpZmYg
LXJ1TiBsaW51eC0yLjUuNDQvbmV0L2lwdjYvaXB2Nl9zb2NrZ2x1ZS5jIGxpbnV4LTIuNS40NEFD
L25ldC9pcHY2L2lwdjZfc29ja2dsdWUuYwotLS0gbGludXgtMi41LjQ0L25ldC9pcHY2L2lwdjZf
c29ja2dsdWUuYwlGcmkgT2N0IDE4IDIxOjAxOjA5IDIwMDIKKysrIGxpbnV4LTIuNS40NEFDL25l
dC9pcHY2L2lwdjZfc29ja2dsdWUuYwlNb24gT2N0IDI4IDEyOjM4OjA5IDIwMDIKQEAgLTM1MSw2
ICszNTEsMjQgQEAKIAkJCXJldHYgPSBpcHY2X3NvY2tfbWNfZHJvcChzaywgbXJlcS5pcHY2bXJf
aWZpbmRleCwgJm1yZXEuaXB2Nm1yX211bHRpYWRkcik7CiAJCWJyZWFrOwogCX0KKwljYXNlIElQ
VjZfSk9JTl9BTllDQVNUOgorCWNhc2UgSVBWNl9MRUFWRV9BTllDQVNUOgorCXsKKwkJc3RydWN0
IGlwdjZfbXJlcSBtcmVxOworCisJCWlmIChvcHRsZW4gIT0gc2l6ZW9mKHN0cnVjdCBpcHY2X21y
ZXEpKQorCQkJZ290byBlX2ludmFsOworCisJCXJldHYgPSAtRUZBVUxUOworCQlpZiAoY29weV9m
cm9tX3VzZXIoJm1yZXEsIG9wdHZhbCwgc2l6ZW9mKHN0cnVjdCBpcHY2X21yZXEpKSkKKwkJCWJy
ZWFrOworCisJCWlmIChvcHRuYW1lID09IElQVjZfSk9JTl9BTllDQVNUKQorCQkJcmV0diA9IGlw
djZfc29ja19hY19qb2luKHNrLCBtcmVxLmlwdjZtcl9pZmluZGV4LCAmbXJlcS5pcHY2bXJfYWNh
ZGRyKTsKKwkJZWxzZQorCQkJcmV0diA9IGlwdjZfc29ja19hY19kcm9wKHNrLCBtcmVxLmlwdjZt
cl9pZmluZGV4LCAmbXJlcS5pcHY2bXJfYWNhZGRyKTsKKwkJYnJlYWs7CisJfQogCWNhc2UgSVBW
Nl9ST1VURVJfQUxFUlQ6CiAJCXJldHYgPSBpcDZfcmFfY29udHJvbChzaywgdmFsLCBOVUxMKTsK
IAkJYnJlYWs7CmRpZmYgLXJ1TiBsaW51eC0yLjUuNDQvbmV0L2lwdjYvbmRpc2MuYyBsaW51eC0y
LjUuNDRBQy9uZXQvaXB2Ni9uZGlzYy5jCi0tLSBsaW51eC0yLjUuNDQvbmV0L2lwdjYvbmRpc2Mu
YwlGcmkgT2N0IDE4IDIxOjAxOjU5IDIwMDIKKysrIGxpbnV4LTIuNS40NEFDL25ldC9pcHY2L25k
aXNjLmMJTW9uIE9jdCAyOCAxMzoxMjoyNyAyMDAyCkBAIC0zNzgsNyArMzc4LDEwIEBACiAJCSAg
IHN0cnVjdCBpbjZfYWRkciAqZGFkZHIsIHN0cnVjdCBpbjZfYWRkciAqc29saWNpdGVkX2FkZHIs
CiAJCSAgIGludCByb3V0ZXIsIGludCBzb2xpY2l0ZWQsIGludCBvdmVycmlkZSwgaW50IGluY19v
cHQpIAogeworCXN0YXRpYyBzdHJ1Y3QgaW42X2FkZHIgdG1wYWRkcjsKKwlzdHJ1Y3QgaW5ldDZf
aWZhZGRyICppZnA7CiAgICAgICAgIHN0cnVjdCBzb2NrICpzayA9IG5kaXNjX3NvY2tldC0+c2s7
CisJc3RydWN0IGluNl9hZGRyICpzcmNfYWRkcjsKICAgICAgICAgc3RydWN0IG5kX21zZyAqbXNn
OwogICAgICAgICBpbnQgbGVuOwogICAgICAgICBzdHJ1Y3Qgc2tfYnVmZiAqc2tiOwpAQCAtNDAw
LDEzICs0MDMsMjMgQEAKIAkJTkRfUFJJTlRLMSgic2VuZF9uYTogYWxsb2Mgc2tiIGZhaWxlZFxu
Iik7CiAJCXJldHVybjsKIAl9CisJLyogZm9yIGFueWNhc3Qgb3IgcHJveHksIHNvbGljaXRlZF9h
ZGRyICE9IHNyY19hZGRyICovCisJaWZwID0gaXB2Nl9nZXRfaWZhZGRyKHNvbGljaXRlZF9hZGRy
LCBkZXYpOworCWlmIChpZnApIHsKKwkJc3JjX2FkZHIgPSBzb2xpY2l0ZWRfYWRkcjsKKwkJaW42
X2lmYV9wdXQoaWZwKTsKKwl9IGVsc2UgeworCQlpZiAoaXB2Nl9kZXZfZ2V0X3NhZGRyKGRldiwg
ZGFkZHIsICZ0bXBhZGRyLCAwKSkKKwkJCXJldHVybjsKKwkJc3JjX2FkZHIgPSAmdG1wYWRkcjsK
Kwl9CiAKIAlpZiAobmRpc2NfYnVpbGRfbGxfaGRyKHNrYiwgZGV2LCBkYWRkciwgbmVpZ2gsIGxl
bikgPT0gMCkgewogCQlrZnJlZV9za2Ioc2tiKTsKIAkJcmV0dXJuOwogCX0KIAotCWlwNl9uZF9o
ZHIoc2ssIHNrYiwgZGV2LCBzb2xpY2l0ZWRfYWRkciwgZGFkZHIsIElQUFJPVE9fSUNNUFY2LCBs
ZW4pOworCWlwNl9uZF9oZHIoc2ssIHNrYiwgZGV2LCBzcmNfYWRkciwgZGFkZHIsIElQUFJPVE9f
SUNNUFY2LCBsZW4pOwogCiAJbXNnID0gKHN0cnVjdCBuZF9tc2cgKikgc2tiX3B1dChza2IsIGxl
bik7CiAKQEAgLTQyNiw3ICs0MzksNyBAQAogCQluZGlzY19maWxsX29wdGlvbihtc2ctPm9wdCwg
TkRfT1BUX1RBUkdFVF9MTF9BRERSLCBkZXYtPmRldl9hZGRyLCBkZXYtPmFkZHJfbGVuKTsKIAog
CS8qIGNoZWNrc3VtICovCi0JbXNnLT5pY21waC5pY21wNl9ja3N1bSA9IGNzdW1faXB2Nl9tYWdp
Yyhzb2xpY2l0ZWRfYWRkciwgZGFkZHIsIGxlbiwgCisJbXNnLT5pY21waC5pY21wNl9ja3N1bSA9
IGNzdW1faXB2Nl9tYWdpYyhzcmNfYWRkciwgZGFkZHIsIGxlbiwgCiAJCQkJCQkgSVBQUk9UT19J
Q01QVjYsCiAJCQkJCQkgY3N1bV9wYXJ0aWFsKChfX3U4ICopIG1zZywgCiAJCQkJCQkJICAgICAg
bGVuLCAwKSk7CkBAIC0xMTMzLDYgKzExNDYsNTEgQEAKIAkJCQl9CiAJCQl9CiAJCQlpbjZfaWZh
X3B1dChpZnApOworCQl9IGVsc2UgaWYgKGlwdjZfY2hrX2FjYXN0X2FkZHIoZGV2LCAmbXNnLT50
YXJnZXQpKSB7CisJCQlzdHJ1Y3QgaW5ldDZfZGV2ICppZGV2ID0gaW42X2Rldl9nZXQoZGV2KTsK
KwkJCWludCBhZGRyX3R5cGUgPSBpcHY2X2FkZHJfdHlwZShzYWRkcik7CisJCisJCQkvKiBhbnlj
YXN0ICovCisJCisJCQlpZiAoIWlkZXYpIHsKKwkJCQkvKiBYWFg6IGNvdW50IHRoaXMgZHJvcD8g
Ki8KKwkJCQlyZXR1cm4gMDsKKwkJCX0KKwkKKwkJCWlmIChhZGRyX3R5cGUgPT0gSVBWNl9BRERS
X0FOWSkgeworCQkJCXN0cnVjdCBpbjZfYWRkciBtYWRkcjsKKwkKKwkJCQlpcHY2X2FkZHJfYWxs
X25vZGVzKCZtYWRkcik7CisJCQkJbmRpc2Nfc2VuZF9uYShkZXYsIE5VTEwsICZtYWRkciwgJm1z
Zy0+dGFyZ2V0LAorCQkJCQkgICAgICBpZGV2LT5jbmYuZm9yd2FyZGluZywgMCwgMCwgMSk7CisJ
CQkJaW42X2Rldl9wdXQoaWRldik7CisJCQkJcmV0dXJuIDA7CisJCQl9CisJCisJCQlpZiAoYWRk
cl90eXBlICYgSVBWNl9BRERSX1VOSUNBU1QpIHsKKwkJCQlpbnQgaW5jID0gaXB2Nl9hZGRyX3R5
cGUoZGFkZHIpJklQVjZfQUREUl9NVUxUSUNBU1Q7CisJCQkJaWYgKGluYykgIAorCQkJCQluZF90
Ymwuc3RhdHMucmN2X3Byb2Jlc19tY2FzdCsrOworCSAJCQllbHNlCisJCQkJCW5kX3RibC5zdGF0
cy5yY3ZfcHJvYmVzX3VjYXN0Kys7CisJCisJCQkJLyoKKwkJCQkgKiAgIHVwZGF0ZSAvIGNyZWF0
ZSBjYWNoZSBlbnRyeQorCQkJCSAqICAgZm9yIHRoZSBzb3VyY2UgYWRkZHJlc3MKKwkJCQkgKi8K
KworCQkJCW5laWdoID0gbmVpZ2hfZXZlbnRfbnMoJm5kX3RibCwgbGxhZGRyLCBzYWRkciwgc2ti
LT5kZXYpOworCisJCQkJaWYgKG5laWdoIHx8ICFkZXYtPmhhcmRfaGVhZGVyKSB7CisJCQkJCW5k
aXNjX3NlbmRfbmEoZGV2LCBuZWlnaCwgc2FkZHIsCisJCQkJCQkmbXNnLT50YXJnZXQsIAorCQkJ
CQkgICAgICAgIGlkZXYtPmNuZi5mb3J3YXJkaW5nLCAxLCAwLCBpbmMpOworCQkJCQlpZiAobmVp
Z2gpCisJCQkJCQluZWlnaF9yZWxlYXNlKG5laWdoKTsKKwkJCQl9CisJCQl9CisJCQlpbjZfZGV2
X3B1dChpZGV2KTsKKwogCQl9IGVsc2UgewogCQkJc3RydWN0IGluZXQ2X2RldiAqaW42X2RldiA9
IGluNl9kZXZfZ2V0KGRldik7CiAJCQlpbnQgYWRkcl90eXBlID0gaXB2Nl9hZGRyX3R5cGUoc2Fk
ZHIpOwpkaWZmIC1ydU4gbGludXgtMi41LjQ0L25ldC9uZXRzeW1zLmMgbGludXgtMi41LjQ0QUMv
bmV0L25ldHN5bXMuYwotLS0gbGludXgtMi41LjQ0L25ldC9uZXRzeW1zLmMJRnJpIE9jdCAxOCAy
MTowMTo0OSAyMDAyCisrKyBsaW51eC0yLjUuNDRBQy9uZXQvbmV0c3ltcy5jCU1vbiBPY3QgMjgg
MTI6Mzg6MDkgMjAwMgpAQCAtNDY5LDYgKzQ2OSw4IEBACiBFWFBPUlRfU1lNQk9MKHVucmVnaXN0
ZXJfbmV0ZGV2aWNlKTsKIEVYUE9SVF9TWU1CT0wobmV0ZGV2X3N0YXRlX2NoYW5nZSk7CiBFWFBP
UlRfU1lNQk9MKGRldl9uZXdfaW5kZXgpOworRVhQT1JUX1NZTUJPTChkZXZfZ2V0YW55KTsKK0VY
UE9SVF9TWU1CT0woX19kZXZfZ2V0YW55KTsKIEVYUE9SVF9TWU1CT0woZGV2X2dldF9ieV9pbmRl
eCk7CiBFWFBPUlRfU1lNQk9MKF9fZGV2X2dldF9ieV9pbmRleCk7CiBFWFBPUlRfU1lNQk9MKGRl
dl9nZXRfYnlfbmFtZSk7Cg==

--0__=07BBE6F3DFE120F28f9e8a93df938690918c07BBE6F3DFE120F2--

