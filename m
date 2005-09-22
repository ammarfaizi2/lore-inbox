Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbVIVEEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbVIVEEE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 00:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbVIVEEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 00:04:04 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:60222 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751430AbVIVEEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 00:04:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=EKjIVJqXI72Jyb50j9rFoeVwWMHv9ptXsZybf8LU9sd1h+AvPtY+y/FOlMr9BdBqe2/VKml7JHlIErVQsPH6AtPHIybe85EHTOyEtPANRn39QERv1XWdDlVIuaDAr8N8k0/e+iEx61O8Fpcpm+xo8oQzdntBpjWNF+VjJKHhhig=
Date: Thu, 22 Sep 2005 00:04:44 -0400
From: Florin Malita <fmalita@gmail.com>
To: akpm@osdl.org, davem@davemloft.net
Cc: ctindel@users.sourceforge.net, fubar@us.ibm.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] channel bonding: add support for device-indexed parameters
Message-Id: <20050922000444.369c32c2.fmalita@gmail.com>
X-Mailer: Sylpheed version 2.1.2 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While originally I was interested in being able to set a different
primary interface for each bond device (same primary for all bond
devices doesn't make any sense), most parameters deserve the same
treatement.

This patch adds support for device indexed module parameter
arrays instead of the old plain scalars. Mostly module_param
substitutions and parameter parsing logic tweaking.


Signed-off-by: Florin Malita <fmalita@gmail.com>
---
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -487,6 +487,8 @@
  *	  * Added xmit_hash_policy_layer34()
  *	- Modified by Jay Vosburgh <fubar@us.ibm.com> to also support mode 4.
  *	  Set version to 2.6.3.
+ * 2005/09/20 - Florin Malita <fmalita at gmail dot com>
+ *      - Added support for device-indexed module parameters.
  */
 
 //#define BONDING_DEBUG 1
@@ -545,38 +547,47 @@
 #define BOND_LINK_ARP_INTERV	0
 
 static int max_bonds	= BOND_DEFAULT_MAX_BONDS;
-static int miimon	= BOND_LINK_MON_INTERV;
-static int updelay	= 0;
-static int downdelay	= 0;
-static int use_carrier	= 1;
-static char *mode	= NULL;
-static char *primary	= NULL;
-static char *lacp_rate	= NULL;
-static char *xmit_hash_policy = NULL;
-static int arp_interval = BOND_LINK_ARP_INTERV;
+static int miimon[BOND_MAX_PARMS];
+static int num_miimon;
+static int updelay[BOND_MAX_PARMS];
+static int num_updelay;
+static int downdelay[BOND_MAX_PARMS];
+static int num_downdelay;
+static int use_carrier[BOND_MAX_PARMS];
+static int num_use_carrier;
+static char *mode[BOND_MAX_PARMS];
+static int num_mode;
+static char *primary[BOND_MAX_PARMS];
+static int num_primary;
+static char *lacp_rate[BOND_MAX_PARMS];
+static int num_lacp_rate;
+static char *xmit_hash_policy[BOND_MAX_PARMS];
+static int num_xmit_hash_policy;
+static int arp_interval[BOND_MAX_PARMS];
+static int num_arp_interval;
 static char *arp_ip_target[BOND_MAX_ARP_TARGETS] = { NULL, };
 
-module_param(max_bonds, int, 0);
+module_param(max_bonds, int, S_IRUGO);
 MODULE_PARM_DESC(max_bonds, "Max number of bonded devices");
-module_param(miimon, int, 0);
+module_param_array(miimon, int, &num_miimon, S_IRUGO);
 MODULE_PARM_DESC(miimon, "Link check interval in milliseconds");
-module_param(updelay, int, 0);
+module_param_array(updelay, int, &num_updelay, S_IRUGO);
 MODULE_PARM_DESC(updelay, "Delay before considering link up, in milliseconds");
-module_param(downdelay, int, 0);
+module_param_array(downdelay, int, &num_downdelay, S_IRUGO);
 MODULE_PARM_DESC(downdelay, "Delay before considering link down, in milliseconds");
-module_param(use_carrier, int, 0);
+module_param_array(use_carrier, int, &num_use_carrier, S_IRUGO);
 MODULE_PARM_DESC(use_carrier, "Use netif_carrier_ok (vs MII ioctls) in miimon; 0 for off, 1 for on (default)");
-module_param(mode, charp, 0);
+module_param_array(mode, charp, &num_mode, S_IRUGO);
 MODULE_PARM_DESC(mode, "Mode of operation : 0 for round robin, 1 for active-backup, 2 for xor");
-module_param(primary, charp, 0);
+module_param_array(primary, charp, &num_primary, S_IRUGO);
 MODULE_PARM_DESC(primary, "Primary network device to use");
-module_param(lacp_rate, charp, 0);
+module_param_array(lacp_rate, charp, &num_lacp_rate, S_IRUGO);
 MODULE_PARM_DESC(lacp_rate, "LACPDU tx rate to request from 802.3ad partner (slow/fast)");
-module_param(xmit_hash_policy, charp, 0);
+module_param_array(xmit_hash_policy, charp, &num_xmit_hash_policy, S_IRUGO);
 MODULE_PARM_DESC(xmit_hash_policy, "XOR hashing method : 0 for layer 2 (default), 1 for layer 3+4");
-module_param(arp_interval, int, 0);
+module_param_array(arp_interval, int, &num_arp_interval, S_IRUGO);
 MODULE_PARM_DESC(arp_interval, "arp interval in milliseconds");
-module_param_array(arp_ip_target, charp, NULL, 0);
+module_param_array(arp_ip_target, charp, NULL, S_IRUGO);
 MODULE_PARM_DESC(arp_ip_target, "arp targets in n.n.n.n form");
 
 /*----------------------------- Global variables ----------------------------*/
@@ -592,9 +603,6 @@ static struct proc_dir_entry *bond_proc_
 
 static u32 arp_target[BOND_MAX_ARP_TARGETS] = { 0, } ;
 static int arp_ip_count	= 0;
-static int bond_mode	= BOND_MODE_ROUNDROBIN;
-static int xmit_hashtype= BOND_XMIT_POLICY_LAYER2;
-static int lacp_fast	= 0;
 static int app_abi_ver	= 0;
 static int orig_app_abi_ver = -1; /* This is used to save the first ABI version
 				   * we receive from the application. Once set,
@@ -4714,51 +4722,62 @@ static inline int bond_parse_parm(char *
 	return -1;
 }
 
-static int bond_check_params(struct bond_params *params)
+static int bond_check_params(struct bond_params *params, int bond)
 {
+	params->miimon = (bond < num_miimon) ? miimon[bond] : BOND_LINK_MON_INTERV;
+	params->updelay	= (bond < num_updelay) ? updelay[bond] : 0;
+	params->downdelay = (bond < num_downdelay) ? downdelay[bond] : 0;
+	params->use_carrier = (bond < num_use_carrier) ? use_carrier[bond] : 1;
+	params->arp_interval = (bond < num_arp_interval) ? arp_interval[bond] : BOND_LINK_ARP_INTERV;
+	
+	params->mode = BOND_MODE_ROUNDROBIN;
+	params->primary[0] = '\0';
+	params->lacp_fast = 0;
+	params->xmit_policy = BOND_XMIT_POLICY_LAYER2;
+	
+
 	/*
 	 * Convert string parameters.
 	 */
-	if (mode) {
-		bond_mode = bond_parse_parm(mode, bond_mode_tbl);
-		if (bond_mode == -1) {
+	if (bond < num_mode) {
+		params->mode = bond_parse_parm(mode[bond], bond_mode_tbl);
+		if (params->mode == -1) {
 			printk(KERN_ERR DRV_NAME
 			       ": Error: Invalid bonding mode \"%s\"\n",
-			       mode == NULL ? "NULL" : mode);
+			       mode[bond]);
 			return -EINVAL;
 		}
 	}
 
-	if (xmit_hash_policy) {
-		if ((bond_mode != BOND_MODE_XOR) &&
-		    (bond_mode != BOND_MODE_8023AD)) {
+	if (bond < num_xmit_hash_policy) {
+		if ((params->mode != BOND_MODE_XOR) &&
+		    (params->mode != BOND_MODE_8023AD)) {
 			printk(KERN_INFO DRV_NAME
 			       ": xor_mode param is irrelevant in mode %s\n",
-			       bond_mode_name(bond_mode));
+			       bond_mode_name(params->mode));
 		} else {
-			xmit_hashtype = bond_parse_parm(xmit_hash_policy,
+			params->xmit_policy = bond_parse_parm(xmit_hash_policy[bond],
 							xmit_hashtype_tbl);
-			if (xmit_hashtype == -1) {
+			if (params->xmit_policy == -1) {
 				printk(KERN_ERR DRV_NAME
 			       	": Error: Invalid xmit_hash_policy \"%s\"\n",
-			       	xmit_hash_policy == NULL ? "NULL" :
-				       xmit_hash_policy);
+			       	xmit_hash_policy[bond]);
 				return -EINVAL;
 			}
 		}
 	}
 
-	if (lacp_rate) {
-		if (bond_mode != BOND_MODE_8023AD) {
+	if (bond < num_lacp_rate) {
+		if (params->mode != BOND_MODE_8023AD) {
 			printk(KERN_INFO DRV_NAME
 			       ": lacp_rate param is irrelevant in mode %s\n",
-			       bond_mode_name(bond_mode));
+			       bond_mode_name(params->mode));
 		} else {
-			lacp_fast = bond_parse_parm(lacp_rate, bond_lacp_tbl);
-			if (lacp_fast == -1) {
+			params->lacp_fast = bond_parse_parm(lacp_rate[bond], bond_lacp_tbl);
+			if (params->lacp_fast == -1) {
 				printk(KERN_ERR DRV_NAME
 				       ": Error: Invalid lacp rate \"%s\"\n",
-				       lacp_rate == NULL ? "NULL" : lacp_rate);
+				       lacp_rate[bond]);
 				return -EINVAL;
 			}
 		}
@@ -4772,77 +4791,77 @@ static int bond_check_params(struct bond
 		max_bonds = BOND_DEFAULT_MAX_BONDS;
 	}
 
-	if (miimon < 0) {
+	if (params->miimon < 0) {
 		printk(KERN_WARNING DRV_NAME
 		       ": Warning: miimon module parameter (%d), "
 		       "not in range 0-%d, so it was reset to %d\n",
-		       miimon, INT_MAX, BOND_LINK_MON_INTERV);
-		miimon = BOND_LINK_MON_INTERV;
+		       params->miimon, INT_MAX, BOND_LINK_MON_INTERV);
+		params->miimon = BOND_LINK_MON_INTERV;
 	}
 
-	if (updelay < 0) {
+	if (params->updelay < 0) {
 		printk(KERN_WARNING DRV_NAME
 		       ": Warning: updelay module parameter (%d), "
 		       "not in range 0-%d, so it was reset to 0\n",
-		       updelay, INT_MAX);
-		updelay = 0;
+		       params->updelay, INT_MAX);
+		params->updelay = 0;
 	}
 
-	if (downdelay < 0) {
+	if (params->downdelay < 0) {
 		printk(KERN_WARNING DRV_NAME
 		       ": Warning: downdelay module parameter (%d), "
 		       "not in range 0-%d, so it was reset to 0\n",
-		       downdelay, INT_MAX);
-		downdelay = 0;
+		       params->downdelay, INT_MAX);
+		params->downdelay = 0;
 	}
 
-	if ((use_carrier != 0) && (use_carrier != 1)) {
+	if ((params->use_carrier != 0) && (params->use_carrier != 1)) {
 		printk(KERN_WARNING DRV_NAME
 		       ": Warning: use_carrier module parameter (%d), "
 		       "not of valid value (0/1), so it was set to 1\n",
-		       use_carrier);
-		use_carrier = 1;
+		       params->use_carrier);
+		params->use_carrier = 1;
 	}
 
 	/* reset values for 802.3ad */
-	if (bond_mode == BOND_MODE_8023AD) {
-		if (!miimon) {
+	if (params->mode == BOND_MODE_8023AD) {
+		if (!params->miimon) {
 			printk(KERN_WARNING DRV_NAME
 			       ": Warning: miimon must be specified, "
 			       "otherwise bonding will not detect link "
 			       "failure, speed and duplex which are "
 			       "essential for 802.3ad operation\n");
 			printk(KERN_WARNING "Forcing miimon to 100msec\n");
-			miimon = 100;
+			params->miimon = 100;
 		}
 	}
 
 	/* reset values for TLB/ALB */
-	if ((bond_mode == BOND_MODE_TLB) ||
-	    (bond_mode == BOND_MODE_ALB)) {
-		if (!miimon) {
+	if ((params->mode == BOND_MODE_TLB) ||
+	    (params->mode == BOND_MODE_ALB)) {
+		if (!params->miimon) {
 			printk(KERN_WARNING DRV_NAME
 			       ": Warning: miimon must be specified, "
 			       "otherwise bonding will not detect link "
 			       "failure and link speed which are essential "
 			       "for TLB/ALB load balancing\n");
 			printk(KERN_WARNING "Forcing miimon to 100msec\n");
-			miimon = 100;
+			params->miimon = 100;
 		}
 	}
 
-	if (bond_mode == BOND_MODE_ALB) {
+	if (params->mode == BOND_MODE_ALB) {
 		printk(KERN_NOTICE DRV_NAME
 		       ": In ALB mode you might experience client "
 		       "disconnections upon reconnection of a link if the "
 		       "bonding module updelay parameter (%d msec) is "
 		       "incompatible with the forwarding delay time of the "
 		       "switch\n",
-		       updelay);
+		       params->updelay);
 	}
 
-	if (!miimon) {
-		if (updelay || downdelay) {
+	if (!params->miimon) {
+		if (params->updelay || params->downdelay) {
 			/* just warn the user the up/down delay will have
 			 * no effect since miimon is zero...
 			 */
@@ -4851,45 +4870,45 @@ static int bond_check_params(struct bond
 			       "and updelay (%d) or downdelay (%d) module "
 			       "parameter is set; updelay and downdelay have "
 			       "no effect unless miimon is set\n",
-			       updelay, downdelay);
+			       params->updelay, params->downdelay);
 		}
 	} else {
 		/* don't allow arp monitoring */
-		if (arp_interval) {
+		if (params->arp_interval) {
 			printk(KERN_WARNING DRV_NAME
 			       ": Warning: miimon (%d) and arp_interval (%d) "
 			       "can't be used simultaneously, disabling ARP "
 			       "monitoring\n",
-			       miimon, arp_interval);
-			arp_interval = 0;
+			       params->miimon, params->arp_interval);
+			params->arp_interval = 0;
 		}
 
-		if ((updelay % miimon) != 0) {
+		if ((params->updelay % params->miimon) != 0) {
 			printk(KERN_WARNING DRV_NAME
 			       ": Warning: updelay (%d) is not a multiple "
 			       "of miimon (%d), updelay rounded to %d ms\n",
-			       updelay, miimon, (updelay / miimon) * miimon);
+			       params->updelay, params->miimon, (params->updelay / params->miimon) * params->miimon);
 		}
 
-		updelay /= miimon;
+		params->updelay /= params->miimon;
 
-		if ((downdelay % miimon) != 0) {
+		if ((params->downdelay % params->miimon) != 0) {
 			printk(KERN_WARNING DRV_NAME
 			       ": Warning: downdelay (%d) is not a multiple "
 			       "of miimon (%d), downdelay rounded to %d ms\n",
-			       downdelay, miimon,
-			       (downdelay / miimon) * miimon);
+			       params->downdelay, params->miimon,
+			       (params->downdelay / params->miimon) * params->miimon);
 		}
 
-		downdelay /= miimon;
+		params->downdelay /= params->miimon;
 	}
 
-	if (arp_interval < 0) {
+	if (params->arp_interval < 0) {
 		printk(KERN_WARNING DRV_NAME
 		       ": Warning: arp_interval module parameter (%d) "
 		       ", not in range 0-%d, so it was reset to %d\n",
-		       arp_interval, INT_MAX, BOND_LINK_ARP_INTERV);
-		arp_interval = BOND_LINK_ARP_INTERV;
+		       params->arp_interval, INT_MAX, BOND_LINK_ARP_INTERV);
+		params->arp_interval = BOND_LINK_ARP_INTERV;
 	}
 
 	for (arp_ip_count = 0;
@@ -4902,33 +4921,33 @@ static int bond_check_params(struct bond
 			       ": Warning: bad arp_ip_target module parameter "
 			       "(%s), ARP monitoring will not be performed\n",
 			       arp_ip_target[arp_ip_count]);
-			arp_interval = 0;
+			params->arp_interval = 0;
 		} else {
 			u32 ip = in_aton(arp_ip_target[arp_ip_count]);
 			arp_target[arp_ip_count] = ip;
 		}
 	}
 
-	if (arp_interval && !arp_ip_count) {
+	if (params->arp_interval && !arp_ip_count) {
 		/* don't allow arping if no arp_ip_target given... */
 		printk(KERN_WARNING DRV_NAME
 		       ": Warning: arp_interval module parameter (%d) "
 		       "specified without providing an arp_ip_target "
 		       "parameter, arp_interval was reset to 0\n",
-		       arp_interval);
-		arp_interval = 0;
+		       params->arp_interval);
+		params->arp_interval = 0;
 	}
 
-	if (miimon) {
+	if (params->miimon) {
 		printk(KERN_INFO DRV_NAME
 		       ": MII link monitoring set to %d ms\n",
-		       miimon);
-	} else if (arp_interval) {
+		       params->miimon);
+	} else if (params->arp_interval) {
 		int i;
 
 		printk(KERN_INFO DRV_NAME
 		       ": ARP monitoring set to %d ms with %d target(s):",
-		       arp_interval, arp_ip_count);
+		       params->arp_interval, arp_ip_count);
 
 		for (i = 0; i < arp_ip_count; i++)
 			printk (" %s", arp_ip_target[i]);
@@ -4945,32 +4964,20 @@ static int bond_check_params(struct bond
 		       "otherwise bonding will not detect link failures! see "
 		       "bonding.txt for details.\n");
 	}
-
-	if (primary && !USES_PRIMARY(bond_mode)) {
+	
+	if (bond < num_primary) {
 		/* currently, using a primary only makes sense
 		 * in active backup, TLB or ALB modes
 		 */
-		printk(KERN_WARNING DRV_NAME
-		       ": Warning: %s primary device specified but has no "
-		       "effect in %s mode\n",
-		       primary, bond_mode_name(bond_mode));
-		primary = NULL;
-	}
-
-	/* fill params struct with the proper values */
-	params->mode = bond_mode;
-	params->xmit_policy = xmit_hashtype;
-	params->miimon = miimon;
-	params->arp_interval = arp_interval;
-	params->updelay = updelay;
-	params->downdelay = downdelay;
-	params->use_carrier = use_carrier;
-	params->lacp_fast = lacp_fast;
-	params->primary[0] = 0;
-
-	if (primary) {
-		strncpy(params->primary, primary, IFNAMSIZ);
-		params->primary[IFNAMSIZ - 1] = 0;
+		if (USES_PRIMARY(params->mode)) {
+			strncpy(params->primary, primary[bond], IFNAMSIZ);
+			params->primary[IFNAMSIZ - 1] = 0;
+		} else {
+			printk(KERN_WARNING DRV_NAME
+			       ": Warning: %s primary device specified but has no "
+			       "effect in %s mode\n",
+		    		primary[bond], bond_mode_name(params->mode));
+		}
 	}
 
 	memcpy(params->arp_targets, arp_target, sizeof(arp_target));
@@ -4981,16 +4988,12 @@ static int bond_check_params(struct bond
 static int __init bonding_init(void)
 {
 	struct bond_params params;
+	struct net_device *bond_dev;
 	int i;
 	int res;
 
 	printk(KERN_INFO "%s", version);
 
-	res = bond_check_params(&params);
-	if (res) {
-		return res;
-	}
-
 	rtnl_lock();
 
 #ifdef CONFIG_PROC_FS
@@ -4998,8 +5001,6 @@ static int __init bonding_init(void)
 #endif
 
 	for (i = 0; i < max_bonds; i++) {
-		struct net_device *bond_dev;
-
 		bond_dev = alloc_netdev(sizeof(struct bonding), "", ether_setup);
 		if (!bond_dev) {
 			res = -ENOMEM;
@@ -5008,8 +5009,11 @@ static int __init bonding_init(void)
 
 		res = dev_alloc_name(bond_dev, "bond%d");
 		if (res < 0) {
-			free_netdev(bond_dev);
-			goto out_err;
+			goto out_dev;
+		}
+		
+		if ((res = bond_check_params(&params, i)) < 0){
+			goto out_dev;
 		}
 
 		/* bond_init() must be called after dev_alloc_name() (for the
@@ -5018,8 +5022,7 @@ static int __init bonding_init(void)
 		 */
 		res = bond_init(bond_dev, &params);
 		if (res < 0) {
-			free_netdev(bond_dev);
-			goto out_err;
+			goto out_dev;
 		}
 
 		SET_MODULE_OWNER(bond_dev);
@@ -5027,8 +5030,7 @@ static int __init bonding_init(void)
 		res = register_netdevice(bond_dev);
 		if (res < 0) {
 			bond_deinit(bond_dev);
-			free_netdev(bond_dev);
-			goto out_err;
+			goto out_dev;
 		}
 	}
 
@@ -5038,6 +5040,8 @@ static int __init bonding_init(void)
 
 	return 0;
 
+out_dev:
+	free_netdev(bond_dev);
 out_err:
 	/*
 	 * rtnl_unlock() will run netdev_run_todo(), putting the
diff --git a/drivers/net/bonding/bonding.h b/drivers/net/bonding/bonding.h
--- a/drivers/net/bonding/bonding.h
+++ b/drivers/net/bonding/bonding.h
@@ -46,6 +46,7 @@
 #define DRV_DESCRIPTION	"Ethernet Channel Bonding Driver"
 
 #define BOND_MAX_ARP_TARGETS	16
+#define BOND_MAX_PARMS		16
 
 #ifdef BONDING_DEBUG
 #define dprintk(fmt, args...) \
