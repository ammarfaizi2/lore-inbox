Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUB0Bsf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 20:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbUB0Bsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 20:48:35 -0500
Received: from moraine.clusterfs.com ([66.246.132.190]:16071 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261725AbUB0Bqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 20:46:52 -0500
Date: Thu, 26 Feb 2004 18:46:48 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org,
       drepper@redhat.com
Subject: Re: [PATCH] Add getdents32t syscall
Message-ID: <20040227014648.GW1257@schnapps.adilger.int>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org,
	drepper@redhat.com
References: <20040226193819.GA3501@sunsite.ms.mff.cuni.cz> <Pine.LNX.4.58.0402261411420.7830@ppc970.osdl.org> <Pine.LNX.4.58.0402261415590.7830@ppc970.osdl.org> <20040226223212.GA31589@devserv.devel.redhat.com> <Pine.LNX.4.58.0402261504230.7830@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402261504230.7830@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Feb 2004, Jakub Jelinek wrote:
> Userland struct dirent is:
> (since 1997 or so), so with the extended getdents syscall glibc would need
> to memmove every name by 1 byte.

Actually, before you go through contortions trying to return this stuff to
user space, you should fix the GNU tools to use the information properly.

For example, rm stats the file each time before trying to unlink it even
if it has the file type information from getdents64().  It also tries to
do silly things like unlink() on a directory instead of rmdir, even after
the stat (RH9 coreutils 4.5.3-19 and 2.4.24):

    $ mkdir /tmp/foo
    $ touch /tmp/foo/f{1,2,3,4,5}
    $ strace rm -r /tmp/foo
    :
    :
    lstat64("/tmp/foo", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
    access("/tmp/foo", W_OK)                 = 0
    unlink("/tmp/foo")                       = -1 EISDIR (Is a directory)

Um, hello - we just saw that it was a directory so why not try rmdir()?
It does the same thing when the directory is empty too.

    open(".", O_RDONLY|O_LARGEFILE|O_DIRECTORY) = 3
    lstat64("/tmp/foo", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
    chdir("/tmp/foo")                        = 0
    lstat64(".", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
    open(".", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 4
    fstat64(4, {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
    fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0

    getdents64(4, /* 7 entries */, 4096)    = 168
    lstat64("f1", {st_mode=S_IFREG|0664, st_size=0, ...}) = 0
    access("f1", W_OK)                      = 0
    unlink("f1")                            = 0
    lstat64("f2", {st_mode=S_IFREG|0664, st_size=0, ...}) = 0
    access("f2", W_OK)                      = 0
    unlink("f2")                            = 0
    :
    :

So, for each file, we just got the file type info from getdents64(),
we still stat the file (not sure why), we check the permissions even
though we just statted it (could check perms from stat info or just
try to unlink and handle the error return code), and finally an unlink.

    getdents64(4, /* 0 entries */, 4096)    = 0
    close(4)                                = 0
    fchdir(3)                               = 0
    lstat64(".", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
    lstat64("/tmp/foo", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
    access("/tmp/foo", W_OK)                 = 0
    rmdir("/tmp/foo")                        = 0

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

