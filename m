Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262281AbVAONh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbVAONh1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 08:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbVAONgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 08:36:55 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:30888 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262281AbVAONb3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 08:31:29 -0500
Subject: [PATCH 6/6] cifs: convert schedule_timeout to msleep and ssleep
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: sfrench@samba.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1105795818.9555.9.camel@localhost>
References: <1105795546.9555.2.camel@localhost>
	 <1105795614.9555.3.camel@localhost>  <1105795682.9555.5.camel@localhost>
	 <1105795751.9555.7.camel@localhost>  <1105795818.9555.9.camel@localhost>
Date: Sat, 15 Jan 2005 15:31:28 +0200
Message-Id: <1105795888.9555.11.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts cifs code to use msleep() and ssleep() instead of
schedule_timeout().

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 cifsfs.c  |    9 ++++-----
 connect.c |   25 +++++++++----------------
 2 files changed, 13 insertions(+), 21 deletions(-)

Index: 2.6/fs/cifs/cifsfs.c
===================================================================
--- 2.6.orig/fs/cifs/cifsfs.c	2005-01-12 23:33:14.476445944 +0200
+++ 2.6/fs/cifs/cifsfs.c	2005-01-12 23:37:09.402731720 +0200
@@ -32,6 +32,7 @@
 #include <linux/seq_file.h>
 #include <linux/vfs.h>
 #include <linux/mempool.h>
+#include <linux/delay.h>
 #include "cifsfs.h"
 #include "cifspdu.h"
 #define DECLARE_GLOBALS_HERE
@@ -748,14 +749,12 @@
 
 	oplockThread = current;
 	do {
-		set_current_state(TASK_INTERRUPTIBLE);
-		
-		schedule_timeout(1*HZ);  
+		ssleep(1);
+
 		spin_lock(&GlobalMid_Lock);
 		if(list_empty(&GlobalOplock_Q)) {
 			spin_unlock(&GlobalMid_Lock);
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(39*HZ);
+			ssleep(39);
 		} else {
 			oplock_item = list_entry(GlobalOplock_Q.next, 
 				struct oplock_q_entry, qhead);
Index: 2.6/fs/cifs/connect.c
===================================================================
--- 2.6.orig/fs/cifs/connect.c	2005-01-12 23:33:14.479445488 +0200
+++ 2.6/fs/cifs/connect.c	2005-01-12 23:37:47.396955720 +0200
@@ -29,6 +29,7 @@
 #include <linux/ctype.h>
 #include <linux/utsname.h>
 #include <linux/mempool.h>
+#include <linux/delay.h>
 #include <asm/uaccess.h>
 #include <asm/processor.h>
 #include "cifspdu.h"
@@ -174,8 +175,7 @@
 					server->workstation_RFC1001_name);
 		}
 		if(rc) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(3 * HZ);
+			ssleep(3);
 		} else {
 			atomic_inc(&tcpSesReconnectCount);
 			spin_lock(&GlobalMid_Lock);
@@ -226,8 +226,7 @@
 
 		if (smb_buffer == NULL) {
 			cERROR(1,("Can not get memory for SMB response"));
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(HZ * 3); /* give system time to free memory */
+			ssleep(3);
 			continue;
 		}
 		iov.iov_base = smb_buffer;
@@ -308,8 +307,7 @@
 				} else {
 					/* give server a second to
 					clean up before reconnect attempt */
-					set_current_state(TASK_INTERRUPTIBLE);
-					schedule_timeout(HZ);
+					ssleep(1);
 					/* always try 445 first on reconnect
 					since we get NACK on some if we ever
 					connected to port 139 (the NACK is 
@@ -433,8 +431,7 @@
 	and get out of SendReceive.  */
 	wake_up_all(&server->request_q);
 	/* give those requests time to exit */
-	set_current_state(TASK_INTERRUPTIBLE);
-	schedule_timeout(HZ/8);
+	msleep(125);
 
 	if(server->ssocket) {
 		sock_release(csocket);
@@ -471,17 +468,15 @@
 		}
 		spin_unlock(&GlobalMid_Lock);
 		read_unlock(&GlobalSMBSeslock);
-		set_current_state(TASK_INTERRUPTIBLE);
 		/* 1/8th of sec is more than enough time for them to exit */
-		schedule_timeout(HZ/8); 
+		msleep(125);
 	}
 
 	if (list_empty(&server->pending_mid_q)) {
 		/* mpx threads have not exited yet give them 
 		at least the smb send timeout time for long ops */
 		cFYI(1, ("Wait for exit from demultiplex thread"));
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(46 * HZ);	
+		ssleep(46);
 		/* if threads still have not exited they are probably never
 		coming home not much else we can do but free the memory */
 	}
@@ -497,8 +492,7 @@
 			GFP_KERNEL);
 	}
 
-	set_current_state(TASK_INTERRUPTIBLE);
-	schedule_timeout(HZ/4);
+	msleep(250);
 	return 0;
 }
 
@@ -2924,8 +2918,7 @@
 	
 	cifs_sb->tcon = NULL;
 	if (ses) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(HZ / 2);
+		msleep(500);
 	}
 	if (ses)
 		sesInfoFree(ses);


