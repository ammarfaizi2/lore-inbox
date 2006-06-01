Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbWFAPLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbWFAPLE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 11:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWFAPLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 11:11:03 -0400
Received: from tayrelbas04.tay.hp.com ([161.114.80.247]:61396 "EHLO
	tayrelbas04.tay.hp.com") by vger.kernel.org with ESMTP
	id S1030194AbWFAPLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 11:11:01 -0400
Date: Thu, 1 Jun 2006 11:11:00 -0400
From: Amy Griffis <amy.griffis@hp.com>
To: linux-kernel@vger.kernel.org
Cc: John McCutchan <john@johnmccutchan.com>, Robert Love <rlove@rlove.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 5/5] inotify: update kernel documentation
Message-ID: <20060601151100.GC2214@zk3.dec.com>
References: <20060601150702.GA2171@zk3.dec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060601150702.GA2171@zk3.dec.com>
X-Mailer: Mutt http://www.mutt.org/
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update kernel documentation to include a description of the inotify
kernel API.

Signed-off-by: Amy Griffis <amy.griffis@hp.com>

---

 Documentation/filesystems/inotify.txt |  130 +++++++++++++++++++++++++++++++--
 1 files changed, 124 insertions(+), 6 deletions(-)

d45652a4125e6e1ade00329ec0a18ffc0398e749
diff --git a/Documentation/filesystems/inotify.txt b/Documentation/filesystems/inotify.txt
index 6d50190..59a919f 100644
--- a/Documentation/filesystems/inotify.txt
+++ b/Documentation/filesystems/inotify.txt
@@ -69,17 +69,135 @@ Prototypes:
 	int inotify_rm_watch (int fd, __u32 mask);
 
 
-(iii) Internal Kernel Implementation
+(iii) Kernel Interface
 
-Each inotify instance is associated with an inotify_device structure.
+Inotify's kernel API consists a set of functions for managing watches and an
+event callback.
+
+To use the kernel API, you must first initialize an inotify instance with a set
+of inotify_operations.  You are given an opaque inotify_handle, which you use
+for any further calls to inotify.
+
+    struct inotify_handle *ih = inotify_init(my_event_handler);
+
+You must provide a function for processing events and a function for destroying
+the inotify watch.
+
+    void handle_event(struct inotify_watch *watch, u32 wd, u32 mask,
+    	              u32 cookie, const char *name, struct inode *inode)
+
+	watch - the pointer to the inotify_watch that triggered this call
+	wd - the watch descriptor
+	mask - describes the event that occurred
+	cookie - an identifier for synchronizing events
+	name - the dentry name for affected files in a directory-based event
+	inode - the affected inode in a directory-based event
+
+    void destroy_watch(struct inotify_watch *watch)
+
+You may add watches by providing a pre-allocated and initialized inotify_watch
+structure and specifying the inode to watch along with an inotify event mask.
+You must pin the inode during the call.  You will likely wish to embed the
+inotify_watch structure in a structure of your own which contains other
+information about the watch.  Once you add an inotify watch, it is immediately
+subject to removal depending on filesystem events.  You must grab a reference if
+you depend on the watch hanging around after the call.
+
+    inotify_init_watch(&my_watch->iwatch);
+    inotify_get_watch(&my_watch->iwatch);	// optional
+    s32 wd = inotify_add_watch(ih, &my_watch->iwatch, inode, mask);
+    inotify_put_watch(&my_watch->iwatch);	// optional
+
+You may use the watch descriptor (wd) or the address of the inotify_watch for
+other inotify operations.  You must not directly read or manipulate data in the
+inotify_watch.  Additionally, you must not call inotify_add_watch() more than
+once for a given inotify_watch structure, unless you have first called either
+inotify_rm_watch() or inotify_rm_wd().
+
+To determine if you have already registered a watch for a given inode, you may
+call inotify_find_watch(), which gives you both the wd and the watch pointer for
+the inotify_watch, or an error if the watch does not exist.
+
+    wd = inotify_find_watch(ih, inode, &watchp);
+
+You may use container_of() on the watch pointer to access your own data
+associated with a given watch.  When an existing watch is found,
+inotify_find_watch() bumps the refcount before releasing its locks.  You must
+put that reference with:
+
+    put_inotify_watch(watchp);
+
+Call inotify_find_update_watch() to update the event mask for an existing watch.
+inotify_find_update_watch() returns the wd of the updated watch, or an error if
+the watch does not exist.
+
+    wd = inotify_find_update_watch(ih, inode, mask);
+
+An existing watch may be removed by calling either inotify_rm_watch() or
+inotify_rm_wd().
+
+    int ret = inotify_rm_watch(ih, &my_watch->iwatch);
+    int ret = inotify_rm_wd(ih, wd);
+
+A watch may be removed while executing your event handler with the following:
+
+    inotify_remove_watch_locked(ih, iwatch);
+
+Call inotify_destroy() to remove all watches from your inotify instance and
+release it.  If there are no outstanding references, inotify_destroy() will call
+your destroy_watch op for each watch.
+
+    inotify_destroy(ih);
+
+When inotify removes a watch, it sends an IN_IGNORED event to your callback.
+You may use this event as an indication to free the watch memory.  Note that
+inotify may remove a watch due to filesystem events, as well as by your request.
+If you use IN_ONESHOT, inotify will remove the watch after the first event, at
+which point you may call the final inotify_put_watch.
+
+(iv) Kernel Interface Prototypes
+
+	struct inotify_handle *inotify_init(struct inotify_operations *ops);
+
+	inotify_init_watch(struct inotify_watch *watch);
+
+	s32 inotify_add_watch(struct inotify_handle *ih,
+		              struct inotify_watch *watch,
+			      struct inode *inode, u32 mask);
+
+	s32 inotify_find_watch(struct inotify_handle *ih, struct inode *inode,
+			       struct inotify_watch **watchp);
+
+	s32 inotify_find_update_watch(struct inotify_handle *ih,
+				      struct inode *inode, u32 mask);
+
+	int inotify_rm_wd(struct inotify_handle *ih, u32 wd);
+
+	int inotify_rm_watch(struct inotify_handle *ih,
+			     struct inotify_watch *watch);
+
+	void inotify_remove_watch_locked(struct inotify_handle *ih,
+					 struct inotify_watch *watch);
+
+	void inotify_destroy(struct inotify_handle *ih);
+
+	void get_inotify_watch(struct inotify_watch *watch);
+	void put_inotify_watch(struct inotify_watch *watch);
+
+
+(v) Internal Kernel Implementation
+
+Each inotify instance is represented by an inotify_handle structure.
+Inotify's userspace consumers also have an inotify_device which is
+associated with the inotify_handle, and on which events are queued.
 
 Each watch is associated with an inotify_watch structure.  Watches are chained
-off of each associated device and each associated inode.
+off of each associated inotify_handle and each associated inode.
 
-See fs/inotify.c for the locking and lifetime rules.
+See fs/inotify.c and fs/inotify_user.c for the locking and lifetime rules.
 
 
-(iv) Rationale
+(vi) Rationale
 
 Q: What is the design decision behind not tying the watch to the open fd of
    the watched object?
@@ -145,7 +263,7 @@ A: The poor user-space interface is the 
    file descriptor-based one that allows basic file I/O and poll/select.
    Obtaining the fd and managing the watches could have been done either via a
    device file or a family of new system calls.  We decided to implement a
-   family of system calls because that is the preffered approach for new kernel
+   family of system calls because that is the preferred approach for new kernel
    interfaces.  The only real difference was whether we wanted to use open(2)
    and ioctl(2) or a couple of new system calls.  System calls beat ioctls.
 
-- 
1.3.0

