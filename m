Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318650AbSHEQMp>; Mon, 5 Aug 2002 12:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318661AbSHEQL2>; Mon, 5 Aug 2002 12:11:28 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:62094 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S318643AbSHEQJ2>; Mon, 5 Aug 2002 12:09:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arndb@de.ibm.com>
Reply-To: arnd@bergmann-dalldorf.de
Organization: IBM Deutschland Entwicklung GmbH
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] 18/18 scsi core changes
Date: Mon, 5 Aug 2002 20:08:35 +0200
User-Agent: KMail/1.4.2
Cc: lkml <linux-kernel@vger.kernel.org>
References: <200208051830.50713.arndb@de.ibm.com>
In-Reply-To: <200208051830.50713.arndb@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208052008.35187.arndb@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does not look fit for inclusion to me, but appearantly it's
needed if anyone actually wants to use the new zfcp driver I sent with
patch 10/18...

diff -urN linux-2.4.19-rc3/drivers/scsi/Config.in linux-2.4.19-s390/drivers/scsi/Config.in
--- linux-2.4.19-rc3/drivers/scsi/Config.in	Tue Jul 30 09:02:28 2002
+++ linux-2.4.19-s390/drivers/scsi/Config.in	Tue Jul 30 09:02:54 2002
@@ -45,6 +45,8 @@
 if [ "$CONFIG_PCI" = "y" ]; then
    dep_tristate '3ware Hardware ATA-RAID support' CONFIG_BLK_DEV_3W_XXXX_RAID $CONFIG_SCSI
 fi
+
+if [ "$CONFIG_ARCH_S390" != "y" ]; then
 dep_tristate '7000FASST SCSI support' CONFIG_SCSI_7000FASST $CONFIG_SCSI
 dep_tristate 'ACARD SCSI support' CONFIG_SCSI_ACARD $CONFIG_SCSI
 dep_tristate 'Adaptec AHA152X/2825 support' CONFIG_SCSI_AHA152X $CONFIG_SCSI
@@ -251,6 +253,12 @@
 #      bool 'Cyberstorm Mk III SCSI support (EXPERIMENTAL)' CONFIG_CYBERSTORMIII_SCSI
 #      bool 'GVP Turbo 040/060 SCSI support (EXPERIMENTAL)' CONFIG_GVP_TURBO_SCSI
    fi
+fi
+
+fi
+
+if [ "$CONFIG_ARCH_S390" = "y" ]; then
+dep_tristate 'IBM z900 FCP host bus adapter driver' CONFIG_ZFCP $CONFIG_QDIO
 fi
 
 endmenu
diff -urN linux-2.4.19-rc3/drivers/scsi/hosts.c linux-2.4.19-s390/drivers/scsi/hosts.c
--- linux-2.4.19-rc3/drivers/scsi/hosts.c	Tue Jul 30 09:02:22 2002
+++ linux-2.4.19-s390/drivers/scsi/hosts.c	Tue Jul 30 09:02:34 2002
@@ -81,13 +81,31 @@
 struct Scsi_Host * scsi_hostlist;
 struct Scsi_Device_Template * scsi_devicelist;
 
-int max_scsi_hosts;
-int next_scsi_host;
+int max_scsi_hosts;	/* host_no for next new host */
+int next_scsi_host;	/* count of registered scsi hosts */
 
 void
 scsi_unregister(struct Scsi_Host * sh){
     struct Scsi_Host * shpnt;
     Scsi_Host_Name *shn;
+    char name[10];
+
+    /* kill error handling thread */
+    if (sh->hostt->use_new_eh_code
+        && sh->ehandler != NULL) {
+            DECLARE_MUTEX_LOCKED(sem);
+            
+            sh->eh_notify = &sem;
+            send_sig(SIGHUP, sh->ehandler, 1);
+            down(&sem);
+            sh->eh_notify = NULL;
+    }
+   
+    /* remove proc entry */
+#ifdef CONFIG_PROC_FS
+    sprintf(name, "%d", sh->host_no);
+    remove_proc_entry(name, sh->hostt->proc_dir);
+#endif
         
     if(scsi_hostlist == sh)
 	scsi_hostlist = sh->next;
@@ -107,6 +125,18 @@
     if (shn) shn->host_registered = 0;
     /* else {} : This should not happen, we should panic here... */
     
+#if 1
+    /* We shoult not decrement max_scsi_hosts (and make this value
+     * candidate for re-allocation by a different driver).
+     * Reason: the device is _still_ on the
+     * scsi_host_no_list and it's identified by its name. When the same
+     * device is re-registered it will get the same host_no again while
+     * new devices may use the allocation scheme and get this very same
+     * host_no.
+     * It's OK to have "holes" in the allocation but it does not mean
+     * "leaks".
+     */
+#else // if 0
     /* If we are removing the last host registered, it is safe to reuse
      * its host number (this avoids "holes" at boot time) (DB) 
      * It is also safe to reuse those of numbers directly below which have
@@ -121,7 +151,9 @@
 		break;
 	}
     }
+#endif
     next_scsi_host--;
+
     kfree((char *) sh);
 }
 
@@ -135,6 +167,7 @@
     Scsi_Host_Name *shn, *shn2;
     int flag_new = 1;
     const char * hname;
+    char *name;
     size_t hname_len;
     retval = (struct Scsi_Host *)kmalloc(sizeof(struct Scsi_Host) + j,
 					 (tpnt->unchecked_isa_dma && j ? 
@@ -262,6 +295,35 @@
 		o_shp->next = retval;
         }
     }
+    
+#ifdef CONFIG_PROC_FS
+    build_proc_dir_entry(retval);
+#endif
+    
+    /* Start error handling thread */
+    if (retval->hostt->use_new_eh_code) {
+            DECLARE_MUTEX_LOCKED(sem);
+            
+            retval->eh_notify = &sem;
+            kernel_thread((int (*)(void *)) scsi_error_handler,
+                          (void *) retval, 0);
+            
+            /*
+             * Now wait for the kernel error thread to initialize itself
+             * as it might be needed when we scan the bus.
+             */
+            down(&sem);
+            retval->eh_notify = NULL;
+    }
+
+    if (tpnt->info) {
+            name = (char *)tpnt->info(retval);
+    } else {
+            name = (char *)tpnt->name;
+    }
+    printk(KERN_INFO "scsi%d : %s\n",		/* And print a little message */
+                   retval->host_no, name);
+    
     
     return retval;
 }
diff -urN linux-2.4.19-rc3/drivers/scsi/hosts.h linux-2.4.19-s390/drivers/scsi/hosts.h
--- linux-2.4.19-rc3/drivers/scsi/hosts.h	Tue Jul 30 09:02:22 2002
+++ linux-2.4.19-s390/drivers/scsi/hosts.h	Tue Jul 30 09:02:34 2002
@@ -464,7 +464,10 @@
 
 extern Scsi_Host_Template * scsi_hosts;
 
-extern void build_proc_dir_entries(Scsi_Host_Template  *);
+#ifdef CONFIG_PROC_FS
+extern void build_proc_dir(Scsi_Host_Template *);
+extern void build_proc_dir_entry(struct Scsi_Host *);
+#endif
 
 /*
  *  scsi_init initializes the scsi hosts.
diff -urN linux-2.4.19-rc3/drivers/scsi/scsi.c linux-2.4.19-s390/drivers/scsi/scsi.c
--- linux-2.4.19-rc3/drivers/scsi/scsi.c	Tue Jul 30 09:02:28 2002
+++ linux-2.4.19-s390/drivers/scsi/scsi.c	Tue Jul 30 09:02:55 2002
@@ -533,22 +533,10 @@
 				   SCpnt->target,
 				   atomic_read(&SCpnt->host->host_active),
 				   SCpnt->host->host_failed));
-	if (SCpnt->host->host_failed != 0) {
-		SCSI_LOG_ERROR_RECOVERY(5, printk("Error handler thread %d %d\n",
-						SCpnt->host->in_recovery,
-						SCpnt->host->eh_active));
-	}
-	/*
-	 * If the host is having troubles, then look to see if this was the last
-	 * command that might have failed.  If so, wake up the error handler.
-	 */
-	if (SCpnt->host->in_recovery
-	    && !SCpnt->host->eh_active
-	    && SCpnt->host->host_busy == SCpnt->host->host_failed) {
-		SCSI_LOG_ERROR_RECOVERY(5, printk("Waking error handler thread (%d)\n",
-			     atomic_read(&SCpnt->host->eh_wait->count)));
-		up(SCpnt->host->eh_wait);
-	}
+
+        /* Note: The eh_thread is now started in scsi_bottom_half_handler for 
+         * all cases except command timeout
+         */
 
 	spin_unlock_irqrestore(&device_request_lock, flags);
 
@@ -1296,26 +1284,38 @@
 					SCpnt->owner = SCSI_OWNER_ERROR_HANDLER;
 					SCpnt->state = SCSI_STATE_FAILED;
 					SCpnt->host->in_recovery = 1;
-					/*
-					 * If the host is having troubles, then look to see if this was the last
-					 * command that might have failed.  If so, wake up the error handler.
-					 */
-					if (SCpnt->host->host_busy == SCpnt->host->host_failed) {
-						SCSI_LOG_ERROR_RECOVERY(5, printk("Waking error handler thread (%d)\n",
-										  atomic_read(&SCpnt->host->eh_wait->count)));
-						up(SCpnt->host->eh_wait);
-					}
-				} else {
-					/*
-					 * We only get here if the error recovery thread has died.
-					 */
+                                } else {
+                                        /* eh not present....trying to continue anyway */
 					scsi_finish_command(SCpnt);
-				}
+                                }
+                                break;
+                        } // switch
+                        if (SCpnt->host->eh_wait != NULL) {
+                                /*
+                                 * If the host is having troubles, then look to see if this was the last
+                                 * command that might have failed.  If so, wake up the error handler.
+                                 */
+                                if (SCpnt->host->in_recovery && 
+                                    !SCpnt->host->eh_active &&
+                                    (SCpnt->host->host_busy == SCpnt->host->host_failed)) {
+                                        SCSI_LOG_ERROR_RECOVERY(5, printk("Waking error handler thread (%d)\n",
+                                                                          atomic_read(&SCpnt->host->eh_wait->count)));
+                                        printk("(in_recovery=%d, host_busy=%d, host_failed=%d) "
+                                               "Waking error handler thread bh(%d)\n",
+                                               SCpnt->host->in_recovery,
+                                               SCpnt->host->host_busy,
+                                               SCpnt->host->host_failed,
+                                               atomic_read(&SCpnt->host->eh_wait->count));
+                                        up(SCpnt->host->eh_wait);
+                                }
+                        } else {
+                                SCSI_LOG_ERROR_RECOVERY(5, printk("Warning: eh_thread not present\n"));
 			}
+                        
 		}		/* for(; SCpnt...) */
-
+                
 	}			/* while(1==1) */
-
+        
 }
 
 /*
@@ -1864,7 +1864,6 @@
 	struct Scsi_Host *shpnt;
 	Scsi_Device *SDpnt;
 	struct Scsi_Device_Template *sdtpnt;
-	const char *name;
 	unsigned long flags;
 	int out_of_space = 0;
 
@@ -1896,6 +1895,11 @@
 	} else
 		tpnt->present = tpnt->detect(tpnt);
 
+	/* Add the new driver to /proc/scsi (directory only) */
+#ifdef CONFIG_PROC_FS
+	build_proc_dir(tpnt);
+#endif
+
 	if (tpnt->present) {
 		if (pcount == next_scsi_host) {
 			if (tpnt->present > 1) {
@@ -1917,45 +1921,6 @@
 		tpnt->next = scsi_hosts;	/* Add to the linked list */
 		scsi_hosts = tpnt;
 
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
-			if (shpnt->hostt == tpnt && shpnt->hostt->use_new_eh_code) {
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
-			}
-		}
-
 		/* The next step is to call scan_scsis here.  This generates the
 		 * Scsi_Devices entries
 		 */
@@ -2032,7 +1997,6 @@
 	struct Scsi_Device_Template *sdtpnt;
 	struct Scsi_Host *sh1;
 	struct Scsi_Host *shpnt;
-	char name[10];	/* host_no>=10^9? I don't think so. */
 
 	/* get the big kernel lock, so we don't race with open() */
 	lock_kernel();
@@ -2134,18 +2098,6 @@
 	/*
 	 * Next, kill the kernel error recovery thread for this host.
 	 */
-	for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
-		if (shpnt->hostt == tpnt
-		    && shpnt->hostt->use_new_eh_code
-		    && shpnt->ehandler != NULL) {
-			DECLARE_MUTEX_LOCKED(sem);
-
-			shpnt->eh_notify = &sem;
-			send_sig(SIGHUP, shpnt->ehandler, 1);
-			down(&sem);
-			shpnt->eh_notify = NULL;
-		}
-	}
 
 	/* Next we free up the Scsi_Cmnd structures for this host */
 
@@ -2174,9 +2126,6 @@
 		if (shpnt->hostt != tpnt)
 			continue;
 		pcount = next_scsi_host;
-		/* Remove the /proc/scsi directory entry */
-		sprintf(name,"%d",shpnt->host_no);
-		remove_proc_entry(name, tpnt->proc_dir);
 		if (tpnt->release)
 			(*tpnt->release) (shpnt);
 		else {
diff -urN linux-2.4.19-rc3/drivers/scsi/scsi.h linux-2.4.19-s390/drivers/scsi/scsi.h
--- linux-2.4.19-rc3/drivers/scsi/scsi.h	Tue Jul 30 09:02:28 2002
+++ linux-2.4.19-s390/drivers/scsi/scsi.h	Tue Jul 30 09:02:55 2002
@@ -390,6 +390,17 @@
 #include <asm/pgtable.h>
 #define CONTIGUOUS_BUFFERS(X,Y) \
 	(virt_to_phys((X)->b_data+(X)->b_size-1)+1==virt_to_phys((Y)->b_data))
+#elif defined(CONFIG_ARCH_S390) || defined(CONFIG_ARCH_S390X)
+#define _CONTIGUOUS_BUFFERS(xd, xs, yd, ys) \
+     (((xd + xs) == yd) \
+      && ((xd & PAGE_MASK) == ((yd + ys - 1) & PAGE_MASK)))
+
+#define CONTIGUOUS_BUFFERS(X,Y) \
+	_CONTIGUOUS_BUFFERS( \
+		(unsigned long)(X)->b_data, \
+		(unsigned long)(X)->b_size, \
+		(unsigned long)(Y)->b_data, \
+		(unsigned long)(Y)->b_size)
 #else
 #define CONTIGUOUS_BUFFERS(X,Y) ((X->b_data+X->b_size) == Y->b_data)
 #endif
diff -urN linux-2.4.19-rc3/drivers/scsi/scsi_lib.c linux-2.4.19-s390/drivers/scsi/scsi_lib.c
--- linux-2.4.19-rc3/drivers/scsi/scsi_lib.c	Tue Jul 30 09:02:29 2002
+++ linux-2.4.19-s390/drivers/scsi/scsi_lib.c	Tue Jul 30 09:02:55 2002
@@ -262,6 +262,15 @@
 		 * the bad sector.
 		 */
 		SCpnt->request.special = (void *) SCpnt;
+                /*
+                 * We need to recount the number of
+                 * scatter-gather segments here - the
+                 * normal case code assumes this to be
+                 * correct, as it would be a performance
+                 * loss to always recount.  Handling
+                 * errors is always unusual, of course.
+                 */
+                recount_segments(SCpnt);
 		list_add(&SCpnt->request.queue, &q->queue_head);
 	}
 
@@ -969,15 +978,6 @@
 			 */
 			if( req->special != NULL ) {
 				SCpnt = (Scsi_Cmnd *) req->special;
-				/*
-				 * We need to recount the number of
-				 * scatter-gather segments here - the
-				 * normal case code assumes this to be
-				 * correct, as it would be a performance
-				 * lose to always recount.  Handling
-				 * errors is always unusual, of course.
-				 */
-				recount_segments(SCpnt);
 			} else {
 				SCpnt = scsi_allocate_device(SDpnt, FALSE, FALSE);
 			}
diff -urN linux-2.4.19-rc3/drivers/scsi/scsi_proc.c linux-2.4.19-s390/drivers/scsi/scsi_proc.c
--- linux-2.4.19-rc3/drivers/scsi/scsi_proc.c	Thu Jun 28 02:10:55 2001
+++ linux-2.4.19-s390/drivers/scsi/scsi_proc.c	Tue Jul 30 09:01:23 2002
@@ -120,35 +120,34 @@
 	return(ret);
 }
 
-void build_proc_dir_entries(Scsi_Host_Template * tpnt)
-{
-	struct Scsi_Host *hpnt;
-	char name[10];	/* see scsi_unregister_host() */
+void build_proc_dir_entry(struct Scsi_Host *shpnt) {
+	char name[10]; /* host_no>=10^9? I don't think so. */
+	struct proc_dir_entry *p;
 
-	tpnt->proc_dir = proc_mkdir(tpnt->proc_name, proc_scsi);
-        if (!tpnt->proc_dir) {
-                printk(KERN_ERR "Unable to proc_mkdir in scsi.c/build_proc_dir_entries");
-                return;
-        }
-	tpnt->proc_dir->owner = tpnt->module;
+	if(shpnt->hostt->proc_dir) {
+		sprintf(name, "%d", shpnt->host_no);
+		p = create_proc_read_entry(
+			name,
+			S_IFREG | S_IRUGO | S_IWUSR,
+			shpnt->hostt->proc_dir,
+			proc_scsi_read,
+			(void *) shpnt
+		);
+		if (!p)
+			panic("Not enough memory to register SCSI HBA in /proc/scsi !\n");
+		p->write_proc=proc_scsi_write;
+		p->owner = shpnt->hostt->module;
+	}
+}
 
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
+void build_proc_dir(Scsi_Host_Template * tpnt)
+{
+	tpnt->proc_dir = proc_mkdir(tpnt->proc_name, proc_scsi);
+	if (!tpnt->proc_dir) {
+		printk(KERN_ERR "Unable to proc_mkdir in scsi.c/build_proc_dir_entries");
+		return;
 	}
+	tpnt->proc_dir->owner = tpnt->module;
 }
 
 /*


