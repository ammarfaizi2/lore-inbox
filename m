Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266833AbUGLNjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266833AbUGLNjy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 09:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266831AbUGLNjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 09:39:54 -0400
Received: from magic.adaptec.com ([216.52.22.17]:28602 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S266833AbUGLNij convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 09:38:39 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [2.6 patch] SCSI ips: remove inlines
Date: Mon, 12 Jul 2004 09:38:36 -0400
Message-ID: <A121ABA5B472B74EB59076B8E3C8F019549416@rtpe2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] SCSI ips: remove inlines
Thread-Index: AcRmFCnbto88zWr9R+6mqYCv5XsvEAB/6UDw
From: "IpsLinux" <ipslinux@Adaptec.com>
To: "Adrian Bunk" <bunk@fs.tum.de>
Cc: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian,

FYI ... Your ips patch has been applied to the current development code
stream at Adaptec.
Thanks for the heads-up.

IpsLinux Support

 

-----Original Message-----
From: Adrian Bunk [mailto:bunk@fs.tum.de] 
Sent: Friday, July 09, 2004 8:24 PM
To: IpsLinux
Cc: linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org
Subject: [2.6 patch] SCSI ips: remove inlines

Trying to compile drivers/scsi/ips.c with gcc 3.4 and
  # define inline         __inline__ __attribute__((always_inline))
results in the following error:

<--  snip  -->

...
  CC      drivers/scsi/ips.o
drivers/scsi/ips.c: In function `ips_eh_abort':
drivers/scsi/ips.c:490: sorry, unimplemented: inlining failed in call to
'ips_removeq_copp': function body not available
drivers/scsi/ips.c:843: sorry, unimplemented: called from here
drivers/scsi/ips.c:488: sorry, unimplemented: inlining failed in call to
'ips_removeq_wait': function body not available
drivers/scsi/ips.c:847: sorry, unimplemented: called from here
make[2]: *** [drivers/scsi/ips.o] Error 1

<--  snip  -->


The patch below removes all inlines from ips.c. As a side effect, this
showed that 3 formerly inlined functions are completely unused which are
also removed in the patch.

An alternative approach to removing the inlines would be to keep all
inlines that are _really_ required and reorder the functions in the file
accordingly.


diffstat output:
 drivers/scsi/ips.c |  130 ++++++---------------------------------------
 1 files changed, 19 insertions(+), 111 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm6-full-gcc3.4/drivers/scsi/ips.c.old	2004-07-09
01:12:30.000000000 +0200
+++ linux-2.6.7-mm6-full-gcc3.4/drivers/scsi/ips.c	2004-07-09
01:24:02.000000000 +0200
@@ -474,21 +474,17 @@
 static uint32_t ips_statupd_copperhead_memio(ips_ha_t *);  static
uint32_t ips_statupd_morpheus(ips_ha_t *);  static ips_scb_t
*ips_getscb(ips_ha_t *); -static inline void
ips_putq_scb_head(ips_scb_queue_t *, ips_scb_t *); -static inline void
ips_putq_scb_tail(ips_scb_queue_t *, ips_scb_t *); -static inline void
ips_putq_wait_head(ips_wait_queue_t *, Scsi_Cmnd *); -static inline void
ips_putq_wait_tail(ips_wait_queue_t *, Scsi_Cmnd *); -static inline void
ips_putq_copp_head(ips_copp_queue_t *,
+static void ips_putq_scb_head(ips_scb_queue_t *, ips_scb_t *); static 
+void ips_putq_wait_tail(ips_wait_queue_t *, Scsi_Cmnd *); static void 
+ips_putq_copp_tail(ips_copp_queue_t *,
 				      ips_copp_wait_item_t *);
-static inline void ips_putq_copp_tail(ips_copp_queue_t *,
-				      ips_copp_wait_item_t *);
-static inline ips_scb_t *ips_removeq_scb_head(ips_scb_queue_t *);
-static inline ips_scb_t *ips_removeq_scb(ips_scb_queue_t *, ips_scb_t
*); -static inline Scsi_Cmnd *ips_removeq_wait_head(ips_wait_queue_t *);
-static inline Scsi_Cmnd *ips_removeq_wait(ips_wait_queue_t *, Scsi_Cmnd
*); -static inline ips_copp_wait_item_t
*ips_removeq_copp(ips_copp_queue_t *,
+static ips_scb_t *ips_removeq_scb_head(ips_scb_queue_t *); static 
+ips_scb_t *ips_removeq_scb(ips_scb_queue_t *, ips_scb_t *); static 
+Scsi_Cmnd *ips_removeq_wait_head(ips_wait_queue_t *); static Scsi_Cmnd 
+*ips_removeq_wait(ips_wait_queue_t *, Scsi_Cmnd *); static 
+ips_copp_wait_item_t *ips_removeq_copp(ips_copp_queue_t *,
 
ips_copp_wait_item_t *);
-static inline ips_copp_wait_item_t
*ips_removeq_copp_head(ips_copp_queue_t *);
+static ips_copp_wait_item_t *ips_removeq_copp_head(ips_copp_queue_t *);
 
 static int ips_is_passthru(Scsi_Cmnd *);  static int
ips_make_passthru(ips_ha_t *, Scsi_Cmnd *, ips_scb_t *, int); @@ -1885,7
+1881,7 @@
 /*   Fill in a single scb sg_list element from an address
*/
 /*   return a -1 if a breakup occurred
*/
 
/***********************************************************************
*****/
-static inline int
+static int
 ips_fill_scb_sg_single(ips_ha_t * ha, dma_addr_t busaddr,
 		       ips_scb_t * scb, int indx, unsigned int e_len)  {
@@ -2950,7 +2946,7 @@
 /* ASSUMED to be called from within the HA lock
*/
 /*
*/
 
/***********************************************************************
*****/
-static inline void
+static void
 ips_putq_scb_head(ips_scb_queue_t * queue, ips_scb_t * item)  {
 	METHOD_TRACE("ips_putq_scb_head", 1);
@@ -2969,38 +2965,6 @@
 
 
/***********************************************************************
*****/
 /*
*/
-/* Routine Name: ips_putq_scb_tail
*/
-/*
*/
-/* Routine Description:
*/
-/*
*/
-/*   Add an item to the tail of the queue
*/
-/*
*/
-/* ASSUMED to be called from within the HA lock
*/
-/*
*/
-/**********************************************************************
******/
-static inline void
-ips_putq_scb_tail(ips_scb_queue_t * queue, ips_scb_t * item) -{
-	METHOD_TRACE("ips_putq_scb_tail", 1);
-
-	if (!item)
-		return;
-
-	item->q_next = NULL;
-
-	if (queue->tail)
-		queue->tail->q_next = item;
-
-	queue->tail = item;
-
-	if (!queue->head)
-		queue->head = item;
-
-	queue->count++;
-}
-
-/**********************************************************************
******/
-/*
*/
 /* Routine Name: ips_removeq_scb_head
*/
 /*
*/
 /* Routine Description:
*/
@@ -3010,7 +2974,7 @@
 /* ASSUMED to be called from within the HA lock
*/
 /*
*/
 
/***********************************************************************
*****/
-static inline ips_scb_t *
+static ips_scb_t *
 ips_removeq_scb_head(ips_scb_queue_t * queue)  {
 	ips_scb_t *item;
@@ -3045,7 +3009,7 @@
 /* ASSUMED to be called from within the HA lock
*/
 /*
*/
 
/***********************************************************************
*****/
-static inline ips_scb_t *
+static ips_scb_t *
 ips_removeq_scb(ips_scb_queue_t * queue, ips_scb_t * item)  {
 	ips_scb_t *p;
@@ -3082,34 +3046,6 @@
 
 
/***********************************************************************
*****/
 /*
*/
-/* Routine Name: ips_putq_wait_head
*/
-/*
*/
-/* Routine Description:
*/
-/*
*/
-/*   Add an item to the head of the queue
*/
-/*
*/
-/* ASSUMED to be called from within the HA lock
*/
-/*
*/
-/**********************************************************************
******/
-static inline void
-ips_putq_wait_head(ips_wait_queue_t * queue, Scsi_Cmnd * item) -{
-	METHOD_TRACE("ips_putq_wait_head", 1);
-
-	if (!item)
-		return;
-
-	item->host_scribble = (char *) queue->head;
-	queue->head = item;
-
-	if (!queue->tail)
-		queue->tail = item;
-
-	queue->count++;
-}
-
-/**********************************************************************
******/
-/*
*/
 /* Routine Name: ips_putq_wait_tail
*/
 /*
*/
 /* Routine Description:
*/
@@ -3119,7 +3055,7 @@
 /* ASSUMED to be called from within the HA lock
*/
 /*
*/
 
/***********************************************************************
*****/
-static inline void
+static void
 ips_putq_wait_tail(ips_wait_queue_t * queue, Scsi_Cmnd * item)  {
 	METHOD_TRACE("ips_putq_wait_tail", 1); @@ -3151,7 +3087,7 @@
 /* ASSUMED to be called from within the HA lock
*/
 /*
*/
 
/***********************************************************************
*****/
-static inline Scsi_Cmnd *
+static Scsi_Cmnd *
 ips_removeq_wait_head(ips_wait_queue_t * queue)  {
 	Scsi_Cmnd *item;
@@ -3186,7 +3122,7 @@
 /* ASSUMED to be called from within the HA lock
*/
 /*
*/
 
/***********************************************************************
*****/
-static inline Scsi_Cmnd *
+static Scsi_Cmnd *
 ips_removeq_wait(ips_wait_queue_t * queue, Scsi_Cmnd * item)  {
 	Scsi_Cmnd *p;
@@ -3223,34 +3159,6 @@
 
 
/***********************************************************************
*****/
 /*
*/
-/* Routine Name: ips_putq_copp_head
*/
-/*
*/
-/* Routine Description:
*/
-/*
*/
-/*   Add an item to the head of the queue
*/
-/*
*/
-/* ASSUMED to be called from within the HA lock
*/
-/*
*/
-/**********************************************************************
******/
-static inline void
-ips_putq_copp_head(ips_copp_queue_t * queue, ips_copp_wait_item_t *
item) -{
-	METHOD_TRACE("ips_putq_copp_head", 1);
-
-	if (!item)
-		return;
-
-	item->next = queue->head;
-	queue->head = item;
-
-	if (!queue->tail)
-		queue->tail = item;
-
-	queue->count++;
-}
-
-/**********************************************************************
******/
-/*
*/
 /* Routine Name: ips_putq_copp_tail
*/
 /*
*/
 /* Routine Description:
*/
@@ -3260,7 +3168,7 @@
 /* ASSUMED to be called from within the HA lock
*/
 /*
*/
 
/***********************************************************************
*****/
-static inline void
+static void
 ips_putq_copp_tail(ips_copp_queue_t * queue, ips_copp_wait_item_t *
item)  {
 	METHOD_TRACE("ips_putq_copp_tail", 1); @@ -3292,7 +3200,7 @@
 /* ASSUMED to be called from within the HA lock
*/
 /*
*/
 
/***********************************************************************
*****/
-static inline ips_copp_wait_item_t *
+static ips_copp_wait_item_t *
 ips_removeq_copp_head(ips_copp_queue_t * queue)  {
 	ips_copp_wait_item_t *item;
@@ -3327,7 +3235,7 @@
 /* ASSUMED to be called from within the HA lock
*/
 /*
*/
 
/***********************************************************************
*****/
-static inline ips_copp_wait_item_t *
+static ips_copp_wait_item_t *
 ips_removeq_copp(ips_copp_queue_t * queue, ips_copp_wait_item_t * item)
{
 	ips_copp_wait_item_t *p;

