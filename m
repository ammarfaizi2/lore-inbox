Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292582AbSCIHTE>; Sat, 9 Mar 2002 02:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292539AbSCIHQ2>; Sat, 9 Mar 2002 02:16:28 -0500
Received: from zeus.kernel.org ([204.152.189.113]:61645 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S292549AbSCIHPl>;
	Sat, 9 Mar 2002 02:15:41 -0500
Date: Fri, 08 Mar 2002 21:48:38 -0500
From: Thomas Hood <jdthood@mail.com>
Subject: Re: PnP BIOS driver status
In-Reply-To: <E16jWYf-0008Q4-00@the-village.bc.nu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org
Message-id: <1015642119.941.49.camel@thanatos>
MIME-version: 1.0
X-Mailer: Evolution/1.0.2
Content-type: text/plain
Content-transfer-encoding: 7bit
In-Reply-To: <E16jWYf-0008Q4-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here the patch for Alan (which also includes the
kpnpbios -> kpnpbiosd change):

--- linux-2.4.19-pre2-ac3/drivers/pnp/pnpbios_core.c_ORIG	Fri Mar  8 17:35:44 2002
+++ linux-2.4.19-pre2-ac3/drivers/pnp/pnpbios_core.c	Fri Mar  8 21:43:10 2002
@@ -139,10 +139,16 @@
 
 static spinlock_t pnp_bios_lock;
 
+/*
+ * call_pnp_bios
+ *
+ * Call with the pnp_bios_lock held and with irqs disabled.
+ * On some boxes IRQ's during PnP BIOS calls are deadly.
+ */
+
 static inline u16 call_pnp_bios(u16 func, u16 arg1, u16 arg2, u16 arg3,
                                 u16 arg4, u16 arg5, u16 arg6, u16 arg7)
 {
-	unsigned long flags;
 	u16 status;
 
 	/*
@@ -152,9 +158,6 @@
 	if(pnp_bios_is_utter_crap)
 		return PNP_FUNCTION_NOT_SUPPORTED;
 
-	/* On some boxes IRQ's during PnP BIOS calls are deadly.  */
-	spin_lock_irqsave(&pnp_bios_lock, flags);
-	__cli();
 	__asm__ __volatile__(
 	        "pushl %%ebp\n\t"
 		"pushl %%edi\n\t"
@@ -184,7 +187,6 @@
 		  "i" (0)
 		: "memory"
 	);
-	spin_unlock_irqrestore(&pnp_bios_lock, flags);
 	
 	/* If we get here and this is set then the PnP BIOS faulted on us. */
 	if(pnp_bios_is_utter_crap)
@@ -220,7 +222,7 @@
 /*
  * Call this only after init time
  */
-static int pnp_bios_present(void)
+static inline int pnp_bios_present(void)
 {
 	return (pnp_bios_hdr != NULL);
 }
@@ -254,11 +256,14 @@
  */
 static int __pnp_bios_dev_node_info(struct pnp_dev_node_info *data)
 {
+	unsigned long flags;
 	u16 status;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
+	spin_lock_irqsave(&pnp_bios_lock, flags);
 	Q2_SET_SEL(PNP_TS1, data, sizeof(struct pnp_dev_node_info));
 	status = call_pnp_bios(PNP_GET_NUM_SYS_DEV_NODES, 0, PNP_TS1, 2, PNP_TS1, PNP_DS, 0, 0);
+	spin_unlock_irqrestore(&pnp_bios_lock, flags);
 	data->no_nodes &= 0xff;
 	return status;
 }
@@ -287,14 +292,17 @@
  */
 static int __pnp_bios_get_dev_node(u8 *nodenum, char boot, struct pnp_bios_node *data)
 {
+	unsigned long flags;
 	u16 status;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	if ( !boot & pnpbios_dont_use_current_config )
 		return PNP_FUNCTION_NOT_SUPPORTED;
+	spin_lock_irqsave(&pnp_bios_lock, flags);
 	Q2_SET_SEL(PNP_TS1, nodenum, sizeof(char));
 	Q2_SET_SEL(PNP_TS2, data, 64 * 1024);
 	status = call_pnp_bios(PNP_GET_SYS_DEV_NODE, 0, PNP_TS1, 0, PNP_TS2, boot ? 2 : 1, PNP_DS, 0);
+	spin_unlock_irqrestore(&pnp_bios_lock, flags);
 	return status;
 }
 
@@ -316,13 +324,16 @@
  */
 static int __pnp_bios_set_dev_node(u8 nodenum, char boot, struct pnp_bios_node *data)
 {
+	unsigned long flags;
 	u16 status;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	if ( !boot & pnpbios_dont_use_current_config )
 		return PNP_FUNCTION_NOT_SUPPORTED;
+	spin_lock_irqsave(&pnp_bios_lock, flags);
 	Q2_SET_SEL(PNP_TS1, data, /* *((u16 *) data)*/ 65536);
 	status = call_pnp_bios(PNP_SET_SYS_DEV_NODE, nodenum, 0, PNP_TS1, boot ? 2 : 1, PNP_DS, 0, 0);
+	spin_unlock_irqrestore(&pnp_bios_lock, flags);
 	return status;
 }
 
@@ -350,11 +361,14 @@
  */
 static int pnp_bios_get_event(u16 *event)
 {
+	unsigned long flags;
 	u16 status;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
+	spin_lock_irqsave(&pnp_bios_lock, flags);
 	Q2_SET_SEL(PNP_TS1, event, sizeof(u16));
 	status = call_pnp_bios(PNP_GET_EVENT, 0, PNP_TS1, PNP_DS, 0, 0 ,0 ,0);
+	spin_unlock_irqrestore(&pnp_bios_lock, flags);
 	return status;
 }
 #endif
@@ -365,10 +379,13 @@
  */
 static int pnp_bios_send_message(u16 message)
 {
+	unsigned long flags;
 	u16 status;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
+	spin_lock_irqsave(&pnp_bios_lock, flags);
 	status = call_pnp_bios(PNP_SEND_MESSAGE, message, PNP_DS, 0, 0, 0, 0, 0);
+	spin_unlock_irqrestore(&pnp_bios_lock, flags);
 	return status;
 }
 #endif
@@ -379,11 +396,14 @@
  */
 static int pnp_bios_dock_station_info(struct pnp_docking_station_info *data)
 {
+	unsigned long flags;
 	u16 status;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
+	spin_lock_irqsave(&pnp_bios_lock, flags);
 	Q2_SET_SEL(PNP_TS1, data, sizeof(struct pnp_docking_station_info));
 	status = call_pnp_bios(PNP_GET_DOCKING_STATION_INFORMATION, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0);
+	spin_unlock_irqrestore(&pnp_bios_lock, flags);
 	return status;
 }
 #endif
@@ -395,11 +415,14 @@
  */
 static int pnp_bios_set_stat_res(char *info)
 {
+	unsigned long flags;
 	u16 status;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
+	spin_lock_irqsave(&pnp_bios_lock, flags);
 	Q2_SET_SEL(PNP_TS1, info, *((u16 *) info));
 	status = call_pnp_bios(PNP_SET_STATIC_ALLOCED_RES_INFO, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0);
+	spin_unlock_irqrestore(&pnp_bios_lock, flags);
 	return status;
 }
 #endif
@@ -410,11 +433,14 @@
  */
 static int __pnp_bios_get_stat_res(char *info)
 {
+	unsigned long flags;
 	u16 status;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
+	spin_lock_irqsave(&pnp_bios_lock, flags);
 	Q2_SET_SEL(PNP_TS1, info, 64 * 1024);
 	status = call_pnp_bios(PNP_GET_STATIC_ALLOCED_RES_INFO, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0);
+	spin_unlock_irqrestore(&pnp_bios_lock, flags);
 	return status;
 }
 
@@ -433,12 +459,15 @@
  */
 static int pnp_bios_apm_id_table(char *table, u16 *size)
 {
+	unsigned long flags;
 	u16 status;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
+	spin_lock_irqsave(&pnp_bios_lock, flags);
 	Q2_SET_SEL(PNP_TS1, table, *size);
 	Q2_SET_SEL(PNP_TS2, size, sizeof(u16));
 	status = call_pnp_bios(PNP_GET_APM_ID_TABLE, 0, PNP_TS2, 0, PNP_TS1, PNP_DS, 0, 0);
+	spin_unlock_irqrestore(&pnp_bios_lock, flags);
 	return status;
 }
 #endif
@@ -448,11 +477,14 @@
  */
 static int __pnp_bios_isapnp_config(struct pnp_isa_config_struc *data)
 {
+	unsigned long flags;
 	u16 status;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
+	spin_lock_irqsave(&pnp_bios_lock, flags);
 	Q2_SET_SEL(PNP_TS1, data, sizeof(struct pnp_isa_config_struc));
 	status = call_pnp_bios(PNP_GET_PNP_ISA_CONFIG_STRUC, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0);
+	spin_unlock_irqrestore(&pnp_bios_lock, flags);
 	return status;
 }
 
@@ -470,11 +502,14 @@
  */
 static int __pnp_bios_escd_info(struct escd_info_struc *data)
 {
+	unsigned long flags;
 	u16 status;
 	if (!pnp_bios_present())
 		return ESCD_FUNCTION_NOT_SUPPORTED;
+	spin_lock_irqsave(&pnp_bios_lock, flags);
 	Q2_SET_SEL(PNP_TS1, data, sizeof(struct escd_info_struc));
 	status = call_pnp_bios(PNP_GET_ESCD_INFO, 0, PNP_TS1, 2, PNP_TS1, 4, PNP_TS1, PNP_DS);
+	spin_unlock_irqrestore(&pnp_bios_lock, flags);
 	return status;
 }
 
@@ -493,13 +528,16 @@
  */
 static int __pnp_bios_read_escd(char *data, u32 nvram_base)
 {
+	unsigned long flags;
 	u16 status;
 	if (!pnp_bios_present())
 		return ESCD_FUNCTION_NOT_SUPPORTED;
+	spin_lock_irqsave(&pnp_bios_lock, flags);
 	Q2_SET_SEL(PNP_TS1, data, 64 * 1024);
 	set_base(gdt[PNP_TS2 >> 3], nvram_base);
 	set_limit(gdt[PNP_TS2 >> 3], 64 * 1024);
 	status = call_pnp_bios(PNP_READ_ESCD, 0, PNP_TS1, PNP_TS2, PNP_DS, 0, 0, 0);
+	spin_unlock_irqrestore(&pnp_bios_lock, flags);
 	return status;
 }
 
@@ -518,13 +556,16 @@
  */
 static int pnp_bios_write_escd(char *data, u32 nvram_base)
 {
+	unsigned long flags;
 	u16 status;
 	if (!pnp_bios_present())
 		return ESCD_FUNCTION_NOT_SUPPORTED;
+	spin_lock_irqsave(&pnp_bios_lock, flags);
 	Q2_SET_SEL(PNP_TS1, data, 64 * 1024);
 	set_base(gdt[PNP_TS2 >> 3], nvram_base);
 	set_limit(gdt[PNP_TS2 >> 3], 64 * 1024);
 	status = call_pnp_bios(PNP_WRITE_ESCD, 0, PNP_TS1, PNP_TS2, PNP_DS, 0, 0, 0);
+	spin_unlock_irqrestore(&pnp_bios_lock, flags);
 	return status;
 }
 #endif
@@ -606,7 +647,7 @@
 	int docked = -1, d = 0;
 	daemonize();
 	reparent_to_init();
-	strcpy(current->comm, "kpnpbios");
+	strcpy(current->comm, "kpnpbiosd");
 	while(!unloading && !signal_pending(current))
 	{
 		int status;

