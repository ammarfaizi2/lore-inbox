Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261308AbSJLRkc>; Sat, 12 Oct 2002 13:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261307AbSJLRkc>; Sat, 12 Oct 2002 13:40:32 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:1787 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261301AbSJLRkZ>;
	Sat, 12 Oct 2002 13:40:25 -0400
Date: Sat, 12 Oct 2002 10:47:22 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: "Jeffery, David" <David_Jeffery@adaptec.com>
Cc: "'Dave Hansen'" <haveblue@us.ibm.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Degraded I/O performance, since 2.5.41
Message-ID: <20021012174722.GA1793@beaverton.ibm.com>
Mail-Followup-To: "Jeffery, David" <David_Jeffery@adaptec.com>,
	'Dave Hansen' <haveblue@us.ibm.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <A3B9245C291EEF4785A24A1DBE8D852B0376B0@rtpexc01.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A3B9245C291EEF4785A24A1DBE8D852B0376B0@rtpexc01.adaptec.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if this is a resend it looked this did not make it onto the list
Friday.

Jeffery, David [David_Jeffery@adaptec.com] wrote:
> > Yes, they are better, but still about 10% below what I was seeing 
> > before.  Thank you for getting this out so quickly.  I can do 
> > reasonable work with this.

Dave H,

The short term patch will not bring your queue_depth value back up all
the way. The ips drivers cmd_per_lun value is 16. The old method would
distribute the queue_depth among the devices on the adapter. I believe
your system has a ServeRAID 4M which means you could have had a
queue_depth as high as 95. This seems high but from your numbers a value
higher than 16 is most likely needed.

You can check your old and new values post booting the kernel if you have
sg configured in with:

cat /proc/scsi/sg/device_hdr /proc/scsi/sg/devices

> 
> I'm using an older 2.5 kernel so I hadn't seen the performance drop.
> I'll update my kernel and get to work on it next week when I have

David J,
Here is a quick patch for you to review. I tested and seems to bring my
system back up to per patch queue depth values. I used a enq value to
simulate past behavior in the attach function. I tested with one logical
and two logical devices.


Here is some sg output at different kernel and logical driver values.

2.5.40 1 logical drive:
host    chan    id      lun     type    opens   qdepth  busy    online
0       0       0       0       0       3       31      0       1

2.5.40 2 logical drives:
host    chan    id      lun     type    opens   qdepth  busy    online
0       0       0       0       0       3       15      0       1
0       0       1       0       0       0       15      0       1

2.5 current 2 logical drives: 
host    chan    id      lun     type    opens   qdepth  busy    online
0       0       0       0       0       3       1       0       1
0       0       1       0       0       0       1       0       1

2.5 current 2 logical drives + patch:
host    chan    id      lun     type    opens   qdepth  busy    online
0       0       0       0       0       3       15      0       1
0       0       1       0       0       0       7       0       1

2.5 current 2 logical drives + patch post some IO:
host    chan    id      lun     type    opens   qdepth  busy    online
0       0       0       0       0       3       15      0       1
0       0       1       0       0       0       15      0       1

-andmike
--
Michael Anderson
andmike@us.ibm.com

 ips.c |   47 ++++++++++++++++-------------------------------
 ips.h |    3 ++-
 2 files changed, 18 insertions(+), 32 deletions(-)
------

--- 1.26/drivers/scsi/ips.c	Tue Oct  8 00:51:39 2002
+++ edited/drivers/scsi/ips.c	Fri Oct 11 13:24:08 2002
@@ -481,7 +481,6 @@
 static void ips_free_flash_copperhead(ips_ha_t *ha);
 static void ips_get_bios_version(ips_ha_t *, int);
 static void ips_identify_controller(ips_ha_t *);
-static void ips_select_queue_depth(struct Scsi_Host *, Scsi_Device *);
 static void ips_chkstatus(ips_ha_t *, IPS_STATUS *);
 static void ips_enable_int_copperhead(ips_ha_t *);
 static void ips_enable_int_copperhead_memio(ips_ha_t *);
@@ -1087,7 +1086,6 @@
          sh->n_io_port = io_addr ? 255 : 0;
          sh->unique_id = (io_addr) ? io_addr : mem_addr;
          sh->irq = irq;
-         sh->select_queue_depths = ips_select_queue_depth;
          sh->sg_tablesize = sh->hostt->sg_tablesize;
          sh->can_queue = sh->hostt->can_queue;
          sh->cmd_per_lun = sh->hostt->cmd_per_lun;
@@ -1820,45 +1818,33 @@
 
 /****************************************************************************/
 /*                                                                          */
-/* Routine Name: ips_select_queue_depth                                     */
+/* Routine Name: ips_slave_attach                                           */
 /*                                                                          */
 /* Routine Description:                                                     */
 /*                                                                          */
-/*   Select queue depths for the devices on the contoller                   */
+/*   Configure the device we are attaching to this controller               */
 /*                                                                          */
 /****************************************************************************/
-static void
-ips_select_queue_depth(struct Scsi_Host *host, Scsi_Device *scsi_devs) {
-   Scsi_Device *device;
+int
+ips_slave_attach(Scsi_Device *scsi_dev) {
    ips_ha_t    *ha;
-   int          count = 0;
-   int          min;
+   int          queue_depth;
+   int          min, per_logical;
+
+   ha = (ips_ha_t *) scsi_dev->host->hostdata;;
 
-   ha = IPS_HA(host);
    min = ha->max_cmds / 4;
+   per_logical = ( ha->max_cmds -1 ) / ha->enq->ucLogDriveCount;
 
-   for (device = scsi_devs; device; device = device->next) {
-     if (device->host == host) {
-        if ((device->channel == 0) && (device->type == 0))
-           count++;
-     }
+   if ((scsi_dev->channel == 0) && (scsi_dev->type == 0)) {
+      queue_depth = max(per_logical, min);
+   } else {
+      queue_depth = 2;
    }
 
-   for (device = scsi_devs; device; device = device->next) {
-      if (device->host == host) {
-         if ((device->channel == 0) && (device->type == 0)) {
-            device->queue_depth = ( ha->max_cmds - 1 ) / count;
-            if (device->queue_depth < min) 
-               device->queue_depth = min;
-         }
-         else {
-            device->queue_depth = 2;
-         }
-
-         if (device->queue_depth < 2)
-            device->queue_depth = 2;
-      }
-   }
+   scsi_adjust_queue_depth(scsi_dev, 0, queue_depth);
+   
+   return 0;
 }
 
 /****************************************************************************/
@@ -7407,7 +7393,6 @@
     sh->n_io_port = io_addr ? 255 : 0;
     sh->unique_id = (io_addr) ? io_addr : mem_addr;
     sh->irq = irq;
-    sh->select_queue_depths = ips_select_queue_depth;
     sh->sg_tablesize = sh->hostt->sg_tablesize;
     sh->can_queue = sh->hostt->can_queue;
     sh->cmd_per_lun = sh->hostt->cmd_per_lun;
--- 1.9/drivers/scsi/ips.h	Tue Oct  8 00:51:39 2002
+++ edited/drivers/scsi/ips.h	Fri Oct 11 11:39:14 2002
@@ -62,6 +62,7 @@
    extern int ips_biosparam(Disk *, struct block_device *, int *);
    extern const char * ips_info(struct Scsi_Host *);
    extern void do_ips(int, void *, struct pt_regs *);
+   extern int ips_slave_attach(Scsi_Device *);
 
    /*
     * Some handy macros
@@ -481,7 +482,7 @@
     eh_host_reset_handler : ips_eh_reset, \
     abort : NULL,                         \
     reset : NULL,                         \
-    slave_attach : NULL,                  \
+    slave_attach : ips_slave_attach,      \
     bios_param : ips_biosparam,           \
     can_queue : 0,                        \
     this_id: -1,                          \


