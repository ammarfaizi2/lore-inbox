Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263448AbSITUCw>; Fri, 20 Sep 2002 16:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263450AbSITUCw>; Fri, 20 Sep 2002 16:02:52 -0400
Received: from mail.cogenit.fr ([195.68.53.173]:39135 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S263448AbSITUCs>;
	Fri, 20 Sep 2002 16:02:48 -0400
Date: Fri, 20 Sep 2002 22:07:48 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.37 - xtime to do_gettimeofday() in drivers/atm/*c
Message-ID: <20020920220748.A14520@fafner.intra.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

  simple xtime to do_gettimeofday() as indicated in the subject.

Please apply.

diff -urpN linux-2.5.37.orig/drivers/atm/ambassador.c linux-2.5.37/drivers/atm/ambassador.c
--- linux-2.5.37.orig/drivers/atm/ambassador.c	Fri Sep 20 20:45:33 2002
+++ linux-2.5.37/drivers/atm/ambassador.c	Fri Sep 20 21:30:04 2002
@@ -516,7 +516,7 @@ static void rx_complete (amb_dev * dev, 
 	  
 	  // VC layer stats
 	  atomic_inc(&atm_vcc->stats->rx);
-	  skb->stamp = xtime;
+	  do_gettimeofday(&skb->stamp);
 	  // end of our responsability
 	  atm_vcc->push (atm_vcc, skb);
 	  return;
diff -urpN linux-2.5.37.orig/drivers/atm/atmtcp.c linux-2.5.37/drivers/atm/atmtcp.c
--- linux-2.5.37.orig/drivers/atm/atmtcp.c	Fri Sep 20 20:45:33 2002
+++ linux-2.5.37/drivers/atm/atmtcp.c	Fri Sep 20 21:32:19 2002
@@ -275,7 +275,7 @@ static int atmtcp_c_send(struct atm_vcc 
 		result = -ENOBUFS;
 		goto done;
 	}
-	new_skb->stamp = xtime;
+	do_gettimeofday(&new_skb->stamp);
 	memcpy(skb_put(new_skb,skb->len),skb->data,skb->len);
 	out_vcc->push(out_vcc,new_skb);
 	atomic_inc(&vcc->stats->tx);
diff -urpN linux-2.5.37.orig/drivers/atm/eni.c linux-2.5.37/drivers/atm/eni.c
--- linux-2.5.37.orig/drivers/atm/eni.c	Fri Sep 20 20:45:33 2002
+++ linux-2.5.37/drivers/atm/eni.c	Fri Sep 20 21:27:03 2002
@@ -702,7 +702,7 @@ static void get_service(struct atm_dev *
 			DPRINTK("Grr, servicing VCC %ld twice\n",vci);
 			continue;
 		}
-		ENI_VCC(vcc)->timestamp = xtime;
+		do_gettimeofday(&ENI_VCC(vcc)->timestamp);
 		ENI_VCC(vcc)->next = NULL;
 		if (vcc->qos.rxtp.traffic_class == ATM_CBR) {
 			if (eni_dev->fast)
diff -urpN linux-2.5.37.orig/drivers/atm/fore200e.c linux-2.5.37/drivers/atm/fore200e.c
--- linux-2.5.37.orig/drivers/atm/fore200e.c	Fri Sep 20 20:45:33 2002
+++ linux-2.5.37/drivers/atm/fore200e.c	Fri Sep 20 21:30:55 2002
@@ -1134,7 +1134,8 @@ fore200e_push_rpd(struct fore200e* fore2
 	return;
     } 
 
-    skb->stamp = vcc->timestamp = xtime;
+	do_gettimeofday(&vcc->timestamp);
+    skb->stamp = vcc->timestamp;
     
 #ifdef FORE200E_52BYTE_AAL0_SDU
     if (cell_header) {
diff -urpN linux-2.5.37.orig/drivers/atm/horizon.c linux-2.5.37/drivers/atm/horizon.c
--- linux-2.5.37.orig/drivers/atm/horizon.c	Fri Sep 20 20:45:33 2002
+++ linux-2.5.37/drivers/atm/horizon.c	Fri Sep 20 21:31:10 2002
@@ -1049,7 +1049,7 @@ static void rx_schedule (hrz_dev * dev, 
 	  struct atm_vcc * vcc = ATM_SKB(skb)->vcc;
 	  // VC layer stats
 	  atomic_inc(&vcc->stats->rx);
-	  skb->stamp = xtime;
+	  do_gettimeofday(&skb->stamp);
 	  // end of our responsability
 	  vcc->push (vcc, skb);
 	}
diff -urpN linux-2.5.37.orig/drivers/atm/idt77252.c linux-2.5.37/drivers/atm/idt77252.c
--- linux-2.5.37.orig/drivers/atm/idt77252.c	Fri Sep 20 20:45:33 2002
+++ linux-2.5.37/drivers/atm/idt77252.c	Fri Sep 20 21:32:52 2002
@@ -1099,7 +1099,7 @@ dequeue_rx(struct idt77252_dev *card, st
 			       cell, ATM_CELL_PAYLOAD);
 
 			ATM_SKB(sb)->vcc = vcc;
-			sb->stamp = xtime;
+			do_gettimeofday(&sb->stamp);
 			vcc->push(vcc, sb);
 			atomic_inc(&vcc->stats->rx);
 
@@ -1177,7 +1177,7 @@ dequeue_rx(struct idt77252_dev *card, st
 
 			skb_trim(skb, len);
 			ATM_SKB(skb)->vcc = vcc;
-			skb->stamp = xtime;
+			do_gettimeofday(&skb->stamp);
 
 			vcc->push(vcc, skb);
 			atomic_inc(&vcc->stats->rx);
@@ -1199,7 +1199,7 @@ dequeue_rx(struct idt77252_dev *card, st
 
 		skb_trim(skb, len);
 		ATM_SKB(skb)->vcc = vcc;
-		skb->stamp = xtime;
+		do_gettimeofday(&skb->stamp);
 
 		vcc->push(vcc, skb);
 		atomic_inc(&vcc->stats->rx);
@@ -1337,7 +1337,7 @@ idt77252_rx_raw(struct idt77252_dev *car
 		       ATM_CELL_PAYLOAD);
 
 		ATM_SKB(sb)->vcc = vcc;
-		sb->stamp = xtime;
+		do_gettimeofday(&sb->stamp);
 		vcc->push(vcc, sb);
 		atomic_inc(&vcc->stats->rx);
 
diff -urpN linux-2.5.37.orig/drivers/atm/lanai.c linux-2.5.37/drivers/atm/lanai.c
--- linux-2.5.37.orig/drivers/atm/lanai.c	Fri Sep 20 20:45:33 2002
+++ linux-2.5.37/drivers/atm/lanai.c	Fri Sep 20 21:31:39 2002
@@ -1606,7 +1606,7 @@ static void vcc_rx_aal5(struct lanai_vcc
 	}
 	skb_put(skb, size);
 	ATM_SKB(skb)->vcc = lvcc->rx.atmvcc;
-	skb->stamp = xtime;
+	do_gettimeofday(&skb->stamp);
 	vcc_rx_memcpy(skb->data, lvcc, size);
 	lvcc->rx.atmvcc->push(lvcc->rx.atmvcc, skb);
 	atomic_inc(&lvcc->rx.atmvcc->stats->rx);
diff -urpN linux-2.5.37.orig/drivers/atm/nicstar.c linux-2.5.37/drivers/atm/nicstar.c
--- linux-2.5.37.orig/drivers/atm/nicstar.c	Fri Sep 20 20:45:33 2002
+++ linux-2.5.37/drivers/atm/nicstar.c	Fri Sep 20 21:29:37 2002
@@ -2264,7 +2264,7 @@ static void dequeue_rx(ns_dev *card, ns_
          memcpy(sb->tail, cell, ATM_CELL_PAYLOAD);
          skb_put(sb, ATM_CELL_PAYLOAD);
          ATM_SKB(sb)->vcc = vcc;
-         sb->stamp = xtime;
+         do_gettimeofday(&sb->stamp);
          vcc->push(vcc, sb);
          atomic_inc(&vcc->stats->rx);
          cell += ATM_CELL_PAYLOAD;
@@ -2395,7 +2395,7 @@ static void dequeue_rx(ns_dev *card, ns_
             skb->destructor = ns_sb_destructor;
 #endif /* NS_USE_DESTRUCTORS */
             ATM_SKB(skb)->vcc = vcc;
-            skb->stamp = xtime;
+            do_gettimeofday(&skb->stamp);
             vcc->push(vcc, skb);
             atomic_inc(&vcc->stats->rx);
          }
@@ -2422,7 +2422,7 @@ static void dequeue_rx(ns_dev *card, ns_
                sb->destructor = ns_sb_destructor;
 #endif /* NS_USE_DESTRUCTORS */
                ATM_SKB(sb)->vcc = vcc;
-               sb->stamp = xtime;
+               do_gettimeofday(&sb->stamp);
                vcc->push(vcc, sb);
                atomic_inc(&vcc->stats->rx);
             }
@@ -2448,7 +2448,7 @@ static void dequeue_rx(ns_dev *card, ns_
                memcpy(skb->data, sb->data, NS_SMBUFSIZE);
                skb_put(skb, len - NS_SMBUFSIZE);
                ATM_SKB(skb)->vcc = vcc;
-               skb->stamp = xtime;
+               do_gettimeofday(&skb->stamp);
                vcc->push(vcc, skb);
                atomic_inc(&vcc->stats->rx);
             }
@@ -2554,7 +2554,7 @@ static void dequeue_rx(ns_dev *card, ns_
 #ifdef NS_USE_DESTRUCTORS
             hb->destructor = ns_hb_destructor;
 #endif /* NS_USE_DESTRUCTORS */
-            hb->stamp = xtime;
+            do_gettimeofday(&hb->stamp);
             vcc->push(vcc, hb);
             atomic_inc(&vcc->stats->rx);
          }
diff -urpN linux-2.5.37.orig/drivers/atm/zatm.c linux-2.5.37/drivers/atm/zatm.c
--- linux-2.5.37.orig/drivers/atm/zatm.c	Fri Sep 20 20:45:33 2002
+++ linux-2.5.37/drivers/atm/zatm.c	Fri Sep 20 21:31:55 2002
@@ -584,7 +584,7 @@ EVENT("error code 0x%x/0x%x\n",(here[3] 
 #ifdef CONFIG_ATM_ZATM_EXACT_TS
 		skb->stamp = exact_time(zatm_dev,here[1]);
 #else
-		skb->stamp = xtime;
+		do_gettimeofday(&skb->stamp);
 #endif
 #if 0
 printk("[-3..0] 0x%08lx 0x%08lx 0x%08lx 0x%08lx\n",((unsigned *) skb->data)[-3],
