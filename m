Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319742AbSIMS3T>; Fri, 13 Sep 2002 14:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319741AbSIMS3S>; Fri, 13 Sep 2002 14:29:18 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:267 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319742AbSIMS2P>;
	Fri, 13 Sep 2002 14:28:15 -0400
Date: Fri, 13 Sep 2002 11:29:31 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI Hotplug changes for 2.4.20-pre7
Message-ID: <20020913182930.GC26589@kroah.com>
References: <20020913182846.GA26589@kroah.com> <20020913182903.GB26589@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020913182903.GB26589@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.661   -> 1.662  
#	drivers/hotplug/ibmphp_hpc.c	1.3     -> 1.4    
#	drivers/hotplug/ibmphp_ebda.c	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/13	zubarev@us.ibm.com	1.662
# [PATCH] IBM PCI Hotplug driver update for ISA based devices
# 
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/ibmphp_ebda.c b/drivers/hotplug/ibmphp_ebda.c
--- a/drivers/hotplug/ibmphp_ebda.c	Fri Sep 13 10:57:23 2002
+++ b/drivers/hotplug/ibmphp_ebda.c	Fri Sep 13 10:57:23 2002
@@ -814,6 +814,7 @@
 	struct ebda_hpc_slot *slot_ptr;
 	struct bus_info *bus_info_ptr1, *bus_info_ptr2;
 	int rc;
+	int retval;
 	struct slot *slot_cur;
 	struct list_head *list;
 
@@ -932,6 +933,10 @@
 			case 0:
 				hpc_ptr->u.isa_ctlr.io_start = readw (io_mem + addr);
 				hpc_ptr->u.isa_ctlr.io_end = readw (io_mem + addr + 2);
+				retval = check_region (hpc_ptr->u.isa_ctlr.io_start, (hpc_ptr->u.isa_ctlr.io_end - hpc_ptr->u.isa_ctlr.io_start + 1));
+				if (retval)
+					return -ENODEV;
+				request_region (hpc_ptr->u.isa_ctlr.io_start, (hpc_ptr->u.isa_ctlr.io_end - hpc_ptr->u.isa_ctlr.io_start + 1), "ibmphp");
 				hpc_ptr->irq = readb (io_mem + addr + 4);
 				addr += 5;
 				break;
@@ -948,9 +953,9 @@
 				return -ENODEV;
 		}
 
-		/* following 3 line: Now our driver only supports I2c ctlrType */
-		if ((hpc_ptr->ctlr_type != 2) && (hpc_ptr->ctlr_type != 4)) {
-			err ("Please run this driver on ibm xseries440\n ");
+		/* following 3 line: Now our driver only supports I2c/ISA ctlrType */
+		if ((hpc_ptr->ctlr_type != 2) && (hpc_ptr->ctlr_type != 4) && (hpc_ptr->ctlr_type != 0)) {
+			err ("Please run this driver on IBM xSeries440 or xSeries 235\n ");
 			return -ENODEV;
 		}
 
@@ -1210,6 +1215,8 @@
 
 	list_for_each_safe (list, next, &ebda_hpc_head) {
 		controller = list_entry (list, struct controller, ebda_hpc_list);
+		if (controller->ctlr_type == 0)
+			release_region (controller->u.isa_ctlr.io_start, (controller->u.isa_ctlr.io_end - controller->u.isa_ctlr.io_start + 1));
 		free_ebda_hpc (controller);
 	}
 }
diff -Nru a/drivers/hotplug/ibmphp_hpc.c b/drivers/hotplug/ibmphp_hpc.c
--- a/drivers/hotplug/ibmphp_hpc.c	Fri Sep 13 10:57:23 2002
+++ b/drivers/hotplug/ibmphp_hpc.c	Fri Sep 13 10:57:23 2002
@@ -350,10 +350,41 @@
 	return (rc);
 }
 
+//------------------------------------------------------------
+//  Read from ISA type HPC 
+//------------------------------------------------------------
+static u8 isa_ctrl_read (struct controller *ctlr_ptr, u8 offset)
+{
+	u16 start_address;
+	u16 end_address;
+	u8 data;
+
+	start_address = ctlr_ptr->u.isa_ctlr.io_start;
+	end_address = ctlr_ptr->u.isa_ctlr.io_end;
+	data = inb (start_address + offset);
+	return data;
+}
+
+//--------------------------------------------------------------
+// Write to ISA type HPC
+//--------------------------------------------------------------
+static void isa_ctrl_write (struct controller *ctlr_ptr, u8 offset, u8 data)
+{
+	u16 start_address;
+	u16 port_address;
+	
+	start_address = ctlr_ptr->u.isa_ctlr.io_start;
+	port_address = start_address + (u16) offset;
+	outb (data, port_address);
+}
+
 static u8 ctrl_read (struct controller *ctlr, void *base, u8 offset)
 {
 	u8 rc;
 	switch (ctlr->ctlr_type) {
+	case 0:
+		rc = isa_ctrl_read (ctlr, offset);
+		break;
 	case 2:
 	case 4:
 		rc = i2c_ctrl_read (ctlr, base, offset);
@@ -368,6 +399,9 @@
 {
 	u8 rc = 0;
 	switch (ctlr->ctlr_type) {
+	case 0:
+		isa_ctrl_write(ctlr, offset, data);
+		break;
 	case 2:
 	case 4:
 		rc = i2c_ctrl_write(ctlr, base, offset, data);
