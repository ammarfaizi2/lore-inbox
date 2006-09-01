Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWIAM1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWIAM1h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 08:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWIAM1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 08:27:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48529 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751123AbWIAM1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 08:27:36 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH] NOMMU: Make futexes work under NOMMU conditions
Date: Fri, 01 Sep 2006 13:27:19 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org, dhowells@redhat.com
Message-Id: <20060901122719.25128.8467.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Make futexes work under NOMMU conditions.

This can be tested by running this in one shell:

	#define SYSERROR(X, Y) \
		do { if ((long)(X) == -1L) { perror(Y); exit(1); }} while(0)

	int main()
	{
		int shmid, tmp, *f, n;

		shmid = shmget(23, 4, IPC_CREAT|0666);
		SYSERROR(shmid, "shmget");

		f = shmat(shmid, NULL, 0);
		SYSERROR(f, "shmat");

		n = *f;
		printf("WAIT: %p{%x}\n", f, n);
		tmp = futex(f, FUTEX_WAIT, n, NULL, NULL, 0);
		SYSERROR(tmp, "futex");
		printf("WAITED: %d\n", tmp);

		tmp = shmdt(f);
		SYSERROR(tmp, "shmdt");

		exit(0);
	}

And then this in the other shell:

	#define SYSERROR(X, Y) \
		do { if ((long)(X) == -1L) { perror(Y); exit(1); }} while(0)

	int main()
	{
		int shmid, tmp, *f;

		shmid = shmget(23, 4, IPC_CREAT|0666);
		SYSERROR(shmid, "shmget");

		f = shmat(shmid, NULL, 0);
		SYSERROR(f, "shmat");

		(*f)++;
		printf("WAKE: %p{%x}\n", f, *f);
		tmp = futex(f, FUTEX_WAKE, 1, NULL, NULL, 0);
		SYSERROR(tmp, "futex");
		printf("WOKE: %d\n", tmp);

		tmp = shmdt(f);
		SYSERROR(tmp, "shmdt");

		exit(0);
	}

The first program will set up a SYSV IPC SHM segment and wait on a futex in it
for the number at the start to change.  The program will increment that number
and wake the first program up.  This leads to output of the form:

	SHELL 1			SHELL 2
	=======================	=======================
	# /dowait
	WAIT: 0xc32ac000{0}
				# /dowake
				WAKE: 0xc32ac000{1}
	WAITED: 0		WOKE: 1

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 mm/nommu.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index a0ba6ac..3215f46 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -327,6 +327,15 @@ struct vm_area_struct *find_vma(struct m
 EXPORT_SYMBOL(find_vma);
 
 /*
+ * find a VMA
+ * - we don't extend stack VMAs under NOMMU conditions
+ */
+struct vm_area_struct *find_extend_vma(struct mm_struct *mm, unsigned long addr)
+{
+	return find_vma(mm, addr);
+}
+
+/*
  * look up the first VMA exactly that exactly matches addr
  * - should be called with mm->mmap_sem at least held readlocked
  */
@@ -1130,11 +1139,6 @@ struct page *follow_page(struct vm_area_
 	return NULL;
 }
 
-struct vm_area_struct *find_extend_vma(struct mm_struct *mm, unsigned long addr)
-{
-	return NULL;
-}
-
 int remap_pfn_range(struct vm_area_struct *vma, unsigned long from,
 		unsigned long to, unsigned long size, pgprot_t prot)
 {
