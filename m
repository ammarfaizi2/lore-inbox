Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262427AbVCSHQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbVCSHQm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 02:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262428AbVCSHQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 02:16:42 -0500
Received: from mail.kroah.org ([69.55.234.183]:13745 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262427AbVCSHPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 02:15:51 -0500
Date: Fri, 18 Mar 2005 23:15:40 -0800
From: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, chrisw@osdl.org, torvalds@osdl.org,
       akpm@osdl.org
Subject: Re: Linux 2.6.11.5
Message-ID: <20050319071540.GB22754@kroah.com>
References: <20050319071515.GA22754@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050319071515.GA22754@kroah.com>
User-Agent: Mutt/1.5.8i
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Nru a/Makefile b/Makefile
--- a/Makefile	2005-03-18 22:35:14 -08:00
+++ b/Makefile	2005-03-18 22:35:14 -08:00
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 11
-EXTRAVERSION = .4
+EXTRAVERSION = .5
 NAME=Woozy Numbat
 
 # *DOCUMENTATION*
diff -Nru a/drivers/net/amd8111e.c b/drivers/net/amd8111e.c
--- a/drivers/net/amd8111e.c	2005-03-18 22:35:14 -08:00
+++ b/drivers/net/amd8111e.c	2005-03-18 22:35:14 -08:00
@@ -1381,6 +1381,8 @@
 
 	if(amd8111e_restart(dev)){
 		spin_unlock_irq(&lp->lock);
+		if (dev->irq)
+			free_irq(dev->irq, dev);
 		return -ENOMEM;
 	}
 	/* Start ipg timer */
diff -Nru a/drivers/net/tun.c b/drivers/net/tun.c
--- a/drivers/net/tun.c	2005-03-18 22:35:14 -08:00
+++ b/drivers/net/tun.c	2005-03-18 22:35:14 -08:00
@@ -229,7 +229,7 @@
 	size_t len = count;
 
 	if (!(tun->flags & TUN_NO_PI)) {
-		if ((len -= sizeof(pi)) > len)
+		if ((len -= sizeof(pi)) > count)
 			return -EINVAL;
 
 		if(memcpy_fromiovec((void *)&pi, iv, sizeof(pi)))
diff -Nru a/drivers/net/via-rhine.c b/drivers/net/via-rhine.c
--- a/drivers/net/via-rhine.c	2005-03-18 22:35:14 -08:00
+++ b/drivers/net/via-rhine.c	2005-03-18 22:35:14 -08:00
@@ -1197,8 +1197,10 @@
 		       dev->name, rp->pdev->irq);
 
 	rc = alloc_ring(dev);
-	if (rc)
+	if (rc) {
+		free_irq(rp->pdev->irq, dev);
 		return rc;
+	}
 	alloc_rbufs(dev);
 	alloc_tbufs(dev);
 	rhine_chip_reset(dev);
diff -Nru a/drivers/net/wan/hd6457x.c b/drivers/net/wan/hd6457x.c
--- a/drivers/net/wan/hd6457x.c	2005-03-18 22:35:14 -08:00
+++ b/drivers/net/wan/hd6457x.c	2005-03-18 22:35:14 -08:00
@@ -315,7 +315,7 @@
 #endif
 	stats->rx_packets++;
 	stats->rx_bytes += skb->len;
-	skb->dev->last_rx = jiffies;
+	dev->last_rx = jiffies;
 	skb->protocol = hdlc_type_trans(skb, dev);
 	netif_rx(skb);
 }
diff -Nru a/kernel/signal.c b/kernel/signal.c
--- a/kernel/signal.c	2005-03-18 22:35:14 -08:00
+++ b/kernel/signal.c	2005-03-18 22:35:14 -08:00
@@ -1728,6 +1728,7 @@
 			 * with another processor delivering a stop signal,
 			 * then the SIGCONT that wakes us up should clear it.
 			 */
+			read_unlock(&tasklist_lock);
 			return 0;
 		}
 
diff -Nru a/net/ipv4/fib_hash.c b/net/ipv4/fib_hash.c
--- a/net/ipv4/fib_hash.c	2005-03-18 22:35:14 -08:00
+++ b/net/ipv4/fib_hash.c	2005-03-18 22:35:14 -08:00
@@ -919,13 +919,23 @@
 	return fa;
 }
 
+static struct fib_alias *fib_get_idx(struct seq_file *seq, loff_t pos)
+{
+	struct fib_alias *fa = fib_get_first(seq);
+
+	if (fa)
+		while (pos && (fa = fib_get_next(seq)))
+			--pos;
+	return pos ? NULL : fa;
+}
+
 static void *fib_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	void *v = NULL;
 
 	read_lock(&fib_hash_lock);
 	if (ip_fib_main_table)
-		v = *pos ? fib_get_next(seq) : SEQ_START_TOKEN;
+		v = *pos ? fib_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
 	return v;
 }
 
diff -Nru a/net/netrom/nr_in.c b/net/netrom/nr_in.c
--- a/net/netrom/nr_in.c	2005-03-18 22:35:14 -08:00
+++ b/net/netrom/nr_in.c	2005-03-18 22:35:14 -08:00
@@ -74,7 +74,6 @@
 static int nr_state1_machine(struct sock *sk, struct sk_buff *skb,
 	int frametype)
 {
-	bh_lock_sock(sk);
 	switch (frametype) {
 	case NR_CONNACK: {
 		nr_cb *nr = nr_sk(sk);
@@ -103,8 +102,6 @@
 	default:
 		break;
 	}
-	bh_unlock_sock(sk);
-
 	return 0;
 }
 
@@ -116,7 +113,6 @@
 static int nr_state2_machine(struct sock *sk, struct sk_buff *skb,
 	int frametype)
 {
-	bh_lock_sock(sk);
 	switch (frametype) {
 	case NR_CONNACK | NR_CHOKE_FLAG:
 		nr_disconnect(sk, ECONNRESET);
@@ -132,8 +128,6 @@
 	default:
 		break;
 	}
-	bh_unlock_sock(sk);
-
 	return 0;
 }
 
@@ -154,7 +148,6 @@
 	nr = skb->data[18];
 	ns = skb->data[17];
 
-	bh_lock_sock(sk);
 	switch (frametype) {
 	case NR_CONNREQ:
 		nr_write_internal(sk, NR_CONNACK);
@@ -265,8 +258,6 @@
 	default:
 		break;
 	}
-	bh_unlock_sock(sk);
-
 	return queued;
 }
 
diff -Nru a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
--- a/net/xfrm/xfrm_state.c	2005-03-18 22:35:14 -08:00
+++ b/net/xfrm/xfrm_state.c	2005-03-18 22:35:14 -08:00
@@ -609,7 +609,7 @@
 
 	for (i = 0; i < XFRM_DST_HSIZE; i++) {
 		list_for_each_entry(x, xfrm_state_bydst+i, bydst) {
-			if (x->km.seq == seq) {
+			if (x->km.seq == seq && x->km.state == XFRM_STATE_ACQ) {
 				xfrm_state_hold(x);
 				return x;
 			}
diff -Nru a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
--- a/sound/pci/ac97/ac97_codec.c	2005-03-18 22:35:14 -08:00
+++ b/sound/pci/ac97/ac97_codec.c	2005-03-18 22:35:14 -08:00
@@ -1185,7 +1185,7 @@
 /*
  * create mute switch(es) for normal stereo controls
  */
-static int snd_ac97_cmute_new(snd_card_t *card, char *name, int reg, ac97_t *ac97)
+static int snd_ac97_cmute_new_stereo(snd_card_t *card, char *name, int reg, int check_stereo, ac97_t *ac97)
 {
 	snd_kcontrol_t *kctl;
 	int err;
@@ -1196,7 +1196,7 @@
 
 	mute_mask = 0x8000;
 	val = snd_ac97_read(ac97, reg);
-	if (ac97->flags & AC97_STEREO_MUTES) {
+	if (check_stereo || (ac97->flags & AC97_STEREO_MUTES)) {
 		/* check whether both mute bits work */
 		val1 = val | 0x8080;
 		snd_ac97_write(ac97, reg, val1);
@@ -1254,7 +1254,7 @@
 /*
  * create a mute-switch and a volume for normal stereo/mono controls
  */
-static int snd_ac97_cmix_new(snd_card_t *card, const char *pfx, int reg, ac97_t *ac97)
+static int snd_ac97_cmix_new_stereo(snd_card_t *card, const char *pfx, int reg, int check_stereo, ac97_t *ac97)
 {
 	int err;
 	char name[44];
@@ -1265,7 +1265,7 @@
 
 	if (snd_ac97_try_bit(ac97, reg, 15)) {
 		sprintf(name, "%s Switch", pfx);
-		if ((err = snd_ac97_cmute_new(card, name, reg, ac97)) < 0)
+		if ((err = snd_ac97_cmute_new_stereo(card, name, reg, check_stereo, ac97)) < 0)
 			return err;
 	}
 	check_volume_resolution(ac97, reg, &lo_max, &hi_max);
@@ -1277,6 +1277,8 @@
 	return 0;
 }
 
+#define snd_ac97_cmix_new(card, pfx, reg, ac97)	snd_ac97_cmix_new_stereo(card, pfx, reg, 0, ac97)
+#define snd_ac97_cmute_new(card, name, reg, ac97)	snd_ac97_cmute_new_stereo(card, name, reg, 0, ac97)
 
 static unsigned int snd_ac97_determine_spdif_rates(ac97_t *ac97);
 
@@ -1327,7 +1329,8 @@
 
 	/* build surround controls */
 	if (snd_ac97_try_volume_mix(ac97, AC97_SURROUND_MASTER)) {
-		if ((err = snd_ac97_cmix_new(card, "Surround Playback", AC97_SURROUND_MASTER, ac97)) < 0)
+		/* Surround Master (0x38) is with stereo mutes */
+		if ((err = snd_ac97_cmix_new_stereo(card, "Surround Playback", AC97_SURROUND_MASTER, 1, ac97)) < 0)
 			return err;
 	}
 
