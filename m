Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265400AbTBFEHM>; Wed, 5 Feb 2003 23:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbTBFEGV>; Wed, 5 Feb 2003 23:06:21 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:57872 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265414AbTBFEC7>;
	Wed, 5 Feb 2003 23:02:59 -0500
Subject: Re: [PATCH] PCI Hotplug changes for 2.5.59
In-reply-to: <10445044911216@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Wed, 5 Feb 2003 20:08 -0800
Message-id: <10445044923469@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.947.23.13, 2003/02/06 11:09:25+11:00, greg@kroah.com

[PATCH] Compaq PCI Hotplug: fix checker memory leak bugs.


diff -Nru a/drivers/hotplug/cpqphp_nvram.c b/drivers/hotplug/cpqphp_nvram.c
--- a/drivers/hotplug/cpqphp_nvram.c	Thu Feb  6 14:51:17 2003
+++ b/drivers/hotplug/cpqphp_nvram.c	Thu Feb  6 14:51:17 2003
@@ -473,7 +473,7 @@
 		p_byte += 3;
 
 		if (p_byte > ((u8*)p_EV_header + evbuffer_length))
-			return(2);
+			return 2;
 
 		bus = p_ev_ctrl->bus;
 		device = p_ev_ctrl->device;
@@ -490,20 +490,20 @@
 			p_byte += 4;
 
 			if (p_byte > ((u8*)p_EV_header + evbuffer_length))
-				return(2);
+				return 2;
 
 			// Skip forward to the next entry
 			p_byte += (nummem + numpmem + numio + numbus) * 8;
 
 			if (p_byte > ((u8*)p_EV_header + evbuffer_length))
-				return(2);
+				return 2;
 
 			p_ev_ctrl = (struct ev_hrt_ctrl *) p_byte;
 
 			p_byte += 3;
 
 			if (p_byte > ((u8*)p_EV_header + evbuffer_length))
-				return(2);
+				return 2;
 
 			bus = p_ev_ctrl->bus;
 			device = p_ev_ctrl->device;
@@ -518,7 +518,7 @@
 		p_byte += 4;
 
 		if (p_byte > ((u8*)p_EV_header + evbuffer_length))
-			return(2);
+			return 2;
 
 		while (nummem--) {
 			mem_node = (struct pci_resource*) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);
@@ -530,15 +530,19 @@
 			dbg("mem base = %8.8x\n",mem_node->base);
 			p_byte += 4;
 
-			if (p_byte > ((u8*)p_EV_header + evbuffer_length))
-				return(2);
+			if (p_byte > ((u8*)p_EV_header + evbuffer_length)) {
+				kfree(mem_node);
+				return 2;
+			}
 
 			mem_node->length = *(u32*)p_byte;
 			dbg("mem length = %8.8x\n",mem_node->length);
 			p_byte += 4;
 
-			if (p_byte > ((u8*)p_EV_header + evbuffer_length))
-				return(2);
+			if (p_byte > ((u8*)p_EV_header + evbuffer_length)) {
+				kfree(mem_node);
+				return 2;
+			}
 
 			mem_node->next = ctrl->mem_head;
 			ctrl->mem_head = mem_node;
@@ -554,15 +558,19 @@
 			dbg("pre-mem base = %8.8x\n",p_mem_node->base);
 			p_byte += 4;
 
-			if (p_byte > ((u8*)p_EV_header + evbuffer_length))
-				return(2);
+			if (p_byte > ((u8*)p_EV_header + evbuffer_length)) {
+				kfree(p_mem_node);
+				return 2;
+			}
 
 			p_mem_node->length = *(u32*)p_byte;
 			dbg("pre-mem length = %8.8x\n",p_mem_node->length);
 			p_byte += 4;
 
-			if (p_byte > ((u8*)p_EV_header + evbuffer_length))
-				return(2);
+			if (p_byte > ((u8*)p_EV_header + evbuffer_length)) {
+				kfree(p_mem_node);
+				return 2;
+			}
 
 			p_mem_node->next = ctrl->p_mem_head;
 			ctrl->p_mem_head = p_mem_node;
@@ -578,15 +586,19 @@
 			dbg("io base = %8.8x\n",io_node->base);
 			p_byte += 4;
 
-			if (p_byte > ((u8*)p_EV_header + evbuffer_length))
-				return(2);
+			if (p_byte > ((u8*)p_EV_header + evbuffer_length)) {
+				kfree(io_node);
+				return 2;
+			}
 
 			io_node->length = *(u32*)p_byte;
 			dbg("io length = %8.8x\n",io_node->length);
 			p_byte += 4;
 
-			if (p_byte > ((u8*)p_EV_header + evbuffer_length))
-				return(2);
+			if (p_byte > ((u8*)p_EV_header + evbuffer_length)) {
+				kfree(io_node);
+				return 2;
+			}
 
 			io_node->next = ctrl->io_head;
 			ctrl->io_head = io_node;
@@ -601,15 +613,18 @@
 			bus_node->base = *(u32*)p_byte;
 			p_byte += 4;
 
-			if (p_byte > ((u8*)p_EV_header + evbuffer_length))
-				return(2);
+			if (p_byte > ((u8*)p_EV_header + evbuffer_length)) {
+				kfree(bus_node);
+				return 2;
+			}
 
 			bus_node->length = *(u32*)p_byte;
 			p_byte += 4;
 
-
-			if (p_byte > ((u8*)p_EV_header + evbuffer_length))
-				return(2);
+			if (p_byte > ((u8*)p_EV_header + evbuffer_length)) {
+				kfree(bus_node);
+				return 2;
+			}
 
 			bus_node->next = ctrl->bus_head;
 			ctrl->bus_head = bus_node;
@@ -623,13 +638,11 @@
 		rc &= cpqhp_resource_sort_and_combine(&(ctrl->io_head));
 		rc &= cpqhp_resource_sort_and_combine(&(ctrl->bus_head));
 
-		if (rc) {
+		if (rc)
 			return(rc);
-		}
 	} else {
-		if ((evbuffer[0] != 0) && (!ctrl->push_flag)) {
-			return(1);
-		}
+		if ((evbuffer[0] != 0) && (!ctrl->push_flag)) 
+			return 1;
 	}
 
 	return 0;

