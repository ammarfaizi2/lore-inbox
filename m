Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbVL2Sm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbVL2Sm0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 13:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVL2Sm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 13:42:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:3288 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750822AbVL2SmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 13:42:25 -0500
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, mpm@selenic.com
In-Reply-To: <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org>
References: <20051228114637.GA3003@elte.hu>
	 <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
	 <1135798495.2935.29.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
	 <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
	 <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu>
	 <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org>
Content-Type: text/plain
Date: Thu, 29 Dec 2005 19:42:15 +0100
Message-Id: <1135881735.2935.66.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> One thing we could do: I think modern gcc's at least have an option to 
> warn when they don't inline something. It might make sense to just enable 
> that warning, and see _which_ functions -Os and -funit-at-a-time say are 
> too large to be inlined.


with -Os gcc gets a bit picky and warns a LOT; with -O2... you get the
following fixes (all huge functions)


diff -purN linux-org/drivers/acpi/ec.c linux-2.6.15-rc6/drivers/acpi/ec.c
--- linux-org/drivers/acpi/ec.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc6/drivers/acpi/ec.c	2005-12-29 19:21:37.000000000 +0100
@@ -153,7 +153,7 @@ static int acpi_ec_polling_mode = EC_POL
                              Transaction Management
    -------------------------------------------------------------------------- */
 
-static inline u32 acpi_ec_read_status(union acpi_ec *ec)
+static u32 acpi_ec_read_status(union acpi_ec *ec)
 {
 	u32 status = 0;
 
diff -purN linux-org/drivers/bluetooth/hci_bcsp.c linux-2.6.15-rc6/drivers/bluetooth/hci_bcsp.c
--- linux-org/drivers/bluetooth/hci_bcsp.c	2005-12-22 19:54:33.000000000 +0100
+++ linux-2.6.15-rc6/drivers/bluetooth/hci_bcsp.c	2005-12-29 19:23:21.000000000 +0100
@@ -494,7 +494,7 @@ static inline void bcsp_unslip_one_byte(
 	}
 }
 
-static inline void bcsp_complete_rx_pkt(struct hci_uart *hu)
+static void bcsp_complete_rx_pkt(struct hci_uart *hu)
 {
 	struct bcsp_struct *bcsp = hu->priv;
 	int pass_up;
diff -purN linux-org/drivers/char/drm/r128_state.c linux-2.6.15-rc6/drivers/char/drm/r128_state.c
--- linux-org/drivers/char/drm/r128_state.c	2005-12-22 19:54:33.000000000 +0100
+++ linux-2.6.15-rc6/drivers/char/drm/r128_state.c	2005-12-29 19:24:59.000000000 +0100
@@ -220,7 +220,7 @@ static __inline__ void r128_emit_tex1(dr
 	ADVANCE_RING();
 }
 
-static __inline__ void r128_emit_state(drm_r128_private_t * dev_priv)
+static void r128_emit_state(drm_r128_private_t * dev_priv)
 {
 	drm_r128_sarea_t *sarea_priv = dev_priv->sarea_priv;
 	unsigned int dirty = sarea_priv->dirty;
diff -purN linux-org/drivers/isdn/hisax/avm_pci.c linux-2.6.15-rc6/drivers/isdn/hisax/avm_pci.c
--- linux-org/drivers/isdn/hisax/avm_pci.c	2005-12-22 19:54:33.000000000 +0100
+++ linux-2.6.15-rc6/drivers/isdn/hisax/avm_pci.c	2005-12-29 19:29:31.000000000 +0100
@@ -358,7 +358,7 @@ hdlc_fill_fifo(struct BCState *bcs)
 	}
 }
 
-static inline void
+static void
 HDLC_irq(struct BCState *bcs, u_int stat) {
 	int len;
 	struct sk_buff *skb;
diff -purN linux-org/drivers/isdn/hisax/diva.c linux-2.6.15-rc6/drivers/isdn/hisax/diva.c
--- linux-org/drivers/isdn/hisax/diva.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc6/drivers/isdn/hisax/diva.c	2005-12-29 19:29:42.000000000 +0100
@@ -476,7 +476,7 @@ Memhscx_fill_fifo(struct BCState *bcs)
 	}
 }
 
-static inline void
+static void
 Memhscx_interrupt(struct IsdnCardState *cs, u_char val, u_char hscx)
 {
 	u_char r;
diff -purN linux-org/drivers/isdn/hisax/hscx_irq.c linux-2.6.15-rc6/drivers/isdn/hisax/hscx_irq.c
--- linux-org/drivers/isdn/hisax/hscx_irq.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc6/drivers/isdn/hisax/hscx_irq.c	2005-12-29 19:30:21.000000000 +0100
@@ -119,7 +119,7 @@ hscx_fill_fifo(struct BCState *bcs)
 	}
 }
 
-static inline void
+static void
 hscx_interrupt(struct IsdnCardState *cs, u_char val, u_char hscx)
 {
 	u_char r;
@@ -221,7 +221,7 @@ hscx_interrupt(struct IsdnCardState *cs,
 	}
 }
 
-static inline void
+static void
 hscx_int_main(struct IsdnCardState *cs, u_char val)
 {
 
diff -purN linux-org/drivers/isdn/hisax/jade_irq.c linux-2.6.15-rc6/drivers/isdn/hisax/jade_irq.c
--- linux-org/drivers/isdn/hisax/jade_irq.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc6/drivers/isdn/hisax/jade_irq.c	2005-12-29 19:30:07.000000000 +0100
@@ -110,7 +110,7 @@ jade_fill_fifo(struct BCState *bcs)
 }
 
 
-static inline void
+static void
 jade_interrupt(struct IsdnCardState *cs, u_char val, u_char jade)
 {
 	u_char r;
diff -purN linux-org/drivers/md/dm-crypt.c linux-2.6.15-rc6/drivers/md/dm-crypt.c
--- linux-org/drivers/md/dm-crypt.c	2005-12-22 19:54:33.000000000 +0100
+++ linux-2.6.15-rc6/drivers/md/dm-crypt.c	2005-12-29 19:28:58.000000000 +0100
@@ -228,7 +228,7 @@ static struct crypt_iv_operations crypt_
 };
 
 
-static inline int
+static int
 crypt_convert_scatterlist(struct crypt_config *cc, struct scatterlist *out,
                           struct scatterlist *in, unsigned int length,
                           int write, sector_t sector)
diff -purN linux-org/drivers/media/video/cx25840/cx25840-audio.c linux-2.6.15-rc6/drivers/media/video/cx25840/cx25840-audio.c
--- linux-org/drivers/media/video/cx25840/cx25840-audio.c	2005-12-22 19:54:33.000000000 +0100
+++ linux-2.6.15-rc6/drivers/media/video/cx25840/cx25840-audio.c	2005-12-29 19:31:11.000000000 +0100
@@ -23,7 +23,7 @@
 
 #include "cx25840.h"
 
-inline static int set_audclk_freq(struct i2c_client *client,
+static int set_audclk_freq(struct i2c_client *client,
 				 enum v4l2_audio_clock_freq freq)
 {
 	struct cx25840_state *state = i2c_get_clientdata(client);
diff -purN linux-org/drivers/media/video/tvp5150.c linux-2.6.15-rc6/drivers/media/video/tvp5150.c
--- linux-org/drivers/media/video/tvp5150.c	2005-12-22 19:54:33.000000000 +0100
+++ linux-2.6.15-rc6/drivers/media/video/tvp5150.c	2005-12-29 19:31:41.000000000 +0100
@@ -87,7 +87,7 @@ struct tvp5150 {
 	int sat;
 };
 
-static inline int tvp5150_read(struct i2c_client *c, unsigned char addr)
+static int tvp5150_read(struct i2c_client *c, unsigned char addr)
 {
 	unsigned char buffer[1];
 	int rc;
diff -purN linux-org/drivers/mtd/nand/diskonchip.c linux-2.6.15-rc6/drivers/mtd/nand/diskonchip.c
--- linux-org/drivers/mtd/nand/diskonchip.c	2005-12-22 19:54:34.000000000 +0100
+++ linux-2.6.15-rc6/drivers/mtd/nand/diskonchip.c	2005-12-29 19:31:26.000000000 +0100
@@ -1506,7 +1506,7 @@ static inline int __init doc2001plus_ini
 	return 1;
 }
 
-static inline int __init doc_probe(unsigned long physadr)
+static int __init doc_probe(unsigned long physadr)
 {
 	unsigned char ChipID;
 	struct mtd_info *mtd;
diff -purN linux-org/drivers/net/wireless/ipw2100.c linux-2.6.15-rc6/drivers/net/wireless/ipw2100.c
--- linux-org/drivers/net/wireless/ipw2100.c	2005-12-22 19:54:34.000000000 +0100
+++ linux-2.6.15-rc6/drivers/net/wireless/ipw2100.c	2005-12-29 19:33:50.000000000 +0100
@@ -2346,7 +2346,7 @@ static inline void ipw2100_corruption_de
 	schedule_reset(priv);
 }
 
-static inline void isr_rx(struct ipw2100_priv *priv, int i,
+static void isr_rx(struct ipw2100_priv *priv, int i,
 			  struct ieee80211_rx_stats *stats)
 {
 	struct ipw2100_status *status = &priv->status_queue.drv[i];
@@ -2481,7 +2481,7 @@ static inline int ipw2100_corruption_che
  * The WRITE index is cached in the variable 'priv->rx_queue.next'.
  *
  */
-static inline void __ipw2100_rx_process(struct ipw2100_priv *priv)
+static void __ipw2100_rx_process(struct ipw2100_priv *priv)
 {
 	struct ipw2100_bd_queue *rxq = &priv->rx_queue;
 	struct ipw2100_status_queue *sq = &priv->status_queue;
@@ -2634,7 +2634,7 @@ static inline void __ipw2100_rx_process(
  * for use by future command and data packets.
  *
  */
-static inline int __ipw2100_tx_process(struct ipw2100_priv *priv)
+static int __ipw2100_tx_process(struct ipw2100_priv *priv)
 {
 	struct ipw2100_bd_queue *txq = &priv->tx_queue;
 	struct ipw2100_bd *tbd;
diff -purN linux-org/drivers/scsi/iscsi_tcp.c linux-2.6.15-rc6/drivers/scsi/iscsi_tcp.c
--- linux-org/drivers/scsi/iscsi_tcp.c	2005-12-22 19:54:34.000000000 +0100
+++ linux-2.6.15-rc6/drivers/scsi/iscsi_tcp.c	2005-12-29 19:32:02.000000000 +0100
@@ -1437,7 +1437,7 @@ iscsi_buf_data_digest_update(struct iscs
 	}
 }
 
-static inline int
+static int
 iscsi_digest_final_send(struct iscsi_conn *conn, struct iscsi_cmd_task *ctask,
 			struct iscsi_buf *buf, uint32_t *digest, int final)
 {
diff -purN linux-org/drivers/video/matrox/matroxfb_maven.c linux-2.6.15-rc6/drivers/video/matrox/matroxfb_maven.c
--- linux-org/drivers/video/matrox/matroxfb_maven.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc6/drivers/video/matrox/matroxfb_maven.c	2005-12-29 19:34:05.000000000 +0100
@@ -968,7 +968,7 @@ static inline int maven_compute_timming(
 	return 0;
 }
 
-static inline int maven_program_timming(struct maven_data* md,
+static int maven_program_timming(struct maven_data* md,
 		const struct mavenregs* m) {
 	struct i2c_client* c = md->client;
 
diff -purN linux-org/fs/9p/conv.c linux-2.6.15-rc6/fs/9p/conv.c
--- linux-org/fs/9p/conv.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc6/fs/9p/conv.c	2005-12-29 19:20:19.000000000 +0100
@@ -350,7 +350,7 @@ serialize_stat(struct v9fs_session_info 
  *
  */
 
-static inline int
+static int
 deserialize_stat(struct v9fs_session_info *v9ses, struct cbuf *bufp,
 		 struct v9fs_stat *stat, struct cbuf *dbufp)
 {
diff -purN linux-org/fs/nfsd/nfsxdr.c linux-2.6.15-rc6/fs/nfsd/nfsxdr.c
--- linux-org/fs/nfsd/nfsxdr.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc6/fs/nfsd/nfsxdr.c	2005-12-29 19:24:28.000000000 +0100
@@ -151,7 +151,7 @@ decode_sattr(u32 *p, struct iattr *iap)
 	return p;
 }
 
-static inline u32 *
+static u32 *
 encode_fattr(struct svc_rqst *rqstp, u32 *p, struct svc_fh *fhp)
 {
 	struct vfsmount *mnt = fhp->fh_export->ex_mnt;
diff -purN linux-org/net/ieee80211/ieee80211_rx.c linux-2.6.15-rc6/net/ieee80211/ieee80211_rx.c
--- linux-org/net/ieee80211/ieee80211_rx.c	2005-12-22 19:54:36.000000000 +0100
+++ linux-2.6.15-rc6/net/ieee80211/ieee80211_rx.c	2005-12-29 19:24:05.000000000 +0100
@@ -1295,7 +1295,7 @@ static inline int is_beacon(int fc)
 	return (WLAN_FC_GET_STYPE(le16_to_cpu(fc)) == IEEE80211_STYPE_BEACON);
 }
 
-static inline void ieee80211_process_probe_response(struct ieee80211_device
+static void ieee80211_process_probe_response(struct ieee80211_device
 						    *ieee, struct
 						    ieee80211_probe_response
 						    *beacon, struct ieee80211_rx_stats
diff -purN linux-org/net/netfilter/nfnetlink.c linux-2.6.15-rc6/net/netfilter/nfnetlink.c
--- linux-org/net/netfilter/nfnetlink.c	2005-12-22 19:54:36.000000000 +0100
+++ linux-2.6.15-rc6/net/netfilter/nfnetlink.c	2005-12-29 19:28:08.000000000 +0100
@@ -212,7 +212,7 @@ int nfnetlink_unicast(struct sk_buff *sk
 }
 
 /* Process one complete nfnetlink message. */
-static inline int nfnetlink_rcv_msg(struct sk_buff *skb,
+static int nfnetlink_rcv_msg(struct sk_buff *skb,
 				    struct nlmsghdr *nlh, int *errp)
 {
 	struct nfnl_callback *nc;
diff -purN linux-org/sound/oss/esssolo1.c linux-2.6.15-rc6/sound/oss/esssolo1.c
--- linux-org/sound/oss/esssolo1.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc6/sound/oss/esssolo1.c	2005-12-29 19:23:05.000000000 +0100
@@ -515,7 +515,7 @@ static inline int prog_dmabuf_adc(struct
 	return 0;
 }
 
-static inline int prog_dmabuf_dac(struct solo1_state *s)
+static int prog_dmabuf_dac(struct solo1_state *s)
 {
 	unsigned long va;
 	int c;


