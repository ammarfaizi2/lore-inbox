Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbSLTQhY>; Fri, 20 Dec 2002 11:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262620AbSLTQhY>; Fri, 20 Dec 2002 11:37:24 -0500
Received: from host194.steeleye.com ([66.206.164.34]:38155 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S262492AbSLTQhW>; Fri, 20 Dec 2002 11:37:22 -0500
Message-Id: <200212201645.gBKGjJQ03941@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] Enable checking of reap of in-use slab
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_14187960620"
Date: Fri, 20 Dec 2002 10:45:19 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_14187960620
Content-Type: text/plain; charset=us-ascii

Hi Marcelo,

On older (2.4.9) kernels, we keep running into the occasional attempts to reap 
in-use slabs.  The checks for this were compiled out on 2.4.10 and above in 
the name of efficiency.

I'd like to add the checks just for the in use parts back just to make 
assurances doubly sure that this bug is actually fixed, not just obscured.  
The changes use the BUG_ON macro, so the actual debugging stuff is in the 
unlikely branch which shouldn't impact the critical path too much.

Please consider applying for 2.4.22

Thanks,

James


--==_Exmh_14187960620
Content-Type: text/plain ; name="tmp.diff"; charset=us-ascii
Content-Description: tmp.diff
Content-Disposition: attachment; filename="tmp.diff"

===== mm/slab.c 1.21 vs edited =====
--- 1.21/mm/slab.c	Mon Dec 16 00:22:20 2002
+++ edited/mm/slab.c	Fri Dec 20 10:33:02 2002
@@ -928,10 +928,9 @@
 			break;
 
 		slabp = list_entry(cachep->slabs_free.prev, slab_t, list);
-#if DEBUG
-		if (slabp->inuse)
-			BUG();
-#endif
+
+		BUG_ON(slabp->inuse);
+
 		list_del(&slabp->list);
 
 		spin_unlock_irq(&cachep->spinlock);
@@ -1785,10 +1784,9 @@
 		p = searchp->slabs_free.next;
 		while (p != &searchp->slabs_free) {
 			slabp = list_entry(p, slab_t, list);
-#if DEBUG
-			if (slabp->inuse)
-				BUG();
-#endif
+
+			BUG_ON(slabp->inuse);
+
 			full_free++;
 			p = p->next;
 		}
@@ -1838,10 +1836,9 @@
 		if (p == &best_cachep->slabs_free)
 			break;
 		slabp = list_entry(p,slab_t,list);
-#if DEBUG
-		if (slabp->inuse)
-			BUG();
-#endif
+
+		BUG_ON(slabp->inuse);
+
 		list_del(&slabp->list);
 		STATS_INC_REAPED(best_cachep);
 

--==_Exmh_14187960620--


