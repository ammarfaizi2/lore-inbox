Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbUGQWl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbUGQWl0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 18:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbUGQWjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 18:39:49 -0400
Received: from digitalimplant.org ([64.62.235.95]:48361 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262756AbUGQWfx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 18:35:53 -0400
Date: Sat, 17 Jul 2004 15:35:42 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: pavel@ucw.cz
Subject: [16/25] Merge pmdisk and swsusp
Message-ID: <Pine.LNX.4.50.0407171531100.22290-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.1858, 2004/07/17 12:46:29-07:00, mochel@digitalimplant.org

[Power Mgmt] Merge pmdisk and swsusp signature handling.

- Move struct pmdisk_header definition to swsusp and change name to struct
  swsusp_header.
- Statically allocate one (swsusp_header), and use it during mark_swapfiles()
  and when checking sig on resume.
- Move check_sig() from pmdisk to swsusp.
- Wrap with swsusp_verify(), and move check_header() there.
- Fix up calls in pmdisk and swsusp.
- Make new wrapper swsusp_close_swap() and call from write_suspend_image().
- Look for swsusp_info info in swsusp_header.swsusp_info, instead of magic
  location at end of struct.


 kernel/power/pmdisk.c |   71 +--------------------
 kernel/power/swsusp.c |  165 +++++++++++++++++++++++++-------------------------
 2 files changed, 88 insertions(+), 148 deletions(-)


diff -Nru a/kernel/power/pmdisk.c b/kernel/power/pmdisk.c
--- a/kernel/power/pmdisk.c	2004-07-17 14:50:57 -07:00
+++ b/kernel/power/pmdisk.c	2004-07-17 14:50:57 -07:00
@@ -63,15 +63,6 @@
 extern struct swsusp_info swsusp_info;


-#define PMDISK_SIG	"pmdisk-swap1"
-
-struct pmdisk_header {
-	char reserved[PAGE_SIZE - 20 - sizeof(swp_entry_t)];
-	swp_entry_t pmdisk_info;
-	char	orig_sig[10];
-	char	sig[10];
-} __attribute__((packed, aligned(PAGE_SIZE))) pmdisk_header;
-
 /*
  * XXX: We try to keep some more pages free so that I/O operations succeed
  * without paging. Might this be more?
@@ -89,35 +80,10 @@
 #define SWAPFILE_SUSPEND   1	/* This is the suspending device */
 #define SWAPFILE_IGNORED   2	/* Those are other swap devices ignored for suspension */

-extern unsigned short swapfile_used[MAX_SWAPFILES];
-extern unsigned short root_swap;
 extern int swsusp_swap_check(void);
 extern void swsusp_swap_lock(void);


-static int mark_swapfiles(swp_entry_t prev)
-{
-	int error;
-
-	rw_swap_page_sync(READ,
-			  swp_entry(root_swap, 0),
-			  virt_to_page((unsigned long)&pmdisk_header));
-	if (!memcmp("SWAP-SPACE",pmdisk_header.sig,10) ||
-	    !memcmp("SWAPSPACE2",pmdisk_header.sig,10)) {
-		memcpy(pmdisk_header.orig_sig,pmdisk_header.sig,10);
-		memcpy(pmdisk_header.sig,PMDISK_SIG,10);
-		pmdisk_header.pmdisk_info = prev;
-		error = rw_swap_page_sync(WRITE,
-					  swp_entry(root_swap, 0),
-					  virt_to_page((unsigned long)
-						       &pmdisk_header));
-	} else {
-		pr_debug("pmdisk: Partition is not swap space.\n");
-		error = -ENODEV;
-	}
-	return error;
-}
-
 extern int swsusp_write_page(unsigned long addr, swp_entry_t * entry);
 extern int swsusp_data_write(void);
 extern void swsusp_data_free(void);
@@ -156,7 +122,7 @@
 }

 extern void swsusp_init_header(void);
-extern int swsusp_write_header(swp_entry_t*);
+extern int swsusp_close_swap(void);

 /**
  *	write_suspend_image - Write entire image and metadata.
@@ -166,7 +132,6 @@
 static int write_suspend_image(void)
 {
 	int error;
-	swp_entry_t prev = { 0 };

 	swsusp_init_header();
 	if ((error = swsusp_data_write()))
@@ -175,10 +140,8 @@
 	if ((error = write_pagedir()))
 		goto FreePagedir;

-	if ((error = swsusp_write_header(&prev)))
+	if ((error = swsusp_close_swap()))
 		goto FreePagedir;
-
-	error = mark_swapfiles(prev);
  Done:
 	return error;
  FreePagedir:
@@ -227,30 +190,6 @@
 extern dev_t __init name_to_dev_t(const char *line);


-static int __init check_sig(void)
-{
-	int error;
-
-	memset(&pmdisk_header,0,sizeof(pmdisk_header));
-	if ((error = bio_read_page(0,&pmdisk_header)))
-		return error;
-	if (!memcmp(PMDISK_SIG,pmdisk_header.sig,10)) {
-		memcpy(pmdisk_header.sig,pmdisk_header.orig_sig,10);
-
-		/*
-		 * Reset swap signature now.
-		 */
-		error = bio_write_page(0,&pmdisk_header);
-	} else {
-		pr_debug(KERN_ERR "pmdisk: Invalid partition type.\n");
-		return -EINVAL;
-	}
-	if (!error)
-		pr_debug("pmdisk: Signature found, resuming\n");
-	return error;
-}
-
-
 static int __init read_pagedir(void)
 {
 	unsigned long addr;
@@ -282,13 +221,11 @@
 static int __init read_suspend_image(void)
 {
 	extern int swsusp_data_read(void);
-	extern int swsusp_check_header(swp_entry_t);
+	extern int swsusp_verify(void);

 	int error = 0;

-	if ((error = check_sig()))
-		return error;
-	if ((error = swsusp_check_header(pmdisk_header.pmdisk_info)))
+	if ((error = swsusp_verify()))
 		return error;
 	if ((error = read_pagedir()))
 		return error;
diff -Nru a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	2004-07-17 14:50:57 -07:00
+++ b/kernel/power/swsusp.c	2004-07-17 14:50:57 -07:00
@@ -111,6 +111,15 @@
 suspend_pagedir_t *pagedir_save;
 int pagedir_order __nosavedata = 0;

+#define SWSUSP_SIG	"S1SUSPEND"
+
+struct swsusp_header {
+	char reserved[PAGE_SIZE - 20 - sizeof(swp_entry_t)];
+	swp_entry_t swsusp_info;
+	char	orig_sig[10];
+	char	sig[10];
+} __attribute__((packed, aligned(PAGE_SIZE))) swsusp_header;
+
 struct swsusp_info swsusp_info;

 struct link {
@@ -161,49 +170,32 @@
 #define SWAPFILE_SUSPEND   1	/* This is the suspending device */
 #define SWAPFILE_IGNORED   2	/* Those are other swap devices ignored for suspension */

-unsigned short swapfile_used[MAX_SWAPFILES];
-unsigned short root_swap;
-#define MARK_SWAP_SUSPEND 0
-#define MARK_SWAP_RESUME 2
+static unsigned short swapfile_used[MAX_SWAPFILES];
+static unsigned short root_swap;

-static void mark_swapfiles(swp_entry_t prev, int mode)
+static int mark_swapfiles(swp_entry_t prev)
 {
-	swp_entry_t entry;
-	union diskpage *cur;
-	struct page *page;
-
-	if (root_swap == 0xFFFF)  /* ignored */
-		return;
+	int error;

-	page = alloc_page(GFP_ATOMIC);
-	if (!page)
-		panic("Out of memory in mark_swapfiles");
-	cur = page_address(page);
-	/* XXX: this is dirty hack to get first page of swap file */
-	entry = swp_entry(root_swap, 0);
-	rw_swap_page_sync(READ, entry, page);
-
-	if (mode == MARK_SWAP_RESUME) {
-	  	if (!memcmp("S1",cur->swh.magic.magic,2))
-		  	memcpy(cur->swh.magic.magic,"SWAP-SPACE",10);
-		else if (!memcmp("S2",cur->swh.magic.magic,2))
-			memcpy(cur->swh.magic.magic,"SWAPSPACE2",10);
-		else printk("%sUnable to find suspended-data signature (%.10s - misspelled?\n",
-		      	name_resume, cur->swh.magic.magic);
+	rw_swap_page_sync(READ,
+			  swp_entry(root_swap, 0),
+			  virt_to_page((unsigned long)&swsusp_header));
+	if (!memcmp("SWAP-SPACE",swsusp_header.sig,10) ||
+	    !memcmp("SWAPSPACE2",swsusp_header.sig,10)) {
+		memcpy(swsusp_header.orig_sig,swsusp_header.sig,10);
+		memcpy(swsusp_header.sig,SWSUSP_SIG,10);
+		swsusp_header.swsusp_info = prev;
+		error = rw_swap_page_sync(WRITE,
+					  swp_entry(root_swap, 0),
+					  virt_to_page((unsigned long)
+						       &swsusp_header));
 	} else {
-	  	if ((!memcmp("SWAP-SPACE",cur->swh.magic.magic,10)))
-		  	memcpy(cur->swh.magic.magic,"S1SUSP....",10);
-		else if ((!memcmp("SWAPSPACE2",cur->swh.magic.magic,10)))
-			memcpy(cur->swh.magic.magic,"S2SUSP....",10);
-		else panic("\nSwapspace is not swapspace (%.10s)\n", cur->swh.magic.magic);
-		cur->link.next = prev; /* prev is the first/last swap page of the resume area */
-		/* link.next lies *no more* in last 4/8 bytes of magic */
+		pr_debug("swsusp: Partition is not swap space.\n");
+		error = -ENODEV;
 	}
-	rw_swap_page_sync(WRITE, entry, page);
-	__free_page(page);
+	return error;
 }

-
 /*
  * Check whether the swap device is the specified resume
  * device, irrespective of whether they are specified by
@@ -400,11 +392,25 @@
  *	entrance. On exit, it contains the location of the header.
  */

-int swsusp_write_header(swp_entry_t * entry)
+static int write_header(swp_entry_t * entry)
 {
 	return swsusp_write_page((unsigned long)&swsusp_info,entry);
 }

+
+int swsusp_close_swap(void)
+{
+	swp_entry_t entry;
+	int error;
+	error = write_header(&entry);
+
+	printk( "S" );
+	if (!error)
+		error = mark_swapfiles(entry);
+	printk( "|\n" );
+	return error;
+}
+
 /**
  *    write_suspend_image - Write entire image to disk.
  *
@@ -429,6 +435,7 @@
 		return -ENOMEM;

 	swsusp_data_write();
+	swsusp_init_header();

 	printk( "Writing pagedir (%d pages): ", nr_pgdir_pages);
 	addr = (unsigned long)pagedir_nosave;
@@ -442,12 +449,8 @@
 	BUG_ON (sizeof(union diskpage) != PAGE_SIZE);
 	BUG_ON (sizeof(struct link) != PAGE_SIZE);

-	swsusp_init_header();
 	swsusp_info.pagedir[0] = entry;
-	error = swsusp_write_header(&entry);
-	printk( "S" );
-	mark_swapfiles(entry, MARK_SWAP_SUSPEND);
-	printk( "|\n" );
+	swsusp_close_swap();

 	MDELAY(1000);
 	return 0;
@@ -906,9 +909,6 @@
 	restore_highmem();
 #endif
 	device_resume();
-	PRINTK( "Fixing swap signatures... " );
-	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
-	PRINTK( "ok\n" );

 #ifdef SUSPEND_CONSOLE
 	acquire_console_sem();
@@ -1217,12 +1217,12 @@
 }


-int __init swsusp_check_header(swp_entry_t loc)
+static int __init check_header(void)
 {
 	const char * reason = NULL;
 	int error;

-	if ((error = bio_read_page(swp_offset(loc), &swsusp_info)))
+	if ((error = bio_read_page(swp_offset(swsusp_header.swsusp_info), &swsusp_info)))
 		return error;

  	/* Is this same machine? */
@@ -1234,6 +1234,38 @@
 	return error;
 }

+static int __init check_sig(void)
+{
+	int error;
+
+	memset(&swsusp_header,0,sizeof(swsusp_header));
+	if ((error = bio_read_page(0,&swsusp_header)))
+		return error;
+	if (!memcmp(SWSUSP_SIG,swsusp_header.sig,10)) {
+		memcpy(swsusp_header.sig,swsusp_header.orig_sig,10);
+
+		/*
+		 * Reset swap signature now.
+		 */
+		error = bio_write_page(0,&swsusp_header);
+	} else {
+		pr_debug(KERN_ERR "swsusp: Invalid partition type.\n");
+		return -EINVAL;
+	}
+	if (!error)
+		pr_debug("swsusp: Signature found, resuming\n");
+	return error;
+}
+
+
+int __init swsusp_verify(void)
+{
+	int error;
+
+	if (!(error = check_sig()))
+		error = check_header();
+	return error;
+}


 /**
@@ -1273,6 +1305,9 @@
 	int i, nr_pgdir_pages;
 	int error;

+	if ((error = swsusp_verify()))
+		return error;
+
 	cur = (union diskpage *)get_zeroed_page(GFP_ATOMIC);
 	if (!cur)
 		return -ENOMEM;
@@ -1282,40 +1317,8 @@
 		next.val = swp_offset(next); \
         }

-	if (bio_read_page(0, cur)) return -EIO;
-
-	if ((!memcmp("SWAP-SPACE",cur->swh.magic.magic,10)) ||
-	    (!memcmp("SWAPSPACE2",cur->swh.magic.magic,10))) {
-		printk(KERN_ERR "%sThis is normal swap space\n", name_resume );
-		return -EINVAL;
-	}
-
-	PREPARENEXT; /* We have to read next position before we overwrite it */
-
-	if (!memcmp("S1",cur->swh.magic.magic,2))
-		memcpy(cur->swh.magic.magic,"SWAP-SPACE",10);
-	else if (!memcmp("S2",cur->swh.magic.magic,2))
-		memcpy(cur->swh.magic.magic,"SWAPSPACE2",10);
-	else {
-		if (noresume)
-			return -EINVAL;
-		panic("%sUnable to find suspended-data signature (%.10s - misspelled?\n",
-			name_resume, cur->swh.magic.magic);
-	}
-	if (noresume) {
-		/* We don't do a sanity check here: we want to restore the swap
-		   whatever version of kernel made the suspend image;
-		   We need to write swap, but swap is *not* enabled so
-		   we must write the device directly */
-		printk("%s: Fixing swap signatures %s...\n", name_resume, resume_file);
-		bio_write_page(0, cur);
-	}
-
-	printk( "%sSignature found, resuming\n", name_resume );
-	MDELAY(1000);
-
-	if ((error = swsusp_check_header(next)))
-		return error;
+	if (noresume)
+		return 0;

 	next = swsusp_info.pagedir[0];
 	next.val = swp_offset(next);
