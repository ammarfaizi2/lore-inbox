Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318868AbSICR4r>; Tue, 3 Sep 2002 13:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318861AbSICR4r>; Tue, 3 Sep 2002 13:56:47 -0400
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:32908 "EHLO
	falcon.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S318838AbSICR4o>; Tue, 3 Sep 2002 13:56:44 -0400
Date: Tue, 3 Sep 2002 14:06:26 -0400
To: linux-kernel@vger.kernel.org
Cc: dledford@redhat.com, ehw@lanl.gov, linux-scsi@vger.kernel.org
Subject: [patch] qlogic "this should not happen"
Message-ID: <20020903180626.GA20013@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch tested on 2.5.31, 2.5.31-mm1, 2.5.32-mm1, 2.5.32-mm2.

Without patch, 2.5.x during heavy benchmark/stress testing
eventually locks up with these final messages:

kernel: qlogicfc0 : no handle slots, this should not happen.
kernel: hostdata->queued is 6, in_ptr: 7d

Derived from Doug Ledford's patch:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103005703808312&w=2
and Eric Weigle's patch:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103005790509079&w=2

2.5.33 locked up without the patch.  

diff -ruN linux-2.5.33/drivers/scsi/qlogicfc.c linux/drivers/scsi/qlogicfc.c
--- linux-2.5.33/drivers/scsi/qlogicfc.c        2002-07-24 19:09:03.000000000 -0400
+++ linux/drivers/scsi/qlogicfc.c       2002-09-01 16:44:33.000000000 -0400
@@ -1342,18 +1342,11 @@

        num_free = QLOGICFC_REQ_QUEUE_LEN - REQ_QUEUE_DEPTH(in_ptr, out_ptr);
        num_free = (num_free > 2) ? num_free - 2 : 0;
-       host->can_queue = hostdata->queued + num_free;
+       host->can_queue = host->host_busy + num_free;
        if (host->can_queue > QLOGICFC_REQ_QUEUE_LEN)
                host->can_queue = QLOGICFC_REQ_QUEUE_LEN;
        host->sg_tablesize = QLOGICFC_MAX_SG(num_free);

-       /* this is really gross */
-       if (host->can_queue <= host->host_busy){
-               if (host->can_queue+2 < host->host_busy)
-                       DEBUG(printk("qlogicfc%d.c crosses its fingers.\n", hostdata->host_id));
-               host->can_queue = host->host_busy + 1;
-       }
-
        LEAVE("isp2x00_queuecommand");

        return 0;
@@ -1623,17 +1616,11 @@

        num_free = QLOGICFC_REQ_QUEUE_LEN - REQ_QUEUE_DEPTH(in_ptr, out_ptr);
        num_free = (num_free > 2) ? num_free - 2 : 0;
-       host->can_queue = hostdata->queued + num_free;
+       host->can_queue = host->host_busy + num_free;
        if (host->can_queue > QLOGICFC_REQ_QUEUE_LEN)
                host->can_queue = QLOGICFC_REQ_QUEUE_LEN;
        host->sg_tablesize = QLOGICFC_MAX_SG(num_free);

-       if (host->can_queue <= host->host_busy){
-               if (host->can_queue+2 < host->host_busy)
-                       DEBUG(printk("qlogicfc%d : crosses its fingers.\n", hostdata->host_id));
-               host->can_queue = host->host_busy + 1;
-       }
-
        outw(HCCR_CLEAR_RISC_INTR, host->io_port + HOST_HCCR);
        LEAVE_INTR("isp2x00_intr_handler");
 }
diff -ruN linux-2.5.33/drivers/scsi/qlogicfc.h linux/drivers/scsi/qlogicfc.h
--- linux-2.5.33/drivers/scsi/qlogicfc.h        2002-07-24 19:09:03.000000000 -0400
+++ linux/drivers/scsi/qlogicfc.h       2002-09-01 16:41:47.000000000 -0400
@@ -65,7 +65,7 @@
 #define DATASEGS_PER_COMMAND 2
 #define DATASEGS_PER_CONT 5

-#define QLOGICFC_REQ_QUEUE_LEN 127     /* must be power of two - 1 */
+#define QLOGICFC_REQ_QUEUE_LEN 255     /* must be power of two - 1 */
 #define QLOGICFC_MAX_SG(ql)    (DATASEGS_PER_COMMAND + (((ql) > 0) ? DATASEGS_PER_CONT*((ql) - 1) : 0))
 #define QLOGICFC_CMD_PER_LUN    8

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

