Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbVJaWDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbVJaWDA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 17:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbVJaWDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 17:03:00 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:13485 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964858AbVJaWC6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 17:02:58 -0500
Subject: [PATCH] SHM_NORESERVE flags for shmget()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org
Content-Type: multipart/mixed; boundary="=-pw4MyCvMfx0RBbXuyB5J"
Date: Mon, 31 Oct 2005 14:02:32 -0800
Message-Id: <1130796152.24503.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pw4MyCvMfx0RBbXuyB5J
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

Here is the patch to add SHM_NORESERVE functionality
similar to MAP_NORESERVE for shared memory segments.

This mainly to avoid abuse of OVERCOMMIT_ALWAYS and
this flag is ignored for OVERCOMMIT_NEVER. 
Hugh reviewed the patch earlier and had no objections 
to it. Could you include this ?

Thanks,
Badari





--=-pw4MyCvMfx0RBbXuyB5J
Content-Disposition: attachment; filename=shm-noreserve.patch
Content-Type: text/x-patch; name=shm-noreserve.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
diff -Naurp -X dontdiff linux-2.6.14/include/linux/shm.h linux-2.6.14.new/include/linux/shm.h
--- linux-2.6.14/include/linux/shm.h	2005-09-30 14:17:35.000000000 -0700
+++ linux-2.6.14.new/include/linux/shm.h	2005-10-18 08:46:03.000000000 -0700
@@ -92,6 +92,7 @@ struct shmid_kernel /* private to the ke
 #define	SHM_DEST	01000	/* segment will be destroyed on last detach */
 #define SHM_LOCKED      02000   /* segment will not be swapped */
 #define SHM_HUGETLB     04000   /* segment will use huge TLB pages */
+#define SHM_NORESERVE   010000  /* don't check for reservations */
 
 #ifdef CONFIG_SYSVIPC
 long do_shmat(int shmid, char __user *shmaddr, int shmflg, unsigned long *addr);
diff -Naurp -X dontdiff linux-2.6.14/ipc/shm.c linux-2.6.14.new/ipc/shm.c
--- linux-2.6.14/ipc/shm.c	2005-09-30 14:17:35.000000000 -0700
+++ linux-2.6.14.new/ipc/shm.c	2005-10-20 14:14:40.000000000 -0700
@@ -212,8 +212,16 @@ static int newseg (key_t key, int shmflg
 		file = hugetlb_zero_setup(size);
 		shp->mlock_user = current->user;
 	} else {
+		int acctflag = VM_ACCOUNT;
+		/*
+		 * Do not allow no accounting for OVERCOMMIT_NEVER, even
+	 	 * if it's asked for.
+		 */
+		if  ((shmflg & SHM_NORESERVE) && 
+			sysctl_overcommit_memory != OVERCOMMIT_NEVER)
+			acctflag = 0;
 		sprintf (name, "SYSV%08x", key);
-		file = shmem_file_setup(name, size, VM_ACCOUNT);
+		file = shmem_file_setup(name, size, acctflag);
 	}
 	error = PTR_ERR(file);
 	if (IS_ERR(file))

--=-pw4MyCvMfx0RBbXuyB5J--

