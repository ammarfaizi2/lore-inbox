Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267708AbUIAXOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267708AbUIAXOB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267891AbUIAUyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:54:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:32987 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267851AbUIAUvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:51:47 -0400
Date: Wed, 1 Sep 2004 13:50:56 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent
 semantic changes with reiser4)
In-Reply-To: <20040901200806.GC31934@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
References: <20040826150202.GE5733@mail.shareable.org>
 <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Sep 2004, Jamie Lokier wrote:
>
> I'm going to explain why filesystem support for .tar.gz or other
> "document container"-like formats is useful.  This does _not_ mean tar
> in the kernel (I know someone who can't read will think that if I
> don't say it isn't); it does mean hooks in the kernel for maintaining
> coherency between different views and filesystem support for cacheing.

I think that's a valid thing, but there are some fundamental problems with 
it if you expect it to work on a normal filesystem (ie something that 
isn't fundamentally designed as a database).

For example, _what_ kind of coherency do you think is acceptable? Quite
frankly, using standard UNIX interfaces, absolute coherency just isn't an
option, because it's just not possible to try to atomically update a view
at the same time somebody else is writing to the "main file". "mmap()" is
the most obvious example of this, but even the _basic_ notion of multiple
"read" calls is not atomic without locking that is _way_ too expensive.

A "read()" on a file is not atomic even on the _plain_ file: if somebody 
does a concurrent "write()", the reader may see a partial update. This 
becomes a million times more confusing if the reader is seeing a 
structured view of the file the writer is modifying.

Also, it's likely impossible to write() to the view-file, again unless you 
expect all the underlying filesystems to be something really special.

So from a _practical_ standpoint, I suspect that the best you can really 
do pretty cheaply (and which gets you 90% of what you probably want) is:

 - open-close consistency: the "validity" of the cache is checked at 
   _open_ time, and no guarantees are given about the cache being 
   updated afterwards.
 - read-only access to the cache (ie you can only read the view, not write 
   to it).

and quite frankly, I think you can do the above pretty much totally in
user space with a small library and a daemon (in fact, ignoring security
issues you probably don't even need the daemon). And if you can prototype
it like that, and people actually find it useful, I suspect kernel support
for better performance might be possible.

Suggested interface:

	int open_cached_view(int base_fd, char *type, char *subname);

where "type" would be the type of the view (ie "tar" for a tar-file view,
"idtag" for a mp3 ID tag, or NULL for "autodetect default view") and
"subname" would be the cache entry name (ie the tar-file filename, or the
tag type to open).

I bet you could write a small library to test this out for a few types.  
See if it's useful to you. And only if it's useful (and would make a huge
performance difference) would it be worth putting in the kernel.

Implementation of the _user_space_ library would be something like this:

	#define MAXNAME 1024
	int open_cached_view(int base_fd, char *type, char *subname)
	{
	        struct stat st;
	        char filename[PATH_MAX];
	        char name[MAXNAME];
	        int len, cachefd;
	
	        if (fstat(base_fd, &st) < 0)
	                return -1;
	        sprintf(name, "/proc/self/fd/%d", base_fd);
	        len = readlink(name, filename, sizeof(filename)-1);
	        if (len < 0)
	                return -1;
	        filename[len] = 0;
	
	        /* FIXME! Replace '/' with '#' in "type" and "subname" */
	        len = snprintf(name, sizeof(name),
	                        "%04llx/%04llx/%s/%s/%s",
	                        (unsigned long long) st.st_dev,
	                        (unsigned long long) st.st_ino,
	                        type ? : "default",
	                        subname,
	                        filename);
	        errno = ENAMETOOLONG;
	        if (len >= sizeof(name))
	                return -1;
	        cachefd = open(name, O_RDONLY);
	        if (cachefd >= 0) {
	                /* Check mtime here - maybe we could have kernel support */
	                return cachefd;
	        }
	        if (errno != ENOENT)
	                return -1;
	        /*
	        .. try to generate cache file here ..
	         */

see what I'm aiming at? You start out with a generic "attribute cache" 
library that does some hacky things (like depending on "mtime" for 
coherency) and then if that works out you can see if it's useful.

			Linus
