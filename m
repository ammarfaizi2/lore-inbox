Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262135AbULCJ6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbULCJ6V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 04:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbULCJ6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 04:58:21 -0500
Received: from stud4.tuwien.ac.at ([193.170.75.14]:33787 "EHLO
	stud4.tuwien.ac.at") by vger.kernel.org with ESMTP id S262135AbULCJ4t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 04:56:49 -0500
From: Martin Bammer <e9525103@student.tuwien.ac.at>
To: linux-kernel@vger.kernel.org
Subject: Patch for: [Bug 3481] lp doesn't recognize parallel port
Date: Fri, 3 Dec 2004 10:59:40 +0100
User-Agent: KMail/1.7.1
Cc: andrea@novell.com
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_MkDsB53PonmNvHA"
Message-Id: <200412031059.40194.e9525103@stud4.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_MkDsB53PonmNvHA
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi!

Current version of parport_pc driver is a bit buggy. It doesn't recognize and 
register parallel port devices correctly on an "MSI KT880 Delta" and maybe on 
some other platforms.
Another problem is that some allocated resources are not freed when the driver 
is unloaded. So the next loading of the driver will make troubles.
I have made a patch which solves all these problems. parport_pc now works fine 
on all my systems and frees all allocated resources correctly.
Would be nice to have this patch in the next kernel release.

Cheers, Martin

--Boundary-00=_MkDsB53PonmNvHA
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-2.6.10-rc2-bk13-parport_pc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch-2.6.10-rc2-bk13-parport_pc"

diff -Nru a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
--- a/drivers/parport/parport_pc.c	2004-12-01 10:34:06.000000000 +0100
+++ b/drivers/parport/parport_pc.c	2004-12-01 11:31:52.000000000 +0100
@@ -95,6 +95,9 @@
 	int dma;
 } superios[NR_SUPERIOS] __devinitdata = { {0,},};
 
+/* Extra I/O-Space information will be saved here for later release. */
+static unsigned long configios[NR_SUPERIOS] = { 0, };
+
 static int user_specified;
 #if defined(CONFIG_PARPORT_PC_SUPERIO) || \
        (defined(CONFIG_PARPORT_1284) && defined(CONFIG_PARPORT_PC_FIFO))
@@ -1195,7 +1198,7 @@
 
 #ifdef CONFIG_PARPORT_PC_SUPERIO
 /* Super-IO chipset detection, Winbond, SMSC */
-static void __devinit show_parconfig_smsc37c669(int io, int key)
+static int __devinit show_parconfig_smsc37c669(int io, int key)
 {
 	int cr1,cr4,cra,cr23,cr26,cr27,i=0;
 	static const char *modes[]={ "SPP and Bidirectional (PS/2)",	
@@ -1267,12 +1270,17 @@
 				superios[i].dma= d;
 			else
 				superios[i].dma= PARPORT_DMA_NONE;
+			/* Save extra I/O-Space for later release! */
+			if (io != superios[i].io) configios[i] = io;
+			if (parport_pc_probe_port(superios[i].io, superios[i].io+0x400, superios[i].irq, superios[i].dma, NULL))
+				return 1;
 		}
- 	}
+	}
+	return 0;
 }
 
 
-static void __devinit show_parconfig_winbond(int io, int key)
+static int __devinit show_parconfig_winbond(int io, int key)
 {
 	int cr30,cr60,cr61,cr70,cr74,crf0,i=0;
 	static const char *modes[] = {
@@ -1331,11 +1339,16 @@
 			superios[i].irq = cr70&0x0f;
 			superios[i].dma = (((cr74 & 0x07) > 3) ?
 					   PARPORT_DMA_NONE : (cr74 & 0x07));
+			/* Save extra I/O-Space for later release! */
+			if (io != superios[i].io) configios[i] = io;
+			if (parport_pc_probe_port(superios[i].io, superios[i].io+0x400, superios[i].irq, superios[i].dma, NULL))
+				return 1;
 		}
 	}
+	return 0;
 }
 
-static void __devinit decode_winbond(int efer, int key, int devid, int devrev, int oldid)
+static int __devinit decode_winbond(int efer, int key, int devid, int devrev, int oldid)
 {
 	const char *type = "unknown";
 	int id,progif=2;
@@ -1343,7 +1356,7 @@
 	if (devid == devrev)
 		/* simple heuristics, we happened to read some
                    non-winbond register */
-		return;
+		return 0;
 
 	id=(devid<<8) | devrev;
 
@@ -1368,19 +1381,20 @@
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
@@ -1396,16 +1410,17 @@
 		       efer, key, devid, devrev, type);
 
 	if (func)
-		func(efer,key);
+		return func(efer,key);
+	return 0;
 }
 
 
-static void __devinit winbond_check(int io, int key)
+static int __devinit winbond_check(int io, int key)
 {
 	int devid,devrev,oldid,x_devid,x_devrev,x_oldid;
 
 	if (!request_region(io, 3, __FUNCTION__))
-		return;
+		return -1;
 
 	/* First probe without key */
 	outb(0x20,io);
@@ -1426,20 +1441,23 @@
 	oldid=inb(io+1);
 	outb(0xaa,io);    /* Magic Seal */
 
-	if ((x_devid == devid) && (x_devrev == devrev) && (x_oldid == oldid))
-		goto out; /* protection against false positives */
-
-	decode_winbond(io,key,devid,devrev,oldid);
-out:
-	release_region(io, 3);
+	if ((x_devid == devid) && (x_devrev == devrev) && (x_oldid == oldid)) {
+		release_region(io, 3);
+		return 0; /* protection against false positives */
+	}
+	if (!decode_winbond(io,key,devid,devrev,oldid)) {
+		release_region(io, 3);
+		return 0;
+	}
+	return 1;
 }
 
-static void __devinit winbond_check2(int io,int key)
+static int __devinit winbond_check2(int io,int key)
 {
         int devid,devrev,oldid,x_devid,x_devrev,x_oldid;
 
 	if (!request_region(io, 3, __FUNCTION__))
-		return;
+		return -1;
 
 	/* First probe without the key */
 	outb(0x20,io+2);
@@ -1459,20 +1477,23 @@
         oldid=inb(io+2);
         outb(0xaa,io);    /* Magic Seal */
 
-	if ((x_devid == devid) && (x_devrev == devrev) && (x_oldid == oldid))
-		goto out; /* protection against false positives */
-
-	decode_winbond(io,key,devid,devrev,oldid);
-out:
-	release_region(io, 3);
+	if ((x_devid == devid) && (x_devrev == devrev) && (x_oldid == oldid)) {
+		release_region(io, 3);
+		return 0; /* protection against false positives */
+	}
+	if (!decode_winbond(io,key,devid,devrev,oldid)) {
+		release_region(io, 3);
+		return 0;
+	}
+	return 1;
 }
 
-static void __devinit smsc_check(int io, int key)
+static int __devinit smsc_check(int io, int key)
 {
         int id,rev,oldid,oldrev,x_id,x_rev,x_oldid,x_oldrev;
 
 	if (!request_region(io, 3, __FUNCTION__))
-		return;
+		return -1;
 
 	/* First probe without the key */
 	outb(0x0d,io);
@@ -1498,36 +1519,45 @@
         outb(0xaa,io);    /* Magic Seal */
 
 	if ((x_id == id) && (x_oldrev == oldrev) &&
-	    (x_oldid == oldid) && (x_rev == rev))
-		goto out; /* protection against false positives */
-
-        decode_smsc(io,key,oldid,oldrev);
-out:
-	release_region(io, 3);
+	    (x_oldid == oldid) && (x_rev == rev)) {
+		release_region(io, 3);
+		return 0; /* protection against false positives */
+	}
+	if (!decode_smsc(io,key,oldid,oldrev)) {
+		release_region(io, 3);
+		return 0;
+	}
+	return 1;
 }
 
 
-static void __devinit detect_and_report_winbond (void)
+static int __devinit detect_and_report_winbond (void)
 { 
+	int count = 0;
+
 	if (verbose_probing)
-		printk(KERN_DEBUG "Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...\n");
-	winbond_check(0x3f0,0x87);
-	winbond_check(0x370,0x87);
-	winbond_check(0x2e ,0x87);
-	winbond_check(0x4e ,0x87);
-	winbond_check(0x3f0,0x86);
-	winbond_check2(0x250,0x88); 
-	winbond_check2(0x250,0x89);
+	printk(KERN_DEBUG "Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...\n");
+	if (winbond_check(0x3f0,0x87) > 0) count++;
+	if (winbond_check(0x370,0x87) > 0) count++;
+	if (winbond_check(0x02e,0x87) > 0) count++;
+	if (winbond_check(0x04e,0x87) > 0) count++;
+	if (winbond_check(0x3f0,0x86) > 0) count++;
+	if (winbond_check2(0x250,0x88) > 0) count++; 
+	if (winbond_check2(0x250,0x89) > 0) count++;
+	return count;
 }
 
-static void __devinit detect_and_report_smsc (void)
+static int __devinit detect_and_report_smsc (void)
 {
+	int count = 0;
+
 	if (verbose_probing)
-		printk(KERN_DEBUG "SMSC Super-IO detection, now testing Ports 2F0, 370 ...\n");
-	smsc_check(0x3f0,0x55);
-	smsc_check(0x370,0x55);
-	smsc_check(0x3f0,0x44);
-	smsc_check(0x370,0x44);
+	printk(KERN_DEBUG "SMSC Super-IO detection, now testing Ports 2F0, 370 ...\n");
+	if (smsc_check(0x3f0,0x55) > 0) count++;
+	if (smsc_check(0x370,0x55) > 0) count++;
+	if (smsc_check(0x3f0,0x44) > 0) count++;
+	if (smsc_check(0x370,0x44) > 0) count++;
+	return count;
 }
 #endif /* CONFIG_PARPORT_PC_SUPERIO */
 
@@ -3078,8 +3108,8 @@
 	int count = 0, r;
 
 #ifdef CONFIG_PARPORT_PC_SUPERIO
-	detect_and_report_winbond ();
-	detect_and_report_smsc ();
+	count += detect_and_report_winbond ();
+	count += detect_and_report_smsc ();
 #endif
 
 	/* Onboard SuperIO chipsets that show themselves on the PCI bus. */
@@ -3098,10 +3128,10 @@
 	count += parport_pc_find_nonpci_ports (autoirq, autodma);
 
 	r = pci_register_driver (&parport_pc_pci_driver);
-	if (r)
-		return r;
-	pci_registered_parport = 1;
-	count += 1;
+	if (r >= 0) {
+		pci_registered_parport = 1;
+		count += r;
+	}
 
 	return count;
 }
@@ -3354,6 +3384,8 @@
 
 static void __exit parport_pc_exit(void)
 {
+	int i=0;
+
 	if (pci_registered_parport)
 		pci_unregister_driver (&parport_pc_pci_driver);
 	if (pnp_registered_parport)
@@ -3370,6 +3402,11 @@
 		parport_pc_unregister_port(port);
 		spin_lock(&ports_lock);
 	}
+	/* Release configuration spaces of winbond and smsc chips */
+	while (i<NR_SUPERIOS) {
+		if (configios[i]) release_region(configios[i], 3);
+		i++;
+	}
 	spin_unlock(&ports_lock);
 }
 

--Boundary-00=_MkDsB53PonmNvHA--
