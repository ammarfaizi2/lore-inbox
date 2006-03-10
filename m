Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWCJWfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWCJWfq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 17:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWCJWfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 17:35:46 -0500
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:30903 "EHLO
	smtprelay04.ispgateway.de") by vger.kernel.org with ESMTP
	id S932333AbWCJWfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 17:35:45 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] IPv6: Cleanups for net/ipv6/addrconf.c (kzalloc, early exit) v2
Date: Fri, 10 Mar 2006 23:34:26 +0100
User-Agent: KMail/1.9.1
Cc: yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
References: <20060210.014853.13643277.yoshfuji@linux-ipv6.org> <20060212.021103.76157181.yoshfuji@linux-ipv6.org> <20060310.030258.55767431.davem@davemloft.net>
In-Reply-To: <20060310.030258.55767431.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603102334.27590.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Oeser <ioe-lkml@rameria.de>

Here are some possible (and trivial) cleanups.
- use kzalloc() where possible
- invert allocation failure test like
  if (object) {
        /* Rest of function here */
  }
  to

  if (object == NULL)
        return NULL;

  /* Rest of function here */

Signed-off-by: Ingo Oeser <ioe-lkml@rameria.de>
Acked-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

---
Hello Dave,

On Friday, 10. March 2006 12:02, David S. Miller wrote:
> This patch no longer applied cleanly, Ingo can you generate
> a fresh version of your patch against my net-2.6.16 tree?

Done!

I rebased it, but against net-2.6.17, since it did apply cleanly to
net-2.6 and I didn't find the tree for net-2.6.16 as requested.

Hope I got it right :-)

Regards 

Ingo Oeser

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 8df9eb9..395b3f8 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -341,84 +341,83 @@ static struct inet6_dev * ipv6_add_dev(s
 	if (dev->mtu < IPV6_MIN_MTU)
 		return NULL;
 
-	ndev = kmalloc(sizeof(struct inet6_dev), GFP_KERNEL);
-
-	if (ndev) {
-		memset(ndev, 0, sizeof(struct inet6_dev));
-
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
+ 	ndev = kzalloc(sizeof(struct inet6_dev), GFP_KERNEL);
+  
+ 	if (ndev == NULL)
+ 		return NULL;
+
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
 
@@ -536,7 +535,7 @@ ipv6_add_addr(struct inet6_dev *idev, co
 		goto out;
 	}
 
-	ifa = kmalloc(sizeof(struct inet6_ifaddr), GFP_ATOMIC);
+	ifa = kzalloc(sizeof(struct inet6_ifaddr), GFP_ATOMIC);
 
 	if (ifa == NULL) {
 		ADBG(("ipv6_add_addr: malloc failed\n"));
@@ -550,7 +549,6 @@ ipv6_add_addr(struct inet6_dev *idev, co
 		goto out;
 	}
 
-	memset(ifa, 0, sizeof(struct inet6_ifaddr));
 	ipv6_addr_copy(&ifa->addr, addr);
 
 	spin_lock_init(&ifa->lock);
@@ -2669,11 +2667,10 @@ static int if6_seq_open(struct inode *in
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
