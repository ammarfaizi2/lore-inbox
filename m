Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280710AbRKGANB>; Tue, 6 Nov 2001 19:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280708AbRKGAMx>; Tue, 6 Nov 2001 19:12:53 -0500
Received: from zok.SGI.COM ([204.94.215.101]:62138 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S280695AbRKGAMh>;
	Tue, 6 Nov 2001 19:12:37 -0500
Date: Wed, 7 Nov 2001 11:12:24 +1100
From: Nathan Scott <nathans@sgi.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        Andreas Gruenbacher <ag@bestbits.at>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        acl-devel@bestbits.at, linux-xfs@oss.sgi.comc
Subject: [RFC][PATCH] extended attributes
Message-ID: <20011107111224.C591676@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi folks,

I've been discussing a filesystem extended attributes API with Andreas
Gruenbacher (maintainer of the ext2/ext3 extended attributes patch[1])
which is suitable for other Linux filesystems as well, in an effort to
remove the differences between our current implementations and to help
out the people building services layered above this (especially Samba).
In doing so we have reviewed the earlier discussion[2,3] on this topic,
and have attempted to produce a new interface which I believe satisfies
many of the issues and ideas put forward there, while at the same time
ensuring that the interface is simple, and remains true to the design
of extended attributes being name:value pairs.

A manual page describing the system call interface can be found here[4].
We're very interested in feedback on this.  In partiular, Linus - would
you consider the patch below, which reserves system call numbers for
this interface?  That would be a big help to our collaborative effort.

We have written most of the code for XFS, and Andreas is working away on
the ext2/ext3 version.  Switching to a new syscall interface is going to
cause several compatibility issues for our existing users, of course, so
is not something we want to rush into before soliciting feedback and
(hopefully) getting some system call numbers reserved - otherwise we may
find ourselves needing to do a similar transition again later.

As a test case for the interface, we will now be able to use the same
POSIX ACL userspace[1,5] between XFS and ext2 without any on-disk format
changes in XFS - this was an important interface design goal for us XFS
folk, where our format is fixed in stone as it is also used by IRIX.

We have also begun discussions with some of the LSM developers, with the
goal of implementing POSIX capabilities and POSIX MAC (mandatory access
control) security extensions in Linux also,  Here we again expect to be
able to provide a filesystem independent view of these attributes, while
still preserving the on-disk XFS format for these attributes using the
simple namespace abstraction mechanism this new interface provides.

I've included some pointers[6,7,8,9,10] to other projects, developers,
discussions, etc. which I've come across who are in some way or another
interested in an extended attributes implementation in the base kernel
- just as examples of how various people are using (or planning to use)
the current ext2/ext3 and XFS interfaces on Linux.

cheers.

-- 
Nathan


[1] Extended attributes for ext2/ext3 and POSIX ACLs
    http://acl.bestbits.at/
[2] fs-devel extended attributes discussion
    http://marc.theaimsgroup.com/?l=linux-fsdevel&m=97222475218787&w=2
[3] Andrew Gildfind's interface comparison whitepaper
    http://acl.bestbits.at/pre/gildfind-acls.pdf
[4] New extattr(2) system call man pages
    http://acl.bestbits.at/man/extattr.2.html
    http://acl.bestbits.at/man/extattr.5.html
    http://oss.sgi.com/cgi-bin/cvsweb.cgi/linux-2.4-xfs/cmd/attr2/man/man2/extattr.2
[5] Common POSIX ACL implementation for Linux
    http://acl.bestbits.at/pipermail/acl-devel/2001-February/000495.html
    http://www.samba.org/samba/whatsnew/samba-2.2.0.html
[6] Andrew Morgan's Filesystem Capability patches
    http://www.kernel.org/pub/linux/libs/security/linux-privs/README
[7] LSM - Linux Security Module project
    http://www.linuxsecurity.com/articles/forums_article-2854.html
    http://mail.wirex.com/pipermail/linux-security-module/2001-October/002310.html
[8] DMAPI/XDSM specification - implemented in XFS via extended attributes
    http://www.opengroup.org/onlinepubs/9657099/
    http://oss.sgi.com/projects/xfs/dmapi.html
[9] SnapFS snapshot filesystem
    http://lwn.net/2001/0308/a/snapfs.php3
[10] Will Dyson's resurrection of BeFS for Linux 2.4
    http://cs.earlham.edu/~will/software/linux/kernel/BeFS.html
    http://marc.theaimsgroup.com/?l=linux-fsdevel&m=100431033704112&w=2


diff -Naur 2.4.14-pristine/arch/i386/kernel/entry.S 2.4.14-reserved/arch/i386/kernel/entry.S
--- 2.4.14-pristine/arch/i386/kernel/entry.S	Sat Nov  3 12:18:49 2001
+++ 2.4.14-reserved/arch/i386/kernel/entry.S	Wed Nov  7 10:02:59 2001
@@ -622,6 +622,9 @@
 	.long SYMBOL_NAME(sys_ni_syscall)	/* Reserved for Security */
 	.long SYMBOL_NAME(sys_gettid)
 	.long SYMBOL_NAME(sys_readahead)	/* 225 */
+	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for extattr  */
+	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for lextattr */
+	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for fextattr */
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
diff -Naur 2.4.14-pristine/include/asm-i386/unistd.h 2.4.14-reserved/include/asm-i386/unistd.h
--- 2.4.14-pristine/include/asm-i386/unistd.h	Thu Oct 18 03:03:03 2001
+++ 2.4.14-reserved/include/asm-i386/unistd.h	Wed Nov  7 10:02:59 2001
@@ -230,6 +230,9 @@
 #define __NR_security		223	/* syscall for security modules */
 #define __NR_gettid		224
 #define __NR_readahead		225
+#define __NR_extattr		226	/* syscall for extended attributes */
+#define __NR_lextattr		227	/* syscall for extended attributes */
+#define __NR_fextattr		228	/* syscall for extended attributes */
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
