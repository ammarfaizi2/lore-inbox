Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316916AbSFFKWa>; Thu, 6 Jun 2002 06:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316919AbSFFKW3>; Thu, 6 Jun 2002 06:22:29 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:63372 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S316916AbSFFKW2>; Thu, 6 Jun 2002 06:22:28 -0400
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
Subject: Fwd: Patch - SCSI host numbers - please apply
Date: Thu, 6 Jun 2002 13:23:50 +0300
User-Agent: KMail/1.4.1
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_QV4AV7EM5496C7R4YWH3"
Message-Id: <200206061323.50476.nahshon@actcom.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_QV4AV7EM5496C7R4YWH3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

This was sent on Apr 22 and probably lost.
This patch still applies cleanly to 2.4.19-pre10.

Can this get in the kernel before 2.4.19 final ?

-- Itai

----------  Forwarded Message  ----------

Subject: Patch - SCSI host numbers - please apply
Date: Mon, 22 Apr 2002 09:19:56 +0300
From: Itai Nahshon <nahshon@actcom.co.il>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, Jens Axboe <axboe@suse.de>

Hello,
I think this has gone through enough testing...

History:
  A similar patch was submitted to to lkml and to linux-scsi
  two months ago. Verified by Aron Zeh <ARZEH@de.ibm.com> on Apr 9.
  The attached patch is a cleaned-up version
  (The original had #ifdef'ed the code that this one removes).

Kernel version info:
  2.4.x: Patch applies cleanly (and tested with) all 2.4.19-preX
        kernels.
  2.5.x: Patch applies with 8 line offset to 2.5.8.
        Bug verified only by "visual inspection". (but really nothing
	in the host_no allocation algorithm has changed since 2.4).

Bug info:
  Actually fixing two _different_ scenarios that look almost the same.
  Need two or more) scsi host adapters that are not required for
  normal system usage. I uses ide-scsi and usb-storage fr my
  tests. Start with a "clean system" (before any of these drivers
  is loaded). Suppose scsi host adapter drivers are named A and B.

  scenario 1:
	insmod A
	rmmod A
	insmod A
	insmod B

  scenario 2:
	insmod A
	rmmod A
	insmod B
	insmod A

  Without the patch, both scenarios end with both host adapters having
  the same host_no.

More tests:
  I tested also with param scsihosts=<host0>:<host1>:....
  (when loading scsi_mod)

Comment/motivation:
  This keeps max_scsi_host coherent with the length of the list
  scsi_host_no_list. Since we never shorten the list
  we should never decrement max_scsi_host.

Sincerely,
-- Itai

-------------------------------------------------------


--------------Boundary-00=_QV4AV7EM5496C7R4YWH3
Content-Type: text/x-diff;
  charset="us-ascii";
  name="scsi-host_no_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="scsi-host_no_fix.patch"

--- drivers/scsi/hosts.c.orig	Mon Feb 25 21:38:04 2002
+++ drivers/scsi/hosts.c	Wed Apr 17 01:42:47 2002
@@ -81,8 +81,8 @@
 struct Scsi_Host * scsi_hostlist;
 struct Scsi_Device_Template * scsi_devicelist;
 
-int max_scsi_hosts;
-int next_scsi_host;
+int max_scsi_hosts;	/* host_no for next new host */
+int next_scsi_host;	/* count of registered scsi hosts */
 
 void
 scsi_unregister(struct Scsi_Host * sh){
@@ -107,21 +107,8 @@
     if (shn) shn->host_registered = 0;
     /* else {} : This should not happen, we should panic here... */
     
-    /* If we are removing the last host registered, it is safe to reuse
-     * its host number (this avoids "holes" at boot time) (DB) 
-     * It is also safe to reuse those of numbers directly below which have
-     * been released earlier (to avoid some holes in numbering).
-     */
-    if(sh->host_no == max_scsi_hosts - 1) {
-	while(--max_scsi_hosts >= next_scsi_host) {
-	    shpnt = scsi_hostlist;
-	    while(shpnt && shpnt->host_no != max_scsi_hosts - 1)
-		shpnt = shpnt->next;
-	    if(shpnt)
-		break;
-	}
-    }
     next_scsi_host--;
+
     kfree((char *) sh);
 }
 

--------------Boundary-00=_QV4AV7EM5496C7R4YWH3--

