Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311965AbSCXVHe>; Sun, 24 Mar 2002 16:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312027AbSCXVHY>; Sun, 24 Mar 2002 16:07:24 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:17612 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S311965AbSCXVHP>;
	Sun, 24 Mar 2002 16:07:15 -0500
Date: Sun, 24 Mar 2002 22:06:22 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Maksim Krasnyanskiy <maxk@qualcomm.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
        marcelo Tosatti <marcelo@conectiva.com.br>, Alan@lxorguk.ukuu.org.uk,
        cell@sch.bme.hu, linux-atm-general@lists.sourceforge.net
Subject: Re: [PATCH] Updated ATM patch for 2.4.19-pre4
Message-ID: <20020324220622.A1054@fafner.intra.cogenit.fr>
In-Reply-To: <5.1.0.14.2.20020322170653.0337b970@mail1.qualcomm.com> <20020323221058.B15111@fafner.intra.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[thread starts at:
http://www.cs.Helsinki.FI/linux/linux-kernel/2002-11/1311.html]

The following patch applies on top of Maksim's one. It:
- adds a missing include (hunk #1);
- turns a cast fiesta into the equivalent list_entry (hunk #2);
- unregisters net_device once it isn't needed for bridging (hunk #3);
- compiles and stands a kill-br2684ctl-before-ifconfig-down test: nas0 
  disappeared as it should.

Without the patch an oops happens, see:
<URL:http://www.cogenit.fr/linux/atm/oopses/text-6>

Comments welcome.

--- net/atm/br2684.c.orig	Sat Mar 23 21:21:41 2002
+++ net/atm/br2684.c	Sun Mar 24 21:42:30 2002
@@ -15,6 +15,7 @@ Author: Marcell GAL, 2000, XDSL Ltd, Hun
 #include <linux/etherdevice.h>
 #include <net/arp.h>
 #include <linux/rtnetlink.h>
+#include <linux/ip.h>
 #include <linux/atmbr2684.h>
 
 #include "ipcommon.h"
@@ -97,8 +98,7 @@ static LIST_HEAD(br2684_devs);
 
 static inline struct br2684_dev *BRPRIV(const struct net_device *net_dev)
 {
-	return (struct br2684_dev *) ((char *) (net_dev) -
-	    (unsigned long) (&((struct br2684_dev *) 0)->net_dev));
+	return list_entry(net_dev, struct br2684_dev, net_dev);
 }
 
 static inline struct br2684_dev *list_entry_brdev(const struct list_head *le)
@@ -410,6 +410,13 @@ static void br2684_push(struct atm_vcc *
 
 	if (skb == NULL) {	/* skb==NULL means VCC is being destroyed */
 		br2684_close_vcc(brvcc);
+		if (list_empty(&brdev->brvccs)) {
+			read_lock(&devs_lock);
+			list_del(&brdev->br2684_devs);
+			read_unlock(&devs_lock);
+			unregister_netdev(&brdev->net_dev);
+			kfree(brdev);
+		}
 		return;
 	}
 
-- 
Ueimor
