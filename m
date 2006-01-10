Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWAJU5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWAJU5F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932629AbWAJU5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:57:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62985 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932152AbWAJU5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:57:04 -0500
Date: Tue, 10 Jan 2006 21:57:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: dann frazier <dannf@dannf.org>
Cc: linux-kernel@vger.kernel.org, 344205@bugs.debian.org,
       Roland Mas <lolando@debian.org>
Subject: [2.6 patch] fix AIRO{,_CS} <-> CRYPTO
Message-ID: <20060110205701.GC3911@stusta.de>
References: <20051220211944.19259.91642.reportbug@mirexpress.internal.placard.fr.eu.org> <87irt1vz4o.fsf@mirexpress.internal.placard.fr.eu.org> <1136588604.16769.55.camel@krebs.dannf> <877j9cfc4q.fsf@mirexpress.internal.placard.fr.eu.org> <1136681234.11955.12.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136681234.11955.12.camel@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 05:47:14PM -0700, dann frazier wrote:
> airo.c currently has MICSUPPORT enabled, which requires CONFIG_CRYPTO.
> A user reported a build failure which is due to the lack of a Kconfig
> dependency.  See http://bugs.debian.org/344205.
> 
> This patch makes Kconfig enforce this dependency.
> 
> Signed-off-by: dann frazier <dannf@debian.org>
>...

Hi Dann,

thanks for your patch.

A more complete fix is below.

cu
Adrian


<--  snip  -->


drivers/net/wireless/airo.c requires CONFIG_CRYPTO for compilations.

Therefore, AIRO and AIRO_CS should select CRYPTO.

Additionally, this patch removes the #ifdef's for the non-compiling 
CRYPTO=n case from drivers/net/wireless/airo.c.

Bug report by Roland Mas <lolando@debian.org>,
initial patch by dann frazier <dannf@debian.org>.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/wireless/Kconfig |    2 +
 drivers/net/wireless/airo.c  |   55 +----------------------------------
 2 files changed, 4 insertions(+), 53 deletions(-)

--- linux-2.6.15-mm2-full/drivers/net/wireless/Kconfig.old	2006-01-10 20:40:12.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/net/wireless/Kconfig	2006-01-10 21:06:08.000000000 +0100
@@ -244,6 +244,7 @@
 config AIRO
 	tristate "Cisco/Aironet 34X/35X/4500/4800 ISA and PCI cards"
 	depends on NET_RADIO && ISA_DMA_API && (PCI || BROKEN)
+	select CRYPTO
 	---help---
 	  This is the standard Linux driver to support Cisco/Aironet ISA and
 	  PCI 802.11 wireless cards.
@@ -391,6 +392,7 @@
 config AIRO_CS
 	tristate "Cisco/Aironet 34X/35X/4500/4800 PCMCIA cards"
 	depends on NET_RADIO && PCMCIA && (BROKEN || !M32R)
+	select CRYPTO
 	---help---
 	  This is the standard Linux driver to support Cisco/Aironet PCMCIA
 	  802.11 wireless cards.  This driver is the same as the Aironet
--- linux-2.6.15-mm2-full/drivers/net/wireless/airo.c.old	2006-01-10 20:40:31.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/net/wireless/airo.c	2006-01-10 20:42:44.000000000 +0100
@@ -36,6 +36,7 @@
 #include <linux/in.h>
 #include <linux/bitops.h>
 #include <linux/scatterlist.h>
+#include <linux/crypto.h>
 #include <asm/io.h>
 #include <asm/system.h>
 
@@ -87,14 +88,6 @@
 #include <linux/delay.h>
 #endif
 
-/* Support Cisco MIC feature */
-#define MICSUPPORT
-
-#if defined(MICSUPPORT) && !defined(CONFIG_CRYPTO)
-#warning MIC support requires Crypto API
-#undef MICSUPPORT
-#endif
-
 /* Hack to do some power saving */
 #define POWER_ON_DOWN
 
@@ -1118,7 +1111,6 @@
 static int writerids(struct net_device *dev, aironet_ioctl *comp);
 static int flashcard(struct net_device *dev, aironet_ioctl *comp);
 #endif /* CISCO_EXT */
-#ifdef MICSUPPORT
 static void micinit(struct airo_info *ai);
 static int micsetup(struct airo_info *ai);
 static int encapsulate(struct airo_info *ai, etherHead *pPacket, MICBuffer *buffer, int len);
@@ -1127,9 +1119,6 @@
 static u8 airo_rssi_to_dbm (tdsRssiEntry *rssi_rid, u8 rssi);
 static u8 airo_dbm_to_pct (tdsRssiEntry *rssi_rid, u8 dbm);
 
-#include <linux/crypto.h>
-#endif
-
 struct airo_info {
 	struct net_device_stats	stats;
 	struct net_device             *dev;
@@ -1190,12 +1179,10 @@
 	unsigned long		scan_timestamp;	/* Time started to scan */
 	struct iw_spy_data	spy_data;
 	struct iw_public_data	wireless_data;
-#ifdef MICSUPPORT
 	/* MIC stuff */
 	struct crypto_tfm	*tfm;
 	mic_module		mod[2];
 	mic_statistics		micstats;
-#endif
 	HostRxDesc rxfids[MPI_MAX_FIDS]; // rx/tx/config MPI350 descriptors
 	HostTxDesc txfids[MPI_MAX_FIDS];
 	HostRidDesc config_desc;
@@ -1229,7 +1216,6 @@
 static int flashputbuf(struct airo_info *ai);
 static int flashrestart(struct airo_info *ai,struct net_device *dev);
 
-#ifdef MICSUPPORT
 /***********************************************************************
  *                              MIC ROUTINES                           *
  ***********************************************************************
@@ -1686,7 +1672,6 @@
 	digest[2] = (val>>8) & 0xFF;
 	digest[3] = val & 0xFF;
 }
-#endif
 
 static int readBSSListRid(struct airo_info *ai, int first,
 		      BSSListRid *list) {
@@ -2005,7 +1990,6 @@
 	 * Firmware automaticly puts 802 header on so
 	 * we don't need to account for it in the length
 	 */
-#ifdef MICSUPPORT
 	if (test_bit(FLAG_MIC_CAPABLE, &ai->flags) && ai->micstats.enabled &&
 		(ntohs(((u16 *)buffer)[6]) != 0x888E)) {
 		MICBuffer pMic;
@@ -2022,9 +2006,7 @@
 		memcpy (sendbuf, &pMic, sizeof(pMic));
 		sendbuf += sizeof(pMic);
 		memcpy (sendbuf, buffer, len - sizeof(etherHead));
-	} else
-#endif
-	{
+	} else {
 		*payloadLen = cpu_to_le16(len - sizeof(etherHead));
 
 		dev->trans_start = jiffies;
@@ -2400,9 +2382,7 @@
 				ai->shared, ai->shared_dma);
 		}
         }
-#ifdef MICSUPPORT
 	crypto_free_tfm(ai->tfm);
-#endif
 	del_airo_dev( dev );
 	free_netdev( dev );
 }
@@ -2726,9 +2706,7 @@
 	ai->thr_pid = kernel_thread(airo_thread, dev, CLONE_FS | CLONE_FILES);
 	if (ai->thr_pid < 0)
 		goto err_out_free;
-#ifdef MICSUPPORT
 	ai->tfm = NULL;
-#endif
 	rc = add_airo_dev( dev );
 	if (rc)
 		goto err_out_thr;
@@ -2969,10 +2947,8 @@
 			airo_read_wireless_stats(ai);
 		else if (test_bit(JOB_PROMISC, &ai->flags))
 			airo_set_promisc(ai);
-#ifdef MICSUPPORT
 		else if (test_bit(JOB_MIC, &ai->flags))
 			micinit(ai);
-#endif
 		else if (test_bit(JOB_EVENT, &ai->flags))
 			airo_send_event(dev);
 		else if (test_bit(JOB_AUTOWEP, &ai->flags))
@@ -3010,12 +2986,10 @@
 
 		if ( status & EV_MIC ) {
 			OUT4500( apriv, EVACK, EV_MIC );
-#ifdef MICSUPPORT
 			if (test_bit(FLAG_MIC_CAPABLE, &apriv->flags)) {
 				set_bit(JOB_MIC, &apriv->flags);
 				wake_up_interruptible(&apriv->thr_wait);
 			}
-#endif
 		}
 		if ( status & EV_LINK ) {
 			union iwreq_data	wrqu;
@@ -3194,11 +3168,8 @@
 				}
 				bap_read (apriv, buffer + hdrlen/2, len, BAP0);
 			} else {
-#ifdef MICSUPPORT
 				MICBuffer micbuf;
-#endif
 				bap_read (apriv, buffer, ETH_ALEN*2, BAP0);
-#ifdef MICSUPPORT
 				if (apriv->micstats.enabled) {
 					bap_read (apriv,(u16*)&micbuf,sizeof(micbuf),BAP0);
 					if (ntohs(micbuf.typelen) > 0x05DC)
@@ -3211,15 +3182,10 @@
 						skb_trim (skb, len + hdrlen);
 					}
 				}
-#endif
 				bap_read(apriv,buffer+ETH_ALEN,len,BAP0);
-#ifdef MICSUPPORT
 				if (decapsulate(apriv,&micbuf,(etherHead*)buffer,len)) {
 badmic:
 					dev_kfree_skb_irq (skb);
-#else
-				if (0) {
-#endif
 badrx:
 					OUT4500( apriv, EVACK, EV_RX);
 					goto exitrx;
@@ -3430,10 +3396,8 @@
 	int len = 0;
 	struct sk_buff *skb;
 	char *buffer;
-#ifdef MICSUPPORT
 	int off = 0;
 	MICBuffer micbuf;
-#endif
 
 	memcpy_fromio(&rxd, ai->rxfids[0].card_ram_off, sizeof(rxd));
 	/* Make sure we got something */
@@ -3448,7 +3412,6 @@
 			goto badrx;
 		}
 		buffer = skb_put(skb,len);
-#ifdef MICSUPPORT
 		memcpy(buffer, ai->rxfids[0].virtual_host_addr, ETH_ALEN * 2);
 		if (ai->micstats.enabled) {
 			memcpy(&micbuf,
@@ -3470,9 +3433,6 @@
 			dev_kfree_skb_irq (skb);
 			goto badrx;
 		}
-#else
-		memcpy(buffer, ai->rxfids[0].virtual_host_addr, len);
-#endif
 #ifdef WIRELESS_SPY
 		if (ai->spy_data.spy_number > 0) {
 			char *sa;
@@ -3689,13 +3649,11 @@
 		ai->config.authType = AUTH_OPEN;
 		ai->config.modulation = MOD_CCK;
 
-#ifdef MICSUPPORT
 		if ((cap_rid.len>=sizeof(cap_rid)) && (cap_rid.extSoftCap&1) &&
 		    (micsetup(ai) == SUCCESS)) {
 			ai->config.opmode |= MODE_MIC;
 			set_bit(FLAG_MIC_CAPABLE, &ai->flags);
 		}
-#endif
 
 		/* Save off the MAC */
 		for( i = 0; i < ETH_ALEN; i++ ) {
@@ -4170,15 +4128,12 @@
 	}
 	len -= ETH_ALEN * 2;
 
-#ifdef MICSUPPORT
 	if (test_bit(FLAG_MIC_CAPABLE, &ai->flags) && ai->micstats.enabled && 
 	    (ntohs(((u16 *)pPacket)[6]) != 0x888E)) {
 		if (encapsulate(ai,(etherHead *)pPacket,&pMic,len) != SUCCESS)
 			return ERROR;
 		miclen = sizeof(pMic);
 	}
-#endif
-
 	// packet is destination[6], source[6], payload[len-12]
 	// write the payload length and dst/src/payload
 	if (bap_setup(ai, txFid, 0x0036, BAP1) != SUCCESS) return ERROR;
@@ -7271,13 +7226,11 @@
 	case AIROGSTAT:     ridcode = RID_STATUS;       break;
 	case AIROGSTATSD32: ridcode = RID_STATSDELTA;   break;
 	case AIROGSTATSC32: ridcode = RID_STATS;        break;
-#ifdef MICSUPPORT
 	case AIROGMICSTATS:
 		if (copy_to_user(comp->data, &ai->micstats,
 				 min((int)comp->len,(int)sizeof(ai->micstats))))
 			return -EFAULT;
 		return 0;
-#endif
 	case AIRORRID:      ridcode = comp->ridnum;     break;
 	default:
 		return -EINVAL;
@@ -7309,9 +7262,7 @@
 static int writerids(struct net_device *dev, aironet_ioctl *comp) {
 	struct airo_info *ai = dev->priv;
 	int  ridcode;
-#ifdef MICSUPPORT
         int  enabled;
-#endif
 	Resp      rsp;
 	static int (* writer)(struct airo_info *, u16 rid, const void *, int, int);
 	unsigned char *iobuf;
@@ -7368,11 +7319,9 @@
 
 		PC4500_readrid(ai,RID_STATSDELTACLEAR,iobuf,RIDSIZE, 1);
 
-#ifdef MICSUPPORT
 		enabled = ai->micstats.enabled;
 		memset(&ai->micstats,0,sizeof(ai->micstats));
 		ai->micstats.enabled = enabled;
-#endif
 
 		if (copy_to_user(comp->data, iobuf,
 				 min((int)comp->len, (int)RIDSIZE))) {

