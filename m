Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266650AbSKZTgi>; Tue, 26 Nov 2002 14:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266678AbSKZTgi>; Tue, 26 Nov 2002 14:36:38 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:51934 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266650AbSKZTfr>;
	Tue, 26 Nov 2002 14:35:47 -0500
Subject: [PATCH] Memory barriers in IPC RCU
From: Mingming Cao <cmm@us.ibm.com>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, paul.mckenny@us.ibm.com, dipankar@in.ibm.com,
       rusty@rustcorp.com.au
Content-Type: multipart/mixed; boundary="=-qkoZRO+ZjaHxQrHz62Uq"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Nov 2002 11:42:46 -0800
Message-Id: <1038339769.1026.79.camel@w-ming.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qkoZRO+ZjaHxQrHz62Uq
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

Attached patch includes the following changes:

- ipc_lock() need a read_barrier_depends() to prevent indexing
uninitialized new array on the read side. This is corresponding to the
write memory barrier added in grow_ary() from Dipankar's patch to
prevent indexing uninitialized array.

-   Replaced "wmb()" in IPC code with "smp_wmb()"."wmb()" produces a
full write memory barrier in both UP and SMP kernels, while "smp_wmb()"
provides a full write memory barrier in an SMP kernel, but only a
compiler directive in a UP kernel. The same change are made for "rmb()".

- Removed rmb() in ipc_get(). We do not need a read memory barrier there
since ipc_get() is protected by ipc_ids.sem semaphore.

- Added more comments about why write barriers and read barriers are
needed (or not needed) here or there.

Patch against 2.5.49 kernel. 


Thanks,
Mingming

--=-qkoZRO+ZjaHxQrHz62Uq
Content-Disposition: attachment; filename=ipc_barriers.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=ipc_barriers.patch; charset=UTF-8

diff -urN /home/ming/views/base/linux-2.5.49/ipc/util.c 2549-ipc/ipc/util.c
--- /home/ming/views/base/linux-2.5.49/ipc/util.c	2002-11-22 13:40:39.00000=
0000 -0800
+++ 2549-ipc/ipc/util.c	2002-11-26 10:37:35.000000000 -0800
@@ -98,6 +98,10 @@
 	struct kern_ipc_perm* p;
 	int max_id =3D ids->max_id;
=20
+	/*
+	 * read_barrier_depends is not needed here
+	 * since ipc_ids.sem is held
+	 */
 	for (id =3D 0; id <=3D max_id; id++) {
 		p =3D ids->entries[id].p;
 		if(p=3D=3DNULL)
@@ -134,12 +138,12 @@
=20
 	/*
 	 * before setting the ids->entries to the new array, there must be a
-	 * wmb() to make sure that the memcpyed contents of the new array are
+	 * smp_wmb() to make sure the memcpyed contents of the new array are
 	 * visible before the new array becomes visible.
 	 */
-	wmb();
+	smp_wmb();	/* prevent seeing new array uninitialized. */
 	ids->entries =3D new;
-	wmb();
+	smp_wmb();	/* prevent indexing into old array based on new size. */
 	ids->size =3D newsize;
=20
 	ipc_rcu_free(old, sizeof(struct ipc_id)*i);
@@ -156,6 +160,8 @@
  *	initialised and the first free entry is set up and the id assigned
  *	is returned. The list is returned in a locked state on success.
  *	On failure the list is not locked and -1 is returned.
+ *
+ *	Called with ipc_ids.sem held.
  */
 =20
 int ipc_addid(struct ipc_ids* ids, struct kern_ipc_perm* new, int size)
@@ -163,6 +169,11 @@
 	int id;
=20
 	size =3D grow_ary(ids,size);
+
+	/*
+	 * read_barrier_depends() is not needed here since
+	 * ipc_ids.sem is held
+	 */
 	for (id =3D 0; id < size; id++) {
 		if(ids->entries[id].p =3D=3D NULL)
 			goto found;
@@ -207,7 +218,11 @@
 	int lid =3D id % SEQ_MULTIPLIER;
 	if(lid >=3D ids->size)
 		BUG();
-=09
+
+	/*=20
+	 * do not need a read_barrier_depends() here to force ordering
+	 * on Alpha, since the ipc_ids.sem is held.
+	 */=09
 	p =3D ids->entries[lid].p;
 	ids->entries[lid].p =3D NULL;
 	if(p=3D=3DNULL)
@@ -414,15 +429,15 @@
 }
=20
 /*
- * ipc_get() requires ipc_ids.sem down, otherwise we need a rmb() here
- * to sync with grow_ary();
- *
- * So far only shm_get_stat() uses ipc_get() via shm_get().  So ipc_get()
- * is called with shm_ids.sem locked.  Thus a rmb() is not needed here,
- * as grow_ary() also requires shm_ids.sem down(for shm).
- *
- * But if ipc_get() is used in the future without ipc_ids.sem down,
- * we need to add a rmb() before accessing the entries array
+ * So far only shm_get_stat() calls ipc_get() via shm_get(), so ipc_get()
+ * is called with shm_ids.sem locked.  Since grow_ary() is also called wit=
h
+ * shm_ids.sem down(for Shared Memory), there is no need to add read=20
+ * barriers here to gurantee the writes in grow_ary() are seen in order=20
+ * here (for Alpha).
+ *
+ * However ipc_get() itself does not necessary require ipc_ids.sem down. S=
o
+ * if in the future ipc_get() is used by other places without ipc_ids.sem
+ * down, then ipc_get() needs read memery barriers as ipc_lock() does.
  */
 struct kern_ipc_perm* ipc_get(struct ipc_ids* ids, int id)
 {
@@ -430,7 +445,6 @@
 	int lid =3D id % SEQ_MULTIPLIER;
 	if(lid >=3D ids->size)
 		return NULL;
-	rmb();
 	out =3D ids->entries[lid].p;
 	return out;
 }
@@ -439,6 +453,7 @@
 {
 	struct kern_ipc_perm* out;
 	int lid =3D id % SEQ_MULTIPLIER;
+	struct ipc_id* entries;
=20
 	rcu_read_lock();
 	if(lid >=3D ids->size) {
@@ -446,9 +461,18 @@
 		return NULL;
 	}
=20
-	/* we need a barrier here to sync with grow_ary() */
-	rmb();
-	out =3D ids->entries[lid].p;
+	/*=20
+	 * Note: The following two read barriers are corresponding
+	 * to the two write barriers in grow_ary(). They gurantee=20
+	 * the writes are seen in the same order on the read side.=20
+	 * smp_rmb() has effect on all CPUs.  read_barrier_depends()=20
+	 * is used if there are data dependency between two reads, and=20
+	 * has effect only on Alpha.
+	 */
+	smp_rmb(); /* prevent indexing old array with new size */
+	entries =3D ids->entries;
+	read_barrier_depends(); /*prevent seeing new array unitialized */
+	out =3D entries[lid].p;
 	if(out =3D=3D NULL) {
 		rcu_read_unlock();
 		return NULL;

--=-qkoZRO+ZjaHxQrHz62Uq--

