Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbSJQMGI>; Thu, 17 Oct 2002 08:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261531AbSJQMF2>; Thu, 17 Oct 2002 08:05:28 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:22461 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261520AbSJQMCw>; Thu, 17 Oct 2002 08:02:52 -0400
Date: Thu, 17 Oct 2002 01:12:09 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi host cleanup 1/3 (base) (corrected)
Message-ID: <20021017081209.GA5933@beaverton.ibm.com>
Mail-Followup-To: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20021017065112.GA1977@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017065112.GA1977@beaverton.ibm.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had diffed against a tree missing a compile fix this is the correct base
patch.

This is a resend of my previous patch clean ups to the scsi_host lists.

	* Made function naming consistent with rest of SCSI
	* Corrected a problem with driverfs registration to early. Also
	  changed from put_device to device_unregister.
        * Fixed a regression in my previous patch that the scsi_host
          list was not sorted by host number. When we get some device
          naming this hack can be removed.
        * Switch scsi host template, name, host lists to struct
          list_head's.
        * Moved all scsi_host related register / unregister functions
          into hosts.c
        * Added list accessor interface and created a function similar
          to driverfs bus_for_each_dev.

The full patch is available at:
http://www-124.ibm.com/storageio/patches/2.5/scsi-host

-andmike
--
Michael Anderson
andmike@us.ibm.com

 hosts.c |  890 +++++++++++++++++++++++++++++++++++++++++++++++++---------------
 hosts.h |   97 +++---
 2 files changed, 734 insertions(+), 253 deletions(-)
------

diff -Nru a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
--- a/drivers/scsi/hosts.c	Thu Oct 17 00:53:47 2002
+++ b/drivers/scsi/hosts.c	Thu Oct 17 00:53:47 2002
@@ -15,12 +15,15 @@
  *  Updated to reflect the new initialization scheme for the higher 
  *  level of scsi drivers (sd/sr/st)
  *  September 17, 2000 Torben Mathiasen <tmm@image.dk>
+ *
+ *  Restructured scsi_host lists and associated functions.
+ *  September 04, 2002 Mike Anderson (andmike@us.ibm.com)
  */
 
 
 /*
  *  This file contains the medium level SCSI
- *  host interface initialization, as well as the scsi_hosts array of SCSI
+ *  host interface initialization, as well as the scsi_hosts list of SCSI
  *  hosts currently present in the system.
  */
 
@@ -31,232 +34,711 @@
 #include <linux/mm.h>
 #include <linux/proc_fs.h>
 #include <linux/init.h>
+#include <linux/list.h>
+#include <linux/smp_lock.h>
 
 #define __KERNEL_SYSCALLS__
 
 #include <linux/unistd.h>
+#include <asm/dma.h>
 
 #include "scsi.h"
 #include "hosts.h"
 
-/*
-static const char RCSid[] = "$Header: /vger/u4/cvs/linux/drivers/scsi/hosts.c,v 1.20 1996/12/12 19:18:32 davem Exp $";
-*/
+LIST_HEAD(scsi_host_tmpl_list);
+LIST_HEAD(scsi_host_hn_list);
 
-/*
- *  The scsi host entries should be in the order you wish the
- *  cards to be detected.  A driver may appear more than once IFF
- *  it can deal with being detected (and therefore initialized)
- *  with more than one simultaneous host number, can handle being
- *  reentrant, etc.
+LIST_HEAD(scsi_host_list);
+spinlock_t scsi_host_list_lock = SPIN_LOCK_UNLOCKED;
+
+struct Scsi_Device_Template * scsi_devicelist;
+
+static int scsi_host_next_hn;		/* host_no for next new host */
+static int scsi_hosts_registered;	/* cnt of registered scsi hosts */
+
+/**
+ * scsi_tp_for_each_host - call function for each scsi host off a template
+ * @shost_tp:	a pointer to a scsi host template
+ * @callback:	a pointer to callback function
  *
- *  They may appear in any order, as each SCSI host is told which host 
- *  number it is during detection.
- */
+ * Return value:
+ * 	0 on Success / 1 on Failure
+ **/
+int scsi_tp_for_each_host(Scsi_Host_Template *shost_tp, int
+			    (*callback)(struct Scsi_Host *shost))
+{
+	struct list_head *lh, *lh_sf;
+	struct Scsi_Host *shost;
 
-/*
- *  When figure is run, we don't want to link to any object code.  Since
- *  the macro for each host will contain function pointers, we cannot
- *  use it and instead must use a "blank" that does no such
- *  idiocy.
- */
+	spin_lock(&scsi_host_list_lock);
 
-Scsi_Host_Template * scsi_hosts;
+	list_for_each_safe(lh, lh_sf, &scsi_host_list) {
+		shost = list_entry(lh, struct Scsi_Host, sh_list);
+		if (shost->hostt == shost_tp) {
+			spin_unlock(&scsi_host_list_lock);
+			callback(shost);
+			spin_lock(&scsi_host_list_lock);
+		}
+	}
 
+	spin_unlock(&scsi_host_list_lock);
 
-/*
- *  Our semaphores and timeout counters, where size depends on 
- *      MAX_SCSI_HOSTS here.
- */
+	return 0;
+}
 
-Scsi_Host_Name * scsi_host_no_list;
-struct Scsi_Host * scsi_hostlist;
-struct Scsi_Device_Template * scsi_devicelist;
+/**
+ * scsi_host_generic_release - default release function for hosts
+ * @shost: 
+ * 
+ * Description:
+ * 	This is the default case for the release function.  It should do
+ * 	the right thing for most correctly written host adapters.
+ **/
+static void scsi_host_generic_release(struct Scsi_Host *shost)
+{
+	if (shost->irq)
+		free_irq(shost->irq, NULL);
+	if (shost->dma_channel != 0xff)
+		free_dma(shost->dma_channel);
+	if (shost->io_port && shost->n_io_port)
+		release_region(shost->io_port, shost->n_io_port);
+}
 
-int max_scsi_hosts;
-int next_scsi_host;
+/**
+ * scsi_host_chk_and_release - check a scsi host for release and release
+ * @shost:	a pointer to a scsi host to release
+ *
+ * Return value:
+ * 	0 on Success / 1 on Failure
+ **/
+int scsi_host_chk_and_release(struct Scsi_Host *shost)
+{
+	int pcount;
+	Scsi_Device *sdev;
+	struct Scsi_Device_Template *sdev_tp;
+	Scsi_Cmnd *scmd;
+
+	/*
+	 * Current policy is all shosts go away on unregister.
+	 */
+	if (shost->hostt->module && GET_USE_COUNT(shost->hostt->module))
+		return 1;
+
+	/*
+	 * FIXME Do ref counting.  We force all of the devices offline to
+	 * help prevent race conditions where other hosts/processors could
+	 * try and get in and queue a command.
+	 */
+	for (sdev = shost->host_queue; sdev; sdev = sdev->next) 
+		sdev->online = FALSE;
+
+	for (sdev = shost->host_queue; sdev; sdev = sdev->next) {
+		/*
+		 * Loop over all of the commands associated with the
+		 * device.  If any of them are busy, then set the state
+		 * back to inactive and bail.
+		 */
+		for (scmd = sdev->device_queue; scmd; scmd = scmd->next) {
+			if (scmd->request && scmd->request->rq_status !=
+			    RQ_INACTIVE) {
+				printk(KERN_ERR "SCSI device not inactive"
+				       "- rq_status=%d, target=%d, pid=%ld,"
+				       "state=%d, owner=%d.\n",
+				       scmd->request->rq_status,
+				       scmd->target, scmd->pid,
+				       scmd->state, scmd->owner);
+				for (sdev = shost->host_queue; sdev;
+				     sdev = sdev->next) {
+					for (scmd = sdev->device_queue; scmd;
+					     scmd = scmd->next)
+						if (scmd->request->rq_status ==
+						    RQ_SCSI_DISCONNECTING)
+							scmd->request->rq_status = RQ_INACTIVE;
+				}
+				printk(KERN_ERR "Device busy???\n");
+				return 1;
+			}
+			/*
+			 * No, this device is really free.  Mark it as such, and
+			 * continue on.
+			 */
+			scmd->state = SCSI_STATE_DISCONNECTING;
+			if (scmd->request)
+				scmd->request->rq_status =
+					RQ_SCSI_DISCONNECTING;	/* Mark as
+								   busy */
+		}
+	}
 
-void
-scsi_unregister(struct Scsi_Host * sh){
-    struct Scsi_Host * shpnt;
-    Scsi_Host_Name *shn;
-        
-    if(scsi_hostlist == sh)
-	scsi_hostlist = sh->next;
-    else {
-	shpnt = scsi_hostlist;
-	while(shpnt->next != sh) shpnt = shpnt->next;
-	shpnt->next = shpnt->next->next;
-    }
-
-    /*
-     * We have to unregister the host from the scsi_host_no_list as well.
-     * Decide by the host_no not by the name because most host drivers are
-     * able to handle more than one adapters from the same kind (or family).
-     */
-    for ( shn=scsi_host_no_list; shn && (sh->host_no != shn->host_no);
-	  shn=shn->next);
-    if (shn) shn->host_registered = 0;
-    /* else {} : This should not happen, we should panic here... */
-    
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
-    next_scsi_host--;
-    kfree((char *) sh);
-}
-
-/* We call this when we come across a new host adapter. We only do this
- * once we are 100% sure that we want to use this host adapter -  it is a
- * pain to reverse this, so we try to avoid it 
- */
+	/*
+	 * Next we detach the high level drivers from the Scsi_Device
+	 * structures
+	 */
+	for (sdev = shost->host_queue; sdev; sdev = sdev->next) {
+		for (sdev_tp = scsi_devicelist; sdev_tp;
+		     sdev_tp = sdev_tp->next)
+			if (sdev_tp->detach)
+				(*sdev_tp->detach) (sdev);
+
+		/* If something still attached, punt */
+		if (sdev->attached) {
+			printk(KERN_ERR "Attached usage count = %d\n",
+			       sdev->attached);
+			return 1;
+		}
+
+		if (shost->hostt->slave_detach)
+			(*shost->hostt->slave_detach) (sdev);
+
+		devfs_unregister(sdev->de);
+		device_unregister(&sdev->sdev_driverfs_dev);
+	}
+
+	/* Next we free up the Scsi_Cmnd structures for this host */
+
+	for (sdev = shost->host_queue; sdev;
+	     sdev = shost->host_queue) {
+		scsi_release_commandblocks(sdev);
+		blk_cleanup_queue(&sdev->request_queue);
+		/* Next free up the Scsi_Device structures for this host */
+		shost->host_queue = sdev->next;
+		if (sdev->inquiry)
+			kfree(sdev->inquiry);
+		kfree(sdev);
+	}
+
+	/* Remove the instance of the individual hosts */
+	pcount = scsi_hosts_registered;
+	if (shost->hostt->release)
+		(*shost->hostt->release) (shost);
+	else {
+		scsi_host_generic_release(shost);
+	}
+
+	if (pcount == scsi_hosts_registered)
+		scsi_unregister(shost);
+
+	return 0;
+}
+
+/**
+ * scsi_unregister - unregister a scsi host
+ * @shost:	scsi host to be unregistered
+ **/
+void scsi_unregister(struct Scsi_Host *shost)
+{
+	struct list_head *lh;
+	Scsi_Host_Name *shost_name;
+
+	/* Remove shost from scsi_host_list */
+	spin_lock(&scsi_host_list_lock);
+	list_del(&shost->sh_list);
+	spin_unlock(&scsi_host_list_lock);
+
+	/* Unregister from scsi_host_hn_list */
+	list_for_each(lh, &scsi_host_hn_list) {
+		shost_name = list_entry(lh, Scsi_Host_Name, shn_list);
+		if (shost->host_no == shost_name->host_no)
+			shost_name->host_registered = 0;
+	}
+
+	/*
+	 * Next, kill the kernel error recovery thread for this host.
+	 */
+	if (shost->ehandler) {
+		DECLARE_MUTEX_LOCKED(sem);
+		shost->eh_notify = &sem;
+		send_sig(SIGHUP, shost->ehandler, 1);
+		down(&sem);
+		shost->eh_notify = NULL;
+	}
+
+	scsi_hosts_registered--;
+	shost->hostt->present--;
+
+	/* Cleanup proc and driverfs */
+#ifdef CONFIG_PROC_FS
+	scsi_proc_host_rm(shost);
+	if (!shost->hostt->present)
+		remove_proc_entry(shost->hostt->proc_name, proc_scsi);
+#endif
+	device_unregister(&shost->host_driverfs_dev);
+
+	kfree(shost);
+}
+
+/**
+ * scsi_host_hn_add - allocate and add new Scsi_Host_Name
+ * @name:	String to store in name field
+ *
+ * Return value:
+ * 	Pointer to a new Scsi_Host_Name
+ **/
+Scsi_Host_Name *scsi_host_hn_add(char *name)
+{
+	Scsi_Host_Name *shost_name;
+	int len;
+
+	len = strlen(name);
+	shost_name =  kmalloc(sizeof(*shost_name), GFP_KERNEL);
+	if (!shost_name) {
+		printk(KERN_ERR "%s: out of memory at line %d.\n",
+		       __FUNCTION__, __LINE__);
+		return NULL;
+	}
+	shost_name->name = kmalloc(len + 1, GFP_KERNEL);
+	if (!shost_name->name) {
+		kfree(shost_name);
+		printk(KERN_ERR "%s: out of memory at line %d.\n",
+		       __FUNCTION__, __LINE__);
+		return NULL;
+	}
+
+	if (len)
+		strncpy(shost_name->name, name, len);
+	shost_name->name[len] = 0;
+	shost_name->host_no = scsi_host_next_hn++;
+	shost_name->host_registered = 0;
+	list_add_tail(&shost_name->shn_list, &scsi_host_hn_list);
+
+	return shost_name;
+}
+
+/**
+ * scsi_register - register a scsi host adapter instance.
+ * @shost_tp:	pointer to scsi host template
+ * @xtr_bytes:	extra bytes to allocate for driver
+ *
+ * Note:
+ * 	We call this when we come across a new host adapter. We only do
+ * 	this once we are 100% sure that we want to use this host adapter -
+ * 	it is a pain to reverse this, so we try to avoid it 
+ *
+ * Return value:
+ * 	Pointer to a new Scsi_Host
+ **/
 extern int blk_nohighio;
-struct Scsi_Host * scsi_register(Scsi_Host_Template * tpnt, int j)
+struct Scsi_Host * scsi_register(Scsi_Host_Template *shost_tp, int xtr_bytes)
 {
-    struct Scsi_Host * retval, *shpnt, *o_shp;
-    Scsi_Host_Name *shn, *shn2;
-    int flag_new = 1;
-    const char * hname;
-    size_t hname_len;
-    retval = (struct Scsi_Host *)kmalloc(sizeof(struct Scsi_Host) + j,
-					 (tpnt->unchecked_isa_dma && j ? 
-					  GFP_DMA : 0) | GFP_ATOMIC);
-    if(retval == NULL)
-    {
-        printk("scsi: out of memory in scsi_register.\n");
-    	return NULL;
-    }
-    	
-    memset(retval, 0, sizeof(struct Scsi_Host) + j);
-
-    /* trying to find a reserved entry (host_no) */
-    hname = (tpnt->proc_name) ?  tpnt->proc_name : "";
-    hname_len = strlen(hname);
-    for (shn = scsi_host_no_list;shn;shn = shn->next) {
-	if (!(shn->host_registered) && 
-	    (hname_len > 0) && (0 == strncmp(hname, shn->name, hname_len))) {
-	    flag_new = 0;
-	    retval->host_no = shn->host_no;
-	    shn->host_registered = 1;
-	    break;
-	}
-    }
-    spin_lock_init(&retval->default_lock);
-    scsi_assign_lock(retval, &retval->default_lock);
-    atomic_set(&retval->host_active,0);
-    retval->host_busy = 0;
-    retval->host_failed = 0;
-    if (flag_new) {
-	shn = (Scsi_Host_Name *) kmalloc(sizeof(Scsi_Host_Name), GFP_ATOMIC);
-        if (!shn) {
-                kfree(retval);
-                printk(KERN_ERR "scsi: out of memory(2) in scsi_register.\n");
-                return NULL;
-        }
-	shn->name = kmalloc(hname_len + 1, GFP_ATOMIC);
-	if (hname_len > 0)
-	    strncpy(shn->name, hname, hname_len);
-	shn->name[hname_len] = 0;
-	shn->host_no = max_scsi_hosts++;
-	shn->host_registered = 1;
-	shn->next = NULL;
-	if (scsi_host_no_list) {
-	    for (shn2 = scsi_host_no_list;shn2->next;shn2 = shn2->next)
-		;
-	    shn2->next = shn;
-	}
-	else
-	    scsi_host_no_list = shn;
-	retval->host_no = shn->host_no;
-    }
-    next_scsi_host++;
-    retval->host_queue = NULL;
-    init_waitqueue_head(&retval->host_wait);
-    retval->resetting = 0;
-    retval->last_reset = 0;
-    retval->irq = 0;
-    retval->dma_channel = 0xff;
-
-    /* These three are default values which can be overridden */
-    retval->max_channel = 0; 
-    retval->max_id = 8;      
-    retval->max_lun = 8;
-
-    /*
-     * All drivers right now should be able to handle 12 byte commands.
-     * Every so often there are requests for 16 byte commands, but individual
-     * low-level drivers need to certify that they actually do something
-     * sensible with such commands.
-     */
-    retval->max_cmd_len = 12;
-
-    retval->unique_id = 0;
-    retval->io_port = 0;
-    retval->hostt = tpnt;
-    retval->next = NULL;
-    retval->in_recovery = 0;
-    retval->ehandler = NULL;    /* Initial value until the thing starts up. */
-    retval->eh_notify   = NULL;    /* Who we notify when we exit. */
+	struct Scsi_Host *shost, *shost_scr;
+	Scsi_Host_Name *shost_name = NULL;
+	Scsi_Host_Name *shn = NULL;
+	char *hname;
+	size_t hname_len;
+	struct list_head *lh;
+	int gfp_mask;
+	DECLARE_MUTEX_LOCKED(sem);
+
+	gfp_mask = GFP_KERNEL;
+	if (shost_tp->unchecked_isa_dma && xtr_bytes)
+		gfp_mask |= __GFP_DMA;
+
+	shost = kmalloc(sizeof(struct Scsi_Host) + xtr_bytes, gfp_mask);
+	if (!shost) {
+		printk(KERN_ERR "%s: out of memory.\n", __FUNCTION__);
+		return NULL;
+	}
 
-    retval->max_host_blocked = tpnt->max_host_blocked ? tpnt->max_host_blocked : SCSI_DEFAULT_HOST_BLOCKED;
+	memset(shost, 0, sizeof(struct Scsi_Host) + xtr_bytes);
 
-    retval->host_blocked = 0;
-    retval->host_self_blocked = FALSE;
+	/*
+	 * Determine host number. Check reserved first before allocating
+	 * new one
+	 */
+	hname = (shost_tp->proc_name) ?  shost_tp->proc_name : "";
+	hname_len = strlen(hname);
+
+	if (hname_len)
+		list_for_each(lh, &scsi_host_hn_list) {
+			shn = list_entry(lh, Scsi_Host_Name, shn_list);
+			if (!(shn->host_registered) &&
+			    !strncmp(hname, shn->name, hname_len)) {
+				shost_name = shn;
+				break;
+			}
+		}
+
+	if (!shost_name) {
+		shost_name = scsi_host_hn_add(hname);
+		if (!shost_name) {
+			kfree(shost);
+			return NULL;
+		}
+	}
+
+	shost->host_no = shost_name->host_no;
+	shost_name->host_registered = 1;
+	scsi_hosts_registered++;
+
+	spin_lock_init(&shost->default_lock);
+	scsi_assign_lock(shost, &shost->default_lock);
+	atomic_set(&shost->host_active,0);
+
+	init_waitqueue_head(&shost->host_wait);
+	shost->dma_channel = 0xff;
+
+	/* These three are default values which can be overridden */
+	shost->max_channel = 0;
+	shost->max_id = 8;
+	shost->max_lun = 8;
+
+	/*
+	 * All drivers right now should be able to handle 12 byte
+	 * commands.  Every so often there are requests for 16 byte
+	 * commands, but individual low-level drivers need to certify that
+	 * they actually do something sensible with such commands.
+	 */
+	shost->max_cmd_len = 12;
+	shost->hostt = shost_tp;
+	shost->host_blocked = FALSE;
+	shost->host_self_blocked = FALSE;
 
 #ifdef DEBUG
-    printk("Register %x %x: %d\n", (int)retval, (int)retval->hostt, j);
+	printk("%s: %x %x: %d\n", __FUNCTION_ (int)shost,
+	       (int)shost->hostt, xtr_bytes);
 #endif
 
-    /* The next six are the default values which can be overridden
-     * if need be */
-    retval->this_id = tpnt->this_id;
-    retval->can_queue = tpnt->can_queue;
-    retval->sg_tablesize = tpnt->sg_tablesize;
-    retval->cmd_per_lun = tpnt->cmd_per_lun;
-    retval->unchecked_isa_dma = tpnt->unchecked_isa_dma;
-    retval->use_clustering = tpnt->use_clustering;   
-    if (!blk_nohighio)
-	retval->highmem_io = tpnt->highmem_io;
-
-    retval->max_sectors = tpnt->max_sectors;
-    retval->use_blk_tcq = tpnt->use_blk_tcq;
-
-    if(!scsi_hostlist)
-	scsi_hostlist = retval;
-    else {
-	shpnt = scsi_hostlist;
-	if (retval->host_no < shpnt->host_no) {
-	    retval->next = shpnt;
-	    wmb(); /* want all to see these writes in this order */
-	    scsi_hostlist = retval;
+	/*
+	 * The next six are the default values which can be overridden if
+	 * need be
+	 */
+	shost->this_id = shost_tp->this_id;
+	shost->can_queue = shost_tp->can_queue;
+	shost->sg_tablesize = shost_tp->sg_tablesize;
+	shost->cmd_per_lun = shost_tp->cmd_per_lun;
+	shost->unchecked_isa_dma = shost_tp->unchecked_isa_dma;
+	shost->use_clustering = shost_tp->use_clustering;
+	if (!blk_nohighio)
+	shost->highmem_io = shost_tp->highmem_io;
+
+	shost->max_sectors = shost_tp->max_sectors;
+	shost->use_blk_tcq = shost_tp->use_blk_tcq;
+
+	spin_lock(&scsi_host_list_lock);
+	/*
+	 * FIXME When device naming is complete remove this step that
+	 * orders the scsi_host_list by host number and just do a
+	 * list_add_tail.
+	 */
+	list_for_each(lh, &scsi_host_list) {
+		shost_scr = list_entry(lh, struct Scsi_Host, sh_list);
+		if (shost->host_no < shost_scr->host_no) {
+			__list_add(&shost->sh_list, shost_scr->sh_list.prev,
+				   &shost_scr->sh_list);
+			goto found;
+		}
+	}
+	list_add_tail(&shost->sh_list, &scsi_host_list);
+found:
+	spin_unlock(&scsi_host_list_lock);
+
+#ifdef CONFIG_PROC_FS
+	/* Add the new driver to /proc/scsi if not already there */
+	if (!shost_tp->proc_dir)
+		scsi_proc_host_mkdir(shost_tp);
+	scsi_proc_host_add(shost);
+#endif
+
+	strncpy(shost->host_driverfs_dev.name, shost_tp->proc_name,
+		DEVICE_NAME_SIZE-1);
+	sprintf(shost->host_driverfs_dev.bus_id, "scsi%d",
+		shost->host_no);
+
+	shost->eh_notify = &sem;
+	kernel_thread((int (*)(void *)) scsi_error_handler, (void *) shost, 0);
+	/*
+	 * Now wait for the kernel error thread to initialize itself
+	 * as it might be needed when we scan the bus.
+	 */
+	down(&sem);
+	shost->eh_notify = NULL;
+
+	shost->hostt->present++;
+
+	return shost;
+}
+
+
+/**
+ * scsi_register_host - register a low level host driver
+ * @shost_tp:	pointer to a scsi host driver template
+ *
+ * Return value:
+ * 	0 on Success / 1 on Failure.
+ **/
+int scsi_register_host(Scsi_Host_Template *shost_tp)
+{
+	int cur_cnt;
+	Scsi_Device *sdev;
+	struct Scsi_Device_Template *sdev_tp;
+	struct list_head *lh;
+	struct Scsi_Host *shost;
+
+	/*
+	 * Check no detect routine.
+	 */
+	if (!shost_tp->detect)
+		return 1;
+
+	/* If max_sectors isn't set, default to max */
+	if (!shost_tp->max_sectors)
+		shost_tp->max_sectors = 1024;
+
+	cur_cnt = scsi_hosts_registered;
+
+	MOD_INC_USE_COUNT;
+
+	/*
+	 * The detect routine must carefully spinunlock/spinlock if it
+	 * enables interrupts, since all interrupt handlers do spinlock as
+	 * well.
+	 */
+
+	/*
+	 * detect should do its own locking
+	 * FIXME present is now set is scsi_register which breaks manual
+	 * registration code below.
+	 */
+	shost_tp->detect(shost_tp);
+
+	if (shost_tp->present) {
+			/*
+			 * FIXME Who needs manual registration and why???
+			 */
+		if (cur_cnt == scsi_hosts_registered) {
+			if (shost_tp->present > 1) {
+				printk(KERN_ERR "scsi: Failure to register"
+				       "low-level scsi driver");
+				scsi_unregister_host(shost_tp);
+				return 1;
+			}
+			/*
+			 * The low-level driver failed to register a driver.
+			 * We can do this now.
+			 */
+			if(scsi_register(shost_tp, 0)==NULL) {
+				printk(KERN_ERR "scsi: register failed.\n");
+				scsi_unregister_host(shost_tp);
+				return 1;
+			}
+		}
+
+		list_add_tail(&shost_tp->shtp_list, &scsi_host_tmpl_list);
+
+		/* The next step is to call scan_scsis here.  This generates the
+		 * Scsi_Devices entries
+		 */
+		list_for_each(lh, &scsi_host_list) {
+			shost = list_entry(lh, struct Scsi_Host, sh_list);
+			if (shost->hostt == shost_tp) {
+				const char *dm_name;
+				if (shost_tp->info) {
+					dm_name = shost_tp->info(shost);
+				} else {
+					dm_name = shost_tp->name;
+				}
+				printk(KERN_INFO "scsi%d : %s\n",
+				       shost->host_no, dm_name);
+
+				/* first register parent with driverfs */
+				device_register(&shost->host_driverfs_dev);
+				scan_scsis(shost, 0, 0, 0, 0);
+			}
+		}
+
+		for (sdev_tp = scsi_devicelist; sdev_tp;
+		     sdev_tp = sdev_tp->next) {
+			if (sdev_tp->init && sdev_tp->dev_noticed)
+				(*sdev_tp->init) ();
+		}
+
+		/*
+		 * Next we create the Scsi_Cmnd structures for this host 
+		 */
+		list_for_each(lh, &scsi_host_list) {
+			shost = list_entry(lh, struct Scsi_Host, sh_list);
+			for (sdev = shost->host_queue; sdev; sdev = sdev->next)
+				if (sdev->host->hostt == shost_tp) {
+					for (sdev_tp = scsi_devicelist;
+					     sdev_tp;
+					     sdev_tp = sdev_tp->next)
+						if (sdev_tp->attach)
+							(*sdev_tp->attach) (sdev);
+					if (sdev->attached) {
+						scsi_build_commandblocks(sdev);
+						if (sdev->current_queue_depth == 0)
+							goto out_of_space;
+					}
+				}
+		}
+
+		/* This does any final handling that is required. */
+		for (sdev_tp = scsi_devicelist; sdev_tp;
+		     sdev_tp = sdev_tp->next) {
+			if (sdev_tp->finish && sdev_tp->nr_dev) {
+				(*sdev_tp->finish) ();
+			}
+		}
+	}
+
+	return 0;
+
+out_of_space:
+	scsi_unregister_host(shost_tp); /* easiest way to clean up?? */
+	return 1;
+}
+
+/**
+ * scsi_unregister_host - unregister a low level host adapter driver
+ * @shost_tp:	scsi host template to unregister.
+ *
+ * Description:
+ * 	Similarly, this entry point should be called by a loadable module
+ * 	if it is trying to remove a low level scsi driver from the system.
+ *
+ * Return value:
+ * 	0 on Success / 1 on Failure
+ *
+ * Notes:
+ * 	rmmod does not care what we return here the module will be
+ * 	removed.
+ **/
+int scsi_unregister_host(Scsi_Host_Template *shost_tp)
+{
+	int pcount;
+
+	/* get the big kernel lock, so we don't race with open() */
+	lock_kernel();
+
+	pcount = scsi_hosts_registered;
+
+	scsi_tp_for_each_host(shost_tp, scsi_host_chk_and_release);
+
+	if (pcount != scsi_hosts_registered)
+		printk(KERN_INFO "scsi : %d host%s left.\n", scsi_hosts_registered,
+		       (scsi_hosts_registered == 1) ? "" : "s");
+
+	/*
+	 * Remove it from the list if all
+	 * hosts were successfully removed (ie preset == 0)
+	 */
+	if (!shost_tp->present) {
+		list_del(&shost_tp->shtp_list);
+	}
+
+	MOD_DEC_USE_COUNT;
+
+	unlock_kernel();
+	return 0;
+
+}
+
+/**
+ * *scsi_host_get_next - get scsi host and inc ref count
+ * @shost:	pointer to a Scsi_Host or NULL to start.
+ *
+ * Return value:
+ * 	A pointer to next Scsi_Host in list or NULL.
+ **/
+struct Scsi_Host *scsi_host_get_next(struct Scsi_Host *shost)
+{
+	struct list_head *lh = NULL;
+
+	spin_lock(&scsi_host_list_lock);
+	if (shost) {
+		/* XXX Dec ref on cur shost */
+		lh = shost->sh_list.next;
+	} else {
+		lh = scsi_host_list.next;
+	}
+
+	if (lh == &scsi_host_list) {
+		shost = (struct Scsi_Host *)NULL;
+		goto done;
+	}
+
+	shost = list_entry(lh, struct Scsi_Host, sh_list);
+	/* XXX Inc ref count */
+
+done:
+	spin_unlock(&scsi_host_list_lock);
+	return shost;
+}
+
+/**
+ * scsi_host_hn_get - get a Scsi_Host by host no and inc ref count
+ * @host_no:	host number to locate
+ *
+ * Return value:
+ * 	A pointer to located Scsi_Host or NULL.
+ **/
+struct Scsi_Host *scsi_host_hn_get(unsigned short host_no)
+{
+	struct list_head *lh;
+	struct Scsi_Host *shost;
+
+	spin_lock(&scsi_host_list_lock);
+	list_for_each(lh, &scsi_host_list) {
+		shost = list_entry(lh, struct Scsi_Host, sh_list);
+		if (shost->host_no == host_no) {
+			/* XXX Inc ref count */
+			goto done;
+		}
+	}
+
+	shost = (struct Scsi_Host *)NULL;
+done:
+	spin_unlock(&scsi_host_list_lock);
+	return shost;
+}
+
+/**
+ * *scsi_host_put - dec a Scsi_Host ref count
+ * @shost:	Pointer to Scsi_Host to dec.
+ **/
+void scsi_host_put(struct Scsi_Host *shost)
+{
+
+	/* XXX Get list lock */
+	/* XXX dec ref count */
+	/* XXX Release list lock */
+	return;
+}
+
+/**
+ * scsi_host_hn_init - init scsi host number list from string
+ * @shost_hn:	string of scsi host driver names.
+ **/
+void __init scsi_host_hn_init(char *shost_hn)
+{
+	char *temp = shost_hn;
+
+	while (temp) {
+		while (*temp && (*temp != ':') && (*temp != ','))
+			temp++;
+		if (!*temp)
+			temp = NULL;
+		else
+			*temp++ = 0;
+		(void)scsi_host_hn_add(shost_hn);
+		shost_hn = temp;
+	}
+}
+
+/**
+ * scsi_host_no_release - free all entries in scsi host number list
+ **/
+void __exit scsi_host_hn_release()
+{
+	struct list_head *lh, *next;
+	Scsi_Host_Name *shn;
+
+	list_for_each_safe(lh, next, &scsi_host_hn_list) {
+		shn = list_entry(lh, Scsi_Host_Name, shn_list);
+		if (shn->name)
+			kfree(shn->name);
+		kfree(shn);
 	}
-	else {
-	    for (o_shp = shpnt, shpnt = shpnt->next; shpnt; 
-		 o_shp = shpnt, shpnt = shpnt->next) {
-		if (retval->host_no < shpnt->host_no) {
-		    retval->next = shpnt;
-		    wmb();
-		    o_shp->next = retval;
-		    break;
-		}
-	    }
-	    if (! shpnt)
-		o_shp->next = retval;
-        }
-    }
-    
-    return retval;
 }
 
 void scsi_host_busy_inc(struct Scsi_Host *shost, Scsi_Device *sdev)
@@ -279,8 +761,7 @@
 	if (shost->in_recovery && (shost->host_busy == shost->host_failed)) {
 		up(shost->eh_wait);
 		SCSI_LOG_ERROR_RECOVERY(5, printk("Waking error handler"
-					  "thread (%d)\n",
-					  atomic_read(&shost->eh_wait->count)));
+					  " thread\n"));
 	}
 	spin_unlock_irqrestore(shost->host_lock, flags);
 }
@@ -295,8 +776,7 @@
 	if (shost->host_busy == shost->host_failed) {
 		up(shost->eh_wait);
 		SCSI_LOG_ERROR_RECOVERY(5, printk("Waking error handler"
-					  "thread (%d)\n",
-					  atomic_read(&shost->eh_wait->count)));
+					  " thread\n"));
 	}
 	spin_unlock_irqrestore(shost->host_lock, flags);
 }
diff -Nru a/drivers/scsi/hosts.h b/drivers/scsi/hosts.h
--- a/drivers/scsi/hosts.h	Thu Oct 17 00:53:47 2002
+++ b/drivers/scsi/hosts.h	Thu Oct 17 00:53:47 2002
@@ -16,15 +16,14 @@
  *  of the same type.
  *
  *  Jiffies wrap fixes (host->resetting), 3 Dec 1998 Andrea Arcangeli
+ *
+ *  Restructured scsi_host lists and associated functions.
+ *  September 04, 2002 Mike Anderson (andmike@us.ibm.com)
  */
 
 #ifndef _HOSTS_H
 #define _HOSTS_H
 
-/*
-    $Header: /vger/u4/cvs/linux/drivers/scsi/hosts.h,v 1.6 1997/01/19 23:07:13 davem Exp $
-*/
-
 #include <linux/config.h>
 #include <linux/proc_fs.h>
 #include <linux/pci.h>
@@ -58,8 +57,7 @@
 typedef struct	SHT
 {
 
-    /* Used with loadable modules so we can construct a linked list. */
-    struct SHT * next;
+    struct list_head	shtp_list;
 
     /* Used with loadable modules so that we know when it is safe to unload */
     struct module * module;
@@ -374,7 +372,7 @@
      * This information is private to the scsi mid-layer.  Wrapping it in a
      * struct private is a way of marking it in a sort of C++ type of way.
      */
-    struct Scsi_Host      * next;
+    struct list_head      sh_list;
     Scsi_Device           * host_queue;
     struct list_head	  all_scsi_hosts;
     struct list_head	  my_devices;
@@ -510,28 +508,26 @@
  * thing.  This physical pseudo-device isn't real and won't be available
  * from any high-level drivers.
  */
-extern void scsi_free_host_dev(Scsi_Device * SDpnt);
-extern Scsi_Device * scsi_get_host_dev(struct Scsi_Host * SHpnt);
+extern void scsi_free_host_dev(Scsi_Device *);
+extern Scsi_Device * scsi_get_host_dev(struct Scsi_Host *);
 
-extern void scsi_unblock_requests(struct Scsi_Host * SHpnt);
-extern void scsi_block_requests(struct Scsi_Host * SHpnt);
-extern void scsi_report_bus_reset(struct Scsi_Host * SHpnt, int channel);
+extern void scsi_unblock_requests(struct Scsi_Host *);
+extern void scsi_block_requests(struct Scsi_Host *);
+extern void scsi_report_bus_reset(struct Scsi_Host *, int);
 
 typedef struct SHN
-    {
-    struct SHN * next;
-    char * name;
-    unsigned short host_no;
-    unsigned short host_registered;
-    } Scsi_Host_Name;
+{
+	struct list_head shn_list;
+	char *name;
+	unsigned short host_no;
+	unsigned short host_registered;
+} Scsi_Host_Name;
 	
-extern Scsi_Host_Name * scsi_host_no_list;
-extern struct Scsi_Host * scsi_hostlist;
 extern struct Scsi_Device_Template * scsi_devicelist;
 
-extern Scsi_Host_Template * scsi_hosts;
-
-extern void build_proc_dir_entries(Scsi_Host_Template  *);
+extern void scsi_proc_host_mkdir(Scsi_Host_Template *);
+extern void scsi_proc_host_add(struct Scsi_Host *);
+extern void scsi_proc_host_rm(struct Scsi_Host *);
 
 /*
  *  scsi_init initializes the scsi hosts.
@@ -540,34 +536,33 @@
 extern int next_scsi_host;
 
 unsigned int scsi_init(void);
-extern struct Scsi_Host * scsi_register(Scsi_Host_Template *, int j);
-extern void scsi_unregister(struct Scsi_Host * i);
-extern void scsi_register_blocked_host(struct Scsi_Host * SHpnt);
-extern void scsi_deregister_blocked_host(struct Scsi_Host * SHpnt);
+extern struct Scsi_Host * scsi_register(Scsi_Host_Template *, int);
+extern void scsi_unregister(struct Scsi_Host *);
+extern void scsi_register_blocked_host(struct Scsi_Host *);
+extern void scsi_deregister_blocked_host(struct Scsi_Host *);
 
-static inline void scsi_assign_lock(struct Scsi_Host *host, spinlock_t *lock)
+static inline void scsi_assign_lock(struct Scsi_Host *shost, spinlock_t *lock)
 {
-	host->host_lock = lock;
+	shost->host_lock = lock;
 }
 
-static inline void scsi_set_pci_device(struct Scsi_Host *SHpnt,
+static inline void scsi_set_pci_device(struct Scsi_Host *shost,
                                        struct pci_dev *pdev)
 {
-	SHpnt->pci_dev = pdev;
-	SHpnt->host_driverfs_dev.parent=&pdev->dev;
+	shost->pci_dev = pdev;
+	shost->host_driverfs_dev.parent=&pdev->dev;
+
+	/* register parent with driverfs */
+	device_register(&shost->host_driverfs_dev);
 }
 
 
 /*
  * Prototypes for functions/data in scsi_scan.c
  */
-extern void scan_scsis(struct Scsi_Host *shpnt,
-		       uint hardcoded,
-		       uint hchannel,
-		       uint hid,
-                       uint hlun);
+extern void scan_scsis(struct Scsi_Host *, uint, uint, uint, uint);
 
-extern void scsi_mark_host_reset(struct Scsi_Host *Host);
+extern void scsi_mark_host_reset(struct Scsi_Host *);
 
 #define BLANK_HOST {"", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
 
@@ -596,7 +591,7 @@
     struct device_driver scsi_driverfs_driver;
 };
 
-void  scsi_initialize_queue(Scsi_Device * SDpnt, struct Scsi_Host * SHpnt);
+void  scsi_initialize_queue(Scsi_Device *, struct Scsi_Host *);
 
 
 /*
@@ -607,6 +602,12 @@
 extern int scsi_register_host(Scsi_Host_Template *);
 extern int scsi_unregister_host(Scsi_Host_Template *);
 
+extern struct Scsi_Host *scsi_host_get_next(struct Scsi_Host *);
+extern struct Scsi_Host *scsi_host_hn_get(unsigned short);
+extern void scsi_host_put(struct Scsi_Host *);
+extern void scsi_host_hn_init(char *);
+extern void scsi_host_hn_release(void);
+
 /*
  * host_busy inc/dec/test functions
  */
@@ -614,7 +615,6 @@
 extern void scsi_host_busy_dec_and_test(struct Scsi_Host *, Scsi_Device *);
 extern void scsi_host_failed_inc_and_test(struct Scsi_Host *);
 
-
 /*
  * This is an ugly hack.  If we expect to be able to load devices at run time,
  * we need to leave extra room in some of the data structures.	Doing a
@@ -643,21 +643,22 @@
 
 /**
  * scsi_find_device - find a device given the host
+ * @shost:	SCSI host pointer
  * @channel:	SCSI channel (zero if only one channel)
  * @pun:	SCSI target number (physical unit number)
  * @lun:	SCSI Logical Unit Number
  **/
-static inline Scsi_Device *scsi_find_device(struct Scsi_Host *host,
+static inline Scsi_Device *scsi_find_device(struct Scsi_Host *shost,
                                             int channel, int pun, int lun) {
-        Scsi_Device *SDpnt;
+        Scsi_Device *sdev;
 
-        for(SDpnt = host->host_queue;
-            SDpnt != NULL;
-            SDpnt = SDpnt->next)
-                if(SDpnt->channel == channel && SDpnt->id == pun
-                   && SDpnt->lun ==lun)
+        for (sdev = shost->host_queue;
+            sdev != NULL;
+            sdev = sdev->next)
+                if (sdev->channel == channel && sdev->id == pun
+                   && sdev->lun ==lun)
                         break;
-        return SDpnt;
+        return sdev;
 }
     
 #endif

