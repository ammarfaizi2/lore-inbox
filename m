Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbUKONdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbUKONdd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 08:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbUKONdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 08:33:33 -0500
Received: from spc1-leed3-6-0-cust18.seac.broadband.ntl.com ([80.7.68.18]:61130
	"EHLO fentible.pjc.net") by vger.kernel.org with ESMTP
	id S261592AbUKONdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 08:33:19 -0500
Date: Mon, 15 Nov 2004 13:33:18 +0000
From: Patrick Caulfield <patrick@tykepenguin.com>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org,
       DECnet list <linux-decnet-user@lists.sourceforge.net>
Subject: [PATCH] 2.6 Remove CONFIG_DECNET_SIOCGIFCONF
Message-ID: <20041115133318.GD886@tykepenguin.com>
Mail-Followup-To: davem@redhat.com, linux-kernel@vger.kernel.org,
	DECnet list <linux-decnet-user@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the config option DECNET_SIOCGIFCONF in Linux 2.6

It's only purpose seems to be to break ifconfig. It often gets enabled by
default by distributors who like to set everything on, and it just confuses
people.

The functionality is available via netlink anyway - which is what anyone using
DECnet will be using for configuration.


Signed-off-by: Patrick Caulfield <patrick@tykepenguin.com>

===== arch/mips/configs/rm200_defconfig 1.8 vs edited =====
--- 1.8/arch/mips/configs/rm200_defconfig	2004-08-10 00:41:35 +01:00
+++ edited/arch/mips/configs/rm200_defconfig	2004-11-12 13:21:33 +00:00
@@ -524,7 +524,6 @@
 CONFIG_BRIDGE=m
 # CONFIG_VLAN_8021Q is not set
 CONFIG_DECNET=m
-# CONFIG_DECNET_SIOCGIFCONF is not set
 # CONFIG_DECNET_ROUTER is not set
 # CONFIG_LLC2 is not set
 # CONFIG_IPX is not set
===== arch/sparc64/defconfig 1.147 vs edited =====
--- 1.147/arch/sparc64/defconfig	2004-10-31 21:20:37 +00:00
+++ edited/arch/sparc64/defconfig	2004-11-12 13:21:46 +00:00
@@ -693,7 +693,6 @@
 CONFIG_BRIDGE=m
 CONFIG_VLAN_8021Q=m
 CONFIG_DECNET=m
-CONFIG_DECNET_SIOCGIFCONF=y
 CONFIG_DECNET_ROUTER=y
 CONFIG_DECNET_ROUTE_FWMARK=y
 CONFIG_LLC=m
===== net/decnet/Kconfig 1.4 vs edited =====
--- 1.4/net/decnet/Kconfig	2004-02-07 00:24:19 +00:00
+++ edited/net/decnet/Kconfig	2004-11-12 13:22:08 +00:00
@@ -1,17 +1,6 @@
 #
 # DECnet configuration
 #
-config DECNET_SIOCGIFCONF
-	bool "DECnet: SIOCGIFCONF support"
-	depends on DECNET
-	help
-	  This option should only be turned on if you are really sure that
-	  you know what you are doing. It can break other applications which
-	  use this system call and the proper way to get the information
-	  provided by this call is to use rtnetlink.
-
-	  If unsure, say N.
-
 config DECNET_ROUTER
 	bool "DECnet: router support (EXPERIMENTAL)"
 	depends on DECNET && EXPERIMENTAL
===== net/decnet/dn_dev.c 1.27 vs edited =====
--- 1.27/net/decnet/dn_dev.c	2004-10-20 09:12:06 +01:00
+++ edited/net/decnet/dn_dev.c	2004-11-12 13:22:39 +00:00
@@ -1291,59 +1291,6 @@
 	return notifier_chain_unregister(&dnaddr_chain, nb);
 }
 
-#ifdef CONFIG_DECNET_SIOCGIFCONF
-/*
- * Now we support multiple addresses per interface.
- * Since we don't want to break existing code, you have to enable
- * it as a compile time option. Probably you should use the
- * rtnetlink interface instead.
- */
-int dnet_gifconf(struct net_device *dev, char __user *buf, int len)
-{
-	struct dn_dev *dn_db = (struct dn_dev *)dev->dn_ptr;
-	struct dn_ifaddr *ifa;
-	char buffer[DN_IFREQ_SIZE];
-	struct ifreq *ifr = (struct ifreq *)buffer;
-	struct sockaddr_dn *addr = (struct sockaddr_dn *)&ifr->ifr_addr;
-	int done = 0;
-
-	if ((dn_db == NULL) || ((ifa = dn_db->ifa_list) == NULL))
-		return 0;
-
-	for(; ifa; ifa = ifa->ifa_next) {
-		if (!buf) {
-			done += sizeof(DN_IFREQ_SIZE);
-			continue;
-		}
-		if (len < DN_IFREQ_SIZE)
-			return done;
-		memset(buffer, 0, DN_IFREQ_SIZE);
-
-		if (ifa->ifa_label)
-			strcpy(ifr->ifr_name, ifa->ifa_label);
-		else
-			strcpy(ifr->ifr_name, dev->name);
-
-		addr->sdn_family = AF_DECnet;
-		addr->sdn_add.a_len = 2;
-		memcpy(addr->sdn_add.a_addr, &ifa->ifa_local,
-			sizeof(dn_address));
-
-		if (copy_to_user(buf, buffer, DN_IFREQ_SIZE)) {
-			done = -EFAULT;
-			break;
-		}
-
-		buf  += DN_IFREQ_SIZE;
-		len  -= DN_IFREQ_SIZE;
-		done += DN_IFREQ_SIZE;
-	}
-
-	return done;
-}
-#endif /* CONFIG_DECNET_SIOCGIFCONF */
-
-
 #ifdef CONFIG_PROC_FS
 static inline struct net_device *dn_dev_get_next(struct seq_file *seq, struct net_device *dev)
 {
@@ -1502,9 +1449,6 @@
         decnet_address = dn_htons((addr[0] << 10) | addr[1]);
 
 	dn_dev_devices_on();
-#ifdef CONFIG_DECNET_SIOCGIFCONF
-	register_gifconf(PF_DECnet, dnet_gifconf);
-#endif /* CONFIG_DECNET_SIOCGIFCONF */
 
 	rtnetlink_links[PF_DECnet] = dnet_rtnetlink_table;
 
@@ -1522,10 +1466,6 @@
 void __exit dn_dev_cleanup(void)
 {
 	rtnetlink_links[PF_DECnet] = NULL;
-
-#ifdef CONFIG_DECNET_SIOCGIFCONF
-	unregister_gifconf(PF_DECnet);
-#endif /* CONFIG_DECNET_SIOCGIFCONF */
 
 #ifdef CONFIG_SYSCTL
 	{
