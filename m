Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVBSJEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVBSJEu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 04:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVBSJDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 04:03:51 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14095 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261678AbVBSIxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 03:53:34 -0500
Date: Sat, 19 Feb 2005 09:53:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: proski@gnu.org, hermes@gibson.dropbear.id.au, acme@conectiva.com.br
Cc: jgarzik@pobox.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/wireless/: possible cleanups
Message-ID: <20050219085331.GX4337@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- remove the following unneeded EXPORT_SYMBOL:
  - orinoco.c: orinoco_stop

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/wireless/airo.c         |   65 ++++++++++++++--------------
 drivers/net/wireless/orinoco.c      |    7 +--
 drivers/net/wireless/orinoco.h      |    1 
 drivers/net/wireless/strip.c        |    2 
 drivers/net/wireless/wavelan_cs.c   |   26 ++++++-----
 drivers/net/wireless/wavelan_cs.h   |    6 +-
 drivers/net/wireless/wavelan_cs.p.h |   17 -------
 drivers/net/wireless/wl3501_cs.c    |   11 ++--
 8 files changed, 62 insertions(+), 73 deletions(-)

--- linux-2.6.11-rc3-mm2-full/drivers/net/wireless/airo.c.old	2005-02-17 00:36:40.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/wireless/airo.c	2005-02-17 00:58:16.000000000 +0100
@@ -1040,7 +1040,7 @@
 	u16 status;
 } WifiCtlHdr;
 
-WifiCtlHdr wifictlhdr8023 = {
+static WifiCtlHdr wifictlhdr8023 = {
 	.ctlhdr = {
 		.ctl	= HOST_DONT_RLSE,
 	}
@@ -1111,13 +1111,13 @@
 static void timer_func( struct net_device *dev );
 static int airo_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 #ifdef WIRELESS_EXT
-struct iw_statistics *airo_get_wireless_stats (struct net_device *dev);
+static struct iw_statistics *airo_get_wireless_stats (struct net_device *dev);
 static void airo_read_wireless_stats (struct airo_info *local);
 #endif /* WIRELESS_EXT */
 #ifdef CISCO_EXT
 static int readrids(struct net_device *dev, aironet_ioctl *comp);
 static int writerids(struct net_device *dev, aironet_ioctl *comp);
-int flashcard(struct net_device *dev, aironet_ioctl *comp);
+static int flashcard(struct net_device *dev, aironet_ioctl *comp);
 #endif /* CISCO_EXT */
 #ifdef MICSUPPORT
 static void micinit(struct airo_info *ai);
@@ -1223,6 +1223,12 @@
 static int takedown_proc_entry( struct net_device *dev,
 				struct airo_info *apriv );
 
+static int cmdreset(struct airo_info *ai);
+static int setflashmode (struct airo_info *ai);
+static int flashgchar(struct airo_info *ai,int matchbyte,int dwelltime);
+static int flashputbuf(struct airo_info *ai);
+static int flashrestart(struct airo_info *ai,struct net_device *dev);
+
 #ifdef MICSUPPORT
 /***********************************************************************
  *                              MIC ROUTINES                           *
@@ -1231,10 +1237,11 @@
 
 static int RxSeqValid (struct airo_info *ai,miccntx *context,int mcast,u32 micSeq);
 static void MoveWindow(miccntx *context, u32 micSeq);
-void emmh32_setseed(emmh32_context *context, u8 *pkey, int keylen, struct crypto_tfm *);
-void emmh32_init(emmh32_context *context);
-void emmh32_update(emmh32_context *context, u8 *pOctets, int len);
-void emmh32_final(emmh32_context *context, u8 digest[4]);
+static void emmh32_setseed(emmh32_context *context, u8 *pkey, int keylen, struct crypto_tfm *);
+static void emmh32_init(emmh32_context *context);
+static void emmh32_update(emmh32_context *context, u8 *pOctets, int len);
+static void emmh32_final(emmh32_context *context, u8 digest[4]);
+static int flashpchar(struct airo_info *ai,int byte,int dwelltime);
 
 /* micinit - Initialize mic seed */
 
@@ -1312,7 +1319,7 @@
 	return SUCCESS;
 }
 
-char micsnap[]= {0xAA,0xAA,0x03,0x00,0x40,0x96,0x00,0x02};
+static char micsnap[] = {0xAA,0xAA,0x03,0x00,0x40,0x96,0x00,0x02};
 
 /*===========================================================================
  * Description: Mic a packet
@@ -1567,7 +1574,7 @@
 static unsigned char aes_counter[16];
 
 /* expand the key to fill the MMH coefficient array */
-void emmh32_setseed(emmh32_context *context, u8 *pkey, int keylen, struct crypto_tfm *tfm)
+static void emmh32_setseed(emmh32_context *context, u8 *pkey, int keylen, struct crypto_tfm *tfm)
 {
   /* take the keying material, expand if necessary, truncate at 16-bytes */
   /* run through AES counter mode to generate context->coeff[] */
@@ -1599,7 +1606,7 @@
 }
 
 /* prepare for calculation of a new mic */
-void emmh32_init(emmh32_context *context)
+static void emmh32_init(emmh32_context *context)
 {
 	/* prepare for new mic calculation */
 	context->accum = 0;
@@ -1607,7 +1614,7 @@
 }
 
 /* add some bytes to the mic calculation */
-void emmh32_update(emmh32_context *context, u8 *pOctets, int len)
+static void emmh32_update(emmh32_context *context, u8 *pOctets, int len)
 {
 	int	coeff_position, byte_position;
   
@@ -1649,7 +1656,7 @@
 static u32 mask32[4] = { 0x00000000L, 0xFF000000L, 0xFFFF0000L, 0xFFFFFF00L };
 
 /* calculate the mic */
-void emmh32_final(emmh32_context *context, u8 digest[4])
+static void emmh32_final(emmh32_context *context, u8 digest[4])
 {
 	int	coeff_position, byte_position;
 	u32	val;
@@ -2251,7 +2258,7 @@
 	ai->stats.rx_fifo_errors = vals[0];
 }
 
-struct net_device_stats *airo_get_stats(struct net_device *dev)
+static struct net_device_stats *airo_get_stats(struct net_device *dev)
 {
 	struct airo_info *local =  dev->priv;
 
@@ -2410,7 +2417,7 @@
 
 static int add_airo_dev( struct net_device *dev );
 
-int wll_header_parse(struct sk_buff *skb, unsigned char *haddr)
+static int wll_header_parse(struct sk_buff *skb, unsigned char *haddr)
 {
 	memcpy(haddr, skb->mac.raw + 10, ETH_ALEN);
 	return ETH_ALEN;
@@ -2677,7 +2684,7 @@
 	return dev;
 }
 
-int reset_card( struct net_device *dev , int lock) {
+static int reset_card( struct net_device *dev , int lock) {
 	struct airo_info *ai = dev->priv;
 
 	if (lock && down_interruptible(&ai->sem))
@@ -2692,9 +2699,9 @@
 	return 0;
 }
 
-struct net_device *_init_airo_card( unsigned short irq, int port,
-				    int is_pcmcia, struct pci_dev *pci,
-				    struct device *dmdev )
+static struct net_device *_init_airo_card( unsigned short irq, int port,
+					   int is_pcmcia, struct pci_dev *pci,
+					   struct device *dmdev )
 {
 	struct net_device *dev;
 	struct airo_info *ai;
@@ -7177,7 +7184,7 @@
 	local->wstats.miss.beacon = vals[34];
 }
 
-struct iw_statistics *airo_get_wireless_stats(struct net_device *dev)
+static struct iw_statistics *airo_get_wireless_stats(struct net_device *dev)
 {
 	struct airo_info *local =  dev->priv;
 
@@ -7392,14 +7399,8 @@
  * Flash command switch table
  */
 
-int flashcard(struct net_device *dev, aironet_ioctl *comp) {
+static int flashcard(struct net_device *dev, aironet_ioctl *comp) {
 	int z;
-	int cmdreset(struct airo_info *);
-	int setflashmode(struct airo_info *);
-	int flashgchar(struct airo_info *,int,int);
-	int flashpchar(struct airo_info *,int,int);
-	int flashputbuf(struct airo_info *);
-	int flashrestart(struct airo_info *,struct net_device *);
 
 	/* Only super-user can modify flash */
 	if (!capable(CAP_NET_ADMIN))
@@ -7457,7 +7458,7 @@
  * card.
  */
 
-int cmdreset(struct airo_info *ai) {
+static int cmdreset(struct airo_info *ai) {
 	disable_MAC(ai, 1);
 
 	if(!waitbusy (ai)){
@@ -7481,7 +7482,7 @@
  * mode
  */
 
-int setflashmode (struct airo_info *ai) {
+static int setflashmode (struct airo_info *ai) {
 	set_bit (FLAG_FLASHING, &ai->flags);
 
 	OUT4500(ai, SWS0, FLASH_COMMAND);
@@ -7508,7 +7509,7 @@
  * x 50us for  echo .
  */
 
-int flashpchar(struct airo_info *ai,int byte,int dwelltime) {
+static int flashpchar(struct airo_info *ai,int byte,int dwelltime) {
 	int echo;
 	int waittime;
 
@@ -7548,7 +7549,7 @@
  * Get a character from the card matching matchbyte
  * Step 3)
  */
-int flashgchar(struct airo_info *ai,int matchbyte,int dwelltime){
+static int flashgchar(struct airo_info *ai,int matchbyte,int dwelltime){
 	int           rchar;
 	unsigned char rbyte=0;
 
@@ -7579,7 +7580,7 @@
  * send to the card
  */
 
-int flashputbuf(struct airo_info *ai){
+static int flashputbuf(struct airo_info *ai){
 	int            nwords;
 
 	/* Write stuff */
@@ -7601,7 +7602,7 @@
 /*
  *
  */
-int flashrestart(struct airo_info *ai,struct net_device *dev){
+static int flashrestart(struct airo_info *ai,struct net_device *dev){
 	int    i,status;
 
 	ssleep(1);			/* Added 12/7/00 */
--- linux-2.6.11-rc3-mm2-full/drivers/net/wireless/orinoco.h.old	2005-02-17 01:00:23.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/wireless/orinoco.h	2005-02-17 01:00:26.000000000 +0100
@@ -110,7 +110,6 @@
 					   int (*hard_reset)(struct orinoco_private *));
 extern int __orinoco_up(struct net_device *dev);
 extern int __orinoco_down(struct net_device *dev);
-extern int orinoco_stop(struct net_device *dev);
 extern int orinoco_reinit_firmware(struct net_device *dev);
 extern irqreturn_t orinoco_interrupt(int irq, void * dev_id, struct pt_regs *regs);
 
--- linux-2.6.11-rc3-mm2-full/drivers/net/wireless/orinoco.c.old	2005-02-17 00:59:51.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/wireless/orinoco.c	2005-02-17 01:00:49.000000000 +0100
@@ -558,7 +558,7 @@
 } __attribute__ ((packed));
 
 /* 802.2 LLC/SNAP header used for Ethernet encapsulation over 802.11 */
-u8 encaps_hdr[] = {0xaa, 0xaa, 0x03, 0x00, 0x00, 0x00};
+static u8 encaps_hdr[] = {0xaa, 0xaa, 0x03, 0x00, 0x00, 0x00};
 
 #define ENCAPS_OVERHEAD		(sizeof(encaps_hdr) + 2)
 
@@ -630,7 +630,7 @@
 	return err;
 }
 
-int orinoco_stop(struct net_device *dev)
+static int orinoco_stop(struct net_device *dev)
 {
 	struct orinoco_private *priv = netdev_priv(dev);
 	int err = 0;
@@ -3877,7 +3877,7 @@
 	return err;
 }
 
-struct {
+static struct {
 	u16 rid;
 	char *name;
 	int displaytype;
@@ -4130,7 +4130,6 @@
 
 EXPORT_SYMBOL(__orinoco_up);
 EXPORT_SYMBOL(__orinoco_down);
-EXPORT_SYMBOL(orinoco_stop);
 EXPORT_SYMBOL(orinoco_reinit_firmware);
 
 EXPORT_SYMBOL(orinoco_interrupt);
--- linux-2.6.11-rc3-mm2-full/drivers/net/wireless/strip.c.old	2005-02-17 01:01:41.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/wireless/strip.c	2005-02-17 01:03:20.000000000 +0100
@@ -209,7 +209,7 @@
 	NoStructure = 0,	/* Really old firmware */
 	StructuredMessages = 1,	/* Parsable AT response msgs */
 	ChecksummedMessages = 2	/* Parsable AT response msgs with checksums */
-} FirmwareLevel;
+};
 
 struct strip {
 	int magic;
--- linux-2.6.11-rc3-mm2-full/drivers/net/wireless/wavelan_cs.h.old	2005-02-17 01:06:07.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/wireless/wavelan_cs.h	2005-02-17 01:07:27.000000000 +0100
@@ -62,7 +62,7 @@
  * like DEC RoamAbout, or Digital Ocean, Epson, ...), you must modify this
  * part to accommodate your hardware...
  */
-const unsigned char	MAC_ADDRESSES[][3] =
+static const unsigned char	MAC_ADDRESSES[][3] =
 {
   { 0x08, 0x00, 0x0E },		/* AT&T Wavelan (standard) & DEC RoamAbout */
   { 0x08, 0x00, 0x6A },		/* AT&T Wavelan (alternate) */
@@ -79,14 +79,14 @@
  * (as read in the offset register of the dac area).
  * Used to map channel numbers used by `wfreqsel' to frequencies
  */
-const short	channel_bands[] = { 0x30, 0x58, 0x64, 0x7A, 0x80, 0xA8,
+static const short	channel_bands[] = { 0x30, 0x58, 0x64, 0x7A, 0x80, 0xA8,
 				    0xD0, 0xF0, 0xF8, 0x150 };
 
 /* Frequencies of the 1.0 modem (fixed frequencies).
  * Use to map the PSA `subband' to a frequency
  * Note : all frequencies apart from the first one need to be multiplied by 10
  */
-const int	fixed_bands[] = { 915e6, 2.425e8, 2.46e8, 2.484e8, 2.4305e8 };
+static const int	fixed_bands[] = { 915e6, 2.425e8, 2.46e8, 2.484e8, 2.4305e8 };
 
 
 /*************************** PC INTERFACE ****************************/
--- linux-2.6.11-rc3-mm2-full/drivers/net/wireless/wavelan_cs.p.h.old	2005-02-17 01:08:14.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/wireless/wavelan_cs.p.h	2005-02-17 01:12:12.000000000 +0100
@@ -648,23 +648,6 @@
   void __iomem *mem;
 };
 
-/**************************** PROTOTYPES ****************************/
-
-#ifdef WAVELAN_ROAMING
-/* ---------------------- ROAMING SUBROUTINES -----------------------*/
-
-wavepoint_history *wl_roam_check(unsigned short nwid, net_local *lp);
-wavepoint_history *wl_new_wavepoint(unsigned short nwid, unsigned char seq, net_local *lp);
-void wl_del_wavepoint(wavepoint_history *wavepoint, net_local *lp);
-void wl_cell_expiry(unsigned long data);
-wavepoint_history *wl_best_sigqual(int fast_search, net_local *lp);
-void wl_update_history(wavepoint_history *wavepoint, unsigned char sigqual, unsigned char seq);
-void wv_roam_handover(wavepoint_history *wavepoint, net_local *lp);
-void wv_nwid_filter(unsigned char mode, net_local *lp);
-void wv_roam_init(struct net_device *dev);
-void wv_roam_cleanup(struct net_device *dev);
-#endif	/* WAVELAN_ROAMING */
-
 /* ----------------- MODEM MANAGEMENT SUBROUTINES ----------------- */
 static inline u_char		/* data */
 	hasr_read(u_long);	/* Read the host interface : base address */
--- linux-2.6.11-rc3-mm2-full/drivers/net/wireless/wavelan_cs.c.old	2005-02-17 01:06:40.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/wireless/wavelan_cs.c	2005-02-17 01:11:53.000000000 +0100
@@ -59,6 +59,12 @@
 /* Do *NOT* add other headers here, you are guaranteed to be wrong - Jean II */
 #include "wavelan_cs.p.h"		/* Private header */
 
+#ifdef WAVELAN_ROAMING
+static void wl_cell_expiry(unsigned long data);
+static void wl_del_wavepoint(wavepoint_history *wavepoint, struct net_local *lp);
+static void wv_nwid_filter(unsigned char mode, net_local *lp);
+#endif  /*  WAVELAN_ROAMING  */
+
 /************************* MISC SUBROUTINES **************************/
 /*
  * Subroutines which won't fit in one of the following category
@@ -500,9 +506,9 @@
 
 #ifdef WAVELAN_ROAMING	/* Conditional compile, see wavelan_cs.h */
 
-unsigned char WAVELAN_BEACON_ADDRESS[]= {0x09,0x00,0x0e,0x20,0x03,0x00};
+static unsigned char WAVELAN_BEACON_ADDRESS[] = {0x09,0x00,0x0e,0x20,0x03,0x00};
   
-void wv_roam_init(struct net_device *dev)
+static void wv_roam_init(struct net_device *dev)
 {
   net_local  *lp= netdev_priv(dev);
 
@@ -531,7 +537,7 @@
   printk(KERN_DEBUG "WaveLAN: Roaming enabled on device %s\n",dev->name);
 }
  
-void wv_roam_cleanup(struct net_device *dev)
+static void wv_roam_cleanup(struct net_device *dev)
 {
   wavepoint_history *ptr,*old_ptr;
   net_local *lp= netdev_priv(dev);
@@ -550,7 +556,7 @@
 }
 
 /* Enable/Disable NWID promiscuous mode on a given device */
-void wv_nwid_filter(unsigned char mode, net_local *lp)
+static void wv_nwid_filter(unsigned char mode, net_local *lp)
 {
   mm_t                  m;
   unsigned long         flags;
@@ -575,7 +581,7 @@
 }
 
 /* Find a record in the WavePoint table matching a given NWID */
-wavepoint_history *wl_roam_check(unsigned short nwid, net_local *lp)
+static wavepoint_history *wl_roam_check(unsigned short nwid, net_local *lp)
 {
   wavepoint_history	*ptr=lp->wavepoint_table.head;
   
@@ -588,7 +594,7 @@
 }
 
 /* Create a new wavepoint table entry */
-wavepoint_history *wl_new_wavepoint(unsigned short nwid, unsigned char seq, net_local* lp)
+static wavepoint_history *wl_new_wavepoint(unsigned short nwid, unsigned char seq, net_local* lp)
 {
   wavepoint_history *new_wavepoint;
 
@@ -624,7 +630,7 @@
 }
 
 /* Remove a wavepoint entry from WavePoint table */
-void wl_del_wavepoint(wavepoint_history *wavepoint, struct net_local *lp)
+static void wl_del_wavepoint(wavepoint_history *wavepoint, struct net_local *lp)
 {
   if(wavepoint==NULL)
     return;
@@ -646,7 +652,7 @@
 }
 
 /* Timer callback function - checks WavePoint table for stale entries */ 
-void wl_cell_expiry(unsigned long data)
+static void wl_cell_expiry(unsigned long data)
 {
   net_local *lp=(net_local *)data;
   wavepoint_history *wavepoint=lp->wavepoint_table.head,*old_point;
@@ -686,7 +692,7 @@
 }
 
 /* Update SNR history of a wavepoint */
-void wl_update_history(wavepoint_history *wavepoint, unsigned char sigqual, unsigned char seq)	
+static void wl_update_history(wavepoint_history *wavepoint, unsigned char sigqual, unsigned char seq)	
 {
   int i=0,num_missed=0,ptr=0;
   int average_fast=0,average_slow=0;
@@ -723,7 +729,7 @@
 }
 
 /* Perform a handover to a new WavePoint */
-void wv_roam_handover(wavepoint_history *wavepoint, net_local *lp)
+static void wv_roam_handover(wavepoint_history *wavepoint, net_local *lp)
 {
   kio_addr_t		base = lp->dev->base_addr;
   mm_t                  m;
--- linux-2.6.11-rc3-mm2-full/drivers/net/wireless/wl3501_cs.c.old	2005-02-17 01:12:31.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/wireless/wl3501_cs.c	2005-02-17 01:13:41.000000000 +0100
@@ -297,7 +297,8 @@
  *
  * Move 'size' bytes from PC to card. (Shouldn't be interrupted)
  */
-void wl3501_set_to_wla(struct wl3501_card *this, u16 dest, void *src, int size)
+static void wl3501_set_to_wla(struct wl3501_card *this, u16 dest, void *src,
+			      int size)
 {
 	/* switch to SRAM Page 0 */
 	wl3501_switch_page(this, (dest & 0x8000) ? WL3501_BSS_SPAGE1 :
@@ -318,8 +319,8 @@
  *
  * Move 'size' bytes from card to PC. (Shouldn't be interrupted)
  */
-void wl3501_get_from_wla(struct wl3501_card *this, u16 src, void *dest,
-			 int size)
+static void wl3501_get_from_wla(struct wl3501_card *this, u16 src, void *dest,
+				int size)
 {
 	/* switch to SRAM Page 0 */
 	wl3501_switch_page(this, (src & 0x8000) ? WL3501_BSS_SPAGE1 :
@@ -1439,14 +1440,14 @@
 	goto out;
 }
 
-struct net_device_stats *wl3501_get_stats(struct net_device *dev)
+static struct net_device_stats *wl3501_get_stats(struct net_device *dev)
 {
 	struct wl3501_card *this = dev->priv;
 
 	return &this->stats;
 }
 
-struct iw_statistics *wl3501_get_wireless_stats(struct net_device *dev)
+static struct iw_statistics *wl3501_get_wireless_stats(struct net_device *dev)
 {
 	struct wl3501_card *this = dev->priv;
 	struct iw_statistics *wstats = &this->wstats;
