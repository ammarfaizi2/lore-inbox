Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVC3Dsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVC3Dsn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 22:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbVC3Dqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 22:46:55 -0500
Received: from ozlabs.org ([203.10.76.45]:62637 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261744AbVC3DqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 22:46:22 -0500
Date: Wed, 30 Mar 2005 13:44:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>, Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [3/5] Orinoco merge updates, part the fourth: kill dump_recs
Message-ID: <20050330034429.GI6478@localhost.localdomain>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20050330034238.GF6478@localhost.localdomain> <20050330034316.GG6478@localhost.localdomain> <20050330034403.GH6478@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050330034403.GH6478@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the dump_recs debugging iwpriv command.  It will be replaced
later with the simpler and more flexible get_rid command.

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/orinoco.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.c	2005-03-24 15:57:43.000000000 +1100
+++ working-2.6/drivers/net/wireless/orinoco.c	2005-03-24 15:57:44.000000000 +1100
@@ -607,7 +607,6 @@
 static int orinoco_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static int __orinoco_program_rids(struct net_device *dev);
 static void __orinoco_set_multicast_list(struct net_device *dev);
-static int orinoco_debug_dump_recs(struct net_device *dev);
 
 /********************************************************************/
 /* Internal helper functions                                        */
@@ -3861,7 +3860,6 @@
 				{ SIOCIWFIRSTPRIV + 0x7, 0,
 				  IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1,
 				  "get_ibssport" },
-				{ SIOCIWLASTPRIV, 0, 0, "dump_recs" },
 			};
 
 			wrq->u.data.length = sizeof(privtab) / sizeof(privtab[0]);
@@ -3949,14 +3947,6 @@
 		err = orinoco_ioctl_getibssport(dev, wrq);
 		break;
 
-	case SIOCIWLASTPRIV:
-		err = orinoco_debug_dump_recs(dev);
-		if (err)
-			printk(KERN_ERR "%s: Unable to dump records (%d)\n",
-			       dev->name, err);
-		break;
-
-
 	default:
 		err = -EOPNOTSUPP;
 	}
@@ -3970,187 +3960,6 @@
 	return err;
 }
 
-struct {
-	u16 rid;
-	char *name;
-	int displaytype;
-#define DISPLAY_WORDS	0
-#define DISPLAY_BYTES	1
-#define DISPLAY_STRING	2
-#define DISPLAY_XSTRING	3
-} record_table[] = {
-#define DEBUG_REC(name,type) { HERMES_RID_##name, #name, DISPLAY_##type }
-	DEBUG_REC(CNFPORTTYPE,WORDS),
-	DEBUG_REC(CNFOWNMACADDR,BYTES),
-	DEBUG_REC(CNFDESIREDSSID,STRING),
-	DEBUG_REC(CNFOWNCHANNEL,WORDS),
-	DEBUG_REC(CNFOWNSSID,STRING),
-	DEBUG_REC(CNFOWNATIMWINDOW,WORDS),
-	DEBUG_REC(CNFSYSTEMSCALE,WORDS),
-	DEBUG_REC(CNFMAXDATALEN,WORDS),
-	DEBUG_REC(CNFPMENABLED,WORDS),
-	DEBUG_REC(CNFPMEPS,WORDS),
-	DEBUG_REC(CNFMULTICASTRECEIVE,WORDS),
-	DEBUG_REC(CNFMAXSLEEPDURATION,WORDS),
-	DEBUG_REC(CNFPMHOLDOVERDURATION,WORDS),
-	DEBUG_REC(CNFOWNNAME,STRING),
-	DEBUG_REC(CNFOWNDTIMPERIOD,WORDS),
-	DEBUG_REC(CNFMULTICASTPMBUFFERING,WORDS),
-	DEBUG_REC(CNFWEPENABLED_AGERE,WORDS),
-	DEBUG_REC(CNFMANDATORYBSSID_SYMBOL,WORDS),
-	DEBUG_REC(CNFWEPDEFAULTKEYID,WORDS),
-	DEBUG_REC(CNFDEFAULTKEY0,BYTES),
-	DEBUG_REC(CNFDEFAULTKEY1,BYTES),
-	DEBUG_REC(CNFMWOROBUST_AGERE,WORDS),
-	DEBUG_REC(CNFDEFAULTKEY2,BYTES),
-	DEBUG_REC(CNFDEFAULTKEY3,BYTES),
-	DEBUG_REC(CNFWEPFLAGS_INTERSIL,WORDS),
-	DEBUG_REC(CNFWEPKEYMAPPINGTABLE,WORDS),
-	DEBUG_REC(CNFAUTHENTICATION,WORDS),
-	DEBUG_REC(CNFMAXASSOCSTA,WORDS),
-	DEBUG_REC(CNFKEYLENGTH_SYMBOL,WORDS),
-	DEBUG_REC(CNFTXCONTROL,WORDS),
-	DEBUG_REC(CNFROAMINGMODE,WORDS),
-	DEBUG_REC(CNFHOSTAUTHENTICATION,WORDS),
-	DEBUG_REC(CNFRCVCRCERROR,WORDS),
-	DEBUG_REC(CNFMMLIFE,WORDS),
-	DEBUG_REC(CNFALTRETRYCOUNT,WORDS),
-	DEBUG_REC(CNFBEACONINT,WORDS),
-	DEBUG_REC(CNFAPPCFINFO,WORDS),
-	DEBUG_REC(CNFSTAPCFINFO,WORDS),
-	DEBUG_REC(CNFPRIORITYQUSAGE,WORDS),
-	DEBUG_REC(CNFTIMCTRL,WORDS),
-	DEBUG_REC(CNFTHIRTY2TALLY,WORDS),
-	DEBUG_REC(CNFENHSECURITY,WORDS),
-	DEBUG_REC(CNFGROUPADDRESSES,BYTES),
-	DEBUG_REC(CNFCREATEIBSS,WORDS),
-	DEBUG_REC(CNFFRAGMENTATIONTHRESHOLD,WORDS),
-	DEBUG_REC(CNFRTSTHRESHOLD,WORDS),
-	DEBUG_REC(CNFTXRATECONTROL,WORDS),
-	DEBUG_REC(CNFPROMISCUOUSMODE,WORDS),
-	DEBUG_REC(CNFBASICRATES_SYMBOL,WORDS),
-	DEBUG_REC(CNFPREAMBLE_SYMBOL,WORDS),
-	DEBUG_REC(CNFSHORTPREAMBLE,WORDS),
-	DEBUG_REC(CNFWEPKEYS_AGERE,BYTES),
-	DEBUG_REC(CNFEXCLUDELONGPREAMBLE,WORDS),
-	DEBUG_REC(CNFTXKEY_AGERE,WORDS),
-	DEBUG_REC(CNFAUTHENTICATIONRSPTO,WORDS),
-	DEBUG_REC(CNFBASICRATES,WORDS),
-	DEBUG_REC(CNFSUPPORTEDRATES,WORDS),
-	DEBUG_REC(CNFTICKTIME,WORDS),
-	DEBUG_REC(CNFSCANREQUEST,WORDS),
-	DEBUG_REC(CNFJOINREQUEST,WORDS),
-	DEBUG_REC(CNFAUTHENTICATESTATION,WORDS),
-	DEBUG_REC(CNFCHANNELINFOREQUEST,WORDS),
-	DEBUG_REC(MAXLOADTIME,WORDS),
-	DEBUG_REC(DOWNLOADBUFFER,WORDS),
-	DEBUG_REC(PRIID,WORDS),
-	DEBUG_REC(PRISUPRANGE,WORDS),
-	DEBUG_REC(CFIACTRANGES,WORDS),
-	DEBUG_REC(NICSERNUM,XSTRING),
-	DEBUG_REC(NICID,WORDS),
-	DEBUG_REC(MFISUPRANGE,WORDS),
-	DEBUG_REC(CFISUPRANGE,WORDS),
-	DEBUG_REC(CHANNELLIST,WORDS),
-	DEBUG_REC(REGULATORYDOMAINS,WORDS),
-	DEBUG_REC(TEMPTYPE,WORDS),
-/*  	DEBUG_REC(CIS,BYTES), */
-	DEBUG_REC(STAID,WORDS),
-	DEBUG_REC(CURRENTSSID,STRING),
-	DEBUG_REC(CURRENTBSSID,BYTES),
-	DEBUG_REC(COMMSQUALITY,WORDS),
-	DEBUG_REC(CURRENTTXRATE,WORDS),
-	DEBUG_REC(CURRENTBEACONINTERVAL,WORDS),
-	DEBUG_REC(CURRENTSCALETHRESHOLDS,WORDS),
-	DEBUG_REC(PROTOCOLRSPTIME,WORDS),
-	DEBUG_REC(SHORTRETRYLIMIT,WORDS),
-	DEBUG_REC(LONGRETRYLIMIT,WORDS),
-	DEBUG_REC(MAXTRANSMITLIFETIME,WORDS),
-	DEBUG_REC(MAXRECEIVELIFETIME,WORDS),
-	DEBUG_REC(CFPOLLABLE,WORDS),
-	DEBUG_REC(AUTHENTICATIONALGORITHMS,WORDS),
-	DEBUG_REC(PRIVACYOPTIONIMPLEMENTED,WORDS),
-	DEBUG_REC(OWNMACADDR,BYTES),
-	DEBUG_REC(SCANRESULTSTABLE,WORDS),
-	DEBUG_REC(PHYTYPE,WORDS),
-	DEBUG_REC(CURRENTCHANNEL,WORDS),
-	DEBUG_REC(CURRENTPOWERSTATE,WORDS),
-	DEBUG_REC(CCAMODE,WORDS),
-	DEBUG_REC(SUPPORTEDDATARATES,WORDS),
-	DEBUG_REC(BUILDSEQ,BYTES),
-	DEBUG_REC(FWID,XSTRING)
-#undef DEBUG_REC
-};
-
-#define DEBUG_LTV_SIZE		128
-
-static int orinoco_debug_dump_recs(struct net_device *dev)
-{
-	struct orinoco_private *priv = netdev_priv(dev);
-	hermes_t *hw = &priv->hw;
-	u8 *val8;
-	u16 *val16;
-	int i,j;
-	u16 length;
-	int err;
-
-	/* I'm not sure: we might have a lock here, so we'd better go
-           atomic, just in case. */
-	val8 = kmalloc(DEBUG_LTV_SIZE + 2, GFP_ATOMIC);
-	if (! val8)
-		return -ENOMEM;
-	val16 = (u16 *)val8;
-
-	for (i = 0; i < ARRAY_SIZE(record_table); i++) {
-		u16 rid = record_table[i].rid;
-		int len;
-
-		memset(val8, 0, DEBUG_LTV_SIZE + 2);
-
-		err = hermes_read_ltv(hw, USER_BAP, rid, DEBUG_LTV_SIZE,
-				      &length, val8);
-		if (err) {
-			DEBUG(0, "Error %d reading RID 0x%04x\n", err, rid);
-			continue;
-		}
-		val16 = (u16 *)val8;
-		if (length == 0)
-			continue;
-
-		printk(KERN_DEBUG "%-15s (0x%04x): length=%d (%d bytes)\tvalue=",
-		       record_table[i].name,
-		       rid, length, (length-1)*2);
-		len = min(((int)length-1)*2, DEBUG_LTV_SIZE);
-
-		switch (record_table[i].displaytype) {
-		case DISPLAY_WORDS:
-			for (j = 0; j < len / 2; j++)
-				printk("%04X-", le16_to_cpu(val16[j]));
-			break;
-
-		case DISPLAY_BYTES:
-		default:
-			for (j = 0; j < len; j++)
-				printk("%02X:", val8[j]);
-			break;
-
-		case DISPLAY_STRING:
-			len = min(len, le16_to_cpu(val16[0])+2);
-			val8[len] = '\0';
-			printk("\"%s\"", (char *)&val16[1]);
-			break;
-
-		case DISPLAY_XSTRING:
-			printk("'%s'", (char *)val8);
-		}
-
-		printk("\n");
-	}
-
-	kfree(val8);
-
-	return 0;
-}
 
 /********************************************************************/
 /* Debugging                                                        */

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
