Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbUCQQ6S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 11:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbUCQQ6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 11:58:18 -0500
Received: from smtp9.wanadoo.fr ([193.252.22.22]:42309 "EHLO
	mwinf0904.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261317AbUCQQ6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 11:58:10 -0500
Date: Wed, 17 Mar 2004 17:58:06 +0100
From: David Odin <David@dindinx.org>
To: linux-kernel@vger.kernel.org, Peter Braam <coda@cs.cmu.edu>
Cc: Pierre Pollux Chifflier <chifflier@cpe.fr>
Subject: Patch to fix the old api for codafs
Message-ID: <20040317165806.GA20948@coruscant>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline


  Hi,

The old api of the codafilesystem (96 bits) is still in use, at least
for davfs.  But, as of 2.6.4, a typo presents it to work correctly.

The attached patch fixes this, and is still valid for 2.6.5-pre1-bk2.

  Please apply,

      Regards,

          DindinX

P.S: this patch was given to me be Pollux (CC to this mail)

-- 
David@dindinx.org

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="patch-fix-coda-old-api.diff"

diff -Nru linux-2.6.4.orig/fs/coda/coda_linux.c linux-2.6.4.patched/fs/coda/coda_linux.c
--- linux-2.6.4.orig/fs/coda/coda_linux.c	2004-03-17 17:37:37.000000000 +0100
+++ linux-2.6.4.patched/fs/coda/coda_linux.c	2004-03-17 17:42:32.000000000 +0100
@@ -28,7 +28,7 @@
 char * coda_f2s(struct CodaFid *f)
 {
 	static char s[60];
-#ifdef CODA_FS_OLD_API
+#ifdef CONFIG_CODA_FS_OLD_API
  	sprintf(s, "(%08x.%08x.%08x)", f->opaque[0], f->opaque[1], f->opaque[2]);
 #else
  	sprintf(s, "(%08x.%08x.%08x.%08x)", f->opaque[0], f->opaque[1], f->opaque[2], f->opaque[3]);
diff -Nru linux-2.6.4.orig/fs/coda/psdev.c linux-2.6.4.patched/fs/coda/psdev.c
--- linux-2.6.4.orig/fs/coda/psdev.c	2004-03-17 17:37:37.000000000 +0100
+++ linux-2.6.4.patched/fs/coda/psdev.c	2004-03-17 17:42:52.000000000 +0100
@@ -385,7 +385,7 @@
 	int status;
 	int i;
 	printk(KERN_INFO "Coda Kernel/Venus communications, "
-#ifdef CODA_FS_OLD_API
+#ifdef CONFIG_CODA_FS_OLD_API
 	       "v5.3.20"
 #else
 	       "v6.0.0"
diff -Nru linux-2.6.4.orig/fs/coda/upcall.c linux-2.6.4.patched/fs/coda/upcall.c
--- linux-2.6.4.orig/fs/coda/upcall.c	2004-03-17 17:37:37.000000000 +0100
+++ linux-2.6.4.patched/fs/coda/upcall.c	2004-03-17 17:43:40.000000000 +0100
@@ -55,7 +55,7 @@
         inp->ih.opcode = opcode;
 	inp->ih.pid = current->pid;
 	inp->ih.pgid = process_group(current);
-#ifdef CODA_FS_OLD_API
+#ifdef CONFIG_CODA_FS_OLD_API
 	memset(&inp->ih.cred, 0, sizeof(struct coda_cred));
 	inp->ih.cred.cr_fsuid = current->fsuid;
 #else
@@ -172,7 +172,7 @@
         union inputArgs *inp;
         union outputArgs *outp;
         int insize, outsize, error;
-#ifdef CODA_FS_OLD_API
+#ifdef CONFIG_CODA_FS_OLD_API
 	struct coda_cred cred = { 0, };
 	cred.cr_fsuid = uid;
 #endif
@@ -180,7 +180,7 @@
 	insize = SIZE(store);
 	UPARG(CODA_STORE);
 	
-#ifdef CODA_FS_OLD_API
+#ifdef CONFIG_CODA_FS_OLD_API
 	memcpy(&(inp->ih.cred), &cred, sizeof(cred));
 #else
 	inp->ih.uid = uid;
@@ -219,7 +219,7 @@
 	union inputArgs *inp;
 	union outputArgs *outp;
 	int insize, outsize, error;
-#ifdef CODA_FS_OLD_API
+#ifdef CONFIG_CODA_FS_OLD_API
 	struct coda_cred cred = { 0, };
 	cred.cr_fsuid = uid;
 #endif
@@ -227,7 +227,7 @@
 	insize = SIZE(release);
 	UPARG(CODA_CLOSE);
 	
-#ifdef CODA_FS_OLD_API
+#ifdef CONFIG_CODA_FS_OLD_API
 	memcpy(&(inp->ih.cred), &cred, sizeof(cred));
 #else
 	inp->ih.uid = uid;
diff -Nru linux-2.6.4.orig/include/linux/coda.h linux-2.6.4.patched/include/linux/coda.h
--- linux-2.6.4.orig/include/linux/coda.h	2004-03-17 17:38:32.000000000 +0100
+++ linux-2.6.4.patched/include/linux/coda.h	2004-03-17 17:44:55.000000000 +0100
@@ -200,7 +200,7 @@
 typedef u_int32_t vgid_t;
 #endif /*_VUID_T_ */
 
-#ifdef CODA_FS_OLD_API
+#ifdef CONFIG_CODA_FS_OLD_API
 struct CodaFid {
 	u_int32_t opaque[3];
 };
@@ -220,7 +220,7 @@
     vgid_t cr_groupid, cr_egid, cr_sgid, cr_fsgid; /* same for groups */
 };
 
-#else /* not defined(CODA_FS_OLD_API) */
+#else /* not defined(CONFIG_CODA_FS_OLD_API) */
 
 struct CodaFid {
 	u_int32_t opaque[4];
@@ -318,7 +318,7 @@
 #define CODA_KERNEL_VERSION 0 /* don't care about kernel version number */
 #define CODA_KERNEL_VERSION 1 /* The old venus 4.6 compatible interface */
 #endif
-#ifdef CODA_FS_OLD_API
+#ifdef CONFIG_CODA_FS_OLD_API
 #define CODA_KERNEL_VERSION 2 /* venus_lookup got an extra parameter */
 #else
 #define CODA_KERNEL_VERSION 3 /* 128-bit file identifiers */
@@ -330,7 +330,7 @@
 struct coda_in_hdr {
     u_int32_t opcode;
     u_int32_t unique;	    /* Keep multiple outstanding msgs distinct */
-#ifdef CODA_FS_OLD_API
+#ifdef CONFIG_CODA_FS_OLD_API
     u_int16_t pid;	    /* Common to all */
     u_int16_t pgid;	    /* Common to all */
     u_int16_t sid;          /* Common to all */
@@ -614,7 +614,7 @@
 /* CODA_PURGEUSER is a venus->kernel call */
 struct coda_purgeuser_out {
     struct coda_out_hdr oh;
-#ifdef CODA_FS_OLD_API
+#ifdef CONFIG_CODA_FS_OLD_API
     struct coda_cred cred;
 #else
     vuid_t uid;

--SLDf9lqlvOQaIe6s--
