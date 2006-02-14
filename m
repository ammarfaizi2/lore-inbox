Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422723AbWBNRyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422723AbWBNRyl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 12:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422724AbWBNRyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 12:54:41 -0500
Received: from verein.lst.de ([213.95.11.210]:11981 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1422723AbWBNRyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 12:54:40 -0500
Date: Tue, 14 Feb 2006 18:54:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: sfrench@samba.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: use kthread_ API
Message-ID: <20060214175415.GE19080@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the kthread_ API instead of opencoding lots of hairy code for kernel
thread creation and teardown.

Also cleanup cifs_init to properly unwind when thread creation fails.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/fs/cifs/connect.c
===================================================================
--- linux-2.6.orig/fs/cifs/connect.c	2006-02-04 13:35:01.000000000 +0100
+++ linux-2.6/fs/cifs/connect.c	2006-02-10 14:41:38.000000000 +0100
@@ -31,6 +31,7 @@
 #include <linux/delay.h>
 #include <linux/completion.h>
 #include <linux/pagevec.h>
+#include <linux/kthread.h>
 #include <asm/uaccess.h>
 #include <asm/processor.h>
 #include "cifspdu.h"
@@ -47,8 +48,6 @@
 #define CIFS_PORT 445
 #define RFC1001_PORT 139
 
-static DECLARE_COMPLETION(cifsd_complete);
-
 extern void SMBencrypt(unsigned char *passwd, unsigned char *c8,
 		       unsigned char *p24);
 extern void SMBNTencrypt(unsigned char *passwd, unsigned char *c8,
@@ -329,8 +328,9 @@
 }
 
 static int
-cifs_demultiplex_thread(struct TCP_Server_Info *server)
+cifs_demultiplex_thread(void *data)
 {
+	struct TCP_Server_Info *server = data;
 	int length;
 	unsigned int pdu_length, total_read;
 	struct smb_hdr *smb_buffer = NULL;
@@ -348,23 +348,20 @@
 	int isMultiRsp;
 	int reconnect;
 
-	daemonize("cifsd");
-	allow_signal(SIGKILL);
 	current->flags |= PF_MEMALLOC;
-	server->tsk = current;	/* save process info to wake at shutdown */
 	cFYI(1, ("Demultiplex PID: %d", current->pid));
 	write_lock(&GlobalSMBSeslock); 
 	atomic_inc(&tcpSesAllocCount);
 	length = tcpSesAllocCount.counter;
 	write_unlock(&GlobalSMBSeslock);
-	complete(&cifsd_complete);
+
 	if(length  > 1) {
 		mempool_resize(cifs_req_poolp,
 			length + cifs_min_rcv,
 			GFP_KERNEL);
 	}
 
-	while (server->tcpStatus != CifsExiting) {
+	while (server->tcpStatus != CifsExiting && !kthread_should_stop()) {
 		if (try_to_freeze())
 			continue;
 		if (bigbuf == NULL) {
@@ -403,7 +400,7 @@
 		    kernel_recvmsg(csocket, &smb_msg,
 				 &iov, 1, 4, 0 /* BB see socket.h flags */);
 
-		if(server->tcpStatus == CifsExiting) {
+		if(server->tcpStatus == CifsExiting || kthread_should_stop()) {
 			break;
 		} else if (server->tcpStatus == CifsNeedReconnect) {
 			cFYI(1,("Reconnect after server stopped responding"));
@@ -749,7 +746,6 @@
 			GFP_KERNEL);
 	}
 	
-	complete_and_exit(&cifsd_complete, 0);
 	return 0;
 }
 
@@ -1713,17 +1709,17 @@
 			so no need to spinlock this init of tcpStatus */
 			srvTcp->tcpStatus = CifsNew;
 			init_MUTEX(&srvTcp->tcpSem);
-			rc = (int)kernel_thread((void *)(void *)cifs_demultiplex_thread, srvTcp,
-				      CLONE_FS | CLONE_FILES | CLONE_VM);
-			if(rc < 0) {
-				rc = -ENOMEM;
+
+			srvTcp->tsk = kthread_create(cifs_demultiplex_thread, srvTcp, "cifsd");
+			if (IS_ERR(srvTcp->tsk)) {
+				rc = PTR_ERR(srvTcp->tsk);
 				sock_release(csocket);
 				kfree(volume_info.UNC);
 				kfree(volume_info.password);
 				FreeXid(xid);
 				return rc;
 			}
-			wait_for_completion(&cifsd_complete);
+
 			rc = 0;
 			memcpy(srvTcp->workstation_RFC1001_name, volume_info.source_rfc1001_name,16);
 			memcpy(srvTcp->server_RFC1001_name, volume_info.target_rfc1001_name,16);
@@ -1889,10 +1885,7 @@
 			spin_lock(&GlobalMid_Lock);
 			srvTcp->tcpStatus = CifsExiting;
 			spin_unlock(&GlobalMid_Lock);
-			if(srvTcp->tsk) {
-				send_sig(SIGKILL,srvTcp->tsk,1);
-				wait_for_completion(&cifsd_complete);
-			}
+			kthread_stop(srvTcp->tsk);
 		}
 		 /* If find_unc succeeded then rc == 0 so we can not end */
 		if (tcon)  /* up accidently freeing someone elses tcon struct */
@@ -1905,10 +1898,8 @@
 					temp_rc = CIFSSMBLogoff(xid, pSesInfo);
 					/* if the socketUseCount is now zero */
 					if((temp_rc == -ESHUTDOWN) &&
-					   (pSesInfo->server->tsk)) {
-						send_sig(SIGKILL,pSesInfo->server->tsk,1);
-						wait_for_completion(&cifsd_complete);
-					}
+					   (pSesInfo->server->tsk))
+						kthread_stop(srvTcp->tsk);
 				} else
 					cFYI(1, ("No session or bad tcon"));
 				sesInfoFree(pSesInfo);
@@ -3387,10 +3378,8 @@
 				return 0;
 			} else if (rc == -ESHUTDOWN) {
 				cFYI(1,("Waking up socket by sending it signal"));
-				if(cifsd_task) {
-					send_sig(SIGKILL,cifsd_task,1);
-					wait_for_completion(&cifsd_complete);
-				}
+				if(cifsd_task)
+					kthread_stop(cifsd_task);
 				rc = 0;
 			} /* else - we have an smb session
 				left on this socket do not kill cifsd */
Index: linux-2.6/fs/cifs/cifsfs.c
===================================================================
--- linux-2.6.orig/fs/cifs/cifsfs.c	2006-01-26 13:52:05.000000000 +0100
+++ linux-2.6/fs/cifs/cifsfs.c	2006-02-10 14:52:23.000000000 +0100
@@ -33,6 +33,7 @@
 #include <linux/vfs.h>
 #include <linux/mempool.h>
 #include <linux/delay.h>
+#include <linux/kthread.h>
 #include "cifsfs.h"
 #include "cifspdu.h"
 #define DECLARE_GLOBALS_HERE
@@ -75,9 +76,6 @@
 module_param(cifs_max_pending, int, 0);
 MODULE_PARM_DESC(cifs_max_pending,"Simultaneous requests to server. Default: 50 Range: 2 to 256");
 
-static DECLARE_COMPLETION(cifs_oplock_exited);
-static DECLARE_COMPLETION(cifs_dnotify_exited);
-
 extern mempool_t *cifs_sm_req_poolp;
 extern mempool_t *cifs_req_poolp;
 extern mempool_t *cifs_mid_poolp;
@@ -849,10 +847,6 @@
 	__u16  netfid;
 	int rc;
 
-	daemonize("cifsoplockd");
-	allow_signal(SIGTERM);
-
-	oplockThread = current;
 	do {
 		if (try_to_freeze()) 
 			continue;
@@ -908,9 +902,9 @@
 			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(1);  /* yield in case q were corrupt */
 		}
-	} while(!signal_pending(current));
-	oplockThread = NULL;
-	complete_and_exit (&cifs_oplock_exited, 0);
+	} while (!kthread_should_stop());
+
+	return 0;
 }
 
 static int cifs_dnotify_thread(void * dummyarg)
@@ -918,10 +912,6 @@
 	struct list_head *tmp;
 	struct cifsSesInfo *ses;
 
-	daemonize("cifsdnotifyd");
-	allow_signal(SIGTERM);
-
-	dnotifyThread = current;
 	do {
 		if(try_to_freeze())
 			continue;
@@ -939,8 +929,9 @@
 				wake_up_all(&ses->server->response_q);
 		}
 		read_unlock(&GlobalSMBSeslock);
-	} while(!signal_pending(current));
-	complete_and_exit (&cifs_dnotify_exited, 0);
+	} while (!kthread_should_stop());
+
+	return 0;
 }
 
 static int __init
@@ -990,32 +981,48 @@
 	}
 
 	rc = cifs_init_inodecache();
-	if (!rc) {
-		rc = cifs_init_mids();
-		if (!rc) {
-			rc = cifs_init_request_bufs();
-			if (!rc) {
-				rc = register_filesystem(&cifs_fs_type);
-				if (!rc) {                
-					rc = (int)kernel_thread(cifs_oplock_thread, NULL, 
-						CLONE_FS | CLONE_FILES | CLONE_VM);
-					if(rc > 0) {
-						rc = (int)kernel_thread(cifs_dnotify_thread, NULL,
-							CLONE_FS | CLONE_FILES | CLONE_VM);
-						if(rc > 0)
-							return 0;
-						else
-							cERROR(1,("error %d create dnotify thread", rc));
-					} else {
-						cERROR(1,("error %d create oplock thread",rc));
-					}
-				}
-				cifs_destroy_request_bufs();
-			}
-			cifs_destroy_mids();
-		}
-		cifs_destroy_inodecache();
+	if (rc)
+		goto out_clean_proc;
+
+	rc = cifs_init_mids();
+	if (rc)
+		goto out_destroy_inodecache;
+
+	rc = cifs_init_request_bufs();
+	if (rc)
+		goto out_destroy_mids;
+
+	rc = register_filesystem(&cifs_fs_type);
+	if (rc)
+		goto out_destroy_request_bufs;
+
+	oplockThread = kthread_run(cifs_oplock_thread, NULL, "cifsoplockd");
+	if (IS_ERR(oplockThread)) {
+		rc = PTR_ERR(oplockThread);
+		cERROR(1,("error %d create oplock thread", rc));
+		goto out_unregister_filesystem;
+	}
+
+	dnotifyThread = kthread_run(cifs_dnotify_thread, NULL, "cifsdnotifyd");
+	if (IS_ERR(dnotifyThread)) {
+		rc = PTR_ERR(dnotifyThread);
+		cERROR(1,("error %d create dnotify thread", rc));
+		goto out_stop_oplock_thread;
 	}
+
+	return 0;
+
+ out_stop_oplock_thread:
+	kthread_stop(oplockThread);
+ out_unregister_filesystem:
+	unregister_filesystem(&cifs_fs_type);
+ out_destroy_request_bufs:
+	cifs_destroy_request_bufs();
+ out_destroy_mids:
+	cifs_destroy_mids();
+ out_destroy_inodecache:
+	cifs_destroy_inodecache();
+ out_clean_proc:
 #ifdef CONFIG_PROC_FS
 	cifs_proc_clean();
 #endif
@@ -1033,14 +1040,8 @@
 	cifs_destroy_inodecache();
 	cifs_destroy_mids();
 	cifs_destroy_request_bufs();
-	if(oplockThread) {
-		send_sig(SIGTERM, oplockThread, 1);
-		wait_for_completion(&cifs_oplock_exited);
-	}
-	if(dnotifyThread) {
-		send_sig(SIGTERM, dnotifyThread, 1);
-		wait_for_completion(&cifs_dnotify_exited);
-	}
+	kthread_stop(oplockThread);
+	kthread_stop(dnotifyThread);
 }
 
 MODULE_AUTHOR("Steve French <sfrench@us.ibm.com>");
