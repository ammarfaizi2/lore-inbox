Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUISRec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUISRec (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 13:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUISRec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 13:34:32 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:50951 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261405AbUISReE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 13:34:04 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] reduce stack usage in ixgb_ethtool_ioctl
Date: Sun, 19 Sep 2004 20:33:56 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_EMcTBA3AeMpym9O"
Message-Id: <200409192033.56716.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_EMcTBA3AeMpym9O
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Stack usage reduced from 3024 (!) to 576.
Most of those 3k came from a bug:

#define IXGB_REG_DUMP_LEN  136*sizeof(uint32_t)
                              ^^^^^^^^^^^^^^^^^
...
uint32_t regs_buff[IXGB_REG_DUMP_LEN];

Bug fixed. Two large on-stack variables moved to kmalloc space.

Stack usage is still high because gcc will
allocate too much space for these cases:

        case ETHTOOL_GSET:{
                        struct ethtool_cmd ecmd = { ETHTOOL_GSET };
                        ixgb_ethtool_gset(adapter, &ecmd);
                        if (copy_to_user(addr, &ecmd, sizeof(ecmd)))
                                return -EFAULT;
                        return 0;
                }
        case ETHTOOL_SSET:{
                        struct ethtool_cmd ecmd;
                        if (copy_from_user(&ecmd, addr, sizeof(ecmd)))
                                return -EFAULT;
                        return ixgb_ethtool_sset(adapter, &ecmd);
                }

There will be space for _two_ ecmd's on stack.

Shall it be worked around with ugly union of structs
or we'll just wait for better gcc?

Compile-tested only.
--
vda

--Boundary-00=_EMcTBA3AeMpym9O
Content-Type: text/x-diff;
  charset="koi8-r";
  name="linux-2.6.9-rc2.ixgb_ethtool.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.6.9-rc2.ixgb_ethtool.patch"

diff -urp linux-2.6.9-rc2.src/drivers/net/ixgb/ixgb_ethtool.c linux-2.6.9-rc2.ldelf/drivers/net/ixgb/ixgb_ethtool.c
--- linux-2.6.9-rc2.src/drivers/net/ixgb/ixgb_ethtool.c	Sat Aug 14 13:56:09 2004
+++ linux-2.6.9-rc2.ldelf/drivers/net/ixgb/ixgb_ethtool.c	Sun Sep 19 20:20:12 2004
@@ -180,8 +180,8 @@ ixgb_ethtool_gdrvinfo(struct ixgb_adapte
 	strncpy(drvinfo->fw_version, "N/A", 32);
 	strncpy(drvinfo->bus_info, pci_name(adapter->pdev), 32);
 	drvinfo->n_stats = IXGB_STATS_LEN;
-#define IXGB_REG_DUMP_LEN  136*sizeof(uint32_t)
-	drvinfo->regdump_len = IXGB_REG_DUMP_LEN;
+#define IXGB_REG_DUMP_CNT  136
+	drvinfo->regdump_len = IXGB_REG_DUMP_CNT*sizeof(uint32_t);
 	drvinfo->eedump_len = ixgb_eeprom_size(&adapter->hw);
 }
 
@@ -459,6 +459,7 @@ int ixgb_ethtool_ioctl(struct net_device
 	struct ixgb_adapter *adapter = netdev->priv;
 	void __user *addr = ifr->ifr_data;
 	uint32_t cmd;
+	int err;
 
 	if (get_user(cmd, (uint32_t __user *) addr))
 		return -EFAULT;
@@ -487,8 +488,8 @@ int ixgb_ethtool_ioctl(struct net_device
 	case ETHTOOL_GSTRINGS:{
 			struct ethtool_gstrings gstrings = { ETHTOOL_GSTRINGS };
 			char *strings = NULL;
-			int err = 0;
 
+			err = 0;
 			if (copy_from_user(&gstrings, addr, sizeof(gstrings)))
 				return -EFAULT;
 			switch (gstrings.string_set) {
@@ -526,19 +527,28 @@ int ixgb_ethtool_ioctl(struct net_device
 		}
 	case ETHTOOL_GREGS:{
 			struct ethtool_regs regs = { ETHTOOL_GREGS };
-			uint32_t regs_buff[IXGB_REG_DUMP_LEN];
+			uint32_t *regs_buff;
 
+			err = -ENOMEM;
+			regs_buff = kmalloc(sizeof(*regs_buff)*IXGB_REG_DUMP_CNT, GFP_KERNEL);
+			if (!regs_buff)
+				goto ret_err;
+
+			err = -EFAULT;
 			if (copy_from_user(&regs, addr, sizeof(regs)))
-				return -EFAULT;
+				goto ret_err;
 			ixgb_ethtool_gregs(adapter, &regs, regs_buff);
 			if (copy_to_user(addr, &regs, sizeof(regs)))
-				return -EFAULT;
+				goto ret_err;
 
 			addr += offsetof(struct ethtool_regs, data);
 			if (copy_to_user(addr, regs_buff, regs.len))
-				return -EFAULT;
+				goto ret_err;
+			err = 0;
 
-			return 0;
+		ret_err:
+			kfree(regs_buff);
+			return err;
 		}
 	case ETHTOOL_NWAY_RST:{
 			if (netif_running(netdev)) {
@@ -565,8 +575,8 @@ int ixgb_ethtool_ioctl(struct net_device
 			struct ethtool_eeprom eeprom = { ETHTOOL_GEEPROM };
 			uint16_t eeprom_buff[IXGB_EEPROM_SIZE];
 			void *ptr;
-			int err = 0;
 
+			err = 0;
 			if (copy_from_user(&eeprom, addr, sizeof(eeprom)))
 				return -EFAULT;
 
@@ -609,15 +619,20 @@ int ixgb_ethtool_ioctl(struct net_device
 			return ixgb_ethtool_spause(adapter, &epause);
 		}
 	case ETHTOOL_GSTATS:{
+			int i;
 			struct {
 				struct ethtool_stats eth_stats;
 				uint64_t data[IXGB_STATS_LEN];
-			} stats = { {
-			ETHTOOL_GSTATS, IXGB_STATS_LEN}};
-			int i;
+			} *stats;
+
+			stats = kmalloc(sizeof(*stats), GFP_KERNEL);
+			if (!stats)
+				return -ENOMEM;
+			stats->eth_stats.cmd = ETHTOOL_GSTATS;
+			stats->eth_stats.n_stats = IXGB_STATS_LEN;
 
 			for (i = 0; i < IXGB_STATS_LEN; i++)
-				stats.data[i] =
+				stats->data[i] =
 				    (ixgb_gstrings_stats[i].sizeof_stat ==
 				     sizeof(uint64_t)) ? *(uint64_t *) ((char *)
 									adapter
@@ -628,9 +643,11 @@ int ixgb_ethtool_ioctl(struct net_device
 				    : *(uint32_t *) ((char *)adapter +
 						     ixgb_gstrings_stats[i].
 						     stat_offset);
-			if (copy_to_user(addr, &stats, sizeof(stats)))
-				return -EFAULT;
-			return 0;
+			err = 0;
+			if (copy_to_user(addr, stats, sizeof(*stats)))
+				err = -EFAULT;
+			kfree(stats);
+			return err;
 		}
 	case ETHTOOL_GRXCSUM:{
 			struct ethtool_value edata = { ETHTOOL_GRXCSUM };

--Boundary-00=_EMcTBA3AeMpym9O--

