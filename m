Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266442AbUGOWrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266442AbUGOWrp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 18:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266443AbUGOWrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 18:47:45 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:5848 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266442AbUGOWrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 18:47:37 -0400
Date: Fri, 16 Jul 2004 00:47:26 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI tmscsim.c: fix inline compile errors
Message-ID: <20040715224726.GQ25633@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to compile drivers/scsi/tmscsim.c in 2.6.8-rc1-mm1 using gcc 3.4 
results in compile errors starting with the following:

<--  snip  -->

...
  CC      drivers/scsi/tmscsim.o
In file included from drivers/scsi/tmscsim.c:1477:
drivers/scsi/scsiiom.c: In function `do_DC390_Interrupt':
drivers/scsi/tmscsim.c:295: sorry, unimplemented: inlining failed in 
call to 'dc390_InvalidCmd': function body not available
drivers/scsi/scsiiom.c:279: sorry, unimplemented: called from here
drivers/scsi/tmscsim.c:296: sorry, unimplemented: inlining failed in 
call to 'dc390_EnableMsgOut_Abort': function body not available
drivers/scsi/scsiiom.c:317: sorry, unimplemented: called from here
make[2]: *** [drivers/scsi/tmscsim.o] Error 1

<--  snip  -->


The patch below removes the inlines from the affected functions.

An alternative approach would be to move the functions above the place  
where they are called the first time.



diffstat output:
 drivers/scsi/scsiiom.c |    6 +++---
 drivers/scsi/tmscsim.c |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm6-full-gcc3.4/drivers/scsi/scsiiom.c.old	2004-07-09 01:31:13.000000000 +0200
+++ linux-2.6.7-mm6-full-gcc3.4/drivers/scsi/scsiiom.c	2004-07-09 01:33:35.000000000 +0200
@@ -594,7 +594,7 @@
 }
 
 /* abort command */
-static void __inline__
+static void
 dc390_EnableMsgOut_Abort ( struct dc390_acb* pACB, struct dc390_srb* pSRB )
 {
     pSRB->MsgOutBuf[0] = ABORT; 
@@ -1656,7 +1656,7 @@
 }
 
 
-static void __inline__
+static void
 dc390_RequestSense( struct dc390_acb* pACB, struct dc390_dcb* pDCB, struct dc390_srb* pSRB )
 {
     struct scsi_cmnd *pcmd;
@@ -1696,7 +1696,7 @@
 
 
 
-static void __inline__
+static void
 dc390_InvalidCmd( struct dc390_acb* pACB )
 {
     if( pACB->pActiveDCB->pActiveSRB->SRBState & (SRB_START_+SRB_MSGOUT) )
--- linux-2.6.7-mm6-full-gcc3.4/drivers/scsi/tmscsim.c.old	2004-07-09 01:29:36.000000000 +0200
+++ linux-2.6.7-mm6-full-gcc3.4/drivers/scsi/tmscsim.c	2004-07-09 01:33:46.000000000 +0200
@@ -291,9 +291,9 @@
 static void dc390_DoingSRB_Done( struct dc390_acb* pACB, struct scsi_cmnd * cmd);
 static void dc390_ScsiRstDetect( struct dc390_acb* pACB );
 static void dc390_ResetSCSIBus( struct dc390_acb* pACB );
-static void __inline__ dc390_RequestSense( struct dc390_acb* pACB, struct dc390_dcb* pDCB, struct dc390_srb* pSRB );
-static void __inline__ dc390_InvalidCmd( struct dc390_acb* pACB );
-static void __inline__ dc390_EnableMsgOut_Abort (struct dc390_acb*, struct dc390_srb*);
+static void dc390_RequestSense( struct dc390_acb* pACB, struct dc390_dcb* pDCB, struct dc390_srb* pSRB );
+static void dc390_InvalidCmd( struct dc390_acb* pACB );
+static void dc390_EnableMsgOut_Abort (struct dc390_acb*, struct dc390_srb*);
 static irqreturn_t do_DC390_Interrupt( int, void *, struct pt_regs *);
 
 static int    dc390_initAdapter(struct Scsi_Host *psh, unsigned long io_port, u8 Irq, u8 index );

