Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267013AbTCEXBp>; Wed, 5 Mar 2003 18:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266987AbTCEXBo>; Wed, 5 Mar 2003 18:01:44 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:17038 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S267013AbTCEXBm>; Wed, 5 Mar 2003 18:01:42 -0500
Date: Wed, 5 Mar 2003 23:09:44 -0100
From: Dave Jones <davej@codemonkey.org.uk>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Top stack (l)users
Message-ID: <20030306000944.GA24986@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>,
	linux-kernel@vger.kernel.org
References: <20030305202157.GA392@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030305202157.GA392@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 09:21:57PM +0100, J?rn Engel wrote:

 > And the winner is drivers/scsi/qlogicfc.c.

Ugh, I tackled that ~6 months back for 2.4 but never got
anyone to test my changes (I don't have hardware).

Someone want to try out the following diff with a card ?
(Still applies to 2.5 with offsets..)

		Dave

diff -urpN --exclude-from=/home/davej/.exclude linux-2.4.19/drivers/scsi/qlogicfc.c linux-2.4.19-dj/drivers/scsi/qlogicfc.c
--- linux-2.4.19/drivers/scsi/qlogicfc.c	2002-09-16 15:26:49.000000000 +0100
+++ linux-2.4.19-dj/drivers/scsi/qlogicfc.c	2002-09-18 15:01:51.000000000 +0100
@@ -650,6 +650,7 @@ struct isp2x00_hostdata {
 	u_char queued;
 	u_char host_id;
         struct timer_list explore_timer;
+	struct id_name_map tempmap[QLOGICFC_MAX_ID + 1];
 };
 
 
@@ -845,13 +846,12 @@ static int isp2x00_make_portdb(struct Sc
 
 	short param[8];
 	int i, j;
-	struct id_name_map temp[QLOGICFC_MAX_ID + 1];
 	struct isp2x00_hostdata *hostdata;
 
 	isp2x00_disable_irqs(host);
 
-	memset(temp, 0, sizeof(temp));
 	hostdata = (struct isp2x00_hostdata *) host->hostdata;
+	memset(hostdata->tempmap, 0, sizeof(hostdata->tempmap));
 
 #if ISP2x00_FABRIC
 	for (i = 0x81; i < QLOGICFC_MAX_ID; i++) {
@@ -877,15 +877,15 @@ static int isp2x00_make_portdb(struct Sc
 	if (param[0] == MBOX_COMMAND_COMPLETE) {
 		hostdata->port_id = ((u_int) param[3]) << 16;
 		hostdata->port_id |= param[2];
-		temp[0].loop_id = param[1];
-		temp[0].wwn = hostdata->wwn;
+		hostdata->tempmap[0].loop_id = param[1];
+		hostdata->tempmap[0].wwn = hostdata->wwn;
 	}
 	else {
 	        printk("qlogicfc%d : error getting scsi id.\n", hostdata->host_id);
 	}
 
         for (i = 0; i <=QLOGICFC_MAX_ID; i++)
-                temp[i].loop_id = temp[0].loop_id;
+                hostdata->tempmap[i].loop_id = hostdata->tempmap[0].loop_id;
    
         for (i = 0, j = 1; i <= QLOGICFC_MAX_LOOP_ID; i++) {
                 param[0] = MBOX_GET_PORT_NAME;
@@ -894,15 +894,15 @@ static int isp2x00_make_portdb(struct Sc
 		isp2x00_mbox_command(host, param);
 
 		if (param[0] == MBOX_COMMAND_COMPLETE) {
-			temp[j].loop_id = i;
-			temp[j].wwn = ((u64) (param[2] & 0xff)) << 56;
-			temp[j].wwn |= ((u64) ((param[2] >> 8) & 0xff)) << 48;
-			temp[j].wwn |= ((u64) (param[3] & 0xff)) << 40;
-			temp[j].wwn |= ((u64) ((param[3] >> 8) & 0xff)) << 32;
-			temp[j].wwn |= ((u64) (param[6] & 0xff)) << 24;
-			temp[j].wwn |= ((u64) ((param[6] >> 8) & 0xff)) << 16;
-			temp[j].wwn |= ((u64) (param[7] & 0xff)) << 8;
-			temp[j].wwn |= ((u64) ((param[7] >> 8) & 0xff));
+			hostdata->tempmap[j].loop_id = i;
+			hostdata->tempmap[j].wwn = ((u64) (param[2] & 0xff)) << 56;
+			hostdata->tempmap[j].wwn |= ((u64) ((param[2] >> 8) & 0xff)) << 48;
+			hostdata->tempmap[j].wwn |= ((u64) (param[3] & 0xff)) << 40;
+			hostdata->tempmap[j].wwn |= ((u64) ((param[3] >> 8) & 0xff)) << 32;
+			hostdata->tempmap[j].wwn |= ((u64) (param[6] & 0xff)) << 24;
+			hostdata->tempmap[j].wwn |= ((u64) ((param[6] >> 8) & 0xff)) << 16;
+			hostdata->tempmap[j].wwn |= ((u64) (param[7] & 0xff)) << 8;
+			hostdata->tempmap[j].wwn |= ((u64) ((param[7] >> 8) & 0xff));
 
 			j++;
 
@@ -911,33 +911,33 @@ static int isp2x00_make_portdb(struct Sc
 
 
 #if ISP2x00_FABRIC
-	isp2x00_init_fabric(host, temp, j);
+	isp2x00_init_fabric(host, hostdata->tempmap, j);
 #endif
 
 	for (i = 0; i <= QLOGICFC_MAX_ID; i++) {
-		if (temp[i].wwn != hostdata->port_db[i].wwn) {
+		if (hostdata->tempmap[i].wwn != hostdata->port_db[i].wwn) {
 			for (j = 0; j <= QLOGICFC_MAX_ID; j++) {
-				if (temp[j].wwn == hostdata->port_db[i].wwn) {
-					hostdata->port_db[i].loop_id = temp[j].loop_id;
+				if (hostdata->tempmap[j].wwn == hostdata->port_db[i].wwn) {
+					hostdata->port_db[i].loop_id = hostdata->tempmap[j].loop_id;
 					break;
 				}
 			}
 			if (j == QLOGICFC_MAX_ID + 1)
-				hostdata->port_db[i].loop_id = temp[0].loop_id;
+				hostdata->port_db[i].loop_id = hostdata->tempmap[0].loop_id;
 
 			for (j = 0; j <= QLOGICFC_MAX_ID; j++) {
-				if (hostdata->port_db[j].wwn == temp[i].wwn || !hostdata->port_db[j].wwn) {
+				if (hostdata->port_db[j].wwn == hostdata->tempmap[i].wwn || !hostdata->port_db[j].wwn) {
 					break;
 				}
 			}
 			if (j == QLOGICFC_MAX_ID + 1)
 				printk("qlogicfc%d : Too many scsi devices, no more room in port map.\n", hostdata->host_id);
 			if (!hostdata->port_db[j].wwn) {
-				hostdata->port_db[j].loop_id = temp[i].loop_id;
-				hostdata->port_db[j].wwn = temp[i].wwn;
+				hostdata->port_db[j].loop_id = hostdata->tempmap[i].loop_id;
+				hostdata->port_db[j].wwn = hostdata->tempmap[i].wwn;
 			}
 		} else
-			hostdata->port_db[i].loop_id = temp[i].loop_id;
+			hostdata->port_db[i].loop_id = hostdata->tempmap[i].loop_id;
 
 	}
 

