Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268306AbUH2Umu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268306AbUH2Umu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 16:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268305AbUH2UmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 16:42:25 -0400
Received: from ipx10602.ipxserver.de ([80.190.249.152]:39431 "EHLO taytron.net")
	by vger.kernel.org with ESMTP id S268304AbUH2UkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 16:40:21 -0400
From: Florian Schirmer <jolt@tuxbox.org>
To: Pekka Pietikainen <pp@ee.oulu.fi>
Subject: [PATCH][2/4] b44: Cleanup SiliconBackplane definitions/functions
Date: Sun, 29 Aug 2004 22:34:01 +0200
User-Agent: KMail/1.7
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <200408292218.00756.jolt@tuxbox.org>
In-Reply-To: <200408292218.00756.jolt@tuxbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart12595084.zQyxp4o0NF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200408292234.04238.jolt@tuxbox.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart12595084.zQyxp4o0NF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

there is a good amount of code to support SiliconBackplane functions which =
are unneeded or simply plain wrong. Lets get rid of it.

Regards,
  Florian

Signed-off-by: Florian Schirmer <jolt@tuxbox.org>

=2D-- linux/drivers/net/b44.c-old2 2004-08-29 16:27:00.000000000 +0200
+++ linux/drivers/net/b44.c 2004-08-29 16:59:24.000000000 +0200
@@ -130,41 +130,8 @@ static int b44_wait_bit(struct b44 *bp,=20
  * interrupts disabled.
  */
=20
=2D#define SBID_SDRAM  0
=2D#define SBID_PCI_MEM  1
=2D#define SBID_PCI_CFG  2
=2D#define SBID_PCI_DMA  3
=2D#define SBID_SDRAM_SWAPPED 4
=2D#define SBID_ENUM  5
=2D#define SBID_REG_SDRAM  6
=2D#define SBID_REG_ILINE20 7
=2D#define SBID_REG_EMAC  8
=2D#define SBID_REG_CODEC  9
=2D#define SBID_REG_USB  10
=2D#define SBID_REG_PCI  11
=2D#define SBID_REG_MIPS  12
=2D#define SBID_REG_EXTIF  13
=2D#define SBID_EXTIF  14
=2D#define SBID_EJTAG  15
=2D#define SBID_MAX  16
=2D
=2Dstatic u32 ssb_get_addr(struct b44 *bp, u32 id, u32 instance)
=2D{
=2D switch (id) {
=2D case SBID_PCI_DMA:
=2D  return 0x40000000;
=2D case SBID_ENUM:
=2D  return 0x18000000;
=2D case SBID_REG_EMAC:
=2D  return 0x18000000;
=2D case SBID_REG_CODEC:
=2D  return 0x18001000;
=2D case SBID_REG_PCI:
=2D  return 0x18002000;
=2D default:
=2D  return 0;
=2D };
=2D}
+#define SB_PCI_DMA             0x40000000      /* Client Mode PCI memory a=
ccess space (1 GB) */
+#define BCM4400_PCI_CORE_ADDR  0x18002000      /* Address of PCI core on B=
CM4400 cards */
=20
 static u32 ssb_get_core_rev(struct b44 *bp)
 {
@@ -176,8 +143,7 @@ static u32 ssb_pci_setup(struct b44 *bp,
  u32 bar_orig, pci_rev, val;
=20
  pci_read_config_dword(bp->pdev, SSB_BAR0_WIN, &bar_orig);
=2D pci_write_config_dword(bp->pdev, SSB_BAR0_WIN,
=2D          ssb_get_addr(bp, SBID_REG_PCI, 0));
+ pci_write_config_dword(bp->pdev, SSB_BAR0_WIN, BCM4400_PCI_CORE_ADDR);
  pci_rev =3D ssb_get_core_rev(bp);
=20
  val =3D br32(B44_SBINTVEC);
@@ -1676,7 +1642,6 @@ static int __devinit b44_get_invariants(
  bp->dev->dev_addr[5] =3D eeprom[82];
=20
  bp->phy_addr =3D eeprom[90] & 0x1f;
=2D bp->mdc_port =3D (eeprom[90] >> 14) & 0x1;
=20
  /* With this, plus the rx_header prepended to the data by the
   * hardware, we'll land the ethernet header on a 2-byte boundary.
@@ -1686,7 +1651,7 @@ static int __devinit b44_get_invariants(
  bp->imask =3D IMASK_DEF;
=20
  bp->core_unit =3D ssb_core_unit(bp);
=2D bp->dma_offset =3D ssb_get_addr(bp, SBID_PCI_DMA, 0);
+ bp->dma_offset =3D SB_PCI_DMA;
=20
  /* XXX - really required?=20
     bp->flags |=3D B44_FLAG_BUGGY_TXPTR;
=2D-- linux/drivers/net/b44.h-old2 2004-08-29 16:25:36.000000000 +0200
+++ linux/drivers/net/b44.h 2004-08-29 17:06:44.000000000 +0200
@@ -223,21 +223,8 @@
 #define B44_RX_SYM 0x05D0UL /* MIB RX Symbol Errors */
 #define B44_RX_PAUSE 0x05D4UL /* MIB RX Pause Packets */
 #define B44_RX_NPAUSE 0x05D8UL /* MIB RX Non-Pause Packets */
=2D#define B44_SBIPSFLAG 0x0F08UL /* SB Initiator Port OCP Slave Flag */
=2D#define  SBIPSFLAG_IMASK1 0x0000003f /* Which sbflags --> mips interrupt=
 1 */
=2D#define  SBIPSFLAG_ISHIFT1 0
=2D#define  SBIPSFLAG_IMASK2 0x00003f00 /* Which sbflags --> mips interrupt=
 2 */
=2D#define  SBIPSFLAG_ISHIFT2 8
=2D#define  SBIPSFLAG_IMASK3 0x003f0000 /* Which sbflags --> mips interrupt=
 3 */
=2D#define  SBIPSFLAG_ISHIFT3 16
=2D#define  SBIPSFLAG_IMASK4 0x3f000000 /* Which sbflags --> mips interrupt=
 4 */
=2D#define  SBIPSFLAG_ISHIFT4 24
=2D#define B44_SBTPSFLAG 0x0F18UL /* SB Target Port OCP Slave Flag */
=2D#define  SBTPS_NUM0_MASK 0x0000003f
=2D#define  SBTPS_F0EN0  0x00000040
=2D#define B44_SBADMATCH3 0x0F60UL /* SB Address Match 3 */
=2D#define B44_SBADMATCH2 0x0F68UL /* SB Address Match 2 */
=2D#define B44_SBADMATCH1 0x0F70UL /* SB Address Match 1 */
+
+/* Silicon backplane register definitions */
 #define B44_SBIMSTATE 0x0F90UL /* SB Initiator Agent State */
 #define  SBIMSTATE_PC  0x0000000f /* Pipe Count */
 #define  SBIMSTATE_AP_MASK 0x00000030 /* Arbitration Priority */
@@ -269,86 +256,6 @@
 #define  SBTMSHIGH_GCR  0x20000000 /* Gated Clock Request */
 #define  SBTMSHIGH_BISTF 0x40000000 /* BIST Failed */
 #define  SBTMSHIGH_BISTD 0x80000000 /* BIST Done */
=2D#define B44_SBBWA0 0x0FA0UL /* SB Bandwidth Allocation Table 0 */
=2D#define  SBBWA0_TAB0_MASK 0x0000ffff /* Lookup Table 0 */
=2D#define  SBBWA0_TAB0_SHIFT 0
=2D#define  SBBWA0_TAB1_MASK 0xffff0000 /* Lookup Table 0 */
=2D#define  SBBWA0_TAB1_SHIFT 16
=2D#define B44_SBIMCFGLOW 0x0FA8UL /* SB Initiator Configuration Low */
=2D#define  SBIMCFGLOW_STO_MASK 0x00000003 /* Service Timeout */
=2D#define  SBIMCFGLOW_RTO_MASK 0x00000030 /* Request Timeout */
=2D#define  SBIMCFGLOW_RTO_SHIFT 4
=2D#define  SBIMCFGLOW_CID_MASK 0x00ff0000 /* Connection ID */
=2D#define  SBIMCFGLOW_CID_SHIFT 16
=2D#define B44_SBIMCFGHIGH 0x0FACUL /* SB Initiator Configuration High */
=2D#define  SBIMCFGHIGH_IEM_MASK 0x0000000c /* Inband Error Mode */
=2D#define  SBIMCFGHIGH_TEM_MASK 0x00000030 /* Timeout Error Mode */
=2D#define  SBIMCFGHIGH_TEM_SHIFT 4
=2D#define  SBIMCFGHIGH_BEM_MASK 0x000000c0 /* Bus Error Mode */
=2D#define  SBIMCFGHIGH_BEM_SHIFT 6
=2D#define B44_SBADMATCH0 0x0FB0UL /* SB Address Match 0 */
=2D#define  SBADMATCH0_TYPE_MASK 0x00000003 /* Address Type */
=2D#define  SBADMATCH0_AD64 0x00000004 /* Reserved */
=2D#define  SBADMATCH0_AI0_MASK 0x000000f8 /* Type0 Size */
=2D#define  SBADMATCH0_AI0_SHIFT 3
=2D#define  SBADMATCH0_AI1_MASK 0x000001f8 /* Type1 Size */
=2D#define  SBADMATCH0_AI1_SHIFT 3
=2D#define  SBADMATCH0_AI2_MASK 0x000001f8 /* Type2 Size */
=2D#define  SBADMATCH0_AI2_SHIFT 3
=2D#define  SBADMATCH0_ADEN 0x00000400 /* Enable */
=2D#define  SBADMATCH0_ADNEG 0x00000800 /* Negative Decode */
=2D#define  SBADMATCH0_BS0_MASK 0xffffff00 /* Type0 Base Address */
=2D#define  SBADMATCH0_BS0_SHIFT 8
=2D#define  SBADMATCH0_BS1_MASK 0xfffff000 /* Type1 Base Address */
=2D#define  SBADMATCH0_BS1_SHIFT 12
=2D#define  SBADMATCH0_BS2_MASK 0xffff0000 /* Type2 Base Address */
=2D#define  SBADMATCH0_BS2_SHIFT 16
=2D#define B44_SBTMCFGLOW 0x0FB8UL /* SB Target Configuration Low */
=2D#define  SBTMCFGLOW_CD_MASK 0x000000ff /* Clock Divide Mask */
=2D#define  SBTMCFGLOW_CO_MASK 0x0000f800 /* Clock Offset Mask */
=2D#define  SBTMCFGLOW_CO_SHIFT 11
=2D#define  SBTMCFGLOW_IF_MASK 0x00fc0000 /* Interrupt Flags Mask */
=2D#define  SBTMCFGLOW_IF_SHIFT 18
=2D#define  SBTMCFGLOW_IM_MASK 0x03000000 /* Interrupt Mode Mask */
=2D#define  SBTMCFGLOW_IM_SHIFT 24
=2D#define B44_SBTMCFGHIGH 0x0FBCUL /* SB Target Configuration High */
=2D#define  SBTMCFGHIGH_BM_MASK 0x00000003 /* Busy Mode */
=2D#define  SBTMCFGHIGH_RM_MASK 0x0000000C /* Retry Mode */
=2D#define  SBTMCFGHIGH_RM_SHIFT 2
=2D#define  SBTMCFGHIGH_SM_MASK 0x00000030 /* Stop Mode */
=2D#define  SBTMCFGHIGH_SM_SHIFT 4
=2D#define  SBTMCFGHIGH_EM_MASK 0x00000300 /* Error Mode */
=2D#define  SBTMCFGHIGH_EM_SHIFT 8
=2D#define  SBTMCFGHIGH_IM_MASK 0x00000c00 /* Interrupt Mode */
=2D#define  SBTMCFGHIGH_IM_SHIFT 10
=2D#define B44_SBBCFG 0x0FC0UL /* SB Broadcast Configuration */
=2D#define  SBBCFG_LAT_MASK 0x00000003 /* SB Latency */
=2D#define  SBBCFG_MAX0_MASK 0x000f0000 /* MAX Counter 0 */
=2D#define  SBBCFG_MAX0_SHIFT 16
=2D#define  SBBCFG_MAX1_MASK 0x00f00000 /* MAX Counter 1 */
=2D#define  SBBCFG_MAX1_SHIFT 20
=2D#define B44_SBBSTATE 0x0FC8UL /* SB Broadcast State */
=2D#define  SBBSTATE_SRD  0x00000001 /* ST Reg Disable */
=2D#define  SBBSTATE_HRD  0x00000002 /* Hold Reg Disable */
=2D#define B44_SBACTCNFG 0x0FD8UL /* SB Activate Configuration */
=2D#define B44_SBFLAGST 0x0FE8UL /* SB Current SBFLAGS */
=2D#define B44_SBIDLOW 0x0FF8UL /* SB Identification Low */
=2D#define  SBIDLOW_CS_MASK 0x00000003 /* Config Space Mask */
=2D#define  SBIDLOW_AR_MASK 0x00000038 /* Num Address Ranges Supported */
=2D#define  SBIDLOW_AR_SHIFT 3
=2D#define  SBIDLOW_SYNCH  0x00000040 /* Sync */
=2D#define  SBIDLOW_INIT  0x00000080 /* Initiator */
=2D#define  SBIDLOW_MINLAT_MASK 0x00000f00 /* Minimum Backplane Latency */
=2D#define  SBIDLOW_MINLAT_SHIFT 8
=2D#define  SBIDLOW_MAXLAT_MASK 0x0000f000 /* Maximum Backplane Latency */
=2D#define  SBIDLOW_MAXLAT_SHIFT 12
=2D#define  SBIDLOW_FIRST  0x00010000 /* This Initiator is First */
=2D#define  SBIDLOW_CW_MASK 0x000c0000 /* Cycle Counter Width */
=2D#define  SBIDLOW_CW_SHIFT 18
=2D#define  SBIDLOW_TP_MASK 0x00f00000 /* Target Ports */
=2D#define  SBIDLOW_TP_SHIFT 20
=2D#define  SBIDLOW_IP_MASK 0x0f000000 /* Initiator Ports */
=2D#define  SBIDLOW_IP_SHIFT 24
 #define B44_SBIDHIGH 0x0FFCUL /* SB Identification High */
 #define  SBIDHIGH_RC_MASK 0x0000000f /* Revision Code */
 #define  SBIDHIGH_CC_MASK 0x0000fff0 /* Core Code */
@@ -356,23 +263,13 @@
 #define  SBIDHIGH_VC_MASK 0xffff0000 /* Vendor Code */
 #define  SBIDHIGH_VC_SHIFT 16
=20
=2D#define  CORE_CODE_ILINE20 0x801
=2D#define  CORE_CODE_SDRAM 0x803
=2D#define  CORE_CODE_PCI  0x804
=2D#define  CORE_CODE_MIPS  0x805
=2D#define  CORE_CODE_ENET  0x806
=2D#define  CORE_CODE_CODEC 0x807
=2D#define  CORE_CODE_USB  0x808
=2D#define  CORE_CODE_ILINE100 0x80a
=2D#define  CORE_CODE_EXTIF 0x811
=2D
 /* SSB PCI config space registers.  */
 #define SSB_BAR0_WIN  0x80
 #define SSB_BAR1_WIN  0x84
 #define SSB_SPROM_CONTROL 0x88
 #define SSB_BAR1_CONTROL 0x8c
=20
=2D/* SSB core and hsot control registers.  */
+/* SSB core and host control registers.  */
 #define SSB_CONTROL  0x0000UL
 #define SSB_ARBCONTROL  0x0010UL
 #define SSB_ISTAT  0x0020UL
@@ -540,7 +437,6 @@ struct b44 {
  u32   tx_pending;
  u32   pci_cfg_state[64 / sizeof(u32)];
  u8   phy_addr;
=2D u8   mdc_port;
  u8   core_unit;
=20
  struct mii_if_info mii_if;


--nextPart12595084.zQyxp4o0NF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBMj28XRF2vHoIlBsRAmxjAJoDpX9f67tHSQnhAXoyGdjtmFUt9gCfeQiL
rR2HZQX6xf/xjzUH5QQWwz8=
=1yNi
-----END PGP SIGNATURE-----

--nextPart12595084.zQyxp4o0NF--
