Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270520AbRHHQXL>; Wed, 8 Aug 2001 12:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270521AbRHHQXC>; Wed, 8 Aug 2001 12:23:02 -0400
Received: from ns.caldera.de ([212.34.180.1]:39351 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S270520AbRHHQWw>;
	Wed, 8 Aug 2001 12:22:52 -0400
Date: Wed, 8 Aug 2001 18:22:19 +0200
From: Christoph Hellwig <hch@caldera.de>
To: torvalds@transmeta.com
Cc: alan@redhat.com, linux-kernel@vger.kernel.org,
        linux-privs-discuss@sourceforge.net
Subject: [PATCH] fix permission checks for executables
Message-ID: <20010808182219.A12652@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	torvalds@transmeta.com, alan@redhat.com,
	linux-kernel@vger.kernel.org, linux-privs-discuss@sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linux,

vfs_permission in the Linux 2.4 series tries to check for
CAP_DAC_OVERRIDE if the modes didn't match.  This means even
for an file without executable bits set at all, root will
be reported that it is.   I've actually found one apllication
(scomail under linux-abi) that fails because of this, besides
not matching my reading of Posix 1003.1e.

Of the operating systems with capabilty-like features at least
OpenUNIX gets it right, of the others at least OpenServer and
4.4BSD, but these semantics seem natural to me anyway..

Please aplly the attached patch.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.


--- linux.really_plain/fs/namei.c	Wed Aug  8 17:56:58 2001
+++ linux.plain/fs/namei.c	Wed Aug  8 18:13:22 2001
@@ -163,9 +163,13 @@
 	else if (in_group_p(inode->i_gid))
 		mode >>= 3;
 
-	if (((mode & mask & S_IRWXO) == mask) || capable(CAP_DAC_OVERRIDE))
+	if (((mode & mask & S_IRWXO) == mask))
 		return 0;
 
+	if (!(mask & S_IXOTH) || S_ISDIR(inode->i_mode))
+		if (capable(CAP_DAC_OVERRIDE))
+			return 0;
+
 	/* read and search access */
 	if ((mask == S_IROTH) ||
 	    (S_ISDIR(inode->i_mode)  && !(mask & ~(S_IROTH | S_IXOTH))))
