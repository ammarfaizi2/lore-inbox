Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268331AbUHXVT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268331AbUHXVT0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 17:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268337AbUHXVT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 17:19:26 -0400
Received: from mail.shareable.org ([81.29.64.88]:61892 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S268331AbUHXVSz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 17:18:55 -0400
Date: Tue, 24 Aug 2004 22:18:35 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Christoph Hellwig <hch@lst.de>, Lee Revell <rlrevell@joe-job.com>,
       Andrew Morton <akpm@osdl.org>, reiser@namesys.com,
       linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040824211835.GA6313@mail.shareable.org>
References: <20040824202521.GA26705@lst.de> <1093379718.817.63.camel@krustophenia.net> <20040824203844.GA26999@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040824203844.GA26999@lst.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> > >    - O_DIRECTORY opens succeed on all files on reiser4.  Besides breaking
> > >      .htaccess handling in apache and glibc compilation this also renders
> > >      this flag entirely useless and opens up the races it tries to
> > >      prevent against cmpletely useless
> > 
> > So `find -type d' would list every file on the system?
> 
> the find I have here is using lstat and not open with O_DIRECTORY, so
> no.

The find-like program I use (called treescan) uses O_DIRECTORY as an
optimisation.  It assumes that O_DIRECTORY will only open objects
which are directories and can be read using readdir().

However, if reiser4 returns d_type values, then it won't even attempt
an open on non-DT_DIR objects, and that's a better optimisation.
(reiserfs doesn't return d_type values, unfortunately).

So the list of files that treescan finds depends on whether reiser4
implements d_type.

This is nothing like a POSIX filesystem.  You untar a tree, and then
listing it recursively shows extra things created by reiser4.

I quite like the principle, but because it's not like POSIX and
doesn't match some program's expectations, it's a problem in its
present form.

xattrs aren't a complete solution as you can't store structured data
in an xattr.  For example, with reiser4's model, you can cd into a
.tar, .zip, .mp3 or .xml file and list the internal structure along
with the file's metadata.  You can't do that with xattrs.

Programs exist which quite reasonably assume that when you create a
file, you can't opendir() the file, and recursive listings (like find,
ls -R et al.) won't automatically traverse into every file.

On the other hand, being able to enter a file in a directory-like way
allows structured representations of the contents to be accessed in
the very useful "everything's a file" way -- i.e. ordinary tools.

So here's a semantic proposal:

   1. O_DIRECTORY won't open an ordinary file.
      Corollary: opendir("file") won't open an ordinary file.

   2. An ordinary file path followed by "/" won't open an ordinary file.
      Corollary: opendir("file/") won't open an ordinary file.

      This is because appending a trailing slash is an alternate
      way for userspace to get the same results as O_DIRECTORY.

   3. An ordinary file path followed by "/" _and_ one or more path
      components will open the file as a directory and enter it.
      Corollary: opendir("file/.") will open an ordinary file.

   4. The type of "file/." shall be S_IFDIR, _not_ S_IFREG.
      Corollary: stat("file/.") will return that it's a directory.

      The intention here is that explicit requests to examine the
      metadata or alternate structure representations of a file will
      create such a view, but the view is only available if requested
      explicitly.

      When such a view is created, the results of stat(), O_DIRECTORY
      and opendir() are absolutely consistent.  This will minimise
      confusion.  Programs which recurse over a directory tree won't
      look inside any of the files.  However they can be explicitly
      asked to recurse starting from a path inside a file: then
      they'll recurse over a single file's metadata and structured data.

Regarding the problems of safe locking in the VFS.  The VFS assumes
that directories are not hard linked: i.e. that they cannot appear at
more than one path in a filesystem.  Files-as-directories breaks that.

However, VFS does support directories on multiple paths, using bind mounts.

So it wouldn't be out of the question if entering a file (as described
above) effectively auto-mounted a bind mount at that point.


-- Jamie
