Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319009AbSH1WDM>; Wed, 28 Aug 2002 18:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319001AbSH1WDM>; Wed, 28 Aug 2002 18:03:12 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:5013 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319013AbSH1WDB>;
	Wed, 28 Aug 2002 18:03:01 -0400
Subject: [PATCH]  IPv6 Prefix List support for 2.5.31
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF42C8802F.503447A8-ON88256C23.0069C392@boulder.ibm.com>
From: "Krishna Kumar" <kumarkr@us.ibm.com>
Date: Wed, 28 Aug 2002 15:05:12 -0700
X-MIMETrack: Serialize by Router on D03NM801/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 08/28/2002 04:07:16 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch implements Prefix List support in IPv6. The reasons for the
patch are :

      - RFC conformance (RFC 2461 - Neighbor Discovery, Section 5.1 and
others).
      - Prefix List is needed to support Mobile IPv6 when it gets submitted
to the kernel list.

This code has both been tested within IPv6 and with Mobile IPv6. It has
also been integrated
into the USAGI kernel.

Any comments are welcome.

Thanks,

- KK

--- linux-2.5.31.org/net/ipv6/addrconf.c  Sat Aug 10 18:41:55 2002
+++ linux-2.5.31/net/ipv6/addrconf.c      Tue Aug 20 14:18:28 2002
@@ -26,6 +26,7 @@
  *                                 packets.
  *   yoshfuji@USAGI                :       Fixed interval between DAD
  *                                 packets.
+ *   Krishna Kumar@IBM       :     Added Prefix List Support.
  */

 #include <linux/config.h>
@@ -64,6 +65,10 @@

 #define IPV6_MAX_ADDRESSES 16

+#ifdef CONFIG_IPV6_PREFIXLIST_DEBUG
+#include <linux/inet.h>
+#endif
+
 /* Set to 3 to get tracing... */
 #define ACONF_DEBUG 2

@@ -229,6 +234,7 @@
      struct net_device *dev = idev->dev;
      BUG_TRAP(idev->addr_list==NULL);
      BUG_TRAP(idev->mc_list==NULL);
+     BUG_TRAP(list_empty(&idev->prefix_list) == 1);
 #ifdef NET_REFCNT_DEBUG
      printk(KERN_DEBUG "in6_dev_finish_destroy: %s\n", dev ? dev->name : "NIL");
 #endif
@@ -257,6 +263,8 @@

            ndev->lock = RW_LOCK_UNLOCKED;
            ndev->dev = dev;
+           ndev->prefix_lock = SPIN_LOCK_UNLOCKED;
+           INIT_LIST_HEAD(&ndev->prefix_list);
            memcpy(&ndev->cnf, &ipv6_devconf_dflt, sizeof(ndev->cnf));
            ndev->cnf.mtu6 = dev->mtu;
            ndev->cnf.sysctl = NULL;
@@ -300,6 +308,37 @@
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
 static void addrconf_forward_change(struct inet6_dev *idev)
 {
      struct net_device *dev;
@@ -447,6 +486,56 @@
      in6_ifa_put(ifp);
 }

+int ipv6_get_prefix_entries(struct prefix_info **plist, int ifindex, int plen)
+{
+     int count;
+     struct net_device *dev;
+     struct inet6_dev *idev;
+     struct list_head *head;
+     struct prefix_element *p;
+
+     if (plist == NULL) {
+           BUG_TRAP(plist != NULL);
+           return -EINVAL;
+     }
+     if ((dev = dev_get_by_index(ifindex)) == NULL) {
+           printk(KERN_WARNING "Bad I/F (%d) in ipv6_get_prefix_entries\n",
+                  ifindex);
+           return -EINVAL;
+     }
+
+     if ((idev = __in6_dev_get(dev)) == NULL) {
+           dev_put(dev);
+           return -EINVAL;
+     }
+
+     read_lock_bh(&idev->lock);
+     if (!(count = idev->prefix_count)) {
+           /* No elements on list */
+           goto out;
+     }
+     if ((*plist = kmalloc(count * sizeof(struct prefix_info),
+                       GFP_ATOMIC)) == NULL) {
+           count = -ENOMEM;
+           goto out;
+     }
+     count = 0;
+     spin_lock_bh(&idev->prefix_lock);
+     list_for_each(head, &idev->prefix_list) {
+           p = list_entry(head, struct prefix_element, list);
+           if (plen == 0 || p->pinfo.prefix_len == plen) {
+                 memcpy(*plist + count, &p->pinfo,
+                        sizeof(struct prefix_info));
+                 count++;
+           }
+     }
+     spin_unlock_bh(&idev->prefix_lock);
+out:
+     read_unlock_bh(&idev->lock);
+     dev_put(dev);
+     return count;
+}
+
 /*
  *   Choose an apropriate source address
  *   should do:
@@ -803,6 +892,82 @@
      return idev;
 }

+static int ipv6_add_prefix(struct inet6_dev *idev, struct prefix_info *pinfo,
+           __u32 lifetime)
+{
+     struct in6_addr         prefix;
+     struct list_head  *pos;
+     struct prefix_element   *pfx;
+#ifdef CONFIG_IPV6_PREFIXLIST_DEBUG
+     char abuf[64];
+#endif
+
+     ipv6_addr_prefix(&prefix, &pinfo->prefix, (int)pinfo->prefix_len);
+
+#ifdef CONFIG_IPV6_PREFIXLIST_DEBUG
+     in6_ntop(&prefix, abuf);
+#endif
+
+     /* Check if the prefix already exists in the list */
+     read_lock_bh(&idev->lock);
+     spin_lock_bh(&idev->prefix_lock);
+     list_for_each(pos, &idev->prefix_list) {
+           pfx = list_entry(pos, struct prefix_element, list);
+           if (pfx->pinfo.prefix_len == pinfo->prefix_len
+               && ipv6_addr_cmp(&pfx->pinfo.prefix, &prefix) == 0) {
+                 /* Found the prefix */
+                 if (lifetime == 0) {
+                       /* If lifetime = 0, delete the prefix */
+#ifdef CONFIG_IPV6_PREFIXLIST_DEBUG
+                       printk(KERN_INFO "%s: deleting prefix %s/%d\n",
+                       __FUNCTION__, abuf, pfx->pinfo.prefix_len);
+#endif
+                       list_del(&pfx->list);
+                       kfree(pfx);
+                       goto out;
+                 }
+                 pfx->pinfo.valid = lifetime;
+                 pfx->timestamp = jiffies;
+                 spin_unlock_bh(&idev->prefix_lock);
+                 read_unlock_bh(&idev->lock);
+#ifdef CONFIG_IPV6_PREFIXLIST_DEBUG
+                 printk(KERN_INFO "%s: changing prefix %s/%d, lifetime = %d\n",
+                       __FUNCTION__, abuf, pfx->pinfo.prefix_len, lifetime);
+#endif
+                 return 0;
+           }
+     }
+     if (lifetime == 0) {
+           /* Prefix was not on the list and lifetime = 0, do nothing */
+           goto out;
+     }
+
+     /* New Prefix, allocate one and fill in */
+     if ((pfx = kmalloc(sizeof(struct prefix_element), GFP_ATOMIC)) == NULL) {
+           ADBG(("ipv6_add_prefix: malloc failed\n"));
+           spin_unlock_bh(&idev->prefix_lock);
+           read_unlock_bh(&idev->lock);
+           return -1;
+     }
+     INIT_LIST_HEAD(&pfx->list);
+     memcpy(&pfx->pinfo, pinfo, sizeof(struct prefix_info));
+     pfx->pinfo.valid = lifetime;
+     pfx->timestamp = jiffies;
+     idev->prefix_count++;
+     ipv6_addr_copy(&pfx->pinfo.prefix, &prefix);
+
+     list_add(&pfx->list, idev->prefix_list.prev);   /* add to end of list */
+#ifdef CONFIG_IPV6_PREFIXLIST_DEBUG
+     printk(KERN_INFO "%s: adding prefix %s/%d, lifetime = %d\n",
+           __FUNCTION__, abuf, pfx->pinfo.prefix_len, lifetime);
+#endif
+out:
+     spin_unlock_bh(&idev->prefix_lock);
+     read_unlock_bh(&idev->lock);
+
+     return 0;
+}
+
 void addrconf_prefix_rcv(struct net_device *dev, u8 *opt, int len)
 {
      struct prefix_info *pinfo;
@@ -880,6 +1045,11 @@
      if (rt)
            dst_release(&rt->u.dst);

+     if (pinfo->onlink) {
+           /* Add this prefix to the list of prefixes on this interface */
+           ipv6_add_prefix(in6_dev, pinfo, valid_lft);
+     }
+
      /* Try to figure out our local address for this prefix */

      if (pinfo->autoconf && in6_dev->cnf.autoconf) {
@@ -1325,6 +1495,8 @@
      struct inet6_dev *idev;
      struct inet6_ifaddr *ifa, **bifa;
      int i;
+     struct list_head  *pos, *n;
+     struct prefix_element   *pfx;

      ASSERT_RTNL();

@@ -1387,6 +1559,24 @@
      else
            ipv6_mc_down(idev);

+     /* Step 5: Free up Prefix List */
+     spin_lock_bh(&idev->prefix_lock);
+     list_for_each_safe(pos, n, &idev->prefix_list) {
+           pfx = list_entry(pos, struct prefix_element, list);
+#ifdef CONFIG_IPV6_PREFIXLIST_DEBUG
+           {
+                 char abuf[64];
+                 struct prefix_element *pl = (struct prefix_element *)pfx;
+                 in6_ntop(&pl->pinfo.prefix, abuf);
+                 printk(KERN_INFO "%s: deleting prefix %s/%d, lifetime = %d\n",
+                       __FUNCTION__, abuf, pl->pinfo.prefix_len, pl->pinfo.valid);
+           }
+#endif
+           kfree(pfx);
+     }
+     INIT_LIST_HEAD(&idev->prefix_list);
+     spin_unlock_bh(&idev->prefix_lock);
+
      /* Shot the device (if unregistered) */

      if (how == 1) {
@@ -1618,6 +1808,10 @@
      struct inet6_ifaddr *ifp;
      unsigned long now = jiffies;
      int i;
+     struct list_head *pos, *n;
+     struct prefix_element *pfx;
+     struct net_device *dev;
+     struct inet6_dev *idev;

      for (i=0; i < IN6_ADDR_HSIZE; i++) {

@@ -1659,6 +1853,48 @@
            write_unlock(&addrconf_hash_lock);
      }

+     /*
+      * We need to expire prefixes even if no addresses are deleted in the
+      * loop above, since autoconfiguration may not be set in all router
+      * advertisements.
+      */
+     read_lock(&dev_base_lock);
+     for (dev = dev_base; dev; dev = dev->next) {
+           unsigned long age;
+           if (!(idev = __in6_dev_get(dev))) {
+                 continue;
+           }
+           read_lock_bh(&idev->lock);
+           spin_lock_bh(&idev->prefix_lock);
+           if (list_empty(&idev->prefix_list)) {
+                 spin_unlock_bh(&idev->prefix_lock);
+                 read_unlock_bh(&idev->lock);
+                 continue;
+           }
+           list_for_each_safe(pos, n, &idev->prefix_list) {
+                 pfx = list_entry(pos, struct prefix_element, list);
+                 if (pfx->pinfo.valid != PINFO_VALID_LIFETIME_INFINITE) {
+#ifdef CONFIG_IPV6_PREFIXLIST_DEBUG
+                       char abuf[64];
+
+                       in6_ntop(&pfx->pinfo.prefix, abuf);
+#endif
+                       age = (now - pfx->timestamp) / HZ;
+                       if (age > pfx->pinfo.valid) {
+#ifdef CONFIG_IPV6_PREFIXLIST_DEBUG
+                             printk(KERN_INFO "%s: deleting prefix %s/%d, lifetime = %d\n",
+                             __FUNCTION__, abuf, pfx->pinfo.prefix_len, pfx->pinfo.valid);
+#endif
+                             list_del(&pfx->list);
+                             kfree(pfx);
+                       }
+                 }
+           }
+           spin_unlock_bh(&idev->prefix_lock);
+           read_unlock_bh(&idev->lock);
+     }
+     read_unlock(&dev_base_lock);
+
      mod_timer(&addr_chk_timer, jiffies + ADDR_CHECK_FREQUENCY);
 }

--- linux-2.5.31.org/include/net/addrconf.h     Mon Aug 19 15:52:53 2002
+++ linux-2.5.31/include/net/addrconf.h   Tue Aug 20 14:13:56 2002
@@ -6,6 +6,8 @@
 #define MAX_RTR_SOLICITATIONS            3
 #define RTR_SOLICITATION_INTERVAL  (4*HZ)

+#define PINFO_VALID_LIFETIME_INFINITE    0xffffffff  /* infinite lifetime */
+
 #define ADDR_CHECK_FREQUENCY       (120*HZ)

 struct prefix_info {
@@ -40,6 +42,12 @@

 #define IN6_ADDR_HSIZE       16

+struct prefix_element {
+     struct list_head list;
+     struct prefix_info pinfo;
+     unsigned long timestamp;
+};
+
 extern void                  addrconf_init(void);
 extern void                  addrconf_cleanup(void);

@@ -88,6 +96,10 @@
 extern void                  addrconf_prefix_rcv(struct net_device *dev,
                                        u8 *opt, int len);

+extern int             ipv6_get_prefix_entries(
+                                       struct prefix_info **plist,
+                                       int ifindex, int plen);
+
 /* Device notifier */
 extern int register_inet6addr_notifier(struct notifier_block *nb);
 extern int unregister_inet6addr_notifier(struct notifier_block *nb);
--- linux-2.5.31.org/include/net/if_inet6.h     Sat Aug 10 18:41:56 2002
+++ linux-2.5.31/include/net/if_inet6.h   Tue Aug 20 11:02:01 2002
@@ -96,6 +96,9 @@

      struct inet6_ifaddr     *addr_list;
      struct ifmcaddr6  *mc_list;
+     struct list_head  prefix_list;
+     int               prefix_count;
+     spinlock_t        prefix_lock;
      rwlock_t          lock;
      atomic_t          refcnt;
      __u32             if_flags;
--- linux-2.5.31.org/include/linux/inet.h.org   Wed Aug 21 15:46:05 2002
+++ linux-2.5.31/include/linux/inet.h     Wed Aug 21 15:46:05 2002
@@ -49,5 +49,20 @@
 extern void            inet_proto_init(struct net_proto *pro);
 extern __u32           in_aton(const char *str);

+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+#include <linux/in6.h>
+extern __inline__ char *in6_ntop(const struct in6_addr *in6, char *buf){
+     if (!buf)
+           return NULL;
+     sprintf(buf,
+           "%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x",
+           ntohs(in6->s6_addr16[0]), ntohs(in6->s6_addr16[1]),
+           ntohs(in6->s6_addr16[2]), ntohs(in6->s6_addr16[3]),
+           ntohs(in6->s6_addr16[4]), ntohs(in6->s6_addr16[5]),
+           ntohs(in6->s6_addr16[6]), ntohs(in6->s6_addr16[7]));
+     return buf;
+}
+#endif
+
 #endif
 #endif     /* _LINUX_INET_H */
--- linux-2.5.31.org/net/ipv6/Config.in   Sat Aug 10 18:41:29 2002
+++ linux-2.5.31/net/ipv6/Config.in Wed Aug 21 10:25:36 2002
@@ -2,6 +2,14 @@
 # IPv6 configuration
 #

+# --- overall ---
+bool '    IPv6: Verbose debugging messages' CONFIG_IPV6_DEBUG
+
+# --- NDP (RFC2461) ---
+if [ "$CONFIG_IPV6_DEBUG" = "y" ]; then
+     bool '    IPv6: Prefix List Debugging' CONFIG_IPV6_PREFIXLIST_DEBUG
+fi
+
 #bool '    IPv6: flow policy support' CONFIG_RT6_POLICY
 #bool '    IPv6: firewall support' CONFIG_IPV6_FIREWALL





