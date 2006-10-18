Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422832AbWJRUN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422832AbWJRUN1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422861AbWJRUJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:09:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:33002 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422836AbWJRUJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:31 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: "Ed L. Cashin" <ecashin@coraid.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 8/15] aoe: improve retransmission heuristics
Date: Wed, 18 Oct 2006 13:08:59 -0700
Message-Id: <1161202171977-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <11612021682148-git-send-email-greg@kroah.com>
References: <20061018200433.GA10079@kroah.com> <11612021463993-git-send-email-greg@kroah.com> <11612021491255-git-send-email-greg@kroah.com> <1161202152750-git-send-email-greg@kroah.com> <11612021563910-git-send-email-greg@kroah.com> <11612021601016-git-send-email-greg@kroah.com> <11612021641240-git-send-email-greg@kroah.com> <11612021682148-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed L. Cashin <ecashin@coraid.com>

Add a dynamic minimum timer for better retransmission behavior.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
Acked-by: Alan Cox <alan@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/block/aoe/aoe.h    |    7 ++++---
 drivers/block/aoe/aoecmd.c |   16 +++++++++++++---
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
index 4d79f1e..7b11217 100644
--- a/drivers/block/aoe/aoe.h
+++ b/drivers/block/aoe/aoe.h
@@ -125,8 +125,10 @@ struct aoedev {
 	ulong sysminor;
 	ulong aoemajor;
 	ulong aoeminor;
-	ulong nopen;		/* (bd_openers isn't available without sleeping) */
-	ulong rttavg;		/* round trip average of requests/responses */
+	u16 nopen;		/* (bd_openers isn't available without sleeping) */
+	u16 lasttag;		/* last tag sent */
+	u16 rttavg;		/* round trip average of requests/responses */
+	u16 mintimer;
 	u16 fw_ver;		/* version of blade's firmware */
 	u16 maxbcnt;
 	struct work_struct work;/* disk create work struct */
@@ -142,7 +144,6 @@ struct aoedev {
 	mempool_t *bufpool;	/* for deadlock-free Buf allocation */
 	struct list_head bufq;	/* queue of bios to work on */
 	struct buf *inprocess;	/* the one we're currently working on */
-	ulong lasttag;		/* last tag sent */
 	ushort lostjumbo;
 	ushort nframes;		/* number of frames below */
 	struct frame *frames;
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 621fdbb..c0bdc1f 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -461,8 +461,15 @@ calc_rttavg(struct aoedev *d, int rtt)
 	register long n;
 
 	n = rtt;
-	if (n < MINTIMER)
-		n = MINTIMER;
+	if (n < 0) {
+		n = -rtt;
+		if (n < MINTIMER)
+			n = MINTIMER;
+		else if (n > MAXTIMER)
+			n = MAXTIMER;
+		d->mintimer += (n - d->mintimer) >> 1;
+	} else if (n < d->mintimer)
+		n = d->mintimer;
 	else if (n > MAXTIMER)
 		n = MAXTIMER;
 
@@ -498,8 +505,10 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 
 	spin_lock_irqsave(&d->lock, flags);
 
-	f = getframe(d, be32_to_cpu(hin->tag));
+	n = be32_to_cpu(hin->tag);
+	f = getframe(d, n);
 	if (f == NULL) {
+		calc_rttavg(d, -tsince(n));
 		spin_unlock_irqrestore(&d->lock, flags);
 		snprintf(ebuf, sizeof ebuf,
 			"%15s e%d.%d    tag=%08x@%08lx\n",
@@ -724,6 +733,7 @@ aoecmd_cfg_rsp(struct sk_buff *skb)
 		return;
 	}
 	d->flags |= DEVFL_PAUSE;	/* force pause */
+	d->mintimer = MINTIMER;
 	d->fw_ver = be16_to_cpu(ch->fwver);
 
 	/* check for already outstanding ataid */
-- 
1.4.2.4

