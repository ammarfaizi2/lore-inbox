Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264419AbUHDLup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbUHDLup (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 07:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbUHDLup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 07:50:45 -0400
Received: from cantor.suse.de ([195.135.220.2]:45738 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264419AbUHDLuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 07:50:21 -0400
Date: Wed, 4 Aug 2004 13:45:51 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] request_region for winbond and smsc parport drivers
Message-ID: <20040804114551.GA30710@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


An attempt to fix the random poking in legacy io space...


ask for permissions before poking at io ports.
this affects detect_and_report_winbond() and 
detect_and_report_smsc().
Its unclear what port number is returned in
show_parconfig_winbond(), so just request the 
region as well and free the probing region.


Signed-off-by: Olaf Hering <olh@suse.de>

diff -purN linux-2.6.8-rc3.orig/drivers/parport/parport_pc.c linux-2.6.8-rc3/drivers/parport/parport_pc.c
--- linux-2.6.8-rc3.orig/drivers/parport/parport_pc.c	2004-08-04 11:29:16.000000000 +0200
+++ linux-2.6.8-rc3/drivers/parport/parport_pc.c	2004-08-04 13:11:22.605866967 +0200
@@ -1194,7 +1194,7 @@ struct parport_operations parport_pc_ops
 
 #ifdef CONFIG_PARPORT_PC_SUPERIO
 /* Super-IO chipset detection, Winbond, SMSC */
-static void __devinit show_parconfig_smsc37c669(int io, int key)
+static int __devinit show_parconfig_smsc37c669(int io, int key)
 {
 	int cr1,cr4,cra,cr23,cr26,cr27,i=0;
 	static const char *modes[]={ "SPP and Bidirectional (PS/2)",	
@@ -1261,17 +1261,26 @@ static void __devinit show_parconfig_sms
 					superios[i].io = 0x278;
 					superios[i].irq = 5;
 			}
+			if (io != superios[i].io) {
+				/* how many bytes? */
+				if (!request_region(superios[i].io, 3, "smsc parport")) {
+					superios[i].io = 0;
+					return 0;
+				}
+			}
 			d=(cr26 &0x0f);
 			if((d==1) || (d==3)) 
 				superios[i].dma= d;
 			else
 				superios[i].dma= PARPORT_DMA_NONE;
+			return 1;
 		}
  	}
+	return 0;
 }
 
 
-static void __devinit show_parconfig_winbond(int io, int key)
+static int __devinit show_parconfig_winbond(int io, int key)
 {
 	int cr30,cr60,cr61,cr70,cr74,crf0,i=0;
 	static const char *modes[] = {
@@ -1327,14 +1336,23 @@ static void __devinit show_parconfig_win
 			printk(KERN_INFO "Super-IO: too many chips!\n");
 		else {
 			superios[i].io = (cr60<<8)|cr61;
+			if (io != superios[i].io) {
+				/* how many bytes? */
+				if (!request_region(superios[i].io, 3, "winbond parport")) {
+					superios[i].io = 0;
+					return 0;
+				}
+			}
 			superios[i].irq = cr70&0x0f;
 			superios[i].dma = (((cr74 & 0x07) > 3) ?
 					   PARPORT_DMA_NONE : (cr74 & 0x07));
+			return 1;
 		}
 	}
+	return 0;
 }
 
-static void __devinit decode_winbond(int efer, int key, int devid, int devrev, int oldid)
+static int __devinit decode_winbond(int efer, int key, int devid, int devrev, int oldid)
 {
 	const char *type = "unknown";
 	int id,progif=2;
@@ -1342,7 +1360,7 @@ static void __devinit decode_winbond(int
 	if (devid == devrev)
 		/* simple heuristics, we happened to read some
                    non-winbond register */
-		return;
+		return 0;
 
 	id=(devid<<8) | devrev;
 
@@ -1367,19 +1385,20 @@ static void __devinit decode_winbond(int
 		       efer, key, devid, devrev, oldid, type);
 
 	if (progif == 2)
-		show_parconfig_winbond(efer,key);
+		return show_parconfig_winbond(efer,key);
+	return 0;
 }
 
-static void __devinit decode_smsc(int efer, int key, int devid, int devrev)
+static int __devinit decode_smsc(int efer, int key, int devid, int devrev)
 {
         const char *type = "unknown";
-	void (*func)(int io, int key);
+	int (*func)(int io, int key);
         int id;
 
         if (devid == devrev)
 		/* simple heuristics, we happened to read some
                    non-smsc register */
-		return;
+		return 0;
 
 	func=NULL;
         id=(devid<<8) | devrev;
@@ -1395,7 +1414,8 @@ static void __devinit decode_smsc(int ef
 		       efer, key, devid, devrev, type);
 
 	if (func)
-		func(efer,key);
+		return func(efer,key);
+	return 0;
 }
 
 
@@ -1403,6 +1423,9 @@ static void __devinit winbond_check(int 
 {
 	int devid,devrev,oldid,x_devid,x_devrev,x_oldid;
 
+	if (!request_region(io, 3, __FUNCTION__))
+		return;
+
 	/* First probe without key */
 	outb(0x20,io);
 	x_devid=inb(io+1);
@@ -1423,15 +1446,21 @@ static void __devinit winbond_check(int 
 	outb(0xaa,io);    /* Magic Seal */
 
 	if ((x_devid == devid) && (x_devrev == devrev) && (x_oldid == oldid))
-		return; /* protection against false positives */
+		goto out; /* protection against false positives */
 
-	decode_winbond(io,key,devid,devrev,oldid);
+	if (decode_winbond(io,key,devid,devrev,oldid));
+		return;
+out:
+	release_region(io, 3);
 }
 
 static void __devinit winbond_check2(int io,int key)
 {
         int devid,devrev,oldid,x_devid,x_devrev,x_oldid;
 
+	if (!request_region(io, 3, __FUNCTION__))
+		return;
+
 	/* First probe without the key */
 	outb(0x20,io+2);
 	x_devid=inb(io+2);
@@ -1451,15 +1480,20 @@ static void __devinit winbond_check2(int
         outb(0xaa,io);    /* Magic Seal */
 
 	if ((x_devid == devid) && (x_devrev == devrev) && (x_oldid == oldid))
-		return; /* protection against false positives */
+		goto out; /* protection against false positives */
 
         decode_winbond(io,key,devid,devrev,oldid);
+out:
+	release_region(io, 3);
 }
 
 static void __devinit smsc_check(int io, int key)
 {
         int id,rev,oldid,oldrev,x_id,x_rev,x_oldid,x_oldrev;
 
+	if (!request_region(io, 3, __FUNCTION__))
+		return;
+
 	/* First probe without the key */
 	outb(0x0d,io);
 	x_oldid=inb(io+1);
@@ -1485,9 +1519,11 @@ static void __devinit smsc_check(int io,
 
 	if ((x_id == id) && (x_oldrev == oldrev) &&
 	    (x_oldid == oldid) && (x_rev == rev))
-		return; /* protection against false positives */
+		goto out; /* protection against false positives */
 
         decode_smsc(io,key,oldid,oldrev);
+out:
+	release_region(io, 3);
 }
 
 

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
