Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269520AbUH0CYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269520AbUH0CYG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 22:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269510AbUHZUJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:09:24 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:54243 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S269559AbUHZUCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:02:15 -0400
Date: Thu, 26 Aug 2004 22:02:02 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, irda-users@lists.sourceforge.net
Subject: [2.4 patch][4/6] irlmp.c: fix gcc 3.4 compilation
Message-ID: <20040826200202.GF12772@fs.tum.de>
References: <20040826195133.GB12772@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826195133.GB12772@fs.tum.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error when trying to build 2.4.28-pre2 using
gcc 3.4:


<--  snip  -->

...
gcc-3.4 -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.28-pre2-full/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon 
-fno-unit-at-a-time   -nostdinc -iwithprefix include 
-DKBUILD_BASENAME=irlmp  -c -o irlmp.o irlmp.c
irlmp.c: In function `irlmp_flow_indication':
irlmp.c:1244: error: parse error before "__FUNCTION__"
irlmp.c:1258: error: parse error before "__FUNCTION__"
irlmp.c:1277: error: parse error before "__FUNCTION__"
irlmp.c:1284: error: parse error before "__FUNCTION__"
make[3]: *** [irlmp.o] Error 1
make[3]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.28-pre2-full/net/irda'

<--  snip  -->


The patch below fixes this issue (similar to how it was done in 2.6).


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.4.28-pre2-full/net/irda/irlmp.c.old	2004-08-26 19:36:09.000000000 +0200
+++ linux-2.4.28-pre2-full/net/irda/irlmp.c	2004-08-26 19:38:48.000000000 +0200
@@ -1241,7 +1241,7 @@
 	/* Get the number of lsap. That's the only safe way to know
 	 * that we have looped around... - Jean II */
 	lsap_todo = HASHBIN_GET_SIZE(self->lsaps);
-	IRDA_DEBUG(4, __FUNCTION__ "() : %d lsaps to scan\n", lsap_todo);
+	IRDA_DEBUG(4, "%s() : %d lsaps to scan\n", __FUNCTION__ , lsap_todo);
 
 	/* Poll lsap in order until the queue is full or until we
 	 * tried them all.
@@ -1255,7 +1255,7 @@
 			/* Note that if there is only one LSAP on the LAP
 			 * (most common case), self->flow_next is always NULL,
 			 * so we always avoid this loop. - Jean II */
-			IRDA_DEBUG(4, __FUNCTION__ "() : searching my LSAP\n");
+			IRDA_DEBUG(4, "%s() : searching my LSAP\n", __FUNCTION__ );
 
 			/* We look again in hashbins, because the lsap
 			 * might have gone away... - Jean II */
@@ -1274,14 +1274,14 @@
 
 		/* Next time, we will get the next one (or the first one) */
 		self->flow_next = (struct lsap_cb *) hashbin_get_next(self->lsaps);
-		IRDA_DEBUG(4, __FUNCTION__ "() : curr is %p, next was %p and is now %p, still %d to go - queue len = %d\n", curr, next, self->flow_next, lsap_todo, IRLAP_GET_TX_QUEUE_LEN(self->irlap));
+		IRDA_DEBUG(4, "%s() : curr is %p, next was %p and is now %p, still %d to go - queue len = %d\n", __FUNCTION__ , curr, next, self->flow_next, lsap_todo, IRLAP_GET_TX_QUEUE_LEN(self->irlap));
 
 		/* Inform lsap user that it can send one more packet. */
 		if (curr->notify.flow_indication != NULL)
 			curr->notify.flow_indication(curr->notify.instance, 
 						     curr, flow);
 		else
-			IRDA_DEBUG(1, __FUNCTION__ "(), no handler\n");
+			IRDA_DEBUG(1, "%s(), no handler\n", __FUNCTION__ );
 	}
 }
 
