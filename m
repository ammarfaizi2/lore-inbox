Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbTELLXq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 07:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbTELLXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 07:23:46 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:44527 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S262105AbTELLXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 07:23:41 -0400
Date: Mon, 12 May 2003 04:36:18 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: linux-kernel@vger.kernel.org, ppp@samba.org
Subject: [PATCH] 2.4.20/2.5.69 ppp_generic kmalloc()!=NULL check
Message-ID: <20030512043618.B29781@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In ppp_generic.c:cardmap_set(), the return value from 2 kmalloc() calls
are not checked.

/fc

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cardmap_set.patch"

--- linux-2.4.20/drivers/net/ppp_generic.c.orig	Fri Apr 25 02:02:14 2003
+++ linux-2.4.20/drivers/net/ppp_generic.c	Fri Apr 25 02:21:36 2003
@@ -2270,17 +2270,20 @@ ppp_create_interface(int unit, int *retp
 	dev->priv = ppp;
 	dev->features |= NETIF_F_DYNALLOC;
 
+	if (ret = cardmap_set(&all_ppp_units, unit, ppp))
+		goto err_unlock;
+
 	rtnl_lock();
 	ret = register_netdevice(dev);
 	rtnl_unlock();
 	if (ret != 0) {
 		printk(KERN_ERR "PPP: couldn't register device %s (%d)\n",
 		       dev->name, ret);
+		cardmap_set(&all_ppp_units, unit, NULL))
 		goto err_unlock;
 	}
 
 	atomic_inc(&ppp_unit_count);
-	cardmap_set(&all_ppp_units, unit, ppp);
 	up(&all_ppp_sem);
 	*retp = 0;
 	return ppp;
@@ -2542,6 +2545,8 @@ static void cardmap_set(struct cardmap *
 		do {
 			/* need a new top level */
 			struct cardmap *np = kmalloc(sizeof(*np), GFP_KERNEL);
+			if (np == 0)
+				return -ENOMEM;
 			memset(np, 0, sizeof(*np));
 			np->ptr[0] = p;
 			if (p != NULL) {
@@ -2557,6 +2562,8 @@ static void cardmap_set(struct cardmap *
 		i = (nr >> p->shift) & CARDMAP_MASK;
 		if (p->ptr[i] == NULL) {
 			struct cardmap *np = kmalloc(sizeof(*np), GFP_KERNEL);
+			if (np == 0)
+				return -ENOMEM;
 			memset(np, 0, sizeof(*np));
 			np->shift = p->shift - CARDMAP_ORDER;
 			np->parent = p;

--5mCyUwZo2JvN/JJP--
