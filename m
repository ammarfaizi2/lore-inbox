Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965072AbWBGUTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbWBGUTf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 15:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965064AbWBGUTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 15:19:35 -0500
Received: from verein.lst.de ([213.95.11.210]:10434 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S965048AbWBGUTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 15:19:33 -0500
Date: Tue, 7 Feb 2006 21:19:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: achim_leubner@adaptec.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH](call for testers) gdth: add execute firmware command abstraction
Message-ID: <20060207201914.GA31890@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First step to move gdth and thus one of the two remaining drivers off
the scsi_request interface:

Introduce a gdth_execute abstraction to send a firmware command to a
host.  This gets rid of all the knowledge of scsi_requests or scsi_cmnd
structures everywhere in the drivers (and thus also the big ifdef mess).

As a next step gdth_execute can be switched to a different underlying
mechanism.


 gdth.c      |  335 ++++++++++++++++++++----------------------------------------
 gdth_proc.c |  211 +++----------------------------------
 gdth_proc.h |   17 ---
 3 files changed, 138 insertions(+), 425 deletions(-)

Index: linux-2.6/drivers/scsi/gdth.c
===================================================================
--- linux-2.6.orig/drivers/scsi/gdth.c	2006-02-07 20:12:42.000000000 +0100
+++ linux-2.6/drivers/scsi/gdth.c	2006-02-07 21:12:08.000000000 +0100
@@ -682,6 +682,86 @@
     }
 }
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
+static void gdth_scsi_done(struct scsi_cmnd *scp)
+{
+	TRACE2(("gdth_scsi_done()\n"));
+
+	scp->request->rq_status = RQ_SCSI_DONE;
+	if (scp->request->waiting)
+		complete(scp->request->waiting);
+}
+
+int __gdth_execute(struct scsi_device *sdev, gdth_cmd_str *gdtcmd, char *cmnd,
+		 int timeout, u32 *info)
+{
+	struct scsi_request *scp = scsi_allocate_request(sdev, GFP_KERNEL);
+	unsigned bufflen = gdtcmd ? sizeof(gdth_cmd_str) : 0;
+	DECLARE_COMPLETION(wait);
+	int rval;
+
+	if (!scp)
+		return -ENOMEM;
+	scp->sr_cmd_len = 12;
+	scp->sr_use_sg = 0;
+	scp->sr_request->rq_status = RQ_SCSI_BUSY;
+	scp->sr_request->waiting = &wait;
+	scsi_do_req(scp, cmnd, gdtcmd, bufflen, gdth_scsi_done, timeout*HZ, 1);
+	wait_for_completion(&wait);
+
+	rval = scp->sr_command->SCp.Status;
+	if (info)
+		*info = scp->sr_command->SCp.Message;
+
+	scsi_release_request(scp);
+	return rval;
+}
+#else
+static void gdth_scsi_done(Scsi_Cmnd *scp)
+{
+	TRACE2(("gdth_scsi_done()\n"));
+
+	scp->request.rq_status = RQ_SCSI_DONE;
+	if (scp->request.waiting)
+		complete(scp->request.waiting);
+}
+
+int __gdth_execute(struct scsi_device *sdev, gdth_cmd_str *gdtcmd, char *cmnd,
+		 int timeout, u32 *info)
+{
+	Scsi_Cmnd *scp = scsi_allocate_device(sdev, 1, FALSE);
+	unsigned bufflen = gdtcmd ? sizeof(gdth_cmd_str) : 0;
+	DECLARE_COMPLETION(wait);
+	int rval;
+
+	if (!scp)
+		return -ENOMEM;
+	scp->cmd_len = 12;
+	scp->use_sg = 0;
+	scp->request.rq_status = RQ_SCSI_BUSY;
+	scp->request.waiting = &wait;
+	scsi_do_cmd(scp, cmnd, gdtcmd, bufflen, gdth_scsi_done, timeout*HZ, 1);
+	wait_for_completion(&wait);
+
+	rval = scp->SCp.Status;
+	if (info)
+		*info = scp->SCp.Message;
+
+	scsi_release_command(scp);
+	return rval;
+}
+#endif
+
+int gdth_execute(struct Scsi_Host *shost, gdth_cmd_str *gdtcmd, char *cmnd,
+		 int timeout, u32 *info)
+{
+	struct scsi_device *sdev = scsi_get_host_dev(shost);
+	int rval = __gdth_execute(sdev, gdtcmd, cmnd, timeout, info);
+
+	scsi_free_host_dev(sdev);
+	return rval;
+}
+
 static void gdth_eval_mapping(ulong32 size, ulong32 *cyls, int *heads, int *secs)
 {
     *cyls = size /HEADS/SECS;
@@ -4921,11 +5001,7 @@
     gdth_cmd_str cmd;
     int hanum;
     gdth_ha_str *ha;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-    Scsi_Request *srp;
-#else
-    Scsi_Cmnd *scp;
-#endif
+    int rval;
 
     if (copy_from_user(&res, arg, sizeof(gdth_ioctl_reset)) ||
         res.ionode >= gdth_ctr_count || res.number >= MAX_HDRIVES)
@@ -4942,25 +5018,11 @@
         cmd.u.cache64.DeviceNo = res.number;
     else
         cmd.u.cache.DeviceNo = res.number;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-    srp  = scsi_allocate_request(ha->sdev, GFP_KERNEL);
-    if (!srp)
-        return -ENOMEM;
-    srp->sr_cmd_len = 12;
-    srp->sr_use_sg = 0;
-    gdth_do_req(srp, &cmd, cmnd, 30);
-    res.status = (ushort)srp->sr_command->SCp.Status;
-    scsi_release_request(srp);
-#else
-    scp  = scsi_allocate_device(ha->sdev, 1, FALSE);
-    if (!scp)
-        return -ENOMEM;
-    scp->cmd_len = 12;
-    scp->use_sg = 0;
-    gdth_do_cmd(scp, &cmd, cmnd, 30);
-    res.status = (ushort)scp->SCp.Status;
-    scsi_release_command(scp);
-#endif
+
+    rval = __gdth_execute(ha->sdev, &cmd, cmnd, 30, NULL);
+    if (rval < 0)
+	    return rval;
+    res.status = rval;
 
     if (copy_to_user(arg, &res, sizeof(gdth_ioctl_reset)))
         return -EFAULT;
@@ -4973,12 +5035,8 @@
     char *buf = NULL;
     ulong64 paddr; 
     int hanum;
-        gdth_ha_str *ha; 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-        Scsi_Request *srp;
-#else
-        Scsi_Cmnd *scp;
-#endif
+    gdth_ha_str *ha;
+    int rval;
         
     if (copy_from_user(&gen, arg, sizeof(gdth_ioctl_general)) ||
         gen.ionode >= gdth_ctr_count)
@@ -5070,27 +5128,10 @@
         }
     }
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-    srp  = scsi_allocate_request(ha->sdev, GFP_KERNEL);
-    if (!srp)
-        return -ENOMEM;
-    srp->sr_cmd_len = 12;
-    srp->sr_use_sg = 0;
-    gdth_do_req(srp, &gen.command, cmnd, gen.timeout);
-    gen.status = srp->sr_command->SCp.Status;
-    gen.info = srp->sr_command->SCp.Message;
-    scsi_release_request(srp);
-#else
-    scp  = scsi_allocate_device(ha->sdev, 1, FALSE);
-    if (!scp)
-        return -ENOMEM;
-    scp->cmd_len = 12;
-    scp->use_sg = 0;
-    gdth_do_cmd(scp, &gen.command, cmnd, gen.timeout);
-    gen.status = scp->SCp.Status;
-    gen.info = scp->SCp.Message;
-    scsi_release_command(scp);
-#endif
+    rval = __gdth_execute(ha->sdev, &gen.command, cmnd, gen.timeout, &gen.info);
+    if (rval < 0)
+	    return rval;
+    gen.status = rval;
 
     if (copy_to_user(arg + sizeof(gdth_ioctl_general), buf, 
                      gen.data_len + gen.sense_len)) {
@@ -5113,11 +5154,7 @@
     gdth_ha_str *ha;
     unchar i;
     int hanum, rc = -ENOMEM;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-    Scsi_Request *srp;
-#else
-    Scsi_Cmnd *scp;
-#endif
+    u32 cluster_type = 0;
         
     rsc = kmalloc(sizeof(*rsc), GFP_KERNEL);
     cmd = kmalloc(sizeof(*cmd), GFP_KERNEL);
@@ -5133,20 +5170,6 @@
     ha = HADATA(gdth_ctr_tab[hanum]);
     memset(cmd, 0, sizeof(gdth_cmd_str));
    
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-    srp  = scsi_allocate_request(ha->sdev, GFP_KERNEL);
-    if (!srp)
-        goto free_fail;
-    srp->sr_cmd_len = 12;
-    srp->sr_use_sg = 0;
-#else
-    scp  = scsi_allocate_device(ha->sdev, 1, FALSE);
-    if (!scp)
-        goto free_fail;
-    scp->cmd_len = 12;
-    scp->use_sg = 0;
-#endif
-
     for (i = 0; i < MAX_HDRIVES; ++i) { 
         if (!ha->hdr[i].present) {
             rsc->hdr_list[i].bus = 0xff; 
@@ -5163,22 +5186,10 @@
                 cmd->u.cache64.DeviceNo = i;
             else
                 cmd->u.cache.DeviceNo = i;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-            gdth_do_req(srp, cmd, cmnd, 30);
-            if (srp->sr_command->SCp.Status == S_OK)
-                rsc->hdr_list[i].cluster_type = srp->sr_command->SCp.Message;
-#else
-            gdth_do_cmd(scp, cmd, cmnd, 30);
-            if (scp->SCp.Status == S_OK)
-                rsc->hdr_list[i].cluster_type = scp->SCp.Message;
-#endif
+            if (__gdth_execute(ha->sdev, cmd, cmnd, 30, &cluster_type) == S_OK)
+                rsc->hdr_list[i].cluster_type = cluster_type;
         }
     } 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-    scsi_release_request(srp);
-#else
-    scsi_release_command(scp);
-#endif       
  
     if (copy_to_user(arg, rsc, sizeof(gdth_ioctl_rescan)))
         rc = -EFAULT;
@@ -5201,11 +5212,6 @@
     int rc = -ENOMEM;
     ulong flags;
     gdth_ha_str *ha; 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-    Scsi_Request *srp;
-#else
-    Scsi_Cmnd *scp;
-#endif
 
     rsc = kmalloc(sizeof(*rsc), GFP_KERNEL);
     cmd = kmalloc(sizeof(*cmd), GFP_KERNEL);
@@ -5221,20 +5227,6 @@
     ha = HADATA(gdth_ctr_tab[hanum]);
     memset(cmd, 0, sizeof(gdth_cmd_str));
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-    srp  = scsi_allocate_request(ha->sdev, GFP_KERNEL);
-    if (!srp)
-        goto free_fail;
-    srp->sr_cmd_len = 12;
-    srp->sr_use_sg = 0;
-#else
-    scp  = scsi_allocate_device(ha->sdev, 1, FALSE);
-    if (!scp)
-        goto free_fail;
-    scp->cmd_len = 12;
-    scp->use_sg = 0;
-#endif
-     
     if (rsc->flag == 0) {
         /* old method: re-init. cache service */
         cmd->Service = CACHESERVICE;
@@ -5245,19 +5237,8 @@
             cmd->OpCode = GDT_INIT;
             cmd->u.cache.DeviceNo = LINUX_OS;
         }
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-        gdth_do_req(srp, cmd, cmnd, 30);
-        status = (ushort)srp->sr_command->SCp.Status;
-        info = (ulong32)srp->sr_command->SCp.Message;
-#elif LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
-        gdth_do_cmd(scp, cmd, cmnd, 30);
-        status = (ushort)scp->SCp.Status;
-        info = (ulong32)scp->SCp.Message;
-#else
-        gdth_do_cmd(&scp, cmd, cmnd, 30);
-        status = (ushort)scp.SCp.Status;
-        info = (ulong32)scp.SCp.Message;
-#endif
+
+        status = __gdth_execute(ha->sdev, cmd, cmnd, 30, &info);
         i = 0;
         hdr_cnt = (status == S_OK ? (ushort)info : 0);
     } else {
@@ -5272,15 +5253,9 @@
             cmd->u.cache64.DeviceNo = i;
         else 
             cmd->u.cache.DeviceNo = i;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-        gdth_do_req(srp, cmd, cmnd, 30);
-        status = (ushort)srp->sr_command->SCp.Status;
-        info = (ulong32)srp->sr_command->SCp.Message;
-#else
-        gdth_do_cmd(scp, cmd, cmnd, 30);
-        status = (ushort)scp->SCp.Status;
-        info = (ulong32)scp->SCp.Message;
-#endif
+
+        status = __gdth_execute(ha->sdev, cmd, cmnd, 30, &info);
+
         spin_lock_irqsave(&ha->smp_lock, flags);
         rsc->hdr_list[i].bus = ha->virt_bus;
         rsc->hdr_list[i].target = i;
@@ -5312,15 +5287,9 @@
             cmd->u.cache64.DeviceNo = i;
         else
             cmd->u.cache.DeviceNo = i;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-        gdth_do_req(srp, cmd, cmnd, 30);
-        status = (ushort)srp->sr_command->SCp.Status;
-        info = (ulong32)srp->sr_command->SCp.Message;
-#else
-        gdth_do_cmd(scp, cmd, cmnd, 30);
-        status = (ushort)scp->SCp.Status;
-        info = (ulong32)scp->SCp.Message;
-#endif
+
+        status = __gdth_execute(ha->sdev, cmd, cmnd, 30, &info);
+
         spin_lock_irqsave(&ha->smp_lock, flags);
         ha->hdr[i].devtype = (status == S_OK ? (ushort)info : 0);
         spin_unlock_irqrestore(&ha->smp_lock, flags);
@@ -5331,15 +5300,9 @@
             cmd->u.cache64.DeviceNo = i;
         else
             cmd->u.cache.DeviceNo = i;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-        gdth_do_req(srp, cmd, cmnd, 30);
-        status = (ushort)srp->sr_command->SCp.Status;
-        info = (ulong32)srp->sr_command->SCp.Message;
-#else
-        gdth_do_cmd(scp, cmd, cmnd, 30);
-        status = (ushort)scp->SCp.Status;
-        info = (ulong32)scp->SCp.Message;
-#endif
+
+        status = __gdth_execute(ha->sdev, cmd, cmnd, 30, &info);
+
         spin_lock_irqsave(&ha->smp_lock, flags);
         ha->hdr[i].cluster_type = 
             ((status == S_OK && !shared_access) ? (ushort)info : 0);
@@ -5352,24 +5315,13 @@
             cmd->u.cache64.DeviceNo = i;
         else
             cmd->u.cache.DeviceNo = i;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-        gdth_do_req(srp, cmd, cmnd, 30);
-        status = (ushort)srp->sr_command->SCp.Status;
-        info = (ulong32)srp->sr_command->SCp.Message;
-#else
-        gdth_do_cmd(scp, cmd, cmnd, 30);
-        status = (ushort)scp->SCp.Status;
-        info = (ulong32)scp->SCp.Message;
-#endif
+
+        status = __gdth_execute(ha->sdev, cmd, cmnd, 30, &info);
+
         spin_lock_irqsave(&ha->smp_lock, flags);
         ha->hdr[i].rw_attribs = (status == S_OK ? (ushort)info : 0);
         spin_unlock_irqrestore(&ha->smp_lock, flags);
     }
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-    scsi_release_request(srp);
-#else
-    scsi_release_command(scp);
-#endif       
  
     if (copy_to_user(arg, rsc, sizeof(gdth_ioctl_rescan)))
         rc = -EFAULT;
@@ -5557,34 +5509,12 @@
     int             i;
     gdth_ha_str     *ha;
     gdth_cmd_str    gdtcmd;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-    Scsi_Request    *srp;
-#else
-    Scsi_Cmnd       *scp;
-#endif
-    struct scsi_device     *sdev;
     char            cmnd[MAX_COMMAND_SIZE];   
     memset(cmnd, 0xff, MAX_COMMAND_SIZE);
 
     TRACE2(("gdth_flush() hanum %d\n",hanum));
     ha = HADATA(gdth_ctr_tab[hanum]);
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-    sdev = scsi_get_host_dev(gdth_ctr_tab[hanum]);
-    srp  = scsi_allocate_request(sdev, GFP_KERNEL);
-    if (!srp)
-        return;
-    srp->sr_cmd_len = 12;
-    srp->sr_use_sg = 0;
-#else
-    sdev = scsi_get_host_dev(gdth_ctr_tab[hanum]);
-    scp  = scsi_allocate_device(sdev, 1, FALSE);
-    if (!scp)
-        return;
-    scp->cmd_len = 12;
-    scp->use_sg = 0;
-#endif
-
     for (i = 0; i < MAX_HDRIVES; ++i) {
         if (ha->hdr[i].present) {
             gdtcmd.BoardNode = LOCALBOARD;
@@ -5600,20 +5530,10 @@
                 gdtcmd.u.cache.sg_canz = 0;
             }
             TRACE2(("gdth_flush(): flush ha %d drive %d\n", hanum, i));
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-            gdth_do_req(srp, &gdtcmd, cmnd, 30);
-#else
-            gdth_do_cmd(scp, &gdtcmd, cmnd, 30);
-#endif
+
+            gdth_execute(gdth_ctr_tab[hanum], &gdtcmd, cmnd, 30, NULL);
         }
     }
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-    scsi_release_request(srp);
-    scsi_free_host_dev(sdev);
-#else
-    scsi_release_command(scp);
-    scsi_free_host_dev(sdev);
-#endif
 }
 
 /* shutdown routine */
@@ -5622,13 +5542,6 @@
     int             hanum;
 #ifndef __alpha__
     gdth_cmd_str    gdtcmd;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-    Scsi_Request    *srp;
-    struct scsi_device     *sdev;
-#else
-    Scsi_Cmnd       *scp;
-    struct scsi_device     *sdev;
-#endif
     char            cmnd[MAX_COMMAND_SIZE];   
 #endif
 
@@ -5647,31 +5560,7 @@
         gdtcmd.Service = CACHESERVICE;
         gdtcmd.OpCode = GDT_RESET;
         TRACE2(("gdth_halt(): reset controller %d\n", hanum));
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-        sdev = scsi_get_host_dev(gdth_ctr_tab[hanum]);
-        srp  = scsi_allocate_request(sdev, GFP_KERNEL);
-        if (!srp) {
-            unregister_reboot_notifier(&gdth_notifier);
-            return NOTIFY_OK;
-        }
-        srp->sr_cmd_len = 12;
-        srp->sr_use_sg = 0;
-        gdth_do_req(srp, &gdtcmd, cmnd, 10);
-        scsi_release_request(srp);
-        scsi_free_host_dev(sdev);
-#else
-        sdev = scsi_get_host_dev(gdth_ctr_tab[hanum]);
-        scp  = scsi_allocate_device(sdev, 1, FALSE);
-        if (!scp) {
-            unregister_reboot_notifier(&gdth_notifier);
-            return NOTIFY_OK;
-        }
-        scp->cmd_len = 12;
-        scp->use_sg = 0;
-        gdth_do_cmd(scp, &gdtcmd, cmnd, 10);
-        scsi_release_command(scp);
-        scsi_free_host_dev(sdev);
-#endif
+        gdth_execute(gdth_ctr_tab[hanum], &gdtcmd, cmnd, 10, NULL);
 #endif
     }
     printk("Done.\n");
Index: linux-2.6/drivers/scsi/gdth_proc.c
===================================================================
--- linux-2.6.orig/drivers/scsi/gdth_proc.c	2005-12-27 18:30:30.000000000 +0100
+++ linux-2.6/drivers/scsi/gdth_proc.c	2006-02-07 21:12:43.000000000 +0100
@@ -52,53 +52,21 @@
                          int hanum,int busnum)
 {
     int             ret_val = -EINVAL;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-    Scsi_Request    *scp;
-    struct scsi_device     *sdev;
-#else
-    Scsi_Cmnd       *scp;
-    struct scsi_device     *sdev;
-#endif
-    TRACE2(("gdth_set_info() ha %d bus %d\n",hanum,busnum));
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-    sdev = scsi_get_host_dev(host);
-    scp  = scsi_allocate_request(sdev, GFP_KERNEL);
-    if (!scp)
-        return -ENOMEM;
-    scp->sr_cmd_len = 12;
-    scp->sr_use_sg = 0;
-#else
-    sdev = scsi_get_host_dev(host);
-    scp  = scsi_allocate_device(sdev, 1, FALSE);
-    if (!scp)
-        return -ENOMEM;
-    scp->cmd_len = 12;
-    scp->use_sg = 0;
-#endif
+    TRACE2(("gdth_set_info() ha %d bus %d\n",hanum,busnum));
 
     if (length >= 4) {
         if (strncmp(buffer,"gdth",4) == 0) {
             buffer += 5;
             length -= 5;
-            ret_val = gdth_set_asc_info( buffer, length, hanum, scp );
+            ret_val = gdth_set_asc_info(host, buffer, length, hanum);
         }
     }
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-    scsi_release_request(scp);
-    scsi_free_host_dev(sdev);
-#else
-    scsi_release_command(scp);
-    scsi_free_host_dev(sdev);
-#endif
+
     return ret_val;
 }
          
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-static int gdth_set_asc_info(char *buffer,int length,int hanum,Scsi_Request *scp)
-#else
-static int gdth_set_asc_info(char *buffer,int length,int hanum,Scsi_Cmnd *scp)
-#endif
+static int gdth_set_asc_info(struct Scsi_Host *host, char *buffer,int length,int hanum)
 {
     int             orig_length, drive, wb_mode;
     int             i, found;
@@ -146,11 +114,8 @@
                     gdtcmd.u.cache.DeviceNo = i;
                     gdtcmd.u.cache.BlockNo = 1;
                 }
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-                gdth_do_req(scp, &gdtcmd, cmnd, 30);
-#else
-                gdth_do_cmd(scp, &gdtcmd, cmnd, 30);
-#endif
+
+                gdth_execute(host, &gdtcmd, cmnd, 30, NULL);
             }
         }
         if (!found)
@@ -202,11 +167,9 @@
         gdtcmd.u.ioctl.subfunc = CACHE_CONFIG;
         gdtcmd.u.ioctl.channel = INVALID_CHANNEL;
         pcpar->write_back = wb_mode==1 ? 0:1;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-        gdth_do_req(scp, &gdtcmd, cmnd, 30);
-#else
-        gdth_do_cmd(scp, &gdtcmd, cmnd, 30);
-#endif
+
+        gdth_execute(host, &gdtcmd, cmnd, 30, NULL);
+
         gdth_ioctl_free(hanum, GDTH_SCRATCH, ha->pscratch, paddr);
         printk("Done.\n");
         return(orig_length);
@@ -230,13 +193,6 @@
 
     gdth_cmd_str *gdtcmd;
     gdth_evt_str *estr;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-    Scsi_Request *scp;
-    struct scsi_device *sdev;
-#else
-    Scsi_Cmnd *scp;
-    struct scsi_device *sdev;
-#endif
     char hrec[161];
     struct timeval tv;
 
@@ -260,29 +216,6 @@
     TRACE2(("gdth_get_info() ha %d bus %d\n",hanum,busnum));
     ha = HADATA(gdth_ctr_tab[hanum]);
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-    sdev = scsi_get_host_dev(host);
-    scp  = scsi_allocate_request(sdev, GFP_KERNEL);
-    if (!scp)
-        goto free_fail;
-    scp->sr_cmd_len = 12;
-    scp->sr_use_sg = 0;
-#elif LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
-    sdev = scsi_get_host_dev(host);
-    scp  = scsi_allocate_device(sdev, 1, FALSE);
-    if (!scp)
-        goto free_fail;
-    scp->cmd_len = 12;
-    scp->use_sg = 0;
-#else
-    memset(&sdev,0,sizeof(struct scsi_device));
-    memset(&scp, 0,sizeof(Scsi_Cmnd));
-    sdev.host = scp.host = host;
-    sdev.id = scp.target = sdev.host->this_id;
-    scp.device = &sdev;
-#endif
-    
-    
     /* request is i.e. "cat /proc/scsi/gdth/0" */ 
     /* format: %-15s\t%-10s\t%-15s\t%s */
     /* driver parameters */
@@ -386,16 +319,9 @@
                 sizeof(pds->list[0]);
             if (pds->entries > cnt)
                 pds->entries = cnt;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-            gdth_do_req(scp, gdtcmd, cmnd, 30);
-            if (scp->sr_command->SCp.Status != S_OK) 
-#else
-            gdth_do_cmd(scp, gdtcmd, cmnd, 30);
-            if (scp->SCp.Status != S_OK) 
-#endif
-            { 
+
+            if (gdth_execute(host, gdtcmd, cmnd, 30, NULL) != S_OK)
                 pds->count = 0;
-            }
 
             /* other IOCTLs must fit into area GDTH_SCRATCH/4 */
             for (j = 0; j < ha->raw[i].pdev_cnt; ++j) {
@@ -410,14 +336,8 @@
                 gdtcmd->u.ioctl.subfunc = SCSI_DR_INFO | L_CTRL_PATTERN;
                 gdtcmd->u.ioctl.channel = 
                     ha->raw[i].address | ha->raw[i].id_list[j];
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-                gdth_do_req(scp, gdtcmd, cmnd, 30);
-                if (scp->sr_command->SCp.Status == S_OK) 
-#else
-                gdth_do_cmd(scp, gdtcmd, cmnd, 30);
-                if (scp->SCp.Status == S_OK) 
-#endif
-                {
+
+                if (gdth_execute(host, gdtcmd, cmnd, 30, NULL) == S_OK) {
                     strncpy(hrec,pdi->vendor,8);
                     strncpy(hrec+8,pdi->product,16);
                     strncpy(hrec+24,pdi->revision,4);
@@ -466,14 +386,9 @@
                     gdtcmd->u.ioctl.channel = 
                         ha->raw[i].address | ha->raw[i].id_list[j];
                     pdef->sddc_type = 0x08;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-                    gdth_do_req(scp, gdtcmd, cmnd, 30);
-                    if (scp->sr_command->SCp.Status == S_OK) 
-#else
-                    gdth_do_cmd(scp, gdtcmd, cmnd, 30);
-                    if (scp->SCp.Status == S_OK) 
-#endif
-                    {
+
+
+                    if (gdth_execute(host, gdtcmd, cmnd, 30, NULL) == S_OK) {
                         size = sprintf(buffer+len,
                                        " Grown Defects:\t%d\n",
                                        pdef->sddc_cnt);
@@ -519,16 +434,8 @@
                 gdtcmd->u.ioctl.param_size = sizeof(gdth_cdrinfo_str);
                 gdtcmd->u.ioctl.subfunc = CACHE_DRV_INFO;
                 gdtcmd->u.ioctl.channel = drv_no;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-                gdth_do_req(scp, gdtcmd, cmnd, 30);
-                if (scp->sr_command->SCp.Status != S_OK) 
-#else
-                gdth_do_cmd(scp, gdtcmd, cmnd, 30);
-                if (scp->SCp.Status != S_OK)
-#endif
-                {
+                if (gdth_execute(host, gdtcmd, cmnd, 30, NULL) != S_OK)
                     break;
-                }
                 pcdi->ld_dtype >>= 16;
                 j++;
                 if (pcdi->ld_dtype > 2) {
@@ -629,14 +536,8 @@
             gdtcmd->u.ioctl.param_size = sizeof(gdth_arrayinf_str);
             gdtcmd->u.ioctl.subfunc = ARRAY_INFO | LA_CTRL_PATTERN;
             gdtcmd->u.ioctl.channel = i;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-            gdth_do_req(scp, gdtcmd, cmnd, 30);
-            if (scp->sr_command->SCp.Status == S_OK) 
-#else
-            gdth_do_cmd(scp, gdtcmd, cmnd, 30);
-            if (scp->SCp.Status == S_OK) 
-#endif
-            {
+
+            if (gdth_execute(host, gdtcmd, cmnd, 30, NULL) == S_OK) {
                 if (pai->ai_state == 0)
                     strcpy(hrec, "idle");
                 else if (pai->ai_state == 2)
@@ -710,14 +611,8 @@
             gdtcmd->u.ioctl.channel = i;
             phg->entries = MAX_HDRIVES;
             phg->offset = GDTOFFSOF(gdth_hget_str, entry[0]); 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-            gdth_do_req(scp, gdtcmd, cmnd, 30);
-            if (scp->sr_command->SCp.Status != S_OK) 
-#else
-            gdth_do_cmd(scp, gdtcmd, cmnd, 30);
-            if (scp->SCp.Status != S_OK) 
-#endif
-            {
+
+	    if (gdth_execute(host, gdtcmd, cmnd, 30, NULL) == S_OK) {
                 ha->hdr[i].ldr_no = i;
                 ha->hdr[i].rw_attribs = 0;
                 ha->hdr[i].start_sec = 0;
@@ -791,13 +686,6 @@
     }
 
 stop_output:
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-    scsi_release_request(scp);
-    scsi_free_host_dev(sdev);
-#else
-    scsi_release_command(scp);
-    scsi_free_host_dev(sdev);
-#endif
     *start = buffer +(offset-begin);
     len -= (offset-begin);
     if (len > length)
@@ -813,63 +701,6 @@
 }
 
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-static void gdth_do_req(Scsi_Request *scp, gdth_cmd_str *gdtcmd, 
-                        char *cmnd, int timeout)
-{
-    unsigned bufflen;
-    DECLARE_COMPLETION(wait);
-
-    TRACE2(("gdth_do_req()\n"));
-    if (gdtcmd != NULL) { 
-        bufflen = sizeof(gdth_cmd_str);
-    } else {
-        bufflen = 0;
-    }
-    scp->sr_request->rq_status = RQ_SCSI_BUSY;
-    scp->sr_request->waiting = &wait;
-    scsi_do_req(scp, cmnd, gdtcmd, bufflen, gdth_scsi_done, timeout*HZ, 1);
-    wait_for_completion(&wait);
-}
-
-#else
-static void gdth_do_cmd(Scsi_Cmnd *scp, gdth_cmd_str *gdtcmd, 
-                        char *cmnd, int timeout)
-{
-    unsigned bufflen;
-    DECLARE_COMPLETION(wait);
-
-    TRACE2(("gdth_do_cmd()\n"));
-    if (gdtcmd != NULL) { 
-        scp->SCp.this_residual = IOCTL_PRI;
-        bufflen = sizeof(gdth_cmd_str);
-    } else {
-        scp->SCp.this_residual = DEFAULT_PRI;
-        bufflen = 0;
-    }
-
-    scp->request.rq_status = RQ_SCSI_BUSY;
-    scp->request.waiting = &wait;
-    scsi_do_cmd(scp, cmnd, gdtcmd, bufflen, gdth_scsi_done, timeout*HZ, 1);
-    wait_for_completion(&wait);
-}
-#endif
-
-void gdth_scsi_done(Scsi_Cmnd *scp)
-{
-    TRACE2(("gdth_scsi_done()\n"));
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-    scp->request->rq_status = RQ_SCSI_DONE;
-    if (scp->request->waiting != NULL)
-        complete(scp->request->waiting);
-#else
-    scp->request.rq_status = RQ_SCSI_DONE;
-    if (scp->request.waiting != NULL)
-        complete(scp->request.waiting);
-#endif
-}
-
 static char *gdth_ioctl_alloc(int hanum, int size, int scratch, 
                               ulong64 *paddr)
 {
Index: linux-2.6/drivers/scsi/gdth_proc.h
===================================================================
--- linux-2.6.orig/drivers/scsi/gdth_proc.h	2005-12-27 18:30:30.000000000 +0100
+++ linux-2.6/drivers/scsi/gdth_proc.h	2006-02-07 21:12:35.000000000 +0100
@@ -5,20 +5,15 @@
  * $Id: gdth_proc.h,v 1.16 2004/01/14 13:09:01 achim Exp $
  */
 
+int gdth_execute(struct Scsi_Host *shost, gdth_cmd_str *gdtcmd, char *cmnd,
+		 int timeout, u32 *info);
+
 static int gdth_set_info(char *buffer,int length,struct Scsi_Host *host,
                          int hanum,int busnum);
 static int gdth_get_info(char *buffer,char **start,off_t offset,int length,
                          struct Scsi_Host *host,int hanum,int busnum);
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-static void gdth_do_req(Scsi_Request *srp, gdth_cmd_str *cmd, 
-                        char *cmnd, int timeout);
-static int gdth_set_asc_info(char *buffer,int length,int hanum,Scsi_Request *scp);
-#else
-static void gdth_do_cmd(Scsi_Cmnd *scp, gdth_cmd_str *cmd, 
-                        char *cmnd, int timeout);
-static int gdth_set_asc_info(char *buffer,int length,int hanum,Scsi_Cmnd *scp);
-#endif
+static int gdth_set_asc_info(struct Scsi_Host *host, char *buffer,
+			 int length, int hanum);
 
 static char *gdth_ioctl_alloc(int hanum, int size, int scratch,
                               ulong64 *paddr);  
@@ -28,7 +23,5 @@
 static void gdth_start_timeout(int hanum, int busnum, int id);
 static int gdth_update_timeout(int hanum, Scsi_Cmnd *scp, int timeout);
 
-void gdth_scsi_done(Scsi_Cmnd *scp);
-
 #endif
 
