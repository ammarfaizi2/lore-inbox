Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261817AbSJQGrJ>; Thu, 17 Oct 2002 02:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261815AbSJQGrJ>; Thu, 17 Oct 2002 02:47:09 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:37031 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261817AbSJQGqq>; Thu, 17 Oct 2002 02:46:46 -0400
Date: Wed, 16 Oct 2002 23:53:52 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi host cleanup 2/3 (mid lvl changes)
Message-ID: <20021017065352.GB1977@beaverton.ibm.com>
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

 scsi.c      |  456 +++---------------------------------------------------------
 scsi_proc.c |   57 ++++---
 scsi_syms.c |    5 
 sg.c        |    6 
 4 files changed, 63 insertions(+), 461 deletions(-)
------

diff -Nru a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
--- a/drivers/scsi/scsi.c	Wed Oct 16 22:51:48 2002
+++ b/drivers/scsi/scsi.c	Wed Oct 16 22:51:48 2002
@@ -1659,33 +1659,6 @@
 	}
 }
 
-void __init scsi_host_no_insert(char *str, int n)
-{
-    Scsi_Host_Name *shn, *shn2;
-    int len;
-    
-    len = strlen(str);
-    if (len && (shn = (Scsi_Host_Name *) kmalloc(sizeof(Scsi_Host_Name), GFP_ATOMIC))) {
-	if ((shn->name = kmalloc(len+1, GFP_ATOMIC))) {
-	    strncpy(shn->name, str, len);
-	    shn->name[len] = 0;
-	    shn->host_no = n;
-	    shn->host_registered = 0;
-	    shn->next = NULL;
-	    if (scsi_host_no_list) {
-		for (shn2 = scsi_host_no_list;shn2->next;shn2 = shn2->next)
-		    ;
-		shn2->next = shn;
-	    }
-	    else
-		scsi_host_no_list = shn;
-	    max_scsi_hosts = n+1;
-	}
-	else
-	    kfree((char *) shn);
-    }
-}
-
 #ifdef CONFIG_PROC_FS
 static int scsi_proc_info(char *buffer, char **start, off_t offset, int length)
 {
@@ -1698,7 +1671,8 @@
 	/*
 	 * First, see if there are any attached devices or not.
 	 */
-	for (HBA_ptr = scsi_hostlist; HBA_ptr; HBA_ptr = HBA_ptr->next) {
+	for (HBA_ptr = scsi_host_get_next(NULL); HBA_ptr;
+	     HBA_ptr = scsi_host_get_next(HBA_ptr)) {
 		if (HBA_ptr->host_queue != NULL) {
 			break;
 		}
@@ -1706,7 +1680,8 @@
 	size = sprintf(buffer + len, "Attached devices: %s\n", (HBA_ptr) ? "" : "none");
 	len += size;
 	pos = begin + len;
-	for (HBA_ptr = scsi_hostlist; HBA_ptr; HBA_ptr = HBA_ptr->next) {
+	for (HBA_ptr = scsi_host_get_next(NULL); HBA_ptr;
+	     HBA_ptr = scsi_host_get_next(HBA_ptr)) {
 #if 0
 		size += sprintf(buffer + len, "scsi%2d: %s\n", (int) HBA_ptr->host_no,
 				HBA_ptr->hostt->procname);
@@ -1873,7 +1848,8 @@
 		printk(KERN_INFO "scsi singledevice %d %d %d %d\n", host, channel,
 		       id, lun);
 
-		for (HBA_ptr = scsi_hostlist; HBA_ptr; HBA_ptr = HBA_ptr->next) {
+		for (HBA_ptr = scsi_host_get_next(NULL); HBA_ptr;
+		     HBA_ptr = scsi_host_get_next(HBA_ptr)) {
 			if (HBA_ptr->host_no == host) {
 				break;
 			}
@@ -1918,7 +1894,8 @@
 		lun = simple_strtoul(p + 1, &p, 0);
 
 
-		for (HBA_ptr = scsi_hostlist; HBA_ptr; HBA_ptr = HBA_ptr->next) {
+		for (HBA_ptr = scsi_host_get_next(NULL); HBA_ptr;
+		     HBA_ptr = scsi_host_get_next(HBA_ptr)) {
 			if (HBA_ptr->host_no == host) {
 				break;
 			}
@@ -1988,369 +1965,6 @@
 #endif
 
 /*
- * This entry point should be called by a driver if it is trying
- * to add a low level scsi driver to the system.
- */
-int scsi_register_host(Scsi_Host_Template * tpnt)
-{
-	int pcount;
-	struct Scsi_Host *shpnt;
-	Scsi_Device *SDpnt;
-	struct Scsi_Device_Template *sdtpnt;
-	const char *name;
-	int out_of_space = 0;
-
-	if (tpnt->next || !tpnt->detect)
-		return 1;	/* Must be already loaded, or
-				 * no detect routine available
-				 */
-
-	/* If max_sectors isn't set, default to max */
-	if (!tpnt->max_sectors)
-		tpnt->max_sectors = 1024;
-
-	pcount = next_scsi_host;
-
-	MOD_INC_USE_COUNT;
-
-	/* The detect routine must carefully spinunlock/spinlock if 
-	   it enables interrupts, since all interrupt handlers do 
-	   spinlock as well.  */
-
-	/*
-	 * detect should do its own locking
-	 */
-	tpnt->present = tpnt->detect(tpnt);
-
-	if (tpnt->present) {
-		if (pcount == next_scsi_host) {
-			if (tpnt->present > 1) {
-				printk(KERN_ERR "scsi: Failure to register low-level scsi driver");
-				scsi_unregister_host(tpnt);
-				return 1;
-			}
-			/* 
-			 * The low-level driver failed to register a driver.
-			 * We can do this now.
-			 */
-			if(scsi_register(tpnt, 0)==NULL)
-			{
-				printk(KERN_ERR "scsi: register failed.\n");
-				scsi_unregister_host(tpnt);
-				return 1;
-			}
-		}
-		tpnt->next = scsi_hosts;	/* Add to the linked list */
-		scsi_hosts = tpnt;
-
-		/* Add the new driver to /proc/scsi */
-#ifdef CONFIG_PROC_FS
-		build_proc_dir_entries(tpnt);
-#endif
-
-
-		/*
-		 * Add the kernel threads for each host adapter that will
-		 * handle error correction.
-		 */
-		for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
-			if (shpnt->hostt == tpnt) {
-				DECLARE_MUTEX_LOCKED(sem);
-
-				shpnt->eh_notify = &sem;
-				kernel_thread((int (*)(void *)) scsi_error_handler,
-					      (void *) shpnt, 0);
-
-				/*
-				 * Now wait for the kernel error thread to initialize itself
-				 * as it might be needed when we scan the bus.
-				 */
-				down(&sem);
-				shpnt->eh_notify = NULL;
-			}
-		}
-
-		for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
-			if (shpnt->hostt == tpnt) {
-				if (tpnt->info) {
-					name = tpnt->info(shpnt);
-				} else {
-					name = tpnt->name;
-				}
-				printk(KERN_INFO "scsi%d : %s\n",		/* And print a little message */
-				       shpnt->host_no, name);
-				strncpy(shpnt->host_driverfs_dev.name,name,
-					DEVICE_NAME_SIZE-1);
-				sprintf(shpnt->host_driverfs_dev.bus_id,
-					"scsi%d",
-					shpnt->host_no);
-			}
-		}
-
-		/* The next step is to call scan_scsis here.  This generates the
-		 * Scsi_Devices entries
-		 */
-		for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
-			if (shpnt->hostt == tpnt) {
-				/* first register parent with driverfs */
-				device_register(&shpnt->host_driverfs_dev);
-				scan_scsis(shpnt, 0, 0, 0, 0);
-			}
-		}
-
-		for (sdtpnt = scsi_devicelist; sdtpnt; sdtpnt = sdtpnt->next) {
-			if (sdtpnt->init && sdtpnt->dev_noticed)
-				(*sdtpnt->init) ();
-		}
-
-		/*
-		 * Next we create the Scsi_Cmnd structures for this host 
-		 */
-		for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
-			for (SDpnt = shpnt->host_queue; SDpnt; SDpnt = SDpnt->next)
-				if (SDpnt->host->hostt == tpnt) {
-					for (sdtpnt = scsi_devicelist; sdtpnt; sdtpnt = sdtpnt->next)
-						if (sdtpnt->attach)
-							(*sdtpnt->attach) (SDpnt);
-					if (SDpnt->attached) {
-						scsi_build_commandblocks(SDpnt);
-						if (SDpnt->current_queue_depth == 0)
-							out_of_space = 1;
-					}
-				}
-		}
-
-		/* This does any final handling that is required. */
-		for (sdtpnt = scsi_devicelist; sdtpnt; sdtpnt = sdtpnt->next) {
-			if (sdtpnt->finish && sdtpnt->nr_dev) {
-				(*sdtpnt->finish) ();
-			}
-		}
-	}
-
-	if (out_of_space) {
-		scsi_unregister_host(tpnt);	/* easiest way to clean up?? */
-		return 1;
-	} else
-		return 0;
-}
-
-/*
- * Similarly, this entry point should be called by a loadable module if it
- * is trying to remove a low level scsi driver from the system.
- */
-int scsi_unregister_host(Scsi_Host_Template * tpnt)
-{
-	int online_status;
-	int pcount0, pcount;
-	Scsi_Cmnd *SCpnt;
-	Scsi_Device *SDpnt;
-	Scsi_Device *SDpnt1;
-	struct Scsi_Device_Template *sdtpnt;
-	struct Scsi_Host *sh1;
-	struct Scsi_Host *shpnt;
-	char name[10];	/* host_no>=10^9? I don't think so. */
-
-	/* get the big kernel lock, so we don't race with open() */
-	lock_kernel();
-
-	/*
-	 * First verify that this host adapter is completely free with no pending
-	 * commands 
-	 */
-	for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
-		for (SDpnt = shpnt->host_queue; SDpnt;
-		     SDpnt = SDpnt->next) {
-			if (SDpnt->host->hostt == tpnt
-			    && SDpnt->host->hostt->module
-			    && GET_USE_COUNT(SDpnt->host->hostt->module))
-				goto err_out;
-			/* 
-			 * FIXME(eric) - We need to find a way to notify the
-			 * low level driver that we are shutting down - via the
-			 * special device entry that still needs to get added. 
-			 *
-			 * Is detach interface below good enough for this?
-			 */
-		}
-	}
-
-	/*
-	 * FIXME(eric) put a spinlock on this.  We force all of the devices offline
-	 * to help prevent race conditions where other hosts/processors could try and
-	 * get in and queue a command.
-	 */
-	for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
-		for (SDpnt = shpnt->host_queue; SDpnt;
-		     SDpnt = SDpnt->next) {
-			if (SDpnt->host->hostt == tpnt)
-				SDpnt->online = FALSE;
-
-		}
-	}
-
-	for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
-		if (shpnt->hostt != tpnt) {
-			continue;
-		}
-		for (SDpnt = shpnt->host_queue; SDpnt;
-		     SDpnt = SDpnt->next) {
-			/*
-			 * Loop over all of the commands associated with the device.  If any of
-			 * them are busy, then set the state back to inactive and bail.
-			 */
-			for (SCpnt = SDpnt->device_queue; SCpnt;
-			     SCpnt = SCpnt->next) {
-				online_status = SDpnt->online;
-				SDpnt->online = FALSE;
-				if (SCpnt->request && SCpnt->request->rq_status != RQ_INACTIVE) {
-					printk(KERN_ERR "SCSI device not inactive - rq_status=%d, target=%d, pid=%ld, state=%d, owner=%d.\n",
-					       SCpnt->request->rq_status, SCpnt->target, SCpnt->pid,
-					     SCpnt->state, SCpnt->owner);
-					for (SDpnt1 = shpnt->host_queue; SDpnt1;
-					     SDpnt1 = SDpnt1->next) {
-						for (SCpnt = SDpnt1->device_queue; SCpnt;
-						     SCpnt = SCpnt->next)
-							if (SCpnt->request->rq_status == RQ_SCSI_DISCONNECTING)
-								SCpnt->request->rq_status = RQ_INACTIVE;
-					}
-					SDpnt->online = online_status;
-					printk(KERN_ERR "Device busy???\n");
-					goto err_out;
-				}
-				/*
-				 * No, this device is really free.  Mark it as such, and
-				 * continue on.
-				 */
-				SCpnt->state = SCSI_STATE_DISCONNECTING;
-                                if(SCpnt->request)
-                                        SCpnt->request->rq_status = RQ_SCSI_DISCONNECTING;	/* Mark as busy */
-			}
-		}
-	}
-	/* Next we detach the high level drivers from the Scsi_Device structures */
-
-	for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
-		if (shpnt->hostt != tpnt) {
-			continue;
-		}
-		for (SDpnt = shpnt->host_queue; SDpnt;
-		     SDpnt = SDpnt->next) {
-			for (sdtpnt = scsi_devicelist; sdtpnt; sdtpnt = sdtpnt->next)
-				if (sdtpnt->detach)
-					(*sdtpnt->detach) (SDpnt);
-
-			/* If something still attached, punt */
-			if (SDpnt->attached) {
-				printk(KERN_ERR "Attached usage count = %d\n", SDpnt->attached);
-				goto err_out;
-			}
-			if (shpnt->hostt->slave_detach)
-				(*shpnt->hostt->slave_detach) (SDpnt);
-			devfs_unregister (SDpnt->de);
-			put_device(&SDpnt->sdev_driverfs_dev);
-		}
-	}
-
-	/*
-	 * Next, kill the kernel error recovery thread for this host.
-	 */
-	for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
-		if (shpnt->hostt == tpnt
-		    && shpnt->ehandler != NULL) {
-			DECLARE_MUTEX_LOCKED(sem);
-
-			shpnt->eh_notify = &sem;
-			send_sig(SIGHUP, shpnt->ehandler, 1);
-			down(&sem);
-			shpnt->eh_notify = NULL;
-		}
-	}
-
-	/* Next we free up the Scsi_Cmnd structures for this host */
-
-	for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
-		if (shpnt->hostt != tpnt) {
-			continue;
-		}
-		for (SDpnt = shpnt->host_queue; SDpnt;
-		     SDpnt = shpnt->host_queue) {
-			scsi_release_commandblocks(SDpnt);
-
-			blk_cleanup_queue(&SDpnt->request_queue);
-			/* Next free up the Scsi_Device structures for this host */
-			shpnt->host_queue = SDpnt->next;
-			if (SDpnt->inquiry)
-				kfree(SDpnt->inquiry);
-			kfree((char *) SDpnt);
-
-		}
-	}
-
-	/* Next we go through and remove the instances of the individual hosts
-	 * that were detected */
-
-	pcount0 = next_scsi_host;
-	for (shpnt = scsi_hostlist; shpnt; shpnt = sh1) {
-		sh1 = shpnt->next;
-		if (shpnt->hostt != tpnt)
-			continue;
-		pcount = next_scsi_host;
-		/* Remove the /proc/scsi directory entry */
-		sprintf(name,"%d",shpnt->host_no);
-		remove_proc_entry(name, tpnt->proc_dir);
-		put_device(&shpnt->host_driverfs_dev);
-		if (tpnt->release)
-			(*tpnt->release) (shpnt);
-		else {
-			/* This is the default case for the release function.
-			 * It should do the right thing for most correctly
-			 * written host adapters.
-			 */
-			if (shpnt->irq)
-				free_irq(shpnt->irq, NULL);
-			if (shpnt->dma_channel != 0xff)
-				free_dma(shpnt->dma_channel);
-			if (shpnt->io_port && shpnt->n_io_port)
-				release_region(shpnt->io_port, shpnt->n_io_port);
-		}
-		if (pcount == next_scsi_host)
-			scsi_unregister(shpnt);
-		tpnt->present--;
-	}
-
-	if (pcount0 != next_scsi_host)
-		printk(KERN_INFO "scsi : %d host%s left.\n", next_scsi_host,
-		       (next_scsi_host == 1) ? "" : "s");
-
-	/*
-	 * Remove it from the linked list and /proc if all
-	 * hosts were successfully removed (ie preset == 0)
-	 */
-	if (!tpnt->present) {
-		Scsi_Host_Template **SHTp = &scsi_hosts;
-		Scsi_Host_Template *SHT;
-
-		while ((SHT = *SHTp) != NULL) {
-			if (SHT == tpnt) {
-				*SHTp = SHT->next;
-				remove_proc_entry(tpnt->proc_name, proc_scsi);
-				break;
-			}
-			SHTp = &SHT->next;
-		}
-	}
-	MOD_DEC_USE_COUNT;
-
-	unlock_kernel();
-	return 0;
-
-err_out:
-	unlock_kernel();
-	return -1;
-}
-
-/*
  * This entry point should be called by a loadable module if it is trying
  * add a high level scsi driver to the system.
  */
@@ -2361,7 +1975,7 @@
 	int out_of_space = 0;
 
 #ifdef CONFIG_KMOD
-	if (scsi_hosts == NULL)
+	if (scsi_host_get_next(NULL) == NULL)
 		request_module("scsi_hostadapter");
 #endif
 
@@ -2375,7 +1989,8 @@
 	 * First scan the devices that we know about, and see if we notice them.
 	 */
 
-	for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
+	for (shpnt = scsi_host_get_next(NULL); shpnt;
+	     shpnt = scsi_host_get_next(shpnt)) {
 		for (SDpnt = shpnt->host_queue; SDpnt;
 		     SDpnt = SDpnt->next) {
 			if (tpnt->detect)
@@ -2394,7 +2009,8 @@
 	/*
 	 * Now actually connect the devices to the new driver.
 	 */
-	for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
+	for (shpnt = scsi_host_get_next(NULL); shpnt;
+	     shpnt = scsi_host_get_next(shpnt)) {
 		for (SDpnt = shpnt->host_queue; SDpnt;
 		     SDpnt = SDpnt->next) {
 			if (tpnt->attach)
@@ -2444,7 +2060,8 @@
 	 * Next, detach the devices from the driver.
 	 */
 
-	for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
+	for (shpnt = scsi_host_get_next(NULL); shpnt;
+	     shpnt = scsi_host_get_next(shpnt)) {
 		for (SDpnt = shpnt->host_queue; SDpnt;
 		     SDpnt = SDpnt->next) {
 			if (tpnt->detach)
@@ -2516,7 +2133,8 @@
 	Scsi_Device *SDpnt;
 	printk(KERN_INFO "Dump of scsi host parameters:\n");
 	i = 0;
-	for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
+	for (shpnt = scsi_host_get_next(NULL); shpnt;
+	     shpnt = scsi_host_get_next(shpnt)) {
 		printk(KERN_INFO " %d %d %d : %d %d\n",
 		       shpnt->host_failed,
 		       shpnt->host_busy,
@@ -2527,7 +2145,8 @@
 
 	printk(KERN_INFO "\n\n");
 	printk(KERN_INFO "Dump of scsi command parameters:\n");
-	for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
+	for (shpnt = scsi_host_get_next(NULL); shpnt;
+	     shpnt = scsi_host_get_next(shpnt)) {
 		printk(KERN_INFO "h:c:t:l (dev sect nsect cnumsec sg) (ret all flg) (to/cmd to ito) cmd snse result\n");
 		for (SDpnt = shpnt->host_queue; SDpnt; SDpnt = SDpnt->next) {
 			for (SCpnt = SDpnt->device_queue; SCpnt; SCpnt = SCpnt->next) {
@@ -2565,26 +2184,6 @@
 }
 #endif				/* CONFIG_PROC_FS */
 
-static int __init scsi_host_no_init (char *str)
-{
-    static int next_no = 0;
-    char *temp;
-
-    while (str) {
-	temp = str;
-	while (*temp && (*temp != ':') && (*temp != ','))
-	    temp++;
-	if (!*temp)
-	    temp = NULL;
-	else
-	    *temp++ = 0;
-	scsi_host_no_insert(str, next_no);
-	str = temp;
-	next_no++;
-    }
-    return 1;
-}
-
 static char *scsihosts;
 
 MODULE_PARM(scsihosts, "s");
@@ -2724,9 +2323,8 @@
 #endif
 
         scsi_devfs_handle = devfs_mk_dir (NULL, "scsi", NULL);
-        if (scsihosts)
-		printk(KERN_INFO "scsi: host order: %s\n", scsihosts);	
-	scsi_host_no_init (scsihosts);
+
+	scsi_host_hn_init(scsihosts);
 
 	bus_register(&scsi_driverfs_bus_type);
 
@@ -2738,19 +2336,11 @@
 
 static void __exit exit_scsi(void)
 {
-	Scsi_Host_Name *shn, *shn2 = NULL;
 	int i;
 
         devfs_unregister (scsi_devfs_handle);
-        for (shn = scsi_host_no_list;shn;shn = shn->next) {
-		if (shn->name)
-			kfree(shn->name);
-                if (shn2)
-			kfree (shn2);
-                shn2 = shn;
-        }
-        if (shn2)
-		kfree (shn2);
+
+	scsi_host_hn_release();
 
 #ifdef CONFIG_PROC_FS
 	/* No, we're not here anymore. Don't show the /proc/scsi files. */
diff -Nru a/drivers/scsi/scsi_proc.c b/drivers/scsi/scsi_proc.c
--- a/drivers/scsi/scsi_proc.c	Wed Oct 16 22:51:48 2002
+++ b/drivers/scsi/scsi_proc.c	Wed Oct 16 22:51:48 2002
@@ -119,35 +119,44 @@
 	return(ret);
 }
 
-void build_proc_dir_entries(Scsi_Host_Template * tpnt)
+void scsi_proc_host_mkdir(Scsi_Host_Template *shost_tp)
 {
-	struct Scsi_Host *hpnt;
-	char name[10];	/* see scsi_unregister_host() */
-
-	tpnt->proc_dir = proc_mkdir(tpnt->proc_name, proc_scsi);
-        if (!tpnt->proc_dir) {
-                printk(KERN_ERR "Unable to proc_mkdir in scsi.c/build_proc_dir_entries");
+	shost_tp->proc_dir = proc_mkdir(shost_tp->proc_name, proc_scsi);
+        if (!shost_tp->proc_dir) {
+		printk(KERN_ERR "%s: proc_mkdir failed for %s\n",
+		       __FUNCTION__, shost_tp->proc_name);
                 return;
         }
-	tpnt->proc_dir->owner = tpnt->module;
+	shost_tp->proc_dir->owner = shost_tp->module;
+}
+
+void scsi_proc_host_add(struct Scsi_Host *shost)
+{
+	char name[10];
+	struct proc_dir_entry *p;
 
-	hpnt = scsi_hostlist;
-	while (hpnt) {
-		if (tpnt == hpnt->hostt) {
-			struct proc_dir_entry *p;
-			sprintf(name,"%d",hpnt->host_no);
-			p = create_proc_read_entry(name,
-					S_IFREG | S_IRUGO | S_IWUSR,
-					tpnt->proc_dir,
-					proc_scsi_read,
-					(void *)hpnt);
-			if (!p)
-				panic("Not enough memory to register SCSI HBA in /proc/scsi !\n");
-			p->write_proc=proc_scsi_write;
-			p->owner = tpnt->module;
-		}
-		hpnt = hpnt->next;
+	sprintf(name,"%d",shost->host_no);
+	p = create_proc_read_entry(name,
+			S_IFREG | S_IRUGO | S_IWUSR,
+			shost->hostt->proc_dir,
+			proc_scsi_read,
+			(void *)shost);
+	if (!p) {
+		printk(KERN_ERR "%s: Failed to register host %d in"
+		       "%s\n", __FUNCTION__, shost->host_no,
+		       shost->hostt->proc_name);
+	} else {
+		p->write_proc=proc_scsi_write;
+		p->owner = shost->hostt->module;
 	}
+
+}
+
+void scsi_proc_host_rm(struct Scsi_Host *shost)
+{
+	char name[10];
+	sprintf(name,"%d",shost->host_no);
+	remove_proc_entry(name, shost->hostt->proc_dir);
 }
 
 /*
diff -Nru a/drivers/scsi/scsi_syms.c b/drivers/scsi/scsi_syms.c
--- a/drivers/scsi/scsi_syms.c	Wed Oct 16 22:51:48 2002
+++ b/drivers/scsi/scsi_syms.c	Wed Oct 16 22:51:48 2002
@@ -91,8 +91,9 @@
 /*
  * These are here only while I debug the rest of the scsi stuff.
  */
-EXPORT_SYMBOL(scsi_hostlist);
-EXPORT_SYMBOL(scsi_hosts);
+EXPORT_SYMBOL(scsi_host_get_next);
+EXPORT_SYMBOL(scsi_host_hn_get);
+EXPORT_SYMBOL(scsi_host_put);
 EXPORT_SYMBOL(scsi_devicelist);
 EXPORT_SYMBOL(scsi_device_types);
 
diff -Nru a/drivers/scsi/sg.c b/drivers/scsi/sg.c
--- a/drivers/scsi/sg.c	Wed Oct 16 22:51:48 2002
+++ b/drivers/scsi/sg.c	Wed Oct 16 22:51:48 2002
@@ -3103,7 +3103,8 @@
 	struct Scsi_Host *shp;
 	int k;
 
-	for (k = 0, shp = scsi_hostlist; shp; shp = shp->next, ++k) {
+	for (k = 0, shp = scsi_host_get_next(NULL); shp;
+	     shp = scsi_host_get_next(shp), ++k) {
 		for (; k < shp->host_no; ++k)
 			PRINT_PROC("-1\t-1\t-1\t-1\t-1\t-1\n");
 		PRINT_PROC("%u\t%hu\t%hd\t%hu\t%d\t%d\n",
@@ -3147,7 +3148,8 @@
 	char buff[SG_MAX_HOST_STR_LEN];
 	char *cp;
 
-	for (k = 0, shp = scsi_hostlist; shp; shp = shp->next, ++k) {
+	for (k = 0, shp = scsi_host_get_next(NULL); shp;
+	     shp = scsi_host_get_next(shp), ++k) {
 		for (; k < shp->host_no; ++k)
 			PRINT_PROC("<no active host>\n");
 		strncpy(buff, shp->hostt->info ? shp->hostt->info(shp) :
