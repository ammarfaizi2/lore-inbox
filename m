Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262541AbVCXPKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbVCXPKP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 10:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbVCXPKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 10:10:15 -0500
Received: from geode.he.net ([216.218.230.98]:3854 "HELO noserose.net")
	by vger.kernel.org with SMTP id S262541AbVCXPJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 10:09:59 -0500
From: ecashin@noserose.net
Message-Id: <1111676997.25277@geode.he.net>
Date: Thu, 24 Mar 2005 07:09:57 -0800
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.11] aoe [2/12]: allow multiple aoe devices with same MAC addr
References: <87mztbi79d.fsf@coraid.com> <20050317234641.GA7091@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


allow multiple aoe devices with same MAC addr

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>

diff -uprN a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
--- a/drivers/block/aoe/aoe.h	2005-03-10 12:19:04.000000000 -0500
+++ b/drivers/block/aoe/aoe.h	2005-03-10 12:19:11.000000000 -0500
@@ -156,7 +156,7 @@ void aoecmd_cfg_rsp(struct sk_buff *);
 
 int aoedev_init(void);
 void aoedev_exit(void);
-struct aoedev *aoedev_bymac(unsigned char *);
+struct aoedev *aoedev_by_aoeaddr(int maj, int min);
 void aoedev_downdev(struct aoedev *d);
 struct aoedev *aoedev_set(ulong, unsigned char *, struct net_device *, ulong);
 int aoedev_busy(void);
diff -uprN a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
--- a/drivers/block/aoe/aoecmd.c	2005-03-10 12:19:04.000000000 -0500
+++ b/drivers/block/aoe/aoecmd.c	2005-03-10 12:19:11.000000000 -0500
@@ -380,14 +380,15 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 	register long n;
 	ulong flags;
 	char ebuf[128];
-	
+	u16 aoemajor;
+
 	hin = (struct aoe_hdr *) skb->mac.raw;
-	d = aoedev_bymac(hin->src);
+	aoemajor = __be16_to_cpu(*((u16 *) hin->major));
+	d = aoedev_by_aoeaddr(aoemajor, hin->minor);
 	if (d == NULL) {
 		snprintf(ebuf, sizeof ebuf, "aoecmd_ata_rsp: ata response "
 			"for unknown device %d.%d\n",
-			 __be16_to_cpu(*((u16 *) hin->major)),
-			hin->minor);
+			 aoemajor, hin->minor);
 		aoechr_error(ebuf);
 		return;
 	}
diff -uprN a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
--- a/drivers/block/aoe/aoedev.c	2005-03-07 17:37:14.000000000 -0500
+++ b/drivers/block/aoe/aoedev.c	2005-03-10 12:19:11.000000000 -0500
@@ -13,7 +13,7 @@ static struct aoedev *devlist;
 static spinlock_t devlist_lock;
 
 struct aoedev *
-aoedev_bymac(unsigned char *macaddr)
+aoedev_by_aoeaddr(int maj, int min)
 {
 	struct aoedev *d;
 	ulong flags;
@@ -21,7 +21,7 @@ aoedev_bymac(unsigned char *macaddr)
 	spin_lock_irqsave(&devlist_lock, flags);
 
 	for (d=devlist; d; d=d->next)
-		if (!memcmp(d->addr, macaddr, 6))
+		if (d->aoemajor == maj && d->aoeminor == min)
 			break;
 
 	spin_unlock_irqrestore(&devlist_lock, flags);
@@ -125,7 +125,6 @@ aoedev_set(ulong sysminor, unsigned char
 	d->ifp = ifp;
 
 	if (d->sysminor != sysminor
-	|| memcmp(d->addr, addr, sizeof d->addr)
 	|| (d->flags & DEVFL_UP) == 0) {
 		aoedev_downdev(d); /* flushes outstanding frames */
 		memcpy(d->addr, addr, sizeof d->addr);


-- 
  Ed L. Cashin <ecashin@coraid.com>
