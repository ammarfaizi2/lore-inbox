Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264881AbSJPFdq>; Wed, 16 Oct 2002 01:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264883AbSJPFdq>; Wed, 16 Oct 2002 01:33:46 -0400
Received: from modemcable061.219-201-24.mtl.mc.videotron.ca ([24.201.219.61]:5509
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S264881AbSJPFdo>; Wed, 16 Oct 2002 01:33:44 -0400
Date: Wed, 16 Oct 2002 01:26:36 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: sfrench@us.ibm.com
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5] CIFS find_tcp_session/GlobalSMBSessionList protection
Message-ID: <Pine.LNX.4.44.0210160036130.1460-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any other interaction i'm missing and should protect from?

Index: linux-2.5.43/fs/cifs/cifs_debug.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.43/fs/cifs/cifs_debug.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 cifs_debug.c
--- linux-2.5.43/fs/cifs/cifs_debug.c	16 Oct 2002 03:46:04 -0000	1.1.1.1
+++ linux-2.5.43/fs/cifs/cifs_debug.c	16 Oct 2002 05:13:08 -0000
@@ -79,6 +79,7 @@
 	buf += length;
 
 	i = 0;
+	down_read(&GlobalSMB_Sem);
 	list_for_each(tmp, &GlobalSMBSessionList) {
 		i++;
 		ses = list_entry(tmp, struct cifsSesInfo, cifsSessionList);
@@ -91,6 +92,7 @@
 			    ses->serverOS, ses->serverNOS, ses->capabilities);
 		buf += length;
 	}
+
 	sprintf(buf, "\n");
 	buf++;
 	printk("\nTotal Buffer so far: %s\n", buf_start);
@@ -122,6 +124,8 @@
 				    tcon->fsDevInfo.DeviceType);
 		buf += length;
 	}
+	up_read(&GlobalSMB_Sem);
+
 	length = sprintf(buf, "\n");
 	buf += length;
 	*eof = 1;
Index: linux-2.5.43/fs/cifs/cifsglob.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.43/fs/cifs/cifsglob.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 cifsglob.h
--- linux-2.5.43/fs/cifs/cifsglob.h	16 Oct 2002 03:46:04 -0000	1.1.1.1
+++ linux-2.5.43/fs/cifs/cifsglob.h	16 Oct 2002 05:23:37 -0000
@@ -292,6 +292,8 @@
  */
 GLOBAL_EXTERN struct smbUidInfo *GlobalUidList[UID_HASH];
 
+/* The following are protected by GlobalSMB_Sem */
+GLOBAL_EXTERN struct rw_semaphore GlobalSMB_Sem;
 GLOBAL_EXTERN struct list_head GlobalServerList;	/* BB this one is not implemented yet */
 GLOBAL_EXTERN struct list_head GlobalSMBSessionList;
 GLOBAL_EXTERN struct list_head GlobalTreeConnectionList;
Index: linux-2.5.43/fs/cifs/connect.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.43/fs/cifs/connect.c,v
retrieving revision 1.2
diff -u -r1.2 connect.c
--- linux-2.5.43/fs/cifs/connect.c	16 Oct 2002 04:33:05 -0000	1.2
+++ linux-2.5.43/fs/cifs/connect.c	16 Oct 2002 05:24:29 -0000
@@ -253,12 +253,14 @@
 	}
 	/* BB add code to lock SMB sessions while releasing */
 	if(server->ssocket) {
-        sock_release(csocket);
-	    server->ssocket = NULL;
-    }
+		sock_release(csocket);
+		server->ssocket = NULL;
+	}
 	set_fs(temp_fs);
 	if (smb_buffer) /* buffer usually freed in free_mid - need to free it on error or exit */
 		buf_release(smb_buffer);
+
+	down_write(&GlobalSMB_Sem);
 	if (list_empty(&server->pending_mid_q)) {
 		/* loop through server session structures attached to this and mark them dead */
 		list_for_each(tmp, &GlobalSMBSessionList) {
@@ -278,6 +280,7 @@
    time out and then free the tcp per server struct BB */
 
 	cFYI(1, ("\nAbout to exit from demultiplex thread\n"));
+	up_write(&GlobalSMB_Sem);
 	return 0;
 }
 
@@ -419,6 +422,7 @@
 
 	*psrvTcp = NULL;
 
+	down_read(&GlobalSMB_Sem);
 	list_for_each(tmp, &GlobalSMBSessionList) {
 		ses = list_entry(tmp, struct cifsSesInfo, cifsSessionList);
 		if (ses->server) {
@@ -429,12 +433,15 @@
 				/* BB check if reconnection needed */
 				if (strncmp
 				    (ses->userName, userName,
-				     MAX_USERNAME_SIZE) == 0)
+				     MAX_USERNAME_SIZE) == 0) {
+					up_read(&GlobalSMB_Sem);
 					return ses;	/* found exact match on both tcp and SMB sessions */
+				}
 			}
 		}
 		/* else tcp and smb sessions need reconnection */
 	}
+	up_read(&GlobalSMB_Sem);
 	return NULL;
 }
 
Index: linux-2.5.43/fs/cifs/misc.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.43/fs/cifs/misc.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 misc.c
--- linux-2.5.43/fs/cifs/misc.c	16 Oct 2002 03:46:04 -0000	1.1.1.1
+++ linux-2.5.43/fs/cifs/misc.c	16 Oct 2002 05:17:45 -0000
@@ -29,6 +29,7 @@
 extern kmem_cache_t *cifs_req_cachep;
 
 static DECLARE_MUTEX(GlobalMid_Sem);	/* also protects XID globals */
+static DECLARE_RWSEM(GlobalSMB_Sem);	/* protects SMB/TCP session lists */
 __u16 GlobalMid;		/* multiplex id - rotating counter */
 
 /* The xid serves as a useful identifier for each incoming vfs request, 
@@ -70,7 +71,9 @@
 	if (ret_buf) {
 		memset(ret_buf, 0, sizeof (struct cifsSesInfo));
 		atomic_inc(&sesInfoAllocCount);
+		down_write(&GlobalSMB_Sem);
 		list_add(&ret_buf->cifsSessionList, &GlobalSMBSessionList);
+		up_write(&GlobalSMB_Sem);
 		init_MUTEX(&ret_buf->sesSem);
 	}
 	return ret_buf;
@@ -105,9 +108,11 @@
 	if (ret_buf) {
 		memset(ret_buf, 0, sizeof (struct cifsTconInfo));
 		atomic_inc(&tconInfoAllocCount);
+		down_write(&GlobalSMB_Sem);
 		list_add(&ret_buf->cifsConnectionList,
 			 &GlobalTreeConnectionList);
-        INIT_LIST_HEAD(&ret_buf->openFileList);
+		up_write(&GlobalSMB_Sem);
+		INIT_LIST_HEAD(&ret_buf->openFileList);
 		init_MUTEX(&ret_buf->tconSem);
 	}
 	return ret_buf;

-- 
function.linuxpower.ca


