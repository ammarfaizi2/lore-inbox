Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267299AbTAGEy7>; Mon, 6 Jan 2003 23:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267300AbTAGEy7>; Mon, 6 Jan 2003 23:54:59 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:9673 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S267299AbTAGEy4>; Mon, 6 Jan 2003 23:54:56 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Tue, 7 Jan 2003 16:03:28 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15898.24480.346258.361959@notabene.cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Define hash_mem in lib/hash.c to apply hash_long to an arbitraty piece of memory.
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Seeing as we have a simple, elegant, and effective hash_long in
hash.h, and seeing that I need to hash things that aren't a long
(i.e. strings), I would like to propose defining "hash_mem" based on
hash_long as done in the following patch (hash_mem already exists
local to net/sunrpc/svcauth.c, this patch tidies it up and moves it to
lib/hash.c). 

It could be argued that there are better hashing functions for
strings, and indeed Andrew Morton pointed me to ext3/hash.c

I did a little testing and found that on a list of 2 million 
basenames from a recent backup index (800,000 unique):

 hash_mem (as included here) is noticably faster than HASH_HALF_MD4 or
 HASH_TEA: 

  hash_mem:		10 seconds
  DX_HASH_HALF_MD4:	14 seconds
  DX_HASH_TEA:		15.2 seconds

but that hash_mem is slightly worse at distributing the names into an
8bit space.  The normalised standard deviation of the frequencies of
the 256 possibly hash values (which you would like to be small) was:
   hash_mem:		0.0225508
   DX_HASH_HALF_MD4	0.0182673
   DX_HASH_TEA		0.0169549

so for a general-purpose internal hash function, I think hash_mem
wins :-)
Statisticians: please be gentle if I have said something silly - it's
a while since I have done much formal maths.

### Comments for ChangeSet
Define hash_mem in lib/hash.c to apply hash_long to an arbitraty piece of memory.

This moves hash_mem out of net/sunrpc/svcauth.c where it was used to hash
some strings, into lib/hash.c where it can be used by everyone.

As some achitectures don't like dereferencing unalinged longs we
always memcpy into a long if the buffer isn't aligned.

Unfortunately the 'unlikely' doesn't move the unlikely code very 
far out of the way.  It is still between the function entry and
exit points.


 ----------- Diffstat output ------------
 ./include/linux/hash.h           |    5 ++++
 ./include/linux/string.h         |    3 ++
 ./include/linux/sunrpc/svcauth.h |    7 -----
 ./lib/Makefile                   |    4 +--
 ./lib/hash.c                     |   47 +++++++++++++++++++++++++++++++++++++++
 ./net/sunrpc/svcauth.c           |   20 ----------------
 ./net/sunrpc/svcauth_unix.c      |    1 
 7 files changed, 59 insertions(+), 28 deletions(-)

diff ./include/linux/hash.h~current~ ./include/linux/hash.h
--- ./include/linux/hash.h~current~	2003-01-07 14:43:38.000000000 +1100
+++ ./include/linux/hash.h	2003-01-07 13:55:28.000000000 +1100
@@ -55,4 +55,9 @@ static inline unsigned long hash_ptr(voi
 {
 	return hash_long((unsigned long)ptr, bits);
 }
+
+
+extern unsigned long hash_mem(void *buf, unsigned int len, unsigned int bits);
+/* hash_str is also available in linux/string.h */
+
 #endif /* _LINUX_HASH_H */

diff ./include/linux/string.h~current~ ./include/linux/string.h
--- ./include/linux/string.h~current~	2003-01-07 14:43:38.000000000 +1100
+++ ./include/linux/string.h	2003-01-07 13:54:59.000000000 +1100
@@ -82,5 +82,8 @@ extern void * memchr(const void *,int,__
 }
 #endif
 
+/* #define rather than inline so hash.h isn't needed for compilation */
+#define hash_str(str,bits) hash_mem(str, strlen(str), bits)
+
 #endif
 #endif /* _LINUX_STRING_H_ */

diff ./include/linux/sunrpc/svcauth.h~current~ ./include/linux/sunrpc/svcauth.h
--- ./include/linux/sunrpc/svcauth.h~current~	2003-01-07 14:43:38.000000000 +1100
+++ ./include/linux/sunrpc/svcauth.h	2003-01-07 14:30:21.000000000 +1100
@@ -14,7 +14,6 @@
 #include <linux/string.h>
 #include <linux/sunrpc/msg_prot.h>
 #include <linux/sunrpc/cache.h>
-#include <linux/string.h>
 
 struct svc_cred {
 	uid_t			cr_uid;
@@ -113,12 +112,6 @@ extern struct auth_domain *auth_unix_loo
 extern int auth_unix_forget_old(struct auth_domain *dom);
 extern void svcauth_unix_purge(void);
 
-extern int hash_mem(char *buf, int len, int bits);
-static inline int hash_str(char *name, int bits)
-{
-	return hash_mem(name, strlen(name), bits);
-}
-
 extern struct cache_detail auth_domain_cache, ip_map_cache;
 
 #endif /* __KERNEL__ */

diff ./lib/Makefile~current~ ./lib/Makefile
--- ./lib/Makefile~current~	2003-01-07 14:43:38.000000000 +1100
+++ ./lib/Makefile	2003-01-07 13:51:45.000000000 +1100
@@ -9,11 +9,11 @@
 L_TARGET := lib.a
 
 export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o \
-	       crc32.o rbtree.o radix-tree.o kobject.o
+	       crc32.o rbtree.o radix-tree.o kobject.o hash.o
 
 obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
-	 kobject.o
+	 kobject.o hash.o
 
 obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o

diff ./lib/hash.c~current~ ./lib/hash.c
--- ./lib/hash.c~current~	2003-01-07 14:43:38.000000000 +1100
+++ ./lib/hash.c	2003-01-07 14:00:53.000000000 +1100
@@ -0,0 +1,47 @@
+/*
+ * linux/lib/hash.c
+ *
+ * No Copyright Claimed.
+ * Author: Neil Brown
+ */
+
+#include <linux/types.h>
+#include <linux/hash.h>
+#include <linux/compiler.h>
+#include <linux/module.h>
+
+#define BYTES_PER_LONG (BITS_PER_LONG/8)
+#define IsLongAligned(ptr) (((unsigned long)ptr & (BYTES_PER_LONG-1))==0)
+unsigned long hash_mem(void *buf, unsigned int len, unsigned int bits)
+{
+	int hash = 0;
+	unsigned long l;
+
+	if (unlikely(IsLongAligned(buf))) {
+
+		/* Some architectures don't like dereferencing a long
+		 * pointer that isn't aligned, so we do it by hand...
+		 */
+		while (len >= BYTES_PER_LONG) {
+			memcpy(&l, buf, BYTES_PER_LONG);
+			buf += BYTES_PER_LONG;
+			len -= BYTES_PER_LONG;
+			hash ^= hash_long(l, bits);
+		}
+	} else {
+		while (len >= BYTES_PER_LONG) {
+			l = *(unsigned long *)buf;
+			buf += BYTES_PER_LONG;
+			len -= BYTES_PER_LONG;
+			hash ^= hash_long(l, bits);
+		}
+	}
+	if (len) {
+		l=0;
+		memcpy((char*)&l, buf, len);
+		hash ^= hash_long(l, bits);
+	}
+	return hash;
+}
+
+EXPORT_SYMBOL(hash_mem);

diff ./net/sunrpc/svcauth.c~current~ ./net/sunrpc/svcauth.c
--- ./net/sunrpc/svcauth.c~current~	2003-01-07 14:43:38.000000000 +1100
+++ ./net/sunrpc/svcauth.c	2003-01-07 14:44:02.000000000 +1100
@@ -17,6 +17,7 @@
 #include <linux/sunrpc/svcauth.h>
 #include <linux/err.h>
 #include <linux/hash.h>
+#include <linux/string.h>
 
 #define RPCDBG_FACILITY	RPCDBG_AUTH
 
@@ -97,25 +98,6 @@ svc_auth_unregister(rpc_authflavor_t fla
  * it will complain.
  */
 
-int hash_mem(char *buf, int len, int bits)
-{
-	int hash = 0;
-	unsigned long l;
-	while (len >= BITS_PER_LONG/8) {
-		l = *(unsigned long *)buf;
-		buf += BITS_PER_LONG/8;
-		len -= BITS_PER_LONG/8;
-		hash ^= hash_long(l, bits);
-	}
-	if (len) {
-		l=0;
-		memcpy((char*)&l, buf, len);
-		hash ^= hash_long(l, bits);
-	}
-	return hash;
-}
-
-
 /*
  * Auth auth_domain cache is somewhat different to other caches,
  * largely because the entries are possibly of different types:

diff ./net/sunrpc/svcauth_unix.c~current~ ./net/sunrpc/svcauth_unix.c
--- ./net/sunrpc/svcauth_unix.c~current~	2003-01-07 14:43:38.000000000 +1100
+++ ./net/sunrpc/svcauth_unix.c	2003-01-07 14:31:11.000000000 +1100
@@ -7,6 +7,7 @@
 #include <linux/err.h>
 #include <linux/seq_file.h>
 #include <linux/hash.h>
+#include <linux/string.h>
 
 #define RPCDBG_FACILITY	RPCDBG_AUTH
 
