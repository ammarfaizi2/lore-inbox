Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWEVD4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWEVD4W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 23:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWEVD4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 23:56:22 -0400
Received: from xenotime.net ([66.160.160.81]:2263 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751191AbWEVD4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 23:56:21 -0400
Date: Sun, 21 May 2006 20:57:32 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, wli@holomorphy.com
Subject: [PATCH 2/14/] Doc. sources: expose vm/
Message-Id: <20060521205732.cc824d73.rdunlap@xenotime.net>
In-Reply-To: <20060521203349.40b40930.rdunlap@xenotime.net>
References: <20060521203349.40b40930.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Documentation/vm/:
Expose example and tool source files in the Documentation/ directory in
their own files instead of being buried (almost hidden) in readme/txt files.

This will make them more visible/usable to users who may need
to use them, to developers who may need to test with them, and
to janitors who would update them if they were more visible.

Also, if any of these possibly should not be in the kernel tree at
all, it will be clearer that they are here and we can discuss if
they should be removed.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/vm/hugepage-mmap.c |   73 ++++++++++++++++++
 Documentation/vm/hugepage-shm.c  |   69 +++++++++++++++++
 Documentation/vm/hugetlbpage.txt |  152 +--------------------------------------
 3 files changed, 149 insertions(+), 145 deletions(-)

--- /dev/null
+++ linux-2617-rc4g9-docsrc-split/Documentation/vm/hugepage-shm.c
@@ -0,0 +1,69 @@
+#include <stdlib.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/shm.h>
+#include <sys/mman.h>
+
+#ifndef SHM_HUGETLB
+#define SHM_HUGETLB 04000
+#endif
+
+#define LENGTH (256UL*1024*1024)
+
+#define dprintf(x)  printf(x)
+
+/* Only ia64 requires this */
+#ifdef __ia64__
+#define ADDR (void *)(0x8000000000000000UL)
+#define SHMAT_FLAGS (SHM_RND)
+#else
+#define ADDR (void *)(0x0UL)
+#define SHMAT_FLAGS (0)
+#endif
+
+int main(void)
+{
+	int shmid;
+	unsigned long i;
+	char *shmaddr;
+
+	if ((shmid = shmget(2, LENGTH,
+			    SHM_HUGETLB | IPC_CREAT | SHM_R | SHM_W)) < 0) {
+		perror("shmget");
+		exit(1);
+	}
+	printf("shmid: 0x%x\n", shmid);
+
+	shmaddr = shmat(shmid, ADDR, SHMAT_FLAGS);
+	if (shmaddr == (char *)-1) {
+		perror("Shared memory attach failure");
+		shmctl(shmid, IPC_RMID, NULL);
+		exit(2);
+	}
+	printf("shmaddr: %p\n", shmaddr);
+
+	dprintf("Starting the writes:\n");
+	for (i = 0; i < LENGTH; i++) {
+		shmaddr[i] = (char)(i);
+		if (!(i % (1024 * 1024)))
+			dprintf(".");
+	}
+	dprintf("\n");
+
+	dprintf("Starting the Check...");
+	for (i = 0; i < LENGTH; i++)
+		if (shmaddr[i] != (char)i)
+			printf("\nIndex %lu mismatched\n", i);
+	dprintf("Done.\n");
+
+	if (shmdt((const void *)shmaddr) != 0) {
+		perror("Detach failure");
+		shmctl(shmid, IPC_RMID, NULL);
+		exit(3);
+	}
+
+	shmctl(shmid, IPC_RMID, NULL);
+
+	return 0;
+}
--- linux-2617-rc4g9-docsrc-split.orig/Documentation/vm/hugetlbpage.txt
+++ linux-2617-rc4g9-docsrc-split/Documentation/vm/hugetlbpage.txt
@@ -104,13 +104,15 @@ Also, it is important to note that no su
 applications are going to use only shmat/shmget system calls.  Users who
 wish to use hugetlb page via shared memory segment should be a member of
 a supplementary group and system admin needs to configure that gid into
-/proc/sys/vm/hugetlb_shm_group.  It is possible for same or different
-applications to use any combination of mmaps and shm* calls, though the
-mount of filesystem will be required for using mmap calls.
+/proc/sys/vm/hugetlb_shm_group.  It is possible for one or different
+applications to use any combination of mmaps and shm* calls, though a
+hugetlbfs filesystem mount will be required for using mmaps.
 
 *******************************************************************
 
 /*
+ * hugepage-shm:  see Documentation/vm/hugepage-shm.c
+ *
  * Example of using hugepage memory in a user application using Sys V shared
  * memory system calls.  In this example the app is requesting 256MB of
  * memory that is backed by huge pages.  The application uses the flag
@@ -134,79 +136,12 @@ mount of filesystem will be required for
  *
  * echo 4194304 > /proc/sys/kernel/shmall
  */
-#include <stdlib.h>
-#include <stdio.h>
-#include <sys/types.h>
-#include <sys/ipc.h>
-#include <sys/shm.h>
-#include <sys/mman.h>
-
-#ifndef SHM_HUGETLB
-#define SHM_HUGETLB 04000
-#endif
-
-#define LENGTH (256UL*1024*1024)
-
-#define dprintf(x)  printf(x)
-
-/* Only ia64 requires this */
-#ifdef __ia64__
-#define ADDR (void *)(0x8000000000000000UL)
-#define SHMAT_FLAGS (SHM_RND)
-#else
-#define ADDR (void *)(0x0UL)
-#define SHMAT_FLAGS (0)
-#endif
-
-int main(void)
-{
-	int shmid;
-	unsigned long i;
-	char *shmaddr;
-
-	if ((shmid = shmget(2, LENGTH,
-			    SHM_HUGETLB | IPC_CREAT | SHM_R | SHM_W)) < 0) {
-		perror("shmget");
-		exit(1);
-	}
-	printf("shmid: 0x%x\n", shmid);
-
-	shmaddr = shmat(shmid, ADDR, SHMAT_FLAGS);
-	if (shmaddr == (char *)-1) {
-		perror("Shared memory attach failure");
-		shmctl(shmid, IPC_RMID, NULL);
-		exit(2);
-	}
-	printf("shmaddr: %p\n", shmaddr);
-
-	dprintf("Starting the writes:\n");
-	for (i = 0; i < LENGTH; i++) {
-		shmaddr[i] = (char)(i);
-		if (!(i % (1024 * 1024)))
-			dprintf(".");
-	}
-	dprintf("\n");
-
-	dprintf("Starting the Check...");
-	for (i = 0; i < LENGTH; i++)
-		if (shmaddr[i] != (char)i)
-			printf("\nIndex %lu mismatched\n", i);
-	dprintf("Done.\n");
-
-	if (shmdt((const void *)shmaddr) != 0) {
-		perror("Detach failure");
-		shmctl(shmid, IPC_RMID, NULL);
-		exit(3);
-	}
-
-	shmctl(shmid, IPC_RMID, NULL);
-
-	return 0;
-}
 
 *******************************************************************
 
 /*
+ * hugepage-mmap:  see Documentation/vm/hugepage-mmap.c
+ *
  * Example of using hugepage memory in a user application using the mmap
  * system call.  Before running this application, make sure that the
  * administrator has mounted the hugetlbfs filesystem (on some directory
@@ -219,76 +154,3 @@ int main(void)
  * specified.  Specifying a fixed address is not required on ppc64, i386
  * or x86_64.
  */
-#include <stdlib.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <sys/mman.h>
-#include <fcntl.h>
-
-#define FILE_NAME "/mnt/hugepagefile"
-#define LENGTH (256UL*1024*1024)
-#define PROTECTION (PROT_READ | PROT_WRITE)
-
-/* Only ia64 requires this */
-#ifdef __ia64__
-#define ADDR (void *)(0x8000000000000000UL)
-#define FLAGS (MAP_SHARED | MAP_FIXED)
-#else
-#define ADDR (void *)(0x0UL)
-#define FLAGS (MAP_SHARED)
-#endif
-
-void check_bytes(char *addr)
-{
-	printf("First hex is %x\n", *((unsigned int *)addr));
-}
-
-void write_bytes(char *addr)
-{
-	unsigned long i;
-
-	for (i = 0; i < LENGTH; i++)
-		*(addr + i) = (char)i;
-}
-
-void read_bytes(char *addr)
-{
-	unsigned long i;
-
-	check_bytes(addr);
-	for (i = 0; i < LENGTH; i++)
-		if (*(addr + i) != (char)i) {
-			printf("Mismatch at %lu\n", i);
-			break;
-		}
-}
-
-int main(void)
-{
-	void *addr;
-	int fd;
-
-	fd = open(FILE_NAME, O_CREAT | O_RDWR, 0755);
-	if (fd < 0) {
-		perror("Open failed");
-		exit(1);
-	}
-
-	addr = mmap(ADDR, LENGTH, PROTECTION, FLAGS, fd, 0);
-	if (addr == MAP_FAILED) {
-		perror("mmap");
-		unlink(FILE_NAME);
-		exit(1);
-	}
-
-	printf("Returned address is %p\n", addr);
-	check_bytes(addr);
-	write_bytes(addr);
-	read_bytes(addr);
-
-	munmap(addr, LENGTH);
-	close(fd);
-	unlink(FILE_NAME);
-
-	return 0;
-}
--- /dev/null
+++ linux-2617-rc4g9-docsrc-split/Documentation/vm/hugepage-mmap.c
@@ -0,0 +1,73 @@
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <fcntl.h>
+
+#define FILE_NAME "/mnt/hugepagefile"
+#define LENGTH (256UL*1024*1024)
+#define PROTECTION (PROT_READ | PROT_WRITE)
+
+/* Only ia64 requires this */
+#ifdef __ia64__
+#define ADDR (void *)(0x8000000000000000UL)
+#define FLAGS (MAP_SHARED | MAP_FIXED)
+#else
+#define ADDR (void *)(0x0UL)
+#define FLAGS (MAP_SHARED)
+#endif
+
+void check_bytes(char *addr)
+{
+	printf("First hex is %x\n", *((unsigned int *)addr));
+}
+
+void write_bytes(char *addr)
+{
+	unsigned long i;
+
+	for (i = 0; i < LENGTH; i++)
+		*(addr + i) = (char)i;
+}
+
+void read_bytes(char *addr)
+{
+	unsigned long i;
+
+	check_bytes(addr);
+	for (i = 0; i < LENGTH; i++)
+		if (*(addr + i) != (char)i) {
+			printf("Mismatch at %lu\n", i);
+			break;
+		}
+}
+
+int main(void)
+{
+	void *addr;
+	int fd;
+
+	fd = open(FILE_NAME, O_CREAT | O_RDWR, 0755);
+	if (fd < 0) {
+		perror("Open failed");
+		exit(1);
+	}
+
+	addr = mmap(ADDR, LENGTH, PROTECTION, FLAGS, fd, 0);
+	if (addr == MAP_FAILED) {
+		perror("mmap");
+		unlink(FILE_NAME);
+		exit(1);
+	}
+
+	printf("Returned address is %p\n", addr);
+	check_bytes(addr);
+	write_bytes(addr);
+	read_bytes(addr);
+
+	munmap(addr, LENGTH);
+	close(fd);
+	unlink(FILE_NAME);
+
+	return 0;
+}


---
