Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292792AbSCIOo2>; Sat, 9 Mar 2002 09:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292785AbSCIOoT>; Sat, 9 Mar 2002 09:44:19 -0500
Received: from hermes.toad.net ([162.33.130.251]:54702 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S292784AbSCIOoJ>;
	Sat, 9 Mar 2002 09:44:09 -0500
Subject: Re: PnP BIOS driver status
From: Thomas Hood <jdthood@mail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org
In-Reply-To: <E16jWYf-0008Q4-00@the-village.bc.nu>
In-Reply-To: <E16jWYf-0008Q4-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 09 Mar 2002 09:44:53 -0500
Message-Id: <1015685100.941.195.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan: I just tried to apply Brian's patch and noticed that 
it was against 2.5.6.  Here is his patch versus 2.4.19-pre2-ac3 
with the kpnpbios -> kpnpbiosd change added in. 
// Thomas

--- linux-2.4.19-pre2-ac3/drivers/pnp/pnpbios_core.c_ORIG	Fri Mar  8 17:35:44 2002
+++ linux-2.4.19-pre2-ac3/drivers/pnp/pnpbios_core.c	Sat Mar  9 09:39:56 2002
@@ -140,7 +140,9 @@
 static spinlock_t pnp_bios_lock;
 
 static inline u16 call_pnp_bios(u16 func, u16 arg1, u16 arg2, u16 arg3,
-                                u16 arg4, u16 arg5, u16 arg6, u16 arg7)
+                                u16 arg4, u16 arg5, u16 arg6, u16 arg7,
+                                void *ts1_base, u32 ts1_size,
+                                void *ts2_base, u32 ts2_size)
 {
 	unsigned long flags;
 	u16 status;
@@ -154,7 +156,12 @@
 
 	/* On some boxes IRQ's during PnP BIOS calls are deadly.  */
 	spin_lock_irqsave(&pnp_bios_lock, flags);
-	__cli();
+
+	if (ts1_size)
+		Q2_SET_SEL(PNP_TS1, ts1_base, ts1_size);
+	if (ts2_size)
+		Q2_SET_SEL(PNP_TS2, ts2_base, ts2_size);
+
 	__asm__ __volatile__(
 	        "pushl %%ebp\n\t"
 		"pushl %%edi\n\t"
@@ -220,7 +227,7 @@
 /*
  * Call this only after init time
  */
-static int pnp_bios_present(void)
+static inline int pnp_bios_present(void)
 {
 	return (pnp_bios_hdr != NULL);
 }
@@ -257,8 +264,8 @@
 	u16 status;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, data, sizeof(struct pnp_dev_node_info));
-	status = call_pnp_bios(PNP_GET_NUM_SYS_DEV_NODES, 0, PNP_TS1, 2, PNP_TS1, PNP_DS, 0, 0);
+	status = call_pnp_bios(PNP_GET_NUM_SYS_DEV_NODES, 0, PNP_TS1, 2, PNP_TS1, PNP_DS, 0, 0,
+			       data, sizeof(struct pnp_dev_node_info), 0, 0);
 	data->no_nodes &= 0xff;
 	return status;
 }
@@ -292,9 +299,8 @@
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	if ( !boot & pnpbios_dont_use_current_config )
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, nodenum, sizeof(char));
-	Q2_SET_SEL(PNP_TS2, data, 64 * 1024);
-	status = call_pnp_bios(PNP_GET_SYS_DEV_NODE, 0, PNP_TS1, 0, PNP_TS2, boot ? 2 : 1, PNP_DS, 0);
+	status = call_pnp_bios(PNP_GET_SYS_DEV_NODE, 0, PNP_TS1, 0, PNP_TS2, boot ? 2 : 1, PNP_DS, 0,
+			       nodenum, sizeof(char), data, 65536);
 	return status;
 }
 
@@ -321,8 +327,8 @@
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	if ( !boot & pnpbios_dont_use_current_config )
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, data, /* *((u16 *) data)*/ 65536);
-	status = call_pnp_bios(PNP_SET_SYS_DEV_NODE, nodenum, 0, PNP_TS1, boot ? 2 : 1, PNP_DS, 0, 0);
+	status = call_pnp_bios(PNP_SET_SYS_DEV_NODE, nodenum, 0, PNP_TS1, boot ? 2 : 1, PNP_DS, 0, 0,
+			       data, 65536, 0, 0);
 	return status;
 }
 
@@ -353,8 +359,8 @@
 	u16 status;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, event, sizeof(u16));
-	status = call_pnp_bios(PNP_GET_EVENT, 0, PNP_TS1, PNP_DS, 0, 0 ,0 ,0);
+	status = call_pnp_bios(PNP_GET_EVENT, 0, PNP_TS1, PNP_DS, 0, 0 ,0 ,0,
+			       event, sizeof(u16), 0, 0);
 	return status;
 }
 #endif
@@ -368,7 +374,7 @@
 	u16 status;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	status = call_pnp_bios(PNP_SEND_MESSAGE, message, PNP_DS, 0, 0, 0, 0, 0);
+	status = call_pnp_bios(PNP_SEND_MESSAGE, message, PNP_DS, 0, 0, 0, 0, 0, 0, 0, 0, 0);
 	return status;
 }
 #endif
@@ -382,8 +388,8 @@
 	u16 status;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, data, sizeof(struct pnp_docking_station_info));
-	status = call_pnp_bios(PNP_GET_DOCKING_STATION_INFORMATION, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0);
+	status = call_pnp_bios(PNP_GET_DOCKING_STATION_INFORMATION, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0,
+			       data, sizeof(struct pnp_docking_station_info), 0, 0);
 	return status;
 }
 #endif
@@ -398,8 +404,8 @@
 	u16 status;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, info, *((u16 *) info));
-	status = call_pnp_bios(PNP_SET_STATIC_ALLOCED_RES_INFO, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0);
+	status = call_pnp_bios(PNP_SET_STATIC_ALLOCED_RES_INFO, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0,
+			       info, *((u16 *) info), 0, 0);
 	return status;
 }
 #endif
@@ -413,8 +419,8 @@
 	u16 status;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, info, 64 * 1024);
-	status = call_pnp_bios(PNP_GET_STATIC_ALLOCED_RES_INFO, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0);
+	status = call_pnp_bios(PNP_GET_STATIC_ALLOCED_RES_INFO, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0,
+			       info, 65536, 0, 0);
 	return status;
 }
 
@@ -436,9 +442,8 @@
 	u16 status;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, table, *size);
-	Q2_SET_SEL(PNP_TS2, size, sizeof(u16));
-	status = call_pnp_bios(PNP_GET_APM_ID_TABLE, 0, PNP_TS2, 0, PNP_TS1, PNP_DS, 0, 0);
+	status = call_pnp_bios(PNP_GET_APM_ID_TABLE, 0, PNP_TS2, 0, PNP_TS1, PNP_DS, 0, 0,
+			       table, *size, size, sizeof(u16));
 	return status;
 }
 #endif
@@ -451,8 +456,8 @@
 	u16 status;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, data, sizeof(struct pnp_isa_config_struc));
-	status = call_pnp_bios(PNP_GET_PNP_ISA_CONFIG_STRUC, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0);
+	status = call_pnp_bios(PNP_GET_PNP_ISA_CONFIG_STRUC, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0,
+			       data, sizeof(struct pnp_isa_config_struc), 0, 0);
 	return status;
 }
 
@@ -473,8 +478,8 @@
 	u16 status;
 	if (!pnp_bios_present())
 		return ESCD_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, data, sizeof(struct escd_info_struc));
-	status = call_pnp_bios(PNP_GET_ESCD_INFO, 0, PNP_TS1, 2, PNP_TS1, 4, PNP_TS1, PNP_DS);
+	status = call_pnp_bios(PNP_GET_ESCD_INFO, 0, PNP_TS1, 2, PNP_TS1, 4, PNP_TS1, PNP_DS,
+			       data, sizeof(struct escd_info_struc), 0, 0);
 	return status;
 }
 
@@ -496,10 +501,8 @@
 	u16 status;
 	if (!pnp_bios_present())
 		return ESCD_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, data, 64 * 1024);
-	set_base(gdt[PNP_TS2 >> 3], nvram_base);
-	set_limit(gdt[PNP_TS2 >> 3], 64 * 1024);
-	status = call_pnp_bios(PNP_READ_ESCD, 0, PNP_TS1, PNP_TS2, PNP_DS, 0, 0, 0);
+	status = call_pnp_bios(PNP_READ_ESCD, 0, PNP_TS1, PNP_TS2, PNP_DS, 0, 0, 0,
+			       data, 65536, nvram_base, 65536);
 	return status;
 }
 
@@ -521,10 +524,8 @@
 	u16 status;
 	if (!pnp_bios_present())
 		return ESCD_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, data, 64 * 1024);
-	set_base(gdt[PNP_TS2 >> 3], nvram_base);
-	set_limit(gdt[PNP_TS2 >> 3], 64 * 1024);
-	status = call_pnp_bios(PNP_WRITE_ESCD, 0, PNP_TS1, PNP_TS2, PNP_DS, 0, 0, 0);
+	status = call_pnp_bios(PNP_WRITE_ESCD, 0, PNP_TS1, PNP_TS2, PNP_DS, 0, 0, 0,
+			       data, 65536, nvram_base, 65536);
 	return status;
 }
 #endif
@@ -606,7 +607,7 @@
 	int docked = -1, d = 0;
 	daemonize();
 	reparent_to_init();
-	strcpy(current->comm, "kpnpbios");
+	strcpy(current->comm, "kpnpbiosd");
 	while(!unloading && !signal_pending(current))
 	{
 		int status;

