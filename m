Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbTE3L0X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 07:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTE3L0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 07:26:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:15535 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263587AbTE3L0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 07:26:13 -0400
Date: Fri, 30 May 2003 04:38:17 -0700 (PDT)
Message-Id: <20030530.043817.48675398.davem@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [UPDATED-PATCH] 2.5.x Dcache using Jenkins
From: "David S. Miller" <davem@redhat.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This fixes the inlining issues I mentioned in my previous
patch.  Also, use likely/unlikely where appropriate.

--- ./drivers/char/mem.c.~1~	Fri May 30 02:36:32 2003
+++ ./drivers/char/mem.c	Fri May 30 02:36:40 2003
@@ -695,7 +695,6 @@ static int __init chr_dev_init(void)
 				S_IFCHR | devlist[i].mode, devlist[i].name);
 	}
 	
-	rand_initialize();
 #if defined (CONFIG_FB)
 	fbmem_init();
 #endif
--- ./fs/adfs/dir.c.~1~	Fri May 30 00:59:14 2003
+++ ./fs/adfs/dir.c	Fri May 30 00:59:47 2003
@@ -208,7 +208,7 @@ adfs_hash(struct dentry *parent, struct 
 {
 	const unsigned int name_len = ADFS_SB(parent->d_sb)->s_namelen;
 	const unsigned char *name;
-	unsigned long hash;
+	struct name_hash_state hash;
 	int i;
 
 	if (qstr->len < name_len)
@@ -220,7 +220,7 @@ adfs_hash(struct dentry *parent, struct 
 	 */
 	qstr->len = i = name_len;
 	name = qstr->name;
-	hash = init_name_hash();
+	init_name_hash(&hash);
 	while (i--) {
 		char c;
 
@@ -228,9 +228,9 @@ adfs_hash(struct dentry *parent, struct 
 		if (c >= 'A' && c <= 'Z')
 			c += 'a' - 'A';
 
-		hash = partial_name_hash(c, hash);
+		partial_name_hash(c, &hash);
 	}
-	qstr->hash = end_name_hash(hash);
+	qstr->hash = end_name_hash(&hash);
 
 	return 0;
 }
--- ./fs/affs/namei.c.~1~	Fri May 30 00:59:59 2003
+++ ./fs/affs/namei.c	Fri May 30 01:00:21 2003
@@ -74,18 +74,18 @@ static inline int
 __affs_hash_dentry(struct dentry *dentry, struct qstr *qstr, toupper_t toupper)
 {
 	const u8 *name = qstr->name;
-	unsigned long hash;
+	struct name_hash_state hash;
 	int i;
 
 	i = affs_check_name(qstr->name,qstr->len);
 	if (i)
 		return i;
 
-	hash = init_name_hash();
+	init_name_hash(&hash);
 	i = min(qstr->len, 30u);
 	for (; i > 0; name++, i--)
-		hash = partial_name_hash(toupper(*name), hash);
-	qstr->hash = end_name_hash(hash);
+		partial_name_hash(toupper(*name), &hash);
+	qstr->hash = end_name_hash(&hash);
 
 	return 0;
 }
--- ./fs/hfs/string.c.~1~	Fri May 30 01:00:48 2003
+++ ./fs/hfs/string.c	Fri May 30 01:01:14 2003
@@ -83,12 +83,12 @@ static unsigned char casefold[256] = {
  */
 unsigned int hfs_strhash(const unsigned char *name, unsigned int len)
 {
-	unsigned long hash = init_name_hash();
+	struct name_hash_state hash;
 
+	init_name_hash(&hash);
 	while (len--)
-	        hash = partial_name_hash(caseorder[*name++],
-					 hash);
-	return end_name_hash(hash);
+	        partial_name_hash(caseorder[*name++], &hash);
+	return end_name_hash(&hash);
 }
 
 /*
--- ./fs/hpfs/dentry.c.~1~	Fri May 30 01:01:34 2003
+++ ./fs/hpfs/dentry.c	Fri May 30 01:02:06 2003
@@ -14,7 +14,7 @@
 
 int hpfs_hash_dentry(struct dentry *dentry, struct qstr *qstr)
 {
-	unsigned long	 hash;
+	struct name_hash_state hash;
 	int		 i;
 	unsigned l = qstr->len;
 
@@ -26,10 +26,10 @@ int hpfs_hash_dentry(struct dentry *dent
 		/*return -ENOENT;*/
 	x:
 
-	hash = init_name_hash();
+	init_name_hash(&hash);
 	for (i = 0; i < l; i++)
-		hash = partial_name_hash(hpfs_upcase(hpfs_sb(dentry->d_sb)->sb_cp_table,qstr->name[i]), hash);
-	qstr->hash = end_name_hash(hash);
+		partial_name_hash(hpfs_upcase(hpfs_sb(dentry->d_sb)->sb_cp_table,qstr->name[i]), &hash);
+	qstr->hash = end_name_hash(&hash);
 
 	return 0;
 }
--- ./fs/isofs/inode.c.~1~	Fri May 30 01:02:14 2003
+++ ./fs/isofs/inode.c	Fri May 30 01:02:32 2003
@@ -211,7 +211,7 @@ isofs_hashi_common(struct dentry *dentry
 	const char *name;
 	int len;
 	char c;
-	unsigned long hash;
+	struct name_hash_state hash;
 
 	len = qstr->len;
 	name = qstr->name;
@@ -220,12 +220,12 @@ isofs_hashi_common(struct dentry *dentry
 			len--;
 	}
 
-	hash = init_name_hash();
+	init_name_hash(&hash);
 	while (len--) {
 		c = tolower(*name++);
-		hash = partial_name_hash(tolower(c), hash);
+		partial_name_hash(tolower(c), &hash);
 	}
-	qstr->hash = end_name_hash(hash);
+	qstr->hash = end_name_hash(&hash);
 
 	return 0;
 }
--- ./fs/minix/namei.c.~1~	Fri May 30 01:02:46 2003
+++ ./fs/minix/namei.c	Fri May 30 01:03:06 2003
@@ -32,7 +32,7 @@ static int add_nondir(struct dentry *den
 
 static int minix_hash(struct dentry *dentry, struct qstr *qstr)
 {
-	unsigned long hash;
+	struct name_hash_state hash;
 	int i;
 	const unsigned char *name;
 
@@ -43,10 +43,10 @@ static int minix_hash(struct dentry *den
 	   function. */
 	qstr->len = i;
 	name = qstr->name;
-	hash = init_name_hash();
+	init_name_hash(&hash);
 	while (i--)
-		hash = partial_name_hash(*name++, hash);
-	qstr->hash = end_name_hash(hash);
+		partial_name_hash(*name++, &hash);
+	qstr->hash = end_name_hash(&hash);
 	return 0;
 }
 
--- ./fs/ncpfs/dir.c.~1~	Fri May 30 01:03:20 2003
+++ ./fs/ncpfs/dir.c	Fri May 30 01:03:50 2003
@@ -101,17 +101,18 @@ static int 
 ncp_hash_dentry(struct dentry *dentry, struct qstr *this)
 {
 	struct nls_table *t;
-	unsigned long hash;
 	int i;
 
 	t = NCP_IO_TABLE(dentry);
 
 	if (!ncp_case_sensitive(dentry->d_inode)) {
-		hash = init_name_hash();
+		struct name_hash_state hash;
+
+		init_name_hash(&hash);
 		for (i=0; i<this->len ; i++)
-			hash = partial_name_hash(ncp_tolower(t, this->name[i]),
-									hash);
-		this->hash = end_name_hash(hash);
+			partial_name_hash(ncp_tolower(t, this->name[i]),
+					  &hash);
+		this->hash = end_name_hash(&hash);
 	}
 	return 0;
 }
--- ./fs/smbfs/dir.c.~1~	Fri May 30 01:04:05 2003
+++ ./fs/smbfs/dir.c	Fri May 30 01:04:22 2003
@@ -330,13 +330,13 @@ smb_lookup_validate(struct dentry * dent
 static int 
 smb_hash_dentry(struct dentry *dir, struct qstr *this)
 {
-	unsigned long hash;
+	struct name_hash_state hash;
 	int i;
 
-	hash = init_name_hash();
+	init_name_hash(&hash);
 	for (i=0; i < this->len ; i++)
-		hash = partial_name_hash(tolower(this->name[i]), hash);
-	this->hash = end_name_hash(hash);
+		partial_name_hash(tolower(this->name[i]), &hash);
+	this->hash = end_name_hash(&hash);
   
 	return 0;
 }
--- ./fs/sysv/namei.c.~1~	Fri May 30 01:04:34 2003
+++ ./fs/sysv/namei.c	Fri May 30 01:04:51 2003
@@ -42,7 +42,7 @@ static int add_nondir(struct dentry *den
 
 static int sysv_hash(struct dentry *dentry, struct qstr *qstr)
 {
-	unsigned long hash;
+	struct name_hash_state hash;
 	int i;
 	const unsigned char *name;
 
@@ -53,10 +53,10 @@ static int sysv_hash(struct dentry *dent
 	   function. */
 	qstr->len = i;
 	name = qstr->name;
-	hash = init_name_hash();
+	init_name_hash(&hash);
 	while (i--)
-		hash = partial_name_hash(*name++, hash);
-	qstr->hash = end_name_hash(hash);
+		partial_name_hash(*name++, &hash);
+	qstr->hash = end_name_hash(&hash);
 	return 0;
 }
 
--- ./fs/vfat/namei.c.~1~	Fri May 30 01:05:02 2003
+++ ./fs/vfat/namei.c	Fri May 30 01:05:25 2003
@@ -139,17 +139,17 @@ static int vfat_hashi(struct dentry *den
 	struct nls_table *t = MSDOS_SB(dentry->d_inode->i_sb)->nls_io;
 	const char *name;
 	int len;
-	unsigned long hash;
+	struct name_hash_state hash;
 
 	len = qstr->len;
 	name = qstr->name;
 	while (len && name[len-1] == '.')
 		len--;
 
-	hash = init_name_hash();
+	init_name_hash(&hash);
 	while (len--)
-		hash = partial_name_hash(vfat_tolower(t, *name++), hash);
-	qstr->hash = end_name_hash(hash);
+		partial_name_hash(vfat_tolower(t, *name++), &hash);
+	qstr->hash = end_name_hash(&hash);
 
 	return 0;
 }
--- ./fs/dcache.c.~1~	Fri May 30 01:09:34 2003
+++ ./fs/dcache.c	Fri May 30 03:49:58 2003
@@ -28,6 +28,8 @@
 #include <asm/uaccess.h>
 #include <linux/security.h>
 #include <linux/seqlock.h>
+#include <linux/random.h>
+#include <linux/init.h>
 
 #define DCACHE_PARANOIA 1
 /* #define DCACHE_DEBUG 1 */
@@ -53,6 +55,8 @@ static unsigned int d_hash_shift;
 static struct hlist_head *dentry_hashtable;
 static LIST_HEAD(dentry_unused);
 
+u32 dcache_hash_rnd;
+
 /* Statistics gathering. */
 struct dentry_stat_t dentry_stat = {
 	.age_limit = 45,
@@ -1596,6 +1600,37 @@ static void __init dcache_init(unsigned 
 		d++;
 		i--;
 	} while (i);
+
+	/* The name hash routines start by BUG checking that
+	 * dcache_hash_rnd is non-zero.
+	 */
+	while (!dcache_hash_rnd)
+		get_random_bytes(&dcache_hash_rnd, sizeof(dcache_hash_rnd));
+}
+
+void __partial_name_hash(struct name_hash_state *hash)
+{
+	u32 a = hash->words[0], b = hash->words[1], c = hash->words[2];
+
+	__jhash_mix(a, b, c);
+
+	hash->words[0] = a;
+	hash->words[1] = b;
+	hash->words[2] = c;
+
+	hash->cur_byte = 0;
+}
+
+u32 end_name_hash(struct name_hash_state *hash)
+{
+	u32 c = hash->words[2];
+
+	if (likely(hash->cur_byte)) {
+		u32 a = hash->words[0], b = hash->words[1];
+
+		__jhash_mix(a, b, c);
+	}
+	return c;
 }
 
 /* SLAB cache for __getname() consumers */
--- ./fs/namei.c.~1~	Fri May 30 01:05:41 2003
+++ ./fs/namei.c	Fri May 30 01:06:27 2003
@@ -582,7 +582,7 @@ int link_path_walk(const char * name, st
 
 	/* At this point we know we have a real path component. */
 	for(;;) {
-		unsigned long hash;
+		struct name_hash_state hash;
 		struct qstr this;
 		unsigned int c;
 
@@ -596,14 +596,14 @@ int link_path_walk(const char * name, st
 		this.name = name;
 		c = *(const unsigned char *)name;
 
-		hash = init_name_hash();
+		init_name_hash(&hash);
 		do {
 			name++;
-			hash = partial_name_hash(c, hash);
+			partial_name_hash(c, &hash);
 			c = *(const unsigned char *)name;
 		} while (c && (c != '/'));
 		this.len = name - (const char *) this.name;
-		this.hash = end_name_hash(hash);
+		this.hash = end_name_hash(&hash);
 
 		/* remove trailing slashes? */
 		if (!c)
@@ -908,7 +908,7 @@ out:
 /* SMP-safe */
 struct dentry * lookup_one_len(const char * name, struct dentry * base, int len)
 {
-	unsigned long hash;
+	struct name_hash_state hash;
 	struct qstr this;
 	unsigned int c;
 
@@ -917,14 +917,14 @@ struct dentry * lookup_one_len(const cha
 	if (!len)
 		goto access;
 
-	hash = init_name_hash();
+	init_name_hash(&hash);
 	while (len--) {
 		c = *(const unsigned char *)name++;
 		if (c == '/' || c == '\0')
 			goto access;
-		hash = partial_name_hash(c, hash);
+		partial_name_hash(c, &hash);
 	}
-	this.hash = end_name_hash(hash);
+	this.hash = end_name_hash(&hash);
 
 	return lookup_hash(&this, base);
 access:
--- ./include/linux/dcache.h.~1~	Fri May 30 00:06:47 2003
+++ ./include/linux/dcache.h	Fri May 30 03:50:54 2003
@@ -3,11 +3,13 @@
 
 #ifdef __KERNEL__
 
+#include <linux/types.h>
 #include <asm/atomic.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/cache.h>
 #include <linux/rcupdate.h>
+#include <linux/jhash.h>
 #include <asm/bug.h>
 
 struct vfsmount;
@@ -30,7 +32,7 @@ struct vfsmount;
 struct qstr {
 	const unsigned char * name;
 	unsigned int len;
-	unsigned int hash;
+	u32 hash;
 	char name_str[0];
 };
 
@@ -43,34 +45,52 @@ struct dentry_stat_t {
 };
 extern struct dentry_stat_t dentry_stat;
 
-/* Name hashing routines. Initial hash value */
-/* Hash courtesy of the R5 hash in reiserfs modulo sign bits */
-#define init_name_hash()		0
-
-/* partial hash update function. Assume roughly 4 bits per character */
-static inline unsigned long
-partial_name_hash(unsigned long c, unsigned long prevhash)
+extern u32 dcache_hash_rnd;
+
+struct name_hash_state {
+	u32	words[3];
+	u32	cur_byte;
+};
+
+/* Name hashing routines.  */
+static inline void
+init_name_hash(struct name_hash_state *hash)
 {
-	return (prevhash + (c << 4) + (c >> 4)) * 11;
+	if (!dcache_hash_rnd)
+		BUG();
+	hash->words[0] = hash->words[1] = JHASH_GOLDEN_RATIO;
+	hash->words[2] = dcache_hash_rnd;
+	hash->cur_byte = 0;
 }
 
-/*
- * Finally: cut down the number of bits to a int value (and try to avoid
- * losing bits)
- */
-static inline unsigned long end_name_hash(unsigned long hash)
+extern void __partial_name_hash(struct name_hash_state *hash);
+
+static inline void
+partial_name_hash(const unsigned char c, struct name_hash_state *hash)
 {
-	return (unsigned int) hash;
+	u32 entry = hash->cur_byte;
+	u32 val = (u32) c << ((entry % sizeof(u32)) * 8);
+
+	hash->words[entry / sizeof(u32)] += val;
+
+	entry++;
+	hash->cur_byte = entry;
+	if (unlikely(entry == 12))
+		__partial_name_hash(hash);
 }
 
+extern u32 end_name_hash(struct name_hash_state *hash);
+
 /* Compute the hash for a name string. */
-static inline unsigned int
+static inline u32
 full_name_hash(const unsigned char *name, unsigned int len)
 {
-	unsigned long hash = init_name_hash();
+	struct name_hash_state hash;
+
+	init_name_hash(&hash);
 	while (len--)
-		hash = partial_name_hash(*name++, hash);
-	return end_name_hash(hash);
+		partial_name_hash(*name++, &hash);
+	return end_name_hash(&hash);
 }
 
 #define DNAME_INLINE_LEN_MIN 16
--- ./init/main.c.~1~	Fri May 30 03:30:09 2003
+++ ./init/main.c	Fri May 30 03:33:06 2003
@@ -37,6 +37,7 @@
 #include <linux/rcupdate.h>
 #include <linux/moduleparam.h>
 #include <linux/writeback.h>
+#include <linux/random.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -437,6 +438,7 @@ asmlinkage void __init start_kernel(void
 	proc_caches_init();
 	security_scaffolding_startup();
 	buffer_init();
+	rand_initialize();
 	vfs_caches_init(num_physpages);
 	radix_tree_init();
 	signals_init();
--- ./kernel/ksyms.c.~1~	Fri May 30 01:09:48 2003
+++ ./kernel/ksyms.c	Fri May 30 03:51:43 2003
@@ -160,6 +160,9 @@ EXPORT_SYMBOL(lookup_one_len);
 EXPORT_SYMBOL(lookup_hash);
 EXPORT_SYMBOL(sys_close);
 EXPORT_SYMBOL(dcache_lock);
+EXPORT_SYMBOL(dcache_hash_rnd);
+EXPORT_SYMBOL(__partial_name_hash);
+EXPORT_SYMBOL(end_name_hash);
 EXPORT_SYMBOL(d_alloc_root);
 EXPORT_SYMBOL(d_delete);
 EXPORT_SYMBOL(dget_locked);
