Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275200AbTHAG70 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 02:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275201AbTHAG70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 02:59:26 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:47959 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S275200AbTHAG7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 02:59:09 -0400
To: <greg@kroah.com>
Subject: [PATCH]shm to sysfs ready (?)
From: <ffrederick@prov-liege.be>
Cc: <linux-kernel@vger.kernel.org>
Date: Fri, 1 Aug 2003 09:25:30 CEST
Reply-To: <ffrederick@prov-liege.be>
X-Priority: 3 (Normal)
X-Originating-Ip: [10.10.0.30]
X-Mailer: NOCC v0.9.5
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <S275200AbTHAG7J/20030801065910Z+2647@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

          Here's a reworked version of shm to sysfs.

  Summary :

      -shm destruction moved to kobject release function
      -id seek was trivial.Attrshow rewritten.
      -Tested against recursive fgreps-kde-personal benchmark program
      -Patched might_sleep problem
      -Checking release code in front of all shm_destroy calls
      -No more MAJ charset for attributes
      -Adding EOL to attr values.
      -Working against 2.6.0.test2

      Is it ok for you ?

Thanks for your help,
Regards,
Fabian           

diff -Naur orig/ipc/shm.c edited/ipc/shm.c
--- orig/ipc/shm.c	2003-07-27 17:02:04.000000000 +0000
+++ edited/ipc/shm.c	2003-07-31 22:34:59.000000000 +0000
@@ -13,6 +13,7 @@
  * Shared /dev/zero support, Kanoj Sarcar <kanoj@sgi.com>
  * Move the mm functionality over to mm/shmem.c, Christoph Rohland <cr@sap.com>
  *
+ * sysfs support (c) 2003 Fabian Frederick <ffrederick@users.sourceforge.net>
  */
 
 #include <linux/config.h>
@@ -27,6 +28,8 @@
 #include <linux/shmem_fs.h>
 #include <linux/security.h>
 #include <asm/uaccess.h>
+#include <linux/kobject.h>
+#include <linux/kobj_map.h>
 
 #include "util.h"
 
@@ -62,6 +65,12 @@
 #ifdef CONFIG_PROC_FS
 	create_proc_read_entry("sysvipc/shm", 0, 0, sysvipc_shm_read_proc, NULL);
 #endif
+	strcpy(shm_ids.kobj.name, "shm");
+	shm_ids.kobj.parent = NULL;
+	shm_ids.kobj.kset = NULL;
+	shm_ids.kobj.ktype = NULL;
+	kobject_register(&shm_ids.kobj);
+
 }
 
 static inline int shm_checkid(struct shmid_kernel *s, int id)
@@ -81,8 +90,6 @@
 	return ipc_addid(&shm_ids, &shp->shm_perm, shm_ctlmni+1);
 }
 
-
-
 static inline void shm_inc (int id) {
 	struct shmid_kernel *shp;
 
@@ -94,6 +101,80 @@
 	shm_unlock(shp);
 }
 
+/*
+ * sysfs exports
+ */
+static ssize_t shm_attr_show(struct kobject *kobj, struct attribute *attr, char *buf)
+{
+	unsigned int id=simple_strtoul(kobj->name,NULL,10)%SEQ_MULTIPLIER;
+	struct shmid_kernel *shp;
+	down (&shm_ids.sem);
+	shp=shm_lock(id);
+	if(!strcmp(attr->name,"key"))
+		snprintf(buf, PAGE_SIZE,"%ld\n", (long)shp->shm_perm.key);
+	else if(!strcmp(attr->name, "owner"))
+		snprintf(buf, PAGE_SIZE, "%d\n", shp->shm_perm.uid);
+	else if(!strcmp(attr->name,"perms"))
+		snprintf(buf, PAGE_SIZE, "%4o\n", shp->shm_flags);
+	else if(!strcmp(attr->name,"bytes"))	
+		snprintf(buf, PAGE_SIZE, "%d\n", (int)shp->shm_segsz);
+	else if (!strcmp(attr->name, "nattach"))
+		snprintf(buf, PAGE_SIZE, "%ld\n", \
+		is_file_hugepages(shp->shm_file) ? \
+		(file_count(shp->shm_file)-1):shp->shm_nattch);
+	else if (!strcmp(attr->name,"cpid"))
+		snprintf(buf,PAGE_SIZE, "%d\n", shp->shm_cprid);
+	else if (!strcmp(attr->name,"lpid"))
+		snprintf(buf,PAGE_SIZE, "%d\n",shp->shm_lprid);
+	else if (!strcmp(attr->name,"gid"))
+		snprintf(buf,PAGE_SIZE, "%d\n", shp->shm_perm.gid);
+	else if (!strcmp(attr->name,"cuid"))
+		snprintf(buf,PAGE_SIZE, "%d\n", shp->shm_perm.cuid);
+	else if (!strcmp(attr->name,"cgid"))
+		snprintf(buf,PAGE_SIZE, "%d\n", shp->shm_perm.cgid);
+	else if (!strcmp(attr->name,"atime"))
+		snprintf(buf,PAGE_SIZE, "%ld\n", (long)shp->shm_atim);
+	else if (!strcmp(attr->name,"dtime"))
+		snprintf(buf,PAGE_SIZE, "%ld\n", (long)shp->shm_dtim);
+	else if (!strcmp(attr->name,"ctime"))
+		snprintf(buf,PAGE_SIZE, "%ld\n", (long) shp->shm_ctim);
+	shm_unlock(shp);
+	up (&shm_ids.sem);
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
+void shm_release (struct kobject *kobj)
+{	
+	struct shmid_kernel *shp;
+	int id;
+	id=(int)simple_strtoul(kobj->name, NULL, 10);
+	shp = shm_lock(id);
+	shm_tot -= (shp->shm_segsz + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	shm_rmid (id);
+	shm_unlock(shp);
+	if (!is_file_hugepages(shp->shm_file))
+		shmem_lock(shp->shm_file, 0);
+	fput (shp->shm_file);
+	security_shm_free(shp);
+	ipc_rcu_free(shp, sizeof(struct shmid_kernel));
+}
+
+static struct sysfs_ops shm_sysfs_ops ={
+	.show = shm_attr_show,
+};
+
+static struct kobj_type ktype_shm ={
+	.sysfs_ops = &shm_sysfs_ops,
+	.release = &shm_release,
+};
+
 /* This is called by fork, once for every shm attach. */
 static void shm_open (struct vm_area_struct *shmd)
 {
@@ -110,14 +191,8 @@
  */
 static void shm_destroy (struct shmid_kernel *shp)
 {
-	shm_tot -= (shp->shm_segsz + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	shm_rmid (shp->id);
 	shm_unlock(shp);
-	if (!is_file_hugepages(shp->shm_file))
-		shmem_lock(shp->shm_file, 0);
-	fput (shp->shm_file);
-	security_shm_free(shp);
-	ipc_rcu_free(shp, sizeof(struct shmid_kernel));
+	kobject_unregister(&shm_ids.entries[shp->id%SEQ_MULTIPLIER].kobj);
 }
 
 /*
@@ -165,6 +240,8 @@
 	.nopage	= shmem_nopage,
 };
 
+ /* Call with shm_ids.sem locked
+  */
 static int newseg (key_t key, int shmflg, size_t size)
 {
 	int error;
@@ -223,7 +300,29 @@
 	else
 		file->f_op = &shm_file_operations;
 	shm_tot += numpages;
+	sprintf(shm_ids.entries[id].kobj.name, "%ld", \
+	       (long)shm_buildid(id,shp->shm_perm.seq));
+	shm_ids.entries[id].kobj.parent=kobject_get(&shm_ids.kobj);
+	shm_ids.entries[id].kobj.kset=NULL;
+	shm_ids.entries[id].kobj.ktype=&ktype_shm;
 	shm_unlock(shp);
+	if(!kobject_register(&(shm_ids.entries[id].kobj))){
+		SHM_ATTR(key);
+		SHM_ATTR(owner);
+		SHM_ATTR(bytes);
+		SHM_ATTR(perms);
+		SHM_ATTR(nattach);
+		SHM_ATTR(cpid);
+		SHM_ATTR(lpid);
+		SHM_ATTR(gid);
+		SHM_ATTR(cuid);
+		SHM_ATTR(cgid);
+		SHM_ATTR(atime);
+		SHM_ATTR(dtime);
+		SHM_ATTR(ctime);
+	}else{
+		return -EINVAL;
+	}
 	return shp->id;
 
 no_id:
diff -Naur orig/ipc/util.h edited/ipc/util.h
--- orig/ipc/util.h	2003-07-27 17:03:11.000000000 +0000
+++ edited/ipc/util.h	2003-07-29 06:51:51.000000000 +0000
@@ -19,9 +19,11 @@
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



