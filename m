Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbVE0JH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbVE0JH5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 05:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbVE0JHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 05:07:20 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:40878 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S262391AbVE0JCI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 05:02:08 -0400
Date: Fri, 27 May 2005 11:03:45 +0200
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: [patch 7/10] s390: qeth bug fixes
Message-ID: <20050527090345.GG8213@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Frank Pavlic <pavlic@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[patch 7/10] s390: qeth bug fixes.

From: Frank Pavlic <pavlic@de.ibm.com>

qeth network driver changes:
 - Removed redundant code, use the same qeth_fill_buffer_frag
   for TSO path either
 - Using skb->frags solely is not correct since skb->data still
   points to the beginning of the whole data, even when it is
   a small portion we have to fill the qdio buffer with it.

Signed-off-by: Frank Pavlic <pavlic@de.ibm.com>

diffstat:
 drivers/s390/net/qeth.h      |   13 +++++++
 drivers/s390/net/qeth_eddp.c |   15 +--------
 drivers/s390/net/qeth_main.c |   49 ++---------------------------
 drivers/s390/net/qeth_tso.c  |   49 ++++++-----------------------
 drivers/s390/net/qeth_tso.h  |   71 +++++++++++++++++++++++++++++++++++--------
 5 files changed, 86 insertions(+), 111 deletions(-)

diff -urpN linux-2.6/drivers/s390/net/qeth_eddp.c linux-2.6-patched/drivers/s390/net/qeth_eddp.c
--- linux-2.6/drivers/s390/net/qeth_eddp.c	2005-05-06 11:25:57.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth_eddp.c	2005-05-06 11:26:14.000000000 +0200
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_eddp.c ($Revision: 1.11 $)
+ * linux/drivers/s390/net/qeth_eddp.c ($Revision: 1.12 $)
  *
  * Enhanced Device Driver Packing (EDDP) support for the qeth driver.
  *
@@ -8,7 +8,7 @@
  *
  *    Author(s): Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.11 $	 $Date: 2005/03/24 09:04:18 $
+ *    $Revision: 1.12 $	 $Date: 2005/04/01 21:40:40 $
  *
  */
 #include <linux/config.h>
@@ -202,17 +202,6 @@ out:
 	return flush_cnt;
 }
 
-static inline int
-qeth_get_skb_data_len(struct sk_buff *skb)
-{
-	int len = skb->len;
-	int i;
-
-	for (i = 0; i < skb_shinfo(skb)->nr_frags; ++i)
-		len -= skb_shinfo(skb)->frags[i].size;
-	return len;
-}
-
 static inline void
 qeth_eddp_create_segment_hdrs(struct qeth_eddp_context *ctx,
 			      struct qeth_eddp_data *eddp)
diff -urpN linux-2.6/drivers/s390/net/qeth.h linux-2.6-patched/drivers/s390/net/qeth.h
--- linux-2.6/drivers/s390/net/qeth.h	2005-05-06 11:25:57.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth.h	2005-05-06 11:26:14.000000000 +0200
@@ -24,7 +24,7 @@
 
 #include "qeth_mpc.h"
 
-#define VERSION_QETH_H 		"$Revision: 1.135 $"
+#define VERSION_QETH_H 		"$Revision: 1.136 $"
 
 #ifdef CONFIG_QETH_IPV6
 #define QETH_VERSION_IPV6 	":IPv6"
@@ -866,6 +866,17 @@ qeth_push_skb(struct qeth_card *card, st
         return hdr;
 }
 
+static inline int
+qeth_get_skb_data_len(struct sk_buff *skb)
+{
+	int len = skb->len;
+	int i;
+
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; ++i)
+		len -= skb_shinfo(skb)->frags[i].size;
+	return len;
+}
+
 inline static int
 qeth_get_hlen(__u8 link_type)
 {
diff -urpN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-patched/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	2005-05-06 11:25:57.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth_main.c	2005-05-06 11:26:14.000000000 +0200
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.206 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.207 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.206 $	 $Date: 2005/03/24 09:04:18 $
+ *    $Revision: 1.207 $	 $Date: 2005/04/01 21:40:40 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -80,7 +80,7 @@ qeth_eyecatcher(void)
 #include "qeth_eddp.h"
 #include "qeth_tso.h"
 
-#define VERSION_QETH_C "$Revision: 1.206 $"
+#define VERSION_QETH_C "$Revision: 1.207 $"
 static const char *version = "qeth S/390 OSA-Express driver";
 
 /**
@@ -3894,47 +3894,6 @@ qeth_fill_header(struct qeth_card *card,
 }
 
 static inline void
-__qeth_fill_buffer_frag(struct sk_buff *skb, struct qdio_buffer *buffer,
-			int *next_element_to_fill)
-{
-	int length = skb->len;
-	struct skb_frag_struct *frag;
-	int fragno;
-	unsigned long addr;
-	int element;
-	int first_lap = 1;
-
-	fragno = skb_shinfo(skb)->nr_frags; /* start with last frag */
-	element = *next_element_to_fill + fragno;
-	while (length > 0) {
-		if (fragno > 0) {
-			frag = &skb_shinfo(skb)->frags[fragno - 1];
-			addr = (page_to_pfn(frag->page) << PAGE_SHIFT) +
-				frag->page_offset;
-			buffer->element[element].addr = (char *)addr;
-			buffer->element[element].length = frag->size;
-			length -= frag->size;
-			if (first_lap)
-				buffer->element[element].flags =
-				    SBAL_FLAGS_LAST_FRAG;
-			else
-				buffer->element[element].flags =
-				    SBAL_FLAGS_MIDDLE_FRAG;
-		} else {
-			buffer->element[element].addr = skb->data;
-			buffer->element[element].length = length;
-			length = 0;
-			buffer->element[element].flags =
-				SBAL_FLAGS_FIRST_FRAG;
-		}
-		element--;
-		fragno--;
-		first_lap = 0;
-	}
-	*next_element_to_fill += skb_shinfo(skb)->nr_frags + 1;
-}
-
-static inline void
 __qeth_fill_buffer(struct sk_buff *skb, struct qdio_buffer *buffer,
 		   int *next_element_to_fill)
 {
@@ -3991,7 +3950,7 @@ qeth_fill_buffer(struct qeth_qdio_out_q 
 		__qeth_fill_buffer(skb, buffer,
 				   (int *)&buf->next_element_to_fill);
 	else
-		__qeth_fill_buffer_frag(skb, buffer,
+		__qeth_fill_buffer_frag(skb, buffer, 0,
 					(int *)&buf->next_element_to_fill);
 
 	if (!queue->do_pack) {
diff -urpN linux-2.6/drivers/s390/net/qeth_tso.c linux-2.6-patched/drivers/s390/net/qeth_tso.c
--- linux-2.6/drivers/s390/net/qeth_tso.c	2005-05-06 11:25:57.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth_tso.c	2005-05-06 11:26:14.000000000 +0200
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/s390/net/qeth_tso.c ($Revision: 1.6 $)
+ * linux/drivers/s390/net/qeth_tso.c ($Revision: 1.7 $)
  *
  * Header file for qeth TCP Segmentation Offload support.
  *
@@ -7,7 +7,7 @@
  *
  *    Author(s): Frank Pavlic <pavlic@de.ibm.com>
  *
- *    $Revision: 1.6 $	 $Date: 2005/03/24 09:04:18 $
+ *    $Revision: 1.7 $	 $Date: 2005/04/01 21:40:41 $
  *
  */
 
@@ -144,38 +144,6 @@ qeth_tso_get_queue_buffer(struct qeth_qd
 	return flush_cnt;
 }
 
-static inline void
-__qeth_tso_fill_buffer_frag(struct qeth_qdio_out_buffer *buf,
-			  struct sk_buff *skb)
-{
-	struct skb_frag_struct *frag;
-	struct qdio_buffer *buffer;
-	int fragno, cnt, element;
-	unsigned long addr;
-
-        QETH_DBF_TEXT(trace, 6, "tsfilfrg");
-
-	/*initialize variables ...*/
-	fragno = skb_shinfo(skb)->nr_frags;
-	buffer = buf->buffer;
-	element = buf->next_element_to_fill;
-	/*fill buffer elements .....*/
-	for (cnt = 0; cnt < fragno; cnt++) {
-		frag = &skb_shinfo(skb)->frags[cnt];
-		addr = (page_to_pfn(frag->page) << PAGE_SHIFT) +
-			frag->page_offset;
-		buffer->element[element].addr = (char *)addr;
-		buffer->element[element].length = frag->size;
-		if (cnt < (fragno - 1))
-			buffer->element[element].flags =
-				SBAL_FLAGS_MIDDLE_FRAG;
-		else
-			buffer->element[element].flags =
-				SBAL_FLAGS_LAST_FRAG;
-		element++;
-	}
-	buf->next_element_to_fill = element;
-}
 
 static inline int
 qeth_tso_fill_buffer(struct qeth_qdio_out_buffer *buf,
@@ -205,19 +173,22 @@ qeth_tso_fill_buffer(struct qeth_qdio_ou
 	buffer->element[element].length = hdr_len;
 	buffer->element[element].flags = SBAL_FLAGS_FIRST_FRAG;
 	buf->next_element_to_fill++;
-
+	/*check if we have frags ...*/
 	if (skb_shinfo(skb)->nr_frags > 0) {
-                 __qeth_tso_fill_buffer_frag(buf, skb);
+		skb->len = length;
+		skb->data = data;
+                 __qeth_fill_buffer_frag(skb, buffer,1,
+					(int *)&buf->next_element_to_fill);
                  goto out;
         }
 
-       /*start filling buffer entries ...*/
+       /*... if not, use this */
         element++;
         while (length > 0) {
                 /* length_here is the remaining amount of data in this page */
 		length_here = PAGE_SIZE - ((unsigned long) data % PAGE_SIZE);
 		if (length < length_here)
-                        length_here = length;
+			length_here = length;
                 buffer->element[element].addr = data;
                 buffer->element[element].length = length_here;
                 length -= length_here;
@@ -230,9 +201,9 @@ qeth_tso_fill_buffer(struct qeth_qdio_ou
                 data += length_here;
                 element++;
         }
-        /*set the buffer to primed  ...*/
         buf->next_element_to_fill = element;
 out:
+        /*prime buffer now  ...*/
 	atomic_set(&buf->state, QETH_QDIO_BUF_PRIMED);
         return 1;
 }
diff -urpN linux-2.6/drivers/s390/net/qeth_tso.h linux-2.6-patched/drivers/s390/net/qeth_tso.h
--- linux-2.6/drivers/s390/net/qeth_tso.h	2005-05-06 11:25:57.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth_tso.h	2005-05-06 11:26:14.000000000 +0200
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/s390/net/qeth_tso.h ($Revision: 1.4 $)
+ * linux/drivers/s390/net/qeth_tso.h ($Revision: 1.5 $)
  *
  * Header file for qeth TCP Segmentation Offload support.
  *
@@ -7,7 +7,7 @@
  *
  *    Author(s): Frank Pavlic <pavlic@de.ibm.com>
  *
- *    $Revision: 1.4 $	 $Date: 2005/03/24 09:04:18 $
+ *    $Revision: 1.5 $	 $Date: 2005/04/01 21:40:41 $
  *
  */
 #ifndef __QETH_TSO_H__
@@ -37,22 +37,67 @@ struct qeth_hdr_tso {
 } __attribute__ ((packed));
 
 /*some helper functions*/
-
 static inline int
 qeth_get_elements_no(struct qeth_card *card, void *hdr, struct sk_buff *skb)
 {
 	int elements_needed = 0;
 
-	if (skb_shinfo(skb)->nr_frags > 0)
-		elements_needed = (skb_shinfo(skb)->nr_frags + 1);
-	if (elements_needed == 0 )
-		elements_needed = 1 + (((((unsigned long) hdr) % PAGE_SIZE)
-					+ skb->len) >> PAGE_SHIFT);
-	if (elements_needed > QETH_MAX_BUFFER_ELEMENTS(card)){
-		PRINT_ERR("qeth_do_send_packet: invalid size of "
-			  "IP packet. Discarded.");
-		return 0;
+        if (skb_shinfo(skb)->nr_frags > 0)
+                elements_needed = (skb_shinfo(skb)->nr_frags + 1);
+        if (elements_needed == 0 )
+                elements_needed = 1 + (((((unsigned long) hdr) % PAGE_SIZE)
+                                        + skb->len) >> PAGE_SHIFT);
+        if (elements_needed > QETH_MAX_BUFFER_ELEMENTS(card)){
+                PRINT_ERR("qeth_do_send_packet: invalid size of "
+                          "IP packet. Discarded.");
+                return 0;
+        }
+        return elements_needed;
+}
+
+static inline void
+__qeth_fill_buffer_frag(struct sk_buff *skb, struct qdio_buffer *buffer,
+			int is_tso, int *next_element_to_fill)
+{
+	int length = skb->len;
+	struct skb_frag_struct *frag;
+	int fragno;
+	unsigned long addr;
+	int element;
+	int first_lap = 1;
+
+	fragno = skb_shinfo(skb)->nr_frags; /* start with last frag */
+	element = *next_element_to_fill + fragno;
+	while (length > 0) {
+		if (fragno > 0) {
+			frag = &skb_shinfo(skb)->frags[fragno - 1];
+			addr = (page_to_pfn(frag->page) << PAGE_SHIFT) +
+				frag->page_offset;
+			buffer->element[element].addr = (char *)addr;
+			buffer->element[element].length = frag->size;
+			length -= frag->size;
+			if (first_lap)
+				buffer->element[element].flags =
+				    SBAL_FLAGS_LAST_FRAG;
+			else
+				buffer->element[element].flags =
+				    SBAL_FLAGS_MIDDLE_FRAG;
+		} else {
+			buffer->element[element].addr = skb->data;
+			buffer->element[element].length = length;
+			length = 0;
+			if (is_tso)
+				buffer->element[element].flags =
+					SBAL_FLAGS_MIDDLE_FRAG;
+			else
+				buffer->element[element].flags =
+					SBAL_FLAGS_FIRST_FRAG;
+		}
+		element--;
+		fragno--;
+		first_lap = 0;
 	}
-	return elements_needed;
+	*next_element_to_fill += skb_shinfo(skb)->nr_frags + 1;
 }
+
 #endif /* __QETH_TSO_H__ */
