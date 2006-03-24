Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbWCXSR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbWCXSR6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWCXSR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:17:28 -0500
Received: from [198.99.130.12] ([198.99.130.12]:50070 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932100AbWCXSN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:13:59 -0500
Message-Id: <200603241814.k2OIExNn005555@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 12/16] UML - Memory hotplug
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Mar 2006 13:14:59 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds hotplug memory support to UML.  The mconsole syntax is
	config mem=[+-]n[KMG]
In other words, add or subtract some number of kilobytes, megabytes, or
gigabytes.
 
Unplugged pages are allocated and then madvise(MADV_REMOVE), which is
a currently experimental madvise extension.  These pages are tracked so
they can be plugged back in later if the admin decides to give them back.
The first page to be unplugged is used to keep track of about 4M of other
pages.  A list_head is the first thing on this page.  The rest is filled
with addresses of other unplugged pages.  This first page is not madvised,
obviously.
When this page is filled, the next page is used in a similar way and linked
onto a list with the first page.  Etc.
This whole process reverses when pages are plugged back in.  When a tracking
page no longer tracks any unplugged pages, then it is next in line for
plugging, which is done by freeing pages back to the kernel.

This patch also removes checking for /dev/anon on the host, which is obsoleted
by MADVISE_REMOVE.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.16.orig/arch/um/drivers/mconsole_kern.c	2006-03-23 17:15:05.000000000 -0500
+++ linux-2.6.16/arch/um/drivers/mconsole_kern.c	2006-03-23 17:39:21.000000000 -0500
@@ -20,6 +20,8 @@
 #include "linux/namei.h"
 #include "linux/proc_fs.h"
 #include "linux/syscalls.h"
+#include "linux/list.h"
+#include "linux/mm.h"
 #include "linux/console.h"
 #include "asm/irq.h"
 #include "asm/uaccess.h"
@@ -347,6 +349,139 @@ static struct mc_device *mconsole_find_d
 	return(NULL);
 }
 
+#define UNPLUGGED_PER_PAGE \
+	((PAGE_SIZE - sizeof(struct list_head)) / sizeof(unsigned long))
+
+struct unplugged_pages {
+	struct list_head list;
+	void *pages[UNPLUGGED_PER_PAGE];
+};
+
+static unsigned long long unplugged_pages_count = 0;
+static struct list_head unplugged_pages = LIST_HEAD_INIT(unplugged_pages);
+static int unplug_index = UNPLUGGED_PER_PAGE;
+
+static int mem_config(char *str)
+{
+	unsigned long long diff;
+	int err = -EINVAL, i, add;
+	char *ret;
+
+	if(str[0] != '=')
+		goto out;
+
+	str++;
+	if(str[0] == '-')
+		add = 0;
+	else if(str[0] == '+'){
+		add = 1;
+	}
+	else goto out;
+
+	str++;
+	diff = memparse(str, &ret);
+	if(*ret != '\0')
+		goto out;
+
+	diff /= PAGE_SIZE;
+
+	for(i = 0; i < diff; i++){
+		struct unplugged_pages *unplugged;
+		void *addr;
+
+		if(add){
+			if(list_empty(&unplugged_pages))
+				break;
+
+			unplugged = list_entry(unplugged_pages.next,
+					       struct unplugged_pages, list);
+			if(unplug_index > 0)
+				addr = unplugged->pages[--unplug_index];
+			else {
+				list_del(&unplugged->list);
+				addr = unplugged;
+				unplug_index = UNPLUGGED_PER_PAGE;
+			}
+
+			free_page((unsigned long) addr);
+			unplugged_pages_count--;
+		}
+		else {
+			struct page *page;
+
+			page = alloc_page(GFP_ATOMIC);
+			if(page == NULL)
+				break;
+
+			unplugged = page_address(page);
+			if(unplug_index == UNPLUGGED_PER_PAGE){
+				INIT_LIST_HEAD(&unplugged->list);
+				list_add(&unplugged->list, &unplugged_pages);
+				unplug_index = 0;
+			}
+			else {
+				struct list_head *entry = unplugged_pages.next;
+				addr = unplugged;
+
+				unplugged = list_entry(entry,
+						       struct unplugged_pages,
+						       list);
+				unplugged->pages[unplug_index++] = addr;
+				err = os_drop_memory(addr, PAGE_SIZE);
+				if(err)
+					printk("Failed to release memory - "
+					       "errno = %d\n", err);
+			}
+
+			unplugged_pages_count++;
+		}
+	}
+
+	err = 0;
+out:
+	return err;
+}
+
+static int mem_get_config(char *name, char *str, int size, char **error_out)
+{
+	char buf[sizeof("18446744073709551615\0")];
+	int len = 0;
+
+	sprintf(buf, "%ld", uml_physmem);
+	CONFIG_CHUNK(str, size, len, buf, 1);
+
+	return len;
+}
+
+static int mem_id(char **str, int *start_out, int *end_out)
+{
+	*start_out = 0;
+	*end_out = 0;
+
+	return 0;
+}
+
+static int mem_remove(int n)
+{
+	return -EBUSY;
+}
+
+static struct mc_device mem_mc = {
+	.name		= "mem",
+	.config		= mem_config,
+	.get_config	= mem_get_config,
+	.id		= mem_id,
+	.remove		= mem_remove,
+};
+
+static int mem_mc_init(void)
+{
+	mconsole_register_dev(&mem_mc);
+	return 0;
+}
+
+__initcall(mem_mc_init);
+
 #define CONFIG_BUF_SIZE 64
 
 static void mconsole_get_config(int (*get_config)(char *, char *, int,
Index: linux-2.6.16/arch/um/include/os.h
===================================================================
--- linux-2.6.16.orig/arch/um/include/os.h	2006-03-23 17:35:56.000000000 -0500
+++ linux-2.6.16/arch/um/include/os.h	2006-03-23 17:39:21.000000000 -0500
@@ -205,6 +205,7 @@ extern int os_map_memory(void *virt, int
 extern int os_protect_memory(void *addr, unsigned long len, 
 			     int r, int w, int x);
 extern int os_unmap_memory(void *addr, int len);
+extern int os_drop_memory(void *addr, int length);
 extern void os_flush_stdout(void);
 
 /* tt.c
Index: linux-2.6.16/arch/um/os-Linux/process.c
===================================================================
--- linux-2.6.16.orig/arch/um/os-Linux/process.c	2006-03-23 17:15:05.000000000 -0500
+++ linux-2.6.16/arch/um/os-Linux/process.c	2006-03-23 17:39:21.000000000 -0500
@@ -187,6 +187,20 @@ int os_unmap_memory(void *addr, int len)
         return(0);
 }
 
+#ifndef MADV_REMOVE
+#define MADV_REMOVE	0x5		/* remove these pages & resources */
+#endif
+
+int os_drop_memory(void *addr, int length)
+{
+	int err;
+
+	err = madvise(addr, length, MADV_REMOVE);
+	if(err < 0)
+		err = -errno;
+	return 0;
+}
+
 void init_new_thread_stack(void *sig_stack, void (*usr1_handler)(int))
 {
 	int flags = 0, pages;
Index: linux-2.6.16/arch/um/include/mem_user.h
===================================================================
--- linux-2.6.16.orig/arch/um/include/mem_user.h	2006-03-23 17:15:05.000000000 -0500
+++ linux-2.6.16/arch/um/include/mem_user.h	2006-03-23 17:39:21.000000000 -0500
@@ -49,7 +49,6 @@ extern int iomem_size;
 extern unsigned long host_task_size;
 extern unsigned long task_size;
 
-extern void check_devanon(void);
 extern int init_mem_user(void);
 extern void setup_memory(void *entry);
 extern unsigned long find_iomem(char *driver, unsigned long *len_out);
Index: linux-2.6.16/arch/um/os-Linux/mem.c
===================================================================
--- linux-2.6.16.orig/arch/um/os-Linux/mem.c	2006-03-23 17:15:05.000000000 -0500
+++ linux-2.6.16/arch/um/os-Linux/mem.c	2006-03-23 17:39:21.000000000 -0500
@@ -121,36 +121,11 @@ int create_tmp_file(unsigned long long l
 	return(fd);
 }
 
-static int create_anon_file(unsigned long long len)
-{
-	void *addr;
-	int fd;
-
-	fd = open("/dev/anon", O_RDWR);
-	if(fd < 0) {
-		perror("opening /dev/anon");
-		exit(1);
-	}
-
-	addr = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
-	if(addr == MAP_FAILED){
-		perror("mapping physmem file");
-		exit(1);
-	}
-	munmap(addr, len);
-
-	return(fd);
-}
-
-extern int have_devanon;
-
 int create_mem_file(unsigned long long len)
 {
 	int err, fd;
 
-	if(have_devanon)
-		fd = create_anon_file(len);
-	else fd = create_tmp_file(len);
+	fd = create_tmp_file(len);
 
 	err = os_set_exec_close(fd, 1);
 	if(err < 0){
Index: linux-2.6.16/arch/um/os-Linux/start_up.c
===================================================================
--- linux-2.6.16.orig/arch/um/os-Linux/start_up.c	2006-03-23 17:23:54.000000000 -0500
+++ linux-2.6.16/arch/um/os-Linux/start_up.c	2006-03-23 17:39:21.000000000 -0500
@@ -470,25 +470,6 @@ int can_do_skas(void)
 }
 #endif
 
-int have_devanon = 0;
-
-/* Runs on boot kernel stack - already safe to use printk. */
-
-void check_devanon(void)
-{
-	int fd;
-
-	printk("Checking for /dev/anon on the host...");
-	fd = open("/dev/anon", O_RDWR);
-	if(fd < 0){
-		printk("Not available (open failed with errno %d)\n", errno);
-		return;
-	}
-
-	printk("OK\n");
-	have_devanon = 1;
-}
-
 int __init parse_iomem(char *str, int *add)
 {
 	struct iomem_region *new;
@@ -664,6 +645,5 @@ void os_check_bugs(void)
 {
 	check_ptrace();
 	check_sigio();
-	check_devanon();
 }
 

