Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263102AbVGNTYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263102AbVGNTYO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 15:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVGNTWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 15:22:16 -0400
Received: from peabody.ximian.com ([130.57.169.10]:5260 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261689AbVGNTUQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 15:20:16 -0400
Subject: [patch] inotify: documentation update
From: Robert Love <rml@novell.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, John McCutchan <ttb@tentacle.dhs.org>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 15:20:15 -0400
Message-Id: <1121368815.830.2.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Trivial documentation update for inotify.  Please, apply.

	Robert Love


Clean up and expand some of the inotify documentation.

Signed-off-by: Robert Love <rml@novell.com>

 Documentation/filesystems/inotify.txt |   77 +++++++++++++++++++---------------
 1 files changed, 45 insertions(+), 32 deletions(-)

diff -urN linux-2.6.13-rc3/Documentation/filesystems/inotify.txt linux/Documentation/filesystems/inotify.txt
--- linux-2.6.13-rc3/Documentation/filesystems/inotify.txt	2005-07-13 10:51:09.000000000 -0400
+++ linux/Documentation/filesystems/inotify.txt	2005-07-14 15:17:59.000000000 -0400
@@ -1,18 +1,22 @@
-				    inotify
-	     a powerful yet simple file change notification system
+				   inotify
+	    a powerful yet simple file change notification system
 
 
 
 Document started 15 Mar 2005 by Robert Love <rml@novell.com>
 
+
 (i) User Interface
 
-Inotify is controlled by a set of three sys calls 
+Inotify is controlled by a set of three system calls and normal file I/O on a
+returned file descriptor.
 
-First step in using inotify is to initialise an inotify instance
+First step in using inotify is to initialise an inotify instance:
 
 	int fd = inotify_init ();
 
+Each instance is associated with a unique, ordered queue.
+
 Change events are managed by "watches".  A watch is an (object,mask) pair where
 the object is a file or directory and the mask is a bit mask of one or more
 inotify events that the application wishes to receive.  See <linux/inotify.h>
@@ -22,43 +26,52 @@
 
 Watches on a directory will return events on any files inside of the directory.
 
-Adding a watch is simple,
+Adding a watch is simple:
 
 	int wd = inotify_add_watch (fd, path, mask);
 
-You can add a large number of files via something like
-
-	for each file to watch {
-		int wd = inotify_add_watch (fd, file, mask);
-	}
+Where "fd" is the return value from inotify_init(), path is the path to the
+object to watch, and mask is the watch mask (see <linux/inotify.h>).
 
 You can update an existing watch in the same manner, by passing in a new mask.
 
-An existing watch is removed via the INOTIFY_IGNORE ioctl, for example
+An existing watch is removed via
 
-	inotify_rm_watch (fd, wd);
+	int ret = inotify_rm_watch (fd, wd);
 
 Events are provided in the form of an inotify_event structure that is read(2)
-from a inotify instance fd.  The filename is of dynamic length and follows the 
-struct. It is of size len.  The filename is padded with null bytes to ensure 
-proper alignment.  This padding is reflected in len.
+from a given inotify instance.  The filename is of dynamic length and follows
+the struct. It is of size len.  The filename is padded with null bytes to
+ensure proper alignment.  This padding is reflected in len.
 
 You can slurp multiple events by passing a large buffer, for example
 
 	size_t len = read (fd, buf, BUF_LEN);
 
-Will return as many events as are available and fit in BUF_LEN.
+Where "buf" is a pointer to an array of "inotify_event" structures at least
+BUF_LEN bytes in size.  The above example will return as many events as are
+available and fit in BUF_LEN.
 
-each inotify instance fd is also select()- and poll()-able.
+Each inotify instance fd is also select()- and poll()-able.
 
-You can find the size of the current event queue via the FIONREAD ioctl.
+You can find the size of the current event queue via the standard FIONREAD
+ioctl on the fd returned by inotify_init().
 
 All watches are destroyed and cleaned up on close.
 
 
-(ii) Internal Kernel Implementation
+(ii)
+
+Prototypes:
+
+	int inotify_init (void);
+	int inotify_add_watch (int fd, const char *path, __u32 mask);
+	int inotify_rm_watch (int fd, __u32 mask);
+
 
-Each open inotify instance is associated with an inotify_device structure.
+(iii) Internal Kernel Implementation
+
+Each inotify instance is associated with an inotify_device structure.
 
 Each watch is associated with an inotify_watch structure.  Watches are chained
 off of each associated device and each associated inode.
@@ -66,7 +79,7 @@
 See fs/inotify.c for the locking and lifetime rules.
 
 
-(iii) Rationale
+(iv) Rationale
 
 Q: What is the design decision behind not tying the watch to the open fd of
    the watched object?
@@ -75,9 +88,9 @@
    This solves the primary problem with dnotify: keeping the file open pins
    the file and thus, worse, pins the mount.  Dnotify is therefore infeasible
    for use on a desktop system with removable media as the media cannot be
-   unmounted.
+   unmounted.  Watching a file should not require that it be open.
 
-Q: What is the design decision behind using an-fd-per-device as opposed to
+Q: What is the design decision behind using an-fd-per-instance as opposed to
    an fd-per-watch?
 
 A: An fd-per-watch quickly consumes more file descriptors than are allowed,
@@ -86,8 +99,8 @@
    can use epoll, but requiring both is a silly and extraneous requirement.
    A watch consumes less memory than an open file, separating the number
    spaces is thus sensible.  The current design is what user-space developers
-   want: Users initialize inotify, once, and add n watches, requiring but one fd
-   and no twiddling with fd limits.  Initializing an inotify instance two
+   want: Users initialize inotify, once, and add n watches, requiring but one
+   fd and no twiddling with fd limits.  Initializing an inotify instance two
    thousand times is silly.  If we can implement user-space's preferences 
    cleanly--and we can, the idr layer makes stuff like this trivial--then we 
    should.
@@ -111,9 +124,6 @@
      example, love it.  Trust me, I asked.  It is not a surprise: Who'd want
      to manage and block on 1000 fd's via select?
 
-   - You'd have to manage the fd's, as an example: Call close() when you
-     received a delete event.
-
    - No way to get out of band data.
 
    - 1024 is still too low.  ;-)
@@ -122,6 +132,11 @@
    scales to 1000s of directories, juggling 1000s of fd's just does not seem
    the right interface.  It is too heavy.
 
+   Additionally, it _is_ possible to  more than one instance  and
+   juggle more than one queue and thus more than one associated fd.  There
+   need not be a one-fd-per-process mapping; it is one-fd-per-queue and a
+   process can easily want more than one queue.
+
 Q: Why the system call approach?
 
 A: The poor user-space interface is the second biggest problem with dnotify.
@@ -131,8 +146,6 @@
    Obtaining the fd and managing the watches could have been done either via a
    device file or a family of new system calls.  We decided to implement a
    family of system calls because that is the preffered approach for new kernel
-   features and it means our user interface requirements.
-
-   Additionally, it _is_ possible to  more than one instance  and
-   juggle more than one queue and thus more than one associated fd.
+   interfaces.  The only real difference was whether we wanted to use open(2)
+   and ioctl(2) or a couple of new system calls.  System calls beat ioctls.
 


