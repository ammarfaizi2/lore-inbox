Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVDMTEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVDMTEH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 15:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVDMTEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 15:04:06 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:786 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261205AbVDMTDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 15:03:14 -0400
Date: Wed, 13 Apr 2005 20:03:07 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Petr Baudis <pasky@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: Re: [ANNOUNCE] git-pasky-0.3
Message-ID: <20050413200307.B19329@flint.arm.linux.org.uk>
Mail-Followup-To: Petr Baudis <pasky@ucw.cz>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Ross Vandegrift <ross@jose.lug.udel.edu>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz> <20050411015852.GI5902@pasky.ji.cz> <20050411135758.GA3524@pasky.ji.cz> <20050413103521.D1798@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050413103521.D1798@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Wed, Apr 13, 2005 at 10:35:21AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 10:35:21AM +0100, Russell King wrote:
> I tried this today, applied my patch for BE<->LE conversions and
> glibc-2.2 compatibility (attached, still requires cleaning though),
> and then tried git pull.  Umm, whoops.

Here's an updated patch which allows me to work with a BE-based
cache.  I've just used this to grab and checkout sparse.git.

Note: it also fixes my glibc-2.2 build problem with the nsec
stat64 structures (see read-cache.c).

--- cache.h
+++ cache.h	Wed Apr 13 11:23:39 2005
@@ -14,6 +14,12 @@
 #include <openssl/sha.h>
 #include <zlib.h>
 
+#include <netinet/in.h>
+#define cpu_to_beuint(x)	(htonl(x))
+#define beuint_to_cpu(x)	(ntohl(x))
+#define cpu_to_beushort(x)	(htons(x))
+#define beushort_to_cpu(x)	(ntohs(x))
+
 /*
  * Basic data structures for the directory cache
  *
@@ -67,7 +73,7 @@
 #define DEFAULT_DB_ENVIRONMENT ".git/objects"
 
 #define cache_entry_size(len) ((offsetof(struct cache_entry,name) + (len) + 8) & ~7)
-#define ce_size(ce) cache_entry_size((ce)->namelen)
+#define ce_size(ce) cache_entry_size(beushort_to_cpu((ce)->namelen))
 
 #define alloc_nr(x) (((x)+16)*3/2)
 
--- checkout-cache.c
+++ checkout-cache.c	Wed Apr 13 19:52:08 2005
@@ -77,7 +77,7 @@
 		return error("checkout-cache: unable to read sha1 file of %s (%s)",
 			ce->name, sha1_to_hex(ce->sha1));
 	}
-	fd = create_file(ce->name, ce->st_mode);
+	fd = create_file(ce->name, beuint_to_cpu(ce->st_mode));
 	if (fd < 0) {
 		free(new);
 		return error("checkout-cache: unable to create %s (%s)",
--- read-cache.c
+++ read-cache.c	Wed Apr 13 19:37:00 2005
@@ -271,27 +271,34 @@
 	/* nsec seems unreliable - not all filesystems support it, so
 	 * as long as it is in the inode cache you get right nsec
 	 * but after it gets flushed, you get zero nsec. */
-	if (ce->mtime.sec  != (unsigned int)st->st_mtim.tv_sec
+#if 0
+	if (beuint_to_cpu(ce->mtime.sec)  != (unsigned int)st->st_mtim.tv_sec
 #ifdef NSEC
-	    || ce->mtime.nsec != (unsigned int)st->st_mtim.tv_nsec
+	    || beuint_to_cpu(ce->mtime.nsec) != (unsigned int)st->st_mtim.tv_nsec
 #endif
 	    )
 		changed |= MTIME_CHANGED;
-	if (ce->ctime.sec  != (unsigned int)st->st_ctim.tv_sec
+	if (beuint_to_cpu(ce->ctime.sec)  != (unsigned int)st->st_ctim.tv_sec
 #ifdef NSEC
-	    || ce->ctime.nsec != (unsigned int)st->st_ctim.tv_nsec
+	    || beuint_to_cpu(ce->ctime.nsec) != (unsigned int)st->st_ctim.tv_nsec
 #endif
 	    )
 		changed |= CTIME_CHANGED;
-	if (ce->st_uid != (unsigned int)st->st_uid ||
-	    ce->st_gid != (unsigned int)st->st_gid)
+#else
+	if (beuint_to_cpu(ce->mtime.sec)  != (unsigned int)st->st_mtime)
+		changed |= MTIME_CHANGED;
+	if (beuint_to_cpu(ce->ctime.sec)  != (unsigned int)st->st_ctime)
+		changed |= CTIME_CHANGED;
+#endif
+	if (beuint_to_cpu(ce->st_uid) != (unsigned int)st->st_uid ||
+	    beuint_to_cpu(ce->st_gid) != (unsigned int)st->st_gid)
 		changed |= OWNER_CHANGED;
-	if (ce->st_mode != (unsigned int)st->st_mode)
+	if (beuint_to_cpu(ce->st_mode) != (unsigned int)st->st_mode)
 		changed |= MODE_CHANGED;
-	if (ce->st_dev != (unsigned int)st->st_dev ||
-	    ce->st_ino != (unsigned int)st->st_ino)
+	if (beuint_to_cpu(ce->st_dev) != (unsigned int)st->st_dev ||
+	    beuint_to_cpu(ce->st_ino) != (unsigned int)st->st_ino)
 		changed |= INODE_CHANGED;
-	if (ce->st_size != (unsigned int)st->st_size)
+	if (beuint_to_cpu(ce->st_size) != (unsigned int)st->st_size)
 		changed |= DATA_CHANGED;
 	return changed;
 }
@@ -320,7 +327,7 @@
 	while (last > first) {
 		int next = (last + first) >> 1;
 		struct cache_entry *ce = active_cache[next];
-		int cmp = cache_name_compare(name, namelen, ce->name, ce->namelen);
+		int cmp = cache_name_compare(name, namelen, ce->name, beushort_to_cpu(ce->namelen));
 		if (!cmp)
 			return next;
 		if (cmp < 0) {
@@ -347,7 +354,7 @@
 {
 	int pos;
 
-	pos = cache_name_pos(ce->name, ce->namelen);
+	pos = cache_name_pos(ce->name, beushort_to_cpu(ce->namelen));
 
 	/* existing match? Just replace it */
 	if (pos >= 0) {
@@ -378,9 +385,9 @@
 	SHA_CTX c;
 	unsigned char sha1[20];
 
-	if (hdr->signature != CACHE_SIGNATURE)
+	if (hdr->signature != cpu_to_beuint(CACHE_SIGNATURE))
 		return error("bad signature");
-	if (hdr->version != 1)
+	if (hdr->version != cpu_to_beuint(1))
 		return error("bad version");
 	SHA1_Init(&c);
 	SHA1_Update(&c, hdr, offsetof(struct cache_header, sha1));
@@ -428,12 +435,12 @@
 	if (verify_hdr(hdr, size) < 0)
 		goto unmap;
 
-	active_nr = hdr->entries;
+	active_nr = beuint_to_cpu(hdr->entries);
 	active_alloc = alloc_nr(active_nr);
 	active_cache = calloc(active_alloc, sizeof(struct cache_entry *));
 
 	offset = sizeof(*hdr);
-	for (i = 0; i < hdr->entries; i++) {
+	for (i = 0; i < beuint_to_cpu(hdr->entries); i++) {
 		struct cache_entry *ce = map + offset;
 		offset = offset + ce_size(ce);
 		active_cache[i] = ce;
@@ -452,9 +459,9 @@
 	struct cache_header hdr;
 	int i;
 
-	hdr.signature = CACHE_SIGNATURE;
-	hdr.version = 1;
-	hdr.entries = entries;
+	hdr.signature = cpu_to_beuint(CACHE_SIGNATURE);
+	hdr.version = cpu_to_beuint(1);
+	hdr.entries = cpu_to_beuint(entries);
 
 	SHA1_Init(&c);
 	SHA1_Update(&c, &hdr, offsetof(struct cache_header, sha1));
--- read-tree.c
+++ read-tree.c	Wed Apr 13 19:56:52 2005
@@ -13,8 +13,8 @@
 
 	memset(ce, 0, size);
 
-	ce->st_mode = mode;
-	ce->namelen = baselen + len;
+	ce->st_mode = cpu_to_beuint(mode);
+	ce->namelen = cpu_to_beushort(baselen + len);
 	memcpy(ce->name, base, baselen);
 	memcpy(ce->name + baselen, pathname, len+1);
 	memcpy(ce->sha1, sha1, 20);
--- show-diff.c
+++ show-diff.c	Wed Apr 13 11:27:34 2005
@@ -89,7 +89,7 @@
 		changed = cache_match_stat(ce, &st);
 		if (!changed)
 			continue;
-		printf("%.*s:  ", ce->namelen, ce->name);
+		printf("%.*s:  ", beushort_to_cpu(ce->namelen), ce->name);
 		for (n = 0; n < 20; n++)
 			printf("%02x", ce->sha1[n]);
 		printf(" %02x\n", changed);
--- update-cache.c
+++ update-cache.c	Wed Apr 13 19:55:16 2005
@@ -68,18 +68,18 @@
  */
 static void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
 {
-	ce->ctime.sec = st->st_ctime;
+	ce->ctime.sec = cpu_to_beuint(st->st_ctime);
 #ifdef NSEC
-	ce->ctime.nsec = st->st_ctim.tv_nsec;
+	ce->ctime.nsec = cpu_to_beuint(st->st_ctim.tv_nsec);
 #endif
-	ce->mtime.sec = st->st_mtime;
+	ce->mtime.sec = cpu_to_beuint(st->st_mtime);
 #ifdef NSEC
-	ce->mtime.nsec = st->st_mtim.tv_nsec;
+	ce->mtime.nsec = cpu_to_beuint(st->st_mtim.tv_nsec);
 #endif
-	ce->st_dev = st->st_dev;
-	ce->st_ino = st->st_ino;
-	ce->st_uid = st->st_uid;
-	ce->st_gid = st->st_gid;
+	ce->st_dev = cpu_to_beuint(st->st_dev);
+	ce->st_ino = cpu_to_beuint(st->st_ino);
+	ce->st_uid = cpu_to_beuint(st->st_uid);
+	ce->st_gid = cpu_to_beuint(st->st_gid);
 }
 
 static int add_file_to_cache(char *path)
@@ -106,21 +106,21 @@
 	ce = malloc(size);
 	memset(ce, 0, size);
 	memcpy(ce->name, path, namelen);
-	ce->ctime.sec = st.st_ctime;
+	ce->ctime.sec = cpu_to_beuint(st.st_ctime);
 #ifdef NSEC
-	ce->ctime.nsec = st.st_ctim.tv_nsec;
+	ce->ctime.nsec = cpu_to_beuint(st.st_ctim.tv_nsec);
 #endif
-	ce->mtime.sec = st.st_mtime;
+	ce->mtime.sec = cpu_to_beuint(st.st_mtime);
 #ifdef NSEC
-	ce->mtime.nsec = st.st_mtim.tv_nsec;
+	ce->mtime.nsec = cpu_to_beuint(st.st_mtim.tv_nsec);
 #endif
-	ce->st_dev = st.st_dev;
-	ce->st_ino = st.st_ino;
-	ce->st_mode = st.st_mode;
-	ce->st_uid = st.st_uid;
-	ce->st_gid = st.st_gid;
-	ce->st_size = st.st_size;
-	ce->namelen = namelen;
+	ce->st_dev = cpu_to_beuint(st.st_dev);
+	ce->st_ino = cpu_to_beuint(st.st_ino);
+	ce->st_mode = cpu_to_beuint(st.st_mode);
+	ce->st_uid = cpu_to_beuint(st.st_uid);
+	ce->st_gid = cpu_to_beuint(st.st_gid);
+	ce->st_size = cpu_to_beuint(st.st_size);
+	ce->namelen = cpu_to_beushort(namelen);
 
 	if (index_fd(path, namelen, ce, fd, &st) < 0)
 		return -1;
@@ -201,7 +201,7 @@
 	updated = malloc(size);
 	memcpy(updated, ce, size);
 	fill_stat_cache_info(updated, &st);
-	updated->st_size = st.st_size;
+	updated->st_size = cpu_to_beuint(st.st_size);
 	return updated;
 }
 
--- write-tree.c
+++ write-tree.c	Wed Apr 13 19:30:45 2005
@@ -45,7 +45,7 @@
 	do {
 		struct cache_entry *ce = cachep[nr];
 		const char *pathname = ce->name, *filename, *dirname;
-		int pathlen = ce->namelen, entrylen;
+		int pathlen = beushort_to_cpu(ce->namelen), entrylen;
 		unsigned char *sha1;
 		unsigned int mode;
 
@@ -54,7 +54,7 @@
 			break;
 
 		sha1 = ce->sha1;
-		mode = ce->st_mode;
+		mode = beuint_to_cpu(ce->st_mode);
 
 		/* Do we have _further_ subdirectories? */
 		filename = pathname + baselen;


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
