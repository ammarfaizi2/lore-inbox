Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbVJ2Uy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbVJ2Uy5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 16:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVJ2Uy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 16:54:57 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:5551 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932198AbVJ2Uyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 16:54:44 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: [RFC][PATCH 5/6] swsusp: move swap-handling functions to separate file
Date: Sat, 29 Oct 2005 22:41:04 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@osdl.org
References: <200510292158.11089.rjw@sisk.pl>
In-Reply-To: <200510292158.11089.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510292241.05312.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to show that the swap-handling part of swsusp is really independent
and it can be moved entirely to a separate file.  It introduces the file swap.c
containing all of the swap-handling code.

After the change swsusp.c contains the functions that in my opinion do not
belong to either the snapshot-handling part or the swap-handling part
(swsusp_suspend(), swsusp_resume() and the functions related to highmem).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 kernel/power/Makefile   |    2 
 kernel/power/power.h    |    2 
 kernel/power/snapshot.c |   93 ----
 kernel/power/swap.c     |  915 +++++++++++++++++++++++++++++++++++++++++++++++
 kernel/power/swsusp.c   |  923 +++---------------------------------------------
 5 files changed, 988 insertions(+), 947 deletions(-)

Index: linux-2.6.14-rc5-mm1/kernel/power/Makefile
===================================================================
--- linux-2.6.14-rc5-mm1.orig/kernel/power/Makefile	2005-10-29 13:23:31.000000000 +0200
+++ linux-2.6.14-rc5-mm1/kernel/power/Makefile	2005-10-29 13:26:26.000000000 +0200
@@ -4,7 +4,7 @@
 endif
 
 obj-y				:= main.o process.o console.o pm.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o snapshot.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o snapshot.o swap.o
 
 obj-$(CONFIG_SUSPEND_SMP)	+= smp.o
 
Index: linux-2.6.14-rc5-mm1/kernel/power/power.h
===================================================================
--- linux-2.6.14-rc5-mm1.orig/kernel/power/power.h	2005-10-29 13:24:58.000000000 +0200
+++ linux-2.6.14-rc5-mm1/kernel/power/power.h	2005-10-29 13:26:26.000000000 +0200
@@ -58,8 +58,6 @@
 extern asmlinkage int swsusp_arch_suspend(void);
 extern asmlinkage int swsusp_arch_resume(void);
 
-extern int save_highmem(void);
-extern int restore_highmem(void);
 extern void swsusp_free(void);
 
 extern unsigned snapshot_pages_to_save(void);
Index: linux-2.6.14-rc5-mm1/kernel/power/swap.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.14-rc5-mm1/kernel/power/swap.c	2005-10-29 13:26:26.000000000 +0200
@@ -0,0 +1,915 @@
+/*
+ * linux/kernel/power/snapshot.c
+ *
+ * This file provides the swap writing/reading functionality.
+ *
+ * Copyright (C) 1998-2005 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 2005 Rafael J. Wysocki <rjw@sisk.pl>
+ *
+ * This file is released under the GPLv2, and is based on swsusp.c.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/suspend.h>
+#include <linux/smp_lock.h>
+#include <linux/file.h>
+#include <linux/utsname.h>
+#include <linux/version.h>
+#include <linux/delay.h>
+#include <linux/bitops.h>
+#include <linux/spinlock.h>
+#include <linux/genhd.h>
+#include <linux/kernel.h>
+#include <linux/major.h>
+#include <linux/swap.h>
+#include <linux/pm.h>
+#include <linux/device.h>
+#include <linux/buffer_head.h>
+#include <linux/swapops.h>
+#include <linux/bootmem.h>
+#include <linux/syscalls.h>
+#include <linux/highmem.h>
+#include <linux/bio.h>
+
+#include <asm/uaccess.h>
+#include <asm/mmu_context.h>
+#include <asm/pgtable.h>
+#include <asm/tlbflush.h>
+#include <asm/io.h>
+
+#include <linux/random.h>
+#include <linux/crypto.h>
+#include <asm/scatterlist.h>
+
+#include "power.h"
+
+#define CIPHER "aes"
+#define MAXKEY 32
+#define MAXIV  32
+
+extern char resume_file[];
+
+
+#define SWSUSP_SIG	"S1SUSPEND"
+
+static struct swsusp_header {
+	char reserved[PAGE_SIZE - 20 - MAXKEY - MAXIV - sizeof(swp_entry_t)];
+	u8 key_iv[MAXKEY+MAXIV];
+	swp_entry_t swsusp_info;
+	char	orig_sig[10];
+	char	sig[10];
+} __attribute__((packed, aligned(PAGE_SIZE))) swsusp_header;
+
+static struct swsusp_info swsusp_info;
+
+/*
+ * Saving part...
+ */
+
+/* We memorize in swapfile_used what swap devices are used for suspension */
+#define SWAPFILE_UNUSED    0
+#define SWAPFILE_SUSPEND   1	/* This is the suspending device */
+#define SWAPFILE_IGNORED   2	/* Those are other swap devices ignored for suspension */
+
+static unsigned short swapfile_used[MAX_SWAPFILES];
+static unsigned short root_swap;
+
+static int write_page(unsigned long addr, swp_entry_t * loc);
+static int bio_read_page(pgoff_t page_off, void * page);
+
+static u8 key_iv[MAXKEY+MAXIV];
+
+#ifdef CONFIG_SWSUSP_ENCRYPT
+
+static int crypto_init(int mode, void **mem)
+{
+	int error = 0;
+	int len;
+	char *modemsg;
+	struct crypto_tfm *tfm;
+
+	modemsg = mode ? "suspend not possible" : "resume not possible";
+
+	tfm = crypto_alloc_tfm(CIPHER, CRYPTO_TFM_MODE_CBC);
+	if(!tfm) {
+		printk(KERN_ERR "swsusp: no tfm, %s\n", modemsg);
+		error = -EINVAL;
+		goto out;
+	}
+
+	if(MAXKEY < crypto_tfm_alg_min_keysize(tfm)) {
+		printk(KERN_ERR "swsusp: key buffer too small, %s\n", modemsg);
+		error = -ENOKEY;
+		goto fail;
+	}
+
+	if (mode)
+		get_random_bytes(key_iv, MAXKEY+MAXIV);
+
+	len = crypto_tfm_alg_max_keysize(tfm);
+	if (len > MAXKEY)
+		len = MAXKEY;
+
+	if (crypto_cipher_setkey(tfm, key_iv, len)) {
+		printk(KERN_ERR "swsusp: key setup failure, %s\n", modemsg);
+		error = -EKEYREJECTED;
+		goto fail;
+	}
+
+	len = crypto_tfm_alg_ivsize(tfm);
+
+	if (MAXIV < len) {
+		printk(KERN_ERR "swsusp: iv buffer too small, %s\n", modemsg);
+		error = -EOVERFLOW;
+		goto fail;
+	}
+
+	crypto_cipher_set_iv(tfm, key_iv+MAXKEY, len);
+
+	*mem=(void *)tfm;
+
+	goto out;
+
+fail:	crypto_free_tfm(tfm);
+out:	return error;
+}
+
+static __inline__ void crypto_exit(void *mem)
+{
+	crypto_free_tfm((struct crypto_tfm *)mem);
+}
+
+static __inline__ int crypto_write(unsigned long addr, swp_entry_t *entry, void *mem)
+{
+	int error = 0;
+	struct scatterlist src, dst;
+
+	src.page   = virt_to_page((void *)addr);
+	src.offset = 0;
+	src.length = PAGE_SIZE;
+	dst.page   = virt_to_page((void *)&swsusp_header);
+	dst.offset = 0;
+	dst.length = PAGE_SIZE;
+
+	error = crypto_cipher_encrypt((struct crypto_tfm *)mem, &dst, &src,
+					PAGE_SIZE);
+
+	if (!error)
+		error = write_page((unsigned long)&swsusp_header, entry);
+	return error;
+}
+
+static __inline__ int crypto_read(unsigned long offset, void *buf, void *mem)
+{
+	int error = 0;
+	struct scatterlist src, dst;
+
+	error = bio_read_page(offset, buf);
+	if (!error) {
+		src.offset = 0;
+		src.length = PAGE_SIZE;
+		dst.offset = 0;
+		dst.length = PAGE_SIZE;
+		src.page = dst.page = virt_to_page(buf);
+
+		error = crypto_cipher_decrypt((struct crypto_tfm *)mem, &dst,
+						&src, PAGE_SIZE);
+	}
+	return error;
+}
+#else
+static __inline__ int crypto_init(int mode, void *mem)
+{
+	return 0;
+}
+
+static __inline__ void crypto_exit(void *mem)
+{
+}
+
+static __inline__ int crypto_write(unsigned long addr, swp_entry_t *entry, void *mem)
+{
+	return write_page(addr, entry);
+}
+
+static __inline__ int crypto_read(unsigned long offset, void *buf, void *mem)
+{
+	return bio_read_page(offset, buf);
+}
+#endif
+
+static int mark_swapfiles(swp_entry_t prev)
+{
+	int error;
+
+	rw_swap_page_sync(READ,
+			  swp_entry(root_swap, 0),
+			  virt_to_page((unsigned long)&swsusp_header));
+	if (!memcmp("SWAP-SPACE",swsusp_header.sig, 10) ||
+	    !memcmp("SWAPSPACE2",swsusp_header.sig, 10)) {
+		memcpy(swsusp_header.orig_sig,swsusp_header.sig, 10);
+		memcpy(swsusp_header.sig,SWSUSP_SIG, 10);
+		memcpy(swsusp_header.key_iv, key_iv, MAXKEY+MAXIV);
+		swsusp_header.swsusp_info = prev;
+		error = rw_swap_page_sync(WRITE,
+					  swp_entry(root_swap, 0),
+					  virt_to_page((unsigned long)
+						       &swsusp_header));
+	} else {
+		pr_debug("swsusp: Partition is not swap space.\n");
+		error = -ENODEV;
+	}
+	return error;
+}
+
+/*
+ * Check whether the swap device is the specified resume
+ * device, irrespective of whether they are specified by
+ * identical names.
+ *
+ * (Thus, device inode aliasing is allowed.  You can say /dev/hda4
+ * instead of /dev/ide/host0/bus0/target0/lun0/part4 [if using devfs]
+ * and they'll be considered the same device.  This is *necessary* for
+ * devfs, since the resume code can only recognize the form /dev/hda4,
+ * but the suspend code would see the long name.)
+ */
+static int is_resume_device(const struct swap_info_struct *swap_info)
+{
+	struct file *file = swap_info->swap_file;
+	struct inode *inode = file->f_dentry->d_inode;
+
+	return S_ISBLK(inode->i_mode) &&
+		swsusp_resume_device == MKDEV(imajor(inode), iminor(inode));
+}
+
+static int swsusp_swap_check(void) /* This is called before saving image */
+{
+	int i, len;
+
+	len=strlen(resume_file);
+	root_swap = 0xFFFF;
+
+	spin_lock(&swap_lock);
+	for (i=0; i<MAX_SWAPFILES; i++) {
+		if (!(swap_info[i].flags & SWP_WRITEOK)) {
+			swapfile_used[i]=SWAPFILE_UNUSED;
+		} else {
+			if (!len) {
+	    			printk(KERN_WARNING "resume= option should be used to set suspend device" );
+				if (root_swap == 0xFFFF) {
+					swapfile_used[i] = SWAPFILE_SUSPEND;
+					root_swap = i;
+				} else
+					swapfile_used[i] = SWAPFILE_IGNORED;
+			} else {
+	  			/* we ignore all swap devices that are not the resume_file */
+				if (is_resume_device(&swap_info[i])) {
+					swapfile_used[i] = SWAPFILE_SUSPEND;
+					root_swap = i;
+				} else {
+				  	swapfile_used[i] = SWAPFILE_IGNORED;
+				}
+			}
+		}
+	}
+	spin_unlock(&swap_lock);
+	return (root_swap != 0xffff) ? 0 : -ENODEV;
+}
+
+/**
+ * This is called after saving image so modification
+ * will be lost after resume... and that's what we want.
+ * we make the device unusable. A new call to
+ * lock_swapdevices can unlock the devices.
+ */
+static void lock_swapdevices(void)
+{
+	int i;
+
+	spin_lock(&swap_lock);
+	for (i = 0; i< MAX_SWAPFILES; i++)
+		if (swapfile_used[i] == SWAPFILE_IGNORED) {
+			swap_info[i].flags ^= SWP_WRITEOK;
+		}
+	spin_unlock(&swap_lock);
+}
+
+/**
+ *	write_page - Write one page to a fresh swap location.
+ *	@addr:	Address we're writing.
+ *	@loc:	Place to store the entry we used.
+ *
+ *	Allocate a new swap entry and 'sync' it. Note we discard -EIO
+ *	errors. That is an artifact left over from swsusp. It did not
+ *	check the return of rw_swap_page_sync() at all, since most pages
+ *	written back to swap would return -EIO.
+ *	This is a partial improvement, since we will at least return other
+ *	errors, though we need to eventually fix the damn code.
+ */
+static int write_page(unsigned long addr, swp_entry_t * loc)
+{
+	swp_entry_t entry;
+	int error = 0;
+
+	entry = get_swap_page();
+	if (swp_offset(entry) &&
+	    swapfile_used[swp_type(entry)] == SWAPFILE_SUSPEND) {
+		error = rw_swap_page_sync(WRITE, entry,
+					  virt_to_page(addr));
+		if (error == -EIO)
+			error = 0;
+		if (!error)
+			*loc = entry;
+	} else
+		error = -ENOSPC;
+	return error;
+}
+
+static void dump_info(void)
+{
+	pr_debug(" swsusp: Version: %u\n",swsusp_info.version_code);
+	pr_debug(" swsusp: Num Pages: %ld\n",swsusp_info.num_physpages);
+	pr_debug(" swsusp: UTS Sys: %s\n",swsusp_info.uts.sysname);
+	pr_debug(" swsusp: UTS Node: %s\n",swsusp_info.uts.nodename);
+	pr_debug(" swsusp: UTS Release: %s\n",swsusp_info.uts.release);
+	pr_debug(" swsusp: UTS Version: %s\n",swsusp_info.uts.version);
+	pr_debug(" swsusp: UTS Machine: %s\n",swsusp_info.uts.machine);
+	pr_debug(" swsusp: UTS Domain: %s\n",swsusp_info.uts.domainname);
+	pr_debug(" swsusp: CPUs: %d\n",swsusp_info.cpus);
+	pr_debug(" swsusp: Image: %ld Pages\n",swsusp_info.image_pages);
+	pr_debug(" swsusp: Total: %ld Pages\n", swsusp_info.pages);
+}
+
+static void init_header(unsigned nr_pages, unsigned img_pages)
+{
+	memset(&swsusp_info, 0, sizeof(swsusp_info));
+	swsusp_info.version_code = LINUX_VERSION_CODE;
+	swsusp_info.num_physpages = num_physpages;
+	memcpy(&swsusp_info.uts, &system_utsname, sizeof(system_utsname));
+
+	swsusp_info.cpus = num_online_cpus();
+	swsusp_info.image_pages = img_pages;
+	swsusp_info.pages = nr_pages;
+}
+
+static int close_swap(void)
+{
+	swp_entry_t entry;
+	int error;
+
+	dump_info();
+	error = write_page((unsigned long)&swsusp_info, &entry);
+	if (!error) {
+		printk( "S" );
+		error = mark_swapfiles(entry);
+		printk( "|\n" );
+	}
+	return error;
+}
+
+/**
+ *	Swap map handling functions
+ *
+ *	The swap map is a data structure used for keeping track of each page
+ *	written to the swap.  It consists of many swp_map_page structures
+ *	that contain each an array of MAP_PAGE_SIZE swap entries.
+ *	These structures are linked together with the help of either the
+ *	.next (in memory) or the .next_swp (in swap) member.
+ *
+ *	The swap map is created during suspend.  At that time we need to keep
+ *	it in memory, because we have to free all of the allocated swap
+ *	entries if an error occurs.  The memory needed is preallocated
+ *	so that we know in advance if there's enough of it.
+ *
+ *	The first swp_map_page structure is filled with the swap entries that
+ *	correspond to the first MAP_PAGE_SIZE data pages written to swap and
+ *	so on.  After the all of the data pages have been written, the order
+ *	of the swp_map_page structures in the map is reversed so that they
+ *	can be read from swap in the original order.  This causes the data
+ *	pages to be loaded in exactly the same order in which they have been
+ *	saved.
+ *
+ *	During resume we only need to use one swp_map_page structure
+ *	at a time, which means that we only need to use two memory pages for
+ *	reading the image - one for reading the swp_map_page structures
+ *	and the second for reading the data pages from swap.
+ */
+
+#define MAP_PAGE_SIZE	((PAGE_SIZE - sizeof(swp_entry_t) - sizeof(void *)) \
+			/ sizeof(swp_entry_t))
+
+struct swp_map_page {
+	swp_entry_t		entries[MAP_PAGE_SIZE];
+	swp_entry_t		next_swp;
+	struct swp_map_page	*next;
+};
+
+typedef struct swp_map_page swp_map_t;
+
+static inline void free_swp_map(swp_map_t *swp_map)
+{
+	swp_map_t *swp;
+
+	while (swp_map) {
+		swp = swp_map->next;
+		free_page((unsigned long)swp_map);
+		swp_map = swp;
+	}
+}
+
+static swp_map_t *alloc_swp_map(unsigned nr_pages)
+{
+	swp_map_t *swp_map, *swp;
+	unsigned n = 0;
+
+	if (!nr_pages)
+		return NULL;
+
+	pr_debug("alloc_swp_map(): nr_pages = %d\n", nr_pages);
+	swp_map = (swp_map_t *)get_zeroed_page(GFP_ATOMIC);
+	swp = swp_map;
+	for (n = MAP_PAGE_SIZE; n < nr_pages; n += MAP_PAGE_SIZE) {
+		swp->next = (swp_map_t *)get_zeroed_page(GFP_ATOMIC);
+		swp = swp->next;
+		if (!swp) {
+			free_swp_map(swp_map);
+			return NULL;
+		}
+	}
+	return swp_map;
+}
+
+static inline swp_map_t *reverse_swp_map(swp_map_t *swp_map)
+{
+	swp_map_t *prev, *next;
+
+	prev = NULL;
+	while (swp_map) {
+		next = swp_map->next;
+		swp_map->next = prev;
+		prev = swp_map;
+		swp_map = next;
+	}
+	return prev;
+}
+
+/**
+ *	save_swp_map - save the swap map used for tracing the data pages
+ *	stored in swap
+ */
+
+static int save_swp_map(swp_map_t *swp_map, swp_entry_t *start)
+{
+	swp_entry_t entry = (swp_entry_t){0};
+	int error;
+
+	while (swp_map) {
+		swp_map->next_swp = entry;
+		if ((error = write_page((unsigned long)swp_map, &entry)))
+			return error;
+		swp_map = swp_map->next;
+	}
+	*start = entry;
+	return 0;
+}
+
+static inline void free_swp_map_entries(swp_map_t *swp_map)
+{
+	while (swp_map) {
+		if (swp_map->next_swp.val)
+			swap_free(swp_map->next_swp);
+		swp_map = swp_map->next;
+	}
+}
+
+/**
+ *	save_image - save the image data provided by the snapshot-handling
+ *	part to swap.  The swap map is used for keeping track of the
+ *	saved pages
+ */
+
+static int save_image(swp_map_t *swp, unsigned nr_pages, void *buf)
+{
+	unsigned n, k;
+	int error;
+	unsigned mod = nr_pages / 100;
+	void *tfm;
+
+	if ((error = crypto_init(1, &tfm)))
+		return error;
+	printk("Writing data to swap (%d pages) ...     ", nr_pages);
+	n = 0;
+	while (swp) {
+		for (k = 0; k < MAP_PAGE_SIZE && n < nr_pages; k++, n++) {
+			error = snapshot_send_page(buf);
+			if (!error)
+				error = crypto_write((unsigned long)buf,
+						swp->entries + k, tfm);
+			if (error) {
+				crypto_exit(tfm);
+				return error;
+			}
+			if (!(n % mod))
+				printk("\b\b\b\b%3d%%", n / mod);
+		}
+		swp = swp->next;
+	}
+	printk("\b\b\b\bdone\n");
+	crypto_exit(tfm);
+	return 0;
+}
+
+static inline void free_pages_entries(swp_map_t *swp)
+{
+	unsigned k;
+
+	while (swp) {
+		for (k = 0; k < MAP_PAGE_SIZE; k++)
+			if (swp->entries[k].val)
+				swap_free(swp->entries[k]);
+		swp = swp->next;
+	}
+}
+
+/**
+ *	enough_swap - Make sure we have enough swap to save the image.
+ *
+ *	Returns TRUE or FALSE after checking the total amount of swap
+ *	space avaiable.
+ *
+ *	FIXME: si_swapinfo(&i) returns all swap devices information.
+ *	We should only consider resume_device.
+ */
+
+static int enough_swap(unsigned long nr_pages)
+{
+	struct sysinfo i;
+
+	si_swapinfo(&i);
+	pr_debug("swsusp: available swap: %lu pages\n", i.freeswap);
+	return i.freeswap > (nr_pages + PAGES_FOR_IO +
+		(nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE);
+}
+
+/**
+ *	write_suspend_image - Write entire image and metadata.
+ *
+ */
+static int write_suspend_image(void)
+{
+	unsigned nr_pages;
+	int error;
+	swp_map_t *swp_map;
+	void *buffer;
+
+	nr_pages = snapshot_pages_to_save();
+	if (!enough_swap(nr_pages)) {
+		printk(KERN_ERR "swsusp: Not enough free swap\n");
+		return -ENOSPC;
+	}
+
+	init_header(nr_pages, snapshot_image_pages());
+	buffer = (void *)get_zeroed_page(GFP_ATOMIC);
+	if (!buffer)
+		return -ENOMEM;
+
+	swp_map = alloc_swp_map(nr_pages);
+	if (!swp_map) {
+		free_page((unsigned long)buffer);
+		return -ENOMEM;
+	}
+	snapshot_send_init();
+	if ((error = save_image(swp_map, nr_pages, buffer)))
+		goto Free_pages_entries;
+	if ((error = snapshot_finish()))
+		goto Free_pages_entries;
+	swp_map = reverse_swp_map(swp_map);
+	if ((error = save_swp_map(swp_map, &swsusp_info.start)))
+		goto Free_map_entries;
+	if ((error = close_swap()))
+		goto Free_map_entries;
+
+Free_mem:
+	free_swp_map(swp_map);
+	free_page((unsigned long)buffer);
+	memset(key_iv, 0, MAXKEY+MAXIV);
+	return error;
+
+Free_map_entries:
+	free_swp_map_entries(swp_map);
+Free_pages_entries:
+	free_pages_entries(swp_map);
+	goto Free_mem;
+}
+
+/* It is important _NOT_ to umount filesystems at this point. We want
+ * them synced (in case something goes wrong) but we DO not want to mark
+ * filesystem clean: it is not. (And it does not matter, if we resume
+ * correctly, we'll mark system clean, anyway.)
+ */
+int swsusp_write(void)
+{
+	int error;
+
+	if ((error = swsusp_swap_check())) {
+		printk(KERN_ERR "swsusp: cannot find swap device, try swapon -a.\n");
+		return error;
+	}
+	lock_swapdevices();
+	error = write_suspend_image();
+	/* This will unlock ignored swap devices since writing is finished */
+	lock_swapdevices();
+	return error;
+}
+
+/**
+ *	Using bio to read from swap.
+ *	This code requires a bit more work than just using buffer heads
+ *	but, it is the recommended way for 2.5/2.6.
+ *	The following are to signal the beginning and end of I/O. Bios
+ *	finish asynchronously, while we want them to happen synchronously.
+ *	A simple atomic_t, and a wait loop take care of this problem.
+ */
+
+static atomic_t io_done = ATOMIC_INIT(0);
+
+static int end_io(struct bio * bio, unsigned int num, int err)
+{
+	if (!test_bit(BIO_UPTODATE, &bio->bi_flags))
+		panic("I/O error reading memory image");
+	atomic_set(&io_done, 0);
+	return 0;
+}
+
+static struct block_device * resume_bdev;
+
+/**
+ *	submit - submit BIO request.
+ *	@rw:	READ or WRITE.
+ *	@off	physical offset of page.
+ *	@page:	page we're reading or writing.
+ *
+ *	Straight from the textbook - allocate and initialize the bio.
+ *	If we're writing, make sure the page is marked as dirty.
+ *	Then submit it and wait.
+ */
+
+static int submit(int rw, pgoff_t page_off, void * page)
+{
+	int error = 0;
+	struct bio * bio;
+
+	bio = bio_alloc(GFP_ATOMIC, 1);
+	if (!bio)
+		return -ENOMEM;
+	bio->bi_sector = page_off * (PAGE_SIZE >> 9);
+	bio_get(bio);
+	bio->bi_bdev = resume_bdev;
+	bio->bi_end_io = end_io;
+
+	if (bio_add_page(bio, virt_to_page(page), PAGE_SIZE, 0) < PAGE_SIZE) {
+		printk("swsusp: ERROR: adding page to bio at %ld\n",page_off);
+		error = -EFAULT;
+		goto Done;
+	}
+
+	if (rw == WRITE)
+		bio_set_pages_dirty(bio);
+
+	atomic_set(&io_done, 1);
+	submit_bio(rw | (1 << BIO_RW_SYNC), bio);
+	while (atomic_read(&io_done))
+		yield();
+
+ Done:
+	bio_put(bio);
+	return error;
+}
+
+static int bio_read_page(pgoff_t page_off, void * page)
+{
+	return submit(READ, page_off, page);
+}
+
+static int bio_write_page(pgoff_t page_off, void * page)
+{
+	return submit(WRITE, page_off, page);
+}
+
+/**
+ *	load_image - Load the image and metadata from swap, using the
+ *	snapshot_recv_page() function provided by the snapshot-handling code
+ *
+ *	We assume that the data has been saved using the swap map handling
+ *	functions above
+ */
+static int load_image(unsigned nr_pages, swp_entry_t start)
+{
+	swp_map_t *swp;
+	void *buf;
+	unsigned n, k;
+	unsigned long offset = swp_offset(start);
+	int error;
+	unsigned mod = nr_pages / 100;
+	void *tfm;
+
+	if (!nr_pages || !offset)
+		return -EINVAL;
+
+	if ((error = crypto_init(0, &tfm)))
+		return error;
+
+	buf = (void *)get_zeroed_page(GFP_ATOMIC);
+	if (!buf) {
+		error = -ENOMEM;
+		goto Crypto_exit;
+	}
+	swp = (swp_map_t *)get_zeroed_page(GFP_ATOMIC);
+	if (!swp) {
+		error = -ENOMEM;
+		goto Free_buf;
+	}
+	printk("Loading data from swap (%d pages) ...     ", nr_pages);
+	n = 0;
+	while (n < nr_pages) {
+		if ((error = crypto_read(offset, (void *)swp, tfm)))
+			goto Free;
+		for (k = 0; k < MAP_PAGE_SIZE && n < nr_pages; k++, n++) {
+			error = bio_read_page(swp_offset(swp->entries[k]), buf);
+			if (!error)
+				error = snapshot_recv_page(buf);
+			if (error)
+				goto Free;
+			if (!(n % mod))
+				printk("\b\b\b\b%3d%%", n / mod);
+		}
+		offset = swp_offset(swp->next_swp);
+	}
+	printk("\b\b\b\bdone\n");
+Free:
+	free_page((unsigned long)swp);
+Free_buf:
+	free_page((unsigned long)buf);
+Crypto_exit:
+	crypto_exit(tfm);
+	return error;
+}
+
+/*
+ * Sanity check if this image makes sense with this kernel/swap context
+ * I really don't think that it's foolproof but more than nothing..
+ */
+
+static const char * sanity_check(void)
+{
+	dump_info();
+	if (swsusp_info.version_code != LINUX_VERSION_CODE)
+		return "kernel version";
+	if (swsusp_info.num_physpages != num_physpages)
+		return "memory size";
+	if (strcmp(swsusp_info.uts.sysname,system_utsname.sysname))
+		return "system type";
+	if (strcmp(swsusp_info.uts.release,system_utsname.release))
+		return "kernel release";
+	if (strcmp(swsusp_info.uts.version,system_utsname.version))
+		return "version";
+	if (strcmp(swsusp_info.uts.machine,system_utsname.machine))
+		return "machine";
+#if 0
+	/* We can't use number of online CPUs when we use hotplug to remove them ;-))) */
+	if (swsusp_info.cpus != num_possible_cpus())
+		return "number of cpus";
+#endif
+	return NULL;
+}
+
+
+static int check_header(void)
+{
+	const char * reason = NULL;
+	int error;
+
+	if ((error = bio_read_page(swp_offset(swsusp_header.swsusp_info), &swsusp_info)))
+		return error;
+
+ 	/* Is this same machine? */
+	if ((reason = sanity_check())) {
+		printk(KERN_ERR "swsusp: Resume mismatch: %s\n",reason);
+		return -EPERM;
+	}
+	return error;
+}
+
+static int check_sig(void)
+{
+	int error;
+
+	memset(&swsusp_header, 0, sizeof(swsusp_header));
+	if ((error = bio_read_page(0, &swsusp_header)))
+		return error;
+	if (!memcmp(SWSUSP_SIG, swsusp_header.sig, 10)) {
+		memcpy(swsusp_header.sig, swsusp_header.orig_sig, 10);
+		memcpy(key_iv, swsusp_header.key_iv, MAXKEY+MAXIV);
+		memset(swsusp_header.key_iv, 0, MAXKEY+MAXIV);
+
+		/*
+		 * Reset swap signature now.
+		 */
+		error = bio_write_page(0, &swsusp_header);
+	} else {
+		return -EINVAL;
+	}
+	if (!error)
+		pr_debug("swsusp: Signature found, resuming\n");
+	return error;
+}
+
+static int check_suspend_image(void)
+{
+	int error = 0;
+
+	if ((error = check_sig()))
+		return error;
+
+	if ((error = check_header()))
+		return error;
+
+	return 0;
+}
+
+static int read_suspend_image(void)
+{
+	int error;
+
+	error = snapshot_recv_init(swsusp_info.pages, swsusp_info.image_pages);
+	if (!error)
+		error = load_image(swsusp_info.pages, swsusp_info.start);
+	if (!error)
+		error = snapshot_finish();
+	return error;
+}
+
+/**
+ *      swsusp_check - Check for saved image in swap
+ */
+
+int swsusp_check(void)
+{
+	int error;
+
+	resume_bdev = open_by_devnum(swsusp_resume_device, FMODE_READ);
+	if (!IS_ERR(resume_bdev)) {
+		set_blocksize(resume_bdev, PAGE_SIZE);
+		error = check_suspend_image();
+		if (error)
+		    blkdev_put(resume_bdev);
+	} else
+		error = PTR_ERR(resume_bdev);
+
+	if (!error)
+		pr_debug("swsusp: resume file found\n");
+	else
+		pr_debug("swsusp: Error %d check for resume file\n", error);
+	return error;
+}
+
+/**
+ *	swsusp_read - Read saved image from swap.
+ */
+
+int swsusp_read(void)
+{
+	int error;
+
+	if (IS_ERR(resume_bdev)) {
+		pr_debug("swsusp: block device not initialised\n");
+		return PTR_ERR(resume_bdev);
+	}
+
+	error = read_suspend_image();
+	blkdev_put(resume_bdev);
+	memset(key_iv, 0, MAXKEY+MAXIV);
+
+	if (!error)
+		pr_debug("swsusp: Reading resume file was successful\n");
+	else
+		pr_debug("swsusp: Error %d resuming\n", error);
+	return error;
+}
+
+/**
+ *	swsusp_close - close swap device.
+ */
+
+void swsusp_close(void)
+{
+	if (IS_ERR(resume_bdev)) {
+		pr_debug("swsusp: block device not initialised\n");
+		return;
+	}
+
+	blkdev_put(resume_bdev);
+}
+
Index: linux-2.6.14-rc5-mm1/kernel/power/snapshot.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/kernel/power/snapshot.c	2005-10-29 13:24:58.000000000 +0200
+++ linux-2.6.14-rc5-mm1/kernel/power/snapshot.c	2005-10-29 13:26:26.000000000 +0200
@@ -39,99 +39,6 @@
 static unsigned nr_copy_pages;
 static unsigned nr_pb_pages;
 
-#ifdef CONFIG_HIGHMEM
-struct highmem_page {
-	char *data;
-	struct page *page;
-	struct highmem_page *next;
-};
-
-static struct highmem_page *highmem_copy;
-
-static int save_highmem_zone(struct zone *zone)
-{
-	unsigned long zone_pfn;
-	mark_free_pages(zone);
-	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
-		struct page *page;
-		struct highmem_page *save;
-		void *kaddr;
-		unsigned long pfn = zone_pfn + zone->zone_start_pfn;
-
-		if (!(pfn%1000))
-			printk(".");
-		if (!pfn_valid(pfn))
-			continue;
-		page = pfn_to_page(pfn);
-		/*
-		 * This condition results from rvmalloc() sans vmalloc_32()
-		 * and architectural memory reservations. This should be
-		 * corrected eventually when the cases giving rise to this
-		 * are better understood.
-		 */
-		if (PageReserved(page)) {
-			printk("highmem reserved page?!\n");
-			continue;
-		}
-		BUG_ON(PageNosave(page));
-		if (PageNosaveFree(page))
-			continue;
-		save = kmalloc(sizeof(struct highmem_page), GFP_ATOMIC);
-		if (!save)
-			return -ENOMEM;
-		save->next = highmem_copy;
-		save->page = page;
-		save->data = (void *) get_zeroed_page(GFP_ATOMIC);
-		if (!save->data) {
-			kfree(save);
-			return -ENOMEM;
-		}
-		kaddr = kmap_atomic(page, KM_USER0);
-		memcpy(save->data, kaddr, PAGE_SIZE);
-		kunmap_atomic(kaddr, KM_USER0);
-		highmem_copy = save;
-	}
-	return 0;
-}
-
-
-int save_highmem(void)
-{
-	struct zone *zone;
-	int res = 0;
-
-	pr_debug("swsusp: Saving Highmem\n");
-	for_each_zone (zone) {
-		if (is_highmem(zone))
-			res = save_highmem_zone(zone);
-		if (res)
-			return res;
-	}
-	return 0;
-}
-
-int restore_highmem(void)
-{
-	printk("swsusp: Restoring Highmem\n");
-	while (highmem_copy) {
-		struct highmem_page *save = highmem_copy;
-		void *kaddr;
-		highmem_copy = save->next;
-
-		kaddr = kmap_atomic(save->page, KM_USER0);
-		memcpy(kaddr, save->data, PAGE_SIZE);
-		kunmap_atomic(kaddr, KM_USER0);
-		free_page((long) save->data);
-		kfree(save);
-	}
-	return 0;
-}
-#else
-int save_highmem(void) { return 0; }
-int restore_highmem(void) { return 0; }
-#endif /* CONFIG_HIGHMEM */
-
-
 static int pfn_is_nosave(unsigned long pfn)
 {
 	unsigned long nosave_begin_pfn = __pa(&__nosave_begin) >> PAGE_SHIFT;
Index: linux-2.6.14-rc5-mm1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/kernel/power/swsusp.c	2005-10-29 13:25:41.000000000 +0200
+++ linux-2.6.14-rc5-mm1/kernel/power/swsusp.c	2005-10-29 13:26:26.000000000 +0200
@@ -76,586 +76,96 @@
 
 #include "power.h"
 
-#define CIPHER "aes"
-#define MAXKEY 32
-#define MAXIV  32
-
-extern char resume_file[];
-
-
-#define SWSUSP_SIG	"S1SUSPEND"
-
-static struct swsusp_header {
-	char reserved[PAGE_SIZE - 20 - MAXKEY - MAXIV - sizeof(swp_entry_t)];
-	u8 key_iv[MAXKEY+MAXIV];
-	swp_entry_t swsusp_info;
-	char	orig_sig[10];
-	char	sig[10];
-} __attribute__((packed, aligned(PAGE_SIZE))) swsusp_header;
-
-static struct swsusp_info swsusp_info;
-
-/*
- * Saving part...
- */
-
-/* We memorize in swapfile_used what swap devices are used for suspension */
-#define SWAPFILE_UNUSED    0
-#define SWAPFILE_SUSPEND   1	/* This is the suspending device */
-#define SWAPFILE_IGNORED   2	/* Those are other swap devices ignored for suspension */
-
-static unsigned short swapfile_used[MAX_SWAPFILES];
-static unsigned short root_swap;
-
-static int write_page(unsigned long addr, swp_entry_t * loc);
-static int bio_read_page(pgoff_t page_off, void * page);
-
-static u8 key_iv[MAXKEY+MAXIV];
-
-#ifdef CONFIG_SWSUSP_ENCRYPT
-
-static int crypto_init(int mode, void **mem)
-{
-	int error = 0;
-	int len;
-	char *modemsg;
-	struct crypto_tfm *tfm;
-
-	modemsg = mode ? "suspend not possible" : "resume not possible";
-
-	tfm = crypto_alloc_tfm(CIPHER, CRYPTO_TFM_MODE_CBC);
-	if(!tfm) {
-		printk(KERN_ERR "swsusp: no tfm, %s\n", modemsg);
-		error = -EINVAL;
-		goto out;
-	}
-
-	if(MAXKEY < crypto_tfm_alg_min_keysize(tfm)) {
-		printk(KERN_ERR "swsusp: key buffer too small, %s\n", modemsg);
-		error = -ENOKEY;
-		goto fail;
-	}
-
-	if (mode)
-		get_random_bytes(key_iv, MAXKEY+MAXIV);
-
-	len = crypto_tfm_alg_max_keysize(tfm);
-	if (len > MAXKEY)
-		len = MAXKEY;
-
-	if (crypto_cipher_setkey(tfm, key_iv, len)) {
-		printk(KERN_ERR "swsusp: key setup failure, %s\n", modemsg);
-		error = -EKEYREJECTED;
-		goto fail;
-	}
-
-	len = crypto_tfm_alg_ivsize(tfm);
-
-	if (MAXIV < len) {
-		printk(KERN_ERR "swsusp: iv buffer too small, %s\n", modemsg);
-		error = -EOVERFLOW;
-		goto fail;
-	}
-
-	crypto_cipher_set_iv(tfm, key_iv+MAXKEY, len);
-
-	*mem=(void *)tfm;
-
-	goto out;
-
-fail:	crypto_free_tfm(tfm);
-out:	return error;
-}
-
-static __inline__ void crypto_exit(void *mem)
-{
-	crypto_free_tfm((struct crypto_tfm *)mem);
-}
-
-static __inline__ int crypto_write(unsigned long addr, swp_entry_t *entry, void *mem)
-{
-	int error = 0;
-	struct scatterlist src, dst;
-
-	src.page   = virt_to_page((void *)addr);
-	src.offset = 0;
-	src.length = PAGE_SIZE;
-	dst.page   = virt_to_page((void *)&swsusp_header);
-	dst.offset = 0;
-	dst.length = PAGE_SIZE;
-
-	error = crypto_cipher_encrypt((struct crypto_tfm *)mem, &dst, &src,
-					PAGE_SIZE);
-
-	if (!error)
-		error = write_page((unsigned long)&swsusp_header, entry);
-	return error;
-}
-
-static __inline__ int crypto_read(unsigned long offset, void *buf, void *mem)
-{
-	int error = 0;
-	struct scatterlist src, dst;
-
-	error = bio_read_page(offset, buf);
-	if (!error) {
-		src.offset = 0;
-		src.length = PAGE_SIZE;
-		dst.offset = 0;
-		dst.length = PAGE_SIZE;
-		src.page = dst.page = virt_to_page(buf);
-
-		error = crypto_cipher_decrypt((struct crypto_tfm *)mem, &dst,
-						&src, PAGE_SIZE);
-	}
-	return error;
-}
-#else
-static __inline__ int crypto_init(int mode, void *mem)
-{
-	return 0;
-}
-
-static __inline__ void crypto_exit(void *mem)
-{
-}
-
-static __inline__ int crypto_write(unsigned long addr, swp_entry_t *entry, void *mem)
-{
-	return write_page(addr, entry);
-}
-
-static __inline__ int crypto_read(unsigned long offset, void *buf, void *mem)
-{
-	return bio_read_page(offset, buf);
-}
-#endif
-
-static int mark_swapfiles(swp_entry_t prev)
-{
-	int error;
-
-	rw_swap_page_sync(READ,
-			  swp_entry(root_swap, 0),
-			  virt_to_page((unsigned long)&swsusp_header));
-	if (!memcmp("SWAP-SPACE",swsusp_header.sig, 10) ||
-	    !memcmp("SWAPSPACE2",swsusp_header.sig, 10)) {
-		memcpy(swsusp_header.orig_sig,swsusp_header.sig, 10);
-		memcpy(swsusp_header.sig,SWSUSP_SIG, 10);
-		memcpy(swsusp_header.key_iv, key_iv, MAXKEY+MAXIV);
-		swsusp_header.swsusp_info = prev;
-		error = rw_swap_page_sync(WRITE,
-					  swp_entry(root_swap, 0),
-					  virt_to_page((unsigned long)
-						       &swsusp_header));
-	} else {
-		pr_debug("swsusp: Partition is not swap space.\n");
-		error = -ENODEV;
-	}
-	return error;
-}
-
-/*
- * Check whether the swap device is the specified resume
- * device, irrespective of whether they are specified by
- * identical names.
- *
- * (Thus, device inode aliasing is allowed.  You can say /dev/hda4
- * instead of /dev/ide/host0/bus0/target0/lun0/part4 [if using devfs]
- * and they'll be considered the same device.  This is *necessary* for
- * devfs, since the resume code can only recognize the form /dev/hda4,
- * but the suspend code would see the long name.)
- */
-static int is_resume_device(const struct swap_info_struct *swap_info)
-{
-	struct file *file = swap_info->swap_file;
-	struct inode *inode = file->f_dentry->d_inode;
-
-	return S_ISBLK(inode->i_mode) &&
-		swsusp_resume_device == MKDEV(imajor(inode), iminor(inode));
-}
-
-static int swsusp_swap_check(void) /* This is called before saving image */
-{
-	int i, len;
-
-	len=strlen(resume_file);
-	root_swap = 0xFFFF;
-
-	spin_lock(&swap_lock);
-	for (i=0; i<MAX_SWAPFILES; i++) {
-		if (!(swap_info[i].flags & SWP_WRITEOK)) {
-			swapfile_used[i]=SWAPFILE_UNUSED;
-		} else {
-			if (!len) {
-	    			printk(KERN_WARNING "resume= option should be used to set suspend device" );
-				if (root_swap == 0xFFFF) {
-					swapfile_used[i] = SWAPFILE_SUSPEND;
-					root_swap = i;
-				} else
-					swapfile_used[i] = SWAPFILE_IGNORED;
-			} else {
-	  			/* we ignore all swap devices that are not the resume_file */
-				if (is_resume_device(&swap_info[i])) {
-					swapfile_used[i] = SWAPFILE_SUSPEND;
-					root_swap = i;
-				} else {
-				  	swapfile_used[i] = SWAPFILE_IGNORED;
-				}
-			}
-		}
-	}
-	spin_unlock(&swap_lock);
-	return (root_swap != 0xffff) ? 0 : -ENODEV;
-}
-
-/**
- * This is called after saving image so modification
- * will be lost after resume... and that's what we want.
- * we make the device unusable. A new call to
- * lock_swapdevices can unlock the devices.
- */
-static void lock_swapdevices(void)
-{
-	int i;
-
-	spin_lock(&swap_lock);
-	for (i = 0; i< MAX_SWAPFILES; i++)
-		if (swapfile_used[i] == SWAPFILE_IGNORED) {
-			swap_info[i].flags ^= SWP_WRITEOK;
-		}
-	spin_unlock(&swap_lock);
-}
-
-/**
- *	write_page - Write one page to a fresh swap location.
- *	@addr:	Address we're writing.
- *	@loc:	Place to store the entry we used.
- *
- *	Allocate a new swap entry and 'sync' it. Note we discard -EIO
- *	errors. That is an artifact left over from swsusp. It did not
- *	check the return of rw_swap_page_sync() at all, since most pages
- *	written back to swap would return -EIO.
- *	This is a partial improvement, since we will at least return other
- *	errors, though we need to eventually fix the damn code.
- */
-static int write_page(unsigned long addr, swp_entry_t * loc)
-{
-	swp_entry_t entry;
-	int error = 0;
-
-	entry = get_swap_page();
-	if (swp_offset(entry) &&
-	    swapfile_used[swp_type(entry)] == SWAPFILE_SUSPEND) {
-		error = rw_swap_page_sync(WRITE, entry,
-					  virt_to_page(addr));
-		if (error == -EIO)
-			error = 0;
-		if (!error)
-			*loc = entry;
-	} else
-		error = -ENOSPC;
-	return error;
-}
-
-static void dump_info(void)
-{
-	pr_debug(" swsusp: Version: %u\n",swsusp_info.version_code);
-	pr_debug(" swsusp: Num Pages: %ld\n",swsusp_info.num_physpages);
-	pr_debug(" swsusp: UTS Sys: %s\n",swsusp_info.uts.sysname);
-	pr_debug(" swsusp: UTS Node: %s\n",swsusp_info.uts.nodename);
-	pr_debug(" swsusp: UTS Release: %s\n",swsusp_info.uts.release);
-	pr_debug(" swsusp: UTS Version: %s\n",swsusp_info.uts.version);
-	pr_debug(" swsusp: UTS Machine: %s\n",swsusp_info.uts.machine);
-	pr_debug(" swsusp: UTS Domain: %s\n",swsusp_info.uts.domainname);
-	pr_debug(" swsusp: CPUs: %d\n",swsusp_info.cpus);
-	pr_debug(" swsusp: Image: %ld Pages\n",swsusp_info.image_pages);
-	pr_debug(" swsusp: Total: %ld Pages\n", swsusp_info.pages);
-}
-
-static void init_header(unsigned nr_pages, unsigned img_pages)
-{
-	memset(&swsusp_info, 0, sizeof(swsusp_info));
-	swsusp_info.version_code = LINUX_VERSION_CODE;
-	swsusp_info.num_physpages = num_physpages;
-	memcpy(&swsusp_info.uts, &system_utsname, sizeof(system_utsname));
-
-	swsusp_info.cpus = num_online_cpus();
-	swsusp_info.image_pages = img_pages;
-	swsusp_info.pages = nr_pages;
-}
-
-static int close_swap(void)
-{
-	swp_entry_t entry;
-	int error;
-
-	dump_info();
-	error = write_page((unsigned long)&swsusp_info, &entry);
-	if (!error) {
-		printk( "S" );
-		error = mark_swapfiles(entry);
-		printk( "|\n" );
-	}
-	return error;
-}
-
-/**
- *	Swap map handling functions
- *
- *	The swap map is a data structure used for keeping track of each page
- *	written to the swap.  It consists of many swp_map_page structures
- *	that contain each an array of MAP_PAGE_SIZE swap entries.
- *	These structures are linked together with the help of either the
- *	.next (in memory) or the .next_swp (in swap) member.
- *
- *	The swap map is created during suspend.  At that time we need to keep
- *	it in memory, because we have to free all of the allocated swap
- *	entries if an error occurs.  The memory needed is preallocated
- *	so that we know in advance if there's enough of it.
- *
- *	The first swp_map_page structure is filled with the swap entries that
- *	correspond to the first MAP_PAGE_SIZE data pages written to swap and
- *	so on.  After the all of the data pages have been written, the order
- *	of the swp_map_page structures in the map is reversed so that they
- *	can be read from swap in the original order.  This causes the data
- *	pages to be loaded in exactly the same order in which they have been
- *	saved.
- *
- *	During resume we only need to use one swp_map_page structure
- *	at a time, which means that we only need to use two memory pages for
- *	reading the image - one for reading the swp_map_page structures
- *	and the second for reading the data pages from swap.
- */
-
-#define MAP_PAGE_SIZE	((PAGE_SIZE - sizeof(swp_entry_t) - sizeof(void *)) \
-			/ sizeof(swp_entry_t))
-
-struct swp_map_page {
-	swp_entry_t		entries[MAP_PAGE_SIZE];
-	swp_entry_t		next_swp;
-	struct swp_map_page	*next;
+#ifdef CONFIG_HIGHMEM
+struct highmem_page {
+	char *data;
+	struct page *page;
+	struct highmem_page *next;
 };
 
-typedef struct swp_map_page swp_map_t;
-
-static inline void free_swp_map(swp_map_t *swp_map)
-{
-	swp_map_t *swp;
-
-	while (swp_map) {
-		swp = swp_map->next;
-		free_page((unsigned long)swp_map);
-		swp_map = swp;
-	}
-}
+static struct highmem_page *highmem_copy;
 
-static swp_map_t *alloc_swp_map(unsigned nr_pages)
+static int save_highmem_zone(struct zone *zone)
 {
-	swp_map_t *swp_map, *swp;
-	unsigned n = 0;
-
-	if (!nr_pages)
-		return NULL;
-
-	pr_debug("alloc_swp_map(): nr_pages = %d\n", nr_pages);
-	swp_map = (swp_map_t *)get_zeroed_page(GFP_ATOMIC);
-	swp = swp_map;
-	for (n = MAP_PAGE_SIZE; n < nr_pages; n += MAP_PAGE_SIZE) {
-		swp->next = (swp_map_t *)get_zeroed_page(GFP_ATOMIC);
-		swp = swp->next;
-		if (!swp) {
-			free_swp_map(swp_map);
-			return NULL;
+	unsigned long zone_pfn;
+	mark_free_pages(zone);
+	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
+		struct page *page;
+		struct highmem_page *save;
+		void *kaddr;
+		unsigned long pfn = zone_pfn + zone->zone_start_pfn;
+
+		if (!(pfn%1000))
+			printk(".");
+		if (!pfn_valid(pfn))
+			continue;
+		page = pfn_to_page(pfn);
+		/*
+		 * This condition results from rvmalloc() sans vmalloc_32()
+		 * and architectural memory reservations. This should be
+		 * corrected eventually when the cases giving rise to this
+		 * are better understood.
+		 */
+		if (PageReserved(page)) {
+			printk("highmem reserved page?!\n");
+			continue;
 		}
-	}
-	return swp_map;
-}
-
-static inline swp_map_t *reverse_swp_map(swp_map_t *swp_map)
-{
-	swp_map_t *prev, *next;
-
-	prev = NULL;
-	while (swp_map) {
-		next = swp_map->next;
-		swp_map->next = prev;
-		prev = swp_map;
-		swp_map = next;
-	}
-	return prev;
-}
-
-/**
- *	save_swp_map - save the swap map used for tracing the data pages
- *	stored in swap
- */
-
-static int save_swp_map(swp_map_t *swp_map, swp_entry_t *start)
-{
-	swp_entry_t entry = (swp_entry_t){0};
-	int error;
-
-	while (swp_map) {
-		swp_map->next_swp = entry;
-		if ((error = write_page((unsigned long)swp_map, &entry)))
-			return error;
-		swp_map = swp_map->next;
-	}
-	*start = entry;
-	return 0;
-}
-
-static inline void free_swp_map_entries(swp_map_t *swp_map)
-{
-	while (swp_map) {
-		if (swp_map->next_swp.val)
-			swap_free(swp_map->next_swp);
-		swp_map = swp_map->next;
-	}
-}
-
-/**
- *	save_image - save the image data provided by the snapshot-handling
- *	part to swap.  The swap map is used for keeping track of the
- *	saved pages
- */
-
-static int save_image(swp_map_t *swp, unsigned nr_pages, void *buf)
-{
-	unsigned n, k;
-	int error;
-	unsigned mod = nr_pages / 100;
-	void *tfm;
-
-	if ((error = crypto_init(1, &tfm)))
-		return error;
-	printk("Writing data to swap (%d pages) ...     ", nr_pages);
-	n = 0;
-	while (swp) {
-		for (k = 0; k < MAP_PAGE_SIZE && n < nr_pages; k++, n++) {
-			error = snapshot_send_page(buf);
-			if (!error)
-				error = crypto_write((unsigned long)buf,
-						swp->entries + k, tfm);
-			if (error) {
-				crypto_exit(tfm);
-				return error;
-			}
-			if (!(n % mod))
-				printk("\b\b\b\b%3d%%", n / mod);
+		BUG_ON(PageNosave(page));
+		if (PageNosaveFree(page))
+			continue;
+		save = kmalloc(sizeof(struct highmem_page), GFP_ATOMIC);
+		if (!save)
+			return -ENOMEM;
+		save->next = highmem_copy;
+		save->page = page;
+		save->data = (void *) get_zeroed_page(GFP_ATOMIC);
+		if (!save->data) {
+			kfree(save);
+			return -ENOMEM;
 		}
-		swp = swp->next;
+		kaddr = kmap_atomic(page, KM_USER0);
+		memcpy(save->data, kaddr, PAGE_SIZE);
+		kunmap_atomic(kaddr, KM_USER0);
+		highmem_copy = save;
 	}
-	printk("\b\b\b\bdone\n");
-	crypto_exit(tfm);
 	return 0;
 }
 
-static inline void free_pages_entries(swp_map_t *swp)
-{
-	unsigned k;
-
-	while (swp) {
-		for (k = 0; k < MAP_PAGE_SIZE; k++)
-			if (swp->entries[k].val)
-				swap_free(swp->entries[k]);
-		swp = swp->next;
-	}
-}
-
-/**
- *	enough_swap - Make sure we have enough swap to save the image.
- *
- *	Returns TRUE or FALSE after checking the total amount of swap
- *	space avaiable.
- *
- *	FIXME: si_swapinfo(&i) returns all swap devices information.
- *	We should only consider resume_device.
- */
-
-static int enough_swap(unsigned long nr_pages)
-{
-	struct sysinfo i;
-
-	si_swapinfo(&i);
-	pr_debug("swsusp: available swap: %lu pages\n", i.freeswap);
-	return i.freeswap > (nr_pages + PAGES_FOR_IO +
-		(nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE);
-}
-
-/**
- *	write_suspend_image - Write entire image and metadata.
- *
- */
-static int write_suspend_image(void)
+static int save_highmem(void)
 {
-	unsigned nr_pages;
-	int error;
-	swp_map_t *swp_map;
-	void *buffer;
+	struct zone *zone;
+	int res = 0;
 
-	nr_pages = snapshot_pages_to_save();
-	if (!enough_swap(nr_pages)) {
-		printk(KERN_ERR "swsusp: Not enough free swap\n");
-		return -ENOSPC;
+	pr_debug("swsusp: Saving Highmem\n");
+	for_each_zone (zone) {
+		if (is_highmem(zone))
+			res = save_highmem_zone(zone);
+		if (res)
+			return res;
 	}
-
-	init_header(nr_pages, snapshot_image_pages());
-	buffer = (void *)get_zeroed_page(GFP_ATOMIC);
-	if (!buffer)
-		return -ENOMEM;
-
-	swp_map = alloc_swp_map(nr_pages);
-	if (!swp_map) {
-		free_page((unsigned long)buffer);
-		return -ENOMEM;
-	}
-	snapshot_send_init();
-	if ((error = save_image(swp_map, nr_pages, buffer)))
-		goto Free_pages_entries;
-	if ((error = snapshot_finish()))
-		goto Free_pages_entries;
-	swp_map = reverse_swp_map(swp_map);
-	if ((error = save_swp_map(swp_map, &swsusp_info.start)))
-		goto Free_map_entries;
-	if ((error = close_swap()))
-		goto Free_map_entries;
-
-Free_mem:
-	free_swp_map(swp_map);
-	free_page((unsigned long)buffer);
-	memset(key_iv, 0, MAXKEY+MAXIV);
-	return error;
-
-Free_map_entries:
-	free_swp_map_entries(swp_map);
-Free_pages_entries:
-	free_pages_entries(swp_map);
-	goto Free_mem;
+	return 0;
 }
 
-/* It is important _NOT_ to umount filesystems at this point. We want
- * them synced (in case something goes wrong) but we DO not want to mark
- * filesystem clean: it is not. (And it does not matter, if we resume
- * correctly, we'll mark system clean, anyway.)
- */
-int swsusp_write(void)
+static int restore_highmem(void)
 {
-	int error;
-
-	if ((error = swsusp_swap_check())) {
-		printk(KERN_ERR "swsusp: cannot find swap device, try swapon -a.\n");
-		return error;
+	printk("swsusp: Restoring Highmem\n");
+	while (highmem_copy) {
+		struct highmem_page *save = highmem_copy;
+		void *kaddr;
+		highmem_copy = save->next;
+
+		kaddr = kmap_atomic(save->page, KM_USER0);
+		memcpy(kaddr, save->data, PAGE_SIZE);
+		kunmap_atomic(kaddr, KM_USER0);
+		free_page((long) save->data);
+		kfree(save);
 	}
-	lock_swapdevices();
-	error = write_suspend_image();
-	/* This will unlock ignored swap devices since writing is finished */
-	lock_swapdevices();
-	return error;
+	return 0;
 }
-
-
+#else
+static int save_highmem(void) { return 0; }
+static int restore_highmem(void) { return 0; }
+#endif /* CONFIG_HIGHMEM */
 
 int swsusp_suspend(void)
 {
@@ -718,292 +228,3 @@
 	local_irq_enable();
 	return error;
 }
-
-/*
- *	Using bio to read from swap.
- *	This code requires a bit more work than just using buffer heads
- *	but, it is the recommended way for 2.5/2.6.
- *	The following are to signal the beginning and end of I/O. Bios
- *	finish asynchronously, while we want them to happen synchronously.
- *	A simple atomic_t, and a wait loop take care of this problem.
- */
-
-static atomic_t io_done = ATOMIC_INIT(0);
-
-static int end_io(struct bio * bio, unsigned int num, int err)
-{
-	if (!test_bit(BIO_UPTODATE, &bio->bi_flags))
-		panic("I/O error reading memory image");
-	atomic_set(&io_done, 0);
-	return 0;
-}
-
-static struct block_device * resume_bdev;
-
-/**
- *	submit - submit BIO request.
- *	@rw:	READ or WRITE.
- *	@off	physical offset of page.
- *	@page:	page we're reading or writing.
- *
- *	Straight from the textbook - allocate and initialize the bio.
- *	If we're writing, make sure the page is marked as dirty.
- *	Then submit it and wait.
- */
-
-static int submit(int rw, pgoff_t page_off, void * page)
-{
-	int error = 0;
-	struct bio * bio;
-
-	bio = bio_alloc(GFP_ATOMIC, 1);
-	if (!bio)
-		return -ENOMEM;
-	bio->bi_sector = page_off * (PAGE_SIZE >> 9);
-	bio_get(bio);
-	bio->bi_bdev = resume_bdev;
-	bio->bi_end_io = end_io;
-
-	if (bio_add_page(bio, virt_to_page(page), PAGE_SIZE, 0) < PAGE_SIZE) {
-		printk("swsusp: ERROR: adding page to bio at %ld\n",page_off);
-		error = -EFAULT;
-		goto Done;
-	}
-
-	if (rw == WRITE)
-		bio_set_pages_dirty(bio);
-
-	atomic_set(&io_done, 1);
-	submit_bio(rw | (1 << BIO_RW_SYNC), bio);
-	while (atomic_read(&io_done))
-		yield();
-
- Done:
-	bio_put(bio);
-	return error;
-}
-
-static int bio_read_page(pgoff_t page_off, void * page)
-{
-	return submit(READ, page_off, page);
-}
-
-static int bio_write_page(pgoff_t page_off, void * page)
-{
-	return submit(WRITE, page_off, page);
-}
-
-/**
- *	load_image - Load the image and metadata from swap, using the
- *	snapshot_recv_page() function provided by the snapshot-handling code
- *
- *	We assume that the data has been saved using the swap map handling
- *	functions above
- */
-static int load_image(unsigned nr_pages, swp_entry_t start)
-{
-	swp_map_t *swp;
-	void *buf;
-	unsigned n, k;
-	unsigned long offset = swp_offset(start);
-	int error;
-	unsigned mod = nr_pages / 100;
-	void *tfm;
-
-	if (!nr_pages || !offset)
-		return -EINVAL;
-
-	if ((error = crypto_init(0, &tfm)))
-		return error;
-
-	buf = (void *)get_zeroed_page(GFP_ATOMIC);
-	if (!buf) {
-		error = -ENOMEM;
-		goto Crypto_exit;
-	}
-	swp = (swp_map_t *)get_zeroed_page(GFP_ATOMIC);
-	if (!swp) {
-		error = -ENOMEM;
-		goto Free_buf;
-	}
-	printk("Loading data from swap (%d pages) ...     ", nr_pages);
-	n = 0;
-	while (n < nr_pages) {
-		if ((error = crypto_read(offset, (void *)swp, tfm)))
-			goto Free;
-		for (k = 0; k < MAP_PAGE_SIZE && n < nr_pages; k++, n++) {
-			error = bio_read_page(swp_offset(swp->entries[k]), buf);
-			if (!error)
-				error = snapshot_recv_page(buf);
-			if (error)
-				goto Free;
-			if (!(n % mod))
-				printk("\b\b\b\b%3d%%", n / mod);
-		}
-		offset = swp_offset(swp->next_swp);
-	}
-	printk("\b\b\b\bdone\n");
-Free:
-	free_page((unsigned long)swp);
-Free_buf:
-	free_page((unsigned long)buf);
-Crypto_exit:
-	crypto_exit(tfm);
-	return error;
-}
-
-/*
- * Sanity check if this image makes sense with this kernel/swap context
- * I really don't think that it's foolproof but more than nothing..
- */
-
-static const char * sanity_check(void)
-{
-	dump_info();
-	if (swsusp_info.version_code != LINUX_VERSION_CODE)
-		return "kernel version";
-	if (swsusp_info.num_physpages != num_physpages)
-		return "memory size";
-	if (strcmp(swsusp_info.uts.sysname,system_utsname.sysname))
-		return "system type";
-	if (strcmp(swsusp_info.uts.release,system_utsname.release))
-		return "kernel release";
-	if (strcmp(swsusp_info.uts.version,system_utsname.version))
-		return "version";
-	if (strcmp(swsusp_info.uts.machine,system_utsname.machine))
-		return "machine";
-#if 0
-	/* We can't use number of online CPUs when we use hotplug to remove them ;-))) */
-	if (swsusp_info.cpus != num_possible_cpus())
-		return "number of cpus";
-#endif
-	return NULL;
-}
-
-
-static int check_header(void)
-{
-	const char * reason = NULL;
-	int error;
-
-	if ((error = bio_read_page(swp_offset(swsusp_header.swsusp_info), &swsusp_info)))
-		return error;
-
- 	/* Is this same machine? */
-	if ((reason = sanity_check())) {
-		printk(KERN_ERR "swsusp: Resume mismatch: %s\n",reason);
-		return -EPERM;
-	}
-	return error;
-}
-
-static int check_sig(void)
-{
-	int error;
-
-	memset(&swsusp_header, 0, sizeof(swsusp_header));
-	if ((error = bio_read_page(0, &swsusp_header)))
-		return error;
-	if (!memcmp(SWSUSP_SIG, swsusp_header.sig, 10)) {
-		memcpy(swsusp_header.sig, swsusp_header.orig_sig, 10);
-		memcpy(key_iv, swsusp_header.key_iv, MAXKEY+MAXIV);
-		memset(swsusp_header.key_iv, 0, MAXKEY+MAXIV);
-
-		/*
-		 * Reset swap signature now.
-		 */
-		error = bio_write_page(0, &swsusp_header);
-	} else {
-		return -EINVAL;
-	}
-	if (!error)
-		pr_debug("swsusp: Signature found, resuming\n");
-	return error;
-}
-
-static int check_suspend_image(void)
-{
-	int error = 0;
-
-	if ((error = check_sig()))
-		return error;
-
-	if ((error = check_header()))
-		return error;
-
-	return 0;
-}
-
-static int read_suspend_image(void)
-{
-	int error;
-
-	error = snapshot_recv_init(swsusp_info.pages, swsusp_info.image_pages);
-	if (!error)
-		error = load_image(swsusp_info.pages, swsusp_info.start);
-	if (!error)
-		error = snapshot_finish();
-	return error;
-}
-
-/**
- *      swsusp_check - Check for saved image in swap
- */
-
-int swsusp_check(void)
-{
-	int error;
-
-	resume_bdev = open_by_devnum(swsusp_resume_device, FMODE_READ);
-	if (!IS_ERR(resume_bdev)) {
-		set_blocksize(resume_bdev, PAGE_SIZE);
-		error = check_suspend_image();
-		if (error)
-		    blkdev_put(resume_bdev);
-	} else
-		error = PTR_ERR(resume_bdev);
-
-	if (!error)
-		pr_debug("swsusp: resume file found\n");
-	else
-		pr_debug("swsusp: Error %d check for resume file\n", error);
-	return error;
-}
-
-/**
- *	swsusp_read - Read saved image from swap.
- */
-
-int swsusp_read(void)
-{
-	int error;
-
-	if (IS_ERR(resume_bdev)) {
-		pr_debug("swsusp: block device not initialised\n");
-		return PTR_ERR(resume_bdev);
-	}
-
-	error = read_suspend_image();
-	blkdev_put(resume_bdev);
-	memset(key_iv, 0, MAXKEY+MAXIV);
-
-	if (!error)
-		pr_debug("swsusp: Reading resume file was successful\n");
-	else
-		pr_debug("swsusp: Error %d resuming\n", error);
-	return error;
-}
-
-/**
- *	swsusp_close - close swap device.
- */
-
-void swsusp_close(void)
-{
-	if (IS_ERR(resume_bdev)) {
-		pr_debug("swsusp: block device not initialised\n");
-		return;
-	}
-
-	blkdev_put(resume_bdev);
-}

