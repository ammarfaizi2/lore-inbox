Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265247AbUGQXDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265247AbUGQXDH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 19:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265253AbUGQXB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 19:01:56 -0400
Received: from digitalimplant.org ([64.62.235.95]:42985 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262730AbUGQWfk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 18:35:40 -0400
Date: Sat, 17 Jul 2004 15:35:30 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: pavel@ucw.cz
Subject: [14/25] Merge pmdisk and swsusp
Message-ID: <Pine.LNX.4.50.0407171530410.22290-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.1856, 2004/07/17 12:23:27-07:00, mochel@digitalimplant.org

[Power Mgmt] Merge swsusp and pmdisk info headers.

- Move definition of struct pmdsik_info to power.h and rename to struct
  swsusp_info.
- Kill struct suspend_header.
- Move helpers from pmdisk into swsusp: init_header(), dump_info(),
  write_header(), sanity_check(), check_header().
- Fix up calls in pmdisk to call the right ones.
- Clean up swsusp code to use helpers; delete duplicates.


 include/linux/suspend.h |   10 --
 kernel/power/pmdisk.c   |  131 +++--------------------------------
 kernel/power/power.h    |   16 ++++
 kernel/power/swsusp.c   |  175 +++++++++++++++++++++++++++++-------------------
 4 files changed, 135 insertions(+), 197 deletions(-)


diff -Nru a/include/linux/suspend.h b/include/linux/suspend.h
--- a/include/linux/suspend.h	2004-07-17 14:51:05 -07:00
+++ b/include/linux/suspend.h	2004-07-17 14:51:05 -07:00
@@ -23,16 +23,6 @@

 #define SWAP_FILENAME_MAXLENGTH	32

-struct suspend_header {
-	u32 version_code;
-	unsigned long num_physpages;
-	char machine[8];
-	char version[20];
-	int num_cpus;
-	int page_size;
-	suspend_pagedir_t *suspend_pagedir;
-	unsigned int num_pbes;
-};

 #define SUSPEND_PD_PAGES(x)     (((x)*sizeof(struct pbe))/PAGE_SIZE+1)

diff -Nru a/kernel/power/pmdisk.c b/kernel/power/pmdisk.c
--- a/kernel/power/pmdisk.c	2004-07-17 14:51:05 -07:00
+++ b/kernel/power/pmdisk.c	2004-07-17 14:51:05 -07:00
@@ -28,7 +28,6 @@
 #include <linux/device.h>
 #include <linux/swapops.h>
 #include <linux/bootmem.h>
-#include <linux/utsname.h>

 #include <asm/mmu_context.h>

@@ -61,17 +60,7 @@
 extern suspend_pagedir_t *pagedir_save;
 extern int pagedir_order;

-
-struct pmdisk_info {
-	struct new_utsname	uts;
-	u32			version_code;
-	unsigned long		num_physpages;
-	int			cpus;
-	unsigned long		image_pages;
-	unsigned long		pagedir_pages;
-	swp_entry_t		pagedir[768];
-} __attribute__((aligned(PAGE_SIZE))) pmdisk_info;
-
+extern struct swsusp_info swsusp_info;


 #define PMDISK_SIG	"pmdisk-swap1"
@@ -139,11 +128,11 @@

 static void free_pagedir_entries(void)
 {
-	int num = pmdisk_info.pagedir_pages;
+	int num = swsusp_info.pagedir_pages;
 	int i;

 	for (i = 0; i < num; i++)
-		swap_free(pmdisk_info.pagedir[i]);
+		swap_free(swsusp_info.pagedir[i]);
 }


@@ -159,64 +148,15 @@
 	int n = SUSPEND_PD_PAGES(nr_copy_pages);
 	int i;

-	pmdisk_info.pagedir_pages = n;
+	swsusp_info.pagedir_pages = n;
 	printk( "Writing pagedir (%d pages)\n", n);
 	for (i = 0; i < n && !error; i++, addr += PAGE_SIZE)
-		error = swsusp_write_page(addr,&pmdisk_info.pagedir[i]);
+		error = swsusp_write_page(addr,&swsusp_info.pagedir[i]);
 	return error;
 }

-
-#ifdef DEBUG
-static void dump_pmdisk_info(void)
-{
-	printk(" pmdisk: Version: %u\n",pmdisk_info.version_code);
-	printk(" pmdisk: Num Pages: %ld\n",pmdisk_info.num_physpages);
-	printk(" pmdisk: UTS Sys: %s\n",pmdisk_info.uts.sysname);
-	printk(" pmdisk: UTS Node: %s\n",pmdisk_info.uts.nodename);
-	printk(" pmdisk: UTS Release: %s\n",pmdisk_info.uts.release);
-	printk(" pmdisk: UTS Version: %s\n",pmdisk_info.uts.version);
-	printk(" pmdisk: UTS Machine: %s\n",pmdisk_info.uts.machine);
-	printk(" pmdisk: UTS Domain: %s\n",pmdisk_info.uts.domainname);
-	printk(" pmdisk: CPUs: %d\n",pmdisk_info.cpus);
-	printk(" pmdisk: Image: %ld Pages\n",pmdisk_info.image_pages);
-	printk(" pmdisk: Pagedir: %ld Pages\n",pmdisk_info.pagedir_pages);
-}
-#else
-static void dump_pmdisk_info(void)
-{
-
-}
-#endif
-
-static void init_header(void)
-{
-	memset(&pmdisk_info,0,sizeof(pmdisk_info));
-	pmdisk_info.version_code = LINUX_VERSION_CODE;
-	pmdisk_info.num_physpages = num_physpages;
-	memcpy(&pmdisk_info.uts,&system_utsname,sizeof(system_utsname));
-
-	pmdisk_info.cpus = num_online_cpus();
-	pmdisk_info.image_pages = nr_copy_pages;
-	dump_pmdisk_info();
-}
-
-/**
- *	write_header - Fill and write the suspend header.
- *	@entry:	Location of the last swap entry used.
- *
- *	Allocate a page, fill header, write header.
- *
- *	@entry is the location of the last pagedir entry written on
- *	entrance. On exit, it contains the location of the header.
- */
-
-static int write_header(swp_entry_t * entry)
-{
-	return swsusp_write_page((unsigned long)&pmdisk_info,entry);
-}
-
-
+extern void swsusp_init_header(void);
+extern int swsusp_write_header(swp_entry_t*);

 /**
  *	write_suspend_image - Write entire image and metadata.
@@ -228,13 +168,14 @@
 	int error;
 	swp_entry_t prev = { 0 };

+	swsusp_init_header();
 	if ((error = swsusp_data_write()))
 		goto FreeData;

 	if ((error = write_pagedir()))
 		goto FreePagedir;

-	if ((error = write_header(&prev)))
+	if ((error = swsusp_write_header(&prev)))
 		goto FreePagedir;

 	error = mark_swapfiles(prev);
@@ -310,57 +251,10 @@
 }


-/*
- * Sanity check if this image makes sense with this kernel/swap context
- * I really don't think that it's foolproof but more than nothing..
- */
-
-static const char * __init sanity_check(void)
-{
-	dump_pmdisk_info();
-	if(pmdisk_info.version_code != LINUX_VERSION_CODE)
-		return "kernel version";
-	if(pmdisk_info.num_physpages != num_physpages)
-		return "memory size";
-	if (strcmp(pmdisk_info.uts.sysname,system_utsname.sysname))
-		return "system type";
-	if (strcmp(pmdisk_info.uts.release,system_utsname.release))
-		return "kernel release";
-	if (strcmp(pmdisk_info.uts.version,system_utsname.version))
-		return "version";
-	if (strcmp(pmdisk_info.uts.machine,system_utsname.machine))
-		return "machine";
-	if(pmdisk_info.cpus != num_online_cpus())
-		return "number of cpus";
-	return NULL;
-}
-
-
-static int __init check_header(void)
-{
-	const char * reason = NULL;
-	int error;
-
-	init_header();
-
-	if ((error = bio_read_page(swp_offset(pmdisk_header.pmdisk_info),
-			       &pmdisk_info)))
-		return error;
-
- 	/* Is this same machine? */
-	if ((reason = sanity_check())) {
-		printk(KERN_ERR "pmdisk: Resume mismatch: %s\n",reason);
-		return -EPERM;
-	}
-	nr_copy_pages = pmdisk_info.image_pages;
-	return error;
-}
-
-
 static int __init read_pagedir(void)
 {
 	unsigned long addr;
-	int i, n = pmdisk_info.pagedir_pages;
+	int i, n = swsusp_info.pagedir_pages;
 	int error = 0;

 	pagedir_order = get_bitmask_order(n);
@@ -373,7 +267,7 @@
 	pr_debug("pmdisk: Reading pagedir (%d Pages)\n",n);

 	for (i = 0; i < n && !error; i++, addr += PAGE_SIZE) {
-		unsigned long offset = swp_offset(pmdisk_info.pagedir[i]);
+		unsigned long offset = swp_offset(swsusp_info.pagedir[i]);
 		if (offset)
 			error = bio_read_page(offset, (void *)addr);
 		else
@@ -388,12 +282,13 @@
 static int __init read_suspend_image(void)
 {
 	extern int swsusp_data_read(void);
+	extern int swsusp_check_header(swp_entry_t);

 	int error = 0;

 	if ((error = check_sig()))
 		return error;
-	if ((error = check_header()))
+	if ((error = swsusp_check_header(pmdisk_header.pmdisk_info)))
 		return error;
 	if ((error = read_pagedir()))
 		return error;
diff -Nru a/kernel/power/power.h b/kernel/power/power.h
--- a/kernel/power/power.h	2004-07-17 14:51:05 -07:00
+++ b/kernel/power/power.h	2004-07-17 14:51:05 -07:00
@@ -1,4 +1,5 @@
-
+#include <linux/suspend.h>
+#include <linux/utsname.h>

 /* With SUSPEND_CONSOLE defined, it suspend looks *really* cool, but
    we probably do not take enough locks for switching consoles, etc,
@@ -7,6 +8,19 @@
 #if defined(CONFIG_VT) && defined(CONFIG_VT_CONSOLE)
 #define SUSPEND_CONSOLE	(MAX_NR_CONSOLES-1)
 #endif
+
+
+struct swsusp_info {
+	struct new_utsname	uts;
+	u32			version_code;
+	unsigned long		num_physpages;
+	int			cpus;
+	unsigned long		image_pages;
+	unsigned long		pagedir_pages;
+	suspend_pagedir_t	* suspend_pagedir;
+	swp_entry_t		pagedir[768];
+} __attribute__((aligned(PAGE_SIZE)));
+


 #ifdef CONFIG_PM_DISK
diff -Nru a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	2004-07-17 14:51:05 -07:00
+++ b/kernel/power/swsusp.c	2004-07-17 14:51:05 -07:00
@@ -111,6 +111,8 @@
 suspend_pagedir_t *pagedir_save;
 int pagedir_order __nosavedata = 0;

+struct swsusp_info swsusp_info;
+
 struct link {
 	char dummy[PAGE_SIZE - sizeof(swp_entry_t)];
 	swp_entry_t next;
@@ -119,7 +121,6 @@
 union diskpage {
 	union swap_header swh;
 	struct link link;
-	struct suspend_header sh;
 };

 /*
@@ -155,27 +156,6 @@
  * Saving part...
  */

-static __inline__ int fill_suspend_header(struct suspend_header *sh)
-{
-	memset((char *)sh, 0, sizeof(*sh));
-
-	sh->version_code = LINUX_VERSION_CODE;
-	sh->num_physpages = num_physpages;
-	strncpy(sh->machine, system_utsname.machine, 8);
-	strncpy(sh->version, system_utsname.version, 20);
-	/* FIXME: Is this bogus? --RR */
-	sh->num_cpus = num_online_cpus();
-	sh->page_size = PAGE_SIZE;
-	sh->suspend_pagedir = pagedir_nosave;
-	BUG_ON (pagedir_save != pagedir_nosave);
-	sh->num_pbes = nr_copy_pages;
-	/* TODO: needed? mounted fs' last mounted date comparison
-	 * [so they haven't been mounted since last suspend.
-	 * Maybe it isn't.] [we'd need to do this for _all_ fs-es]
-	 */
-	return 0;
-}
-
 /* We memorize in swapfile_used what swap devices are used for suspension */
 #define SWAPFILE_UNUSED    0
 #define SWAPFILE_SUSPEND   1	/* This is the suspending device */
@@ -375,7 +355,55 @@
 	return error;
 }

+#ifdef DEBUG
+static void dump_info(void)
+{
+	printk(" swsusp: Version: %u\n",swsusp_info.version_code);
+	printk(" swsusp: Num Pages: %ld\n",swsusp_info.num_physpages);
+	printk(" swsusp: UTS Sys: %s\n",swsusp_info.uts.sysname);
+	printk(" swsusp: UTS Node: %s\n",swsusp_info.uts.nodename);
+	printk(" swsusp: UTS Release: %s\n",swsusp_info.uts.release);
+	printk(" swsusp: UTS Version: %s\n",swsusp_info.uts.version);
+	printk(" swsusp: UTS Machine: %s\n",swsusp_info.uts.machine);
+	printk(" swsusp: UTS Domain: %s\n",swsusp_info.uts.domainname);
+	printk(" swsusp: CPUs: %d\n",swsusp_info.cpus);
+	printk(" swsusp: Image: %ld Pages\n",swsusp_info.image_pages);
+	printk(" swsusp: Pagedir: %ld Pages\n",swsusp_info.pagedir_pages);
+}
+#else
+static void dump_info(void)
+{
+
+}
+#endif

+void swsusp_init_header(void)
+{
+	memset(&swsusp_info,0,sizeof(swsusp_info));
+	swsusp_info.version_code = LINUX_VERSION_CODE;
+	swsusp_info.num_physpages = num_physpages;
+	memcpy(&swsusp_info.uts,&system_utsname,sizeof(system_utsname));
+
+	swsusp_info.suspend_pagedir = pagedir_nosave;
+	swsusp_info.cpus = num_online_cpus();
+	swsusp_info.image_pages = nr_copy_pages;
+	dump_info();
+}
+
+/**
+ *	write_header - Fill and write the suspend header.
+ *	@entry:	Location of the last swap entry used.
+ *
+ *	Allocate a page, fill header, write header.
+ *
+ *	@entry is the location of the last pagedir entry written on
+ *	entrance. On exit, it contains the location of the header.
+ */
+
+int swsusp_write_header(swp_entry_t * entry)
+{
+	return swsusp_write_page((unsigned long)&swsusp_info,entry);
+}

 /**
  *    write_suspend_image - Write entire image to disk.
@@ -411,17 +439,12 @@
 		error = swsusp_write_page(addr,&entry);
 	}
 	printk("H");
-	BUG_ON (sizeof(struct suspend_header) > PAGE_SIZE-sizeof(swp_entry_t));
 	BUG_ON (sizeof(union diskpage) != PAGE_SIZE);
 	BUG_ON (sizeof(struct link) != PAGE_SIZE);

-	cur = (void *) buffer;
-	if (fill_suspend_header(&cur->sh))
-		BUG();		/* Not a BUG_ON(): we want fill_suspend_header to be called, always */
-
-	cur->link.next = entry;
-	if ((error = swsusp_write_page((unsigned long)cur,&entry)))
-		return error;
+	swsusp_init_header();
+	swsusp_info.pagedir[0] = entry;
+	error = swsusp_write_header(&entry);
 	printk( "S" );
 	mark_swapfiles(entry, MARK_SWAP_SUSPEND);
 	printk( "|\n" );
@@ -734,7 +757,7 @@
 static int enough_free_mem(void)
 {
 	if(nr_free_pages() < (nr_copy_pages + PAGES_FOR_IO)) {
-		pr_debug("pmdisk: Not enough free pages: Have %d\n",
+		pr_debug("swsusp: Not enough free pages: Have %d\n",
 			 nr_free_pages());
 		return 0;
 	}
@@ -758,7 +781,7 @@

 	si_swapinfo(&i);
 	if (i.freeswap < (nr_copy_pages + PAGES_FOR_IO))  {
-		pr_debug("pmdisk: Not enough swap. Need %ld\n",i.freeswap);
+		pr_debug("swsusp: Not enough swap. Need %ld\n",i.freeswap);
 		return 0;
 	}
 	return 1;
@@ -1087,35 +1110,6 @@
 	return check_pagedir();
 }

-/*
- * Sanity check if this image makes sense with this kernel/swap context
- * I really don't think that it's foolproof but more than nothing..
- */
-
-static int sanity_check_failed(char *reason)
-{
-	printk(KERN_ERR "%s%s\n", name_resume, reason);
-	return -EPERM;
-}
-
-static int sanity_check(struct suspend_header *sh)
-{
-	if (sh->version_code != LINUX_VERSION_CODE)
-		return sanity_check_failed("Incorrect kernel version");
-	if (sh->num_physpages != num_physpages)
-		return sanity_check_failed("Incorrect memory size");
-	if (strncmp(sh->machine, system_utsname.machine, 8))
-		return sanity_check_failed("Incorrect machine type");
-	if (strncmp(sh->version, system_utsname.version, 20))
-		return sanity_check_failed("Incorrect version");
-	if (sh->num_cpus != num_online_cpus())
-		return sanity_check_failed("Incorrect number of cpus");
-	if (sh->page_size != PAGE_SIZE)
-		return sanity_check_failed("Incorrect PAGE_SIZE");
-	return 0;
-}
-
-
 /**
  *	Using bio to read from swap.
  *	This code requires a bit more work than just using buffer heads
@@ -1172,7 +1166,7 @@
 	bio->bi_end_io = end_io;

 	if (bio_add_page(bio, virt_to_page(page), PAGE_SIZE, 0) < PAGE_SIZE) {
-		printk("pmdisk: ERROR: adding page to bio at %ld\n",page_off);
+		printk("swsusp: ERROR: adding page to bio at %ld\n",page_off);
 		error = -EFAULT;
 		goto Done;
 	}
@@ -1197,6 +1191,50 @@
 	return submit(WRITE,page_off,page);
 }

+/*
+ * Sanity check if this image makes sense with this kernel/swap context
+ * I really don't think that it's foolproof but more than nothing..
+ */
+
+static const char * __init sanity_check(void)
+{
+	dump_info();
+	if(swsusp_info.version_code != LINUX_VERSION_CODE)
+		return "kernel version";
+	if(swsusp_info.num_physpages != num_physpages)
+		return "memory size";
+	if (strcmp(swsusp_info.uts.sysname,system_utsname.sysname))
+		return "system type";
+	if (strcmp(swsusp_info.uts.release,system_utsname.release))
+		return "kernel release";
+	if (strcmp(swsusp_info.uts.version,system_utsname.version))
+		return "version";
+	if (strcmp(swsusp_info.uts.machine,system_utsname.machine))
+		return "machine";
+	if(swsusp_info.cpus != num_online_cpus())
+		return "number of cpus";
+	return NULL;
+}
+
+
+int __init swsusp_check_header(swp_entry_t loc)
+{
+	const char * reason = NULL;
+	int error;
+
+	if ((error = bio_read_page(swp_offset(loc), &swsusp_info)))
+		return error;
+
+ 	/* Is this same machine? */
+	if ((reason = sanity_check())) {
+		printk(KERN_ERR "swsusp: Resume mismatch: %s\n",reason);
+		return -EPERM;
+	}
+	nr_copy_pages = swsusp_info.image_pages;
+	return error;
+}
+
+

 /**
  *	swsusp_read_data - Read image pages from swap.
@@ -1276,13 +1314,14 @@
 	printk( "%sSignature found, resuming\n", name_resume );
 	MDELAY(1000);

-	if (bio_read_page(next.val, cur)) return -EIO;
-	if (sanity_check(&cur->sh)) 	/* Is this same machine? */
-		return -EPERM;
-	PREPARENEXT;
+	if ((error = swsusp_check_header(next)))
+		return error;
+
+	next = swsusp_info.pagedir[0];
+	next.val = swp_offset(next);

-	pagedir_save = cur->sh.suspend_pagedir;
-	nr_copy_pages = cur->sh.num_pbes;
+	pagedir_save = swsusp_info.suspend_pagedir;
+	nr_copy_pages = swsusp_info.image_pages;
 	nr_pgdir_pages = SUSPEND_PD_PAGES(nr_copy_pages);
 	pagedir_order = get_bitmask_order(nr_pgdir_pages);

