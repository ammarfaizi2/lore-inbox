Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310435AbSDUKhp>; Sun, 21 Apr 2002 06:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311403AbSDUKho>; Sun, 21 Apr 2002 06:37:44 -0400
Received: from fungus.teststation.com ([212.32.186.211]:43789 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S310435AbSDUKho>; Sun, 21 Apr 2002 06:37:44 -0400
Date: Sun, 21 Apr 2002 12:37:04 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: <linux-kernel@vger.kernel.org>
cc: <davem@redhat.com>, <jj@sunsite.ms.mff.cuni.cz>, <davidm@hpl.hp.com>,
        <schwidefsky@de.ibm.com>, <engebret@us.ibm.com>,
        Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: [patch] 64bit archs doing incorrect magic for smbfs?
Message-ID: <Pine.LNX.4.33.0204211221400.13036-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I hope I got the maintainer list right ... ]

Hello

sparc64, ia64, s390x and ppc64 translate the data part of the mount
syscall for smbfs (and ncpfs). I can see this is done to map different
datatypes of a binary struct (uids/pids/...), although I'm not clear on
exactly when this is needed.

I believe this translation isn't always done correctly. The structs used
have a version field that you are supposed to check to ensure that the
data is in the format you think it is.

For smbfs the data part is now often sent as a normal ascii string (when
using samba 2.2.0+) and should then not be modified at all. ncpfs defines
two different formats (v3 and v4), don't know if both are used.


Untested patch vs 2.4.19-pre7-ac2 below adds version number checks for the
smbfs case (yes, it handles the ascii format too). Similar changes are
needed in 2.5.

Another fix for smbfs could be to just drop the mount conversion code.
This would make the older binary format fail, but that's the long term
plan anyway.

/Urban


diff -urN -X exclude linux-2.4.19-pre7-ac2-orig/arch/ia64/ia32/sys_ia32.c linux-2.4.19-pre7-ac2-smbfs/arch/ia64/ia32/sys_ia32.c
--- linux-2.4.19-pre7-ac2-orig/arch/ia64/ia32/sys_ia32.c	Sat Apr 20 22:56:31 2002
+++ linux-2.4.19-pre7-ac2-smbfs/arch/ia64/ia32/sys_ia32.c	Sun Apr 21 00:56:43 2002
@@ -3882,12 +3882,15 @@
 	struct smb_mount_data *s = (struct smb_mount_data *)raw_data;
 	struct smb_mount_data32 *s32 = (struct smb_mount_data32 *)raw_data;
 
+	if (s32->version != SMB_MOUNT_OLDVERSION)
+		goto out;
 	s->version = s32->version;
 	s->mounted_uid = s32->mounted_uid;
 	s->uid = s32->uid;
 	s->gid = s32->gid;
 	s->file_mode = s32->file_mode;
 	s->dir_mode = s32->dir_mode;
+out:
 	return raw_data;
 }
 
diff -urN -X exclude linux-2.4.19-pre7-ac2-orig/arch/ppc64/kernel/sys_ppc32.c linux-2.4.19-pre7-ac2-smbfs/arch/ppc64/kernel/sys_ppc32.c
--- linux-2.4.19-pre7-ac2-orig/arch/ppc64/kernel/sys_ppc32.c	Sat Apr 20 22:56:16 2002
+++ linux-2.4.19-pre7-ac2-smbfs/arch/ppc64/kernel/sys_ppc32.c	Sun Apr 21 00:58:20 2002
@@ -422,12 +422,15 @@
 	struct smb_mount_data *s = (struct smb_mount_data *)raw_data;
 	struct smb_mount_data32 *s32 = (struct smb_mount_data32 *)raw_data;
 
+	if (s32->version != SMB_MOUNT_OLDVERSION)
+		goto out;
 	s->version = s32->version;
 	s->mounted_uid = s32->mounted_uid;
 	s->uid = s32->uid;
 	s->gid = s32->gid;
 	s->file_mode = s32->file_mode;
 	s->dir_mode = s32->dir_mode;
+out:
 	return raw_data;
 }
 
diff -urN -X exclude linux-2.4.19-pre7-ac2-orig/arch/s390x/kernel/linux32.c linux-2.4.19-pre7-ac2-smbfs/arch/s390x/kernel/linux32.c
--- linux-2.4.19-pre7-ac2-orig/arch/s390x/kernel/linux32.c	Sat Apr 20 22:56:16 2002
+++ linux-2.4.19-pre7-ac2-smbfs/arch/s390x/kernel/linux32.c	Sun Apr 21 00:57:49 2002
@@ -1673,12 +1673,15 @@
 	struct smb_mount_data *s = (struct smb_mount_data *)raw_data;
 	struct smb_mount_data32 *s32 = (struct smb_mount_data32 *)raw_data;
 
+	if (s32->version != SMB_MOUNT_OLDVERSION)
+		goto out;
 	s->version = s32->version;
 	s->mounted_uid = low2highuid(s32->mounted_uid);
 	s->uid = low2highuid(s32->uid);
 	s->gid = low2highgid(s32->gid);
 	s->file_mode = s32->file_mode;
 	s->dir_mode = s32->dir_mode;
+out:
 	return raw_data;
 }
 
diff -urN -X exclude linux-2.4.19-pre7-ac2-orig/arch/sparc64/kernel/sys_sparc32.c linux-2.4.19-pre7-ac2-smbfs/arch/sparc64/kernel/sys_sparc32.c
--- linux-2.4.19-pre7-ac2-orig/arch/sparc64/kernel/sys_sparc32.c	Sat Apr 20 22:56:31 2002
+++ linux-2.4.19-pre7-ac2-smbfs/arch/sparc64/kernel/sys_sparc32.c	Sun Apr 21 00:54:41 2002
@@ -1657,6 +1657,8 @@
 	struct smb_mount_data news, *s = &news;
 	struct smb_mount_data32 *s32 = (struct smb_mount_data32 *)raw_data;
 
+	if (s32->version != SMB_MOUNT_OLDVERSION)
+		goto out;
 	s->version = s32->version;
 	s->mounted_uid = low2highuid(s32->mounted_uid);
 	s->uid = low2highuid(s32->uid);
@@ -1664,6 +1666,7 @@
 	s->file_mode = s32->file_mode;
 	s->dir_mode = s32->dir_mode;
 	memcpy(raw_data, s, sizeof(struct smb_mount_data)); 
+out:
 	return raw_data;
 }
 

