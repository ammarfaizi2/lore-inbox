Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbULBA2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbULBA2F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 19:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbULBA2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 19:28:04 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39694 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261512AbULBAZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 19:25:20 -0500
Date: Thu, 2 Dec 2004 01:25:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: chas@cmf.nrl.navy.mil, linux-atm-general@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       linux-net@vger.kernel.org
Subject: [2.6 patch] small drivers/atm cleanups
Message-ID: <20041202002518.GE5148@stusta.de>
References: <20041124020411.GL2927@stusta.de> <20041123180931.36f1a733.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123180931.36f1a733.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 06:09:31PM -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> >   /*
> >  - * This routine will clock the Read_Status_reg function into the X2520
> >  - * eeprom, then pull the result from bit 16 of the NicSTaR's General Purpose 
> >  - * register.  
> >  - */
> >  -
> >  -u_int32_t
> >  -nicstar_read_eprom_status( virt_addr_t base )
> 
> I'd be inclined to whack an #if 0 around functions such as this rather than
> removing them.  Someone may come along one day and do some work on the
> driver, and nicstar_read_eprom_status() may prove to be useful to them.
> 
> Nobody would ever thing to go trolling back through the revision history
> looking to see if previously-interesting stuff was deleted.


Agreed. Updated patch:


The patch below makes the following changes under drivers/atm/ :
- make some needlessly global things static
- #if 0 an unneeded global function in nicstarmac.c

Please review and apply if it's correct.


diffstat output:
 drivers/atm/ambassador.c |    4 +--
 drivers/atm/atmtcp.c     |    6 ++---
 drivers/atm/firestream.c |   12 +++++-----
 drivers/atm/he.c         |   44 ++++++++++++++++++++++++++++++++++++++-
 drivers/atm/he.h         |   43 --------------------------------------
 drivers/atm/idt77105.c   |    2 -
 drivers/atm/idt77105.h   |    1 
 drivers/atm/idt77252.h   |    2 -
 drivers/atm/iphase.c     |   17 ++++++---------
 drivers/atm/iphase.h     |    4 ---
 drivers/atm/nicstarmac.h |    1 
 drivers/atm/nicstarmac.c |    5 +++-
 12 files changed, 67 insertions(+), 74 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/atm/ambassador.c.old	2004-11-05 23:19:10.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/atm/ambassador.c	2004-11-05 23:19:44.000000000 +0100
@@ -1692,7 +1692,7 @@
 };
 
 
-unsigned int command_successes [] = {
+static unsigned int command_successes [] = {
 	[host_memory_test]     = COMMAND_PASSED_TEST,
 	[read_adapter_memory]  = COMMAND_READ_DATA_OK,
 	[write_adapter_memory] = COMMAND_WRITE_DATA_OK,
@@ -2088,7 +2088,7 @@
 }
   
 // swap bits within byte to get Ethernet ordering
-u8 bit_swap (u8 byte)
+static u8 bit_swap (u8 byte)
 {
     const u8 swap[] = {
       0x0, 0x8, 0x4, 0xc,
--- linux-2.6.10-rc1-mm3-full/drivers/atm/atmtcp.c.old	2004-11-05 23:19:51.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/atm/atmtcp.c	2004-11-05 23:20:24.000000000 +0100
@@ -388,7 +388,7 @@
 }
 
 
-int atmtcp_attach(struct atm_vcc *vcc,int itf)
+static int atmtcp_attach(struct atm_vcc *vcc,int itf)
 {
 	struct atm_dev *dev;
 
@@ -419,13 +419,13 @@
 }
 
 
-int atmtcp_create_persistent(int itf)
+static int atmtcp_create_persistent(int itf)
 {
 	return atmtcp_create(itf,1,NULL);
 }
 
 
-int atmtcp_remove_persistent(int itf)
+static int atmtcp_remove_persistent(int itf)
 {
 	struct atm_dev *dev;
 	struct atmtcp_dev_data *dev_data;
--- linux-2.6.10-rc1-mm3-full/drivers/atm/firestream.c.old	2004-11-05 23:20:36.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/atm/firestream.c	2004-11-05 23:21:35.000000000 +0100
@@ -82,14 +82,14 @@
  * would be interpreted. -- REW */
 
 #define NP FS_NR_FREE_POOLS
-int rx_buf_sizes[NP]  = {128,  256,  512, 1024, 2048, 4096, 16384, 65520};
+static int rx_buf_sizes[NP]  = {128,  256,  512, 1024, 2048, 4096, 16384, 65520};
 /* log2:                 7     8     9    10    11    12    14     16 */
 
 #if 0
-int rx_pool_sizes[NP] = {1024, 1024, 512, 256,  128,  64,   32,    32};
+static int rx_pool_sizes[NP] = {1024, 1024, 512, 256,  128,  64,   32,    32};
 #else
 /* debug */
-int rx_pool_sizes[NP] = {128,  128,  128, 64,   64,   64,   32,    32};
+static int rx_pool_sizes[NP] = {128,  128,  128, 64,   64,   64,   32,    32};
 #endif
 /* log2:                 10    10    9    8     7     6     5      5  */
 /* sumlog2:              17    18    18   18    18    18    19     21 */
@@ -250,7 +250,7 @@
 };
 
 
-struct reginit_item PHY_NTC_INIT[] __devinitdata = {
+static struct reginit_item PHY_NTC_INIT[] __devinitdata = {
 	{ PHY_CLEARALL, 0x40 }, 
 	{ 0x12,  0x0001 },
 	{ 0x13,  0x7605 },
@@ -334,7 +334,7 @@
 #define func_exit()  fs_dprintk (FS_DEBUG_FLOW, "fs: exit  %s\n", __FUNCTION__)
 
 
-struct fs_dev *fs_boards = NULL;
+static struct fs_dev *fs_boards = NULL;
 
 #ifdef DEBUG
 
@@ -1921,7 +1921,7 @@
 	return -ENODEV;
 }
 
-void __devexit firestream_remove_one (struct pci_dev *pdev)
+static void __devexit firestream_remove_one (struct pci_dev *pdev)
 {
 	int i;
 	struct fs_dev *dev, *nxtdev;
--- linux-2.6.10-rc1-mm3-full/drivers/atm/he.h.old	2004-11-05 23:22:52.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/atm/he.h	2004-11-05 23:24:59.000000000 +0100
@@ -892,47 +892,4 @@
 #define SI_HIGH		ID_DIN /* HOST_CNTL_ID_PROM_DATA_IN */
 #define EEPROM_DELAY	400 /* microseconds */
 
-/* Read from EEPROM = 0000 0011b */
-unsigned int readtab[] = {
-	CS_HIGH | CLK_HIGH,
-	CS_LOW | CLK_LOW,
-	CLK_HIGH,               /* 0 */
-	CLK_LOW,
-	CLK_HIGH,               /* 0 */
-	CLK_LOW,
-	CLK_HIGH,               /* 0 */
-	CLK_LOW,
-	CLK_HIGH,               /* 0 */
-	CLK_LOW,
-	CLK_HIGH,               /* 0 */
-	CLK_LOW,
-	CLK_HIGH,               /* 0 */
-	CLK_LOW | SI_HIGH,
-	CLK_HIGH | SI_HIGH,     /* 1 */
-	CLK_LOW | SI_HIGH,
-	CLK_HIGH | SI_HIGH      /* 1 */
-};     
- 
-/* Clock to read from/write to the EEPROM */
-unsigned int clocktab[] = {
-	CLK_LOW,
-	CLK_HIGH,
-	CLK_LOW,
-	CLK_HIGH,
-	CLK_LOW,
-	CLK_HIGH,
-	CLK_LOW,
-	CLK_HIGH,
-	CLK_LOW,
-	CLK_HIGH,
-	CLK_LOW,
-	CLK_HIGH,
-	CLK_LOW,
-	CLK_HIGH,
-	CLK_LOW,
-	CLK_HIGH,
-	CLK_LOW
-};     
-
-
 #endif /* _HE_H_ */
--- linux-2.6.10-rc1-mm3-full/drivers/atm/he.c.old	2004-11-05 23:21:42.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/atm/he.c	2004-11-05 23:24:51.000000000 +0100
@@ -147,7 +147,7 @@
 
 /* globals */
 
-struct he_dev *he_devs = NULL;
+static struct he_dev *he_devs = NULL;
 static int disable64 = 0;
 static short nvpibits = -1;
 static short nvcibits = -1;
@@ -155,6 +155,48 @@
 static int irq_coalesce = 1;
 static int sdh = 0;
 
+/* Read from EEPROM = 0000 0011b */
+static unsigned int readtab[] = {
+	CS_HIGH | CLK_HIGH,
+	CS_LOW | CLK_LOW,
+	CLK_HIGH,               /* 0 */
+	CLK_LOW,
+	CLK_HIGH,               /* 0 */
+	CLK_LOW,
+	CLK_HIGH,               /* 0 */
+	CLK_LOW,
+	CLK_HIGH,               /* 0 */
+	CLK_LOW,
+	CLK_HIGH,               /* 0 */
+	CLK_LOW,
+	CLK_HIGH,               /* 0 */
+	CLK_LOW | SI_HIGH,
+	CLK_HIGH | SI_HIGH,     /* 1 */
+	CLK_LOW | SI_HIGH,
+	CLK_HIGH | SI_HIGH      /* 1 */
+};     
+ 
+/* Clock to read from/write to the EEPROM */
+static unsigned int clocktab[] = {
+	CLK_LOW,
+	CLK_HIGH,
+	CLK_LOW,
+	CLK_HIGH,
+	CLK_LOW,
+	CLK_HIGH,
+	CLK_LOW,
+	CLK_HIGH,
+	CLK_LOW,
+	CLK_HIGH,
+	CLK_LOW,
+	CLK_HIGH,
+	CLK_LOW,
+	CLK_HIGH,
+	CLK_LOW,
+	CLK_HIGH,
+	CLK_LOW
+};     
+
 static struct atmdev_ops he_ops =
 {
 	.open =		he_open,
--- linux-2.6.10-rc1-mm3-full/drivers/atm/idt77105.h.old	2004-11-05 23:35:21.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/atm/idt77105.h	2004-11-05 23:35:31.000000000 +0100
@@ -77,7 +77,6 @@
 
 #ifdef __KERNEL__
 int idt77105_init(struct atm_dev *dev) __init;
-int idt77105_stop(struct atm_dev *dev);
 #endif
 
 /*
--- linux-2.6.10-rc1-mm3-full/drivers/atm/idt77105.c.old	2004-11-05 23:25:11.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/atm/idt77105.c	2004-11-05 23:25:26.000000000 +0100
@@ -323,7 +323,7 @@
 }
 
 
-int idt77105_stop(struct atm_dev *dev)
+static int idt77105_stop(struct atm_dev *dev)
 {
 	struct idt77105_priv *walk, *prev;
 
--- linux-2.6.10-rc1-mm3-full/drivers/atm/idt77252.h.old	2004-11-05 23:25:56.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/atm/idt77252.h	2004-11-05 23:26:24.000000000 +0100
@@ -275,7 +275,7 @@
 	struct rsq_entry	*next;
 	struct rsq_entry	*last;
 	dma_addr_t		paddr;
-} rsq_info;
+};
 
 
 /*****************************************************************************/
--- linux-2.6.10-rc1-mm3-full/drivers/atm/iphase.h.old	2004-11-05 23:34:43.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/atm/iphase.h	2004-11-05 23:35:05.000000000 +0100
@@ -1126,8 +1126,6 @@
 #define FE_DS3_PHY      0x0080          /* DS3 */
 #define FE_E3_PHY       0x0090          /* E3 */
 		     
-extern void ia_mb25_init (IADEV *);
-
 /*********************** SUNI_PM7345 PHY DEFINE HERE *********************/
 typedef struct _suni_pm7345_t
 {
@@ -1326,8 +1324,6 @@
 #define SUNI_DS3_FOVRI  0x02            /* FIFO overrun                 */
 #define SUNI_DS3_FUDRI  0x01            /* FIFO underrun                */
 
-extern void ia_suni_pm7345_init (IADEV *iadev);
-
 ///////////////////SUNI_PM7345 PHY DEFINE END /////////////////////////////
 
 /* ia_eeprom define*/
--- linux-2.6.10-rc1-mm3-full/drivers/atm/iphase.c.old	2004-11-05 23:26:35.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/atm/iphase.c	2004-11-05 23:30:13.000000000 +0100
@@ -72,13 +72,13 @@
 #define PRIV(dev) ((struct suni_priv *) dev->phy_data)
 
 static unsigned char ia_phy_get(struct atm_dev *dev, unsigned long addr);
+static void desc_dbg(IADEV *iadev);
 
 static IADEV *ia_dev[8];
 static struct atm_dev *_ia_dev[8];
 static int iadev_count;
 static void ia_led_timer(unsigned long arg);
 static struct timer_list ia_timer = TIMER_INITIALIZER(ia_led_timer, 0, 0);
-struct atm_vcc *vcc_close_que[100];
 static int IA_TX_BUF = DFL_TX_BUFFERS, IA_TX_BUF_SZ = DFL_TX_BUF_SZ;
 static int IA_RX_BUF = DFL_RX_BUFFERS, IA_RX_BUF_SZ = DFL_RX_BUF_SZ;
 static uint IADebugFlag = /* IF_IADBG_ERR | IF_IADBG_CBR| IF_IADBG_INIT_ADAPTER
@@ -147,7 +147,6 @@
   u_short 		desc1;
   u_short		tcq_wr;
   struct ia_vcc         *iavcc_r = NULL; 
-  extern void desc_dbg(IADEV *iadev);
 
   tcq_wr = readl(dev->seg_reg+TCQ_WR_PTR) & 0xffff;
   while (dev->host_tcq_wr != tcq_wr) {
@@ -187,7 +186,6 @@
   unsigned long delta;
   static unsigned long timer = 0;
   int ltimeout;
-  extern void desc_dbg(IADEV *iadev);
 
   ia_hack_tcq (dev);
   if(((jiffies - timer)>50)||((dev->ffL.tcq_rd==dev->host_tcq_wr))){      
@@ -643,7 +641,7 @@
    return 0;
 }
 
-void ia_tx_poll (IADEV *iadev) {
+static void ia_tx_poll (IADEV *iadev) {
    struct atm_vcc *vcc = NULL;
    struct sk_buff *skb = NULL, *skb1 = NULL;
    struct ia_vcc *iavcc;
@@ -860,7 +858,7 @@
   return;
 }
 
-void ia_mb25_init (IADEV *iadev)
+static void ia_mb25_init (IADEV *iadev)
 {
    volatile ia_mb25_t  *mb25 = (ia_mb25_t*)iadev->phy;
 #if 0
@@ -875,7 +873,7 @@
    return;
 }                   
 
-void ia_suni_pm7345_init (IADEV *iadev)
+static void ia_suni_pm7345_init (IADEV *iadev)
 {
    volatile suni_pm7345_t *suni_pm7345 = (suni_pm7345_t *)iadev->phy;
    if (iadev->phy_type & FE_DS3_PHY)
@@ -958,9 +956,8 @@
 
 /***************************** IA_LIB END *****************************/
     
-/* pwang_test debug utility */
-int tcnter = 0, rcnter = 0;
-void xdump( u_char*  cp, int  length, char*  prefix )
+static int tcnter = 0;
+static void xdump( u_char*  cp, int  length, char*  prefix )
 {
     int col, count;
     u_char prntBuf[120];
@@ -1007,7 +1004,7 @@
   
 /*-- some utilities and memory allocation stuff will come here -------------*/  
   
-void desc_dbg(IADEV *iadev) {
+static void desc_dbg(IADEV *iadev) {
 
   u_short tcq_wr_ptr, tcq_st_ptr, tcq_ed_ptr;
   u32 tmp, i;
--- linux-2.6.10-rc1-mm3-full/drivers/atm/nicstarmac.h.old	2004-11-06 00:07:58.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/atm/nicstarmac.h	2004-11-06 00:11:07.000000000 +0100
@@ -9,6 +9,5 @@
 
 typedef void __iomem *virt_addr_t;
 
-u_int32_t nicstar_read_eprom_status( virt_addr_t base );
 void nicstar_init_eprom( virt_addr_t base );
 void nicstar_read_eprom( virt_addr_t, u_int8_t, u_int8_t *, u_int32_t);
--- linux-2.6.10-rc2-mm4-full/drivers/atm/nicstarmac.c.old	2004-12-02 01:00:30.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/atm/nicstarmac.c	2004-12-02 01:03:43.000000000 +0100
@@ -35,6 +35,7 @@
 #define SI_LOW		0x0000		/* Serial input data low */
 
 /* Read Status Register = 0000 0101b */
+#if 0
 static u_int32_t rdsrtab[] =
 {
     CS_HIGH | CLK_HIGH, 
@@ -55,6 +56,7 @@
     CLK_LOW | SI_HIGH, 
     CLK_HIGH | SI_HIGH   /* 1 */
 };
+#endif  /*  0  */
 
 
 /* Read from EEPROM = 0000 0011b */
@@ -117,7 +119,7 @@
  * eeprom, then pull the result from bit 16 of the NicSTaR's General Purpose 
  * register.  
  */
-
+#if 0
 u_int32_t
 nicstar_read_eprom_status( virt_addr_t base )
 {
@@ -153,6 +155,7 @@
    osp_MicroDelay( CYCLE_DELAY );
    return rbyte;
 }
+#endif  /*  0  */
 
 
 /*

