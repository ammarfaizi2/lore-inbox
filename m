Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262562AbVCXPWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbVCXPWG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 10:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbVCXPWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 10:22:05 -0500
Received: from geode.he.net ([216.218.230.98]:25615 "HELO noserose.net")
	by vger.kernel.org with SMTP id S262562AbVCXPTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 10:19:25 -0500
From: ecashin@noserose.net
Message-Id: <1111677562.28909@geode.he.net>
Date: Thu, 24 Mar 2005 07:19:22 -0800
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.11] aoe [6/12]: Alexey Dobriyan sparse cleanup
References: <87mztbi79d.fsf@coraid.com> <20050317234641.GA7091@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alexey Dobriyan sparse cleanup

Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>
Signed-off-by: Ed L. Cashin <ecashin@coraid.com>

diff -uprN a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
--- a/drivers/block/aoe/aoe.h	2005-03-10 12:19:14.000000000 -0500
+++ b/drivers/block/aoe/aoe.h	2005-03-10 12:19:27.000000000 -0500
@@ -39,13 +39,13 @@ enum {
 struct aoe_hdr {
 	unsigned char dst[6];
 	unsigned char src[6];
-	unsigned char type[2];
+	__be16 type;
 	unsigned char verfl;
 	unsigned char err;
-	unsigned char major[2];
+	__be16 major;
 	unsigned char minor;
 	unsigned char cmd;
-	unsigned char tag[4];
+	__be32 tag;
 };
 
 struct aoe_atahdr {
@@ -63,8 +63,8 @@ struct aoe_atahdr {
 };
 
 struct aoe_cfghdr {
-	unsigned char bufcnt[2];
-	unsigned char fwver[2];
+	__be16 bufcnt;
+	__be16 fwver;
 	unsigned char res;
 	unsigned char aoeccmd;
 	unsigned char cslen[2];
diff -uprN a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
--- a/drivers/block/aoe/aoecmd.c	2005-03-10 12:19:11.000000000 -0500
+++ b/drivers/block/aoe/aoecmd.c	2005-03-10 12:19:27.000000000 -0500
@@ -90,19 +90,16 @@ newtag(struct aoedev *d)
 static int
 aoehdr_atainit(struct aoedev *d, struct aoe_hdr *h)
 {
-	u16 type = __constant_cpu_to_be16(ETH_P_AOE);
-	u16 aoemajor = __cpu_to_be16(d->aoemajor);
 	u32 host_tag = newtag(d);
-	u32 tag = __cpu_to_be32(host_tag);
 
 	memcpy(h->src, d->ifp->dev_addr, sizeof h->src);
 	memcpy(h->dst, d->addr, sizeof h->dst);
-	memcpy(h->type, &type, sizeof type);
+	h->type = __constant_cpu_to_be16(ETH_P_AOE);
 	h->verfl = AOE_HVER;
-	memcpy(h->major, &aoemajor, sizeof aoemajor);
+	h->major = cpu_to_be16(d->aoemajor);
 	h->minor = d->aoeminor;
 	h->cmd = AOECMD_ATA;
-	memcpy(h->tag, &tag, sizeof tag);
+	h->tag = cpu_to_be32(host_tag);
 
 	return host_tag;
 }
@@ -215,7 +212,6 @@ rexmit(struct aoedev *d, struct frame *f
 	struct aoe_hdr *h;
 	char buf[128];
 	u32 n;
-	u32 net_tag;
 
 	n = newtag(d);
 
@@ -227,8 +223,7 @@ rexmit(struct aoedev *d, struct frame *f
 
 	h = (struct aoe_hdr *) f->data;
 	f->tag = n;
-	net_tag = __cpu_to_be32(n);
-	memcpy(h->tag, &net_tag, sizeof net_tag);
+	h->tag = cpu_to_be32(n);
 
 	skb = skb_prepare(d, f);
 	if (skb) {
@@ -308,16 +303,16 @@ ataid_complete(struct aoedev *d, unsigne
 	u16 n;
 
 	/* word 83: command set supported */
-	n = __le16_to_cpu(*((u16 *) &id[83<<1]));
+	n = le16_to_cpup((__le16 *) &id[83<<1]);
 
 	/* word 86: command set/feature enabled */
-	n |= __le16_to_cpu(*((u16 *) &id[86<<1]));
+	n |= le16_to_cpup((__le16 *) &id[86<<1]);
 
 	if (n & (1<<10)) {	/* bit 10: LBA 48 */
 		d->flags |= DEVFL_EXT;
 
 		/* word 100: number lba48 sectors */
-		ssize = __le64_to_cpu(*((u64 *) &id[100<<1]));
+		ssize = le64_to_cpup((__le64 *) &id[100<<1]);
 
 		/* set as in ide-disk.c:init_idedisk_capacity */
 		d->geo.cylinders = ssize;
@@ -328,12 +323,12 @@ ataid_complete(struct aoedev *d, unsigne
 		d->flags &= ~DEVFL_EXT;
 
 		/* number lba28 sectors */
-		ssize = __le32_to_cpu(*((u32 *) &id[60<<1]));
+		ssize = le32_to_cpup((__le32 *) &id[60<<1]);
 
 		/* NOTE: obsolete in ATA 6 */
-		d->geo.cylinders = __le16_to_cpu(*((u16 *) &id[54<<1]));
-		d->geo.heads = __le16_to_cpu(*((u16 *) &id[55<<1]));
-		d->geo.sectors = __le16_to_cpu(*((u16 *) &id[56<<1]));
+		d->geo.cylinders = le16_to_cpup((__le16 *) &id[54<<1]);
+		d->geo.heads = le16_to_cpup((__le16 *) &id[55<<1]);
+		d->geo.sectors = le16_to_cpup((__le16 *) &id[56<<1]);
 	}
 	d->ssize = ssize;
 	d->geo.start = 0;
@@ -383,7 +378,7 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 	u16 aoemajor;
 
 	hin = (struct aoe_hdr *) skb->mac.raw;
-	aoemajor = __be16_to_cpu(*((u16 *) hin->major));
+	aoemajor = be16_to_cpu(hin->major);
 	d = aoedev_by_aoeaddr(aoemajor, hin->minor);
 	if (d == NULL) {
 		snprintf(ebuf, sizeof ebuf, "aoecmd_ata_rsp: ata response "
@@ -395,15 +390,15 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 
 	spin_lock_irqsave(&d->lock, flags);
 
-	f = getframe(d, __be32_to_cpu(*((u32 *) hin->tag)));
+	f = getframe(d, be32_to_cpu(hin->tag));
 	if (f == NULL) {
 		spin_unlock_irqrestore(&d->lock, flags);
 		snprintf(ebuf, sizeof ebuf,
 			"%15s e%d.%d    tag=%08x@%08lx\n",
 			"unexpected rsp",
-			__be16_to_cpu(*((u16 *) hin->major)),
+			be16_to_cpu(hin->major),
 			hin->minor,
-			__be32_to_cpu(*((u32 *) hin->tag)),
+			be32_to_cpu(hin->tag),
 			jiffies);
 		aoechr_error(ebuf);
 		return;
@@ -453,7 +448,7 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 			printk(KERN_INFO "aoe: aoecmd_ata_rsp: unrecognized "
 			       "outbound ata command %2.2Xh for %d.%d\n", 
 			       ahout->cmdstat,
-			       __be16_to_cpu(*((u16 *) hin->major)),
+			       be16_to_cpu(hin->major),
 			       hin->minor);
 		}
 	}
@@ -487,8 +482,6 @@ aoecmd_cfg(ushort aoemajor, unsigned cha
 	struct aoe_cfghdr *ch;
 	struct sk_buff *skb, *sl;
 	struct net_device *ifp;
-	u16 aoe_type = __constant_cpu_to_be16(ETH_P_AOE);
-	u16 net_aoemajor = __cpu_to_be16(aoemajor);
 
 	sl = NULL;
 
@@ -508,9 +501,9 @@ aoecmd_cfg(ushort aoemajor, unsigned cha
 
 		memset(h->dst, 0xff, sizeof h->dst);
 		memcpy(h->src, ifp->dev_addr, sizeof h->src);
-		memcpy(h->type, &aoe_type, sizeof aoe_type);
+		h->type = __constant_cpu_to_be16(ETH_P_AOE);
 		h->verfl = AOE_HVER;
-		memcpy(h->major, &net_aoemajor, sizeof net_aoemajor);
+		h->major = cpu_to_be16(aoemajor);
 		h->minor = aoeminor;
 		h->cmd = AOECMD_CFG;
 
@@ -576,7 +569,8 @@ aoecmd_cfg_rsp(struct sk_buff *skb)
 	struct aoedev *d;
 	struct aoe_hdr *h;
 	struct aoe_cfghdr *ch;
-	ulong flags, bufcnt, sysminor, aoemajor;
+	ulong flags, sysminor, aoemajor;
+	u16 bufcnt;
 	struct sk_buff *sl;
 	enum { MAXFRAMES = 8 };
 
@@ -587,7 +581,7 @@ aoecmd_cfg_rsp(struct sk_buff *skb)
 	 * Enough people have their dip switches set backwards to
 	 * warrant a loud message for this special case.
 	 */
-	aoemajor = __be16_to_cpu(*((u16 *) h->major));
+	aoemajor = be16_to_cpu(h->major);
 	if (aoemajor == 0xfff) {
 		printk(KERN_CRIT "aoe: aoecmd_cfg_rsp: Warning: shelf "
 			"address is all ones.  Check shelf dip switches\n");
@@ -602,7 +596,7 @@ aoecmd_cfg_rsp(struct sk_buff *skb)
 		return;
 	}
 
-	bufcnt = __be16_to_cpu(*((u16 *) ch->bufcnt));
+	bufcnt = be16_to_cpu(ch->bufcnt);
 	if (bufcnt > MAXFRAMES)	/* keep it reasonable */
 		bufcnt = MAXFRAMES;
 
@@ -619,7 +613,7 @@ aoecmd_cfg_rsp(struct sk_buff *skb)
 		return;
 	}
 
-	d->fw_ver = __be16_to_cpu(*((u16 *) ch->fwver));
+	d->fw_ver = be16_to_cpu(ch->fwver);
 
 	/* we get here only if the device is new */
 	sl = aoecmd_ata_id(d);
diff -uprN a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
--- a/drivers/block/aoe/aoenet.c	2005-03-07 17:37:14.000000000 -0500
+++ b/drivers/block/aoe/aoenet.c	2005-03-10 12:19:27.000000000 -0500
@@ -69,7 +69,7 @@ set_aoe_iflist(const char __user *user_s
 u64
 mac_addr(char addr[6])
 {
-	u64 n = 0;
+	__be64 n = 0;
 	char *p = (char *) &n;
 
 	memcpy(p + 2, addr, 6);	/* (sizeof addr != 6) */
@@ -108,7 +108,7 @@ static int
 aoenet_rcv(struct sk_buff *skb, struct net_device *ifp, struct packet_type *pt)
 {
 	struct aoe_hdr *h;
-	ulong n;
+	u32 n;
 
 	skb = skb_check(skb);
 	if (!skb)
@@ -121,7 +121,7 @@ aoenet_rcv(struct sk_buff *skb, struct n
 	skb_push(skb, ETH_HLEN);	/* (1) */
 
 	h = (struct aoe_hdr *) skb->mac.raw;
-	n = __be32_to_cpu(*((u32 *) h->tag));
+	n = be32_to_cpu(h->tag);
 	if ((h->verfl & AOEFL_RSP) == 0 || (n & 1<<31))
 		goto exit;
 
@@ -132,7 +132,7 @@ aoenet_rcv(struct sk_buff *skb, struct n
 		if (net_ratelimit())
 			printk(KERN_ERR "aoe: aoenet_rcv: error packet from %d.%d; "
 			       "ecode=%d '%s'\n",
-			       __be16_to_cpu(*((u16 *) h->major)), h->minor, 
+			       be16_to_cpu(h->major), h->minor, 
 			       h->err, aoe_errlist[n]);
 		goto exit;
 	}


-- 
  Ed L. Cashin <ecashin@coraid.com>
