Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268955AbUIMUdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268955AbUIMUdq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 16:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268957AbUIMUdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 16:33:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24541 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268955AbUIMUdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 16:33:41 -0400
Message-ID: <4146041F.2040106@redhat.com>
Date: Mon, 13 Sep 2004 16:33:35 -0400
From: Neil Horman <nhorman@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] close race condition in shared memory mapping/unmapping
Content-Type: multipart/mixed;
 boundary="------------040007020509060101010604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040007020509060101010604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hey all-
	Found this the other day poking through the ipc code.  There appears to 
be a race condition in the counter that records how many processes are 
accessing a given shared memory segment.  In most places the shm_nattch 
variable is protected by the shm_ids.sem semaphore, but there are a few 
openings which appear to be able to allow a corruption of this variable 
when run on SMP systems.  I've attached a patch to 2.6.9-rc2 for review. 
  The locking may be a little over-aggressive (I was following examples 
from other points in this file), but I figure better safe than sorry :).

Anywho, here it is.
Thanks
Neil
-- 
/***************************************************
  *Neil Horman
  *Software Engineer
  *Red Hat, Inc.
  *nhorman@redhat.com
  *gpg keyid: 1024D / 0x92A74FA1
  *http://pgp.mit.edu
  ***************************************************/

--------------040007020509060101010604
Content-Type: text/plain;
 name="linux-2.6.9-rc2-shmlock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.9-rc2-shmlock.patch"

--- linux-2.6.9-rc2-rpc/ipc/shm.c.orig	2004-09-13 15:59:46.604446096 -0400
+++ linux-2.6.9-rc2-rpc/ipc/shm.c	2004-09-13 16:17:05.606493776 -0400
@@ -86,12 +86,14 @@
 static inline void shm_inc (int id) {
 	struct shmid_kernel *shp;
 
+	down(&shm_ids.sem);
 	if(!(shp = shm_lock(id)))
 		BUG();
 	shp->shm_atim = get_seconds();
 	shp->shm_lprid = current->tgid;
 	shp->shm_nattch++;
 	shm_unlock(shp);
+	up(&shm_ids.sem);
 }
 
 /* This is called by fork, once for every shm attach. */
@@ -697,18 +699,23 @@
 	 * We cannot rely on the fs check since SYSV IPC does have an
 	 * additional creator id...
 	 */
+	down(&shm_ids.sem);
 	shp = shm_lock(shmid);
 	if(shp == NULL) {
+		shm_unlock(shp);
+		up(&shm_ids.sem);
 		err = -EINVAL;
 		goto out;
 	}
 	err = shm_checkid(shp,shmid);
 	if (err) {
 		shm_unlock(shp);
+		up(&shm_ids.sem);
 		goto out;
 	}
 	if (ipcperms(&shp->shm_perm, acc_mode)) {
 		shm_unlock(shp);
+		up(&shm_ids.sem);
 		err = -EACCES;
 		goto out;
 	}
@@ -716,6 +723,7 @@
 	err = security_shm_shmat(shp, shmaddr, shmflg);
 	if (err) {
 		shm_unlock(shp);
+		up(&shm_ids.sem);
 		return err;
 	}
 		
@@ -723,6 +731,7 @@
 	size = i_size_read(file->f_dentry->d_inode);
 	shp->shm_nattch++;
 	shm_unlock(shp);
+	up(&shm_ids.sem);
 
 	down_write(&current->mm->mmap_sem);
 	if (addr && !(shmflg & SHM_REMAP)) {

--------------040007020509060101010604--
