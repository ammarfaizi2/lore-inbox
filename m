Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbUB1XVq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 18:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbUB1XVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 18:21:46 -0500
Received: from mail.shareable.org ([81.29.64.88]:2949 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S261941AbUB1XVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 18:21:44 -0500
Date: Sat, 28 Feb 2004 23:21:36 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Jakub Jelinek <jakub@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add getdents32t syscall
Message-ID: <20040228232136.GA1048@mail.shareable.org>
References: <20040226193819.GA3501@sunsite.ms.mff.cuni.cz> <Pine.LNX.4.58.0402261411420.7830@ppc970.osdl.org> <Pine.LNX.4.58.0402261415590.7830@ppc970.osdl.org> <20040226223212.GA31589@devserv.devel.redhat.com> <Pine.LNX.4.58.0402261504230.7830@ppc970.osdl.org> <403E9E4D.6090301@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403E9E4D.6090301@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> > In other words, why doesn't glibc ever just make a new major number and
> > make its "struct dirent" be the 64-bit version?
> 
> You can't be serious.  Can you even imagine the pain this would cause?

Why wouldn't this work?

Change the 32-bit struct dirent to this:

    struct direct
      {
#if __BYTE_ORDER == __LITTLE_ENDIAN
        __ino_t d_ino;
        __u32   __padding1;
        __off_t d_off;
        __u32   __padding2;
#elif __BYTE_ORDER == __BIG_ENDIAN
        __u32   __padding1;
        __ino_t d_ino;
        __u32   __padding2;
        __off_t d_off;
#else
#error Help!
#endif
        unsigned short int d_reclen;
        unsigned char d_type;
        char d_name[256];
      };

And also change getdirentries() and readdir() to call the kernel's getdents64.

Use symbol versioning, so that old binaries will link to the old
(compatible and slower) functions, and newly compiled code, using the
new definition of struct dirent, uses the fast new versions of those
functions?

I presume that, if ELF symbol versioning doesn't allow you to do this,
then the same trick you do with stat() can be used.  From Glibc's
<sys/stat.h>:

    /* To allow the `struct stat' structure and the file type `mode_t'
       bits to vary without changing shared library major version number,
       the `stat' family of functions and `mknod' are in fact inline
       wrappers around calls to `xstat', `fxstat', `lxstat', and `xmknod',
       which all take a leading version-number argument designating the
       data structure and bits used.

-- Jamie
