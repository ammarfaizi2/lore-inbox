Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262407AbVCIX6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbVCIX6w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVCIX5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:57:52 -0500
Received: from nfw.msbit.com ([64.170.147.162]:48594 "EHLO collie.msbit.com")
	by vger.kernel.org with ESMTP id S262431AbVCIXOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:14:41 -0500
Subject: link(2) and symlinks
From: Nick Stoughton <nick@usenix.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1110410075.18359.384.camel@collie>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 09 Mar 2005 15:14:36 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Linux, the link() system call does not dereference symbolic links: if
oldpath is a symbolic link, then newpath is created as a new hard link
to the same symbolic link file.  (In other words, newpath is also a
symbolic link to the same file that oldpath refers to.)  E.g. (using
shell commands to demonstrate):
$ > a
$ ln -s a b
$ ln b c
ln: `b': warning: making a hard link to a symbolic link is not portable
$ ls -li [abc]
 230342 -rw-rw-r--    1 nick     nick            0 Mar  9 15:00 a
 230504 lrwxrwxrwx    2 nick     nick            1 Mar  9 15:01 b -> a
 230504 lrwxrwxrwx    2 nick     nick            1 Mar  9 15:01 c -> a


This behavior does not conform to POSIX, which says that all functions
that perform pathname resolution should dereference symbolic links
unless otherwise specified (and there is no exception specified for
link()).  (POSIX says that resolution of the final component of a
pathname shall be considered complete if "the function is required to
act on the symbolic link itself, or certain arguments direct that the
function act on the symbolic link itself."  In other words (in my
reading), unless the function specification says explicitly that the
function should act on a symbolic link, then the function should
dereference symbolic links.  The specification of link() makes no
statement that it should act on symbolic links rather than the pathnames
to which they refer.)

Most Unix implementations behave in the manner specified by POSIX.  One
notable exception is Solaris 8 (I don't know about later Solarises). 
That implementation shows the same behavior as Linux by default, but the
SUSv3-conformant behavior is obtainable using c89 on that
implementation.

The Linux behavior is clearly deliberate:
(from fs/namei.c)
/*
 * Hardlinks are often used in delicate situations.  We avoid
 * security-related surprises by not following symlinks on the
 * newname.  --KAB
 *
 * We don't follow them on the oldname either to be compatible
 * with linux 2.0, and to avoid hard-linking to directories
 * and other special files.  --ADM
 */
asmlinkage long sys_link(const char __user * oldname, const char __user
* newname)
{
...

Would a patch to provide POSIX conforming behavior under some
conditional case (e.g. if /proc/sys/posix has value 1) ever be accepted?

I'm not a list subscriber, so please cc me in any discussion, thanks!
-- 
Nick Stoughton      USENIX/FSG Standards Liaison
nick@usenix.org     (510) 388 1413

