Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265558AbUABTDs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 14:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265564AbUABTDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 14:03:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26288 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265558AbUABTDE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 14:03:04 -0500
Date: Fri, 2 Jan 2004 19:02:59 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Omkhar Arasaratnam <omkhar@rogers.com>
Cc: emoenke@gwdg.de, linux-kernel@vger.kernel.org, trivial@rustcorp.com.au,
       randy@kerneljanitors.org
Subject: Re: [PATCH] drivers/cdrom/cdu31c.c check_region() fix
Message-ID: <20040102190259.GU4176@parcelfarce.linux.theplanet.co.uk>
References: <20040102161306.GA7122@omkhar.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040102161306.GA7122@omkhar.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 11:13:06AM -0500, Omkhar Arasaratnam wrote:
> Here is a check_region fix for cdu31a
> 
> As usual feel free to poke / prod / suggest / include this patch as you see fit

It's not enough - you have
        if (cdu31a_port == 0xffff) {
        } else if (cdu31a_port != 0) {
		...
                probe on that port
                if got it>
                        drive_found = 1;
                ...
        } else {
		...
		autoprobing
		...
	}

        if (!drive_found)
                goto errout3;

        if (!request_region(cdu31a_port, 4, "cdu31a"))

so at the very least you want to pull request_region() in both branches
that set drive_found.  FWIW, I'd rather move it into get_drive_configuration()
- something along the lines of

--- RC0-current/drivers/cdrom/cdu31a.c	Mon Sep  8 19:25:05 2003
+++ /tmp/cdu31a.c	Fri Jan  2 13:58:32 2004
@@ -3203,13 +3203,16 @@
 static char *load_mech[] __initdata =
     { "caddy", "tray", "pop-up", "unknown" };
 
-static void __init
+static int __init
 get_drive_configuration(unsigned short base_io,
 			unsigned char res_reg[], unsigned int *res_size)
 {
 	unsigned long retry_count;
 
 
+	if (!request_region(base_io, 4, "cdu31a"))
+		return 0;
+
 	/* Set the base address */
 	cdu31a_port = base_io;
 
@@ -3244,7 +3247,7 @@
 		/* If attention is never seen probably not a CDU31a present */
 		if (!is_attention()) {
 			res_reg[0] = 0x20;
-			return;
+			goto out_err;
 		}
 #endif
 
@@ -3254,11 +3257,17 @@
 		do_sony_cd_cmd(SONY_REQ_DRIVE_CONFIG_CMD,
 			       NULL,
 			       0, (unsigned char *) res_reg, res_size);
-		return;
+		if (*res_size <= 2 || (res_reg[0] & 0xf0) != 0)
+			goto out_err;
+		return 1;
 	}
 
 	/* Return an error */
 	res_reg[0] = 0x20;
+out_err:
+	release_region(cdu31a_port, 4);
+	cdu31a_port = 0;
+	return 0;
 }
 
 #ifndef MODULE
@@ -3307,9 +3316,6 @@
 	char msg[255];
 	char buf[40];
 	int i;
-	int drive_found;
-	int tmp_irq;
-
 
 	/*
 	 * According to Alex Freed (freed@europa.orion.adobe.com), this is
@@ -3323,51 +3329,32 @@
 		outb(0xe2, 0x9a01);
 	}
 
-	drive_found = 0;
-
 	/* Setting the base I/O address to 0xffff will disable it. */
-	if (cdu31a_port == 0xffff) {
-	} else if (cdu31a_port != 0) {
-		tmp_irq = cdu31a_irq;	/* Need IRQ 0 because we can't sleep here. */
-		cdu31a_irq = 0;
-
-		get_drive_configuration(cdu31a_port,
-					drive_config.exec_status,
-					&res_size);
-		if ((res_size > 2)
-		    && ((drive_config.exec_status[0] & 0xf0) == 0x00)) {
-			drive_found = 1;
-		}
+	if (cdu31a_port == 0xffff) 
+		goto errout3;
 
+	if (cdu31a_port != 0) {
+		/* Need IRQ 0 because we can't sleep here. */
+		int tmp_irq = cdu31a_irq;
+		cdu31a_irq = 0;
+		if (!get_drive_configuration(cdu31a_port,
+					    drive_config.exec_status,
+					    &res_size))
+			goto errout3;
 		cdu31a_irq = tmp_irq;
 	} else {
 		cdu31a_irq = 0;
-		i = 0;
-		while ((cdu31a_addresses[i].base != 0)
-		       && (!drive_found)) {
-			if (check_region(cdu31a_addresses[i].base, 4)) {
-				i++;
-				continue;
-			}
-			get_drive_configuration(cdu31a_addresses[i].base,
-						drive_config.exec_status,
-						&res_size);
-			if ((res_size > 2)
-			    && ((drive_config.exec_status[0] & 0xf0) ==
-				0x00)) {
-				drive_found = 1;
+		for (i = 0; cdu31a_addresses[i].base; i++) {
+			if (get_drive_configuration(cdu31a_addresses[i].base,
+						     drive_config.exec_status,
+						     &res_size)) {
 				cdu31a_irq = cdu31a_addresses[i].int_num;
-			} else {
-				i++;
+				break;
 			}
 		}
+		if (!cdu31a_port)
+			goto errout3;
 	}
-
-	if (!drive_found)
-		goto errout3;
-
-	if (!request_region(cdu31a_port, 4, "cdu31a"))
-		goto errout3;
 
 	if (register_blkdev(MAJOR_NR, "cdu31a"))
 		goto errout2;
