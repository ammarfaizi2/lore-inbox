Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbUBTRrN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 12:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbUBTRrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 12:47:13 -0500
Received: from mail.shareable.org ([81.29.64.88]:62336 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261323AbUBTRrJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 12:47:09 -0500
Date: Fri, 20 Feb 2004 17:47:04 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Tridge <tridge@samba.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(), O_CLEAN
Message-ID: <20040220174704.GG8994@mail.shareable.org>
References: <16435.61622.732939.135127@samba.org> <Pine.LNX.4.58.0402181511420.18038@home.osdl.org> <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org> <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040220120417.GA4010@elte.hu> <Pine.LNX.4.58.0402200733350.1107@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402200733350.1107@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote to Ingo Molnar;
> Your version is also not multi-threaded: you can never allow more than one 
> thread doing the "sys_mark_dir_clean()".

It's fine as long as each thread has its own dirfd.  The "clean bit"
applies to an fd.  Or did I miss something obvious?

> The problem is that you'd still need other system calls

Here's a thought.  It's a bit ugly, but it offers O_CLEAN-like
functionality without extra system calls for each operation:

    fchdir(dirfd);

That means change to dirfd in the current process (or thread if
CLONE_FS), and when the "clean bit" is set on dirfd, then any creation
of a name _with no directory component_ will abort.

For example, these operations all create names which will check
dirfd's clean bit, and abort if it's set:

    open("file1", O_CREAT|O_TRUNC|O_RDWR, 0666);
    link("file1", "file2");
    symlink("file1","file3");
    rename("file1", "file4");
    link("subdir/file1", "file2");
    symlink("subdir/file1","file3");
    rename("subdir/file1", "file4");

These operations don't check any clean bits:

    open("/tmp/file1", O_CREAT|O_TRUNC|O_RDWR, 0666);
    open("./file1", O_CREAT|O_TRUNC|O_RDWR, 0666);
    link("file1", "subdir/file2");
    symlink("file1","subdir/file3");
    rename("file1", "subdir/file4");

If dirfd is closed, then of course the current directory stays the
same, but there is no clean bit to check any more.  chdir() also
implies no clean bit to check.

In other words the notion of current directory is extended to be
(inode, fd).  fd can be NULL, or an fd whose clean bit must be checked
before allowing name creation for "/"-less paths.

(As you know I prefer to use dnotify on dirfd to represent the "clean
bit", but that's the subject of another mail).

-- Jamie
