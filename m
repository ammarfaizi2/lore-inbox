Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129421AbQL0LA7>; Wed, 27 Dec 2000 06:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129465AbQL0LAt>; Wed, 27 Dec 2000 06:00:49 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:43207 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129421AbQL0LAk>; Wed, 27 Dec 2000 06:00:40 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Dave Gilbert <gilbertd@treblig.org>
Subject: [Patch] shmmin behaviour back to 2.2 behaviour
From: Christoph Rohland <cr@sap.com>
Message-ID: <m3d7eeb1pa.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 27 Dec 2000 11:32:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following patchlet bring the handling of shmget with size zero
back to the 2.2 behaviour. There seem to be programs out, which
(erroneously) rely on this.

Greetings
                Christoph

diff -uNr c/include/linux/shm.h c1/include/linux/shm.h
--- c/include/linux/shm.h	Fri Dec 22 10:20:08 2000
+++ c1/include/linux/shm.h	Tue Dec 26 19:52:15 2000
@@ -10,7 +10,7 @@
  */
 
 #define SHMMAX 0x2000000		 /* max shared seg size (bytes) */
-#define SHMMIN 0			 /* min shared seg size (bytes) */
+#define SHMMIN 1			 /* min shared seg size (bytes) */
 #define SHMMNI 4096			 /* max num of segs system wide */
 #define SHMALL (SHMMAX/PAGE_SIZE*(SHMMNI/16)) /* max shm system wide (pages) */
 #define SHMSEG SHMMNI			 /* max shared segs per process */
diff -uNr c/ipc/shm.c c1/ipc/shm.c
--- c/ipc/shm.c	Fri Dec 22 10:05:38 2000
+++ c1/ipc/shm.c	Tue Dec 26 19:53:35 2000
@@ -179,6 +179,9 @@
 	char name[13];
 	int id;
 
+	if (size < SHMMIN || size > shm_ctlmax)
+		return -EINVAL;
+
 	if (shm_tot + numpages >= shm_ctlall)
 		return -ENOSPC;
 
@@ -222,9 +225,6 @@
 {
 	struct shmid_kernel *shp;
 	int err, id = 0;
-
-	if (size < SHMMIN || size > shm_ctlmax)
-		return -EINVAL;
 
 	down(&shm_ids.sem);
 	if (key == IPC_PRIVATE) {

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
