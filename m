Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264336AbTEGXGa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbTEGXFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:05:46 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:57343 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264336AbTEGXCD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:02:03 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1052349387810@kroah.com>
Subject: Re: [PATCH] TTY changes for 2.5.69
In-Reply-To: <10523493873768@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 7 May 2003 16:16:27 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1106, 2003/05/07 15:00:52-07:00, hannal@us.ibm.com

[PATCH] isicom tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT


 drivers/char/isicom.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)


diff -Nru a/drivers/char/isicom.c b/drivers/char/isicom.c
--- a/drivers/char/isicom.c	Wed May  7 16:00:43 2003
+++ b/drivers/char/isicom.c	Wed May  7 16:00:43 2003
@@ -590,9 +590,7 @@
 							port->status &= ~ISI_DCD;
 							if (!((port->flags & ASYNC_CALLOUT_ACTIVE) &&
 								(port->flags & ASYNC_CALLOUT_NOHUP))) {
-								MOD_INC_USE_COUNT;
-								if (schedule_task(&port->hangup_tq) == 0)
-									MOD_DEC_USE_COUNT;
+								schedule_task(&port->hangup_tq);
 							}
 						}
 					}
@@ -846,7 +844,6 @@
 #endif	
 	
 	bp->status |= BOARD_ACTIVE;
-	MOD_INC_USE_COUNT;
 	return;
 }
  
@@ -1104,7 +1101,6 @@
 	for(channel = 0; channel < bp->port_count; channel++, port++) {
 		drop_dtr_rts(port);
 	}	
-	MOD_DEC_USE_COUNT;
 }
 
 static void isicom_shutdown_port(struct isi_port * port)
@@ -1644,7 +1640,6 @@
 	tty = port->tty;
 	if (tty)
 		tty_hangup(tty);	/* FIXME: module removal race here - AKPM */
-	MOD_DEC_USE_COUNT;
 }
 
 static void isicom_hangup(struct tty_struct * tty)
@@ -1715,6 +1710,7 @@
 	/* tty driver structure initialization */
 	memset(&isicom_normal, 0, sizeof(struct tty_driver));
 	isicom_normal.magic	= TTY_DRIVER_MAGIC;
+	isicom_normal.owner	= THIS_MODULE;
 	isicom_normal.name 	= "ttyM";
 	isicom_normal.major	= ISICOM_NMAJOR;
 	isicom_normal.minor_start	= 0;

