Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272338AbTHNNDy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 09:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272339AbTHNNDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 09:03:54 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:45675 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S272338AbTHNNDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 09:03:46 -0400
Message-ID: <D9B4591FDBACD411B01E00508BB33C1B014053B7@mesadm.epl.prov-liege.be>
From: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
To: "'Patrick Mochel'" <mochel@osdl.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] shm to sysfs rebuild.
Date: Thu, 14 Aug 2003 15:03:43 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C36264.7D532B00"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C36264.7D532B00
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Patrick,

	Here's the patch attached (patches are troublesome when inlined from
here).
btw all your advices were applied.

Regards,
Fabian

-----Message d'origine-----
De : Patrick Mochel [mailto:mochel@osdl.org]
Envoy=E9 : dimanche 10 ao=FBt 2003 19:24
=C0 : Frederick, Fabian
Cc : 'linux-kernel@vger.kernel.org'
Objet : Re: [PATCH] shm to sysfs rebuild.



> Patch: http://fabian.unixtech.be/kernel/shmkobject090803.diff
>=20
> 	It's against 2.6.0test2.If it's ok to you, could you apply ?

Could you please always inline your patches in your email? They stand a =

much better chance of getting applied that way.

Thanks,


	-pat


------_=_NextPart_000_01C36264.7D532B00
Content-Type: application/octet-stream;
	name="shmkobject090803.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="shmkobject090803.diff"

diff -Naur orig/ipc/shm.c edited/ipc/shm.c=0A=
--- orig/ipc/shm.c	2003-07-27 17:02:04.000000000 +0000=0A=
+++ edited/ipc/shm.c	2003-08-09 22:40:59.000000000 +0000=0A=
@@ -13,6 +13,7 @@=0A=
  * Shared /dev/zero support, Kanoj Sarcar <kanoj@sgi.com>=0A=
  * Move the mm functionality over to mm/shmem.c, Christoph Rohland =
<cr@sap.com>=0A=
  *=0A=
+ * sysfs support (c) 2003 Fabian Frederick =
<ffrederick@users.sourceforge.net>=0A=
  */=0A=
 =0A=
 #include <linux/config.h>=0A=
@@ -27,6 +28,7 @@=0A=
 #include <linux/shmem_fs.h>=0A=
 #include <linux/security.h>=0A=
 #include <asm/uaccess.h>=0A=
+#include <linux/kobject.h>=0A=
 =0A=
 #include "util.h"=0A=
 =0A=
@@ -56,14 +58,6 @@=0A=
 =0A=
 static int shm_tot; /* total number of shared memory pages */=0A=
 =0A=
-void __init shm_init (void)=0A=
-{=0A=
-	ipc_init_ids(&shm_ids, 1);=0A=
-#ifdef CONFIG_PROC_FS=0A=
-	create_proc_read_entry("sysvipc/shm", 0, 0, sysvipc_shm_read_proc, =
NULL);=0A=
-#endif=0A=
-}=0A=
-=0A=
 static inline int shm_checkid(struct shmid_kernel *s, int id)=0A=
 {=0A=
 	if (ipc_checkid(&shm_ids,&s->shm_perm,id))=0A=
@@ -81,8 +75,6 @@=0A=
 	return ipc_addid(&shm_ids, &shp->shm_perm, shm_ctlmni+1);=0A=
 }=0A=
 =0A=
-=0A=
-=0A=
 static inline void shm_inc (int id) {=0A=
 	struct shmid_kernel *shp;=0A=
 =0A=
@@ -93,6 +85,115 @@=0A=
 	shp->shm_nattch++;=0A=
 	shm_unlock(shp);=0A=
 }=0A=
+/* sysfs exports*/=0A=
+=0A=
+#define SHM_ATTR(_name) \=0A=
+static struct attribute shm_attr_##_name=3D{ \=0A=
+	.name=3D__stringify(_name), \=0A=
+	.mode=3D0444, \=0A=
+}; \=0A=
+=0A=
+#define ATTR_TYPE(_name) \=0A=
+&shm_attr_##_name =3D=3D attr =0A=
+=0A=
+SHM_ATTR(key);=0A=
+SHM_ATTR(owner);=0A=
+SHM_ATTR(bytes);=0A=
+SHM_ATTR(perms);=0A=
+SHM_ATTR(nattach);=0A=
+SHM_ATTR(cpid);=0A=
+SHM_ATTR(lpid);=0A=
+SHM_ATTR(gid);=0A=
+SHM_ATTR(cuid);=0A=
+SHM_ATTR(cgid);=0A=
+SHM_ATTR(atime);=0A=
+SHM_ATTR(dtime);=0A=
+SHM_ATTR(ctime);=0A=
+=0A=
+static struct attribute *shm_default_attrs[] =3D {=0A=
+	&shm_attr_key,=0A=
+	&shm_attr_owner,=0A=
+	&shm_attr_bytes,=0A=
+	&shm_attr_perms,=0A=
+	&shm_attr_nattach,=0A=
+	&shm_attr_cpid,=0A=
+	&shm_attr_lpid,=0A=
+	&shm_attr_gid,=0A=
+	&shm_attr_cuid,=0A=
+	&shm_attr_cgid,=0A=
+	&shm_attr_atime,=0A=
+	&shm_attr_dtime,=0A=
+	&shm_attr_ctime,=0A=
+	NULL,=0A=
+};=0A=
+=0A=
+static ssize_t shm_attr_show(struct kobject *kobj, struct attribute =
*attr, char *buf)=0A=
+{=0A=
+	unsigned int =
id=3Dsimple_strtoul(kobj->name,NULL,10)%SEQ_MULTIPLIER;=0A=
+	long value;=0A=
+	struct shmid_kernel *shp;=0A=
+	down (&shm_ids.sem);=0A=
+	shp=3Dshm_lock(id);=0A=
+	if(ATTR_TYPE(key))=0A=
+		value=3Dshp->shm_perm.key;=0A=
+	  else if(ATTR_TYPE(owner))=0A=
+			value=3D-1;=0A=
+	  else if(ATTR_TYPE(bytes))=0A=
+			value=3D(int)shp->shm_segsz;=0A=
+	  else if(ATTR_TYPE(perms))=0A=
+			value=3Dshp->shm_perm.uid;=0A=
+	  else if(ATTR_TYPE(nattach))=0A=
+			value=3Dis_file_hugepages \=0A=
+			(shp->shm_file) ? (file_count(shp->shm_file)-1):\=0A=
+			shp->shm_nattch;=0A=
+	  else if(ATTR_TYPE(cpid))=0A=
+			value=3Dshp->shm_cprid; =0A=
+	  else if(ATTR_TYPE(lpid))=0A=
+			value=3Dshp->shm_lprid;=0A=
+	  else if(ATTR_TYPE(gid))=0A=
+			value=3Dshp->shm_perm.gid;=0A=
+	  else if(ATTR_TYPE(cuid))=0A=
+			value=3Dshp->shm_perm.cuid;=0A=
+	  else if(ATTR_TYPE(cgid))=0A=
+			value=3Dshp->shm_perm.cgid;	=0A=
+	  else if(ATTR_TYPE(atime))=0A=
+			value=3D(long)shp->shm_atim;=0A=
+	  else if(ATTR_TYPE(dtime))=0A=
+			value=3D(long)shp->shm_dtim;=0A=
+	  else if(ATTR_TYPE(ctime))=0A=
+			value=3D(long) shp->shm_ctim;=0A=
+	  else  value=3D-1;=0A=
+	snprintf(buf, PAGE_SIZE, "%ld\n", value);=0A=
+	shm_unlock(shp);=0A=
+	up (&shm_ids.sem);=0A=
+	return strlen(buf);=0A=
+}=0A=
+=0A=
+void shm_release (struct kobject *kobj)=0A=
+{	=0A=
+	struct shmid_kernel *shp;=0A=
+	int id;=0A=
+	id=3D(int)simple_strtoul(kobj->name, NULL, 10);=0A=
+	shp =3D shm_lock(id);=0A=
+	shm_tot -=3D (shp->shm_segsz + PAGE_SIZE - 1) >> PAGE_SHIFT;=0A=
+	shm_rmid (id);=0A=
+	shm_unlock(shp);=0A=
+	if (!is_file_hugepages(shp->shm_file))=0A=
+		shmem_lock(shp->shm_file, 0);=0A=
+	fput (shp->shm_file);=0A=
+	security_shm_free(shp);=0A=
+	ipc_rcu_free(shp, sizeof(struct shmid_kernel));=0A=
+}=0A=
+=0A=
+static struct sysfs_ops shm_sysfs_ops =3D{=0A=
+	.show =3D shm_attr_show,=0A=
+};=0A=
+=0A=
+static struct kobj_type shm_ktype =3D{=0A=
+	.sysfs_ops =3D &shm_sysfs_ops,=0A=
+	.release =3D &shm_release,=0A=
+	.default_attrs =3D shm_default_attrs,=0A=
+};=0A=
 =0A=
 /* This is called by fork, once for every shm attach. */=0A=
 static void shm_open (struct vm_area_struct *shmd)=0A=
@@ -110,14 +211,8 @@=0A=
  */=0A=
 static void shm_destroy (struct shmid_kernel *shp)=0A=
 {=0A=
-	shm_tot -=3D (shp->shm_segsz + PAGE_SIZE - 1) >> PAGE_SHIFT;=0A=
-	shm_rmid (shp->id);=0A=
 	shm_unlock(shp);=0A=
-	if (!is_file_hugepages(shp->shm_file))=0A=
-		shmem_lock(shp->shm_file, 0);=0A=
-	fput (shp->shm_file);=0A=
-	security_shm_free(shp);=0A=
-	ipc_rcu_free(shp, sizeof(struct shmid_kernel));=0A=
+	kobject_unregister(&shm_ids.entries[shp->id%SEQ_MULTIPLIER].kobj);=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -165,6 +260,21 @@=0A=
 	.nopage	=3D shmem_nopage,=0A=
 };=0A=
 =0A=
+void __init shm_init (void)=0A=
+{=0A=
+	ipc_init_ids(&shm_ids, 1);=0A=
+#ifdef CONFIG_PROC_FS=0A=
+	create_proc_read_entry("sysvipc/shm", 0, 0, sysvipc_shm_read_proc, =
NULL);=0A=
+#endif=0A=
+	memset(&shm_ids.kobj, 0, sizeof(struct kobject));=0A=
+	strcpy(shm_ids.kobj.name, "shm");=0A=
+	kobject_register(&shm_ids.kobj);=0A=
+=0A=
+}=0A=
+=0A=
+=0A=
+ /* Call with shm_ids.sem locked=0A=
+  */=0A=
 static int newseg (key_t key, int shmflg, size_t size)=0A=
 {=0A=
 	int error;=0A=
@@ -223,7 +333,14 @@=0A=
 	else=0A=
 		file->f_op =3D &shm_file_operations;=0A=
 	shm_tot +=3D numpages;=0A=
+	sprintf(shm_ids.entries[id].kobj.name, "%ld", \=0A=
+	       (long)shm_buildid(id,shp->shm_perm.seq));=0A=
+	shm_ids.entries[id].kobj.parent=3Dkobject_get(&shm_ids.kobj);=0A=
+	shm_ids.entries[id].kobj.kset=3DNULL;=0A=
+	shm_ids.entries[id].kobj.ktype=3D&shm_ktype;=0A=
 	shm_unlock(shp);=0A=
+	if(kobject_register(&(shm_ids.entries[id].kobj)))=0A=
+		return -EINVAL;=0A=
 	return shp->id;=0A=
 =0A=
 no_id:=0A=
diff -Naur orig/ipc/util.h edited/ipc/util.h=0A=
--- orig/ipc/util.h	2003-07-27 17:03:11.000000000 +0000=0A=
+++ edited/ipc/util.h	2003-07-29 06:51:51.000000000 +0000=0A=
@@ -19,9 +19,11 @@=0A=
 	unsigned short seq_max;=0A=
 	struct semaphore sem;	=0A=
 	struct ipc_id* entries;=0A=
+	struct kobject kobj; /* sysfs/ipc/shm {,sem,msg...} */=0A=
 };=0A=
 =0A=
 struct ipc_id {=0A=
+	struct kobject kobj; /* sysfs/ipc/xxx/yyy */=0A=
 	struct kern_ipc_perm* p;=0A=
 };=0A=
 =0A=

------_=_NextPart_000_01C36264.7D532B00--
