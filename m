Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161368AbWI1XwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161368AbWI1XwN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 19:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161369AbWI1XwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 19:52:13 -0400
Received: from ihug-mail.icp-qv1-irony2.iinet.net.au ([203.59.1.196]:24842
	"EHLO mail-ihug.icp-qv1-irony2.iinet.net.au") by vger.kernel.org
	with ESMTP id S1161368AbWI1XwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 19:52:12 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.09,232,1157299200"; 
   d="scan'208"; a="653743621:sNHT22392448"
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DFBF9875-2950-46F4-B2AF-05123DE55E6F@cray.com>
Content-Transfer-Encoding: 7bit
From: Tim Burgess <burgesst@cray.com>
Subject: [PATCH] Fudge block count for 32-bit statfs() of large filesystems
Date: Fri, 29 Sep 2006 09:52:00 +1000
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently we have noticed that apps running in compatibility mode on  
x86_64 could not statfs() the filesystem (e.g. just to check for free  
space remaining).  While it is true that these applications should  
probably be using the 64-bit call, we have worked around the problem  
with a fudge to compat.c enabling statfs() to return a larger block  
size and a smaller block count.

I realise this is a horrible hack, just wanted to open a discussion  
about possible alternatives!  In i386 Linux the filesystem code  
itself is able to make the decision to return bogus values (since it  
knows the caller is 32-bit), but in x86_64 it appears that the  
filesystem-specific code is unable to distinguish between 32- and 64- 
bit callers.

The patch is untested, but we are currently testing a slightly  
different but equivalent patch to a Redhat Enterprise Linux kernel.


--- linux-2.6.18/fs/compat.c.orig	2006-09-29 09:22:32.000000000 +1000
+++ linux-2.6.18/fs/compat.c	2006-09-29 09:32:28.000000000 +1000
@@ -164,11 +164,34 @@ asmlinkage long compat_sys_newfstat(unsi
static int put_compat_statfs(struct compat_statfs __user *ubuf,  
struct kstatfs *kbuf)
{
+	/*
+	 * Large filesystems often have block counts that cannot be  
represented in 32 bits.
+	 * Rather than returning EFAULT to 32-bit apps in compatibility  
mode, we fudge
+	 * the blocksize upwards to keep the block count < 2^32
+	 *
+	 * For now the maximum 'fudge factor' is 16, i.e. the block size  
will be <<4
+	 * and the block count will be >>4.
+	 */
+	int block_shift = 0;
	
	if (sizeof ubuf->f_blocks == 4) {
		if ((kbuf->f_blocks | kbuf->f_bfree | kbuf->f_bavail) &
-		    0xffffffff00000000ULL)
+		    0xfffffff000000000ULL)
			return -EOVERFLOW;
+
+		if ((kbuf->f_blocks | kbuf->f_bfree | kbuf->f_bavail) &
+		    0xfffffff800000000ULL)
+			block_shift = 4;
+		else if ((kbuf->f_blocks | kbuf->f_bfree | kbuf->f_bavail) &
+		    0xfffffffc00000000ULL)
+			block_shift = 3;
+		else if ((kbuf->f_blocks | kbuf->f_bfree | kbuf->f_bavail) &
+		    0xfffffffe00000000ULL)
+			block_shift = 2;
+		else if ((kbuf->f_blocks | kbuf->f_bfree | kbuf->f_bavail) &
+		    0xffffffff00000000ULL)
+			block_shift = 1;
+
		/* f_files and f_ffree may be -1; it's okay
		 * to stuff that into 32 bits */
		if (kbuf->f_files != 0xffffffffffffffffULL
@@ -180,10 +203,10 @@ static int put_compat_statfs(struct comp
	}
	if (!access_ok(VERIFY_WRITE, ubuf, sizeof(*ubuf)) ||
	    __put_user(kbuf->f_type, &ubuf->f_type) ||
-	    __put_user(kbuf->f_bsize, &ubuf->f_bsize) ||
-	    __put_user(kbuf->f_blocks, &ubuf->f_blocks) ||
-	    __put_user(kbuf->f_bfree, &ubuf->f_bfree) ||
-	    __put_user(kbuf->f_bavail, &ubuf->f_bavail) ||
+	    __put_user(kbuf->f_bsize << block_shift, &ubuf->f_bsize) ||
+	    __put_user(kbuf->f_blocks >> block_shift, &ubuf->f_blocks) ||
+	    __put_user(kbuf->f_bfree >> block_shift, &ubuf->f_bfree) ||
+	    __put_user(kbuf->f_bavail >> block_shift, &ubuf->f_bavail) ||
	    __put_user(kbuf->f_files, &ubuf->f_files) ||
	    __put_user(kbuf->f_ffree, &ubuf->f_ffree) ||
	    __put_user(kbuf->f_namelen, &ubuf->f_namelen) ||
@@ -239,10 +262,34 @@ out:
static int put_compat_statfs64(struct compat_statfs64 __user *ubuf,  
struct kstatfs *kbuf)
{
+	/*
+	 * Large filesystems often have block counts that cannot be  
represented in 32 bits.
+	 * Rather than returning EFAULT to 32-bit apps in compatibility  
mode, we fudge
+	 * the blocksize upwards to keep the block count < 2^32
+	 *
+	 * For now the maximum 'fudge factor' is 16, i.e. the block size  
will be <<4
+	 * and the block count will be >>4.
+	 */
+	int block_shift = 0;
+	
	if (sizeof ubuf->f_blocks == 4) {
		if ((kbuf->f_blocks | kbuf->f_bfree | kbuf->f_bavail) &
-		    0xffffffff00000000ULL)
+		    0xfffffff000000000ULL)
			return -EOVERFLOW;
+
+		if ((kbuf->f_blocks | kbuf->f_bfree | kbuf->f_bavail) &
+		    0xfffffff800000000ULL)
+			block_shift = 4;
+		else if ((kbuf->f_blocks | kbuf->f_bfree | kbuf->f_bavail) &
+		    0xfffffffc00000000ULL)
+			block_shift = 3;
+		else if ((kbuf->f_blocks | kbuf->f_bfree | kbuf->f_bavail) &
+		    0xfffffffe00000000ULL)
+			block_shift = 2;
+		else if ((kbuf->f_blocks | kbuf->f_bfree | kbuf->f_bavail) &
+		    0xffffffff00000000ULL)
+			block_shift = 1;
+
		/* f_files and f_ffree may be -1; it's okay
		 * to stuff that into 32 bits */
		if (kbuf->f_files != 0xffffffffffffffffULL
@@ -254,10 +301,10 @@ static int put_compat_statfs64(struct co
	}
	if (!access_ok(VERIFY_WRITE, ubuf, sizeof(*ubuf)) ||
	    __put_user(kbuf->f_type, &ubuf->f_type) ||
-	    __put_user(kbuf->f_bsize, &ubuf->f_bsize) ||
-	    __put_user(kbuf->f_blocks, &ubuf->f_blocks) ||
-	    __put_user(kbuf->f_bfree, &ubuf->f_bfree) ||
-	    __put_user(kbuf->f_bavail, &ubuf->f_bavail) ||
+	    __put_user(kbuf->f_bsize << block_shift, &ubuf->f_bsize) ||
+	    __put_user(kbuf->f_blocks >> block_shift, &ubuf->f_blocks) ||
+	    __put_user(kbuf->f_bfree >> block_shift, &ubuf->f_bfree) ||
+	    __put_user(kbuf->f_bavail >> block_shift, &ubuf->f_bavail) ||
	    __put_user(kbuf->f_files, &ubuf->f_files) ||
	    __put_user(kbuf->f_ffree, &ubuf->f_ffree) ||
	    __put_user(kbuf->f_namelen, &ubuf->f_namelen) ||
