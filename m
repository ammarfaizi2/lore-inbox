Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293256AbSBQSf1>; Sun, 17 Feb 2002 13:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293265AbSBQSfS>; Sun, 17 Feb 2002 13:35:18 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:24530 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S293256AbSBQSe7>;
	Sun, 17 Feb 2002 13:34:59 -0500
Date: Sun, 17 Feb 2002 19:30:51 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Cc: khc@pm.waw.pl, davem@redhat.com, torvalds@transmeta.com,
        jgarzik@mandrakesoft.com
Subject: [PATCH] HDLC patch for 2.5.5 (1/3)
Message-ID: <20020217193051.C14629@se1.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1/3]:
- struct if_settings in struct ifreq becomes struct if_settings *
- anonymous data pointer in struct if_settings is now a pointer to a
  union of struct containing l2 parameters. So far, hdlc_settings is 
  the only one available
- struct hdlc_settings is declared in (new) include/linux/hdlc/ioctl.h.
  The underlying settings (raw hdlc, cisco, fr) are moved from
  include/linux/hdlc.h to here
- shortcuts for accessing protocol specific settings are defined in
  include/linux/hdlc/ioctl.h (shamelessly inspired from 
  #define ifr_map ifr_ifru.ifru_map and friends)


diff -burpN linux-2.5.5-pre1-kh/include/linux/hdlc/ioctl.h linux-2.5.5-pre1-ma_pomme/include/linux/hdlc/ioctl.h
--- linux-2.5.5-pre1-kh/include/linux/hdlc/ioctl.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.5-pre1-ma_pomme/include/linux/hdlc/ioctl.h	Sun Feb 17 17:42:10 2002
@@ -0,0 +1,61 @@
+#ifndef __HDLC_IOCTL_H__
+#define __HDLC_IOCTL_H__
+
+typedef struct { 
+	unsigned int clock_rate; /* bits per second */
+	unsigned int clock_type; /* internal, external, TX-internal etc. */
+	unsigned short loopback;
+} sync_serial_settings;          /* V.35, V.24, X.21 */
+
+typedef struct { 
+	unsigned int clock_rate; /* bits per second */
+	unsigned int clock_type; /* internal, external, TX-internal etc. */
+	unsigned short loopback;
+	unsigned int slot_map;
+} te1_settings;                  /* T1, E1 */
+
+typedef struct {
+	unsigned short encoding;
+	unsigned short parity;
+} raw_hdlc_proto;
+
+typedef struct {
+	unsigned int t391;
+	unsigned int t392;
+	unsigned int n391;
+	unsigned int n392;
+	unsigned int n393;
+	unsigned short lmi;
+	unsigned short dce; /* 1 for DCE (network side) operation */
+} fr_proto;
+
+typedef struct {
+	unsigned int dlci;
+} fr_proto_pvc;          /* for creating/deleting FR PVCs */
+
+typedef struct {
+    unsigned int interval;
+    unsigned int timeout;
+} cisco_proto;
+
+/* PPP doesn't need any info now - supply length = 0 to ioctl */
+
+struct hdlc_settings {
+	union {
+		raw_hdlc_proto		raw_hdlc;
+		cisco_proto		cisco;
+		fr_proto		fr;
+		fr_proto_pvc		fr_pvc;
+		sync_serial_settings	sync;
+		te1_settings		te1;
+	} hdlcs_hdlcu;
+};
+
+#define hdlcs_raw	hdlcs_hdlcu.raw_hdlc
+#define hdlcs_cisco	hdlcs_hdlcu.cisco
+#define hdlcs_fr	hdlcs_hdlcu.fr
+#define hdlcs_pvc	hdlcs_hdlcu.fr_pvc
+#define hdlcs_sync	hdlcs_hdlcu.sync
+#define hdlcs_te1	hdlcs_hdlcu.te1
+
+#endif /* __HDLC_IOCTL_H__ */
diff -burpN linux-2.5.5-pre1-kh/include/linux/hdlc.h linux-2.5.5-pre1-ma_pomme/include/linux/hdlc.h
--- linux-2.5.5-pre1-kh/include/linux/hdlc.h	Sun Feb 17 17:44:14 2002
+++ linux-2.5.5-pre1-ma_pomme/include/linux/hdlc.h	Sun Feb 17 17:42:10 2002
@@ -18,20 +18,6 @@
 #define CLOCK_TXINT	3	/* Internal TX and external RX clock */
 #define CLOCK_TXFROMRX	4	/* TX clock derived from external RX clock */
 
-typedef struct {
-	unsigned int clock_rate; /* bits per second */
-	unsigned int clock_type; /* internal, external, TX-internal etc. */
-	unsigned short loopback;
-}sync_serial_settings;		/* V.35, V.24, X.21 */
-
-typedef struct {
-	unsigned int clock_rate; /* bits per second */
-	unsigned int clock_type; /* internal, external, TX-internal etc. */
-	unsigned short loopback;
-	unsigned int slot_map;
-}te1_settings;			/* T1, E1 */
-
-
 
 #define ENCODING_DEFAULT	0 /* Default (current) setting */
 #define ENCODING_NRZ		1
@@ -50,38 +36,11 @@ typedef struct {
 #define PARITY_CRC32_PR0_CCITT	6 /* CRC32, initial value 0x00000000 */
 #define PARITY_CRC32_PR1_CCITT	7 /* CRC32, initial value 0xFFFFFFFF */
 
-typedef struct {
-	unsigned short encoding;
-	unsigned short parity;
-}raw_hdlc_proto;
-
-
 #define LMI_DEFAULT		0 /* Default (current) setting */
 #define LMI_NONE		1 /* No LMI, all PVCs are static */
 #define LMI_ANSI		2 /* ANSI Annex D */
 #define LMI_CCITT		3 /* ITU-T Annex A */
 
-typedef struct {
-	unsigned int t391;
-	unsigned int t392;
-	unsigned int n391;
-	unsigned int n392;
-	unsigned int n393;
-	unsigned short lmi;
-	unsigned short dce;	/* 1 for DCE (network side) operation */
-}fr_proto;
-
-typedef struct {
-	unsigned int dlci;
-}fr_proto_pvc;			/* for creating/deleting FR PVCs */
-
-
-typedef struct {
-	unsigned int interval;
-	unsigned int timeout;
-}cisco_proto;
-
-
 /* PPP doesn't need any info now - supply length = 0 to ioctl */
 
 
@@ -90,6 +49,7 @@ typedef struct {
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 #include <net/syncppp.h>
+#include <linux/hdlc/ioctl.h>
 
 #define HDLC_MAX_MTU 1500	/* Ethernet 1500 bytes */
 #define HDLC_MAX_MRU (HDLC_MAX_MTU + 10) /* max 10 bytes for FR */
diff -burpN linux-2.5.5-pre1-kh/include/linux/if.h linux-2.5.5-pre1-ma_pomme/include/linux/if.h
--- linux-2.5.5-pre1-kh/include/linux/if.h	Sun Feb 17 17:39:24 2002
+++ linux-2.5.5-pre1-ma_pomme/include/linux/if.h	Sun Feb 17 17:42:10 2002
@@ -21,6 +21,7 @@
 
 #include <linux/types.h>		/* for "__kernel_caddr_t" et al	*/
 #include <linux/socket.h>		/* for "struct sockaddr" et al	*/
+#include <linux/hdlc/ioctl.h>
 
 /* Standard interface flags (netdevice->flags). */
 #define	IFF_UP		0x1		/* interface is up		*/
@@ -95,10 +96,13 @@ struct ifmap 
 struct if_settings
 {
 	unsigned int type;	/* Type of physical device or protocol */
-	unsigned int data_length; /* device/protocol data length */
-	void * data;		/* pointer to data, ignored if length = 0 */
+	union {
+		/* {atm/eth/dsl}_settings anyone ? */
+		struct hdlc_settings ifsu_hdlc;
+	} ifs_ifsu;
 };
 
+#define ifs_hdlc       ifs_ifsu.ifsu_hdlc
 
 /*
  * Interface request structure used for socket
@@ -129,7 +133,7 @@ struct ifreq 
 		char	ifru_slave[IFNAMSIZ];	/* Just fits the size */
 		char	ifru_newname[IFNAMSIZ];
 		char *	ifru_data;
-		struct	if_settings ifru_settings;
+		struct	if_settings *ifru_settings;
 	} ifr_ifru;
 };
 
