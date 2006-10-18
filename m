Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWJRJiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWJRJiR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 05:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWJRJiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 05:38:17 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:48585 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S932132AbWJRJiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 05:38:16 -0400
Subject: [PATCH] drivers/isdn: Handcrafted MIN/MAX Macro removal
From: Amol Lad <amol@verismonetworks.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: kkeil@suse.de
Content-Type: text/plain
Date: Wed, 18 Oct 2006 15:11:37 +0530
Message-Id: <1161164497.20400.137.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanups done to use min/max macros from kernel.h. Handcrafted MIN/MAX
macros are changed to use macros in kernel.h

Tested using allmodconfig

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
 debug.c    |    4 ++--
 di.c       |    8 ++++----
 io.c       |    2 +-
 istream.c  |    4 ++--
 platform.h |    8 --------
 5 files changed, 9 insertions(+), 17 deletions(-)
---
diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff linux-2.6.19-rc2-orig/drivers/isdn/hardware/eicon/debug.c linux-2.6.19-rc2/drivers/isdn/hardware/eicon/debug.c
--- linux-2.6.19-rc2-orig/drivers/isdn/hardware/eicon/debug.c	2006-08-24 02:46:33.000000000 +0530
+++ linux-2.6.19-rc2/drivers/isdn/hardware/eicon/debug.c	2006-10-18 11:25:46.000000000 +0530
@@ -756,14 +756,14 @@ int diva_get_driver_info (dword id, byte
 
     data_length -= 9;
 
-    if ((to_copy = MIN(strlen(clients[id].drvName), data_length-1))) {
+    if ((to_copy = min(strlen(clients[id].drvName), (size_t)(data_length-1)))) {
       memcpy (p, clients[id].drvName, to_copy);
       p += to_copy;
       data_length -= to_copy;
       if ((data_length >= 4) && clients[id].hDbg->drvTag[0]) {
         *p++ = '(';
         data_length -= 1;
-        if ((to_copy = MIN(strlen(clients[id].hDbg->drvTag), data_length-2))) {
+        if ((to_copy = min(strlen(clients[id].hDbg->drvTag), (size_t)(data_length-2)))) {
           memcpy (p, clients[id].hDbg->drvTag, to_copy);
           p += to_copy;
           data_length -= to_copy;
diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff linux-2.6.19-rc2-orig/drivers/isdn/hardware/eicon/di.c linux-2.6.19-rc2/drivers/isdn/hardware/eicon/di.c
--- linux-2.6.19-rc2-orig/drivers/isdn/hardware/eicon/di.c	2006-08-24 02:46:33.000000000 +0530
+++ linux-2.6.19-rc2/drivers/isdn/hardware/eicon/di.c	2006-10-18 11:25:46.000000000 +0530
@@ -133,7 +133,7 @@ void pr_out(ADAPTER * a)
     i = this->XCurrent;
     X = PTR_X(a,this);
     while(i<this->XNum && length<270) {
-      clength = MIN((word)(270-length),X[i].PLength-this->XOffset);
+      clength = min((word)(270-length),(word)(X[i].PLength-this->XOffset));
       a->ram_out_buffer(a,
                         &ReqOut->XBuffer.P[length],
                         PTR_P(a,this,&X[i].P[this->XOffset]),
@@ -622,7 +622,7 @@ byte isdn_ind(ADAPTER * a,
                                                      sizeof(a->stream_buffer),
                                                      &final, NULL, NULL);
         }
-        IoAdapter->RBuffer.length = MIN(MLength, 270);
+        IoAdapter->RBuffer.length = min(MLength, (word)270);
         if (IoAdapter->RBuffer.length != MLength) {
           this->complete = 0;
         } else {
@@ -676,9 +676,9 @@ byte isdn_ind(ADAPTER * a,
         this->RCurrent++;
       }
       if (cma) {
-        clength = MIN(MLength, R[this->RCurrent].PLength-this->ROffset);
+        clength = min(MLength, (word)(R[this->RCurrent].PLength-this->ROffset));
       } else {
-        clength = MIN(a->ram_inw(a, &RBuffer->length)-offset,
+        clength = min(a->ram_inw(a, &RBuffer->length)-offset,
                       R[this->RCurrent].PLength-this->ROffset);
       }
       if(R[this->RCurrent].P) {
diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff linux-2.6.19-rc2-orig/drivers/isdn/hardware/eicon/io.c linux-2.6.19-rc2/drivers/isdn/hardware/eicon/io.c
--- linux-2.6.19-rc2-orig/drivers/isdn/hardware/eicon/io.c	2006-08-24 02:46:33.000000000 +0530
+++ linux-2.6.19-rc2/drivers/isdn/hardware/eicon/io.c	2006-10-18 11:25:46.000000000 +0530
@@ -262,7 +262,7 @@ void request(PISDN_ADAPTER IoAdapter, EN
     case IDI_SYNC_REQ_XDI_GET_CAPI_PARAMS: {
        diva_xdi_get_capi_parameters_t prms, *pI = &syncReq->xdi_capi_prms.info;
        memset (&prms, 0x00, sizeof(prms));
-       prms.structure_length = MIN(sizeof(prms), pI->structure_length);
+       prms.structure_length = min(sizeof(prms), pI->structure_length);
        memset (pI, 0x00, pI->structure_length);
        prms.flag_dynamic_l1_down    = (IoAdapter->capi_cfg.cfg_1 & \
          DIVA_XDI_CAPI_CFG_1_DYNAMIC_L1_ON) ? 1 : 0;
diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff linux-2.6.19-rc2-orig/drivers/isdn/hardware/eicon/istream.c linux-2.6.19-rc2/drivers/isdn/hardware/eicon/istream.c
--- linux-2.6.19-rc2-orig/drivers/isdn/hardware/eicon/istream.c	2006-08-24 02:46:33.000000000 +0530
+++ linux-2.6.19-rc2/drivers/isdn/hardware/eicon/istream.c	2006-10-18 11:25:46.000000000 +0530
@@ -92,7 +92,7 @@ int diva_istream_write (void* context,
     return (-1); /* was not able to write       */
    break;     /* only part of message was written */
   }
-  to_write = MIN(length, DIVA_DFIFO_DATA_SZ);
+  to_write = min(length, DIVA_DFIFO_DATA_SZ);
   if (to_write) {
    a->ram_out_buffer (a,
 #ifdef PLATFORM_GT_32BIT
@@ -176,7 +176,7 @@ int diva_istream_read (void* context,
     return (-1); /* was not able to read */
    break;
   }
-  to_read = MIN(max_length, tmp[1]);
+  to_read = min(max_length, (int)tmp[1]);
   if (to_read) {
    a->ram_in_buffer(a,
 #ifdef PLATFORM_GT_32BIT
diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff linux-2.6.19-rc2-orig/drivers/isdn/hardware/eicon/platform.h linux-2.6.19-rc2/drivers/isdn/hardware/eicon/platform.h
--- linux-2.6.19-rc2-orig/drivers/isdn/hardware/eicon/platform.h	2006-09-21 10:15:33.000000000 +0530
+++ linux-2.6.19-rc2/drivers/isdn/hardware/eicon/platform.h	2006-10-18 11:25:46.000000000 +0530
@@ -83,14 +83,6 @@
 #define	NULL	((void *) 0)
 #endif
 
-#ifndef	MIN
-#define MIN(a,b)	((a)>(b) ? (b) : (a))
-#endif
-
-#ifndef	MAX
-#define MAX(a,b)	((a)>(b) ? (a) : (b))
-#endif
-
 #ifndef	far
 #define far
 #endif


