Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267408AbTBKQo0>; Tue, 11 Feb 2003 11:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267426AbTBKQo0>; Tue, 11 Feb 2003 11:44:26 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:29328 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267408AbTBKQoX>; Tue, 11 Feb 2003 11:44:23 -0500
Date: Tue, 11 Feb 2003 08:55:08 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: "James H. Cloos Jr." <cloos@jhcloos.com>, randy.dunlap@verizon.net,
       linux-kernel@vger.kernel.org, james.bottomley@steeleye.com,
       campbell@torque.net
Subject: Re: [PATCH] scsi/imm.c compile errors in 2.5.60
Message-ID: <20030211165508.GB3164@beaverton.ibm.com>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	"James H. Cloos Jr." <cloos@jhcloos.com>, randy.dunlap@verizon.net,
	linux-kernel@vger.kernel.org, james.bottomley@steeleye.com,
	campbell@torque.net
References: <20030211083453.GA6787@beaverton.ibm.com> <m3znp3q8sv.fsf@lugabout.jhcloos.org> <20030211075447.1fa7b98e.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030211075447.1fa7b98e.rddunlap@osdl.org>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap [rddunlap@osdl.org] wrote:
> On 11 Feb 2003 07:52:00 -0500
> "James H. Cloos Jr." <cloos@jhcloos.com> wrote:
> 
> | Mike> Randy, It looks good. I cc'd David Campbell the listed
> | Mike> maintainer of the driver just to let him know of the update.
> | 
> | scsi/ppa.c (iomega's other scsi-over-parallel protocol) probably needs
> | the same fix.
> 
> Yes, I was planning to go thru drivers/scsi/ looking for others
> that need this repair.
> 
> --
> ~Randy

Here is ppa.c. It has only been compiled, not tested.

-andmike
--
Michael Anderson
andmike@us.ibm.com

 ppa.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)
------

===== drivers/scsi/ppa.c 1.17 vs edited =====
--- 1.17/drivers/scsi/ppa.c	Mon Nov 18 11:07:55 2002
+++ edited/drivers/scsi/ppa.c	Tue Feb 11 08:53:21 2003
@@ -106,7 +106,7 @@
 
 int ppa_detect(Scsi_Host_Template * host)
 {
-    struct Scsi_Host *hreg;
+    struct Scsi_Host *hreg = NULL;
     int ports;
     int i, nhosts, try_again;
     struct parport *pb;
@@ -148,7 +148,7 @@
 		      "pardevice is owning the port for too longtime!\n",
 			   i);
 		    parport_unregister_device(ppa_hosts[i].dev);
-		    spin_lock_irq(ppa_hosts[i].cur_cmd->host->host_lock);
+		    spin_lock_irq(ppa_hosts[i].cur_cmd->device->host->host_lock);
 		    return 0;
 		}
 	    }
@@ -635,7 +635,7 @@
 
 static inline int ppa_send_command(Scsi_Cmnd * cmd)
 {
-    int host_no = cmd->host->unique_id;
+    int host_no = cmd->device->host->unique_id;
     int k;
 
     w_ctr(PPA_BASE(host_no), 0x0c);
@@ -661,7 +661,7 @@
      *  0     Told to schedule
      *  1     Finished data transfer
      */
-    int host_no = cmd->host->unique_id;
+    int host_no = cmd->device->host->unique_id;
     unsigned short ppb = PPA_BASE(host_no);
     unsigned long start_jiffies = jiffies;
 
@@ -752,7 +752,7 @@
 int ppa_command(Scsi_Cmnd * cmd)
 {
     static int first_pass = 1;
-    int host_no = cmd->host->unique_id;
+    int host_no = cmd->device->host->unique_id;
 
     if (first_pass) {
 	printk("ppa: using non-queuing interface\n");
@@ -774,7 +774,7 @@
 	schedule();
 
     if (cmd->SCp.phase)		/* Only disconnect if we have connected */
-	ppa_disconnect(cmd->host->unique_id);
+	ppa_disconnect(cmd->device->host->unique_id);
 
     ppa_pb_release(host_no);
     ppa_hosts[host_no].cur_cmd = 0;
@@ -836,21 +836,21 @@
 #endif
 
     if (cmd->SCp.phase > 1)
-	ppa_disconnect(cmd->host->unique_id);
+	ppa_disconnect(cmd->device->host->unique_id);
     if (cmd->SCp.phase > 0)
-	ppa_pb_release(cmd->host->unique_id);
+	ppa_pb_release(cmd->device->host->unique_id);
 
     tmp->cur_cmd = 0;
     
-    spin_lock_irqsave(cmd->host->host_lock, flags);
+    spin_lock_irqsave(cmd->device->host->host_lock, flags);
     cmd->scsi_done(cmd);
-    spin_unlock_irqrestore(cmd->host->host_lock, flags);
+    spin_unlock_irqrestore(cmd->device->host->host_lock, flags);
     return;
 }
 
 static int ppa_engine(ppa_struct * tmp, Scsi_Cmnd * cmd)
 {
-    int host_no = cmd->host->unique_id;
+    int host_no = cmd->device->host->unique_id;
     unsigned short ppb = PPA_BASE(host_no);
     unsigned char l = 0, h = 0;
     int retv;
@@ -900,7 +900,7 @@
 	}
 
     case 2:			/* Phase 2 - We are now talking to the scsi bus */
-	if (!ppa_select(host_no, cmd->target)) {
+	if (!ppa_select(host_no, cmd->device->id)) {
 	    ppa_fail(host_no, DID_NO_CONNECT);
 	    return 0;
 	}
@@ -966,7 +966,7 @@
 
 int ppa_queuecommand(Scsi_Cmnd * cmd, void (*done) (Scsi_Cmnd *))
 {
-    int host_no = cmd->host->unique_id;
+    int host_no = cmd->device->host->unique_id;
 
     if (ppa_hosts[host_no].cur_cmd) {
 	printk("PPA: bug in ppa_queuecommand\n");
@@ -1011,7 +1011,7 @@
 
 int ppa_abort(Scsi_Cmnd * cmd)
 {
-    int host_no = cmd->host->unique_id;
+    int host_no = cmd->device->host->unique_id;
     /*
      * There is no method for aborting commands since Iomega
      * have tied the SCSI_MESSAGE line high in the interface
@@ -1039,7 +1039,7 @@
 
 int ppa_reset(Scsi_Cmnd * cmd)
 {
-    int host_no = cmd->host->unique_id;
+    int host_no = cmd->device->host->unique_id;
 
     if (cmd->SCp.phase)
 	ppa_disconnect(host_no);
