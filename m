Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265901AbTGIJsN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 05:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265902AbTGIJsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 05:48:13 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:31852 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S265901AbTGIJsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 05:48:04 -0400
Message-ID: <D9B4591FDBACD411B01E00508BB33C1B01AF03D2@mesadm.epl.prov-liege.be>
From: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
To: linux-kernel@vger.kernel.org
Subject: IPC subsystem
Date: Wed, 9 Jul 2003 12:06:14 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C34601.BB2E2120"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C34601.BB2E2120
Content-Type: text/plain;
	charset="iso-8859-1"

Hi,
	I'm trying to port the ipc stuff to work as a subsystem in order to
have sysfs outputs (/sysfs/ipc/sem {,shm,msg} ) .
	Output I have is an early oops (which is not reported in /var/log
...)

	It seems the ipc stuff init begins before kobject stuff or something
?

"EIP is at sysfs_create_dir

<0>kernel panic : attempted to kill the idle task!
"

Here is my patch attached + complete files

Someone could help ?

Regards,
Fabian




------_=_NextPart_000_01C34601.BB2E2120
Content-Type: application/octet-stream;
	name="ipc2.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ipc2.diff"

diff -Naur ipc/shm.c ./../linux-2.5.74ff1/ipc/shm.c=0A=
--- ipc/shm.c	2003-07-02 22:48:07.000000000 +0200=0A=
+++ ./../linux-2.5.74ff1/ipc/shm.c	2003-07-07 22:32:45.000000000 =
+0200=0A=
@@ -13,6 +13,7 @@=0A=
  * Shared /dev/zero support, Kanoj Sarcar <kanoj@sgi.com>=0A=
  * Move the mm functionality over to mm/shmem.c, Christoph Rohland =
<cr@sap.com>=0A=
  *=0A=
+ * /sys/ipc support (c) 2003 Fabian =
Fr=E9d=E9rick<ffrederick@users.sourceforge.net>=0A=
  */=0A=
 =0A=
 #include <linux/config.h>=0A=
@@ -27,7 +28,8 @@=0A=
 #include <linux/shmem_fs.h>=0A=
 #include <linux/security.h>=0A=
 #include <asm/uaccess.h>=0A=
-=0A=
+#include <linux/kobject.h>=0A=
+#include <linux/kobj_map.h>=0A=
 #include "util.h"=0A=
 =0A=
 #define shm_flags	shm_perm.mode=0A=
@@ -62,6 +64,9 @@=0A=
 #ifdef CONFIG_PROC_FS=0A=
 	create_proc_read_entry("sysvipc/shm", 0, 0, sysvipc_shm_read_proc, =
NULL);=0A=
 #endif=0A=
+	shm_ids.kobj.parent =3D &ipc_subsys.kset.kobj;	=0A=
+	sprintf(shm_ids.kobj.name, "%s", "shm");=0A=
+	kobject_register(&shm_ids.kobj);=0A=
 }=0A=
 =0A=
 static inline int shm_checkid(struct shmid_kernel *s, int id)=0A=
@@ -234,6 +239,10 @@=0A=
 	return error;=0A=
 }=0A=
 =0A=
+/* Create a shared memory segment with given size and flags=0A=
+ * Returns negative result in case of failure=0A=
+ */=0A=
+=0A=
 asmlinkage long sys_shmget (key_t key, size_t size, int shmflg)=0A=
 {=0A=
 	struct shmid_kernel *shp;=0A=
diff -Naur ipc/util.c ./../linux-2.5.74ff1/ipc/util.c=0A=
--- ipc/util.c	2003-07-02 22:46:12.000000000 +0200=0A=
+++ ./../linux-2.5.74ff1/ipc/util.c	2003-07-07 22:32:10.000000000 =
+0200=0A=
@@ -24,6 +24,7 @@=0A=
 #include <linux/security.h>=0A=
 #include <linux/rcupdate.h>=0A=
 #include <linux/workqueue.h>=0A=
+#include <linux/kobject.h>=0A=
 =0A=
 #if defined(CONFIG_SYSVIPC)=0A=
 =0A=
@@ -35,9 +36,10 @@=0A=
  *	The various system5 IPC resources (semaphores, messages and =
shared=0A=
  *	memory are initialised=0A=
  */=0A=
- =0A=
 void __init ipc_init (void)=0A=
 {=0A=
+	sprintf(ipc_subsys.kset.kobj.name, "%s", "ipc");=0A=
+	subsystem_register(&ipc_subsys);=0A=
 	sem_init();=0A=
 	msg_init();=0A=
 	shm_init();=0A=
@@ -196,6 +198,8 @@=0A=
 	rcu_read_lock();=0A=
 	spin_lock(&new->lock);=0A=
 	ids->entries[id].p =3D new;=0A=
+	kobject_register(&ids->entries[id].kobj);=0A=
+	=0A=
 	return id;=0A=
 }=0A=
 =0A=
@@ -432,12 +436,12 @@=0A=
  * So far only shm_get_stat() calls ipc_get() via shm_get(), so =
ipc_get()=0A=
  * is called with shm_ids.sem locked.  Since grow_ary() is also called =
with=0A=
  * shm_ids.sem down(for Shared Memory), there is no need to add read =
=0A=
- * barriers here to gurantee the writes in grow_ary() are seen in =
order =0A=
+ * barriers here to guarantee the writes in grow_ary() are seen in =
order =0A=
  * here (for Alpha).=0A=
  *=0A=
- * However ipc_get() itself does not necessary require ipc_ids.sem =
down. So=0A=
+ * However ipc_get() itself does not necessarily require ipc_ids.sem =
down. So=0A=
  * if in the future ipc_get() is used by other places without =
ipc_ids.sem=0A=
- * down, then ipc_get() needs read memery barriers as ipc_lock() =
does.=0A=
+ * down, then ipc_get() needs read memory barriers as ipc_lock() =
does.=0A=
  */=0A=
 struct kern_ipc_perm* ipc_get(struct ipc_ids* ids, int id)=0A=
 {=0A=
diff -Naur ipc/util.h ./../linux-2.5.74ff1/ipc/util.h=0A=
--- ipc/util.h	2003-07-02 22:49:13.000000000 +0200=0A=
+++ ./../linux-2.5.74ff1/ipc/util.h	2003-07-07 22:32:11.000000000 =
+0200=0A=
@@ -7,6 +7,7 @@=0A=
 #define USHRT_MAX 0xffff=0A=
 #define SEQ_MULTIPLIER	(IPCMNI)=0A=
 =0A=
+static struct subsystem ipc_subsys;=0A=
 void sem_init (void);=0A=
 void msg_init (void);=0A=
 void shm_init (void);=0A=
@@ -19,9 +20,11 @@=0A=
 	unsigned short seq_max;=0A=
 	struct semaphore sem;	=0A=
 	struct ipc_id* entries;=0A=
+	struct kobject kobj;=0A=
 };=0A=
 =0A=
 struct ipc_id {=0A=
+	struct kobject kobj;=0A=
 	struct kern_ipc_perm* p;=0A=
 };=0A=
 =0A=

------_=_NextPart_000_01C34601.BB2E2120--
