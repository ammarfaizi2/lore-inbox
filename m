Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274810AbRIUUTt>; Fri, 21 Sep 2001 16:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274820AbRIUUTn>; Fri, 21 Sep 2001 16:19:43 -0400
Received: from hermes.toad.net ([162.33.130.251]:29593 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S274810AbRIUUTc>;
	Fri, 21 Sep 2001 16:19:32 -0400
Message-ID: <3BABA0C6.99A77382@yahoo.co.uk>
Date: Fri, 21 Sep 2001 16:19:19 -0400
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PnP BIOS driver bugfixes
Content-Type: multipart/mixed;
 boundary="------------B4296A00B61548EC49FF7A7F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B4296A00B61548EC49FF7A7F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alan: Thanks for including my previous bugfix patch in the
kernel you just released (-13).  I now realize that that patch
did not go far enough.  The enclosed patch fixes two more
problems in the PnP BIOS driver.

1) First, both irq and dma need to be initialized to -1
   _each time_ a new irq or dma reported by the BIOS is
   processed in the while loop.  This should be self-evident
   from the patch.

2) Second, the PnP BIOS driver mixes up the static "boot" and
   dynamic "current" configurations when it calls the PnP BIOS
   to get or set values.   The enclosed patch fixes this.
   For easy reference, here is the relevant passage from the
   Plug and Play BIOS CLARIFICATION Paper for Plug and Play BIOS
   Specification Version 1.0A, October 6, 1994:

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
The Control flag provides a mechanism for allowing the system
software to indicate whether the systemboard device configuration
specified by this call is to take affect immediately or at the
next boot.  Control is defined as:
	Bits 15:2: Reserved (0)
	Bit 1:	0=Do not set the device configuration for the next boot.
		1=Set the device configuration for the next boot
                   (static configuration).
	Bit 0:	0=Do not set the device configuration dynamically.
		1=Set the device configuration right now
                   (dynamic configuration).
If Control flag is 0, neither bit 0 nor bit 1 is set and this function
should return BAD_PARAMETER.  If both bits are set, then the system
BIOS will attempt to set the configuration of the device right now
(dynamic configuration), as well as set the device configuration for
the next boot (static configuration).  When both bits are set, it is
possible that the NOT_SET_STATICALLY warning could be generated.  This
indicates that the device was configured dynamically, but could not be
configured statically (See Appendix C, Error Codes).
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

In other words, the control flag has to be 2 to set the boot
configuration, 1 to set the current configuration.  The current
driver has this reversed and the appended patch fixes this.

I both append and attach the patch.  I apologize in advance if
Netscape's mail composer converts tabs to spaces in the
appended patch.                      // Thomas Hood

-------------------------------------------------------------------
--- linux-2.4.9-ac13-mwave/drivers/pnp/pnp_bios.c_ORIG	Fri Sep 21 15:23:19 2001
+++ linux-2.4.9-ac13-mwave/drivers/pnp/pnp_bios.c	Fri Sep 21 16:15:44 2001
@@ -233,39 +233,39 @@
 	return status;
 }
 
 /* 
  * Call pnp bios with function 0x01, "get system device node"
- * Input:  *nodenum=desired node, 
- *         static=1: config (dynamic) config, else boot (static) config,
+ * Input: *nodenum = desired node, 
+ *        boot = whether to get static boot (!=0) or dynamic current (0) config
  * Output: *nodenum=next node or 0xff if no more nodes
  */
 
-int pnp_bios_get_dev_node(u8 *nodenum, char config, struct pnp_bios_node *data)
+int pnp_bios_get_dev_node(u8 *nodenum, char boot, struct pnp_bios_node *data)
 {
 	u16 status;
 	if (!pnp_bios_present ())
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	Q2_SET_SEL(PNP_TS1, nodenum, sizeof(char));
 	Q2_SET_SEL(PNP_TS2, data, 64 * 1024);
-	status = call_pnp_bios(PNP_GET_SYS_DEV_NODE, 0, PNP_TS1, 0, PNP_TS2, config ? 1 : 2, PNP_DS, 0);
+	status = call_pnp_bios(PNP_GET_SYS_DEV_NODE, 0, PNP_TS1, 0, PNP_TS2, boot ? 2 : 1, PNP_DS, 0);
 	return status;
 }
 
 /*
  * Call pnp bios with function 0x02, "set system device node"
- * Input: nodenum=desired node, 
- *        static=1: config (dynamic) config, else boot (static) config,
+ * Input: *nodenum = desired node, 
+ *        boot = whether to set static boot (!=0) or dynamic current (0) config
  */
 
-int pnp_bios_set_dev_node(u8 nodenum, char config, struct pnp_bios_node *data)
+int pnp_bios_set_dev_node(u8 nodenum, char boot, struct pnp_bios_node *data)
 {
 	u16 status;
 	if (!pnp_bios_present ())
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	Q2_SET_SEL(PNP_TS1, data, /* *((u16 *) data)*/ 65536);
-	status = call_pnp_bios(PNP_SET_SYS_DEV_NODE, nodenum, 0, PNP_TS1, config ? 1 : 2, PNP_DS, 0, 0);
+	status = call_pnp_bios(PNP_SET_SYS_DEV_NODE, nodenum, 0, PNP_TS1, boot ? 2 : 1, PNP_DS, 0, 0);
 	return status;
 }
 
 /*
  * Call pnp bios with function 0x03, "get event"
@@ -714,11 +714,11 @@
 
 /* parse PNPBIOS "Allocated Resources Block" and fill IO,IRQ,DMA into pci_dev */
 static void __init pnpbios_rawdata_2_pci_dev(struct pnp_bios_node *node, struct pci_dev *pci_dev)
 {
 	unsigned char *p = node->data, *lastp=NULL;
-        int mask,i,io,irq=-1,len,dma=-1;
+        int mask,i,io,irq,len,dma;
 
 	memset(pci_dev, 0, sizeof(struct pci_dev));
         while ( (char *)p < ((char *)node->data + node->size )) {
         	if(p==lastp) break;
 
@@ -750,16 +750,18 @@
                 }
                 if ((p[0]>>3) == 0x0f) // end tag
                         break;
                 switch (p[0]>>3) {
                 case 0x04: // irq
+                        irq = -1;
                         mask= p[1] + p[2]*256;
                         for (i=0;i<16;i++, mask=mask>>1)
                                 if(mask &0x01) irq=i;
 			pnpbios_add_irqresource(pci_dev, irq);
                         break;
                 case 0x05: // dma
+                        dma = -1;
                         mask = p[1];
                         for (i=0;i<8;i++, mask = mask>>1)
                                 if(mask&0x01) dma=i;
 			pnpbios_add_dmaresource(pci_dev, dma);
                         break;
--------------B4296A00B61548EC49FF7A7F
Content-Type: text/plain; charset=us-ascii;
 name="pnpbios-patch-20010921-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnpbios-patch-20010921-1"

--- linux-2.4.9-ac13-mwave/drivers/pnp/pnp_bios.c_ORIG	Fri Sep 21 15:23:19 2001
+++ linux-2.4.9-ac13-mwave/drivers/pnp/pnp_bios.c	Fri Sep 21 16:15:44 2001
@@ -233,39 +233,39 @@
 	return status;
 }
 
 /* 
  * Call pnp bios with function 0x01, "get system device node"
- * Input:  *nodenum=desired node, 
- *         static=1: config (dynamic) config, else boot (static) config,
+ * Input: *nodenum = desired node, 
+ *        boot = whether to get static boot (!=0) or dynamic current (0) config
  * Output: *nodenum=next node or 0xff if no more nodes
  */
 
-int pnp_bios_get_dev_node(u8 *nodenum, char config, struct pnp_bios_node *data)
+int pnp_bios_get_dev_node(u8 *nodenum, char boot, struct pnp_bios_node *data)
 {
 	u16 status;
 	if (!pnp_bios_present ())
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	Q2_SET_SEL(PNP_TS1, nodenum, sizeof(char));
 	Q2_SET_SEL(PNP_TS2, data, 64 * 1024);
-	status = call_pnp_bios(PNP_GET_SYS_DEV_NODE, 0, PNP_TS1, 0, PNP_TS2, config ? 1 : 2, PNP_DS, 0);
+	status = call_pnp_bios(PNP_GET_SYS_DEV_NODE, 0, PNP_TS1, 0, PNP_TS2, boot ? 2 : 1, PNP_DS, 0);
 	return status;
 }
 
 /*
  * Call pnp bios with function 0x02, "set system device node"
- * Input: nodenum=desired node, 
- *        static=1: config (dynamic) config, else boot (static) config,
+ * Input: *nodenum = desired node, 
+ *        boot = whether to set static boot (!=0) or dynamic current (0) config
  */
 
-int pnp_bios_set_dev_node(u8 nodenum, char config, struct pnp_bios_node *data)
+int pnp_bios_set_dev_node(u8 nodenum, char boot, struct pnp_bios_node *data)
 {
 	u16 status;
 	if (!pnp_bios_present ())
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	Q2_SET_SEL(PNP_TS1, data, /* *((u16 *) data)*/ 65536);
-	status = call_pnp_bios(PNP_SET_SYS_DEV_NODE, nodenum, 0, PNP_TS1, config ? 1 : 2, PNP_DS, 0, 0);
+	status = call_pnp_bios(PNP_SET_SYS_DEV_NODE, nodenum, 0, PNP_TS1, boot ? 2 : 1, PNP_DS, 0, 0);
 	return status;
 }
 
 /*
  * Call pnp bios with function 0x03, "get event"
@@ -714,11 +714,11 @@
 
 /* parse PNPBIOS "Allocated Resources Block" and fill IO,IRQ,DMA into pci_dev */
 static void __init pnpbios_rawdata_2_pci_dev(struct pnp_bios_node *node, struct pci_dev *pci_dev)
 {
 	unsigned char *p = node->data, *lastp=NULL;
-        int mask,i,io,irq=-1,len,dma=-1;
+        int mask,i,io,irq,len,dma;
 
 	memset(pci_dev, 0, sizeof(struct pci_dev));
         while ( (char *)p < ((char *)node->data + node->size )) {
         	if(p==lastp) break;
 
@@ -750,16 +750,18 @@
                 }
                 if ((p[0]>>3) == 0x0f) // end tag
                         break;
                 switch (p[0]>>3) {
                 case 0x04: // irq
+                        irq = -1;
                         mask= p[1] + p[2]*256;
                         for (i=0;i<16;i++, mask=mask>>1)
                                 if(mask &0x01) irq=i;
 			pnpbios_add_irqresource(pci_dev, irq);
                         break;
                 case 0x05: // dma
+                        dma = -1;
                         mask = p[1];
                         for (i=0;i<8;i++, mask = mask>>1)
                                 if(mask&0x01) dma=i;
 			pnpbios_add_dmaresource(pci_dev, dma);
                         break;

--------------B4296A00B61548EC49FF7A7F--

