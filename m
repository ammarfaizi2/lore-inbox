Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263921AbTD0K64 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 06:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263922AbTD0K64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 06:58:56 -0400
Received: from hera.cwi.nl ([192.16.191.8]:18050 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263921AbTD0K6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 06:58:53 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 27 Apr 2003 13:11:06 +0200 (MEST)
Message-Id: <UTC200304271111.h3RBB6M14317.aeb@smtp.cwi.nl>
To: dgilbert@interlog.com
Subject: [PATCH] scsi_mid_low_api.txt
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The specification says that slave_configure() has to call
scsi_adjust_queue_depth(). This is false, and moreover
does not always happen in the current tree.
(I was interested since I plan to add a slave_configure()
that will not call scsi_adjust_queue_depth().)

So, the patch below adapts scsi_mid_low_api.txt a little.

Andries

----------------------------------------------------------

diff -u --recursive --new-file -X /linux/dontdiff a/Documentation/scsi/scsi_mid_low_api.txt b/Documentation/scsi/scsi_mid_low_api.txt
--- a/Documentation/scsi/scsi_mid_low_api.txt	Mon Feb 24 23:02:44 2003
+++ b/Documentation/scsi/scsi_mid_low_api.txt	Sun Apr 27 12:58:21 2003
@@ -134,7 +134,7 @@
                     slave_configure() -->  scsi_adjust_queue_depth()
 			 |
 		    slave_alloc()
-                    slave_configure() -->  scsi_adjust_queue_depth()
+                    slave_configure()
 			 |
 		    slave_alloc()
                     slave_configure() -->  scsi_adjust_queue_depth()
@@ -142,8 +142,9 @@
 		    slave_alloc()   **
                     slave_destroy() **
 
-The invocation of scsi_adjust_queue_depth() by the LLD is required
-if slave_configure() is supplied.
+If the LLD wants to adjust the default queue settings, it can invoke
+scsi_adjust_queue_depth() in its slave_configure() routine.
+
 ** For scsi devices that the mid level tries to scan but do not
    respond, a slave_alloc(), slave_destroy() pair is called.
 
@@ -199,7 +200,7 @@
                             |                scsi_register()
                             |
 		      slave_alloc()
-                      slave_configure()  -->  scsi_adjust_queue_depth()
+                      slave_configure()
 		      slave_alloc()   **
 		      slave_destroy() **
                             |
@@ -208,9 +209,10 @@
 		      slave_alloc()   **
 		      slave_destroy() **
 
-If the LLD does not supply a slave_configure() then the mid level invokes
-scsi_adjust_queue_depth() itself with tagged queuing off and "cmd_per_lun"
-for that host as the queue length.
+The mid level invokes scsi_adjust_queue_depth() with tagged queuing off and
+"cmd_per_lun" for that host as the queue length. These settings can be
+overridden by a slave_configure() supplied by the LLD.
+
 ** For scsi devices that the mid level tries to scan but do not
    respond, a slave_alloc(), slave_destroy() pair is called.
 
@@ -903,11 +905,6 @@
  *      Notes: Allows the driver to inspect the response to the initial
  *	INQUIRY done by the scanning code and take appropriate action.
  *	For more details see the hosts.h file.
- *	If this function is not supplied, the mid level will call
- *	scsi_adjust_queue_depth() with the struct Scsi_Host::cmd_per_lun
- *	value on behalf of the given device. If this function is
- *	supplied then its implementation must call
- *	scsi_adjust_queue_depth(). 	
  **/
     int slave_configure(struct scsi_device *sdp);
 
