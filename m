Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbVJSR5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbVJSR5Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 13:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbVJSR5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 13:57:16 -0400
Received: from [85.21.88.2] ([85.21.88.2]:50082 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S1751202AbVJSR5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 13:57:15 -0400
Message-ID: <435688F9.8030509@ru.mvista.com>
Date: Wed, 19 Oct 2005 21:57:13 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Kumar Gala <galak@freescale.com>,
       linuxppc-embedded list <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ppc32: ppc_sys fixes for 8xx and 82xx (whitespaces fixed)
Content-Type: multipart/mixed;
 boundary="------------040409040506060205060709"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040409040506060205060709
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes a numbers of issues regarding to that both 8xx and 82xx
began to use ppc_sys model:
	- Platform is now identified by default deviceless SOC, if no
BOARD_CHIP_NAME is specified in the bard-specific header. For the list
of supported names refer to (arch/ppc/syslib/) mpc8xx_sys.c and
mpc82xx_sys.c for 8xx and 82xx respectively.
	- Fixed a bug in identification by name - if the name was not found, it
returned -1 instead of default deviceless ppc_spec.
	- fixed devices amount in the 8xx platform system descriptions


Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
-- 
Sincerely,
Vitaly


--------------040409040506060205060709
Content-Type: text/x-patch;
 name="2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.patch"

diff --git a/arch/ppc/platforms/fads.h b/arch/ppc/platforms/fads.h
--- a/arch/ppc/platforms/fads.h
+++ b/arch/ppc/platforms/fads.h
@@ -25,6 +25,8 @@
 
 #if defined(CONFIG_MPC86XADS)
 
+#define BOARD_CHIP_NAME "MPC86X"
+
 /* U-Boot maps BCSR to 0xff080000 */
 #define BCSR_ADDR		((uint)0xff080000)
 
diff --git a/arch/ppc/platforms/mpc885ads.h b/arch/ppc/platforms/mpc885ads.h
--- a/arch/ppc/platforms/mpc885ads.h
+++ b/arch/ppc/platforms/mpc885ads.h
@@ -88,5 +88,7 @@
 #define SICR_ENET_MASK	((uint)0x00ff0000)
 #define SICR_ENET_CLKRT	((uint)0x002c0000)
 
+#define BOARD_CHIP_NAME "MPC885"
+
 #endif /* __ASM_MPC885ADS_H__ */
 #endif /* __KERNEL__ */
diff --git a/arch/ppc/syslib/m8260_setup.c b/arch/ppc/syslib/m8260_setup.c
--- a/arch/ppc/syslib/m8260_setup.c
+++ b/arch/ppc/syslib/m8260_setup.c
@@ -62,6 +62,10 @@ m8260_setup_arch(void)
 	if (initrd_start)
 		ROOT_DEV = Root_RAM0;
 #endif
+
+	identify_ppc_sys_by_name_and_id(BOARD_CHIP_NAME, 
+				in_be32(CPM_MAP_ADDR + CPM_IMMR_OFFSET));
+
 	m82xx_board_setup();
 }
 
diff --git a/arch/ppc/syslib/m8xx_setup.c b/arch/ppc/syslib/m8xx_setup.c
--- a/arch/ppc/syslib/m8xx_setup.c
+++ b/arch/ppc/syslib/m8xx_setup.c
@@ -404,6 +404,8 @@ platform_init(unsigned long r3, unsigned
 		strcpy(cmd_line, (char *)(r6+KERNELBASE));
 	}
 
+	identify_ppc_sys_by_name(BOARD_CHIP_NAME);
+
 	ppc_md.setup_arch		= m8xx_setup_arch;
 	ppc_md.show_percpuinfo		= m8xx_show_percpuinfo;
 	ppc_md.irq_canonicalize	= NULL;
diff --git a/arch/ppc/syslib/mpc8xx_sys.c b/arch/ppc/syslib/mpc8xx_sys.c
--- a/arch/ppc/syslib/mpc8xx_sys.c
+++ b/arch/ppc/syslib/mpc8xx_sys.c
@@ -24,7 +24,7 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 		.ppc_sys_name	= "MPC86X",
 		.mask 		= 0xFFFFFFFF,
 		.value 		= 0x00000000,
-		.num_devices	= 2,
+		.num_devices	= 7,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC8xx_CPM_FEC1,
@@ -40,7 +40,7 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 		.ppc_sys_name	= "MPC885",
 		.mask 		= 0xFFFFFFFF,
 		.value 		= 0x00000000,
-		.num_devices	= 3,
+		.num_devices	= 8,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC8xx_CPM_FEC1,
diff --git a/arch/ppc/syslib/ppc_sys.c b/arch/ppc/syslib/ppc_sys.c
--- a/arch/ppc/syslib/ppc_sys.c
+++ b/arch/ppc/syslib/ppc_sys.c
@@ -69,6 +69,9 @@ static int __init find_chip_by_name_and_
 			matched[j++] = i;
 		i++;
 	}
+
+	ret = i;
+
 	if (j != 0) {
 		for (i = 0; i < j; i++) {
 			if ((ppc_sys_specs[matched[i]].mask & id) ==
diff --git a/include/asm-ppc/cpm2.h b/include/asm-ppc/cpm2.h
--- a/include/asm-ppc/cpm2.h
+++ b/include/asm-ppc/cpm2.h
@@ -1087,6 +1087,9 @@ typedef struct im_idma {
 #define SCCR_PCIDF_MSK	0x00000078	/* PCI division factor	*/
 #define SCCR_PCIDF_SHIFT 3
 
+#ifndef CPM_IMMR_OFFSET
+#define CPM_IMMR_OFFSET	0x101a8
+#endif
 
 #endif /* __CPM2__ */
 #endif /* __KERNEL__ */
diff --git a/include/asm-ppc/mpc8260.h b/include/asm-ppc/mpc8260.h
--- a/include/asm-ppc/mpc8260.h
+++ b/include/asm-ppc/mpc8260.h
@@ -92,6 +92,10 @@ enum ppc_sys_devices {
 extern unsigned char __res[];
 #endif
 
+#ifndef BOARD_CHIP_NAME
+#define BOARD_CHIP_NAME ""
+#endif
+
 #endif /* CONFIG_8260 */
 #endif /* !__ASM_PPC_MPC8260_H__ */
 #endif /* __KERNEL__ */
diff --git a/include/asm-ppc/mpc8xx.h b/include/asm-ppc/mpc8xx.h
--- a/include/asm-ppc/mpc8xx.h
+++ b/include/asm-ppc/mpc8xx.h
@@ -113,6 +113,10 @@ enum ppc_sys_devices {
 	MPC8xx_CPM_USB,
 };
 
+#ifndef BOARD_CHIP_NAME
+#define BOARD_CHIP_NAME ""
+#endif
+
 #endif /* !__ASSEMBLY__ */
 #endif /* CONFIG_8xx */
 #endif /* __CONFIG_8xx_DEFS */

--------------040409040506060205060709--
