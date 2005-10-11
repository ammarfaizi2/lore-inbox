Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbVJKF7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbVJKF7Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 01:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbVJKF7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 01:59:16 -0400
Received: from havoc.gtf.org ([69.61.125.42]:40663 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751378AbVJKF7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 01:59:15 -0400
Date: Tue, 11 Oct 2005 01:59:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patch] net driver fix
Message-ID: <20051011055912.GA9288@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from the 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to cure severe performance loss caused by a performance optimization
(new e100 microcode).  We just revert back to tried-and-true (and full
speed) behavior, and let the Intel people have another crack at it.

 drivers/net/e100.c |  224 ++++-------------------------------------------------
 1 files changed, 18 insertions(+), 206 deletions(-)


commit 875521ddccfa90d519cf31dfc8aa472f7f6325bb
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Tue Oct 11 01:38:35 2005 -0400

    e100: revert CPU cycle saver microcode, it causes severe problems
    for certain NICs
    
    Reverting 685fac63f5ca6c5ca06bab641e1a32bbf9287e89:
    > [PATCH] e100: CPU cycle saver microcode
    >
    >
    > Add cpu cycle saver microcode to 8086:{1209/1229} other than ICH devices.
    >
    > Signed-off-by: Mallikarjuna R Chilakala <mallikarjuna.chilakala@intel.com>
    > Signed-off-by: Ganesh Venkatesan <ganesh.venkatesan@intel.com>
    > Signed-off-by: John Ronciak <john.ronciak@intel.com>
    > Signed-off-by: Jeff Garzik <jgarzik@pobox.com>


diff --git a/drivers/net/e100.c b/drivers/net/e100.c
--- a/drivers/net/e100.c
+++ b/drivers/net/e100.c
@@ -903,8 +903,8 @@ static void mdio_write(struct net_device
 
 static void e100_get_defaults(struct nic *nic)
 {
-	struct param_range rfds = { .min = 16, .max = 256, .count = 256 };
-	struct param_range cbs  = { .min = 64, .max = 256, .count = 128 };
+	struct param_range rfds = { .min = 16, .max = 256, .count = 64 };
+	struct param_range cbs  = { .min = 64, .max = 256, .count = 64 };
 
 	pci_read_config_byte(nic->pdev, PCI_REVISION_ID, &nic->rev_id);
 	/* MAC type is encoded as rev ID; exception: ICH is treated as 82559 */
@@ -1007,213 +1007,25 @@ static void e100_configure(struct nic *n
 		c[16], c[17], c[18], c[19], c[20], c[21], c[22], c[23]);
 }
 
-/********************************************************/
-/*  Micro code for 8086:1229 Rev 8                      */
-/********************************************************/
-
-/*  Parameter values for the D101M B-step  */
-#define D101M_CPUSAVER_TIMER_DWORD		78
-#define D101M_CPUSAVER_BUNDLE_DWORD		65
-#define D101M_CPUSAVER_MIN_SIZE_DWORD		126
-
-#define D101M_B_RCVBUNDLE_UCODE \
-{\
-0x00550215, 0xFFFF0437, 0xFFFFFFFF, 0x06A70789, 0xFFFFFFFF, 0x0558FFFF, \
-0x000C0001, 0x00101312, 0x000C0008, 0x00380216, \
-0x0010009C, 0x00204056, 0x002380CC, 0x00380056, \
-0x0010009C, 0x00244C0B, 0x00000800, 0x00124818, \
-0x00380438, 0x00000000, 0x00140000, 0x00380555, \
-0x00308000, 0x00100662, 0x00100561, 0x000E0408, \
-0x00134861, 0x000C0002, 0x00103093, 0x00308000, \
-0x00100624, 0x00100561, 0x000E0408, 0x00100861, \
-0x000C007E, 0x00222C21, 0x000C0002, 0x00103093, \
-0x00380C7A, 0x00080000, 0x00103090, 0x00380C7A, \
-0x00000000, 0x00000000, 0x00000000, 0x00000000, \
-0x0010009C, 0x00244C2D, 0x00010004, 0x00041000, \
-0x003A0437, 0x00044010, 0x0038078A, 0x00000000, \
-0x00100099, 0x00206C7A, 0x0010009C, 0x00244C48, \
-0x00130824, 0x000C0001, 0x00101213, 0x00260C75, \
-0x00041000, 0x00010004, 0x00130826, 0x000C0006, \
-0x002206A8, 0x0013C926, 0x00101313, 0x003806A8, \
-0x00000000, 0x00000000, 0x00000000, 0x00000000, \
-0x00000000, 0x00000000, 0x00000000, 0x00000000, \
-0x00080600, 0x00101B10, 0x00050004, 0x00100826, \
-0x00101210, 0x00380C34, 0x00000000, 0x00000000, \
-0x0021155B, 0x00100099, 0x00206559, 0x0010009C, \
-0x00244559, 0x00130836, 0x000C0000, 0x00220C62, \
-0x000C0001, 0x00101B13, 0x00229C0E, 0x00210C0E, \
-0x00226C0E, 0x00216C0E, 0x0022FC0E, 0x00215C0E, \
-0x00214C0E, 0x00380555, 0x00010004, 0x00041000, \
-0x00278C67, 0x00040800, 0x00018100, 0x003A0437, \
-0x00130826, 0x000C0001, 0x00220559, 0x00101313, \
-0x00380559, 0x00000000, 0x00000000, 0x00000000, \
-0x00000000, 0x00000000, 0x00000000, 0x00000000, \
-0x00000000, 0x00130831, 0x0010090B, 0x00124813, \
-0x000CFF80, 0x002606AB, 0x00041000, 0x00010004, \
-0x003806A8, 0x00000000, 0x00000000, 0x00000000, \
-}
-
-/********************************************************/
-/*  Micro code for 8086:1229 Rev 9                      */
-/********************************************************/
-
-/*  Parameter values for the D101S  */
-#define D101S_CPUSAVER_TIMER_DWORD		78
-#define D101S_CPUSAVER_BUNDLE_DWORD		67
-#define D101S_CPUSAVER_MIN_SIZE_DWORD		128
-
-#define D101S_RCVBUNDLE_UCODE \
-{\
-0x00550242, 0xFFFF047E, 0xFFFFFFFF, 0x06FF0818, 0xFFFFFFFF, 0x05A6FFFF, \
-0x000C0001, 0x00101312, 0x000C0008, 0x00380243, \
-0x0010009C, 0x00204056, 0x002380D0, 0x00380056, \
-0x0010009C, 0x00244F8B, 0x00000800, 0x00124818, \
-0x0038047F, 0x00000000, 0x00140000, 0x003805A3, \
-0x00308000, 0x00100610, 0x00100561, 0x000E0408, \
-0x00134861, 0x000C0002, 0x00103093, 0x00308000, \
-0x00100624, 0x00100561, 0x000E0408, 0x00100861, \
-0x000C007E, 0x00222FA1, 0x000C0002, 0x00103093, \
-0x00380F90, 0x00080000, 0x00103090, 0x00380F90, \
-0x00000000, 0x00000000, 0x00000000, 0x00000000, \
-0x0010009C, 0x00244FAD, 0x00010004, 0x00041000, \
-0x003A047E, 0x00044010, 0x00380819, 0x00000000, \
-0x00100099, 0x00206FFD, 0x0010009A, 0x0020AFFD, \
-0x0010009C, 0x00244FC8, 0x00130824, 0x000C0001, \
-0x00101213, 0x00260FF7, 0x00041000, 0x00010004, \
-0x00130826, 0x000C0006, 0x00220700, 0x0013C926, \
-0x00101313, 0x00380700, 0x00000000, 0x00000000, \
-0x00000000, 0x00000000, 0x00000000, 0x00000000, \
-0x00080600, 0x00101B10, 0x00050004, 0x00100826, \
-0x00101210, 0x00380FB6, 0x00000000, 0x00000000, \
-0x002115A9, 0x00100099, 0x002065A7, 0x0010009A, \
-0x0020A5A7, 0x0010009C, 0x002445A7, 0x00130836, \
-0x000C0000, 0x00220FE4, 0x000C0001, 0x00101B13, \
-0x00229F8E, 0x00210F8E, 0x00226F8E, 0x00216F8E, \
-0x0022FF8E, 0x00215F8E, 0x00214F8E, 0x003805A3, \
-0x00010004, 0x00041000, 0x00278FE9, 0x00040800, \
-0x00018100, 0x003A047E, 0x00130826, 0x000C0001, \
-0x002205A7, 0x00101313, 0x003805A7, 0x00000000, \
-0x00000000, 0x00000000, 0x00000000, 0x00000000, \
-0x00000000, 0x00000000, 0x00000000, 0x00130831, \
-0x0010090B, 0x00124813, 0x000CFF80, 0x00260703, \
-0x00041000, 0x00010004, 0x00380700  \
-}
-
-/********************************************************/
-/*  Micro code for the 8086:1229 Rev F/10               */
-/********************************************************/
-
-/*  Parameter values for the D102 E-step  */
-#define D102_E_CPUSAVER_TIMER_DWORD		42
-#define D102_E_CPUSAVER_BUNDLE_DWORD		54
-#define D102_E_CPUSAVER_MIN_SIZE_DWORD		46
-
-#define     D102_E_RCVBUNDLE_UCODE \
-{\
-0x007D028F, 0x0E4204F9, 0x14ED0C85, 0x14FA14E9, 0x0EF70E36, 0x1FFF1FFF, \
-0x00E014B9, 0x00000000, 0x00000000, 0x00000000, \
-0x00E014BD, 0x00000000, 0x00000000, 0x00000000, \
-0x00E014D5, 0x00000000, 0x00000000, 0x00000000, \
-0x00000000, 0x00000000, 0x00000000, 0x00000000, \
-0x00E014C1, 0x00000000, 0x00000000, 0x00000000, \
-0x00000000, 0x00000000, 0x00000000, 0x00000000, \
-0x00000000, 0x00000000, 0x00000000, 0x00000000, \
-0x00000000, 0x00000000, 0x00000000, 0x00000000, \
-0x00E014C8, 0x00000000, 0x00000000, 0x00000000, \
-0x00200600, 0x00E014EE, 0x00000000, 0x00000000, \
-0x0030FF80, 0x00940E46, 0x00038200, 0x00102000, \
-0x00E00E43, 0x00000000, 0x00000000, 0x00000000, \
-0x00300006, 0x00E014FB, 0x00000000, 0x00000000, \
-0x00000000, 0x00000000, 0x00000000, 0x00000000, \
-0x00000000, 0x00000000, 0x00000000, 0x00000000, \
-0x00000000, 0x00000000, 0x00000000, 0x00000000, \
-0x00906E41, 0x00800E3C, 0x00E00E39, 0x00000000, \
-0x00906EFD, 0x00900EFD, 0x00E00EF8, 0x00000000, \
-0x00000000, 0x00000000, 0x00000000, 0x00000000, \
-0x00000000, 0x00000000, 0x00000000, 0x00000000, \
-0x00000000, 0x00000000, 0x00000000, 0x00000000, \
-0x00000000, 0x00000000, 0x00000000, 0x00000000, \
-0x00000000, 0x00000000, 0x00000000, 0x00000000, \
-0x00000000, 0x00000000, 0x00000000, 0x00000000, \
-0x00000000, 0x00000000, 0x00000000, 0x00000000, \
-0x00000000, 0x00000000, 0x00000000, 0x00000000, \
-0x00000000, 0x00000000, 0x00000000, 0x00000000, \
-0x00000000, 0x00000000, 0x00000000, 0x00000000, \
-0x00000000, 0x00000000, 0x00000000, 0x00000000, \
-0x00000000, 0x00000000, 0x00000000, 0x00000000, \
-0x00000000, 0x00000000, 0x00000000, 0x00000000, \
-0x00000000, 0x00000000, 0x00000000, 0x00000000, \
-}
-
 static void e100_load_ucode(struct nic *nic, struct cb *cb, struct sk_buff *skb)
 {
-/* *INDENT-OFF* */
-	static struct {
-		u32 ucode[UCODE_SIZE + 1];
-		u8 mac;
-		u8 timer_dword;
-		u8 bundle_dword;
-		u8 min_size_dword;
-	} ucode_opts[] = {
-		{ D101M_B_RCVBUNDLE_UCODE,
-		  mac_82559_D101M,
-		  D101M_CPUSAVER_TIMER_DWORD,
-		  D101M_CPUSAVER_BUNDLE_DWORD,
-		  D101M_CPUSAVER_MIN_SIZE_DWORD },
-		{ D101S_RCVBUNDLE_UCODE,
-		  mac_82559_D101S,
-		  D101S_CPUSAVER_TIMER_DWORD,
-		  D101S_CPUSAVER_BUNDLE_DWORD,
-		  D101S_CPUSAVER_MIN_SIZE_DWORD },
-		{ D102_E_RCVBUNDLE_UCODE,
-		  mac_82551_F,
-		  D102_E_CPUSAVER_TIMER_DWORD,
-		  D102_E_CPUSAVER_BUNDLE_DWORD,
-		  D102_E_CPUSAVER_MIN_SIZE_DWORD },
-		{ D102_E_RCVBUNDLE_UCODE,
-		  mac_82551_10,
-		  D102_E_CPUSAVER_TIMER_DWORD,
-		  D102_E_CPUSAVER_BUNDLE_DWORD,
-		  D102_E_CPUSAVER_MIN_SIZE_DWORD },
-		{ {0}, 0, 0, 0, 0}
-	}, *opts;
-/* *INDENT-ON* */
-
-#define BUNDLESMALL 1
-#define BUNDLEMAX 50
-#define INTDELAY 15000
-
-	opts = ucode_opts;
-
-	/* do not load u-code for ICH devices */
-	if (nic->flags & ich)
-		return;
-
-	/* Search for ucode match against h/w rev_id */
-	while (opts->mac) {
-		if (nic->mac == opts->mac) {
-			int i;
-			u32 *ucode = opts->ucode;
-
-			/* Insert user-tunable settings */
-			ucode[opts->timer_dword] &= 0xFFFF0000;
-			ucode[opts->timer_dword] |=
-				(u16) INTDELAY;
-			ucode[opts->bundle_dword] &= 0xFFFF0000;
-			ucode[opts->bundle_dword] |= (u16) BUNDLEMAX;
-			ucode[opts->min_size_dword] &= 0xFFFF0000;
-			ucode[opts->min_size_dword] |=
-				(BUNDLESMALL) ?  0xFFFF : 0xFF80;
-
-			for(i = 0; i < UCODE_SIZE; i++)
-				cb->u.ucode[i] = cpu_to_le32(ucode[i]);
-			cb->command = cpu_to_le16(cb_ucode);
-			return;
-		}
-		opts++;
-	}
+	int i;
+	static const u32 ucode[UCODE_SIZE] = {
+		/* NFS packets are misinterpreted as TCO packets and
+		 * incorrectly routed to the BMC over SMBus.  This
+		 * microcode patch checks the fragmented IP bit in the
+		 * NFS/UDP header to distinguish between NFS and TCO. */
+		0x0EF70E36, 0x1FFF1FFF, 0x1FFF1FFF, 0x1FFF1FFF, 0x1FFF1FFF,
+		0x1FFF1FFF, 0x00906E41, 0x00800E3C, 0x00E00E39, 0x00000000,
+		0x00906EFD, 0x00900EFD,	0x00E00EF8,
+	};
 
-	cb->command = cpu_to_le16(cb_nop);
+	if(nic->mac == mac_82551_F || nic->mac == mac_82551_10) {
+		for(i = 0; i < UCODE_SIZE; i++)
+			cb->u.ucode[i] = cpu_to_le32(ucode[i]);
+		cb->command = cpu_to_le16(cb_ucode);
+	} else
+		cb->command = cpu_to_le16(cb_nop);
 }
 
 static void e100_setup_iaaddr(struct nic *nic, struct cb *cb,
