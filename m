Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161248AbVKIVwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161248AbVKIVwe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161258AbVKIVwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:52:34 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:65172 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161256AbVKIVw0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:52:26 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17266.28537.722390.913812@tut.ibm.com>
Date: Wed, 9 Nov 2005 15:51:53 -0600
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, karim@opersys.com
Subject: [PATCH 4/4] relayfs: Documentation for exported relay fileops 
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation update for exported relay fileops support.

This patch depends on [PATCH 2/4] relayfs: Documentation for non-relay
file support.

Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

---

diff --git a/Documentation/filesystems/relayfs.txt b/Documentation/filesystems/relayfs.txt
--- a/Documentation/filesystems/relayfs.txt
+++ b/Documentation/filesystems/relayfs.txt
@@ -153,6 +153,8 @@ Here's a summary of the API relayfs prov
     subbuf_start(buf, subbuf, prev_subbuf, prev_padding)
     buf_mapped(buf, filp)
     buf_unmapped(buf, filp)
+    create_buf_file(filename, parent, mode, buf, is_global)
+    remove_buf_file(dentry)
 
   helper functions:
 
@@ -347,6 +349,51 @@ for the file and an optional void * to a
 which will be accessible via inode->u.generic_ip (see the relay-apps
 tarball for examples).
 
+Creating relay files in other filesystems
+-----------------------------------------
+
+By default of course, relay_open() creates relay files in the relayfs
+filesystem.  Because relay_file_operations is exported, however, it's
+also possible to create and use relay files in other pseudo-filesytems
+such as debugfs.
+
+For this purpose, two callback functions are provided,
+create_buf_file() and remove_buf_file().  create_buf_file() is called
+once for each per-cpu buffer from relay_open() to allow the client to
+create a file to be used to represent the corresponding buffer; if
+this callback is not defined, the default implementation will create
+and return a file in the relayfs filesystem to represent the buffer.
+The callback should return the dentry of the file created to represent
+the relay buffer.  Note that the parent directory passed to
+relay_open() (and passed along to the callback), if specified, must
+exist in the same filesystem the new relay file is created in.  If
+create_buf_file() is defined, remove_buf_file() must also be defined;
+it's responsible for deleting the file(s) created in create_buf_file()
+and is called during relay_close().
+
+The create_buf_file() implementation can also be defined in such a way
+as to allow the creation of a single 'global' buffer instead of the
+default per-cpu set.  This can be useful for applications interested
+mainly in seeing the relative ordering of system-wide events without
+the need to bother with saving explicit timestamps for the purpose of
+merging/sorting per-cpu files in a postprocessing step.
+
+To have relay_open() create a global buffer, the create_buf_file()
+implementation should set the value of the is_global outparam to a
+non-zero value in addition to creating the file that will be used to
+represent the single buffer.  In the case of a global buffer,
+create_buf_file() and remove_buf_file() will be called only once.  The
+normal channel-writing functions e.g. relay_write() can still be used
+- writes from any cpu will transparently end up in the global buffer -
+but since it is a global buffer, callers should make sure they use the
+proper locking for such a buffer, either by wrapping writes in a
+spinlock, or by copying a write function from relayfs_fs.h and
+creating a local version that internally does the proper locking.
+
+See the 'exported-relayfile' examples in the relay-apps tarball for
+examples of creating and using both per-cpu and global relay files
+in debugfs.
+
 Misc
 ----
 


