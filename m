Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWGTTQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWGTTQc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 15:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWGTTQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 15:16:32 -0400
Received: from student.uhasselt.be ([193.190.2.1]:52748 "EHLO
	student.uhasselt.be") by vger.kernel.org with ESMTP id S964852AbWGTTQb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 15:16:31 -0400
Date: Thu, 20 Jul 2006 21:16:29 +0200
To: linux-kernel@vger.kernel.org
Cc: paulus@samba.org, linux-ppp@vger.kernel.org
Subject: [PATCH] Missing failure handling
Message-ID: <20060720191629.GD7643@lumumba.uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: takis@lumumba.uhasselt.be (Panagiotis Issaris)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Panagiotis Issaris <takis@issaris.org>

The PPP code contains two kmalloc()s followed by memset()s without
handling a possible memory allocation failure. (Suggested by 
Joe Perches).

And furthermore, conversions from kmalloc+memset to kzalloc.

Signed-off-by: Panagiotis Issaris <takis@issaris.org>
---
 drivers/net/ppp_generic.c |   34 +++++++++++++++++++++++-----------
 1 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ppp_generic.c b/drivers/net/ppp_generic.c
index 0ec6e9d..7b27ac8 100644
--- a/drivers/net/ppp_generic.c
+++ b/drivers/net/ppp_generic.c
@@ -192,7 +192,7 @@ struct cardmap {
 	void *ptr[CARDMAP_WIDTH];
 };
 static void *cardmap_get(struct cardmap *map, unsigned int nr);
-static void cardmap_set(struct cardmap **map, unsigned int nr, void *ptr);
+static int cardmap_set(struct cardmap **map, unsigned int nr, void *ptr);
 static unsigned int cardmap_find_first_free(struct cardmap *map);
 static void cardmap_destroy(struct cardmap **map);
 
@@ -1995,10 +1995,9 @@ ppp_register_channel(struct ppp_channel 
 {
 	struct channel *pch;
 
-	pch = kmalloc(sizeof(struct channel), GFP_KERNEL);
+	pch = kzalloc(sizeof(struct channel), GFP_KERNEL);
 	if (pch == 0)
 		return -ENOMEM;
-	memset(pch, 0, sizeof(struct channel));
 	pch->ppp = NULL;
 	pch->chan = chan;
 	chan->ppp = pch;
@@ -2408,13 +2407,12 @@ ppp_create_interface(int unit, int *retp
 	int ret = -ENOMEM;
 	int i;
 
-	ppp = kmalloc(sizeof(struct ppp), GFP_KERNEL);
+	ppp = kzalloc(sizeof(struct ppp), GFP_KERNEL);
 	if (!ppp)
 		goto out;
 	dev = alloc_netdev(0, "", ppp_setup);
 	if (!dev)
 		goto out1;
-	memset(ppp, 0, sizeof(struct ppp));
 
 	ppp->mru = PPP_MRU;
 	init_ppp_file(&ppp->file, INTERFACE);
@@ -2454,11 +2452,18 @@ #endif /* CONFIG_PPP_MULTILINK */
 	}
 
 	atomic_inc(&ppp_unit_count);
-	cardmap_set(&all_ppp_units, unit, ppp);
+	ret = cardmap_set(&all_ppp_units, unit, ppp);
+	if (ret != 0) {
+		printk(KERN_ERR "PPP: couldn't set cardmap\n");	
+		goto out3;
+	}
+
 	mutex_unlock(&all_ppp_mutex);
 	*retp = 0;
 	return ppp;
 
+out3:
+	atomic_dec(&ppp_unit_count);
 out2:
 	mutex_unlock(&all_ppp_mutex);
 	free_netdev(dev);
@@ -2695,7 +2700,7 @@ static void *cardmap_get(struct cardmap 
 	return NULL;
 }
 
-static void cardmap_set(struct cardmap **pmap, unsigned int nr, void *ptr)
+static int cardmap_set(struct cardmap **pmap, unsigned int nr, void *ptr)
 {
 	struct cardmap *p;
 	int i;
@@ -2704,8 +2709,11 @@ static void cardmap_set(struct cardmap *
 	if (p == NULL || (nr >> p->shift) >= CARDMAP_WIDTH) {
 		do {
 			/* need a new top level */
-			struct cardmap *np = kmalloc(sizeof(*np), GFP_KERNEL);
-			memset(np, 0, sizeof(*np));
+			struct cardmap *np = kzalloc(sizeof(*np), GFP_KERNEL);
+			if (!np) {
+				printk(KERN_ERR "PPP: no memory (cardmap)\n");
+				return -ENOMEM;
+			}
 			np->ptr[0] = p;
 			if (p != NULL) {
 				np->shift = p->shift + CARDMAP_ORDER;
@@ -2719,8 +2727,11 @@ static void cardmap_set(struct cardmap *
 	while (p->shift > 0) {
 		i = (nr >> p->shift) & CARDMAP_MASK;
 		if (p->ptr[i] == NULL) {
-			struct cardmap *np = kmalloc(sizeof(*np), GFP_KERNEL);
-			memset(np, 0, sizeof(*np));
+			struct cardmap *np = kzalloc(sizeof(*np), GFP_KERNEL);
+			if (!np) {
+				printk(KERN_ERR "PPP: no memory (cardmap)\n");
+				return -ENOMEM;
+			}
 			np->shift = p->shift - CARDMAP_ORDER;
 			np->parent = p;
 			p->ptr[i] = np;
@@ -2735,6 +2746,7 @@ static void cardmap_set(struct cardmap *
 		set_bit(i, &p->inuse);
 	else
 		clear_bit(i, &p->inuse);
+	return 0;
 }
 
 static unsigned int cardmap_find_first_free(struct cardmap *map)
-- 
1.4.2.rc1.ge7a0-dirty

