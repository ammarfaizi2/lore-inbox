Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263583AbSIQEUD>; Tue, 17 Sep 2002 00:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263585AbSIQEUD>; Tue, 17 Sep 2002 00:20:03 -0400
Received: from [63.205.85.133] ([63.205.85.133]:33804 "EHLO schmee.sfgoth.com")
	by vger.kernel.org with ESMTP id <S263583AbSIQEUB>;
	Tue, 17 Sep 2002 00:20:01 -0400
Date: Mon, 16 Sep 2002 21:23:31 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Adrian Bunk <bunk@fs.tum.de>, torvalds@transmeta.com
Cc: fokkensr@fokkensr.vertis.nl,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.35 atm driver compile fix
Message-ID: <20020916212331.B70462@sfgoth.com>
References: <Pine.LNX.4.33.0209151926330.10806-100000@penguin.transmeta.com> <Pine.NEB.4.44.0209161347591.14886-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.NEB.4.44.0209161347591.14886-100000@mimas.fachschaften.tu-muenchen.de>; from bunk@fs.tum.de on Mon, Sep 16, 2002 at 01:52:53PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This change results in a compile error in the ATM drivers:

Yes, this was a bug in the ATM drivers... they really should have been using
do_gettimeofday() instead of touching xtime anyway.

Here's a patch that should fix up all these ATM compile errors.  Linus,
please apply

-Mitch  (deadbeat ATM maintainer)

diff -u -r linux-2.5.35-VIRGIN/drivers/atm/ambassador.c linux-2.5.35/drivers/atm/ambassador.c
--- linux-2.5.35-VIRGIN/drivers/atm/ambassador.c	2002-08-24 00:08:21.000000000 -0700
+++ linux-2.5.35/drivers/atm/ambassador.c	2002-09-16 21:03:56.000000000 -0700
@@ -516,7 +516,7 @@
 	  
 	  // VC layer stats
 	  atomic_inc(&atm_vcc->stats->rx);
-	  skb->stamp = xtime;
+	  do_gettimeofday(&skb->stamp);
 	  // end of our responsability
 	  atm_vcc->push (atm_vcc, skb);
 	  return;
diff -u -r linux-2.5.35-VIRGIN/drivers/atm/atmtcp.c linux-2.5.35/drivers/atm/atmtcp.c
--- linux-2.5.35-VIRGIN/drivers/atm/atmtcp.c	2002-08-24 00:08:21.000000000 -0700
+++ linux-2.5.35/drivers/atm/atmtcp.c	2002-09-16 21:04:30.000000000 -0700
@@ -275,7 +275,7 @@
 		result = -ENOBUFS;
 		goto done;
 	}
-	new_skb->stamp = xtime;
+	do_gettimeofday(&new_skb->stamp);
 	memcpy(skb_put(new_skb,skb->len),skb->data,skb->len);
 	out_vcc->push(out_vcc,new_skb);
 	atomic_inc(&vcc->stats->tx);
diff -u -r linux-2.5.35-VIRGIN/drivers/atm/eni.c linux-2.5.35/drivers/atm/eni.c
--- linux-2.5.35-VIRGIN/drivers/atm/eni.c	2002-08-24 00:08:21.000000000 -0700
+++ linux-2.5.35/drivers/atm/eni.c	2002-09-16 21:04:45.000000000 -0700
@@ -702,7 +702,7 @@
 			DPRINTK("Grr, servicing VCC %ld twice\n",vci);
 			continue;
 		}
-		ENI_VCC(vcc)->timestamp = xtime;
+		do_gettimeofday(&ENI_VCC(vcc)->timestamp);
 		ENI_VCC(vcc)->next = NULL;
 		if (vcc->qos.rxtp.traffic_class == ATM_CBR) {
 			if (eni_dev->fast)
diff -u -r linux-2.5.35-VIRGIN/drivers/atm/firestream.c linux-2.5.35/drivers/atm/firestream.c
--- linux-2.5.35-VIRGIN/drivers/atm/firestream.c	2002-08-24 00:08:21.000000000 -0700
+++ linux-2.5.35/drivers/atm/firestream.c	2002-09-16 21:04:55.000000000 -0700
@@ -814,7 +814,7 @@
 				skb_put (skb, qe->p1 & 0xffff); 
 				ATM_SKB(skb)->vcc = atm_vcc;
 				atomic_inc(&atm_vcc->stats->rx);
-				skb->stamp = xtime;
+				do_gettimeofday(&skb->stamp);
 				fs_dprintk (FS_DEBUG_ALLOC, "Free rec-skb: %p (pushed)\n", skb);
 				atm_vcc->push (atm_vcc, skb);
 				fs_dprintk (FS_DEBUG_ALLOC, "Free rec-d: %p\n", pe);
diff -u -r linux-2.5.35-VIRGIN/drivers/atm/fore200e.c linux-2.5.35/drivers/atm/fore200e.c
--- linux-2.5.35-VIRGIN/drivers/atm/fore200e.c	2002-08-24 00:08:21.000000000 -0700
+++ linux-2.5.35/drivers/atm/fore200e.c	2002-09-16 21:05:24.000000000 -0700
@@ -1134,7 +1134,8 @@
 	return;
     } 
 
-    skb->stamp = vcc->timestamp = xtime;
+    do_gettimeofday(&skb->stamp);
+    vcc->timestamp = skb->stamp;
     
 #ifdef FORE200E_52BYTE_AAL0_SDU
     if (cell_header) {
diff -u -r linux-2.5.35-VIRGIN/drivers/atm/horizon.c linux-2.5.35/drivers/atm/horizon.c
--- linux-2.5.35-VIRGIN/drivers/atm/horizon.c	2002-08-24 00:08:21.000000000 -0700
+++ linux-2.5.35/drivers/atm/horizon.c	2002-09-16 21:05:36.000000000 -0700
@@ -1049,7 +1049,7 @@
 	  struct atm_vcc * vcc = ATM_SKB(skb)->vcc;
 	  // VC layer stats
 	  atomic_inc(&vcc->stats->rx);
-	  skb->stamp = xtime;
+	  do_gettimeofday(&skb->stamp);
 	  // end of our responsability
 	  vcc->push (vcc, skb);
 	}
diff -u -r linux-2.5.35-VIRGIN/drivers/atm/idt77252.c linux-2.5.35/drivers/atm/idt77252.c
--- linux-2.5.35-VIRGIN/drivers/atm/idt77252.c	2002-08-24 00:08:21.000000000 -0700
+++ linux-2.5.35/drivers/atm/idt77252.c	2002-09-16 21:06:40.000000000 -0700
@@ -1099,7 +1099,7 @@
 			       cell, ATM_CELL_PAYLOAD);
 
 			ATM_SKB(sb)->vcc = vcc;
-			sb->stamp = xtime;
+			do_gettimeofday(&sb->stamp);
 			vcc->push(vcc, sb);
 			atomic_inc(&vcc->stats->rx);
 
@@ -1177,7 +1177,7 @@
 
 			skb_trim(skb, len);
 			ATM_SKB(skb)->vcc = vcc;
-			skb->stamp = xtime;
+			do_gettimeofday(&skb->stamp);
 
 			vcc->push(vcc, skb);
 			atomic_inc(&vcc->stats->rx);
@@ -1199,7 +1199,7 @@
 
 		skb_trim(skb, len);
 		ATM_SKB(skb)->vcc = vcc;
-		skb->stamp = xtime;
+		do_gettimeofday(&skb->stamp);
 
 		vcc->push(vcc, skb);
 		atomic_inc(&vcc->stats->rx);
@@ -1337,7 +1337,7 @@
 		       ATM_CELL_PAYLOAD);
 
 		ATM_SKB(sb)->vcc = vcc;
-		sb->stamp = xtime;
+		do_gettimeofday(&sb->stamp);
 		vcc->push(vcc, sb);
 		atomic_inc(&vcc->stats->rx);
 
diff -u -r linux-2.5.35-VIRGIN/drivers/atm/lanai.c linux-2.5.35/drivers/atm/lanai.c
--- linux-2.5.35-VIRGIN/drivers/atm/lanai.c	2002-08-24 00:08:21.000000000 -0700
+++ linux-2.5.35/drivers/atm/lanai.c	2002-09-16 21:06:54.000000000 -0700
@@ -1606,7 +1606,7 @@
 	}
 	skb_put(skb, size);
 	ATM_SKB(skb)->vcc = lvcc->rx.atmvcc;
-	skb->stamp = xtime;
+	do_gettimeofday(&skb->stamp);
 	vcc_rx_memcpy(skb->data, lvcc, size);
 	lvcc->rx.atmvcc->push(lvcc->rx.atmvcc, skb);
 	atomic_inc(&lvcc->rx.atmvcc->stats->rx);
diff -u -r linux-2.5.35-VIRGIN/drivers/atm/nicstar.c linux-2.5.35/drivers/atm/nicstar.c
--- linux-2.5.35-VIRGIN/drivers/atm/nicstar.c	2002-08-24 00:08:21.000000000 -0700
+++ linux-2.5.35/drivers/atm/nicstar.c	2002-09-16 21:15:15.000000000 -0700
@@ -2264,7 +2264,7 @@
          memcpy(sb->tail, cell, ATM_CELL_PAYLOAD);
          skb_put(sb, ATM_CELL_PAYLOAD);
          ATM_SKB(sb)->vcc = vcc;
-         sb->stamp = xtime;
+         do_gettimeofday(&sb->stamp);
          vcc->push(vcc, sb);
          atomic_inc(&vcc->stats->rx);
          cell += ATM_CELL_PAYLOAD;
@@ -2395,7 +2395,7 @@
             skb->destructor = ns_sb_destructor;
 #endif /* NS_USE_DESTRUCTORS */
             ATM_SKB(skb)->vcc = vcc;
-            skb->stamp = xtime;
+            do_gettimeofday(&skb->stamp);
             vcc->push(vcc, skb);
             atomic_inc(&vcc->stats->rx);
          }
@@ -2422,7 +2422,7 @@
                sb->destructor = ns_sb_destructor;
 #endif /* NS_USE_DESTRUCTORS */
                ATM_SKB(sb)->vcc = vcc;
-               sb->stamp = xtime;
+               do_gettimeofday(&sb->stamp);
                vcc->push(vcc, sb);
                atomic_inc(&vcc->stats->rx);
             }
@@ -2448,7 +2448,7 @@
                memcpy(skb->data, sb->data, NS_SMBUFSIZE);
                skb_put(skb, len - NS_SMBUFSIZE);
                ATM_SKB(skb)->vcc = vcc;
-               skb->stamp = xtime;
+               do_gettimeofday(&skb->stamp);
                vcc->push(vcc, skb);
                atomic_inc(&vcc->stats->rx);
             }
@@ -2554,7 +2554,7 @@
 #ifdef NS_USE_DESTRUCTORS
             hb->destructor = ns_hb_destructor;
 #endif /* NS_USE_DESTRUCTORS */
-            hb->stamp = xtime;
+            do_gettimeofday(&hb->stamp);
             vcc->push(vcc, hb);
             atomic_inc(&vcc->stats->rx);
          }
diff -u -r linux-2.5.35-VIRGIN/drivers/atm/zatm.c linux-2.5.35/drivers/atm/zatm.c
--- linux-2.5.35-VIRGIN/drivers/atm/zatm.c	2002-08-24 00:08:21.000000000 -0700
+++ linux-2.5.35/drivers/atm/zatm.c	2002-09-16 21:08:40.000000000 -0700
@@ -584,7 +584,7 @@
 #ifdef CONFIG_ATM_ZATM_EXACT_TS
 		skb->stamp = exact_time(zatm_dev,here[1]);
 #else
-		skb->stamp = xtime;
+		do_gettimeofday(&skb->stamp);
 #endif
 #if 0
 printk("[-3..0] 0x%08lx 0x%08lx 0x%08lx 0x%08lx\n",((unsigned *) skb->data)[-3],
