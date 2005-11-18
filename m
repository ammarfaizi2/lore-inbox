Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161166AbVKRUMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161166AbVKRUMv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 15:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161171AbVKRUMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 15:12:51 -0500
Received: from havoc.gtf.org ([69.61.125.42]:33180 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1161166AbVKRUMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 15:12:49 -0500
Date: Fri, 18 Nov 2005 15:12:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] 2.6.x net driver fixes
Message-ID: <20051118201248.GA5573@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following assorted fixes:

 drivers/net/au1000_eth.c                |    1 
 drivers/net/e100.c                      |  273 ++++++++++++++++++++++++++++++--
 drivers/net/fec_8xx/Kconfig             |    2 
 drivers/net/ioc3-eth.c                  |    2 
 drivers/net/r8169.c                     |    6 
 drivers/net/saa9730.h                   |   36 ++--
 drivers/net/smc91x.c                    |   17 +
 drivers/net/wan/hdlc_cisco.c            |    6 
 drivers/net/wan/hdlc_fr.c               |    4 
 drivers/net/wan/hdlc_generic.c          |    6 
 drivers/net/wireless/hermes.c           |    6 
 drivers/net/wireless/hermes.h           |    6 
 drivers/net/wireless/i82593.h           |   11 -
 drivers/net/wireless/ipw2100.c          |   29 ++-
 drivers/net/wireless/ipw2100.h          |    2 
 drivers/net/wireless/prism54/isl_38xx.c |    4 
 include/net/ieee80211.h                 |    2 
 17 files changed, 352 insertions(+), 61 deletions(-)

Andrew Morton:
      git-netdev-all-ieee80211_get_payload-warning-fix

Francois Romieu:
      r8169: fix printk_ratelimit in the interrupt handler
      r8169: do not abort when the power management capabilities are disabled

Gabriel A. Devenyi:
      drivers/net/wireless/hermes.c unsigned int comparision

James Ketrenos:
      ipw2100: Fix 'Driver using old /proc/net/wireless...' message

Jeff Garzik:
      [wireless hermes] build fix

Jesse Brandeburg:
      e100: re-enable microcode with more useful defaults

John W. Linville:
      i82593.h: make header comment GPL-compatible
      fec_8xx: make CONFIG_FEC_8XX depend on CONFIG_8xx

Krzysztof Halasa:
      Generic HDLC WAN drivers - disable netif_carrier_off()

Nicolas Pitre:
      smc91x: fix one source of spurious interrupts

Ralf Baechle:
      IOC3: Replace obsolete PCI API
      au1000_eth: Include <linux/config.h>
      SAA9730: Add missing header bits.

Roger While:
      prism54 : Remove extraneous udelay/register read

Russell King:
      smc91x: fix bank mismatch

diff --git a/drivers/net/au1000_eth.c b/drivers/net/au1000_eth.c
index 332e995..cd0b1dc 100644
--- a/drivers/net/au1000_eth.c
+++ b/drivers/net/au1000_eth.c
@@ -32,6 +32,7 @@
  * 
  */
 
+#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
diff --git a/drivers/net/e100.c b/drivers/net/e100.c
index 7a6aeae..22cd045 100644
--- a/drivers/net/e100.c
+++ b/drivers/net/e100.c
@@ -156,7 +156,7 @@
 
 #define DRV_NAME		"e100"
 #define DRV_EXT		"-NAPI"
-#define DRV_VERSION		"3.4.14-k2"DRV_EXT
+#define DRV_VERSION		"3.4.14-k4"DRV_EXT
 #define DRV_DESCRIPTION		"Intel(R) PRO/100 Network Driver"
 #define DRV_COPYRIGHT		"Copyright(c) 1999-2005 Intel Corporation"
 #define PFX			DRV_NAME ": "
@@ -903,8 +903,8 @@ static void mdio_write(struct net_device
 
 static void e100_get_defaults(struct nic *nic)
 {
-	struct param_range rfds = { .min = 16, .max = 256, .count = 64 };
-	struct param_range cbs  = { .min = 64, .max = 256, .count = 64 };
+	struct param_range rfds = { .min = 16, .max = 256, .count = 256 };
+	struct param_range cbs  = { .min = 64, .max = 256, .count = 128 };
 
 	pci_read_config_byte(nic->pdev, PCI_REVISION_ID, &nic->rev_id);
 	/* MAC type is encoded as rev ID; exception: ICH is treated as 82559 */
@@ -1007,25 +1007,264 @@ static void e100_configure(struct nic *n
 		c[16], c[17], c[18], c[19], c[20], c[21], c[22], c[23]);
 }
 
+/********************************************************/
+/*  Micro code for 8086:1229 Rev 8                      */
+/********************************************************/
+
+/*  Parameter values for the D101M B-step  */
+#define D101M_CPUSAVER_TIMER_DWORD		78
+#define D101M_CPUSAVER_BUNDLE_DWORD		65
+#define D101M_CPUSAVER_MIN_SIZE_DWORD		126
+
+#define D101M_B_RCVBUNDLE_UCODE \
+{\
+0x00550215, 0xFFFF0437, 0xFFFFFFFF, 0x06A70789, 0xFFFFFFFF, 0x0558FFFF, \
+0x000C0001, 0x00101312, 0x000C0008, 0x00380216, \
+0x0010009C, 0x00204056, 0x002380CC, 0x00380056, \
+0x0010009C, 0x00244C0B, 0x00000800, 0x00124818, \
+0x00380438, 0x00000000, 0x00140000, 0x00380555, \
+0x00308000, 0x00100662, 0x00100561, 0x000E0408, \
+0x00134861, 0x000C0002, 0x00103093, 0x00308000, \
+0x00100624, 0x00100561, 0x000E0408, 0x00100861, \
+0x000C007E, 0x00222C21, 0x000C0002, 0x00103093, \
+0x00380C7A, 0x00080000, 0x00103090, 0x00380C7A, \
+0x00000000, 0x00000000, 0x00000000, 0x00000000, \
+0x0010009C, 0x00244C2D, 0x00010004, 0x00041000, \
+0x003A0437, 0x00044010, 0x0038078A, 0x00000000, \
+0x00100099, 0x00206C7A, 0x0010009C, 0x00244C48, \
+0x00130824, 0x000C0001, 0x00101213, 0x00260C75, \
+0x00041000, 0x00010004, 0x00130826, 0x000C0006, \
+0x002206A8, 0x0013C926, 0x00101313, 0x003806A8, \
+0x00000000, 0x00000000, 0x00000000, 0x00000000, \
+0x00000000, 0x00000000, 0x00000000, 0x00000000, \
+0x00080600, 0x00101B10, 0x00050004, 0x00100826, \
+0x00101210, 0x00380C34, 0x00000000, 0x00000000, \
+0x0021155B, 0x00100099, 0x00206559, 0x0010009C, \
+0x00244559, 0x00130836, 0x000C0000, 0x00220C62, \
+0x000C0001, 0x00101B13, 0x00229C0E, 0x00210C0E, \
+0x00226C0E, 0x00216C0E, 0x0022FC0E, 0x00215C0E, \
+0x00214C0E, 0x00380555, 0x00010004, 0x00041000, \
+0x00278C67, 0x00040800, 0x00018100, 0x003A0437, \
+0x00130826, 0x000C0001, 0x00220559, 0x00101313, \
+0x00380559, 0x00000000, 0x00000000, 0x00000000, \
+0x00000000, 0x00000000, 0x00000000, 0x00000000, \
+0x00000000, 0x00130831, 0x0010090B, 0x00124813, \
+0x000CFF80, 0x002606AB, 0x00041000, 0x00010004, \
+0x003806A8, 0x00000000, 0x00000000, 0x00000000, \
+}
+
+/********************************************************/
+/*  Micro code for 8086:1229 Rev 9                      */
+/********************************************************/
+
+/*  Parameter values for the D101S  */
+#define D101S_CPUSAVER_TIMER_DWORD		78
+#define D101S_CPUSAVER_BUNDLE_DWORD		67
+#define D101S_CPUSAVER_MIN_SIZE_DWORD		128
+
+#define D101S_RCVBUNDLE_UCODE \
+{\
+0x00550242, 0xFFFF047E, 0xFFFFFFFF, 0x06FF0818, 0xFFFFFFFF, 0x05A6FFFF, \
+0x000C0001, 0x00101312, 0x000C0008, 0x00380243, \
+0x0010009C, 0x00204056, 0x002380D0, 0x00380056, \
+0x0010009C, 0x00244F8B, 0x00000800, 0x00124818, \
+0x0038047F, 0x00000000, 0x00140000, 0x003805A3, \
+0x00308000, 0x00100610, 0x00100561, 0x000E0408, \
+0x00134861, 0x000C0002, 0x00103093, 0x00308000, \
+0x00100624, 0x00100561, 0x000E0408, 0x00100861, \
+0x000C007E, 0x00222FA1, 0x000C0002, 0x00103093, \
+0x00380F90, 0x00080000, 0x00103090, 0x00380F90, \
+0x00000000, 0x00000000, 0x00000000, 0x00000000, \
+0x0010009C, 0x00244FAD, 0x00010004, 0x00041000, \
+0x003A047E, 0x00044010, 0x00380819, 0x00000000, \
+0x00100099, 0x00206FFD, 0x0010009A, 0x0020AFFD, \
+0x0010009C, 0x00244FC8, 0x00130824, 0x000C0001, \
+0x00101213, 0x00260FF7, 0x00041000, 0x00010004, \
+0x00130826, 0x000C0006, 0x00220700, 0x0013C926, \
+0x00101313, 0x00380700, 0x00000000, 0x00000000, \
+0x00000000, 0x00000000, 0x00000000, 0x00000000, \
+0x00080600, 0x00101B10, 0x00050004, 0x00100826, \
+0x00101210, 0x00380FB6, 0x00000000, 0x00000000, \
+0x002115A9, 0x00100099, 0x002065A7, 0x0010009A, \
+0x0020A5A7, 0x0010009C, 0x002445A7, 0x00130836, \
+0x000C0000, 0x00220FE4, 0x000C0001, 0x00101B13, \
+0x00229F8E, 0x00210F8E, 0x00226F8E, 0x00216F8E, \
+0x0022FF8E, 0x00215F8E, 0x00214F8E, 0x003805A3, \
+0x00010004, 0x00041000, 0x00278FE9, 0x00040800, \
+0x00018100, 0x003A047E, 0x00130826, 0x000C0001, \
+0x002205A7, 0x00101313, 0x003805A7, 0x00000000, \
+0x00000000, 0x00000000, 0x00000000, 0x00000000, \
+0x00000000, 0x00000000, 0x00000000, 0x00130831, \
+0x0010090B, 0x00124813, 0x000CFF80, 0x00260703, \
+0x00041000, 0x00010004, 0x00380700  \
+}
+
+/********************************************************/
+/*  Micro code for the 8086:1229 Rev F/10               */
+/********************************************************/
+
+/*  Parameter values for the D102 E-step  */
+#define D102_E_CPUSAVER_TIMER_DWORD		42
+#define D102_E_CPUSAVER_BUNDLE_DWORD		54
+#define D102_E_CPUSAVER_MIN_SIZE_DWORD		46
+
+#define     D102_E_RCVBUNDLE_UCODE \
+{\
+0x007D028F, 0x0E4204F9, 0x14ED0C85, 0x14FA14E9, 0x0EF70E36, 0x1FFF1FFF, \
+0x00E014B9, 0x00000000, 0x00000000, 0x00000000, \
+0x00E014BD, 0x00000000, 0x00000000, 0x00000000, \
+0x00E014D5, 0x00000000, 0x00000000, 0x00000000, \
+0x00000000, 0x00000000, 0x00000000, 0x00000000, \
+0x00E014C1, 0x00000000, 0x00000000, 0x00000000, \
+0x00000000, 0x00000000, 0x00000000, 0x00000000, \
+0x00000000, 0x00000000, 0x00000000, 0x00000000, \
+0x00000000, 0x00000000, 0x00000000, 0x00000000, \
+0x00E014C8, 0x00000000, 0x00000000, 0x00000000, \
+0x00200600, 0x00E014EE, 0x00000000, 0x00000000, \
+0x0030FF80, 0x00940E46, 0x00038200, 0x00102000, \
+0x00E00E43, 0x00000000, 0x00000000, 0x00000000, \
+0x00300006, 0x00E014FB, 0x00000000, 0x00000000, \
+0x00000000, 0x00000000, 0x00000000, 0x00000000, \
+0x00000000, 0x00000000, 0x00000000, 0x00000000, \
+0x00000000, 0x00000000, 0x00000000, 0x00000000, \
+0x00906E41, 0x00800E3C, 0x00E00E39, 0x00000000, \
+0x00906EFD, 0x00900EFD, 0x00E00EF8, 0x00000000, \
+0x00000000, 0x00000000, 0x00000000, 0x00000000, \
+0x00000000, 0x00000000, 0x00000000, 0x00000000, \
+0x00000000, 0x00000000, 0x00000000, 0x00000000, \
+0x00000000, 0x00000000, 0x00000000, 0x00000000, \
+0x00000000, 0x00000000, 0x00000000, 0x00000000, \
+0x00000000, 0x00000000, 0x00000000, 0x00000000, \
+0x00000000, 0x00000000, 0x00000000, 0x00000000, \
+0x00000000, 0x00000000, 0x00000000, 0x00000000, \
+0x00000000, 0x00000000, 0x00000000, 0x00000000, \
+0x00000000, 0x00000000, 0x00000000, 0x00000000, \
+0x00000000, 0x00000000, 0x00000000, 0x00000000, \
+0x00000000, 0x00000000, 0x00000000, 0x00000000, \
+0x00000000, 0x00000000, 0x00000000, 0x00000000, \
+0x00000000, 0x00000000, 0x00000000, 0x00000000, \
+}
+
 static void e100_load_ucode(struct nic *nic, struct cb *cb, struct sk_buff *skb)
 {
-	int i;
-	static const u32 ucode[UCODE_SIZE] = {
-		/* NFS packets are misinterpreted as TCO packets and
-		 * incorrectly routed to the BMC over SMBus.  This
-		 * microcode patch checks the fragmented IP bit in the
-		 * NFS/UDP header to distinguish between NFS and TCO. */
-		0x0EF70E36, 0x1FFF1FFF, 0x1FFF1FFF, 0x1FFF1FFF, 0x1FFF1FFF,
-		0x1FFF1FFF, 0x00906E41, 0x00800E3C, 0x00E00E39, 0x00000000,
-		0x00906EFD, 0x00900EFD,	0x00E00EF8,
-	};
+/* *INDENT-OFF* */
+	static struct {
+		u32 ucode[UCODE_SIZE + 1];
+		u8 mac;
+		u8 timer_dword;
+		u8 bundle_dword;
+		u8 min_size_dword;
+	} ucode_opts[] = {
+		{ D101M_B_RCVBUNDLE_UCODE,
+		  mac_82559_D101M,
+		  D101M_CPUSAVER_TIMER_DWORD,
+		  D101M_CPUSAVER_BUNDLE_DWORD,
+		  D101M_CPUSAVER_MIN_SIZE_DWORD },
+		{ D101S_RCVBUNDLE_UCODE,
+		  mac_82559_D101S,
+		  D101S_CPUSAVER_TIMER_DWORD,
+		  D101S_CPUSAVER_BUNDLE_DWORD,
+		  D101S_CPUSAVER_MIN_SIZE_DWORD },
+		{ D102_E_RCVBUNDLE_UCODE,
+		  mac_82551_F,
+		  D102_E_CPUSAVER_TIMER_DWORD,
+		  D102_E_CPUSAVER_BUNDLE_DWORD,
+		  D102_E_CPUSAVER_MIN_SIZE_DWORD },
+		{ D102_E_RCVBUNDLE_UCODE,
+		  mac_82551_10,
+		  D102_E_CPUSAVER_TIMER_DWORD,
+		  D102_E_CPUSAVER_BUNDLE_DWORD,
+		  D102_E_CPUSAVER_MIN_SIZE_DWORD },
+		{ {0}, 0, 0, 0, 0}
+	}, *opts;
+/* *INDENT-ON* */
+
+/*************************************************************************
+*  CPUSaver parameters
+*
+*  All CPUSaver parameters are 16-bit literals that are part of a
+*  "move immediate value" instruction.  By changing the value of
+*  the literal in the instruction before the code is loaded, the
+*  driver can change the algorithm.
+*
+*  INTDELAY - This loads the dead-man timer with its inital value.
+*    When this timer expires the interrupt is asserted, and the 
+*    timer is reset each time a new packet is received.  (see
+*    BUNDLEMAX below to set the limit on number of chained packets)
+*    The current default is 0x600 or 1536.  Experiments show that
+*    the value should probably stay within the 0x200 - 0x1000.
+*
+*  BUNDLEMAX - 
+*    This sets the maximum number of frames that will be bundled.  In
+*    some situations, such as the TCP windowing algorithm, it may be
+*    better to limit the growth of the bundle size than let it go as
+*    high as it can, because that could cause too much added latency.
+*    The default is six, because this is the number of packets in the
+*    default TCP window size.  A value of 1 would make CPUSaver indicate
+*    an interrupt for every frame received.  If you do not want to put
+*    a limit on the bundle size, set this value to xFFFF.
+*
+*  BUNDLESMALL - 
+*    This contains a bit-mask describing the minimum size frame that
+*    will be bundled.  The default masks the lower 7 bits, which means
+*    that any frame less than 128 bytes in length will not be bundled,
+*    but will instead immediately generate an interrupt.  This does
+*    not affect the current bundle in any way.  Any frame that is 128
+*    bytes or large will be bundled normally.  This feature is meant
+*    to provide immediate indication of ACK frames in a TCP environment.
+*    Customers were seeing poor performance when a machine with CPUSaver
+*    enabled was sending but not receiving.  The delay introduced when
+*    the ACKs were received was enough to reduce total throughput, because
+*    the sender would sit idle until the ACK was finally seen.
+*
+*    The current default is 0xFF80, which masks out the lower 7 bits.
+*    This means that any frame which is x7F (127) bytes or smaller
+*    will cause an immediate interrupt.  Because this value must be a 
+*    bit mask, there are only a few valid values that can be used.  To
+*    turn this feature off, the driver can write the value xFFFF to the
+*    lower word of this instruction (in the same way that the other
+*    parameters are used).  Likewise, a value of 0xF800 (2047) would
+*    cause an interrupt to be generated for every frame, because all
+*    standard Ethernet frames are <= 2047 bytes in length.
+*************************************************************************/
+
+/* if you wish to disable the ucode functionality, while maintaining the 
+ * workarounds it provides, set the following defines to:
+ * BUNDLESMALL 0
+ * BUNDLEMAX 1
+ * INTDELAY 1
+ */
+#define BUNDLESMALL 1
+#define BUNDLEMAX (u16)6
+#define INTDELAY (u16)1536 /* 0x600 */
+
+	/* do not load u-code for ICH devices */
+	if (nic->flags & ich)
+		goto noloaducode;
+
+	/* Search for ucode match against h/w rev_id */
+	for (opts = ucode_opts; opts->mac; opts++) {
+		int i;
+		u32 *ucode = opts->ucode;
+		if (nic->mac != opts->mac)
+			continue;
+
+		/* Insert user-tunable settings */
+		ucode[opts->timer_dword] &= 0xFFFF0000;
+		ucode[opts->timer_dword] |= INTDELAY;
+		ucode[opts->bundle_dword] &= 0xFFFF0000;
+		ucode[opts->bundle_dword] |= BUNDLEMAX;
+		ucode[opts->min_size_dword] &= 0xFFFF0000;
+		ucode[opts->min_size_dword] |= (BUNDLESMALL) ? 0xFFFF : 0xFF80;
 
-	if(nic->mac == mac_82551_F || nic->mac == mac_82551_10) {
-		for(i = 0; i < UCODE_SIZE; i++)
+		for (i = 0; i < UCODE_SIZE; i++)
 			cb->u.ucode[i] = cpu_to_le32(ucode[i]);
 		cb->command = cpu_to_le16(cb_ucode);
-	} else
-		cb->command = cpu_to_le16(cb_nop);
+		return;
+	}
+
+noloaducode:
+	cb->command = cpu_to_le16(cb_nop);
 }
 
 static void e100_setup_iaaddr(struct nic *nic, struct cb *cb,
diff --git a/drivers/net/fec_8xx/Kconfig b/drivers/net/fec_8xx/Kconfig
index 94e7a9a..a84c232 100644
--- a/drivers/net/fec_8xx/Kconfig
+++ b/drivers/net/fec_8xx/Kconfig
@@ -1,6 +1,6 @@
 config FEC_8XX
 	tristate "Motorola 8xx FEC driver"
-	depends on NET_ETHERNET && FEC
+	depends on NET_ETHERNET && 8xx
 	select MII
 
 config FEC_8XX_GENERIC_PHY
diff --git a/drivers/net/ioc3-eth.c b/drivers/net/ioc3-eth.c
index 6a3129b..9b8295e 100644
--- a/drivers/net/ioc3-eth.c
+++ b/drivers/net/ioc3-eth.c
@@ -1360,7 +1360,7 @@ static struct pci_driver ioc3_driver = {
 
 static int __init ioc3_init_module(void)
 {
-	return pci_module_init(&ioc3_driver);
+	return pci_register_driver(&ioc3_driver);
 }
 
 static void __exit ioc3_cleanup_module(void)
diff --git a/drivers/net/r8169.c b/drivers/net/r8169.c
index 159b56a..14a76f7 100644
--- a/drivers/net/r8169.c
+++ b/drivers/net/r8169.c
@@ -1346,10 +1346,8 @@ rtl8169_init_board(struct pci_dev *pdev,
 	} else {
 		if (netif_msg_probe(tp)) {
 			printk(KERN_ERR PFX
-			       "Cannot find PowerManagement capability. "
-			       "Aborting.\n");
+			       "PowerManagement capability not found.\n");
 		}
-		goto err_out_mwi;
 	}
 
 	/* make sure PCI base addr 1 is MMIO */
@@ -2516,7 +2514,7 @@ rtl8169_interrupt(int irq, void *dev_ins
 	} while (boguscnt > 0);
 
 	if (boguscnt <= 0) {
-		if (net_ratelimit() && netif_msg_intr(tp)) {
+		if (netif_msg_intr(tp) && net_ratelimit() ) {
 			printk(KERN_WARNING
 			       "%s: Too much work at interrupt!\n", dev->name);
 		}
diff --git a/drivers/net/saa9730.h b/drivers/net/saa9730.h
index 9e9da6b..a7e9d29 100644
--- a/drivers/net/saa9730.h
+++ b/drivers/net/saa9730.h
@@ -1,6 +1,7 @@
 /*
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
+ * Copyright (C) 2000, 2005  MIPS Technologies, Inc.  All rights reserved.
+ *	Authors: Carsten Langgaard <carstenl@mips.com>
+ *		 Maciej W. Rozycki <macro@mips.com>
  *
  * ########################################################################
  *
@@ -265,6 +266,7 @@
 
 /* The SAA9730 (LAN) controller register map, as seen via the PCI-bus. */
 #define SAA9730_LAN_REGS_ADDR   0x20400
+#define SAA9730_LAN_REGS_SIZE   0x00400
 
 struct lan_saa9730_regmap {
 	volatile unsigned int TxBuffA;			/* 0x20400 */
@@ -309,6 +311,7 @@ typedef volatile struct lan_saa9730_regm
 
 /* The SAA9730 (EVM) controller register map, as seen via the PCI-bus. */
 #define SAA9730_EVM_REGS_ADDR   0x02000
+#define SAA9730_EVM_REGS_SIZE   0x00400
 
 struct evm_saa9730_regmap {
 	volatile unsigned int InterruptStatus1;		/* 0x2000 */
@@ -329,16 +332,32 @@ typedef volatile struct evm_saa9730_regm
 
 
 struct lan_saa9730_private {
+	/*
+	 * Rx/Tx packet buffers.
+	 * The Rx and Tx packets must be PACKET_SIZE aligned.
+	 */
+	void		*buffer_start;
+	unsigned int	buffer_size;
+
+	/*
+	 * DMA address of beginning of this object, returned
+	 * by pci_alloc_consistent().
+	 */
+	dma_addr_t	dma_addr;
+
+	/* Pointer to the associated pci device structure */
+	struct pci_dev	*pci_dev;
+
 	/* Pointer for the SAA9730 LAN controller register set. */
 	t_lan_saa9730_regmap *lan_saa9730_regs;
 
 	/* Pointer to the SAA9730 EVM register. */
 	t_evm_saa9730_regmap *evm_saa9730_regs;
 
-	/* TRUE if the next buffer to write is RxBuffA,  FALSE if RxBuffB. */
-	unsigned char NextRcvToUseIsA;
 	/* Rcv buffer Index. */
 	unsigned char NextRcvPacketIndex;
+	/* Next buffer index. */
+	unsigned char NextRcvBufferIndex;
 
 	/* Index of next packet to use in that buffer. */
 	unsigned char NextTxmPacketIndex;
@@ -353,13 +372,8 @@ struct lan_saa9730_private {
 	unsigned char DmaRcvPackets;
 	unsigned char DmaTxmPackets;
 
-	unsigned char RcvAIndex;	/* index into RcvBufferSpace[] for Blk A */
-	unsigned char RcvBIndex;	/* index into RcvBufferSpace[] for Blk B */
-
-	unsigned int
-	    TxmBuffer[LAN_SAA9730_BUFFERS][LAN_SAA9730_TXM_Q_SIZE];
-	unsigned int
-	    RcvBuffer[LAN_SAA9730_BUFFERS][LAN_SAA9730_RCV_Q_SIZE];
+	void	      *TxmBuffer[LAN_SAA9730_BUFFERS][LAN_SAA9730_TXM_Q_SIZE];
+	void	      *RcvBuffer[LAN_SAA9730_BUFFERS][LAN_SAA9730_RCV_Q_SIZE];
 	unsigned int TxBufferFree[LAN_SAA9730_BUFFERS];
 
 	unsigned char PhysicalAddress[LAN_SAA9730_CAM_ENTRIES][6];
diff --git a/drivers/net/smc91x.c b/drivers/net/smc91x.c
index c91e2e8..28bf2e6 100644
--- a/drivers/net/smc91x.c
+++ b/drivers/net/smc91x.c
@@ -155,6 +155,12 @@ MODULE_LICENSE("GPL");
 #define MEMORY_WAIT_TIME	16
 
 /*
+ * The maximum number of processing loops allowed for each call to the
+ * IRQ handler.  
+ */
+#define MAX_IRQ_LOOPS		8
+
+/*
  * This selects whether TX packets are sent one by one to the SMC91x internal
  * memory and throttled until transmission completes.  This may prevent
  * RX overruns a litle by keeping much of the memory free for RX packets
@@ -684,7 +690,6 @@ static void smc_hardware_send_pkt(unsign
 
 	/* queue the packet for TX */
 	SMC_SET_MMU_CMD(MC_ENQUEUE);
-	SMC_ACK_INT(IM_TX_EMPTY_INT);
 	smc_special_unlock(&lp->lock);
 
 	dev->trans_start = jiffies;
@@ -1207,6 +1212,7 @@ static void smc_phy_configure(void *data
 	smc_phy_check_media(dev, 1);
 
 smc_phy_configure_exit:
+	SMC_SELECT_BANK(2);
 	spin_unlock_irq(&lp->lock);
 	lp->work_pending = 0;
 }
@@ -1305,7 +1311,7 @@ static irqreturn_t smc_interrupt(int irq
 	SMC_SET_INT_MASK(0);
 
 	/* set a timeout value, so I don't stay here forever */
-	timeout = 8;
+	timeout = MAX_IRQ_LOOPS;
 
 	do {
 		status = SMC_GET_INT();
@@ -1372,10 +1378,13 @@ static irqreturn_t smc_interrupt(int irq
 	/* restore register states */
 	SMC_SET_PTR(saved_pointer);
 	SMC_SET_INT_MASK(mask);
-
 	spin_unlock(&lp->lock);
 
-	DBG(3, "%s: Interrupt done (%d loops)\n", dev->name, 8-timeout);
+	if (timeout == MAX_IRQ_LOOPS)
+		PRINTK("%s: spurious interrupt (mask = 0x%02x)\n",
+		       dev->name, mask);
+	DBG(3, "%s: Interrupt done (%d loops)\n",
+	       dev->name, MAX_IRQ_LOOPS - timeout);
 
 	/*
 	 * We return IRQ_HANDLED unconditionally here even if there was
diff --git a/drivers/net/wan/hdlc_cisco.c b/drivers/net/wan/hdlc_cisco.c
index a01efa6..1fd0466 100644
--- a/drivers/net/wan/hdlc_cisco.c
+++ b/drivers/net/wan/hdlc_cisco.c
@@ -192,7 +192,9 @@ static int cisco_rx(struct sk_buff *skb)
 					       "uptime %ud%uh%um%us)\n",
 					       dev->name, days, hrs,
 					       min, sec);
+#if 0
 					netif_carrier_on(dev);
+#endif
 					hdlc->state.cisco.up = 1;
 				}
 			}
@@ -225,7 +227,9 @@ static void cisco_timer(unsigned long ar
 		       hdlc->state.cisco.settings.timeout * HZ)) {
 		hdlc->state.cisco.up = 0;
 		printk(KERN_INFO "%s: Link down\n", dev->name);
+#if 0
 		netif_carrier_off(dev);
+#endif
 	}
 
 	cisco_keepalive_send(dev, CISCO_KEEPALIVE_REQ,
@@ -261,8 +265,10 @@ static void cisco_stop(struct net_device
 {
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	del_timer_sync(&hdlc->state.cisco.timer);
+#if 0
 	if (netif_carrier_ok(dev))
 		netif_carrier_off(dev);
+#endif
 	hdlc->state.cisco.up = 0;
 	hdlc->state.cisco.request_sent = 0;
 }
diff --git a/drivers/net/wan/hdlc_fr.c b/drivers/net/wan/hdlc_fr.c
index e1601d3..523afe1 100644
--- a/drivers/net/wan/hdlc_fr.c
+++ b/drivers/net/wan/hdlc_fr.c
@@ -545,8 +545,10 @@ static void fr_set_link_state(int reliab
 
 	hdlc->state.fr.reliable = reliable;
 	if (reliable) {
+#if 0
 		if (!netif_carrier_ok(dev))
 			netif_carrier_on(dev);
+#endif
 
 		hdlc->state.fr.n391cnt = 0; /* Request full status */
 		hdlc->state.fr.dce_changed = 1;
@@ -560,8 +562,10 @@ static void fr_set_link_state(int reliab
 			}
 		}
 	} else {
+#if 0
 		if (netif_carrier_ok(dev))
 			netif_carrier_off(dev);
+#endif
 
 		while (pvc) {		/* Deactivate all PVCs */
 			pvc_carrier(0, pvc);
diff --git a/drivers/net/wan/hdlc_generic.c b/drivers/net/wan/hdlc_generic.c
index cdd4c09..46cef8f 100644
--- a/drivers/net/wan/hdlc_generic.c
+++ b/drivers/net/wan/hdlc_generic.c
@@ -79,11 +79,13 @@ static void __hdlc_set_carrier_on(struct
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	if (hdlc->proto.start)
 		return hdlc->proto.start(dev);
+#if 0
 #ifdef DEBUG_LINK
 	if (netif_carrier_ok(dev))
 		printk(KERN_ERR "hdlc_set_carrier_on(): already on\n");
 #endif
 	netif_carrier_on(dev);
+#endif
 }
 
 
@@ -94,11 +96,13 @@ static void __hdlc_set_carrier_off(struc
 	if (hdlc->proto.stop)
 		return hdlc->proto.stop(dev);
 
+#if 0
 #ifdef DEBUG_LINK
 	if (!netif_carrier_ok(dev))
 		printk(KERN_ERR "hdlc_set_carrier_off(): already off\n");
 #endif
 	netif_carrier_off(dev);
+#endif
 }
 
 
@@ -294,8 +298,10 @@ int register_hdlc_device(struct net_devi
 	if (result != 0)
 		return -EIO;
 
+#if 0
 	if (netif_carrier_ok(dev))
 		netif_carrier_off(dev); /* no carrier until DCD goes up */
+#endif
 
 	return 0;
 }
diff --git a/drivers/net/wireless/hermes.c b/drivers/net/wireless/hermes.c
index 579480d..346c6fe 100644
--- a/drivers/net/wireless/hermes.c
+++ b/drivers/net/wireless/hermes.c
@@ -398,7 +398,7 @@ static int hermes_bap_seek(hermes_t *hw,
  *
  * Returns: < 0 on internal failure (errno), 0 on success, > 0 on error from firmware
  */
-int hermes_bap_pread(hermes_t *hw, int bap, void *buf, unsigned len,
+int hermes_bap_pread(hermes_t *hw, int bap, void *buf, int len,
 		     u16 id, u16 offset)
 {
 	int dreg = bap ? HERMES_DATA1 : HERMES_DATA0;
@@ -424,7 +424,7 @@ int hermes_bap_pread(hermes_t *hw, int b
  *
  * Returns: < 0 on internal failure (errno), 0 on success, > 0 on error from firmware
  */
-int hermes_bap_pwrite(hermes_t *hw, int bap, const void *buf, unsigned len,
+int hermes_bap_pwrite(hermes_t *hw, int bap, const void *buf, int len,
 		      u16 id, u16 offset)
 {
 	int dreg = bap ? HERMES_DATA1 : HERMES_DATA0;
@@ -450,7 +450,7 @@ int hermes_bap_pwrite(hermes_t *hw, int 
  *
  * Returns: < 0 on internal failure (errno), 0 on success, > 0 on error from firmware
  */
-int hermes_bap_pwrite_pad(hermes_t *hw, int bap, const void *buf, unsigned data_len, unsigned len,
+int hermes_bap_pwrite_pad(hermes_t *hw, int bap, const void *buf, unsigned data_len, int len,
 		      u16 id, u16 offset)
 {
 	int dreg = bap ? HERMES_DATA1 : HERMES_DATA0;
diff --git a/drivers/net/wireless/hermes.h b/drivers/net/wireless/hermes.h
index a6bd472..7644f72 100644
--- a/drivers/net/wireless/hermes.h
+++ b/drivers/net/wireless/hermes.h
@@ -372,12 +372,12 @@ int hermes_docmd_wait(hermes_t *hw, u16 
 		      struct hermes_response *resp);
 int hermes_allocate(hermes_t *hw, u16 size, u16 *fid);
 
-int hermes_bap_pread(hermes_t *hw, int bap, void *buf, unsigned len,
+int hermes_bap_pread(hermes_t *hw, int bap, void *buf, int len,
 		       u16 id, u16 offset);
-int hermes_bap_pwrite(hermes_t *hw, int bap, const void *buf, unsigned len,
+int hermes_bap_pwrite(hermes_t *hw, int bap, const void *buf, int len,
 			u16 id, u16 offset);
 int hermes_bap_pwrite_pad(hermes_t *hw, int bap, const void *buf,
-			unsigned data_len, unsigned len, u16 id, u16 offset);
+			unsigned data_len, int len, u16 id, u16 offset);
 int hermes_read_ltv(hermes_t *hw, int bap, u16 rid, unsigned buflen,
 		    u16 *length, void *buf);
 int hermes_write_ltv(hermes_t *hw, int bap, u16 rid,
diff --git a/drivers/net/wireless/i82593.h b/drivers/net/wireless/i82593.h
index 33acb8a..afac5c7 100644
--- a/drivers/net/wireless/i82593.h
+++ b/drivers/net/wireless/i82593.h
@@ -7,11 +7,16 @@
  *
  * Copyright 1994, Anders Klemets <klemets@it.kth.se>
  *
- * This software may be freely distributed for noncommercial purposes
- * as long as this notice is retained.
- * 
  * HISTORY
  * i82593.h,v
+ * Revision 1.4  2005/11/4  09:15:00  baroniunas
+ * Modified copyright with permission of author as follows:
+ *
+ *   "If I82539.H is the only file with my copyright statement
+ *    that is included in the Source Forge project, then you have
+ *    my approval to change the copyright statement to be a GPL
+ *    license, in the way you proposed on October 10."
+ *
  * Revision 1.1  1996/07/17 15:23:12  root
  * Initial revision
  *
diff --git a/drivers/net/wireless/ipw2100.c b/drivers/net/wireless/ipw2100.c
index a2e6214..77d2a21 100644
--- a/drivers/net/wireless/ipw2100.c
+++ b/drivers/net/wireless/ipw2100.c
@@ -6344,7 +6344,8 @@ static struct net_device *ipw2100_alloc_
 	dev->ethtool_ops = &ipw2100_ethtool_ops;
 	dev->tx_timeout = ipw2100_tx_timeout;
 	dev->wireless_handlers = &ipw2100_wx_handler_def;
-	dev->get_wireless_stats = ipw2100_wx_wireless_stats;
+	priv->wireless_data.ieee80211 = priv->ieee;
+	dev->wireless_data = &priv->wireless_data;
 	dev->set_mac_address = ipw2100_set_address;
 	dev->watchdog_timeo = 3 * HZ;
 	dev->irq = 0;
@@ -7178,6 +7179,11 @@ static int ipw2100_wx_get_range(struct n
 	}
 	range->num_frequency = val;
 
+	/* Event capability (kernel + driver) */
+	range->event_capa[0] = (IW_EVENT_CAPA_K_0 |
+				IW_EVENT_CAPA_MASK(SIOCGIWAP));
+	range->event_capa[1] = IW_EVENT_CAPA_K_1;
+
 	IPW_DEBUG_WX("GET Range\n");
 
 	return 0;
@@ -8446,16 +8452,6 @@ static iw_handler ipw2100_private_handle
 #endif				/* CONFIG_IPW2100_MONITOR */
 };
 
-static struct iw_handler_def ipw2100_wx_handler_def = {
-	.standard = ipw2100_wx_handlers,
-	.num_standard = sizeof(ipw2100_wx_handlers) / sizeof(iw_handler),
-	.num_private = sizeof(ipw2100_private_handler) / sizeof(iw_handler),
-	.num_private_args = sizeof(ipw2100_private_args) /
-	    sizeof(struct iw_priv_args),
-	.private = (iw_handler *) ipw2100_private_handler,
-	.private_args = (struct iw_priv_args *)ipw2100_private_args,
-};
-
 /*
  * Get wireless statistics.
  * Called by /proc/net/wireless
@@ -8597,6 +8593,17 @@ static struct iw_statistics *ipw2100_wx_
 	return (struct iw_statistics *)NULL;
 }
 
+static struct iw_handler_def ipw2100_wx_handler_def = {
+	.standard = ipw2100_wx_handlers,
+	.num_standard = sizeof(ipw2100_wx_handlers) / sizeof(iw_handler),
+	.num_private = sizeof(ipw2100_private_handler) / sizeof(iw_handler),
+	.num_private_args = sizeof(ipw2100_private_args) /
+	    sizeof(struct iw_priv_args),
+	.private = (iw_handler *) ipw2100_private_handler,
+	.private_args = (struct iw_priv_args *)ipw2100_private_args,
+	.get_wireless_stats = ipw2100_wx_wireless_stats,
+};
+
 static void ipw2100_wx_event_work(struct ipw2100_priv *priv)
 {
 	union iwreq_data wrqu;
diff --git a/drivers/net/wireless/ipw2100.h b/drivers/net/wireless/ipw2100.h
index 140fdf2..7c65b10 100644
--- a/drivers/net/wireless/ipw2100.h
+++ b/drivers/net/wireless/ipw2100.h
@@ -571,6 +571,8 @@ struct ipw2100_priv {
 	struct net_device *net_dev;
 	struct iw_statistics wstats;
 
+	struct iw_public_data wireless_data;
+
 	struct tasklet_struct irq_tasklet;
 
 	struct workqueue_struct *workqueue;
diff --git a/drivers/net/wireless/prism54/isl_38xx.c b/drivers/net/wireless/prism54/isl_38xx.c
index 109a96d..23deee6 100644
--- a/drivers/net/wireless/prism54/isl_38xx.c
+++ b/drivers/net/wireless/prism54/isl_38xx.c
@@ -164,12 +164,12 @@ isl38xx_trigger_device(int asleep, void 
 		/* assert the Wakeup interrupt in the Device Interrupt Register */
 		isl38xx_w32_flush(device_base, ISL38XX_DEV_INT_WAKEUP,
 				  ISL38XX_DEV_INT_REG);
+
+#if VERBOSE > SHOW_ERROR_MESSAGES
 		udelay(ISL38XX_WRITEIO_DELAY);
 
 		/* perform another read on the Device Status Register */
 		reg = readl(device_base + ISL38XX_CTRL_STAT_REG);
-
-#if VERBOSE > SHOW_ERROR_MESSAGES
 		do_gettimeofday(&current_time);
 		DEBUG(SHOW_TRACING, "%08li.%08li Device register read %08x\n",
 		      current_time.tv_sec, (long)current_time.tv_usec, reg);
diff --git a/include/net/ieee80211.h b/include/net/ieee80211.h
index b93fd8c..cde2f4f 100644
--- a/include/net/ieee80211.h
+++ b/include/net/ieee80211.h
@@ -1042,7 +1042,7 @@ static inline u8 *ieee80211_get_payload(
 	case IEEE80211_4ADDR_LEN:
 		return ((struct ieee80211_hdr_4addr *)hdr)->payload;
 	}
-
+	return NULL;
 }
 
 static inline int ieee80211_is_ofdm_rate(u8 rate)
