Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131429AbQLIUeP>; Sat, 9 Dec 2000 15:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131870AbQLIUeF>; Sat, 9 Dec 2000 15:34:05 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:244 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S131429AbQLIUdx>; Sat, 9 Dec 2000 15:33:53 -0500
Date: Sat, 9 Dec 2000 18:03:21 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Adam Radford <linux@3ware.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.2: drivers/scsi/3c-xxxx.c resource release on failure
Message-ID: <20001209180321.H859@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Adam Radford <linux@3ware.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20001209151425.E859@conectiva.com.br> <20001209174018.F859@conectiva.com.br> <20001209174918.G859@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001209174918.G859@conectiva.com.br>; from acme@conectiva.com.br on Sat, Dec 09, 2000 at 05:49:18PM -0200
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan/Adam,

	Please consider applying, a similar patch is already in 2.4.

- Arnaldo

--- linux-2.2.18-pre25/drivers/scsi/3w-xxxx.c	Tue Sep  5 19:13:35 2000
+++ linux-2.2.18-pre25.acme/drivers/scsi/3w-xxxx.c	Sat Dec  9 17:59:22 2000
@@ -3,6 +3,8 @@
 
    Written By: Adam Radford <linux@3ware.com>
    Modifications By: Joel Jacobson <linux@3ware.com>
+		     Arnaldo Carvalho de Melo <acme@conectiva.com.br>
+
 
    Copyright (C) 1999-2000 3ware Inc.
 
@@ -64,6 +66,8 @@
                  Bug fix so hot spare drives don't show up.
    1.02.00.002 - Fix bug with tw_setfeature() call that caused oops on some
                  systems.
+   12/09/2000  - release previously allocated resources on failure at
+		 tw_allocate_memory (acme)
 */
 
 #include <linux/module.h>
@@ -416,37 +420,29 @@
 /* This function will allocate memory and check if it is 16 d-word aligned */
 int tw_allocate_memory(TW_Device_Extension *tw_dev, int request_id, int size, int which)
 {
-	u32 *virt_addr;
+	u32 *virt_addr = kmalloc(size, GFP_ATOMIC);
 
 	dprintk(KERN_NOTICE "3w-xxxx: tw_allocate_memory()\n");
 
+	if (!virt_addr) {
+		printk(KERN_WARNING "3w-xxxx: tw_allocate_memory(): kmalloc() failed.\n");
+		return 1;
+	}
+
+	if ((u32)virt_addr % TW_ALIGNMENT) {
+		kfree(virt_addr);
+		printk(KERN_WARNING "3w-xxxx: tw_allocate_memory(): Found unaligned address.\n");
+		return 1;
+	}
+
 	if (which == 0) {
-		/* Allocate command packet memory */
-		virt_addr = kmalloc(size, GFP_ATOMIC);
-		if (virt_addr == NULL) {
-			printk(KERN_WARNING "3w-xxxx: tw_allocate_memory(): kmalloc() failed.\n");
-			return 1;
-		}
-		if ((u32)virt_addr % TW_ALIGNMENT) {
-			printk(KERN_WARNING "3w-xxxx: tw_allocate_memory(): Found unaligned address.\n");
-			return 1;
-		}
 		tw_dev->command_packet_virtual_address[request_id] = virt_addr;
 		tw_dev->command_packet_physical_address[request_id] = 
-		virt_to_bus(virt_addr);
+			virt_to_bus(virt_addr);
 	} else {
-		/* Allocate generic buffer */
-		virt_addr = kmalloc(size, GFP_ATOMIC);
-		if (virt_addr == NULL) {
-			printk(KERN_WARNING "3w-xxxx: tw_allocate_memory(): kmalloc() failed.\n");
-			return 1;
-		}
-		if ((u32)virt_addr % TW_ALIGNMENT) {
-			printk(KERN_WARNING "3w-xxxx: tw_allocate_memory(): Found unaligned address.\n");
-			return 1;
-		}
 		tw_dev->alignment_virtual_address[request_id] = virt_addr;
-		tw_dev->alignment_physical_address[request_id] = virt_to_bus(virt_addr);
+		tw_dev->alignment_physical_address[request_id] =
+			virt_to_bus(virt_addr);
 	}
 	return 0;
 } /* End tw_allocate_memory() */
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
