Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267234AbUIAPrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267234AbUIAPrJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 11:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267189AbUIAPpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:45:23 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:48114 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S267195AbUIAPlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:41:24 -0400
To: jakub@redhat.com, ak@suse.de, ecd@skynet.be, pavel@suse.cz
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/compat.c: rwsem instead of BKL around ioctl32_hash_table
X-Message-Flag: Warning: May contain useful information
References: <20040901072245.GF13749@mellanox.co.il>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 01 Sep 2004 08:40:15 -0700
In-Reply-To: <20040901072245.GF13749@mellanox.co.il> (Michael S. Tsirkin's
 message of "Wed, 1 Sep 2004 10:22:45 +0300")
Message-ID: <524qmi2e1s.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 Sep 2004 15:40:15.0609 (UTC) FILETIME=[FA0FC690:01C49039]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the BKL is used to synchronize access to ioctl32_hash_table
in fs/compat.c.  It seems that an rwsem would be more appropriate,
since this would allow multiple lookups to occur in parallel (and also
serve the general good of minimizing use of the BKL).

I added lock_kernel()/unlock_kernel() around the call to t->handler
when a compatibility handler is found in compat_sys_ioctl() to
preserve the expectation that the BKL will be held during driver ioctl
operations.  It should be safe to do lock_kernel() while holding
ioctl32_sem because of the magic BKL sleep semantics.

I have booted this and run some basic 32-bit userspace on ppc64, and
also compile tested this for x86_64 and sparc64.

Thanks,
  Roland

Signed-off-by: Roland Dreier <roland@topspin.com>

Index: linux-bk/fs/compat.c
===================================================================
--- linux-bk.orig/fs/compat.c	2004-09-01 00:57:03.000000000 -0700
+++ linux-bk/fs/compat.c	2004-09-01 07:21:20.000000000 -0700
@@ -41,6 +41,7 @@
 #include <linux/nfsd/nfsd.h>
 #include <linux/nfsd/syscall.h>
 #include <linux/personality.h>
+#include <linux/rwsem.h>
 
 #include <net/sock.h>		/* siocdevprivate_ioctl */
 
@@ -247,7 +248,8 @@
 /* ioctl32 stuff, used by sparc64, parisc, s390x, ppc64, x86_64, MIPS */
 
 #define IOCTL_HASHSIZE 256
-struct ioctl_trans *ioctl32_hash_table[IOCTL_HASHSIZE];
+static struct ioctl_trans *ioctl32_hash_table[IOCTL_HASHSIZE];
+static DECLARE_RWSEM(ioctl32_sem);
 
 extern struct ioctl_trans ioctl_start[];
 extern int ioctl_table_size;
@@ -302,12 +304,12 @@
 	if (!new_t)
 		return -ENOMEM;
 
-	lock_kernel(); 
+	down_write(&ioctl32_sem);
 	for (t = ioctl32_hash_table[hash]; t; t = t->next) {
 		if (t->cmd == cmd) {
 			printk(KERN_ERR "Trying to register duplicated ioctl32 "
 					"handler %x\n", cmd);
-			unlock_kernel();
+			up_write(&ioctl32_sem);
 			kfree(new_t);
 			return -EINVAL; 
 		}
@@ -317,7 +319,7 @@
 	new_t->handler = handler;
 	ioctl32_insert_translation(new_t);
 
-	unlock_kernel();
+	up_write(&ioctl32_sem);
 	return 0;
 }
 EXPORT_SYMBOL(register_ioctl32_conversion);
@@ -337,11 +339,11 @@
 	unsigned long hash = ioctl32_hash(cmd);
 	struct ioctl_trans *t, *t1;
 
-	lock_kernel(); 
+	down_write(&ioctl32_sem);
 
 	t = ioctl32_hash_table[hash];
 	if (!t) { 
-		unlock_kernel();
+		up_write(&ioctl32_sem);
 		return -EINVAL;
 	} 
 
@@ -351,7 +353,7 @@
 			       __builtin_return_address(0), cmd);
 		} else { 
 			ioctl32_hash_table[hash] = t->next;
-			unlock_kernel();
+			up_write(&ioctl32_sem);
 			kfree(t);
 			return 0;
 		}
@@ -366,7 +368,7 @@
 				goto out;
 			} else { 
 				t->next = t1->next;
-				unlock_kernel();
+				up_write(&ioctl32_sem);
 				kfree(t1);
 				return 0;
 			}
@@ -376,7 +378,7 @@
 	printk(KERN_ERR "Trying to free unknown 32bit ioctl handler %x\n",
 				cmd);
 out:
-	unlock_kernel();
+	up_write(&ioctl32_sem);
 	return -EINVAL;
 }
 EXPORT_SYMBOL(unregister_ioctl32_conversion); 
@@ -397,7 +399,7 @@
 		goto out;
 	}
 
-	lock_kernel();
+	down_read(&ioctl32_sem);
 
 	t = ioctl32_hash_table[ioctl32_hash (cmd)];
 
@@ -405,14 +407,16 @@
 		t = t->next;
 	if (t) {
 		if (t->handler) { 
+			lock_kernel();
 			error = t->handler(fd, cmd, arg, filp);
 			unlock_kernel();
+			up_read(&ioctl32_sem);
 		} else {
-			unlock_kernel();
+			up_read(&ioctl32_sem);
 			error = sys_ioctl(fd, cmd, arg);
 		}
 	} else {
-		unlock_kernel();
+		up_read(&ioctl32_sem);
 		if (cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15)) {
 			error = siocdevprivate_ioctl(fd, cmd, arg);
 		} else {
