Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271968AbTGYIxQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 04:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271970AbTGYIxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 04:53:16 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:9841 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S271968AbTGYIxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 04:53:10 -0400
To: <greg@kroah.com>
Subject: [PATCH] shm kobject model against 2.6t1
From: <ffrederick@prov-liege.be>
Cc: <linux-kernel@vger.kernel.org>
Date: Fri, 25 Jul 2003 11:35:05 CEST
Reply-To: <ffrederick@prov-liege.be>
X-Priority: 3 (Normal)
X-Originating-Ip: [10.10.0.30]
X-Mailer: NOCC v0.9.5
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <S271968AbTGYIxK/20030725085310Z+8146@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

      Many thanks for your advices !!! shm kobject model rocks now :)
Here's the full patch if someone wants to apply (Alan ?) It's against 2.6.0.test1

Summary :

           -export shm to sysfs using kobject model
	   -unregistering (Greg)
	   -adding all keys available in shm_perm
	   -removing unused 'store' in ops. 
           -some typo fixes
	   -shm_attr macro

Regards,
Fabian

diff -Naur orig/ipc/shm.c edited/ipc/shm.c
--- orig/ipc/shm.c	2003-07-14 05:34:31.000000000 +0200
+++ edited/ipc/shm.c	2003-07-25 10:42:06.000000000 +0200
@@ -13,6 +13,7 @@
  * Shared /dev/zero support, Kanoj Sarcar <kanoj@sgi.com>
  * Move the mm functionality over to mm/shmem.c, Christoph Rohland <cr@sap.com>
  *
+ * sysfs support (c) 2003 Fabian Frederick <ffrederick@users.sourceforge.net>
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
@@ -56,12 +58,84 @@
 
 static int shm_tot; /* total number of shared memory pages */
 
+/*
+ * sysfs exports
+ */
+static ssize_t shm_attr_show(struct kobject *kobj, struct attribute *attr, char *buf)
+{
+	unsigned int id;
+	unsigned int kobj_id=simple_strtoul(kobj->name,NULL,10);
+	int found=0;
+	struct shmid_kernel *shp;
+
+	for(id=0; id<=shm_ids.max_id&&!found; id++){
+		shp = shm_lock(id);
+		if(shm_buildid(id,shp->shm_perm.seq)==kobj_id)
+			found=1;
+		shm_unlock(shp);
+	}
+	if(found){
+		id--;
+		shp = shm_lock(id);
+		if(!strcmp(attr->name,"Key"))
+			snprintf(buf, PAGE_SIZE,"%ld", (long)shp->shm_perm.key);
+		else if(!strcmp(attr->name, "Owner"))
+			snprintf(buf, PAGE_SIZE, "%d", shp->shm_perm.uid);
+		else if(!strcmp(attr->name,"Perms"))
+			snprintf(buf, PAGE_SIZE, "%4o", shp->shm_flags);
+		else if(!strcmp(attr->name,"Bytes"))	
+			snprintf(buf, PAGE_SIZE, "%d", (int)shp->shm_segsz);
+		else if (!strcmp(attr->name, "NAttach"))
+			snprintf(buf, PAGE_SIZE, "%ld", \
+			is_file_hugepages(shp->shm_file) ? \
+			(file_count(shp->shm_file)-1):shp->shm_nattch);
+		else if (!strcmp(attr->name,"Cpid"))
+			snprintf(buf,PAGE_SIZE, "%d", shp->shm_cprid);
+		else if (!strcmp(attr->name,"Lpid"))
+			snprintf(buf,PAGE_SIZE, "%d",shp->shm_lprid);
+		else if (!strcmp(attr->name,"Gid"))
+			snprintf(buf,PAGE_SIZE, "%d", shp->shm_perm.gid);
+		else if (!strcmp(attr->name,"Cuid"))
+			snprintf(buf,PAGE_SIZE, "%d", shp->shm_perm.cuid);
+		else if (!strcmp(attr->name,"Cgid"))
+			snprintf(buf,PAGE_SIZE, "%d", shp->shm_perm.cgid);
+		else if (!strcmp(attr->name,"Atime"))
+			snprintf(buf,PAGE_SIZE, "%ld", (long)shp->shm_atim);
+		else if (!strcmp(attr->name,"Dtime"))
+			snprintf(buf,PAGE_SIZE, "%ld", (long)shp->shm_dtim);
+		else if (!strcmp(attr->name,"Ctime"))
+			snprintf(buf,PAGE_SIZE, "%ld", (long) shp->shm_ctim);
+		shm_unlock(shp);
+	}else snprintf(buf, PAGE_SIZE, "Not found");
+	return strlen(buf);
+}
+
+#define SHM_ATTR(_name) \
+static struct attribute shm_attr_##_name={ \
+	.name=__stringify(_name), \
+	.mode=0444, \
+}; \
+sysfs_create_file(&shm_ids.entries[id].kobj, &shm_attr_##_name );
+
+static struct sysfs_ops shm_sysfs_ops ={
+	.show = shm_attr_show,
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
+	strcpy(shm_ids.kobj.name, "shm");
+	shm_ids.kobj.parent = NULL;
+	shm_ids.kobj.kset = NULL;
+	shm_ids.kobj.ktype = NULL;
+	kobject_register(&shm_ids.kobj);
 }
 
 static inline int shm_checkid(struct shmid_kernel *s, int id)
@@ -81,8 +155,6 @@
 	return ipc_addid(&shm_ids, &shp->shm_perm, shm_ctlmni+1);
 }
 
-
-
 static inline void shm_inc (int id) {
 	struct shmid_kernel *shp;
 
@@ -136,6 +208,8 @@
 	/* remove from the list of attaches of the shm segment */
 	if(!(shp = shm_lock(id)))
 		BUG();
+	kobject_cleanup(&shm_ids.entries[id%SEQ_MULTIPLIER].kobj);
+	kobject_unregister(&shm_ids.entries[id%SEQ_MULTIPLIER].kobj);
 	shp->shm_lprid = current->pid;
 	shp->shm_dtim = get_seconds();
 	shp->shm_nattch--;
@@ -223,6 +297,30 @@
 	else
 		file->f_op = &shm_file_operations;
 	shm_tot += numpages;
+
+	sprintf(shm_ids.entries[id].kobj.name, "%ld", \
+	       (long)shm_buildid(id,shp->shm_perm.seq));
+	shm_ids.entries[id].kobj.parent=kobject_get(&shm_ids.kobj);
+	shm_ids.entries[id].kobj.kset=NULL;
+	shm_ids.entries[id].kobj.ktype=&ktype_shm;
+	if(!kobject_register(&(shm_ids.entries[id].kobj))){
+		SHM_ATTR(Key);
+		SHM_ATTR(Owner);
+		SHM_ATTR(Bytes);
+		SHM_ATTR(Perms);
+		SHM_ATTR(NAttach);
+		SHM_ATTR(Cpid);
+		SHM_ATTR(Lpid);
+		SHM_ATTR(Gid);
+		SHM_ATTR(Cuid);
+		SHM_ATTR(Cgid);
+		SHM_ATTR(Atime);
+		SHM_ATTR(Dtime);
+		SHM_ATTR(Ctime);
+	}else{
+		shm_unlock(shp);
+		return -EINVAL;
+	}
 	shm_unlock(shp);
 	return shp->id;
 
@@ -234,6 +332,10 @@
 	return error;
 }
 
+/* Create a shared memory segment with given size and flags
+ * Returns negative result in case of failure
+ */
+
 asmlinkage long sys_shmget (key_t key, size_t size, int shmflg)
 {
 	struct shmid_kernel *shp;
@@ -266,7 +368,6 @@
 		shm_unlock(shp);
 	}
 	up(&shm_ids.sem);
-
 	return err;
 }
 
diff -Naur orig/ipc/util.c edited/ipc/util.c
--- orig/ipc/util.c	2003-07-14 05:33:12.000000000 +0200
+++ edited/ipc/util.c	2003-07-25 10:42:17.000000000 +0200
@@ -10,6 +10,8 @@
  *	      Manfred Spraul <manfreds@colorfullife.com>
  * Oct 2002 - One lock per IPC id. RCU ipc_free for lock-free grow_ary().
  *            Mingming Cao <cmm@us.ibm.com>
+ * Jul 2003 - Adding sysfs reporting.
+ *            Fabian Frederick <ffrederick@users.sourceforge.net>
  */
 
 #include <linux/config.h>
@@ -24,18 +26,19 @@
 #include <linux/security.h>
 #include <linux/rcupdate.h>
 #include <linux/workqueue.h>
-
+#include <linux/kobject.h>
+#include <linux/device.h>
 #if defined(CONFIG_SYSVIPC)
 
 #include "util.h"
 
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
@@ -432,12 +435,12 @@
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
+++ edited/ipc/util.h	2003-07-25 10:42:42.000000000 +0200
@@ -3,6 +3,7 @@
  * Copyright (C) 1999 Christoph Rohland
  *
  * ipc helper functions (c) 1999 Manfred Spraul <manfreds@colorfullife.com>
+ * 
  */
 #define USHRT_MAX 0xffff
 #define SEQ_MULTIPLIER	(IPCMNI)
@@ -19,9 +20,11 @@
 	unsigned short seq_max;
 	struct semaphore sem;	
 	struct ipc_id* entries;
+	struct kobject kobj; /* sysfs/ipc/shm {,sem,msg...} */
 };
 
 struct ipc_id {
+	struct kobject kobj; /* sysfs/ipc/xxx/yyy */
 	struct kern_ipc_perm* p;
 };
 

           


___________________________________



