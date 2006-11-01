Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945929AbWKAAk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945929AbWKAAk1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 19:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945941AbWKAAk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 19:40:27 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:50450 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1945929AbWKAAk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 19:40:26 -0500
Date: Wed, 1 Nov 2006 01:40:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Ed L. Cashin" <ecashin@coraid.com>
Cc: Alan Cox <alan@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-kernel@vger.kernel.org
Subject: [2.6.19 patch] drivers/block/aoe/aoedev.c: fix NULL dereference
Message-ID: <20061101004025.GY27968@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a NULL dereference introduced by
commit e407a7f6cd143b3ab4eb3d7e1cf882e96b710eb5:

This quite unusual error handling through a switch introduces NULL 
dereferences if exactly one of the two k{c,z}alloc's failed.

That wouldn't be unfixable, but considering that the Linux kernel is not 
part of the obfuscated C contest (and silent fallthroughs in switches do 
not improve readability) I've converted it to a normal error handling.

The NULL dereference was spotted by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/block/aoe/aoedev.c |   46 ++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

--- linux-2.6/drivers/block/aoe/aoedev.c.old	2006-10-31 23:56:46.000000000 +0100
+++ linux-2.6/drivers/block/aoe/aoedev.c	2006-11-01 00:23:49.000000000 +0100
@@ -64,30 +64,25 @@
 
 	d = kzalloc(sizeof *d, GFP_ATOMIC);
 	f = kcalloc(nframes, sizeof *f, GFP_ATOMIC);
- 	switch (!d || !f) {
- 	case 0:
- 		d->nframes = nframes;
- 		d->frames = f;
- 		e = f + nframes;
- 		for (; f<e; f++) {
- 			f->tag = FREETAG;
- 			f->skb = new_skb(ETH_ZLEN);
- 			if (!f->skb)
- 				break;
- 		}
- 		if (f == e)
- 			break;
- 		while (f > d->frames) {
- 			f--;
- 			dev_kfree_skb(f->skb);
- 		}
- 	default:
- 		if (f)
- 			kfree(f);
- 		if (d)
- 			kfree(d);
-		return NULL;
+
+ 	if (!d || !f)
+		goto out_err;
+
+	d->nframes = nframes;
+	d->frames = f;
+	e = f + nframes;
+	for (; f < e; f++) {
+		f->tag = FREETAG;
+		f->skb = new_skb(ETH_ZLEN);
+		if (!f->skb) {
+			while (f > d->frames) {
+				f--;
+				dev_kfree_skb(f->skb);
+			}
+			goto out_err;
+		}
 	}
+
 	INIT_WORK(&d->work, aoecmd_sleepwork, d);
 	spin_lock_init(&d->lock);
 	init_timer(&d->timer);
@@ -101,6 +96,11 @@
 	devlist = d;
 
 	return d;
+
+out_err:
+	kfree(f);
+	kfree(d);
+	return NULL;
 }
 
 void

