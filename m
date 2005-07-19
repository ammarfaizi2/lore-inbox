Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVGSDjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVGSDjQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 23:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVGSDjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 23:39:16 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:55238 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261268AbVGSDjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 23:39:14 -0400
Date: Tue, 19 Jul 2005 13:38:53 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ppc64-dev <linuxppc64-dev@ozlabs.org>,
       davem@davemloft.net, ralf@linux-mips.org, tony.luck@intel.com,
       ak@suse.de, willy@debian.org, schwidefsky@de.ibm.com, paulus@samba.org
Subject: [PATCH] compat: be more consistent about [ug]id_t
Message-Id: <20050719133853.7ce48b06.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

When I first wrote the compat layer patches, I was somewhat cavalier about the
definition of compat_uid_t and compat_gid_t (or maybe I just misunderstood :-)).
This patch makes the compat types much more consistent with the types we are being
compatible with and hopefully will fix a few bugs along the way.

	compat type		type in compat arch
	__compat_[ug]id_t	__kernel_[ug]id_t
	__compat_[ug]id32_t	__kernel_[ug]id32_t
	compat_[ug]id_t		[ug]id_t

The difference is that compat_uid_t is always 32 bits (for the archs we care about) but
__compat_uid_t may be 16 bits on some.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/mips/kernel/linux32.c   |   16 ++++++++--------
 fs/compat.c                  |   16 ++++++++--------
 include/asm-ia64/compat.h    |   20 ++++++++++----------
 include/asm-mips/compat.h    |   10 ++++++----
 include/asm-parisc/compat.h  |   10 ++++++----
 include/asm-ppc64/compat.h   |   18 ++++++++++--------
 include/asm-s390/compat.h    |   20 ++++++++++----------
 include/asm-sparc64/compat.h |   18 ++++++++++--------
 include/asm-x86_64/compat.h  |   20 ++++++++++----------
 include/linux/compat.h       |    3 +++
 ipc/compat.c                 |   12 ++++++------
 11 files changed, 87 insertions(+), 76 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruNp linus/arch/mips/kernel/linux32.c linus-compat_uid_t/arch/mips/kernel/linux32.c
--- linus/arch/mips/kernel/linux32.c	2005-06-27 16:08:00.000000000 +1000
+++ linus-compat_uid_t/arch/mips/kernel/linux32.c	2005-06-27 17:40:08.000000000 +1000
@@ -546,20 +546,20 @@ struct msgbuf32 { s32 mtype; char mtext[
 struct ipc_perm32
 {
 	key_t    	  key;
-        compat_uid_t  uid;
-        compat_gid_t  gid;
-        compat_uid_t  cuid;
-        compat_gid_t  cgid;
+        __compat_uid_t  uid;
+        __compat_gid_t  gid;
+        __compat_uid_t  cuid;
+        __compat_gid_t  cgid;
         compat_mode_t	mode;
         unsigned short  seq;
 };
 
 struct ipc64_perm32 {
 	key_t key;
-	compat_uid_t uid;
-	compat_gid_t gid;
-	compat_uid_t cuid;
-	compat_gid_t cgid;
+	__compat_uid_t uid;
+	__compat_gid_t gid;
+	__compat_uid_t cuid;
+	__compat_gid_t cgid;
 	compat_mode_t	mode; 
 	unsigned short	seq;
 	unsigned short __pad1;
diff -ruNp linus/fs/compat.c linus-compat_uid_t/fs/compat.c
--- linus/fs/compat.c	2005-07-13 15:13:18.000000000 +1000
+++ linus-compat_uid_t/fs/compat.c	2005-07-13 16:26:29.000000000 +1000
@@ -720,14 +720,14 @@ compat_sys_io_submit(aio_context_t ctx_i
 struct compat_ncp_mount_data {
 	compat_int_t version;
 	compat_uint_t ncp_fd;
-	compat_uid_t mounted_uid;
+	__compat_uid_t mounted_uid;
 	compat_pid_t wdog_pid;
 	unsigned char mounted_vol[NCP_VOLNAME_LEN + 1];
 	compat_uint_t time_out;
 	compat_uint_t retry_count;
 	compat_uint_t flags;
-	compat_uid_t uid;
-	compat_gid_t gid;
+	__compat_uid_t uid;
+	__compat_gid_t gid;
 	compat_mode_t file_mode;
 	compat_mode_t dir_mode;
 };
@@ -784,9 +784,9 @@ static void *do_ncp_super_data_conv(void
 
 struct compat_smb_mount_data {
 	compat_int_t version;
-	compat_uid_t mounted_uid;
-	compat_uid_t uid;
-	compat_gid_t gid;
+	__compat_uid_t mounted_uid;
+	__compat_uid_t uid;
+	__compat_gid_t gid;
 	compat_mode_t file_mode;
 	compat_mode_t dir_mode;
 };
@@ -1808,8 +1808,8 @@ struct compat_nfsctl_export {
 	compat_dev_t	ex32_dev;
 	compat_ino_t	ex32_ino;
 	compat_int_t	ex32_flags;
-	compat_uid_t	ex32_anon_uid;
-	compat_gid_t	ex32_anon_gid;
+	__compat_uid_t	ex32_anon_uid;
+	__compat_gid_t	ex32_anon_gid;
 };
 
 struct compat_nfsctl_fdparm {
diff -ruNp linus/include/asm-ia64/compat.h linus-compat_uid_t/include/asm-ia64/compat.h
--- linus/include/asm-ia64/compat.h	2005-06-27 16:08:06.000000000 +1000
+++ linus-compat_uid_t/include/asm-ia64/compat.h	2005-06-27 17:40:08.000000000 +1000
@@ -13,10 +13,10 @@ typedef s32		compat_time_t;
 typedef s32		compat_clock_t;
 typedef s32		compat_key_t;
 typedef s32		compat_pid_t;
-typedef u16		compat_uid_t;
-typedef u16		compat_gid_t;
-typedef u32		compat_uid32_t;
-typedef u32		compat_gid32_t;
+typedef u16		__compat_uid_t;
+typedef u16		__compat_gid_t;
+typedef u32		__compat_uid32_t;
+typedef u32		__compat_gid32_t;
 typedef u16		compat_mode_t;
 typedef u32		compat_ino_t;
 typedef u16		compat_dev_t;
@@ -50,8 +50,8 @@ struct compat_stat {
 	compat_ino_t	st_ino;
 	compat_mode_t	st_mode;
 	compat_nlink_t	st_nlink;
-	compat_uid_t	st_uid;
-	compat_gid_t	st_gid;
+	__compat_uid_t	st_uid;
+	__compat_gid_t	st_gid;
 	compat_dev_t	st_rdev;
 	u16		__pad2;
 	u32		st_size;
@@ -120,10 +120,10 @@ typedef u32		compat_sigset_word;
 
 struct compat_ipc64_perm {
 	compat_key_t key;
-	compat_uid32_t uid;
-	compat_gid32_t gid;
-	compat_uid32_t cuid;
-	compat_gid32_t cgid;
+	__compat_uid32_t uid;
+	__compat_gid32_t gid;
+	__compat_uid32_t cuid;
+	__compat_gid32_t cgid;
 	unsigned short mode;
 	unsigned short __pad1;
 	unsigned short seq;
diff -ruNp linus/include/asm-mips/compat.h linus-compat_uid_t/include/asm-mips/compat.h
--- linus/include/asm-mips/compat.h	2005-06-27 16:08:07.000000000 +1000
+++ linus-compat_uid_t/include/asm-mips/compat.h	2005-06-27 17:40:08.000000000 +1000
@@ -15,8 +15,10 @@ typedef s32		compat_clock_t;
 typedef s32		compat_suseconds_t;
 
 typedef s32		compat_pid_t;
-typedef s32		compat_uid_t;
-typedef s32		compat_gid_t;
+typedef u32		__compat_uid_t;
+typedef u32		__compat_gid_t;
+typedef u32		__compat_uid32_t;
+typedef u32		__compat_gid32_t;
 typedef u32		compat_mode_t;
 typedef u32		compat_ino_t;
 typedef u32		compat_dev_t;
@@ -52,8 +54,8 @@ struct compat_stat {
 	compat_ino_t	st_ino;
 	compat_mode_t	st_mode;
 	compat_nlink_t	st_nlink;
-	compat_uid_t	st_uid;
-	compat_gid_t	st_gid;
+	__compat_uid32_t	st_uid;
+	__compat_gid32_t	st_gid;
 	compat_dev_t	st_rdev;
 	s32		st_pad2[2];
 	compat_off_t	st_size;
diff -ruNp linus/include/asm-parisc/compat.h linus-compat_uid_t/include/asm-parisc/compat.h
--- linus/include/asm-parisc/compat.h	2005-06-27 16:08:08.000000000 +1000
+++ linus-compat_uid_t/include/asm-parisc/compat.h	2005-06-27 17:40:08.000000000 +1000
@@ -13,8 +13,10 @@ typedef s32	compat_ssize_t;
 typedef s32	compat_time_t;
 typedef s32	compat_clock_t;
 typedef s32	compat_pid_t;
-typedef u32	compat_uid_t;
-typedef u32	compat_gid_t;
+typedef u32	__compat_uid_t;
+typedef u32	__compat_gid_t;
+typedef u32	__compat_uid32_t;
+typedef u32	__compat_gid32_t;
 typedef u16	compat_mode_t;
 typedef u32	compat_ino_t;
 typedef u32	compat_dev_t;
@@ -67,8 +69,8 @@ struct compat_stat {
 	compat_dev_t		st_realdev;
 	u16			st_basemode;
 	u16			st_spareshort;
-	compat_uid_t		st_uid;
-	compat_gid_t		st_gid;
+	__compat_uid32_t	st_uid;
+	__compat_gid32_t	st_gid;
 	u32			st_spare4[3];
 };
 
diff -ruNp linus/include/asm-ppc64/compat.h linus-compat_uid_t/include/asm-ppc64/compat.h
--- linus/include/asm-ppc64/compat.h	2005-06-27 16:08:08.000000000 +1000
+++ linus-compat_uid_t/include/asm-ppc64/compat.h	2005-06-27 17:40:08.000000000 +1000
@@ -13,8 +13,10 @@ typedef s32		compat_ssize_t;
 typedef s32		compat_time_t;
 typedef s32		compat_clock_t;
 typedef s32		compat_pid_t;
-typedef u32		compat_uid_t;
-typedef u32		compat_gid_t;
+typedef u32		__compat_uid_t;
+typedef u32		__compat_gid_t;
+typedef u32		__compat_uid32_t;
+typedef u32		__compat_gid32_t;
 typedef u32		compat_mode_t;
 typedef u32		compat_ino_t;
 typedef u32		compat_dev_t;
@@ -48,8 +50,8 @@ struct compat_stat {
 	compat_ino_t	st_ino;
 	compat_mode_t	st_mode;
 	compat_nlink_t	st_nlink;	
-	compat_uid_t	st_uid;
-	compat_gid_t	st_gid;
+	__compat_uid32_t	st_uid;
+	__compat_gid32_t	st_gid;
 	compat_dev_t	st_rdev;
 	compat_off_t	st_size;
 	compat_off_t	st_blksize;
@@ -144,10 +146,10 @@ static inline void __user *compat_alloc_
  */
 struct compat_ipc64_perm {
 	compat_key_t key;
-	compat_uid_t uid;
-	compat_gid_t gid;
-	compat_uid_t cuid;
-	compat_gid_t cgid;
+	__compat_uid_t uid;
+	__compat_gid_t gid;
+	__compat_uid_t cuid;
+	__compat_gid_t cgid;
 	compat_mode_t mode;
 	unsigned int seq;
 	unsigned int __pad2;
diff -ruNp linus/include/asm-s390/compat.h linus-compat_uid_t/include/asm-s390/compat.h
--- linus/include/asm-s390/compat.h	2005-06-27 16:08:09.000000000 +1000
+++ linus-compat_uid_t/include/asm-s390/compat.h	2005-06-27 17:40:08.000000000 +1000
@@ -13,10 +13,10 @@ typedef s32		compat_ssize_t;
 typedef s32		compat_time_t;
 typedef s32		compat_clock_t;
 typedef s32		compat_pid_t;
-typedef u16		compat_uid_t;
-typedef u16		compat_gid_t;
-typedef u32		compat_uid32_t;
-typedef u32		compat_gid32_t;
+typedef u16		__compat_uid_t;
+typedef u16		__compat_gid_t;
+typedef u32		__compat_uid32_t;
+typedef u32		__compat_gid32_t;
 typedef u16		compat_mode_t;
 typedef u32		compat_ino_t;
 typedef u16		compat_dev_t;
@@ -51,8 +51,8 @@ struct compat_stat {
 	compat_ino_t	st_ino;
 	compat_mode_t	st_mode;
 	compat_nlink_t	st_nlink;
-	compat_uid_t	st_uid;
-	compat_gid_t	st_gid;
+	__compat_uid_t	st_uid;
+	__compat_gid_t	st_gid;
 	compat_dev_t	st_rdev;
 	u16		__pad2;
 	u32		st_size;
@@ -140,10 +140,10 @@ static inline void __user *compat_alloc_
 
 struct compat_ipc64_perm {
 	compat_key_t key;
-	compat_uid32_t uid;
-	compat_gid32_t gid;
-	compat_uid32_t cuid;
-	compat_gid32_t cgid;
+	__compat_uid32_t uid;
+	__compat_gid32_t gid;
+	__compat_uid32_t cuid;
+	__compat_gid32_t cgid;
 	compat_mode_t mode;
 	unsigned short __pad1;
 	unsigned short seq;
diff -ruNp linus/include/asm-sparc64/compat.h linus-compat_uid_t/include/asm-sparc64/compat.h
--- linus/include/asm-sparc64/compat.h	2005-06-27 16:08:10.000000000 +1000
+++ linus-compat_uid_t/include/asm-sparc64/compat.h	2005-06-27 17:40:08.000000000 +1000
@@ -12,8 +12,10 @@ typedef s32		compat_ssize_t;
 typedef s32		compat_time_t;
 typedef s32		compat_clock_t;
 typedef s32		compat_pid_t;
-typedef u16		compat_uid_t;
-typedef u16		compat_gid_t;
+typedef u16		__compat_uid_t;
+typedef u16		__compat_gid_t;
+typedef u32		__compat_uid32_t;
+typedef u32		__compat_gid32_t;
 typedef u16		compat_mode_t;
 typedef u32		compat_ino_t;
 typedef u16		compat_dev_t;
@@ -47,8 +49,8 @@ struct compat_stat {
 	compat_ino_t	st_ino;
 	compat_mode_t	st_mode;
 	compat_nlink_t	st_nlink;
-	compat_uid_t	st_uid;
-	compat_gid_t	st_gid;
+	__compat_uid_t	st_uid;
+	__compat_gid_t	st_gid;
 	compat_dev_t	st_rdev;
 	compat_off_t	st_size;
 	compat_time_t	st_atime;
@@ -177,10 +179,10 @@ static __inline__ void __user *compat_al
 
 struct compat_ipc64_perm {
 	compat_key_t key;
-	__kernel_uid_t uid;
-	__kernel_gid_t gid;
-	__kernel_uid_t cuid;
-	__kernel_gid_t cgid;
+	__compat_uid32_t uid;
+	__compat_gid32_t gid;
+	__compat_uid32_t cuid;
+	__compat_gid32_t cgid;
 	unsigned short __pad1;
 	compat_mode_t mode;
 	unsigned short __pad2;
diff -ruNp linus/include/asm-x86_64/compat.h linus-compat_uid_t/include/asm-x86_64/compat.h
--- linus/include/asm-x86_64/compat.h	2005-06-27 16:08:10.000000000 +1000
+++ linus-compat_uid_t/include/asm-x86_64/compat.h	2005-06-27 17:40:08.000000000 +1000
@@ -14,10 +14,10 @@ typedef s32		compat_ssize_t;
 typedef s32		compat_time_t;
 typedef s32		compat_clock_t;
 typedef s32		compat_pid_t;
-typedef u16		compat_uid_t;
-typedef u16		compat_gid_t;
-typedef u32		compat_uid32_t;
-typedef u32		compat_gid32_t;
+typedef u16		__compat_uid_t;
+typedef u16		__compat_gid_t;
+typedef u32		__compat_uid32_t;
+typedef u32		__compat_gid32_t;
 typedef u16		compat_mode_t;
 typedef u32		compat_ino_t;
 typedef u16		compat_dev_t;
@@ -52,8 +52,8 @@ struct compat_stat {
 	compat_ino_t	st_ino;
 	compat_mode_t	st_mode;
 	compat_nlink_t	st_nlink;
-	compat_uid_t	st_uid;
-	compat_gid_t	st_gid;
+	__compat_uid_t	st_uid;
+	__compat_gid_t	st_gid;
 	compat_dev_t	st_rdev;
 	u16		__pad2;
 	u32		st_size;
@@ -122,10 +122,10 @@ typedef u32               compat_sigset_
 
 struct compat_ipc64_perm {
 	compat_key_t key;
-	compat_uid32_t uid;
-	compat_gid32_t gid;
-	compat_uid32_t cuid;
-	compat_gid32_t cgid;
+	__compat_uid32_t uid;
+	__compat_gid32_t gid;
+	__compat_uid32_t cuid;
+	__compat_gid32_t cgid;
 	unsigned short mode;
 	unsigned short __pad1;
 	unsigned short seq;
diff -ruNp linus/include/linux/compat.h linus-compat_uid_t/include/linux/compat.h
--- linus/include/linux/compat.h	2005-06-27 16:08:11.000000000 +1000
+++ linus-compat_uid_t/include/linux/compat.h	2005-06-27 17:40:08.000000000 +1000
@@ -18,6 +18,9 @@
 #define compat_jiffies_to_clock_t(x)	\
 		(((unsigned long)(x) * COMPAT_USER_HZ) / HZ)
 
+typedef __compat_uid32_t	compat_uid_t;
+typedef __compat_gid32_t	compat_gid_t;
+
 struct rusage;
 
 struct compat_itimerspec { 
diff -ruNp linus/ipc/compat.c linus-compat_uid_t/ipc/compat.c
--- linus/ipc/compat.c	2005-07-08 15:18:28.000000000 +1000
+++ linus-compat_uid_t/ipc/compat.c	2005-07-08 15:23:00.000000000 +1000
@@ -42,10 +42,10 @@ struct compat_msgbuf {
 
 struct compat_ipc_perm {
 	key_t key;
-	compat_uid_t uid;
-	compat_gid_t gid;
-	compat_uid_t cuid;
-	compat_gid_t cgid;
+	__compat_uid_t uid;
+	__compat_gid_t gid;
+	__compat_uid_t cuid;
+	__compat_gid_t cgid;
 	compat_mode_t mode;
 	unsigned short seq;
 };
@@ -174,8 +174,8 @@ static inline int __put_compat_ipc_perm(
 					struct compat_ipc_perm __user *up)
 {
 	int err;
-	compat_uid_t u;
-	compat_gid_t g;
+	__compat_uid_t u;
+	__compat_gid_t g;
 
 	err  = __put_user(p->key, &up->key);
 	SET_UID(u, p->uid);
