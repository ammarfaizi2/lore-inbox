Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265038AbTGCQkw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 12:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265019AbTGCQil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 12:38:41 -0400
Received: from titan.PLASMA.Xg8.DE ([212.227.110.100]:55307 "EHLO
	titan.PLASMA.Xg8.DE") by vger.kernel.org with ESMTP id S265163AbTGCQh3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 12:37:29 -0400
From: Peter Backes <rtc@helen.PLASMA.Xg8.DE>
Organization: PLASMA
To: linux-kernel@vger.kernel.org
Date: Thu, 03 Jul 2003 18:51:29 +0200
MIME-Version: 1.0
Content-type: Multipart/Mixed; boundary=Message-Boundary-17480
Subject: PATCH (2.2): Fix for misbehaving access(x, X_OK)
Reply-to: rtc@helen.PLASMA.Xg8.DE, linux-kernel@vger.kernel.org
Message-ID: <3F047B31.21524.1095A5B@localhost>
References: <3F037BB1.9318.32D79C1@localhost>
X-mailer: Pegasus Mail for Windows (v4.11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Message-Boundary-17480
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body

Hi,

here is a patch for the quirk in 2.2 kernels I reported yesterday.  I 
mostly took the changes from 2.4.9 to 2.4.10, see 
http://lists.insecure.org/lists/linux-kernel/2001/Sep/0152.html,
and applied them to 2.2.25.  Thus it is based on the patch by 
Christoph Hellwig. 

Keywords: 
	access() system call, X_OK, sys_access(), permission(), 
	vfs_permission(), execute, x-bit, root, uid 0, bash, test -x,
	/usr/bin/access -x, CAP_DAC_OVERRIDE,
	/usr/lib/rpm/find-requires: /usr/lib/rpm/perl.req: /usr/bin/perl: bad interpreter: Permission denied

Please make sure you CC me if you reply as I'm not subscribed. 

-- Peter 'Rattacresh' Backes, rtc@helen.PLASMA.Xg8.DE



--Message-Boundary-17480
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Text from file 'linux-2.2.24-permbug.patch'

--- linux/fs/namei.c.old	Fri Nov  2 17:38:46 2001
+++ linux/fs/namei.c	Thu Jul  3 02:25:52 2003
@@ -149,11 +149,23 @@
 		mode >>= 6;
 	else if (in_group_p(inode->i_gid))
 		mode >>= 3;
-	if (((mode & mask & S_IRWXO) == mask) || capable(CAP_DAC_OVERRIDE))
+	/*
+	 * If the DACs are ok we don't need any capability check.
+	 */
+	if (((mode & mask & (MAY_READ|MAY_WRITE|MAY_EXEC)) == mask))
 		return 0;
-	/* read and search access */
-	if ((mask == S_IROTH) ||
-	    (S_ISDIR(inode->i_mode)  && !(mask & ~(S_IROTH | S_IXOTH))))
+	/*
+	 * Read/write DACs are always overridable.
+	 * Executable DACs are overridable if at least one exec bit is set.
+	 */
+	if ((mask & (MAY_READ|MAY_WRITE)) || (inode->i_mode & S_IXUGO))
+		if (capable(CAP_DAC_OVERRIDE))
+			return 0;
+
+	/*
+	 * Searching includes executable on directories, else just read.
+	 */
+	if (mask == MAY_READ || (S_ISDIR(inode->i_mode) && !(mask & MAY_WRITE)))
 		if (capable(CAP_DAC_READ_SEARCH))
 			return 0;
 	return -EACCES;
--- linux/fs/ext2/acl.c.old	Sun Mar 25 18:30:36 2001
+++ linux/fs/ext2/acl.c	Thu Jul  3 03:41:10 2003
@@ -51,10 +51,23 @@
 	 * Access is always granted for root. We now check last,
          * though, for BSD process accounting correctness
 	 */
-	if (((mode & mask & S_IRWXO) == mask) || capable(CAP_DAC_OVERRIDE))
+	/*
+	 * If the DACs are ok we don't need any capability check.
+	 */
+	if (((mode & mask & (MAY_READ|MAY_WRITE|MAY_EXEC)) == mask))
 		return 0;
-	if ((mask == S_IROTH) ||
-	    (S_ISDIR(inode->i_mode)  && !(mask & ~(S_IROTH | S_IXOTH))))
+	/*
+	 * Read/write DACs are always overridable.
+	 * Executable DACs are overridable if at least one exec bit is set.
+	 */
+	if ((mask & (MAY_READ|MAY_WRITE)) || (inode->i_mode & S_IXUGO))
+		if (capable(CAP_DAC_OVERRIDE))
+			return 0;
+
+	/*
+	 * Searching includes executable on directories, else just read.
+	 */
+	if (mask == MAY_READ || (S_ISDIR(inode->i_mode) && !(mask & MAY_WRITE)))
 		if (capable(CAP_DAC_READ_SEARCH))
 			return 0;
 	return -EACCES;
--- linux/fs/ufs/acl.c.old	Sun Mar 25 18:30:37 2001
+++ linux/fs/ufs/acl.c	Thu Jul  3 03:45:39 2003
@@ -58,10 +58,23 @@
 	 * Access is always granted for root. We now check last,
 	 * though, for BSD process accounting correctness
 	 */
-	if (((mode & mask & S_IRWXO) == mask) || capable(CAP_DAC_OVERRIDE))
+	/*
+	 * If the DACs are ok we don't need any capability check.
+	 */
+	if (((mode & mask & (MAY_READ|MAY_WRITE|MAY_EXEC)) == mask))
 		return 0;
-	if ((mask == S_IROTH) ||
-	    (S_ISDIR(inode->i_mode)  && !(mask & ~(S_IROTH | S_IXOTH))))
+	/*
+	 * Read/write DACs are always overridable.
+	 * Executable DACs are overridable if at least one exec bit is set.
+	 */
+	if ((mask & (MAY_READ|MAY_WRITE)) || (inode->i_mode & S_IXUGO))
+		if (capable(CAP_DAC_OVERRIDE))
+			return 0;
+
+	/*
+	 * Searching includes executable on directories, else just read.
+	 */
+	if (mask == MAY_READ || (S_ISDIR(inode->i_mode) && !(mask & MAY_WRITE)))
 		if (capable(CAP_DAC_READ_SEARCH))
 			return 0;
 	return -EACCES;
--- linux/fs/proc/inode.c.old	Sun Mar 25 18:30:36 2001
+++ linux/fs/proc/inode.c	Thu Jul  3 03:43:56 2003
@@ -145,11 +145,23 @@
 		mode >>= 6;
 	else if (in_group_p(inode->i_gid))
 		mode >>= 3;
-	if (((mode & mask & S_IRWXO) == mask) || capable(CAP_DAC_OVERRIDE))
+	/*
+	 * If the DACs are ok we don't need any capability check.
+	 */
+	if (((mode & mask & (MAY_READ|MAY_WRITE|MAY_EXEC)) == mask))
 		return 0;
-	/* read and search access */
-	if ((mask == S_IROTH) ||
-	    (S_ISDIR(inode->i_mode)  && !(mask & ~(S_IROTH | S_IXOTH))))
+	/*
+	 * Read/write DACs are always overridable.
+	 * Executable DACs are overridable if at least one exec bit is set.
+	 */
+	if ((mask & (MAY_READ|MAY_WRITE)) || (inode->i_mode & S_IXUGO))
+		if (capable(CAP_DAC_OVERRIDE))
+			return 0;
+
+	/*
+	 * Searching includes executable on directories, else just read.
+	 */
+	if (mask == MAY_READ || (S_ISDIR(inode->i_mode) && !(mask & MAY_WRITE)))
 		if (capable(CAP_DAC_READ_SEARCH))
 			return 0;
 	return -EACCES;

--Message-Boundary-17480--
