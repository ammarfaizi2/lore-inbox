Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316863AbSF0TQP>; Thu, 27 Jun 2002 15:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316952AbSF0TQP>; Thu, 27 Jun 2002 15:16:15 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:64164 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S316863AbSF0TQN>; Thu, 27 Jun 2002 15:16:13 -0400
Date: Thu, 27 Jun 2002 20:17:42 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrew Morton <akpm@zip.com.au>, Christoph Rohland <cr@sap.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] shm_destroy lock hang
Message-ID: <Pine.LNX.4.21.0206272007480.2791-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin reported "Bug with shared memory" to LKML 14 May: hang due to
schedule in truncate_list_pages called from .... shm_destroy holding
the shm_lock spinlock.  shm_destroy needs that lock for shm_rmid, but
it can be safely unlocked once link from id to shp has been removed.
Patch against 2.4.19-rc1 or -pre10-ac2, applies at offset to 2.5.24.

--- 2.4.19-rc1/ipc/shm.c	Mon Jun 24 19:14:58 2002
+++ linux/ipc/shm.c	Thu Jun 27 19:34:51 2002
@@ -117,12 +117,14 @@
  *
  * @shp: struct to free
  *
- * It has to be called with shp and shm_ids.sem locked
+ * It has to be called with shp and shm_ids.sem locked,
+ * but returns with shp unlocked and freed.
  */
 static void shm_destroy (struct shmid_kernel *shp)
 {
 	shm_tot -= (shp->shm_segsz + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	shm_rmid (shp->id);
+	shm_unlock(shp->id);
 	shmem_lock(shp->shm_file, 0);
 	fput (shp->shm_file);
 	kfree (shp);
@@ -150,8 +152,8 @@
 	if(shp->shm_nattch == 0 &&
 	   shp->shm_flags & SHM_DEST)
 		shm_destroy (shp);
-
-	shm_unlock(id);
+	else
+		shm_unlock(id);
 	up (&shm_ids.sem);
 }
 
@@ -511,11 +513,9 @@
 			shp->shm_flags |= SHM_DEST;
 			/* Do not find it any more */
 			shp->shm_perm.key = IPC_PRIVATE;
+			shm_unlock(shmid);
 		} else
 			shm_destroy (shp);
-
-		/* Unlock */
-		shm_unlock(shmid);
 		up(&shm_ids.sem);
 		return err;
 	}
@@ -653,7 +653,8 @@
 	if(shp->shm_nattch == 0 &&
 	   shp->shm_flags & SHM_DEST)
 		shm_destroy (shp);
-	shm_unlock(shmid);
+	else
+		shm_unlock(shmid);
 	up (&shm_ids.sem);
 
 	*raddr = (unsigned long) user_addr;

