Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270541AbRHHRdS>; Wed, 8 Aug 2001 13:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270542AbRHHRdP>; Wed, 8 Aug 2001 13:33:15 -0400
Received: from ns.caldera.de ([212.34.180.1]:22456 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S270541AbRHHRdE>;
	Wed, 8 Aug 2001 13:33:04 -0400
Date: Wed, 8 Aug 2001 19:32:28 +0200
From: Christoph Hellwig <hch@caldera.de>
To: torvalds@transmeta.com
Cc: alan@redhat.com, linux-kernel@vger.kernel.org,
        linux-privs-discuss@sourceforge.net
Subject: Re: [Linux-privs-discuss] [PATCH] fix permission checks for executables
Message-ID: <20010808193228.A22007@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	torvalds@transmeta.com, alan@redhat.com,
	linux-kernel@vger.kernel.org, linux-privs-discuss@sourceforge.net
In-Reply-To: <20010808182219.A12652@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010808182219.A12652@caldera.de>; from hch@caldera.de on Wed, Aug 08, 2001 at 06:22:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2001 at 06:22:19PM +0200, Christoph Hellwig wrote:
> Hi Linux,
> 
> vfs_permission in the Linux 2.4 series tries to check for
> CAP_DAC_OVERRIDE if the modes didn't match.  This means even
> for an file without executable bits set at all, root will
> be reported that it is.   I've actually found one apllication
> (scomail under linux-abi) that fails because of this, besides
> not matching my reading of Posix 1003.1e.
> 
> Of the operating systems with capabilty-like features at least
> OpenUNIX gets it right, of the others at least OpenServer and
> 4.4BSD, but these semantics seem natural to me anyway..

Andreas Gruenbacher pointed out that it is much leaner to use
MAY_READ¸MAY_EXEC and MAY_WRITE instead of abusing the stat-macros.

Here is a patch that changes the complete function to use these
and also cleans up and clarifies the comments.

	Christoph


--- linux.really_plain/fs/namei.c	Wed Aug  8 17:56:58 2001
+++ linux.plain/fs/namei.c	Wed Aug  8 19:27:19 2001
@@ -140,7 +140,7 @@
 }
 
 /*
- *	permission()
+ *	vfs_permission()
  *
  * is used to check for read/write/execute permissions on a file.
  * We use "fsuid" for this, letting us set arbitrary permissions
@@ -151,24 +151,40 @@
 {
 	int mode = inode->i_mode;
 
-	if ((mask & S_IWOTH) && IS_RDONLY(inode) &&
-		 (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)))
-		return -EROFS; /* Nobody gets write access to a read-only fs */
-
-	if ((mask & S_IWOTH) && IS_IMMUTABLE(inode))
-		return -EACCES; /* Nobody gets write access to an immutable file */
+	if (mask & MAY_WRITE) {
+		/*
+		 * Nobody gets write access to a read-only fs.
+		 */
+		if (IS_RDONLY(inode) &&
+		    (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)))
+			return -EROFS;
+
+		/*
+		 * Nobody gets write access to an immutable file.
+		 */
+		if (IS_IMMUTABLE(inode))
+			return -EACCES;
+	}
 
 	if (current->fsuid == inode->i_uid)
 		mode >>= 6;
 	else if (in_group_p(inode->i_gid))
 		mode >>= 3;
 
-	if (((mode & mask & S_IRWXO) == mask) || capable(CAP_DAC_OVERRIDE))
+	if (((mode & mask & (MAY_READ|MAY_WRITE|MAY_EXEC)) == mask))
 		return 0;
 
-	/* read and search access */
-	if ((mask == S_IROTH) ||
-	    (S_ISDIR(inode->i_mode)  && !(mask & ~(S_IROTH | S_IXOTH))))
+	/*
+	 * Only read/write DACs are overridable.
+	 */
+	if ((mask & (MAY_READ|MAY_WRITE)) || S_ISDIR(inode->i_mode))
+		if (capable(CAP_DAC_OVERRIDE))
+			return 0;
+
+	/*
+	 * Searching includes executable on directories, else just read.
+	 */
+	if (mask == MAY_READ || (S_ISDIR(inode->i_mode) && !(mask & MAY_WRITE)))
 		if (capable(CAP_DAC_READ_SEARCH))
 			return 0;
 
