Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWJKSgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWJKSgb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 14:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbWJKSgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 14:36:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23522 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751045AbWJKSg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 14:36:29 -0400
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, aviro@redhat.com, hch@infradead.org,
       Trond.Myklebust@netapp.com, sct@redhat.com
cc: dhowells@redhat.com, steved@redhat.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Tricky issues with local filesystem caching
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 11 Oct 2006 19:35:49 +0100
Message-ID: <8716.1160591749@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph and Al raised a number of major objections to the way I'd implemented
the CacheFiles module and daemon, and I'd like to get advice on dealing with
them.  For reference, the current patch set can be downloaded from:

	http://people.redhat.com/~dhowells/nfs/


The issues are:

 (1) Security.

     The way I've written the CacheFiles module means that the module goes
     directly to the appropriate inode operations to do filesystem operations:

	- lookup()
	- create()
	- mkdir()
	- unlink()
	- rename()
	- setxattr()
	- getxattr()

     Partly this is so that I can better handle the locking, avoiding races
     with other processes also wanting to do caching operations, and partly to
     avoid security.

     Christoph insists that I should use the VFS wrappers for performing these
     operations (such as vfs_rename()).  This, however, introduces a couple of
     tricky security problems:

     (a) The CacheFiles operations run in the context of which ever process
     	 issued an I/O request against the netfs that is being cached.
     	 Consider, for instance, a process opening an NFS file:

	 - the open() syscall asks NFS to open a file;

	 - NFS will ask FS-Cache for a cookie to represent that file;

	 - FS-Cache will ask CacheFiles to go and look in the cache to see if
     	   it has an object to represent that cookie;

	 - CacheFiles will perform various lookups, getxattrs, mkdirs, etc. on
     	   the backing filesystem to achieve this; and

	 - the backing fs (eg Ext3) will actually do the operations.

	 All this is run in the context of the process that issued the open()
	 syscall.  This includes its fsuid and fsgid and its security context,
	 including SELinux security label.

	 The cache, however, mustn't be accessed under the security context of
	 anything other than the cache's context, whether doing lookups, file
	 creation or whatever.  Doing otherwise means that the objects in the
	 cache may be either inaccessible or unshareable.  Security for the
	 original open() call should be done at the NFS level, not at the cache
	 or backing fs level.

     (b) Accesses to the cache done by CacheFiles on behalf of the calling
     	 process should very probably *not* be logged in the audit log, at
     	 least not as originating with the process in whose context we're
     	 running - it didn't make the requests, and the whole process is
     	 supposed to be transparent.

	 It would not be unreasonable to log audit events on behalf of the
	 CacheFiles module.

     Christoph asserts that I may *not* change the context (whether fsuid/fsgid
     or security context) of the calling process, and that means that I would
     have to instead run the CacheFiles operations in their own thread or,
     possibly, farm them off to userspace.

     There is a serious performance problem, however, with using a separate
     thread: it would serialise accesses to the netfs over the duration of the
     backing fs's accesses to the cache, which, apart from read/write, are
     synchronous.

     Now, I could use mitigate this by using multiple threads, but it's going
     to be serialised at some level, and allocating more threads uses more
     resources.  With what I have at the moment, each process can separately
     access the cache, and so this isn't actually a problem.

     And it's not just a matter of each cached netfs being serialised with
     respect to itself; *all* cached netfs's will be serialised systemwide.

     Now, if there's mostly only one process accessing NFS files at once on a
     system, then this isn't actually too much of a problem, but if you want to
     do something like "make -jN" on an NFS mounted build tree, then it could
     get interesting.

 (2) I/O.

     There are a number of issues here:

     (a) Without being able to use O_DIRECT, I have to copy data around between
     	 the netfs and backing fs pages.  There's not a lot I can do about that
     	 just at the moment.

     (b) I've got a function to copy the data from an arbitrary kernel page to
     	 a particular page in a specified address space (used to store a page
     	 of data from a netfs page into a page in the appropriate inode of a
     	 backing device).  Christoph seems happy enough with that.

     	 What he objects to is that I'm calling this function directly without
     	 jumping through the file ops table to get to it - which would permit a
     	 filesystem to do something different if it wanted to.  The function in
     	 effect invokes the address space operations (prepare_write() and
     	 commit_write()) directly, but Christoph says that isn't permitted.

	 However, I don't have a file struct available on which to call such an
	 operation.  I could allocate a file struct, but that then brings in
	 the ENFILE problem...

	 Objections have been raised to adding more I/O vectors, especially if
	 they're just for a facility like CacheFiles.

     (c) I'm calling readpage() with a NULL file struct pointer.  I'm not sure
     	 that's necessarily a good idea, but I don't have a file struct to give
     	 it.

     (d) I'm also calling readpage() directly, but that would seem not to be
	 permitted as Christoph said I'm not allowed to call address space ops
	 directly, except through file ops.

     (e) I'm using bmap() to do hole detection in the backing files.  Holes
     	 represent pages not yet retrieved from the server.  I can't use
     	 readpage() because that'll just return a page full of zeros.  Use of
     	 bmap() seems to offend people.

 (3) Communication with the daemon.

     CacheFiles has a daemon (cachefilesd) that does a number of cache
     maintenance operations in userspace, including: deletion of dead object,
     scanning of the cache to build up tables of cullable objects and the
     culling of objects.

     The daemon also sets up the cache initially, tells the module where to
     find it and otherwise configures the module.

     As it stands, the daemon opens /proc/fs/cachefiles to communicate with the
     cache.  The act of doing so starts the process of making a cache
     available.  The daemon then writes configuration commands down this "pipe"
     to tell configure the cache.  It can write further commands to alter the
     cache configuration.  It also writes commands to cull objects from the
     cache.

     The daemon can read from that file to determine the current state of the
     cache, including how much space is available.

     The daemon sets signal handling on that file so that the module can send
     it signals through the file to indicate that it should start culling.
     This means that the module doesn't have to know what process(es) are on
     the other end of that file.  It can just signal it.  I could have used
     poll() for this, but that'd mean calling poll() every time around the loop
     just to determine whether I should be culling or not.

     The daemon installs a dnotify watch on the graveyard directory into which
     the module will move things that need to be deleted.  This will cause the
     daemon to be signalled when its services in that department are required
     without the module having to do anything special.

     Note that the daemon can be busy scanning when a request comes to cull or
     delete.  If it's busy scanning, I'd rather not be polling the module at
     regular intervals also.  The signals really aren't likely to be received
     all that often.  There's hysteresis built in to deal with that.

     Finally, when the file descriptor is closed, it is assumed that the daemon
     has gone away or died, and the cachefiles module shuts down the cache
     facility.

     With this mechanism, I can permit multiple caches: I just have to let the
     file be opened multiple times, once per cache, and let there be a
     cachefiles daemon on the end of each.

     The objections raised to my approach are:

     (a) Christoph objected to my use of a proc-file.  He said I should be
     	 using sysfs.  However, having talked to GregKH, sysfs doesn't allow me
     	 to detect one of its files being closed.  There are several
     	 possibilities as to how this can be done:

	 (j) With a proc-file as I'm doing now.

	 (k) GregKH suggested using a chardev, and Matt Domsch suggested
	     creating one with a dynamic major and letting udev create the
	     device file.

	 (l) Al suggested an elaborate scheme involving creating a simple
	     filesystem just for CacheFiles; having the daemon put itself into
	     its own namespace; mount this fs and bind the cache, /etc and /usr
	     under it; and using kill_sb() to detect the cache going away.
	     There'd still be a "command file" in the cachefiles fs for the
	     daemon to control the module.

         (m) Alter sysfs to permit release detection and then use sysfs.

         (n) Use sysfs without release detection, use static configuration
             through sysfs files, and just ignore the fact that the daemon has
             gone away.  That has the disadvantage that we're ignoring the fact
             that the daemon might go away without us noticing.

         (o) Use netlink.  I don't know much about how to do this.

         The first two are definitely the simplest, as they involve just a
         single simple channel of communication between module and daemon.

     (b) Christoph also objected to my use of signalling the file descriptor to
     	 prod the daemon.  I could use poll() instead, but see above.

     (c) Al objected to my use of dnotify on the basis that I have a channel
     	 open between the module and the daemon anyway and could use that.  My
     	 take on this is that dnotify works automatically and the module
     	 doesn't have to anything special to indicate this to the daemon.

Anyway, can I have your advice please?

David
