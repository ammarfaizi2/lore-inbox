Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129414AbQKQPKL>; Fri, 17 Nov 2000 10:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129420AbQKQPKB>; Fri, 17 Nov 2000 10:10:01 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:62429 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129414AbQKQPJr>; Fri, 17 Nov 2000 10:09:47 -0500
From: Christoph Rohland <cr@sap.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Richard Jerrell <jerrell@missioncriticallinux.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Patch] Re: Bug in 2.4.0-test9 and test10 with sys_shmat()
In-Reply-To: <Pine.LNX.4.21.0011161156270.13545-100000@jerrell.lowell.mclinux.com>
Organisation: SAP LinuxLab
Date: 17 Nov 2000 15:37:38 +0100
In-Reply-To: Richard Jerrell's message of "Thu, 16 Nov 2000 11:57:15 -0500 (EST)"
Message-ID: <qwwn1eyu0jx.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The attached patch fixes two things:

1) shmat should not oops on shmid < 0
2) I think the shm tables should be allocated with GFP_USER instead of
   GFP_KERNEL since these are user requests.

Greetings
		Christoph

--- 4-11-6/ipc/shm.c	Wed Oct  4 15:58:02 2000
+++ linux/ipc/shm.c	Fri Nov 17 13:47:29 2000
@@ -572,13 +572,13 @@
 	if (pages == 0)
 		return NULL;
 
-	ret = kmalloc ((dir+1) * sizeof(pte_t *), GFP_KERNEL);
+	ret = kmalloc ((dir+1) * sizeof(pte_t *), GFP_USER);
 	if (!ret)
 		goto nomem;
 
 	for (ptr = ret; ptr < ret+dir ; ptr++)
 	{
-		*ptr = (pte_t *)__get_free_page (GFP_KERNEL);
+		*ptr = (pte_t *)__get_free_page (GFP_USER);
 		if (!*ptr)
 			goto free;
 		init_ptes (*ptr, PTES_PER_PAGE);
@@ -586,7 +586,7 @@
 
 	/* The last one is probably not of PAGE_SIZE: we use kmalloc */
 	if (last) {
-		*ptr = kmalloc (last*sizeof(pte_t), GFP_KERNEL);
+		*ptr = kmalloc (last*sizeof(pte_t), GFP_USER);
 		if (!*ptr)
 			goto free;
 		init_ptes (*ptr, last);
@@ -724,7 +724,7 @@
 	struct shmid_kernel *shp;
 	pte_t		   **dir;
 
-	shp = (struct shmid_kernel *) kmalloc (sizeof (*shp) + namelen, GFP_KERNEL);
+	shp = (struct shmid_kernel *) kmalloc (sizeof (*shp) + namelen, GFP_USER);
 	if (!shp)
 		return ERR_PTR(-ENOMEM);
 
@@ -1202,7 +1202,7 @@
 	char   name[SHM_FMT_LEN+1];
 	void *user_addr;
 
-	if (!shm_sb || (shmid % SEQ_MULTIPLIER) == zero_id)
+	if (!shm_sb || shmid < 0 || (shmid % SEQ_MULTIPLIER) == zero_id)
 		return -EINVAL;
 
 	if ((addr = (ulong)shmaddr)) {
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
