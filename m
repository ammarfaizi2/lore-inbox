Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261437AbSJHTMP>; Tue, 8 Oct 2002 15:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261436AbSJHTMN>; Tue, 8 Oct 2002 15:12:13 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25360 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263251AbSJHTGn>; Tue, 8 Oct 2002 15:06:43 -0400
Subject: PATCH: fix ppa
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 20:03:52 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yze4-0004uV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/scsi/ppa.c linux.2.5.41-ac1/drivers/scsi/ppa.c
--- linux.2.5.41/drivers/scsi/ppa.c	2002-10-07 22:12:26.000000000 +0100
+++ linux.2.5.41-ac1/drivers/scsi/ppa.c	2002-10-08 00:51:45.000000000 +0100
@@ -18,6 +18,7 @@
 #include <linux/blk.h>
 #include <asm/io.h>
 #include <linux/parport.h>
+#include <linux/workqueue.h>
 #include "sd.h"
 #include "hosts.h"
 int ppa_release(struct Scsi_Host *);
@@ -42,7 +43,7 @@
 	mode:		PPA_AUTODETECT,	\
 	host:		-1,		\
 	cur_cmd:	NULL,		\
-	ppa_tq:		{ routine: ppa_interrupt },	\
+	ppa_tq:		{ func: ppa_interrupt },	\
 	jstart:		0,		\
 	recon_tmo:      PPA_RECON_TMO,	\
 	failed:		0,		\
@@ -800,7 +801,6 @@
     }
     if (ppa_engine(tmp, cmd)) {
 	tmp->ppa_tq.data = (void *) tmp;
-	tmp->ppa_tq.sync = 0;
 	schedule_delayed_work(&tmp->ppa_tq, 1);
 	return;
     }
@@ -985,7 +985,6 @@
     ppa_pb_claim(host_no);
 
     ppa_hosts[host_no].ppa_tq.data = ppa_hosts + host_no;
-    ppa_hosts[host_no].ppa_tq.sync = 0;
     schedule_work(&ppa_hosts[host_no].ppa_tq);
 
     return 0;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/scsi/ppa.h linux.2.5.41-ac1/drivers/scsi/ppa.h
--- linux.2.5.41/drivers/scsi/ppa.h	2002-10-02 21:32:55.000000000 +0100
+++ linux.2.5.41-ac1/drivers/scsi/ppa.h	2002-10-08 00:50:14.000000000 +0100
@@ -78,7 +78,6 @@
 #include  <linux/stddef.h>
 #include  <linux/module.h>
 #include  <linux/kernel.h>
-#include  <linux/tqueue.h>
 #include  <linux/ioport.h>
 #include  <linux/delay.h>
 #include  <linux/proc_fs.h>
