Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267338AbUBSQVO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 11:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267359AbUBSQS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 11:18:56 -0500
Received: from chaos.analogic.com ([204.178.40.224]:896 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267338AbUBSQSb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 11:18:31 -0500
Date: Thu, 19 Feb 2004 11:18:30 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.24 extra CPU cycles in scsi.c 
Message-ID: <Pine.LNX.4.53.0402191116550.500@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When looking through various modules that I use, trying to
find out where some memory seems to be leaking, I found a
couple of unrelated things in scsi.c.

The code sets a structure-member to NULL, then releases the
pointer to that structure. A few CPU cycles being thrown away.
Since I was reviewing the whole file, I also got rid of the
spurious casts when calling kfree().



--- linux-2.4.24/drivers/scsi/scsi.c.orig	Thu Feb 19 10:45:20 2004
+++ linux-2.4.24/drivers/scsi/scsi.c	Thu Feb 19 11:01:47 2004
@@ -314,11 +314,7 @@
 void scsi_release_request(Scsi_Request * req)
 {
 	if( req->sr_command != NULL )
-	{
 		scsi_release_command(req->sr_command);
-		req->sr_command = NULL;
-	}
-
 	kfree(req);
 }

@@ -1449,7 +1445,7 @@
  	spin_lock_irqsave(&device_request_lock, flags);
 	for (SCpnt = SDpnt->device_queue; SCpnt; SCpnt = SCnext) {
 		SDpnt->device_queue = SCnext = SCpnt->next;
-		kfree((char *) SCpnt);
+		kfree(SCpnt);
 	}
 	SDpnt->has_cmdblocks = 0;
 	SDpnt->queue_depth = 0;
@@ -1550,7 +1546,7 @@
 	    max_scsi_hosts = n+1;
 	}
 	else
-	    kfree((char *) shn);
+	    kfree(shn);
     }
 }

@@ -1845,7 +1841,7 @@
 				HBA_ptr->host_queue = scd->next;
 			}
 			blk_cleanup_queue(&scd->request_queue);
-			kfree((char *) scd);
+			kfree(scd);
 		} else {
 			goto out;
 		}
@@ -2164,7 +2160,7 @@
 			blk_cleanup_queue(&SDpnt->request_queue);
 			/* Next free up the Scsi_Device structures for this host */
 			shpnt->host_queue = SDpnt->next;
-			kfree((char *) SDpnt);
+			kfree(SDpnt);

 		}
 	}


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


