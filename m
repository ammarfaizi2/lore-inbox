Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267872AbUI2Hrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267872AbUI2Hrg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 03:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268048AbUI2Hrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 03:47:35 -0400
Received: from cantor.suse.de ([195.135.220.2]:26766 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267872AbUI2Hrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 03:47:31 -0400
Message-ID: <415A67B8.2080003@suse.de>
Date: Wed, 29 Sep 2004 09:43:52 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: James.Bottomley@steeleye.com, Andrew Morton <akpm@osdl.org>
Subject: [Patch] Fix oops on rmmod usb-storage
Content-Type: multipart/mixed;
 boundary="------------020303080901070907040109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020303080901070907040109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

I managed to (hopefully) fix an kernel Oops on rmmod usb-storage.
The Oops we got was something like:

usbcore: deregistering driver usb-storage
scsi: Device offlined - not ready after error recovery: host 0 channel 0 
id 0 lun 0
sr 0:0:0:0: Illegal state transition cancel->offline
Badness in scsi_device_set_state at drivers/scsi/scsi_lib.c:1688
  [<e12bab6e>] scsi_device_set_state+0x9e/0xd0 [scsi_mod]
  [<e12b8a6e>] scsi_eh_offline_sdevs+0x4e/0x70 [scsi_mod]
  [<e12b8f1a>] scsi_unjam_host+0x9a/0x1b0 [scsi_mod]
  [<e12b90f5>] scsi_error_handler+0xc5/0x160 [scsi_mod]
  [<e12b9030>] scsi_error_handler+0x0/0x160 [scsi_mod]
  [<c0104255>] kernel_thread_helper+0x5/0x10

It turned out that in drivers/scsi/hosts.c:scsi_remove_host()
first the host is removed with scsi_forget_host() and _then_ all 
outstanding I/O to this host is cancelled with scsi_host_cancel(). 
Sounds a bit fishy as scsi_host_cancel() tries to talk to a host which 
we just have deleted ...
(Incidentally, this is most likely the same bug as Bug #2752 and #3480 
from bugme.osdl.org :-).
(And also #133249 from bugzilla.redhat.com :-).

The attached patch corrects this.
Please apply.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de

--------------020303080901070907040109
Content-Type: text/x-patch;
 name="remove_scsi_host_after_cancel.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="remove_scsi_host_after_cancel.patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/29 09:27:51+02:00 hare@lammermuir.suse.de 
#   We really should cancel I/O requests before removing the host.
#   
#   Signed-off-by: Hannes Reinecke <hare@suse.de>
# 
# drivers/scsi/hosts.c
#   2004/09/29 09:27:46+02:00 hare@lammermuir.suse.de +1 -1
#   Change ordering to cancel I/O-request before removing the host.
# 
diff -Nru a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
--- a/drivers/scsi/hosts.c	2004-09-29 09:29:19 +02:00
+++ b/drivers/scsi/hosts.c	2004-09-29 09:29:19 +02:00
@@ -75,8 +75,8 @@
  **/
 void scsi_remove_host(struct Scsi_Host *shost)
 {
-	scsi_forget_host(shost);
 	scsi_host_cancel(shost, 0);
+	scsi_forget_host(shost);
 	scsi_proc_host_rm(shost);
 
 	set_bit(SHOST_DEL, &shost->shost_state);

--------------020303080901070907040109--
