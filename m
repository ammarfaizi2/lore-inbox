Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316574AbSFMExo>; Thu, 13 Jun 2002 00:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316644AbSFMExn>; Thu, 13 Jun 2002 00:53:43 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:2805 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S316574AbSFMExm>;
	Thu, 13 Jun 2002 00:53:42 -0400
Date: Thu, 13 Jun 2002 14:52:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, Linus <torvalds@transmeta.com>
Cc: Trivial Kernel Patches <trivial@rustcorp.com.au>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] utimes permission check
Message-Id: <20020613145247.52b10c61.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.7 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, Linus,

The utime and utimes should do exactly the smae permission check
according to SUSv3.
	"The effective user ID of the process shall match the owner of the file,
or has write access to the file or appropriate privileges to use this call
in this manner."

utimes when passed a NULL second argument would fail on a read only
file even if the file is owned by the caller.

As a side note, it appears that glibc in i386 turns calls to utimes into
calls to utime (so this bug is not apparent), but on ia64, glibc turns
calls to utime into calls to utimes (so this bug affects utime as well).
In the kernel we have both syscalls except on Alpha and IA64 where we
don't have utime ... I have no idea what it does on other architectures.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.4.19-pre10/fs/open.c 2.4.19-pre10-utimes.1/fs/open.c
--- 2.4.19-pre10/fs/open.c	Tue Jun  4 13:56:22 2002
+++ 2.4.19-pre10-utimes.1/fs/open.c	Thu Jun 13 14:38:35 2002
@@ -325,7 +325,8 @@
 		newattrs.ia_mtime = times[1].tv_sec;
 		newattrs.ia_valid |= ATTR_ATIME_SET | ATTR_MTIME_SET;
 	} else {
-		if ((error = permission(inode,MAY_WRITE)) != 0)
+		if (current->fsuid != inode->i_uid &&
+		    (error = permission(inode,MAY_WRITE)) != 0)
 			goto dput_and_out;
 	}
 	error = notify_change(nd.dentry, &newattrs);
