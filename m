Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTJ2ILW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 03:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbTJ2ILW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 03:11:22 -0500
Received: from pop.gmx.net ([213.165.64.20]:31438 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261893AbTJ2ILD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 03:11:03 -0500
Date: Wed, 29 Oct 2003 09:11:01 +0100 (MET)
From: "Michael Kerrisk" <michael.kerrisk@gmx.net>
To: linux-kernel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, torvalds@osdl.org
Cc: agruen@suse.de
MIME-Version: 1.0
Subject: [PATCH] fix access() / vfs_permission() bug
X-Priority: 3 (Normal)
X-Authenticated: #2864774
Message-ID: <23919.1067415061@www7.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

After Andreas Gruenbacher suggested a change to vfs_permission() 
( http://marc.theaimsgroup.com/?l=linux-kernel&m=106631710402696&w=2 ) 
and thus also the access() system call, we've done some further 
research on what happens with access() on other Unix 
implementations.  The conclusions we've reached are that on Linux 
the operation of access():

a) doesn't conform to SUSv3, and
b) isn't consistent with other Unix implementations (results from 
   various implementations are shown below).

First a little delving into SUSv3:

[[
>From the specification for <unistd.h>:

    The constants F_OK, R_OK, W_OK, and X_OK and the expressions 
    R_OK|W_OK, R_OK|X_OK, and R_OK|W_OK|X_OK shall all have 
    distinct values.

>From the specification for access():
    If any access permissions are checked, each shall be checked 
    individually, as described in the Base Definitions volume of 
    IEEE Std 1003.1-2001, Chapter 3, Definitions. If the process 
    has appropriate privileges, an implementation may indicate 
    success for X_OK even if none of the execute file permission 
    bits are set.

    ERRORS
    [EACCES] Permission bits of the file mode do not 
    permit the requested access, or search permission is 
    denied on a component of the path prefix. 

>From the rationale for access():
    In early proposals, some inadequacies in the access() 
    function led to the creation of an eaccess() function 
    because:

    1. Historical implementations of access() do not test 
       file access correctly when the process' real user 
       ID is superuser. In particular, they always return
       zero when testing execute permissions without regard 
       to whether the file is executable.

    [...]

    However, the historical model of eaccess() does not 
    resolve problem (1), so this volume of IEEE Std 
    1003.1-2001 now allows access() to behave in the desired 
    way because several implementations have corrected the 
    problem. 
    [...]

    The sentence concerning appropriate privileges and 
    execute permission bits reflects the two possibilities 
    implemented by historical implementations when checking
    superuser access for X_OK.

    New implementations are discouraged from returning X_OK 
    unless at least one execution permission bit is set.
]]

The implication of all this is that for the call:

    access(files, mode)

it is bits/masks that are relevant for the check, rather than a 
direct test for equality of the form `mode == X_OK', which is 
currently what vfs_permission() in effect implements.

Furthermore, when testing for X_OK **for a privileged process**, 
an implementation of access() is permitted two possibilities:

[a] always say that X_OK is allowed
[b] allow X_OK only if execute permission is granted to at 
    least one permission class (user/group/other) for the 
    file.  SUSv3 encourages this latter implementation.

Using a test program (see below) run under the superuser 
account, we tested what access() returns on various 
implementations when applied to a file on which all 
permissions are disabled:

----------  1 500  100  0 Oct 26 10:39 /tmp/t_access

On FreeBSD 4.8, AIX 4.3 and 5.1, and Solaris 9, we see the following:

access(/tmp/t_access, 0) returns 0
access(/tmp/t_access, R_OK) returns 0
access(/tmp/t_access, W_OK) returns 0
access(/tmp/t_access, X_OK) returns 0
access(/tmp/t_access, R_OK | W_OK) returns 0
access(/tmp/t_access, R_OK | X_OK) returns 0
access(/tmp/t_access, W_OK | X_OK) returns 0
access(/tmp/t_access, R_OK | W_OK | X_OK) returns 0

These results are consistent with interpretation [a] above.

On HP-UX 11 and Tru64 4.0f and 5.1B, we see:

access(/tmp/t_access, 0) returns 0
access(/tmp/t_access, R_OK) returns 0
access(/tmp/t_access, W_OK) returns 0
access(/tmp/t_access, X_OK) returns -1
access(/tmp/t_access, R_OK | W_OK) returns 0
access(/tmp/t_access, R_OK | X_OK) returns -1
access(/tmp/t_access, W_OK | X_OK) returns -1
access(/tmp/t_access, R_OK | W_OK | X_OK) returns -1

This is consistent with the (SUSv3 preferred) interpretation [b] above.

On Linux 2.4.21 and 2.6.0-test9, we see the following:

access(/tmp/t_access, 0) returns 0
access(/tmp/t_access, R_OK) returns 0
access(/tmp/t_access, W_OK) returns 0
access(/tmp/t_access, X_OK) returns -1
access(/tmp/t_access, R_OK | W_OK) returns 0
access(/tmp/t_access, R_OK | X_OK) returns 0
access(/tmp/t_access, W_OK | X_OK) returns 0
access(/tmp/t_access, R_OK | W_OK | X_OK) returns 0

In other words, Linux’s access() / vfs_permission() is treating the 
case ‘mode == X_OK’ as a special case, distinct from all of the 
other bit-mask combinations that include X_OK.  Really it should 
operate using either interpretation [a] or (preferably) [b] above.  
I have appended Andreas’ patch against 2.6.0-test9, which 
implements interpretation [b].  Please apply.

Cheers,

Michael Kerrisk

##### Test program #####

/* t_access_root.c */

#include <limits.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/stat.h>

#define UID 500
#define GID 100
#define PERM 0
#define TESTPATH "/tmp/t_access"

static void
errExit(char *msg)
{
    perror(msg);
    exit(EXIT_FAILURE);
} /* errExit */

static void
accessTest(char *file, int mask, char *mstr)
{
    printf("access(%s, %s) returns %d\n", file, mstr, access(file, mask));
} /* accessTest */

int
main(int argc, char *argv[])
{
    int fd, perm, uid, gid;
    char *testpath;
    char cmd[PATH_MAX + 20];

    testpath =  (argc > 1) ? argv[1]                    : TESTPATH;
    perm =      (argc > 2) ? strtoul(argv[2], NULL, 8)  : PERM;
    uid =       (argc > 3) ? atoi(argv[3])              : UID;
    gid =       (argc > 4) ? atoi(argv[4])              : GID;

    unlink(testpath);

    fd = open(testpath, O_RDWR | O_CREAT, 0);
    if (fd == -1) errExit("open");

    if (fchown(fd, uid, gid) == -1) errExit("fchown");
    if (fchmod(fd, perm) == -1) errExit("fchown");
    close(fd);

    snprintf(cmd, sizeof(cmd), "ls -l %s", testpath);
    system(cmd);

    if (seteuid(uid) == -1) errExit("seteuid");

    accessTest(testpath, 0, "0");
    accessTest(testpath, R_OK, "R_OK");
    accessTest(testpath, W_OK, "W_OK");
    accessTest(testpath, X_OK, "X_OK");
    accessTest(testpath, R_OK | W_OK, "R_OK | W_OK");
    accessTest(testpath, R_OK | X_OK, "R_OK | X_OK");
    accessTest(testpath, W_OK | X_OK, "W_OK | X_OK");
    accessTest(testpath, R_OK | W_OK | X_OK, "R_OK | W_OK | X_OK");

    exit(EXIT_SUCCESS);
} /* main */



##### Patch #####

Index: linux-2.6.0-test9/fs/jfs/acl.c
===================================================================
--- linux-2.6.0-test9.orig/fs/jfs/acl.c	2003-10-08 21:24:01.000000000 +0200
+++ linux-2.6.0-test9/fs/jfs/acl.c	2003-10-28 15:03:06.000000000 +0100
@@ -191,7 +191,7 @@ check_capabilities:
 	 * Read/write DACs are always overridable.
 	 * Executable DACs are overridable if at least one exec bit is set.
 	 */
-	if ((mask & (MAY_READ|MAY_WRITE)) || (inode->i_mode & S_IXUGO))
+	if (!(mask & MAY_EXEC) || (inode->i_mode & S_IXUGO))
 		if (capable(CAP_DAC_OVERRIDE))
 			return 0;
 
Index: linux-2.6.0-test9/fs/xfs/xfs_inode.c
===================================================================
--- linux-2.6.0-test9.orig/fs/xfs/xfs_inode.c	2003-10-17 23:43:35.000000000
+0200
+++ linux-2.6.0-test9/fs/xfs/xfs_inode.c	2003-10-28 15:03:06.000000000 +0100
@@ -3722,7 +3722,7 @@ xfs_iaccess(
 	 * Read/write DACs are always overridable.
 	 * Executable DACs are overridable if at least one exec bit is set.
 	 */
-	if ((orgmode & (S_IRUSR|S_IWUSR)) || (inode->i_mode & S_IXUGO))
+	if (!(orgmode & S_IXUSR) || (inode->i_mode & S_IXUGO))
 		if (capable_cred(cr, CAP_DAC_OVERRIDE))
 			return 0;
 
Index: linux-2.6.0-test9/fs/ext2/acl.c
===================================================================
--- linux-2.6.0-test9.orig/fs/ext2/acl.c	2003-10-17 23:43:24.000000000 +0200
+++ linux-2.6.0-test9/fs/ext2/acl.c	2003-10-28 15:03:06.000000000 +0100
@@ -322,7 +322,7 @@ check_groups:
 
 check_capabilities:
 	/* Allowed to override Discretionary Access Control? */
-	if ((mask & (MAY_READ|MAY_WRITE)) || (inode->i_mode & S_IXUGO))
+	if (!(mask & MAY_EXEC) || (inode->i_mode & S_IXUGO))
 		if (capable(CAP_DAC_OVERRIDE))
 			return 0;
 	/* Read and search granted if capable(CAP_DAC_READ_SEARCH) */
Index: linux-2.6.0-test9/fs/ext3/acl.c
===================================================================
--- linux-2.6.0-test9.orig/fs/ext3/acl.c	2003-10-17 23:43:01.000000000 +0200
+++ linux-2.6.0-test9/fs/ext3/acl.c	2003-10-28 15:03:06.000000000 +0100
@@ -327,7 +327,7 @@ check_groups:
 
 check_capabilities:
 	/* Allowed to override Discretionary Access Control? */
-	if ((mask & (MAY_READ|MAY_WRITE)) || (inode->i_mode & S_IXUGO))
+	if (!(mask & MAY_EXEC) || (inode->i_mode & S_IXUGO))
 		if (capable(CAP_DAC_OVERRIDE))
 			return 0;
 	/* Read and search granted if capable(CAP_DAC_READ_SEARCH) */
Index: linux-2.6.0-test9/fs/namei.c
===================================================================
--- linux-2.6.0-test9.orig/fs/namei.c	2003-10-08 21:24:03.000000000 +0200
+++ linux-2.6.0-test9/fs/namei.c	2003-10-28 15:03:06.000000000 +0100
@@ -190,7 +190,7 @@ int vfs_permission(struct inode * inode,
 	 * Read/write DACs are always overridable.
 	 * Executable DACs are overridable if at least one exec bit is set.
 	 */
-	if ((mask & (MAY_READ|MAY_WRITE)) || (inode->i_mode & S_IXUGO))
+	if (!(mask & MAY_EXEC) || (inode->i_mode & S_IXUGO))
 		if (capable(CAP_DAC_OVERRIDE))
 			return 0;

-- 
NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++

