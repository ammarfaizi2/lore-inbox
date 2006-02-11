Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWBKQh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWBKQh3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 11:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWBKQh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 11:37:28 -0500
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:7372 "EHLO
	smtprelay03.ispgateway.de") by vger.kernel.org with ESMTP
	id S932175AbWBKQh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 11:37:26 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: YOSHIFUJI Hideaki /
	 =?utf-8?q?=E5=90=89=E8=97=A4=E8=8B=B1=E6=98=8E?= 
	<yoshfuji@linux-ipv6.org>
Subject: [PATCH] IPv6: Cleanups for net/ipv6/addrconf.c (kzalloc, early exit) v2
Date: Sat, 11 Feb 2006 17:37:18 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <200602091736.18000.ioe-lkml@rameria.de> <20060210.014853.13643277.yoshfuji@linux-ipv6.org>
In-Reply-To: <20060210.014853.13643277.yoshfuji@linux-ipv6.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602111737.20010.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Oeser <ioe-lkml@rameria.de>

Here are some possible (and trivial) cleanups.
- use kzalloc() where possible
- remove unused label
- invert allocation failure test like
  if (object) {
        /* Rest of function here */
  }
  to

  if (object == NULL)
        return NULL;

  /* Rest of function here */

The last one moves quite some code, because it changes indention.
I can split that up, if needed.

Signed-off-by: Ingo Oeser <ioe-lkml@rameria.de>
---
Hello,

On Thursday 09 February 2006 17:48, YOSHIFUJI Hideaki wrote:
> Please keep nlmsg_failure, which is used by NLMSG_NEW().

This issue has been adressed now. 

Patch is against latest git from Linus. It has been compile tested with
allyesconfig on ix86.

Many thanks for your patience!

Regards

Ingo Oeer

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index b7d8822..984a9bc 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -327,86 +327,85 @@ static struct inet6_dev * ipv6_add_dev(s
 	if (dev->mtu < IPV6_MIN_MTU)
 		return NULL;
 
-	ndev = kmalloc(sizeof(struct inet6_dev), GFP_KERNEL);
+	ndev = kzalloc(sizeof(struct inet6_dev), GFP_KERNEL);
 
-	if (ndev) {
-		memset(ndev, 0, sizeof(struct inet6_dev));
+	if (ndev == NULL)
+		return NULL;
 
-		rwlock_init(&ndev->lock);
-		ndev->dev = dev;
-		memcpy(&ndev->cnf, &ipv6_devconf_dflt, sizeof(ndev->cnf));
-		ndev->cnf.mtu6 = dev->mtu;
-		ndev->cnf.sysctl = NULL;
-		ndev->nd_parms = neigh_parms_alloc(dev, &nd_tbl);
-		if (ndev->nd_parms == NULL) {
-			kfree(ndev);
-			return NULL;
-		}
-		/* We refer to the device */
-		dev_hold(dev);
+	rwlock_init(&ndev->lock);
+	ndev->dev = dev;
+	memcpy(&ndev->cnf, &ipv6_devconf_dflt, sizeof(ndev->cnf));
+	ndev->cnf.mtu6 = dev->mtu;
+	ndev->cnf.sysctl = NULL;
+	ndev->nd_parms = neigh_parms_alloc(dev, &nd_tbl);
+	if (ndev->nd_parms == NULL) {
+		kfree(ndev);
+		return NULL;
+	}
+	/* We refer to the device */
+	dev_hold(dev);
 
-		if (snmp6_alloc_dev(ndev) < 0) {
-			ADBG((KERN_WARNING
-				"%s(): cannot allocate memory for statistics; dev=%s.\n",
-				__FUNCTION__, dev->name));
-			neigh_parms_release(&nd_tbl, ndev->nd_parms);
-			ndev->dead = 1;
-			in6_dev_finish_destroy(ndev);
-			return NULL;
-		}
+	if (snmp6_alloc_dev(ndev) < 0) {
+		ADBG((KERN_WARNING
+			"%s(): cannot allocate memory for statistics; dev=%s.\n",
+			__FUNCTION__, dev->name));
+		neigh_parms_release(&nd_tbl, ndev->nd_parms);
+		ndev->dead = 1;
+		in6_dev_finish_destroy(ndev);
+		return NULL;
+	}
 
-		if (snmp6_register_dev(ndev) < 0) {
-			ADBG((KERN_WARNING
-				"%s(): cannot create /proc/net/dev_snmp6/%s\n",
-				__FUNCTION__, dev->name));
-			neigh_parms_release(&nd_tbl, ndev->nd_parms);
-			ndev->dead = 1;
-			in6_dev_finish_destroy(ndev);
-			return NULL;
-		}
+	if (snmp6_register_dev(ndev) < 0) {
+		ADBG((KERN_WARNING
+			"%s(): cannot create /proc/net/dev_snmp6/%s\n",
+			__FUNCTION__, dev->name));
+		neigh_parms_release(&nd_tbl, ndev->nd_parms);
+		ndev->dead = 1;
+		in6_dev_finish_destroy(ndev);
+		return NULL;
+	}
 
-		/* One reference from device.  We must do this before
-		 * we invoke __ipv6_regen_rndid().
-		 */
-		in6_dev_hold(ndev);
+	/* One reference from device.  We must do this before
+	 * we invoke __ipv6_regen_rndid().
+	 */
+	in6_dev_hold(ndev);
 
 #ifdef CONFIG_IPV6_PRIVACY
-		get_random_bytes(ndev->rndid, sizeof(ndev->rndid));
-		get_random_bytes(ndev->entropy, sizeof(ndev->entropy));
-		init_timer(&ndev->regen_timer);
-		ndev->regen_timer.function = ipv6_regen_rndid;
-		ndev->regen_timer.data = (unsigned long) ndev;
-		if ((dev->flags&IFF_LOOPBACK) ||
-		    dev->type == ARPHRD_TUNNEL ||
-		    dev->type == ARPHRD_NONE ||
-		    dev->type == ARPHRD_SIT) {
-			printk(KERN_INFO
-			       "%s: Disabled Privacy Extensions\n",
-			       dev->name);
-			ndev->cnf.use_tempaddr = -1;
-		} else {
-			in6_dev_hold(ndev);
-			ipv6_regen_rndid((unsigned long) ndev);
-		}
+	get_random_bytes(ndev->rndid, sizeof(ndev->rndid));
+	get_random_bytes(ndev->entropy, sizeof(ndev->entropy));
+	init_timer(&ndev->regen_timer);
+	ndev->regen_timer.function = ipv6_regen_rndid;
+	ndev->regen_timer.data = (unsigned long) ndev;
+	if ((dev->flags&IFF_LOOPBACK) ||
+	    dev->type == ARPHRD_TUNNEL ||
+	    dev->type == ARPHRD_NONE ||
+	    dev->type == ARPHRD_SIT) {
+		printk(KERN_INFO
+		       "%s: Disabled Privacy Extensions\n",
+		       dev->name);
+		ndev->cnf.use_tempaddr = -1;
+	} else {
+		in6_dev_hold(ndev);
+		ipv6_regen_rndid((unsigned long) ndev);
+	}
 #endif
 
-		if (netif_carrier_ok(dev))
-			ndev->if_flags |= IF_READY;
+	if (netif_carrier_ok(dev))
+		ndev->if_flags |= IF_READY;
 
-		write_lock_bh(&addrconf_lock);
-		dev->ip6_ptr = ndev;
-		write_unlock_bh(&addrconf_lock);
+	write_lock_bh(&addrconf_lock);
+	dev->ip6_ptr = ndev;
+	write_unlock_bh(&addrconf_lock);
 
-		ipv6_mc_init_dev(ndev);
-		ndev->tstamp = jiffies;
+	ipv6_mc_init_dev(ndev);
+	ndev->tstamp = jiffies;
 #ifdef CONFIG_SYSCTL
-		neigh_sysctl_register(dev, ndev->nd_parms, NET_IPV6, 
-				      NET_IPV6_NEIGH, "ipv6",
-				      &ndisc_ifinfo_sysctl_change,
-				      NULL);
-		addrconf_sysctl_register(ndev, &ndev->cnf);
+	neigh_sysctl_register(dev, ndev->nd_parms, NET_IPV6, 
+			      NET_IPV6_NEIGH, "ipv6",
+			      &ndisc_ifinfo_sysctl_change,
+			      NULL);
+	addrconf_sysctl_register(ndev, &ndev->cnf);
 #endif
-	}
 	return ndev;
 }
 
@@ -524,7 +523,7 @@ ipv6_add_addr(struct inet6_dev *idev, co
 		goto out;
 	}
 
-	ifa = kmalloc(sizeof(struct inet6_ifaddr), GFP_ATOMIC);
+	ifa = kzalloc(sizeof(struct inet6_ifaddr), GFP_ATOMIC);
 
 	if (ifa == NULL) {
 		ADBG(("ipv6_add_addr: malloc failed\n"));
@@ -538,7 +537,6 @@ ipv6_add_addr(struct inet6_dev *idev, co
 		goto out;
 	}
 
-	memset(ifa, 0, sizeof(struct inet6_ifaddr));
 	ipv6_addr_copy(&ifa->addr, addr);
 
 	spin_lock_init(&ifa->lock);
@@ -2668,11 +2666,10 @@ static int if6_seq_open(struct inode *in
 {
 	struct seq_file *seq;
 	int rc = -ENOMEM;
-	struct if6_iter_state *s = kmalloc(sizeof(*s), GFP_KERNEL);
+	struct if6_iter_state *s = kzalloc(sizeof(*s), GFP_KERNEL);
 
 	if (!s)
 		goto out;
-	memset(s, 0, sizeof(*s));
 
 	rc = seq_open(file, &if6_seq_ops);
 	if (rc)

