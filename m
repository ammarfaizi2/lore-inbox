Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268299AbUIKUER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268299AbUIKUER (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 16:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268300AbUIKUEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 16:04:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:23005 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268299AbUIKUAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 16:00:54 -0400
Date: Sat, 11 Sep 2004 12:55:26 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Makan Pourzandi (QB/EMC)" <makan.pourzandi@ericsson.com>
Cc: "'Chris Wright'" <chrisw@osdl.org>, "Serge E. Hallyn" <hallyn@CS.WM.EDU>,
       linux-kernel@vger.kernel.org,
       Axelle Apvrille <axelle.apvrille@trusted-logic.fr>, serue@us.ibm.com,
       "David Gordon (QB/EMC)" <David.Gordon@ericsson.com>,
       gaspoucho@yahoo.com
Subject: Re: [ANNOUNCE] Release Digsig 1.3.1: kernel module for run-time a uthentication of binaries
Message-ID: <20040911125526.T1924@build.pdx.osdl.net>
References: <21A5F45EFF209A44B3057E35CE1FE6E4BC415F@eammlex037.lmc.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <21A5F45EFF209A44B3057E35CE1FE6E4BC415F@eammlex037.lmc.ericsson.se>; from makan.pourzandi@ericsson.com on Fri, Sep 10, 2004 at 06:02:53PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Makan Pourzandi (QB/EMC) (makan.pourzandi@ericsson.com) wrote:
> Thanks a lot for your feedback. We'll work on the modifications in
> the source code mentioned in your email and send out a new release
> hopefully soon.

Here's a patch with a bunch of cleanups:
(sorry it's one big patch, just kept growing...)

- white space and braces cleanups
- NULL pointer checks unified as (!ptr)
- fixup confusion on ERR_PTR vs. NULL (fixes Oopsen)
- cast on kmalloc is unecessary
- make anyting static that can be
  - functions
  - variables (and remove redundany 0 initialization for static vars)
  - use static initializers for things like semaphores, lists, locks
  - remove set_digsig_ops/security_set_operations in favor of
    statically initiaized digsig_security_ops
- name change digsig_attribute_st -> digsig_attribute
- introduce DIGSIG_ATTR macro, and use for attribute initialization
- change names of sysfs files (in module, and hopefully supporting scripts
  and programs)
  - digsig_interface -> key
  - digsig_revoke -> revoke
- move extern defs to header files
- get ifndef/define header bits correct
- move towards single point of return (goto and error cleanup)
- fixup memory leaks on error return paths
- move towards use of error values rather than just -1
- move ctx cleanup out of digsig_sign_verify_final so that caller is
  responsible (less confusion and no chance of double free on error
  cleanup)
- mark init functions as __init
- use security_initcall()
- remove unneeded digsig_init_revocation (list statically initialized now)
- remove inline on external functions
- use list_for_each_entry
- collapse 'n' and 'e' cases in digsig_key_store for raw_public_key allocation
- remove redundant file->f_security = NULL after digsig_allow_write_access()
- move list_add_tail() in dsi_sysfs for revoked key into digsig_revocation.c
  under helper digsig_add_revoked_sig()
- add revoked_list_lock (used in above helper) for proper list manipulation
- s/SHA1_TFM/sha1_tfm/ ala CodingStyle
- fix bogus ctx==NULL check in digsig_sign_verify_update()

It compiles, and I actually loaded it and ran some tests to make sure
it still works.  Seems OK.  I didn't work at stressing any of the error
paths, but I think they are cleaner than they were.

thanks,
-chris

diff -paur digsig-1.3.1.orig/digsig.c digsig-1.3.1/digsig.c
--- digsig-1.3.1.orig/digsig.c	2004-09-03 05:31:19.000000000 -0700
+++ digsig-1.3.1/digsig.c	2004-09-11 11:11:31.000000000 -0700
@@ -60,18 +60,16 @@
 #define get_file_security(file) ((unsigned long)(file->f_security))
 #define set_file_security(file,val) (file->f_security = (void *)val)
 
-extern MPI digsig_public_key[2]; /* dsi_sig_verify.c */
-
 unsigned long int total_jiffies = 0;
 
 /* Allocate and free functions for each kind of security blob. */
-static struct semaphore digsig_sem;
+static DECLARE_MUTEX(digsig_sem);
 
 /* Indicate if module as key or not */
 int g_init = 0;
 
 /* Keep track of how we are registered */
-int secondary = 0;
+static int secondary;
 
 #ifdef DIGSIG_LOG
 int DigsigDebugLevel = DEBUG_INIT | DEBUG_SIGN;
@@ -84,9 +82,6 @@ int digsig_max_cached_sigs = 512;
 module_param(digsig_max_cached_sigs, int, 0);
 MODULE_PARM_DESC(digsig_max_cached_sigs, "Number of signatures to keep cached\n");
 
-/* Number of signature validations cached so far */
-int digsig_num_cached_sigs = 0;
-
 /******************************************************************************
 Description : 
  * For a file being opened for write, check:
@@ -141,13 +136,6 @@ digsig_inode_unlink(struct inode *dir, s
 	return 0;
 }
 
-struct security_operations digsig_security_ops;
-
-#define set_digsig_ops(ops, function)				\
-		if (!ops->function) {				\
-			ops->function = digsig_##function;	\
-                }
-
 static int
 digsig_verify_signature(Elf32_Shdr * elf_shdata,
 		     char *sig_orig, struct file *file, int sh_offset);
@@ -195,7 +183,7 @@ static char *digsig_find_signature(struc
 			return NULL;
 		}
 
-		buffer = (char *) kmalloc(DIGSIG_ELF_SIG_SIZE, DIGSIG_SAFE_ALLOC);
+		buffer = kmalloc(DIGSIG_ELF_SIG_SIZE, DIGSIG_SAFE_ALLOC);
 		if (!buffer) {
 			DSM_ERROR ("kmalloc failed in %s for buffer.\n", __FUNCTION__);
 			return NULL;
@@ -231,62 +219,50 @@ static int
 digsig_verify_signature(Elf32_Shdr * elf_shdata,
 		     char *sig_orig, struct file *file, int sh_offset)
 {
-	char *sig_result, *read_blocks;
-	int retval, offset;
-	unsigned int size;
+	char *sig_result = NULL, *read_blocks = NULL;
+	int retval = -EPERM, offset;
 	unsigned int lower, upper;
-	SIGCTX *ctx;
+	loff_t i_size;
+	SIGCTX *ctx = NULL;
 
 	down (&digsig_sem);
 	if (digsig_is_revoked_sig(sig_orig)) {
 		DSM_ERROR("%s: Refusing attempt to load an ELF file with"
 			  " a revoked signature.\n", __FUNCTION__);
-		up (&digsig_sem);
-		return -EPERM;
+		goto out;
 	}
 
-	if ((ctx = digsig_sign_verify_init(HASH_SHA1, SIGN_RSA)) == NULL) {
+	retval = -ENOMEM;
+	ctx = digsig_sign_verify_init(HASH_SHA1, SIGN_RSA);
+	if (!ctx ) {
 		DSM_PRINT(DEBUG_SIGN,
 			  "%s: Cannot allocate crypto context.\n", __FUNCTION__);
-		up (&digsig_sem);
-		return -ENOMEM;
+		goto out;
 	}
 
-	sig_result = (char *) kmalloc(DIGSIG_ELF_SIG_SIZE, DIGSIG_SAFE_ALLOC);
+	sig_result = kmalloc(DIGSIG_ELF_SIG_SIZE, DIGSIG_SAFE_ALLOC);
 	if (!sig_result) {
 		DSM_ERROR ("kmalloc failed in %s for sig_result.\n", __FUNCTION__);
-		kfree (ctx->tvmem);
-		kfree (ctx);
-		up (&digsig_sem);
-		return -ENOMEM;
+		goto out;
 	}
-	read_blocks = (char *) kmalloc(DIGSIG_ELF_READ_BLOCK_SIZE, DIGSIG_SAFE_ALLOC);
+	read_blocks = kmalloc(DIGSIG_ELF_READ_BLOCK_SIZE, DIGSIG_SAFE_ALLOC);
 	if (!read_blocks) {
 		DSM_ERROR ("kmalloc failed in %s for read_block.\n", __FUNCTION__);
-		kfree (ctx->tvmem);
-		kfree (ctx);
-		kfree (sig_result);
-		up (&digsig_sem);
-		return -ENOMEM;
+		goto out;
 	}
 
 	memset(sig_result, 0, DIGSIG_ELF_SIG_SIZE);
 
-	for (offset = 0; offset < file->f_dentry->d_inode->i_size;
-	     offset += DIGSIG_ELF_READ_BLOCK_SIZE) {
+	i_size = i_size_read(file->f_dentry->d_inode);
+	for (offset = 0; offset < i_size; offset += DIGSIG_ELF_READ_BLOCK_SIZE){
 
-		size = kernel_read(file, offset, (char *) read_blocks,
+		retval = kernel_read(file, offset, (char *) read_blocks,
 				   DIGSIG_ELF_READ_BLOCK_SIZE);
-		if (size <= 0) {
+		if (retval <= 0) {
 			DSM_PRINT(DEBUG_SIGN,
 				  "%s: Unable to read signature in blocks: %d\n",
-				  __FUNCTION__, size);
-			kfree(sig_result);
-			kfree(read_blocks);
-			kfree(ctx->tvmem);
-			kfree(ctx);
-			up (&digsig_sem);
-			return -1;
+				  __FUNCTION__, retval);
+			goto out;
 		}
 
 		/* Makan: This is in order to avoid building a buffer
@@ -308,31 +284,32 @@ digsig_verify_signature(Elf32_Shdr * elf
 		}
 
 		/* continue verification loop */
-		if (digsig_sign_verify_update(ctx, read_blocks, size) != 0) {
+		retval = digsig_sign_verify_update(ctx, read_blocks, retval);
+		if (retval < 0) {
 			DSM_PRINT(DEBUG_SIGN,
 				  "%s: Error updating crypto verification\n", __FUNCTION__);
-			kfree(sig_result);
-			kfree(read_blocks);
-			kfree(ctx->tvmem);
-			kfree(ctx);
-			up (&digsig_sem);
-			return -1;
+			goto out;
 		}
 	}
 
 	/* A bit of bsign formatting else hashes won't match, works with bsign v0.4.4 */
-	if ((retval = digsig_sign_verify_final(ctx, sig_result, DIGSIG_ELF_SIG_SIZE,
-					    sig_orig + DIGSIG_BSIGN_INFOS)) < 0) {
+	retval = digsig_sign_verify_final(ctx, sig_result, DIGSIG_ELF_SIG_SIZE,
+					    sig_orig + DIGSIG_BSIGN_INFOS);
+	if (retval < 0) {
 		DSM_PRINT(DEBUG_SIGN,
 			  "%s: Error calculating final crypto verification\n", __FUNCTION__);
-		kfree(sig_result);
-		kfree(read_blocks);
-		up (&digsig_sem);
-		return -1;
+		goto out;
 	}
 
+	retval = 0;
+
+out:
 	kfree(sig_result);
 	kfree(read_blocks);
+	if (ctx) {
+		kfree(ctx->tvmem);
+		kfree(ctx);
+	}
 	up (&digsig_sem);
 	return retval;
 }
@@ -382,7 +359,7 @@ static void digsig_allow_write_access(st
  * file->f_security>0, and we decrement the inode usage count to
  * show that we are done with it.
  */
-void digsig_file_free_security(struct file *file)
+static void digsig_file_free_security(struct file *file)
 {
 	if (file->f_security) {
 		digsig_allow_write_access(file);
@@ -426,18 +403,17 @@ static inline struct elfhdr *read_elf_he
 {
 	struct elfhdr *elf_ex;
 
-	elf_ex =
-	    (struct elfhdr *)kmalloc(sizeof(struct elfhdr), DIGSIG_SAFE_ALLOC);
+	elf_ex = kmalloc(sizeof(struct elfhdr), DIGSIG_SAFE_ALLOC);
 	if (!elf_ex) {
 		DSM_ERROR ("%s: kmalloc failed for elf_ex\n", __FUNCTION__);
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	kernel_read(file, 0, (char *)elf_ex, sizeof(struct elfhdr));
 
 	if (elf_sanity_check(elf_ex)) {
 		kfree(elf_ex);
-		return NULL;
+		return ERR_PTR(-EINVAL);
 	}
 
 	return elf_ex;
@@ -449,7 +425,7 @@ read_section_header(struct file *file, i
 	Elf32_Shdr *elf_shdata;
 	int retval;
 	
-	elf_shdata = (Elf32_Shdr *) kmalloc(sh_size, DIGSIG_SAFE_ALLOC);
+	elf_shdata = kmalloc(sh_size, DIGSIG_SAFE_ALLOC);
 	if (!elf_shdata) {
 		DSM_ERROR("%s: Cannot allocate memory to read Section Header\n",
 			  __FUNCTION__);
@@ -493,7 +469,7 @@ static inline int is_unprotected_file(st
 			__FUNCTION__, file->f_dentry->d_name.name, exec_time); \
 	}
 	
-int digsig_file_mmap(struct file * file, unsigned long prot, unsigned long flags)
+static int digsig_file_mmap(struct file * file, unsigned long prot, unsigned long flags)
 {
 	struct elfhdr *elf_ex;
 	int retval, sh_offset;
@@ -566,7 +542,7 @@ int digsig_file_mmap(struct file * file,
 	}
 
 	/* Verify binary's signature */
-	retval = digsig_verify_signature (elf_shdata, sig_orig, file, sh_offset);
+	retval = digsig_verify_signature(elf_shdata, sig_orig, file, sh_offset);
 
 	if (!retval) {
 		DSM_PRINT(DEBUG_SIGN,
@@ -587,71 +563,67 @@ int digsig_file_mmap(struct file * file,
 	kfree (sig_orig);
  out_free_shdata:
 	kfree (elf_shdata);
-
  out_with_file:
 	kfree (elf_ex);
  out_file_no_buf:
- 	if (allow_write_on_exit) {
+ 	if (allow_write_on_exit)
 		digsig_allow_write_access(file);
-		file->f_security = NULL;
-	}
 
 	end_digsig_bench;
 
 	return retval;
 }
 
-void security_set_operations(struct security_operations *ops)
-{
-	set_digsig_ops(ops, file_mmap);
-	set_digsig_ops(ops, file_free_security);
-	set_digsig_ops(ops, inode_permission);
-	set_digsig_ops(ops, inode_unlink);
-}
+static struct security_operations digsig_security_ops = {
+	.file_mmap		= digsig_file_mmap,
+	.file_free_security	= digsig_file_free_security,
+	.inode_permission	= digsig_inode_permission,
+	.inode_unlink		= digsig_inode_unlink,
+};
 
 static int __init digsig_init_module(void)
 {
+	int ret = -ENOMEM;
 	DSM_PRINT(DEBUG_INIT, "Initializing module\n");
 
 	/* initialize caching mechanisms */ 
 
-	if (digsig_init_caching()){
-	  return -ENOMEM;
-	}
-	digsig_init_revocation();
+	if (digsig_init_caching())
+		goto out;
 
-	/* initialize DigSig's hooks */
-	security_set_operations(&digsig_security_ops);
+	ret = -EINVAL;
+	if (digsig_init_sysfs()) {
+		DSM_ERROR("Error setting up sysfs for DigSig\n");
+		goto out_cache;
+	}
 
 	/* register */
-	if (register_security (&digsig_security_ops)) {
-		DSM_ERROR ("%s: Failure registering DigSig as primairy security module\n", __FUNCTION__);
-		if (mod_reg_security ("digsig_verif", &digsig_security_ops)) {
-			DSM_ERROR ("%s: Failure registering DigSig as secondary module\n", __FUNCTION__);
-			return -EINVAL;
+	if (register_security(&digsig_security_ops)) {
+		DSM_ERROR("%s: Failure registering DigSig as primairy security module\n", __FUNCTION__);
+		if (mod_reg_security("digsig_verif", &digsig_security_ops)) {
+			DSM_ERROR("%s: Failure registering DigSig as secondary module\n", __FUNCTION__);
+			goto out_sysfs;
 		}
-		DSM_PRINT (DEBUG_INIT, "Registered as secondary module\n");
+		DSM_PRINT(DEBUG_INIT, "Registered as secondary module\n");
 		secondary = 1;
 	}
-
-	init_MUTEX (&digsig_sem);
-
-	if (digsig_init_sysfs()) {
-		DSM_ERROR("Error setting up sysfs for DigSig\n");
-		return -EINVAL;
-	}
-
 	return 0;
+out_sysfs:
+	digsig_cleanup_sysfs();
+out_cache:
+	digsig_cache_cleanup();
+out:
+	return ret;
 }
 
 static void __exit digsig_exit_module(void)
 {
 	DSM_PRINT (DEBUG_INIT, "Deinitializing module\n");
 	g_init = 0;
-	digsig_sign_verify_free ();
-	digsig_cleanup_sysfs ();
-	digsig_cleanup_revocation ();
-	digsig_cache_cleanup ();
+	digsig_sign_verify_free();
+	digsig_cleanup_sysfs();
+	digsig_cleanup_revocation();
+	digsig_cache_cleanup();
 	mpi_free(digsig_public_key[0]);
 	mpi_free(digsig_public_key[1]);
 	if (secondary) {
@@ -666,7 +638,7 @@ static void __exit digsig_exit_module(vo
 	}
 }
 
-module_init(digsig_init_module);
+security_initcall(digsig_init_module);
 module_exit(digsig_exit_module);
 
 /* see linux/module.h */
diff -paur digsig-1.3.1.orig/digsig_cache.c digsig-1.3.1/digsig_cache.c
--- digsig-1.3.1.orig/digsig_cache.c	2004-09-03 05:31:19.000000000 -0700
+++ digsig-1.3.1/digsig_cache.c	2004-09-11 09:11:01.000000000 -0700
@@ -33,10 +33,9 @@
 #define DIGSIG_BENCH 0
 #endif
 
-extern int DigsigDebugLevel;
-
-extern int digsig_max_cached_sigs, digsig_num_cached_sigs;
-extern int g_init;
+extern int digsig_max_cached_sigs;
+/* Number of signature validations cached so far */
+static int digsig_num_cached_sigs;
 
 /*
  * digsig_hash_table:
@@ -71,8 +70,8 @@ struct digsig_hash_table {
 	struct digsig_hash_table *prev;  /* only set if dynamically alloced */
 };
 
-static struct digsig_hash_table *sig_cache = NULL;
-static struct list_head sig_cache_lru;
+static struct digsig_hash_table *sig_cache;
+static LIST_HEAD(sig_cache_lru);
 static spinlock_t sig_cache_spinlock = SPIN_LOCK_UNLOCKED;
 
 /******************************************************************************
@@ -177,7 +176,7 @@ Description : 
 Parameters  : @num: number of cached sig validation entries to clear.
 Return value: number of entries actually deleted.
 ******************************************************************************/
-int digsig_purge_cache(int num)
+static int digsig_purge_cache(int num)
 {			
 	int i=0;
 	struct digsig_hash_table *tmph, *del;
@@ -313,7 +312,7 @@ Description : Initialize caching 
 Parameters  : none
 Return value: 0 on success, 1 on failure.
 ******************************************************************************/
-int digsig_init_caching(void)
+int __init digsig_init_caching(void)
 {
         int tmp;
         
@@ -321,7 +320,7 @@ int digsig_init_caching(void)
 				sizeof(struct digsig_hash_table), GFP_ATOMIC); 
 				/* GFP_KERNEL); */ 
 	
-	if (IS_ERR(sig_cache)) {
+	if (!sig_cache) {
 	  DSM_PRINT(DEBUG_ERROR, "No memory to initialize digsig cache.\n");
 		return 1;
 	}
@@ -333,10 +332,7 @@ int digsig_init_caching(void)
 		sig_cache[tmp].orig = 1;
 	}
 
-	INIT_LIST_HEAD(&sig_cache_lru);
-
 	return 0; 
-
 }
 
 /*
diff -paur digsig-1.3.1.orig/digsig_cache.h digsig-1.3.1/digsig_cache.h
--- digsig-1.3.1.orig/digsig_cache.h	2004-09-03 05:31:19.000000000 -0700
+++ digsig-1.3.1/digsig_cache.h	2004-09-11 10:53:49.000000000 -0700
@@ -15,16 +15,17 @@
  *         
  */
 
-#ifndef __DSI_CACHE_H
+#ifndef _DSI_CACHE_H
+#define _DSI_CACHE_H
 
 #include <linux/fs.h>
 #include "gnupg/mpi/mpi.h"
 
 int is_cached_signature(struct inode *inode);
 void remove_signature(struct inode *inode);
-int digsig_purge_cache(int num);
 void digsig_cache_signature(struct inode *inode);
 int digsig_init_caching(void);
 void digsig_cache_cleanup(void);
 
-#endif
+#endif /* _DSI_CACHE_H */
+
diff -paur digsig-1.3.1.orig/digsig.init digsig-1.3.1/digsig.init
--- digsig-1.3.1.orig/digsig.init	2004-04-27 06:49:36.000000000 -0700
+++ digsig-1.3.1/digsig.init	2004-09-11 11:55:40.000000000 -0700
@@ -47,7 +47,7 @@ case "$1" in
 	echo "Catting revoked sigs into revocation list"
 	if [ -d $REVKEY_DIR ]; then
 		for name in `/bin/ls $REVKEY_DIR`; do
-			/bin/cat $REVKEY_DIR/$name > /sys/digsig/digsig_revoke
+			/bin/cat $REVKEY_DIR/$name > /sys/digsig/revoke
 		done
 	fi
 	echo "Loading public key."	
diff -paur digsig-1.3.1.orig/digsig_revocation.c digsig-1.3.1/digsig_revocation.c
--- digsig-1.3.1.orig/digsig_revocation.c	2004-09-03 05:31:19.000000000 -0700
+++ digsig-1.3.1/digsig_revocation.c	2004-09-11 12:09:25.558845224 -0700
@@ -34,10 +34,8 @@
 #define DIGSIG_BENCH 0
 #endif
 
-extern int DigsigDebugLevel;
-
-extern int digsig_max_hashed_sigs, digsig_num_hashed_sigs;
-struct list_head digsig_revoked_sigs;
+static LIST_HEAD(digsig_revoked_sigs);
+static spinlock_t revoked_list_lock = SPIN_LOCK_UNLOCKED;
 
 /*
  * Description: Called at module unload to free the list of revoked
@@ -48,6 +46,7 @@ void digsig_free_revoked_sigs(void)
 	struct list_head *tmp;
 	struct revoked_sig *rsig;
 
+	spin_lock(&revoked_list_lock);
 	while (!list_empty(&digsig_revoked_sigs)) {
 		tmp = digsig_revoked_sigs.next;
 		if (tmp != &digsig_revoked_sigs) {
@@ -57,9 +56,10 @@ void digsig_free_revoked_sigs(void)
 			kfree(rsig);
 		} else {
 			DSM_ERROR("major list screwyness\n");
-			return;
+			break;
 		}
 	}
+	spin_unlock(&revoked_list_lock);
 }
 
 /*
@@ -70,33 +70,34 @@ void digsig_free_revoked_sigs(void)
 #ifdef DIGSIG_REVOCATION
 int digsig_is_revoked_sig(char *buffer)
 {
-	struct list_head *tmp;
 	struct revoked_sig *rsig;
 	char *tmp1 = buffer + DIGSIG_BSIGN_INFOS + DIGSIG_RSA_DATA_OFFSET;
 	int count = DIGSIG_ELF_SIG_SIZE - DIGSIG_BSIGN_INFOS - DIGSIG_RSA_DATA_OFFSET;
 	int ret = 0;
 	MPI file_sig = mpi_read_from_buffer(tmp1, &count, 0);
 
-	list_for_each(tmp, &digsig_revoked_sigs) {
-		rsig = list_entry(tmp, struct revoked_sig, next);
+	spin_lock(&revoked_list_lock);
+	list_for_each_entry(rsig, &digsig_revoked_sigs, next) {
 		if (mpi_cmp(file_sig, rsig->sig) == 0) {
 			ret = 1;
 			goto out;
 		}
 	}
-
 out:
+	spin_unlock(&revoked_list_lock);
 	mpi_free(file_sig);
 	return ret;
 }
 #endif
 
-inline void digsig_init_revocation()
+void digsig_add_revoked_sig(struct revoked_sig *sig)
 {
-	INIT_LIST_HEAD(&digsig_revoked_sigs);
+	spin_lock(&revoked_list_lock);
+        list_add_tail(&sig->next, &digsig_revoked_sigs);
+	spin_unlock(&revoked_list_lock);
 }
 
-inline void digsig_cleanup_revocation()
+void digsig_cleanup_revocation(void)
 {
 	digsig_free_revoked_sigs();
 }
diff -paur digsig-1.3.1.orig/digsig_revocation.h digsig-1.3.1/digsig_revocation.h
--- digsig-1.3.1.orig/digsig_revocation.h	2004-09-03 05:31:19.000000000 -0700
+++ digsig-1.3.1/digsig_revocation.h	2004-09-11 10:54:03.000000000 -0700
@@ -15,19 +15,12 @@
  *         
  */
 
-#ifndef __DSI_REVOKE_H
+#ifndef _DSI_REVOKE_H
+#define _DSI_REVOKE_H
 
 #include <linux/fs.h>
 #include "gnupg/mpi/mpi.h"
 
-void digsig_init_revocation(void);
-void digsig_cleanup_revocation(void);
-#ifdef DIGSIG_REVOCATION
-int digsig_is_revoked_sig(char *buffer);
-#else
-#define digsig_is_revoked_sig(x) 0
-#endif
-
 /*
  * A linear array of revoked signatures.
  *
@@ -39,4 +32,14 @@ struct revoked_sig {
 	MPI sig;
 };
 
+void digsig_init_revocation(void);
+void digsig_cleanup_revocation(void);
+void digsig_add_revoked_sig(struct revoked_sig *sig);
+#ifdef DIGSIG_REVOCATION
+int digsig_is_revoked_sig(char *buffer);
+#else
+#define digsig_is_revoked_sig(x) 0
 #endif
+
+#endif /* _DSI_REVOKE_H */
+
diff -paur digsig-1.3.1.orig/dsi_debug.h digsig-1.3.1/dsi_debug.h
--- digsig-1.3.1.orig/dsi_debug.h	2004-09-03 05:31:19.000000000 -0700
+++ digsig-1.3.1/dsi_debug.h	2004-09-11 10:56:06.000000000 -0700
@@ -18,8 +18,8 @@
  */
 
 
-#ifndef __DSI_DEBUG_H
-#define __DSI_DEBUG_H
+#ifndef _DSI_DEBUG_H
+#define _DSI_DEBUG_H
 
 #define DIGSIG_MODULE_NAME "DIGSIG MODULE"
 
@@ -63,4 +63,4 @@ extern int DigsigDebugLevel;
 #define DSM_PRINT_NO_PREFIX(dbg,fmt,arg...) \
     if (dbg & DigsigDebugLevel) printk(fmt,##arg)
 
-#endif				/* __DSI_DEBUG_H */
+#endif /* _DSI_DEBUG_H */
diff -paur digsig-1.3.1.orig/dsi.h digsig-1.3.1/dsi.h
--- digsig-1.3.1.orig/dsi.h	2004-09-03 05:31:19.000000000 -0700
+++ digsig-1.3.1/dsi.h	2004-09-11 10:56:12.000000000 -0700
@@ -20,8 +20,8 @@
  */
 
 
-#ifndef __DSI_H
-#define __DSI_H
+#ifndef _DSI_H
+#define _DSI_H
 
 #ifdef MODULE
 #include <linux/kernel.h>
@@ -49,4 +49,6 @@
 
 #endif				/* MODULE */
 
-#endif
+extern int g_init;
+
+#endif /* _DSI_H */
diff -paur digsig-1.3.1.orig/dsi_sig_verify.c digsig-1.3.1/dsi_sig_verify.c
--- digsig-1.3.1.orig/dsi_sig_verify.c	2004-09-03 05:31:19.000000000 -0700
+++ digsig-1.3.1/dsi_sig_verify.c	2004-09-11 11:21:59.000000000 -0700
@@ -33,12 +33,10 @@
  * n bytes: MPI (ie. 0x29)
  */
 
-extern int DigsigDebugLevel;
-
 #define TVMEMSIZE	4096
 
 int gDigestLength[] = { /* SHA-1 */ 0x14 };
-static struct crypto_tfm *SHA1_TFM = NULL;
+static struct crypto_tfm *sha1_tfm;
 MPI digsig_public_key[] = {MPI_NULL, MPI_NULL};
 
 
@@ -70,17 +68,16 @@ SIGCTX *digsig_sign_verify_init(int hash
 	SIGCTX *ctx;
 
 	/* allocating signature context */
-	ctx = (SIGCTX *) kmalloc(sizeof(SIGCTX), GFP_KERNEL);
-	if (ctx == NULL) {
+	ctx = kmalloc(sizeof(SIGCTX), GFP_KERNEL);
+	if (!ctx) {
 		DSM_ERROR("Cannot allocate ctx\n");
-		return NULL;
+		goto err;
 	}
 
 	ctx->tvmem = kmalloc(TVMEMSIZE, GFP_KERNEL);
-	if (ctx->tvmem == NULL) {
-		kfree(ctx);
+	if (!ctx->tvmem) {
 		DSM_ERROR("Cannot allocate plaintext buffer\n");
-		return NULL;
+		goto err;
 	}
 
 	/* checking hash algorithm is known */
@@ -88,16 +85,12 @@ SIGCTX *digsig_sign_verify_init(int hash
 	case HASH_SHA1:
 		if (digsig_sha1_init(ctx)) {
 			DSM_ERROR("Initializing SHA1 failed\n");
-			kfree(ctx->tvmem);
-			kfree(ctx);
-			return NULL;
+			goto err;
 		}
 		break;
 	default:
 		DSM_ERROR("Unknown hash algo\n");
-		kfree(ctx->tvmem);
-		kfree(ctx);
-		return NULL;
+		goto err;
 	}
 
 	/* checking sign algo is known */
@@ -106,13 +99,18 @@ SIGCTX *digsig_sign_verify_init(int hash
 		break;
 	default:
 		DSM_ERROR("Unknown sign algo\n");
-		kfree(ctx->tvmem);
-		kfree(ctx);
-		return NULL;
+		goto err;
 	}
 	ctx->digestAlgo = hashalgo;
 	ctx->signAlgo = signalgo;
 	return ctx;
+
+err:
+	if (ctx) {
+		kfree(ctx->tvmem);
+		kfree(ctx);
+	}
+	return NULL;
 }
 
 /******************************************************************************
@@ -125,17 +123,16 @@ Return value: 0 normally
 ******************************************************************************/
 int digsig_sign_verify_update(SIGCTX * ctx, char *buf, int buflen)
 {
+	if (ctx == NULL)
+		return -EINVAL;
+
 	switch (ctx->digestAlgo) {
 	case HASH_SHA1:
-		if (ctx == NULL) {
-			return -1;
-		}
-
 		digsig_sha1_update(ctx, buf, buflen);
 		break;
 	default:
 		DSM_ERROR("%s: Unknown hash algo\n", __FUNCTION__);
-		return -1;
+		return -EINVAL;
 	}
 
 	return 0;
@@ -151,30 +148,24 @@ digsig_sign_verify_final(SIGCTX * ctx, c
 		      unsigned char *signed_hash)
 {
 	char *digest;
-	int rc = -1;
+	int rc = -ENOMEM;
 
 	digest = kmalloc (gDigestLength[ctx->digestAlgo], DIGSIG_SAFE_ALLOC);
 	if (!digest) {
 		DSM_ERROR ("kmalloc failed in %s for digest\n", __FUNCTION__);
-		return -ENOMEM;
+		goto err;
 	}
 	/* TO DO: check the length of the signature: it should be equal to the length
 	   of the modulus */
 	if ((rc = digsig_sha1_final(ctx, digest)) < 0) {
 		DSM_ERROR
 		    ("%s: Cannot finalize hash algorithm\n", __FUNCTION__);
-		kfree(ctx->tvmem);
-		kfree(ctx);
-		kfree (digest);
-		return rc;
+		goto err;
 	}
 
-	if (siglen < gDigestLength[ctx->digestAlgo]) {
-		kfree(ctx->tvmem);
-		kfree(ctx);
-		kfree (digest);
-		return -2;
-	}
+	rc = -EINVAL;
+	if (siglen < gDigestLength[ctx->digestAlgo])
+		goto err;
 	memcpy(sig, digest, gDigestLength[ctx->digestAlgo]);
 
 	switch (ctx->digestAlgo) {
@@ -190,8 +181,7 @@ digsig_sign_verify_final(SIGCTX * ctx, c
 
 	/* free everything */
 	/* do not free SHA1-TFM. For optimization, we choose always to use the same one */
-	kfree(ctx->tvmem);
-	kfree(ctx);
+err:
 	kfree (digest);
 	return rc;
 }
@@ -203,11 +193,11 @@ Description : 
 Parameters  : 
 Return value: 
 ******************************************************************************/
-void digsig_sign_verify_free()
+void digsig_sign_verify_free(void)
 {
-	if (SHA1_TFM) {
-		crypto_free_tfm(SHA1_TFM);
-		SHA1_TFM = NULL;
+	if (sha1_tfm) {
+		crypto_free_tfm(sha1_tfm);
+		sha1_tfm = NULL;
 	}
 	/* this might cause unpredictable behavior if structures are refering to this,
 	   their pointer might suddenly become NULL, might need a usage count associated */
@@ -252,7 +242,7 @@ Return value: 0 - RSA signature is valid
               -1 - an error occured
 ******************************************************************************/
 
-int digsig_rsa_bsign_verify(unsigned char *hash_format, int length,
+static int digsig_rsa_bsign_verify(unsigned char *hash_format, int length,
 			 unsigned char *signed_hash)
 {
 	int rc = 0;
@@ -265,7 +255,7 @@ int digsig_rsa_bsign_verify(unsigned cha
 	SIGCTX *ctx = NULL;
 	unsigned char *new_sig;
 
-	new_sig = kmalloc (gDigestLength[HASH_SHA1], DIGSIG_SAFE_ALLOC);
+	new_sig = kmalloc(gDigestLength[HASH_SHA1], DIGSIG_SAFE_ALLOC);
 	if (!new_sig) {
 		DSM_ERROR ("kmalloc failed in %s for new_sig\n", __FUNCTION__);
 		return -ENOMEM;
@@ -274,18 +264,20 @@ int digsig_rsa_bsign_verify(unsigned cha
 	/* Get MPI of signed data from .sig file/section */
 	nread = DIGSIG_ELF_SIG_SIZE;
 
-	data = mpi_read_from_buffer(signed_hash + DIGSIG_RSA_DATA_OFFSET, &nread,
-				    0);
-	if (!data)
+	data = mpi_read_from_buffer(signed_hash + DIGSIG_RSA_DATA_OFFSET, 
+				    &nread, 0);
+	if (!data) {
+		kfree(new_sig);
 		return -EINVAL;
+	}
 
 	/* Get MPI for hash */
 	/* bsign modif - file hash - gpg modif */
 	/* bsign modif: add bsign greet at beginning */
 	/* gpg modif:   add class and timestamp at end */
 
-	ctx = (SIGCTX *) kmalloc(sizeof(SIGCTX), GFP_KERNEL);
-	if (ctx == NULL) {
+	ctx = kmalloc(sizeof(SIGCTX), GFP_KERNEL);
+	if (!ctx) {
 		DSM_ERROR("Cannot allocate ctx\n");
 		mpi_free (data);
 		kfree (new_sig);
@@ -293,7 +285,7 @@ int digsig_rsa_bsign_verify(unsigned cha
 	}
 
 	ctx->tvmem = kmalloc(TVMEMSIZE, GFP_KERNEL);
-	if (ctx->tvmem == NULL) {
+	if (!ctx->tvmem) {
 		kfree (ctx);
 		mpi_free(data);
 		kfree (new_sig);
@@ -356,9 +348,9 @@ static int digsig_sha1_init(SIGCTX * ctx
 	if (ctx == NULL)
 		return -1;
 
-	if (SHA1_TFM == NULL)
-		SHA1_TFM = crypto_alloc_tfm("sha1", 0);
-	ctx->tfm = SHA1_TFM;
+	if (sha1_tfm == NULL)
+		sha1_tfm = crypto_alloc_tfm("sha1", 0);
+	ctx->tfm = sha1_tfm;
 	if (ctx->tfm == NULL) {
 		DSM_ERROR("tfm allocation failed\n");
 		return -1;
@@ -392,7 +384,7 @@ static void digsig_sha1_update(SIGCTX * 
 /******************************************************************************
 Description : Portability layer function. 
 Parameters  : 
-Return value: 0 for successful allocation, -1 for failed
+Return value: 0 for successful allocation, -EINVAL for failed
 ******************************************************************************/
 
 static int digsig_sha1_final(SIGCTX * ctx, char *digest)
@@ -401,7 +393,7 @@ static int digsig_sha1_final(SIGCTX * ct
 	   of the modulus */
 
 	if (ctx == NULL)
-		return -1;
+		return -EINVAL;
 
 	crypto_digest_final(ctx->tfm, digest);
 	return 0;
diff -paur digsig-1.3.1.orig/dsi_sig_verify.h digsig-1.3.1/dsi_sig_verify.h
--- digsig-1.3.1.orig/dsi_sig_verify.h	2004-09-03 05:31:19.000000000 -0700
+++ digsig-1.3.1/dsi_sig_verify.h	2004-09-11 10:52:10.000000000 -0700
@@ -14,8 +14,8 @@
  *         David Gordon
  */
 
-#ifndef _DSI_SIG_VERIFY_H_
-#define _DSI_SIG_VERIFY_H_
+#ifndef _DSI_SIG_VERIFY_H
+#define _DSI_SIG_VERIFY_H
 
 #include <linux/crypto.h>
 #include <asm/scatterlist.h>
@@ -79,6 +79,7 @@ typedef struct sig_ctx_st {
 } SIGCTX;
 
 extern int gDigestLength[1];
+extern MPI digsig_public_key[];
 
 SIGCTX *digsig_sign_verify_init(int hashalgo, int signalgo);
 int digsig_sign_verify_update(SIGCTX * ctx, char *buf, int buflen);
@@ -90,4 +91,4 @@ int digsig_init_pkey(const char read_par
 
 
 
-#endif
+#endif /* _DSI_SIG_VERIFY_H */
diff -paur digsig-1.3.1.orig/dsi_sysfs.c digsig-1.3.1/dsi_sysfs.c
--- digsig-1.3.1.orig/dsi_sysfs.c	2004-09-03 05:31:19.000000000 -0700
+++ digsig-1.3.1/dsi_sysfs.c	2004-09-11 11:55:15.000000000 -0700
@@ -47,31 +47,26 @@
 #define DIGSIG_KEY_OFFSET 1
 #endif
 
-extern int g_init; /* digsig.c */
 extern long int total_jiffies; /* digsig.c */
-extern MPI digsig_public_key[2]; /* dsi_sig_verify.c */
 
-extern struct list_head digsig_revoked_sigs; /* dsi_cache.c */
-
-struct digsig_attribute_st  {
+struct digsig_attribute  {
 	struct attribute attr;
 	ssize_t (*show)(struct kobject *, struct attribute *attr, char *);
 	ssize_t (*store)(struct kobject *, struct attribute *attr, const char *, size_t);
 };
 
-/* from digsig_cache.c */
-extern struct list_head digsig_revoked_sigs;
+#define DIGSIG_ATTR(_name, _mode, _show, _store)	\
+struct digsig_attribute digsig_attr_##_name = __ATTR(_name,_mode,_show,_store)
 
 /*
  * These are the show/hide prototypes and attribute for the
- * /sys/digsig/digsig_interface file, which is used to tell digsig the
+ * /sys/digsig/key file, which is used to tell digsig the
  * public key to use to verify ELF file signatures.
  */
 static ssize_t digsig_key_show (struct kobject *obj, struct attribute *attr,
 	char *buff);
 static ssize_t digsig_key_store (struct kobject *obj, struct attribute *attr,
 	const char *buff, size_t count);
-char digsig_file_name[] = "digsig_interface";
 /*
  * For the curious, notice what's going on:  We create a structure which
  * contains  .attr .  This  .attr  is what we pass into  sysfs_create_file
@@ -82,39 +77,26 @@ char digsig_file_name[] = "digsig_interf
  * subtracting that from the address we were sent, which is what container_of
  * in  digsig_store  and  digsig_show  (just a few definitions below) do.
  */
-static struct digsig_attribute_st digsig_attribute = {
-	.attr = {.name = digsig_file_name,
-		 .owner = THIS_MODULE,
-		 .mode = S_IRUSR | S_IWUSR},
-	.show = digsig_key_show,
-	.store = digsig_key_store
-};
+static DIGSIG_ATTR(key, 0600, digsig_key_show, digsig_key_store);
 
 /*
  * These are the show/hide prototypes and attribute for the
- * /sys/digsig/digsig_revoke file, which is used to tell digsig the
+ * /sys/digsig/revoke file, which is used to tell digsig the
  * ELF file signatures which are revoked.  Digsig will not allow
  * loading any files which carry one of these signatures.
  */
-static ssize_t digsig_revoked_list_show (struct kobject *obj,
+static ssize_t digsig_revoked_show (struct kobject *obj,
 	struct attribute *attr, char *buff);
-static ssize_t digsig_revoked_list_store (struct kobject *obj,
+static ssize_t digsig_revoked_store (struct kobject *obj,
 	struct attribute *attr, const char *buff, size_t count);
-char digsig_r_file_name[] = "digsig_revoke";
-static struct digsig_attribute_st digsig_r_attribute = {
-	.attr = {.name = digsig_r_file_name,
-		 .owner = THIS_MODULE,
-		 .mode = S_IRUSR | S_IWUSR},
-	.show = digsig_revoked_list_show,
-	.store = digsig_revoked_list_store
-};
+static DIGSIG_ATTR(revoke, 0600, digsig_revoked_show, digsig_revoked_store);
 
 /*
  * Next are the digsig sysfs file operations.  These are assigned to
- * the files under /sys/digsig.  They will use the digsig_attribute_st
+ * the files under /sys/digsig.  They will use the digsig_attribute
  * struct defined above to find the function which should actually be
  * called for read/write.  The attr argument to these functions is a
- * member of the digsig_attribute_st struct we defined, so we use its
+ * member of the digsig_attribute struct we defined, so we use its
  * offset to find our structure, which in turn contains the read and
  * write operations we actually want to perform.
  */
@@ -122,8 +104,8 @@ static ssize_t
 digsig_store(struct kobject *kobj, struct attribute *attr, const char *buf,
 	size_t len)
 {
-	struct digsig_attribute_st *attribute = container_of(attr,
-		struct digsig_attribute_st, attr);
+	struct digsig_attribute *attribute = container_of(attr,
+		struct digsig_attribute, attr);
 
 	return attribute->store ? attribute->store(kobj, attr, buf, len) : 0;
 }
@@ -131,8 +113,8 @@ digsig_store(struct kobject *kobj, struc
 static ssize_t
 digsig_show(struct kobject *kobj, struct attribute *attr, char *buf)
 {
-	struct digsig_attribute_st *attribute = container_of(attr,
-		struct digsig_attribute_st, attr);
+	struct digsig_attribute *attribute = container_of(attr,
+		struct digsig_attribute, attr);
 
 	return attribute->show ? attribute->show(kobj, attr, buf) : 0;
 }
@@ -161,28 +143,34 @@ static struct kobject digsig_kobject = {
 /*
  * init and cleanup functions for the /sys/digsig directory.
  */
-int digsig_init_sysfs(void)
+int __init digsig_init_sysfs(void)
 {
 	if (kobject_register (&digsig_kobject) != 0) {
 		DSM_ERROR ("Digsig key failed to register properly\n");
-		return -1;
+		goto err;
 	}
-	if (sysfs_create_file(&digsig_kobject, &digsig_attribute.attr) != 0) {
+	if (sysfs_create_file(&digsig_kobject, &digsig_attr_key.attr) != 0) {
 		DSM_ERROR ("Create file failed\n");
-		return -1;
+		goto create_key;
 	}
-	if (sysfs_create_file(&digsig_kobject, &digsig_r_attribute.attr) != 0) {
+	if (sysfs_create_file(&digsig_kobject, &digsig_attr_revoke.attr) != 0) {
 		DSM_ERROR ("Create revocation file failed\n");
-		return -1;
+		goto create_revoke;
 	}
-
 	return 0;
+
+create_revoke:
+	sysfs_remove_file (&digsig_kobject, &digsig_attr_key.attr);
+create_key:
+	kobject_unregister (&digsig_kobject);
+err:
+	return -1;
 }
 
 void digsig_cleanup_sysfs(void)
 {
-	sysfs_remove_file (&digsig_kobject, &digsig_attribute.attr);
-	sysfs_remove_file (&digsig_kobject, &digsig_r_attribute.attr);
+	sysfs_remove_file (&digsig_kobject, &digsig_attr_key.attr);
+	sysfs_remove_file (&digsig_kobject, &digsig_attr_revoke.attr);
 	kobject_unregister (&digsig_kobject);
 }
 
@@ -219,28 +207,17 @@ digsig_key_store (struct kobject *obj, s
 		return -1;
 
 	switch (buff[0]) {
-
 	case 'n':
-		raw_public_key =
-			(unsigned char *) kmalloc(count - DIGSIG_KEY_OFFSET, DIGSIG_SAFE_ALLOC);
-		if (!raw_public_key) {
-			DSM_ERROR("kmalloc fail for n in %s\n", __FUNCTION__);
-			return -ENOMEM;
-		}
-		memcpy(raw_public_key, &buff[DIGSIG_KEY_OFFSET], count - DIGSIG_KEY_OFFSET);
-		mpi_size = count - DIGSIG_KEY_OFFSET;
-		DSM_PRINT(DEBUG_DEV, "pkey->n size is %i\n", mpi_size);
-		break;
 	case 'e':
 		raw_public_key =
-			(unsigned char *) kmalloc(count - DIGSIG_KEY_OFFSET, DIGSIG_SAFE_ALLOC);
+			kmalloc(count - DIGSIG_KEY_OFFSET, DIGSIG_SAFE_ALLOC);
 		if (!raw_public_key) {
-			DSM_ERROR("kmalloc fail for e in %s\n", __FUNCTION__);
+			DSM_ERROR("kmalloc fail for %c in %s\n", buff[0], __FUNCTION__);
 			return -ENOMEM;
 		}
 		memcpy(raw_public_key, &buff[DIGSIG_KEY_OFFSET], count - DIGSIG_KEY_OFFSET);
 		mpi_size = count - DIGSIG_KEY_OFFSET;
-		DSM_PRINT(DEBUG_DEV, "pkey->e size is %i\n", mpi_size);
+		DSM_PRINT(DEBUG_DEV, "pkey->%c size is %i\n", buff[0], mpi_size);
 		break;
 	default:
 		return -EINVAL;
@@ -265,12 +242,12 @@ digsig_key_show (struct kobject *obj, st
 }
 
 /*
- * callbacks for read/write to /sys/digsig/digsig_revoke file
+ * callbacks for read/write to /sys/digsig/revoke file
  */
 static ssize_t
-digsig_revoked_list_store (struct kobject *obj, struct attribute *attr, const char *buff, size_t count)
+digsig_revoked_store (struct kobject *obj, struct attribute *attr, const char *buff, size_t count)
 {
-        struct revoked_sig *tmp;
+        struct revoked_sig *sig;
         int rcount = DIGSIG_ELF_SIG_SIZE - DIGSIG_BSIGN_INFOS - DIGSIG_RSA_DATA_OFFSET;
 
         if (g_init)
@@ -282,22 +259,22 @@ digsig_revoked_list_store (struct kobjec
                 return -EINVAL;
         }
 
-        tmp = kmalloc(sizeof(struct revoked_sig), GFP_KERNEL);
-        if (!tmp)
+        sig = kmalloc(sizeof(struct revoked_sig), GFP_KERNEL);
+        if (!sig)
                 return -ENOMEM;
-        memset(tmp, 0, sizeof(struct revoked_sig));
-        tmp->sig = mpi_read_from_buffer(
+        memset(sig, 0, sizeof(struct revoked_sig));
+        sig->sig = mpi_read_from_buffer(
 		buff + DIGSIG_BSIGN_INFOS + DIGSIG_RSA_DATA_OFFSET,
 		&rcount, 0);
 
-        list_add_tail(&tmp->next, &digsig_revoked_sigs);
+	digsig_add_revoked_sig(sig);
 
         DSM_PRINT(DEBUG_SIGN, "Added a revoked sig.\n");
         return count;
 }
 
 static ssize_t
-digsig_revoked_list_show (struct kobject *obj, struct attribute *attr, char *buff)
+digsig_revoked_show (struct kobject *obj, struct attribute *attr, char *buff)
 {
 
         return 0;
diff -paur digsig-1.3.1.orig/dsi_sysfs.h digsig-1.3.1/dsi_sysfs.h
--- digsig-1.3.1.orig/dsi_sysfs.h	2004-09-03 05:31:19.000000000 -0700
+++ digsig-1.3.1/dsi_sysfs.h	2004-09-11 10:55:08.000000000 -0700
@@ -14,8 +14,8 @@
  * 
  * Vincent Roy
  */
-#ifndef __DSI_SYSFS_H
-#define __DSI_SYSFS_H
+#ifndef _DSI_SYSFS_H
+#define _DSI_SYSFS_H
 
 ssize_t	digsig_store (struct kobject *obj, struct attribute *attr, const char *buff, size_t count);
 ssize_t	digsig_show (struct kobject *obj, struct attribute *attr, char *buff);
@@ -26,4 +26,4 @@ ssize_t digsig_rev_list_show (struct kob
 int digsig_init_sysfs(void);
 void digsig_cleanup_sysfs(void);
 
-#endif
+#endif /* _DSI_SYSFS_H */
diff -paur digsig-1.3.1.orig/tools/extract_pkey.c digsig-1.3.1/tools/extract_pkey.c
--- digsig-1.3.1.orig/tools/extract_pkey.c	2004-09-03 05:31:19.000000000 -0700
+++ digsig-1.3.1/tools/extract_pkey.c	2004-09-11 11:53:37.000000000 -0700
@@ -53,7 +53,7 @@ int main(int argc, char **argv)
 		printf ("Unable to open pkey_file %s %s\n", argv[1], strerror(errno));
 		return -1;
 	}
-	module_file = open ("/sys/digsig/digsig_interface", O_WRONLY);
+	module_file = open ("/sys/digsig/key", O_WRONLY);
 	if (!module_file) {
 		printf ("Unable to open module char device %s\n", strerror(errno));
 		return -1;
