Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261784AbSI2USc>; Sun, 29 Sep 2002 16:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261767AbSI2URS>; Sun, 29 Sep 2002 16:17:18 -0400
Received: from fungus.teststation.com ([212.32.186.211]:39439 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S261761AbSI2UQf>; Sun, 29 Sep 2002 16:16:35 -0400
Date: Sun, 29 Sep 2002 22:21:16 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.enlightnet.local
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [patch] might_sleep fixes (2/3)
Message-ID: <Pine.LNX.4.44.0209292107380.19464-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


+ Fixes 2 cases caught by might_sleep testing.
+ Replace sleep_on with wait_event.
+ MOD_INC_USE_COUNT to prevent module unload vs smbiod thread exit race.

Please apply.

/Urban


diff -urN -X exclude linux-2.5.39-orig/fs/smbfs/Makefile linux-2.5.39-smbfs/fs/smbfs/Makefile
--- linux-2.5.39-orig/fs/smbfs/Makefile	Tue Sep 17 21:39:11 2002
+++ linux-2.5.39-smbfs/fs/smbfs/Makefile	Sun Sep 29 19:53:13 2002
@@ -15,7 +15,7 @@
 #EXTRA_CFLAGS += -DSMBFS_DEBUG_VERBOSE
 #EXTRA_CFLAGS += -DDEBUG_SMB_MALLOC
 #EXTRA_CFLAGS += -DDEBUG_SMB_TIMESTAMP
-EXTRA_CFLAGS += -Werror
+#EXTRA_CFLAGS += -Werror
 
 include $(TOPDIR)/Rules.make
 
diff -urN -X exclude linux-2.5.39-orig/fs/smbfs/inode.c linux-2.5.39-smbfs/fs/smbfs/inode.c
--- linux-2.5.39-orig/fs/smbfs/inode.c	Sat Sep 21 15:48:18 2002
+++ linux-2.5.39-smbfs/fs/smbfs/inode.c	Sun Sep 29 20:51:21 2002
@@ -434,10 +434,9 @@
 {
 	struct smb_sb_info *server = SMB_SB(sb);
 
-	smbiod_unregister_server(server);
-
 	smb_lock_server(server);
 	server->state = CONN_INVALID;
+	smbiod_unregister_server(server);
 
 	smb_close_socket(server);
 
diff -urN -X exclude linux-2.5.39-orig/fs/smbfs/proc.c linux-2.5.39-smbfs/fs/smbfs/proc.c
--- linux-2.5.39-orig/fs/smbfs/proc.c	Sat Sep 21 15:48:18 2002
+++ linux-2.5.39-smbfs/fs/smbfs/proc.c	Sun Sep 29 19:39:31 2002
@@ -1078,6 +1078,7 @@
 			VERBOSE("%s/%s R/W failed, error=%d, retrying R/O\n",
 				DENTRY_PATH(dentry), res);
 			mode = read_only;
+			req->rq_flags = 0;
 			goto retry;
 		}
 		goto out_free;
@@ -1649,6 +1650,7 @@
 			result = smb_set_rw(dentry,server);
 			if (result == 0) {
 				flag = 1;
+				req->rq_flags = 0;
 				goto retry;
 			}
 		}
diff -urN -X exclude linux-2.5.39-orig/fs/smbfs/request.c linux-2.5.39-smbfs/fs/smbfs/request.c
--- linux-2.5.39-orig/fs/smbfs/request.c	Tue Sep 17 20:05:35 2002
+++ linux-2.5.39-smbfs/fs/smbfs/request.c	Sun Sep 29 19:42:36 2002
@@ -332,8 +332,8 @@
 
 	smbiod_wake_up();
 
-	/* FIXME: replace with a timeout-able wake_event_interruptible */
-	timeleft = interruptible_sleep_on_timeout(&req->rq_wait, 30*HZ);
+	timeleft = wait_event_interruptible_timeout(req->rq_wait,
+				    req->rq_flags & SMB_REQ_RECEIVED, 30*HZ);
 	if (!timeleft || signal_pending(current)) {
 		/*
 		 * On timeout or on interrupt we want to try and remove the
@@ -346,7 +346,7 @@
 		}
 		smb_unlock_server(server);
 	}
-		
+
 	if (!timeleft) {
 		PARANOIA("request [%p, mid=%d] timed out!\n",
 			 req, req->rq_mid);
@@ -777,7 +777,7 @@
 
 	/*
 	 * Response completely read. Drop any extra bytes sent by the server.
-	 * (Yes, servers sometimes add extra bytes to requests)
+	 * (Yes, servers sometimes add extra bytes to responses)
 	 */
 	VERBOSE("smb_len: %d   smb_read: %d\n",
 		server->smb_len, server->smb_read);
diff -urN -X exclude linux-2.5.39-orig/fs/smbfs/smbiod.c linux-2.5.39-smbfs/fs/smbfs/smbiod.c
--- linux-2.5.39-orig/fs/smbfs/smbiod.c	Tue Sep 17 20:05:46 2002
+++ linux-2.5.39-smbfs/fs/smbfs/smbiod.c	Sun Sep 29 20:59:17 2002
@@ -18,6 +18,7 @@
 #include <linux/file.h>
 #include <linux/dcache.h>
 #include <linux/smp_lock.h>
+#include <linux/module.h>
 #include <net/ip.h>
 
 #include <linux/smb_fs.h>
@@ -31,7 +32,14 @@
 #include "request.h"
 #include "proto.h"
 
-static int smbiod_pid = -1;
+enum smbiod_state {
+	SMBIOD_DEAD,
+	SMBIOD_STARTING,
+	SMBIOD_RUNNING,
+};
+
+static enum smbiod_state smbiod_state = SMBIOD_DEAD;
+static pid_t smbiod_pid;
 static DECLARE_WAIT_QUEUE_HEAD(smbiod_wait);
 static LIST_HEAD(smb_servers);
 static spinlock_t servers_lock = SPIN_LOCK_UNLOCKED;
@@ -41,14 +49,13 @@
 
 static int smbiod(void *);
 static void smbiod_start(void);
-static void smbiod_stop(void);
 
 /*
  * called when there's work for us to do
  */
 void smbiod_wake_up()
 {
-	if (smbiod_pid == -1)
+	if (smbiod_state == SMBIOD_DEAD)
 		return;
 	set_bit(SMBIOD_DATA_READY, &smbiod_flags);
 	wake_up_interruptible(&smbiod_wait);
@@ -59,18 +66,16 @@
  */
 static void smbiod_start()
 {
-	if (smbiod_pid != -1)
+	pid_t pid;
+	if (smbiod_state != SMBIOD_DEAD)
 		return;
-	smbiod_pid = kernel_thread(smbiod, NULL, 0);
-}
+	smbiod_state = SMBIOD_STARTING;
+	spin_unlock(&servers_lock);
+	pid = kernel_thread(smbiod, NULL, 0);
 
-/*
- * stop smbiod if there are no open connections
- */
-static void smbiod_stop()
-{
-	if (smbiod_pid != -1 && list_empty(&smb_servers))
-		kill_proc(smbiod_pid, SIGKILL, 1);
+	spin_lock(&servers_lock);
+	smbiod_state = SMBIOD_RUNNING;
+	smbiod_pid = pid;
 }
 
 /*
@@ -86,19 +91,18 @@
 }
 
 /*
- * unregister a server & stop smbiod if necessary
+ * Unregister a server
+ * Must be called with the server lock held.
  */
 void smbiod_unregister_server(struct smb_sb_info *server)
 {
 	spin_lock(&servers_lock);
 	list_del_init(&server->entry);
 	VERBOSE("%p\n", server);
-	smbiod_stop();
 	spin_unlock(&servers_lock);
 
-	smb_lock_server(server);
+	smbiod_wake_up();
 	smbiod_flush(server);
-	smb_unlock_server(server);
 }
 
 void smbiod_flush(struct smb_sb_info *server)
@@ -277,6 +281,7 @@
  */
 static int smbiod(void *unused)
 {
+	MOD_INC_USE_COUNT;
 	daemonize();
 
 	spin_lock_irq(&current->sigmask_lock);
@@ -295,32 +300,40 @@
 		/* FIXME: Use poll? */
 		wait_event_interruptible(smbiod_wait,
 			 test_bit(SMBIOD_DATA_READY, &smbiod_flags));
-		if (signal_pending(current))
+		if (signal_pending(current)) {
+			spin_lock(&servers_lock);
+			smbiod_state = SMBIOD_DEAD;
+			spin_unlock(&servers_lock);
 			break;
+		}
 
 		clear_bit(SMBIOD_DATA_READY, &smbiod_flags);
 
-		/*
-		 * We must hold the servers_lock while looking for servers
-		 * to check or else we have a race with put_super.
-		 */
 		spin_lock(&servers_lock);
+		if (list_empty(&smb_servers)) {
+			smbiod_state = SMBIOD_DEAD;
+			spin_unlock(&servers_lock);
+			break;
+		}
+
 		list_for_each_safe(pos, n, &smb_servers) {
 			server = list_entry(pos, struct smb_sb_info, entry);
 			VERBOSE("checking server %p\n", server);
-			smb_lock_server(server);
-			spin_unlock(&servers_lock);
 
-			smbiod_doio(server);
+			if (server->state == CONN_VALID) {
+				spin_unlock(&servers_lock);
 
-			smb_unlock_server(server);
-			spin_lock(&servers_lock);
+				smb_lock_server(server);
+				smbiod_doio(server);
+				smb_unlock_server(server);
+
+				spin_lock(&servers_lock);
+			}
 		}
 		spin_unlock(&servers_lock);
 	}
 
 	VERBOSE("SMB Kernel thread exiting (%d) ...\n", current->pid);
-	smbiod_pid = -1;
-
+	MOD_DEC_USE_COUNT;
 	return 0;
 }

