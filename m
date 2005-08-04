Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbVHDEmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbVHDEmO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 00:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVHDEmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 00:42:01 -0400
Received: from bgerelbas01.asiapac.hp.net ([15.219.201.134]:18414 "EHLO
	bgerelbas01.ind.hp.com") by vger.kernel.org with ESMTP
	id S261765AbVHDElo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 00:41:44 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 2/2] cpqfc: fix for possible memory out of bounds bugzilla#243
Date: Thu, 4 Aug 2005 10:11:41 +0530
Message-ID: <4221C1B21C20854291E185D1243EA8F302623BCE@bgeexc04.asiapacific.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/2] cpqfc: fix for possible memory out of bounds bugzilla#243
Thread-Index: AcWYrs69qAWaJdu5RE6h/7ww4k4o3g==
From: "Saripalli, Venkata Ramanamurthy (STSD)" <saripalli@hp.com>
To: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Cc: <axboe@suse.de>
X-OriginalArrivalTime: 04 Aug 2005 04:41:41.0798 (UTC) FILETIME=[CF347460:01C598AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 2 of 2

This patch fixes the Bugzilla Bug#243. This fix is to solve the possible
memory
out of bounds in BigEndianSwap routine of cpqfcTSworker.c

Please consider this for inclusion

Signed-off-by: Ramanamurthy Saripalli <saripalli@hp.com>

 cpqfcTScontrol.c |    2 --
 cpqfcTSworker.c  |    3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)
------------------------------------------------------------------------
-------
diff -burpN old/drivers/scsi/cpqfcTScontrol.c
new/drivers/scsi/cpqfcTScontrol.c
--- old/drivers/scsi/cpqfcTScontrol.c	2005-07-12 22:52:29.000000000
+0530
+++ new/drivers/scsi/cpqfcTScontrol.c	2005-07-19 00:33:29.385458328
+0530
@@ -606,7 +606,6 @@ static int PeekIMQEntry( PTACHYON fcChip
         if( (fcChip->IMQ->QEntry[CI].type & 0x1FF) == 0x104 )
         { 
           TachFCHDR_GCMND* fchs;
-#error This is too much stack
           ULONG ulFibreFrame[2048/4];  // max DWORDS in incoming FC
Frame
 	  USHORT SFQpi = (USHORT)(fcChip->IMQ->QEntry[CI].word[0] &
0x0fffL);
 
@@ -718,7 +717,6 @@ int CpqTsProcessIMQEntry(void *host)
   ULONG x_ID;
   ULONG ulBuff, dwStatus;
   TachFCHDR_GCMND* fchs;
-#error This is too much stack
   ULONG ulFibreFrame[2048/4];  // max number of DWORDS in incoming
Fibre Frame
   UCHAR ucInboundMessageType;  // Inbound CM, dword 3 "type" field
 
diff -burpN old/drivers/scsi/cpqfcTSworker.c
new/drivers/scsi/cpqfcTSworker.c
--- old/drivers/scsi/cpqfcTSworker.c	2005-07-12 22:52:29.000000000
+0530
+++ new/drivers/scsi/cpqfcTSworker.c	2005-07-19 00:33:32.245023608
+0530
@@ -4024,6 +4024,9 @@ void BigEndianSwap( UCHAR *source, UCHAR
   int i,j;
 
   source+=3;   // start at MSB of 1st ULONG
+
+  cnt -= (cnt % 4 );
+
   for( j=0; j < cnt; j+=4, source+=4, dest+=4)  // every ULONG
   {
     for( i=0; i<4; i++)  // every UCHAR in ULONG
