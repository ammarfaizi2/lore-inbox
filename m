Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292415AbSCICYi>; Fri, 8 Mar 2002 21:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292419AbSCICYa>; Fri, 8 Mar 2002 21:24:30 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:22920 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S292415AbSCICYQ>; Fri, 8 Mar 2002 21:24:16 -0500
Message-ID: <3C897238.CA903C93@didntduck.org>
Date: Fri, 08 Mar 2002 21:23:52 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Hood <jdthood@mail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PnP BIOS driver status
In-Reply-To: <1015628440.14518.212.camel@thanatos>
	 <3C895E90.696E92A2@didntduck.org> <1015636233.988.9.camel@thanatos>
Content-Type: multipart/mixed;
 boundary="------------F3FFBD3F7E4F9B8C61054210"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F3FFBD3F7E4F9B8C61054210
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Thomas Hood wrote:
> 
> On Fri, 2002-03-08 at 20:00, Brian Gerst wrote:
> > The current driver is not SMP-safe.
> 
> That's true.
> 
> > It is modifying the GDT descriptors
> > outside of the pnp_bios_lock.  Also, you can remove the __cli(), as
> > spin_lock_irq() already turns off interrupts.
> 
> I'd welcome a patch like the return of a kidnapped pet.

How does this patch look?  Against 2.5.6

-- 

						Brian Gerst
--------------F3FFBD3F7E4F9B8C61054210
Content-Type: text/plain; charset=us-ascii;
 name="pnpbios-segs-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnpbios-segs-1"

diff -urN linux-2.5.6/drivers/pnp/pnpbios_core.c linux/drivers/pnp/pnpbios_core.c
--- linux-2.5.6/drivers/pnp/pnpbios_core.c	Fri Mar  8 07:51:30 2002
+++ linux/drivers/pnp/pnpbios_core.c	Fri Mar  8 21:15:58 2002
@@ -141,7 +141,9 @@
 static spinlock_t pnp_bios_lock;
 
 static inline u16 call_pnp_bios(u16 func, u16 arg1, u16 arg2, u16 arg3,
-                                u16 arg4, u16 arg5, u16 arg6, u16 arg7)
+				u16 arg4, u16 arg5, u16 arg6, u16 arg7,
+				void *ts1_base, u32 ts1_size,
+				void *ts2_base, u32 ts2_size)
 {
 	unsigned long flags;
 	u16 status;
@@ -155,7 +157,12 @@
 
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
@@ -253,8 +260,8 @@
 	u16 status;
 	if (!pnp_bios_present ())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, data, sizeof(struct pnp_dev_node_info));
-	status = call_pnp_bios(PNP_GET_NUM_SYS_DEV_NODES, 0, PNP_TS1, 2, PNP_TS1, PNP_DS, 0, 0);
+	status = call_pnp_bios(PNP_GET_NUM_SYS_DEV_NODES, 0, PNP_TS1, 2, PNP_TS1, PNP_DS, 0, 0,
+			       data, sizeof(struct pnp_dev_node_info), 0, 0);
 	data->no_nodes &= 0xff;
 	return status;
 }
@@ -288,9 +295,8 @@
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
 
@@ -317,8 +323,8 @@
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	if ( !boot & pnpbios_dont_use_current_config )
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, data, /* *((u16 *) data)*/ 65536);
-	status = call_pnp_bios(PNP_SET_SYS_DEV_NODE, nodenum, 0, PNP_TS1, boot ? 2 : 1, PNP_DS, 0, 0);
+	status = call_pnp_bios(PNP_SET_SYS_DEV_NODE, nodenum, 0, PNP_TS1, boot ? 2 : 1, PNP_DS, 0, 0,
+			       data, 65536, 0, 0);
 	return status;
 }
 
@@ -352,8 +358,8 @@
 	u16 status;
 	if (!pnp_bios_present ())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, event, sizeof(u16));
-	status = call_pnp_bios(PNP_GET_EVENT, 0, PNP_TS1, PNP_DS, 0, 0 ,0 ,0);
+	status = call_pnp_bios(PNP_GET_EVENT, 0, PNP_TS1, PNP_DS, 0, 0 ,0 ,0,
+			       event, sizeof(u16), 0, 0);
 	return status;
 }
 #endif
@@ -367,7 +373,7 @@
 	u16 status;
 	if (!pnp_bios_present ())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	status = call_pnp_bios(PNP_SEND_MESSAGE, message, PNP_DS, 0, 0, 0, 0, 0);
+	status = call_pnp_bios(PNP_SEND_MESSAGE, message, PNP_DS, 0, 0, 0, 0, 0, 0, 0, 0, 0);
 	return status;
 }
 #endif
@@ -381,8 +387,8 @@
 	u16 status;
 	if (!pnp_bios_present ())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, data, sizeof(struct pnp_docking_station_info));
-	status = call_pnp_bios(PNP_GET_DOCKING_STATION_INFORMATION, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0);
+	status = call_pnp_bios(PNP_GET_DOCKING_STATION_INFORMATION, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0,
+			       data, sizeof(struct pnp_docking_station_info), 0, 0);
 	return status;
 }
 #endif
@@ -397,8 +403,8 @@
 	u16 status;
 	if (!pnp_bios_present ())
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
 	if (!pnp_bios_present ())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, info, 64 * 1024);
-	status = call_pnp_bios(PNP_GET_STATIC_ALLOCED_RES_INFO, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0);
+	status = call_pnp_bios(PNP_GET_STATIC_ALLOCED_RES_INFO, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0,
+			       info, 65536, 0, 0);
 	return status;
 }
 #endif
@@ -428,9 +434,8 @@
 	u16 status;
 	if (!pnp_bios_present ())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, table, *size);
-	Q2_SET_SEL(PNP_TS2, size, sizeof(u16));
-	status = call_pnp_bios(PNP_GET_APM_ID_TABLE, 0, PNP_TS2, 0, PNP_TS1, PNP_DS, 0, 0);
+	status = call_pnp_bios(PNP_GET_APM_ID_TABLE, 0, PNP_TS2, 0, PNP_TS1, PNP_DS, 0, 0,
+			       table, *size, size, sizeof(u16));
 	return status;
 }
 #endif
@@ -444,8 +449,8 @@
 	u16 status;
 	if (!pnp_bios_present ())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, data, sizeof(struct pnp_isa_config_struc));
-	status = call_pnp_bios(PNP_GET_PNP_ISA_CONFIG_STRUC, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0);
+	status = call_pnp_bios(PNP_GET_PNP_ISA_CONFIG_STRUC, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0,
+			       data, sizeof(struct pnp_isa_config_struc), 0, 0);
 	return status;
 }
 #endif
@@ -459,8 +464,8 @@
 	u16 status;
 	if (!pnp_bios_present ())
 		return ESCD_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, data, sizeof(struct escd_info_struc));
-	status = call_pnp_bios(PNP_GET_ESCD_INFO, 0, PNP_TS1, 2, PNP_TS1, 4, PNP_TS1, PNP_DS);
+	status = call_pnp_bios(PNP_GET_ESCD_INFO, 0, PNP_TS1, 2, PNP_TS1, 4, PNP_TS1, PNP_DS,
+			       data, sizeof(struct escd_info_struc), 0, 0);
 	return status;
 }
 #endif
@@ -475,10 +480,8 @@
 	u16 status;
 	if (!pnp_bios_present ())
 		return ESCD_FUNCTION_NOT_SUPPORTED;
-	Q2_SET_SEL(PNP_TS1, data, 64 * 1024);
-	set_base(gdt[PNP_TS2 >> 3], nvram_base);
-	set_limit(gdt[PNP_TS2 >> 3], 64 * 1024);
-	status = call_pnp_bios(PNP_READ_ESCD, 0, PNP_TS1, PNP_TS2, PNP_DS, 0, 0, 0);
+	status = call_pnp_bios(PNP_READ_ESCD, 0, PNP_TS1, PNP_TS2, PNP_DS, 0, 0, 0,
+			       data, 65536, nvram_base, 65536);
 	return status;
 }
 #endif
@@ -492,10 +495,8 @@
 	u16 status;
 	if (!pnp_bios_present ())
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

--------------F3FFBD3F7E4F9B8C61054210--

