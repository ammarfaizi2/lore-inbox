Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267771AbTGONtK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 09:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267844AbTGONtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 09:49:09 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:35977 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S267771AbTGONsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 09:48:13 -0400
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] ipc kobject model against 2.6t1
From: <ffrederick@prov-liege.be>
Cc: <greg@kroah.com>
Date: Tue, 15 Jul 2003 16:30:23 CEST
Reply-To: <ffrederick@prov-liege.be>
X-Priority: 3 (Normal)
X-Originating-Ip: [10.10.0.30]
X-Mailer: NOCC v0.9.5
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <S267771AbTGONsN/20030715134813Z+258@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
        Here's a first workable ipc kobject patch against 2.6t1.
It stills have some internal problems like /shm works in /sysfs/shm but won't in /sysfs/ipc/shm ; but if someone could tell me if 
coding model is alright so I can port the stuff all over the place (msg...)

Regards,
Fabian

diff -Naur orig/ipc/shm.c edited/ipc/shm.c
--- orig/ipc/shm.c	2003-07-14 05:34:31.000000000 +0200
+++ edited/ipc/shm.c	2003-07-15 15:10:49.000000000 +0200
@@ -13,6 +13,7 @@
  * Shared /dev/zero support, Kanoj Sarcar <kanoj@sgi.com>
  * Move the mm functionality over to mm/shmem.c, Christoph Rohland <cr@sap.com>
  *
+ * sysfs support (c) 2003 Fabian Frédérick<ffrederick@users.sourceforge.net>
  */
 
 #include <linux/config.h>
@@ -27,7 +28,8 @@
 #include <linux/shmem_fs.h>
 #include <linux/security.h>
 #include <asm/uaccess.h>
-
+#include <linux/kobject.h>
+#include <linux/kobj_map.h>
 #include "util.h"
 
 #define shm_flags	shm_perm.mode
@@ -56,12 +58,70 @@
 
 static int shm_tot; /* total number of shared memory pages */
 
+/*
+ * sysfs exports
+ */
+
+#define SHM_ATTR(_ind, _name)\
+		shm_ids.entries[id].sysfs_attr[_ind].name=(char*)kmalloc(SYSFS_ATTR_MAX_LENGTH,GFP_KERNEL); \
+		sprintf(shm_ids.entries[id].sysfs_attr[_ind].name,__stringify(_name)); \
+		shm_ids.entries[id].sysfs_attr[_ind].mode=0644; \
+		sysfs_create_file(&shm_ids.entries[id].kobj, &shm_ids.entries[id].sysfs_attr[_ind]); 
+
+static ssize_t shm_attr_show(struct kobject *kobj, struct attribute *attr, char *buf){
+	unsigned long key=simple_strtoul(kobj->name,NULL,10);
+	unsigned int id=0;
+	int found=0;
+	struct shmid_kernel *shp;
+	for(id=0;id<=shm_ids.max_id&&!found;id++){
+		shp = shm_lock(id);
+		if (shp->shm_perm.key==key){
+			found=1;
+		}
+		shm_unlock(shp);
+	}
+	if(found){
+		id--;
+		shp = shm_lock(id);
+		if(!strcmp(attr->name,"Id"))
+			snprintf(buf, PAGE_SIZE, "%ld", shm_buildid(id,shp->shm_perm.seq));
+	 	  else if(!strcmp(attr->name, "Owner"))
+			     snprintf(buf, PAGE_SIZE, "___");
+			else if(!strcmp(attr->name,"Perms"))
+				snprintf(buf, PAGE_SIZE, "%d", shp->shm_flags);
+			  else if(!strcmp(attr->name,"Bytes"))	
+				 snprintf(buf, PAGE_SIZE, "%d", shp->shm_segsz);
+			    else if (!strcmp(attr->name, "NAttach"))
+				    snprintf(buf, PAGE_SIZE, "%d", is_file_hugepages(shp->shm_file) ? (file_count(shp->shm_file)-1):shp->shm_nattch);
+		shm_unlock(shp);
+		return strlen(buf);
+	}
+	return 0;
+}
+
+static ssize_t shm_attr_store(struct kobject *kobj, struct attribute *attr, char *buf){
+	return snprintf(buf, PAGE_SIZE, kobj->name);
+}
+
+static struct sysfs_ops shm_sysfs_ops ={
+	.show = shm_attr_show,
+	.store = shm_attr_store,
+};
+
+static struct kobj_type ktype_shm ={
+	.sysfs_ops = &shm_sysfs_ops,
+};
+
 void __init shm_init (void)
 {
 	ipc_init_ids(&shm_ids, 1);
 #ifdef CONFIG_PROC_FS
 	create_proc_read_entry("sysvipc/shm", 0, 0, sysvipc_shm_read_proc, NULL);
 #endif
+        strcpy(shm_ids.kobj.name, "shm");
+        //shm_ids.kobj.parent = &ipc_kobj;	
+	shm_ids.kobj.parent = NULL;
+        kobject_register(&shm_ids.kobj);
 }
 
 static inline int shm_checkid(struct shmid_kernel *s, int id)
@@ -78,11 +138,26 @@
 
 static inline int shm_addid(struct shmid_kernel *shp)
 {
-	return ipc_addid(&shm_ids, &shp->shm_perm, shm_ctlmni+1);
+	int id;
+	id=ipc_addid(&shm_ids, &shp->shm_perm, shm_ctlmni+1);
+	if(id!=-1){
+		sprintf(shm_ids.entries[id].kobj.name, "%ld", (long)(shm_ids.entries[id].p)->key);
+		shm_ids.entries[id].kobj.parent=&shm_ids.kobj;
+		shm_ids.entries[id].kobj.ktype=&ktype_shm;
+		kobject_register(&(shm_ids.entries[id].kobj));
+
+                /* Just setting attribute names */
+		SHM_ATTR(SYSFS_ATTR_KEY, Key);
+		SHM_ATTR(SYSFS_ATTR_ID, Id);
+		SHM_ATTR(SYSFS_ATTR_OWNER, Owner);
+		SHM_ATTR(SYSFS_ATTR_PERMS, Perms);
+		SHM_ATTR(SYSFS_ATTR_BYTES, Bytes);
+		SHM_ATTR(SYSFS_ATTR_NATTACH, Nattach);
+		SHM_ATTR(SYSFS_ATTR_STATUS, Status);
+	}
+	return id;
 }
 
-
-
 static inline void shm_inc (int id) {
 	struct shmid_kernel *shp;
 
@@ -234,6 +309,10 @@
 	return error;
 }
 
+/* Create a shared memory segment with given size and flags
+ * Returns negative result in case of failure
+ */
+
 asmlinkage long sys_shmget (key_t key, size_t size, int shmflg)
 {
 	struct shmid_kernel *shp;
@@ -266,7 +345,6 @@
 		shm_unlock(shp);
 	}
 	up(&shm_ids.sem);
-
 	return err;
 }
 
diff -Naur orig/ipc/util.c edited/ipc/util.c
--- orig/ipc/util.c	2003-07-14 05:33:12.000000000 +0200
+++ edited/ipc/util.c	2003-07-15 15:38:26.000000000 +0200
@@ -10,6 +10,8 @@
  *	      Manfred Spraul <manfreds@colorfullife.com>
  * Oct 2002 - One lock per IPC id. RCU ipc_free for lock-free grow_ary().
  *            Mingming Cao <cmm@us.ibm.com>
+ * Jul 2003 - Adding sysfs reporting.
+ *            Fabian Frederick <ffrederick@users.sourceforge.net>
  */
 
 #include <linux/config.h>
@@ -24,21 +26,27 @@
 #include <linux/security.h>
 #include <linux/rcupdate.h>
 #include <linux/workqueue.h>
-
+#include <linux/kobject.h>
+#include <linux/device.h>
 #if defined(CONFIG_SYSVIPC)
 
 #include "util.h"
 
+static struct kobject ipc_kobj; /* IPC sysfs mainpath */
+
 /**
- *	ipc_init	-	initialise IPC subsystem
+ *	ipc_init	-	initialize IPC subsystem
  *
  *	The various system5 IPC resources (semaphores, messages and shared
- *	memory are initialised
+ *	memory) are initialized
  */
- 
+
 void __init ipc_init (void)
 {
 	sem_init();
+	ipc_kobj.parent=ipc_kobj.dentry=ipc_kobj.ktype=ipc_kobj.kset=NULL;
+        strcpy(ipc_kobj.name, "ipc");
+        kobject_register(&ipc_kobj);
 	msg_init();
 	shm_init();
 	return;
@@ -238,6 +246,7 @@
 		ids->max_id = lid;
 	}
 	p->deleted = 1;
+	kobject_unregister(&(ids->entries[id].kobj));
 	return p;
 }
 
@@ -274,6 +283,7 @@
 		vfree(ptr);
 	else
 		kfree(ptr);
+
 }
 
 struct ipc_rcu_kmalloc
@@ -432,12 +442,12 @@
  * So far only shm_get_stat() calls ipc_get() via shm_get(), so ipc_get()
  * is called with shm_ids.sem locked.  Since grow_ary() is also called with
  * shm_ids.sem down(for Shared Memory), there is no need to add read 
- * barriers here to gurantee the writes in grow_ary() are seen in order 
+ * barriers here to guarantee the writes in grow_ary() are seen in order 
  * here (for Alpha).
  *
- * However ipc_get() itself does not necessary require ipc_ids.sem down. So
+ * However ipc_get() itself does not necessarily require ipc_ids.sem down. So
  * if in the future ipc_get() is used by other places without ipc_ids.sem
- * down, then ipc_get() needs read memery barriers as ipc_lock() does.
+ * down, then ipc_get() needs read memory barriers as ipc_lock() does.
  */
 struct kern_ipc_perm* ipc_get(struct ipc_ids* ids, int id)
 {
diff -Naur orig/ipc/util.h edited/ipc/util.h
--- orig/ipc/util.h	2003-07-14 05:34:42.000000000 +0200
+++ edited/ipc/util.h	2003-07-15 11:18:11.000000000 +0200
@@ -3,6 +3,8 @@
  * Copyright (C) 1999 Christoph Rohland
  *
  * ipc helper functions (c) 1999 Manfred Spraul <manfreds@colorfullife.com>
+ * 
+ * 07/2003 sysfs report by Fabian Frédérick <ffrederick@users.sourceforge.net>
  */
 #define USHRT_MAX 0xffff
 #define SEQ_MULTIPLIER	(IPCMNI)
@@ -19,9 +21,24 @@
 	unsigned short seq_max;
 	struct semaphore sem;	
 	struct ipc_id* entries;
+	struct kobject kobj; /* sysfs/ipc/shm {,sem,msg...} */
 };
 
+#define SYSFS_ATTR_KEY      0
+#define SYSFS_ATTR_ID 	    1
+#define SYSFS_ATTR_OWNER    2 
+#define SYSFS_ATTR_PERMS    3 
+#define SYSFS_ATTR_BYTES    4 
+#define SYSFS_ATTR_NSEMS    5 
+#define SYSFS_ATTR_NATTACH  6 
+#define SYSFS_ATTR_MESSAGES 7 
+#define SYSFS_ATTR_STATUS   8 
+
+#define SYSFS_ATTR_MAX_LENGTH 256 /* attribute entry size for sysfs report */
+
 struct ipc_id {
+	struct kobject kobj; /* sysfs/ipc/xxx/yyy */
+	struct attribute sysfs_attr[10];
 	struct kern_ipc_perm* p;
 };
 




___________________________________



