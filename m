Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVAAXnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVAAXnp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 18:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVAAXnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 18:43:45 -0500
Received: from ozlabs.org ([203.10.76.45]:5780 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261198AbVAAXnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 18:43:16 -0500
Date: Sun, 2 Jan 2005 10:42:15 +1100
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] update hugetlb documentation
Message-ID: <20050101234215.GJ21710@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The hugetlb documentation includes two example programs however they
need some attention. At the moment they are ia64 specific (they use
MAP_FIXED which will fail on other architectures), and they contain a
number of compiler warnings.

Also update the documentation to include the ppc64 page sizes.

Signed-off-by: Anton Blanchard <anton@samba.org>

===== hugetlbpage.txt 1.9 vs edited =====
--- 1.9/Documentation/vm/hugetlbpage.txt	2004-05-10 21:25:53 +10:00
+++ edited/hugetlbpage.txt	2005-01-02 10:25:20 +11:00
@@ -1,14 +1,14 @@
 
 The intent of this file is to give a brief summary of hugetlbpage support in
 the Linux kernel.  This support is built on top of multiple page size support
-that is provided by most of modern architectures.  For example, IA-32
+that is provided by most modern architectures.  For example, IA-32
 architecture supports 4K and 4M (2M in PAE mode) page sizes, IA-64
 architecture supports multiple page sizes 4K, 8K, 64K, 256K, 1M, 4M, 16M,
-256M.  A TLB is a cache of virtual-to-physical translations.  Typically this
-is a very scarce resource on processor.  Operating systems try to make best
-use of limited number of TLB resources.  This optimization is more critical
-now as bigger and bigger physical memories (several GBs) are more readily
-available.
+256M and ppc64 supports 4K and 16M.  A TLB is a cache of virtual-to-physical
+translations.  Typically this is a very scarce resource on processor.
+Operating systems try to make best use of limited number of TLB resources.
+This optimization is more critical now as bigger and bigger physical memories
+(several GBs) are more readily available.
 
 Users can use the huge page support in Linux kernel by either using the mmap
 system call or standard SYSv shared memory system calls (shmget, shmat).
@@ -98,125 +98,187 @@
 applications to use any combination of mmaps and shm* calls.  Though the
 mount of filesystem will be required for using mmaps.
 
-/* Example of using hugepage in user application using Sys V shared memory
- * system calls.  In this example, app is requesting memory of size 256MB that
- * is backed by huge pages.  Application uses the flag SHM_HUGETLB in shmget
- * system call to informt the kernel that it is requesting hugepages.  For
- * IA-64 architecture, Linux kernel reserves Region number 4 for hugepages.
- * That means the addresses starting with 0x800000....will need to be
- * specified.
+*******************************************************************
+
+/*
+ * Example of using hugepage memory in a user application using Sys V shared
+ * memory system calls.  In this example the app is requesting 256MB of
+ * memory that is backed by huge pages.  The application uses the flag
+ * SHM_HUGETLB in the shmget system call to inform the kernel that it is
+ * requesting hugepages.
+ *
+ * For the IA-64 architecture, the Linux kernel reserves Region number 4 for
+ * hugepages.  That means the addresses starting with 0x800000... will need 
+ * to be specified.  Specifying a fixed address is not required on ppc64,
+ * i386 or amd64.
+ *
+ * Note: The default shared memory limit is quite low on many kernels,
+ * you may need to increase it via:
+ *
+ * echo 268435456 > /proc/sys/kernel/shmmax
+ *
+ * This will increase the maximum size per shared memory segment to 256MB.
+ * The other limit that you will hit eventually is shmall which is the
+ * total amount of shared memory in pages. To set it to 16GB on a system
+ * with a 4kB pagesize do:
+ *
+ * echo 4194304 > /proc/sys/kernel/shmall
  */
+#include <stdlib.h>
+#include <stdio.h>
 #include <sys/types.h>
+#include <sys/ipc.h>
 #include <sys/shm.h>
-#include <sys/types.h>
 #include <sys/mman.h>
-#include <errno.h>
 
-extern int errno;
+#ifndef SHM_HUGETLB
 #define SHM_HUGETLB 04000
-#define LPAGE_SIZE      (256UL*1024UL*1024UL)
-#define         dprintf(x)  printf(x)
-#define ADDR (0x8000000000000000UL)
-main()
+#endif
+
+#define LENGTH (256UL*1024*1024)
+
+#define dprintf(x)  printf(x)
+
+/* Only IA64 requires this */
+#ifdef IA64
+#define ADDR (void *)(0x8000000000000000UL)
+#define SHMAT_FLAGS (SHM_RND)
+#else
+#define ADDR (void *)(0x0UL)
+#define SHMAT_FLAGS (0)
+#endif
+
+int main(void)
 {
-        int shmid;
-        int     i, j, k;
-        volatile        char    *shmaddr;
-
-        if ((shmid =shmget(2, LPAGE_SIZE, SHM_HUGETLB|IPC_CREAT|SHM_R|SHM_W ))
-< 0) {
-                perror("Failure:");
-                exit(1);
-        }
-        printf("shmid: 0x%x\n", shmid);
-        shmaddr = shmat(shmid, (void *)ADDR, SHM_RND) ;
-        if (errno != 0) {
-                perror("Shared Memory Attach Failure:");
-                exit(2);
-        }
-        printf("shmaddr: %p\n", shmaddr);
-
-        dprintf("Starting the writes:\n");
-        for (i=0;i<LPAGE_SIZE;i++) {
-                shmaddr[i] = (char) (i);
-                if (!(i%(1024*1024))) dprintf(".");
-        }
-        dprintf("\n");
-        dprintf("Starting the Check...");
-        for (i=0; i<LPAGE_SIZE;i++)
-                if (shmaddr[i] != (char)i)
-                        printf("\nIndex %d mismatched.");
-        dprintf("Done.\n");
-        if (shmdt((const void *)shmaddr) != 0) {
-                perror("Detached Failure:");
-                exit (3);
-        }
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
 }
-*******************************************************************
-*******************************************************************
 
+*******************************************************************
 
-/* Example of using hugepage in user application using mmap 
- * system call.  Before running this application, make sure that
- * administrator has mounted the hugetlbfs (on some directory like /mnt) using
- * the command mount -t hugetlbfs nodev /mnt
- * In this example, app is requesting memory of size 256MB that
- * is backed by huge pages.  Application uses the flag SHM_HUGETLB in shmget
- * system call to informt the kernel that it is requesting hugepages.  For
- * IA-64 architecture, Linux kernel reserves Region number 4 for hugepages.
- * That means the addresses starting with 0x800000....will need to be
- * specified.
+/*
+ * Example of using hugepage memory in a user application using the mmap
+ * system call.  Before running this application, make sure that the
+ * administrator has mounted the hugetlbfs filesystem (on some directory 
+ * like /mnt) using the command mount -t hugetlbfs nodev /mnt. In this
+ * example, the app is requesting memory of size 256MB that is backed by
+ * huge pages.  
+ *
+ * For IA-64 architecture, Linux kernel reserves Region number 4 for hugepages.
+ * That means the addresses starting with 0x800000... will need to be
+ * specified.  Specifying a fixed address is not required on ppc64, i386
+ * or amd64.
  */
-#include <unistd.h>
+#include <stdlib.h>
 #include <stdio.h>
+#include <unistd.h>
 #include <sys/mman.h>
 #include <fcntl.h>
-#include <errno.h>
 
 #define FILE_NAME "/mnt/hugepagefile"
-#define LENGTH (256*1024*1024)
+#define LENGTH (256UL*1024*1024)
 #define PROTECTION (PROT_READ | PROT_WRITE)
-#define FLAGS   MAP_SHARED |MAP_FIXED
-#define ADDRESS (char *)(0x60000000UL + 0x8000000000000000UL)
 
-extern errno;
+/* Only IA64 requires this */
+#ifdef IA64
+#define ADDR (void *)(0x8000000000000000UL)
+#define FLAGS (MAP_SHARED | MAP_FIXED)
+#else
+#define ADDR (void *)(0x0UL)
+#define FLAGS (MAP_SHARED)
+#endif
 
-check_bytes(char *addr)
+void check_bytes(char *addr)
 {
-        printf("First hex is %x\n", *((unsigned int *)addr));
+	printf("First hex is %x\n", *((unsigned int *)addr));
 }
 
-write_bytes(char *addr)
+void write_bytes(char *addr)
 {
-        int i;
-        for (i=0;i<LENGTH;i++)
-                *(addr+i)=(char)i;
+	unsigned long i;
+
+	for (i = 0; i < LENGTH; i++)
+		*(addr + i) = (char)i;
 }
-read_bytes(char *addr)
+
+void read_bytes(char *addr)
 {
-        int i;
-        check_bytes(addr);
-        for (i=0;i<LENGTH;i++)
-                if (*(addr+i)!=(char)i) {
-                        printf("Mismatch at %d\n", i);
-                        break;
-                }
+	unsigned long i;
+
+	check_bytes(addr);
+	for (i = 0; i < LENGTH; i++)
+		if (*(addr + i) != (char)i) {
+			printf("Mismatch at %lu\n", i);
+			break;
+		}
 }
-main()
+
+int main(void)
 {
-        unsigned long addr = 0;
-        int fd ;
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
 
-        fd = open(FILE_NAME, O_CREAT|O_RDWR, 0755);
-        if (fd < 0) {
-                perror("Open failed");
-                exit(errno);
-        }
-        addr = (unsigned long)mmap(ADDRESS, LENGTH, PROTECTION, FLAGS, fd, 0);
-        if (errno != 0)
-                perror("mmap failed");
-        printf("Returned address is %p\n", addr);
-        check_bytes((char*)addr);
-        write_bytes((char*)addr);
-        read_bytes((char *)addr);
+	return 0;
 }

