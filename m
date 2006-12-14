Return-Path: <linux-kernel-owner+w=401wt.eu-S1750823AbWLNPAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWLNPAS (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 10:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932765AbWLNPAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 10:00:18 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:58863 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbWLNPAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 10:00:17 -0500
Date: Thu, 14 Dec 2006 15:00:15 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] m68k trivial build fixes
Message-ID: <20061214150015.GA17561@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

amikbd: missing declaration
sun3_NCR5380: more work_struct mess
sun3_NCR5380: cast is not an lvalue

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

diff --git a/drivers/input/keyboard/amikbd.c b/drivers/input/keyboard/amikbd.c
index 16583d7..c67e84e 100644
--- a/drivers/input/keyboard/amikbd.c
+++ b/drivers/input/keyboard/amikbd.c
@@ -187,7 +187,7 @@ static irqreturn_t amikbd_interrupt(int 
 
 static int __init amikbd_init(void)
 {
-	int i, j;
+	int i, j, err;
 
 	if (!AMIGAHW_PRESENT(AMI_KEYBOARD))
 		return -ENODEV;
diff --git a/drivers/scsi/sun3_NCR5380.c b/drivers/scsi/sun3_NCR5380.c
index 43f5b6a..98e3fe1 100644
--- a/drivers/scsi/sun3_NCR5380.c
+++ b/drivers/scsi/sun3_NCR5380.c
@@ -266,7 +266,7 @@ #define	SETUP_HOSTDATA(in)				\
 	(struct NCR5380_hostdata *)(in)->hostdata
 #define	HOSTDATA(in) ((struct NCR5380_hostdata *)(in)->hostdata)
 
-#define	NEXT(cmd)	((struct scsi_cmnd *)((cmd)->host_scribble))
+#define	NEXT(cmd)	(*(struct scsi_cmnd **)&((cmd)->host_scribble))
 #define	NEXTADDR(cmd)	((struct scsi_cmnd **)&((cmd)->host_scribble))
 
 #define	HOSTNO		instance->host_no
@@ -650,7 +650,7 @@ #include <linux/workqueue.h>
 #include <linux/interrupt.h>
 
 static volatile int main_running = 0;
-static DECLARE_WORK(NCR5380_tqueue, (void (*)(void*))NCR5380_main, NULL);
+static DECLARE_WORK(NCR5380_tqueue, NCR5380_main);
 
 static __inline__ void queue_main(void)
 {
@@ -1031,7 +1031,7 @@ #endif
  *  reenable them.  This prevents reentrancy and kernel stack overflow.
  */ 	
     
-static void NCR5380_main (void *bl)
+static void NCR5380_main (struct work_struct *bl)
 {
     struct scsi_cmnd *tmp, *prev;
     struct Scsi_Host *instance = first_instance;
