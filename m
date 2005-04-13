Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVDMJfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVDMJfx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 05:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVDMJfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 05:35:53 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62732 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261275AbVDMJf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 05:35:27 -0400
Date: Wed, 13 Apr 2005 10:35:21 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Petr Baudis <pasky@ucw.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: Re: [ANNOUNCE] git-pasky-0.3
Message-ID: <20050413103521.D1798@flint.arm.linux.org.uk>
Mail-Followup-To: Petr Baudis <pasky@ucw.cz>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Ross Vandegrift <ross@jose.lug.udel.edu>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz> <20050411015852.GI5902@pasky.ji.cz> <20050411135758.GA3524@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050411135758.GA3524@pasky.ji.cz>; from pasky@ucw.cz on Mon, Apr 11, 2005 at 03:57:58PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 03:57:58PM +0200, Petr Baudis wrote:
>   here goes git-pasky-0.3, my set of patches and scripts upon
> Linus' git, aimed at human usability and to an extent a SCM-like usage.

I tried this today, applied my patch for BE<->LE conversions and
glibc-2.2 compatibility (attached, still requires cleaning though),
and then tried git pull.  Umm, whoops.

Here's just a small sample of what happened:

diff: /9a30ec42a6c4860d3f11ad90c1052823a020de32/show-files.c: No such file or directory
diff: /85bf824bd24f034896f5820a2628148a246f8fd1/show-files.c: No such file or directory
mkdir: cannot create directory `/9a30ec42a6c4860d3f11ad90c1052823a020de32': Permission denied
mkdir: cannot create directory `/85bf824bd24f034896f5820a2628148a246f8fd1': Permission denied
./gitdiff-do: /9a30ec42a6c4860d3f11ad90c1052823a020de32/update-cache.c: No such
file or directory
./gitdiff-do: /85bf824bd24f034896f5820a2628148a246f8fd1/update-cache.c: No such
file or directory
diff: /9a30ec42a6c4860d3f11ad90c1052823a020de32/update-cache.c: No such file or
directory
diff: /85bf824bd24f034896f5820a2628148a246f8fd1/update-cache.c: No such file or
directory
patch: **** Only garbage was found in the patch input.

--- -	Wed Apr 13 09:49:43 2005
+++ cache.h	Fri Apr  8 11:15:08 2005
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
 
--- -	Wed Apr 13 09:49:43 2005
+++ read-cache.c	Fri Apr  8 11:05:34 2005
@@ -271,6 +271,7 @@
 	/* nsec seems unreliable - not all filesystems support it, so
 	 * as long as it is in the inode cache you get right nsec
 	 * but after it gets flushed, you get zero nsec. */
+#if 0
 	if (ce->mtime.sec  != (unsigned int)st->st_mtim.tv_sec
 #ifdef NSEC
 	    || ce->mtime.nsec != (unsigned int)st->st_mtim.tv_nsec
@@ -283,15 +284,21 @@
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
@@ -378,9 +378,9 @@
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
@@ -428,12 +428,12 @@
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
@@ -452,9 +452,9 @@
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
--- -	Wed Apr 13 09:49:43 2005
+++ show-diff.c	Wed Apr 13 09:49:43 2005
@@ -51,7 +51,7 @@
 			printf("%s: ok\n", ce->name);
 			continue;
 		}
-		printf("%.*s:  ", ce->namelen, ce->name);
+		printf("%.*s:  ", beushort_to_cpu(ce->namelen), ce->name);
 		for (n = 0; n < 20; n++)
 			printf("%02x", ce->sha1[n]);
 		printf(" %02x\n", changed);
--- -	Wed Apr 13 09:49:43 2005
+++ update-cache.c	Fri Apr  8 11:06:17 2005
@@ -108,11 +108,11 @@
 	memcpy(ce->name, path, namelen);
 	ce->ctime.sec = st.st_ctime;
 #ifdef NSEC
-	ce->ctime.nsec = st.st_ctim.tv_nsec;
+	ce->ctime.nsec = 0; //st.st_ctim.tv_nsec;
 #endif
 	ce->mtime.sec = st.st_mtime;
 #ifdef NSEC
-	ce->mtime.nsec = st.st_mtim.tv_nsec;
+	ce->mtime.nsec = 0; //st.st_mtim.tv_nsec;
 #endif
 	ce->st_dev = st.st_dev;
 	ce->st_ino = st.st_ino;

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
