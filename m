Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266808AbUG1Hpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266808AbUG1Hpx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 03:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266820AbUG1Hpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 03:45:53 -0400
Received: from ozlabs.org ([203.10.76.45]:9354 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266808AbUG1HLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 03:11:50 -0400
Date: Wed, 28 Jul 2004 17:00:41 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>, Francois Romieu <romieu@fr.zoreil.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>, jt@hpl.hp.com,
       Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>
Subject: [14/15] orinoco merge preliminaries - more HW data
Message-ID: <20040728070041.GQ16908@zax>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	jt@hpl.hp.com, Dan Williams <dcbw@redhat.com>,
	Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>
References: <20040728065450.GG16908@zax> <20040728065526.GH16908@zax> <20040728065550.GI16908@zax> <20040728065659.GJ16908@zax> <20040728065725.GK16908@zax> <20040728065800.GL16908@zax> <20040728065827.GM16908@zax> <20040728065913.GN16908@zax> <20040728065953.GO16908@zax> <20040728070018.GP16908@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728070018.GP16908@zax>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update various constants and structures in orinoco header files.  The
updates generally represent either newer hardware/firmware features,
or corrections to what we know about hardware/firmware functions.

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/hermes.h
===================================================================
--- working-2.6.orig/drivers/net/wireless/hermes.h	2004-07-28 16:29:53.597301344 +1000
+++ working-2.6/drivers/net/wireless/hermes.h	2004-07-28 16:35:12.151873688 +1000
@@ -133,7 +133,6 @@
 /*--- Buffer Mgmt Commands ---------------------------*/
 #define		HERMES_CMD_ALLOC		(0x000A)
 #define		HERMES_CMD_TX			(0x000B)
-#define		HERMES_CMD_CLRPRST		(0x0012)
 
 /*--- Regulate Commands ------------------------------*/
 #define		HERMES_CMD_NOTIFY		(0x0010)
@@ -143,10 +142,34 @@
 #define		HERMES_CMD_ACCESS		(0x0021)
 #define		HERMES_CMD_DOWNLD		(0x0022)
 
+/*--- Serial I/O Commands ----------------------------*/
+#define		HERMES_CMD_READMIF		(0x0030)
+#define		HERMES_CMD_WRITEMIF		(0x0031)
+
 /*--- Debugging Commands -----------------------------*/
-#define 	HERMES_CMD_MONITOR		(0x0038)
-#define		HERMES_MONITOR_ENABLE		(0x000b)
-#define		HERMES_MONITOR_DISABLE		(0x000f)
+#define 	HERMES_CMD_TEST			(0x0038)
+
+
+/* Test command arguments */
+#define		HERMES_TEST_SET_CHANNEL		0x0800
+#define		HERMES_TEST_MONITOR		0x0b00
+#define		HERMES_TEST_STOP		0x0f00
+
+/* Authentication algorithms */
+#define		HERMES_AUTH_OPEN		1
+#define		HERMES_AUTH_SHARED_KEY		2
+
+/* WEP settings */
+#define		HERMES_WEP_PRIVACY_INVOKED	0x0001
+#define		HERMES_WEP_EXCL_UNENCRYPTED	0x0002
+#define		HERMES_WEP_HOST_ENCRYPT		0x0010
+#define		HERMES_WEP_HOST_DECRYPT		0x0080
+
+/* Symbol hostscan options */
+#define		HERMES_HOSTSCAN_SYMBOL_5SEC	0x0001
+#define		HERMES_HOSTSCAN_SYMBOL_ONCE	0x0002
+#define		HERMES_HOSTSCAN_SYMBOL_PASSIVE	0x0040
+#define		HERMES_HOSTSCAN_SYMBOL_BCAST	0x0080
 
 /*
  * Frame structures and constants
@@ -191,7 +214,11 @@
 
 #define HERMES_INQ_TALLIES		(0xF100)
 #define HERMES_INQ_SCAN			(0xF101)
+#define HERMES_INQ_CHANNELINFO		(0xF102)
+#define HERMES_INQ_HOSTSCAN		(0xF103)
+#define HERMES_INQ_HOSTSCAN_SYMBOL	(0xF104)
 #define HERMES_INQ_LINKSTATUS		(0xF200)
+#define HERMES_INQ_SEC_STAT_AGERE	(0xF202)
 
 struct hermes_tallies_frame {
 	u16 TxUnicastFrames;
@@ -223,23 +250,58 @@
 /* Grabbed from wlan-ng - Thanks Mark... - Jean II
  * This is the result of a scan inquiry command */
 /* Structure describing info about an Access Point */
-struct hermes_scan_apinfo {
+struct prism2_scan_apinfo {
 	u16 channel;		/* Channel where the AP sits */
 	u16 noise;		/* Noise level */
 	u16 level;		/* Signal level */
 	u8 bssid[ETH_ALEN];	/* MAC address of the Access Point */
-	u16 beacon_interv;	/* Beacon interval ? */
-	u16 capabilities;	/* Capabilities ? */
+	u16 beacon_interv;	/* Beacon interval */
+	u16 capabilities;	/* Capabilities */
+	u16 essid_len;		/* ESSID length */
 	u8 essid[32];		/* ESSID of the network */
 	u8 rates[10];		/* Bit rate supported */
-	u16 proberesp_rate;	/* ???? */
+	u16 proberesp_rate;	/* Data rate of the response frame */
+	u16 atim;		/* ATIM window time, Kus (hostscan only) */
+} __attribute__ ((packed));
+
+/* Same stuff for the Lucent/Agere card.
+ * Thanks to h1kari <h1kari AT dachb0den.com> - Jean II */
+struct agere_scan_apinfo {
+	u16 channel;		/* Channel where the AP sits */
+	u16 noise;		/* Noise level */
+	u16 level;		/* Signal level */
+	u8 bssid[ETH_ALEN];	/* MAC address of the Access Point */
+	u16 beacon_interv;	/* Beacon interval */
+	u16 capabilities;	/* Capabilities */
+	/* bits: 0-ess, 1-ibss, 4-privacy [wep] */
+	u16 essid_len;		/* ESSID length */
+	u8 essid[32];		/* ESSID of the network */
 } __attribute__ ((packed));
-/* Container */
-struct hermes_scan_frame {
-	u16 rsvd;                   /* ??? */
-	u16 scanreason;             /* ??? */
-	struct hermes_scan_apinfo aps[35];        /* Scan result */
+
+/* Moustafa: Scan structure for Symbol cards */
+struct symbol_scan_apinfo {
+	u8 channel;		/* Channel where the AP sits */
+	u8 unknown1;		/* 8 in 2.9x and 3.9x f/w, 0 otherwise */
+	u16 noise;		/* Noise level */
+	u16 level;		/* Signal level */
+	u8 bssid[ETH_ALEN];	/* MAC address of the Access Point */
+	u16 beacon_interv;	/* Beacon interval */
+	u16 capabilities;	/* Capabilities */
+	/* bits: 0-ess, 1-ibss, 4-privacy [wep] */
+	u16 essid_len;		/* ESSID length */
+	u8 essid[32];		/* ESSID of the network */
+    	u16 rates[5];		/* Bit rate supported */
+	u16 basic_rates;	/* Basic rates bitmask */
+	u8 unknown2[6];		/* Always FF:FF:FF:FF:00:00 */
+	u8 unknown3[8];		/* Always 0, appeared in f/w 3.91-68 */
 } __attribute__ ((packed));
+
+union hermes_scan_info {
+	struct agere_scan_apinfo	a;
+	struct prism2_scan_apinfo	p;
+	struct symbol_scan_apinfo	s;
+};
+
 #define HERMES_LINKSTATUS_NOT_CONNECTED   (0x0000)  
 #define HERMES_LINKSTATUS_CONNECTED       (0x0001)
 #define HERMES_LINKSTATUS_DISCONNECTED    (0x0002)
Index: working-2.6/drivers/net/wireless/hermes_rid.h
===================================================================
--- working-2.6.orig/drivers/net/wireless/hermes_rid.h	2004-07-28 16:29:52.115526608 +1000
+++ working-2.6/drivers/net/wireless/hermes_rid.h	2004-07-28 16:29:53.968244952 +1000
@@ -28,6 +28,7 @@
 #define HERMES_RID_CNFWDSADDRESS6		0xFC16
 #define HERMES_RID_CNFMULTICASTPMBUFFERING	0xFC17
 #define HERMES_RID_CNFWEPENABLED_AGERE		0xFC20
+#define HERMES_RID_CNFAUTHENTICATION_AGERE	0xFC21
 #define HERMES_RID_CNFMANDATORYBSSID_SYMBOL	0xFC21
 #define HERMES_RID_CNFWEPDEFAULTKEYID		0xFC23
 #define HERMES_RID_CNFDEFAULTKEY0		0xFC24
@@ -75,11 +76,13 @@
 #define HERMES_RID_CNFRTSTHRESHOLD4		0xFC9B
 #define HERMES_RID_CNFRTSTHRESHOLD5		0xFC9C
 #define HERMES_RID_CNFRTSTHRESHOLD6		0xFC9D
+#define HERMES_RID_CNFHOSTSCAN_SYMBOL		0xFCAB
 #define HERMES_RID_CNFSHORTPREAMBLE		0xFCB0
 #define HERMES_RID_CNFWEPKEYS_AGERE		0xFCB0
 #define HERMES_RID_CNFEXCLUDELONGPREAMBLE	0xFCB1
 #define HERMES_RID_CNFTXKEY_AGERE		0xFCB1
 #define HERMES_RID_CNFAUTHENTICATIONRSPTO	0xFCB2
+#define HERMES_RID_CNFSCANSSID_AGERE		0xFCB2
 #define HERMES_RID_CNFBASICRATES		0xFCB3
 #define HERMES_RID_CNFSUPPORTEDRATES		0xFCB4
 #define HERMES_RID_CNFTICKTIME			0xFCE0
@@ -87,6 +90,7 @@
 #define HERMES_RID_CNFJOINREQUEST		0xFCE2
 #define HERMES_RID_CNFAUTHENTICATESTATION	0xFCE3
 #define HERMES_RID_CNFCHANNELINFOREQUEST	0xFCE4
+#define HERMES_RID_CNFHOSTSCAN			0xFCE5
 
 /*
  * Information RIDs
@@ -124,6 +128,7 @@
 #define HERMES_RID_CFPOLLABLE			0xFD4C
 #define HERMES_RID_AUTHENTICATIONALGORITHMS	0xFD4D
 #define HERMES_RID_PRIVACYOPTIONIMPLEMENTED	0xFD4F
+#define HERMES_RID_DBMCOMMSQUALITY_INTERSIL	0xFD51
 #define HERMES_RID_CURRENTTXRATE1		0xFD80
 #define HERMES_RID_CURRENTTXRATE2		0xFD81
 #define HERMES_RID_CURRENTTXRATE3		0xFD82

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
