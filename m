Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbVKKQx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbVKKQx3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 11:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbVKKQx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 11:53:29 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:30888 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750909AbVKKQx2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 11:53:28 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17268.52324.392146.995179@tut.ibm.com>
Date: Fri, 11 Nov 2005 10:52:52 -0600
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, karim@opersys.com
Subject: [PATCH 10/12] relayfs: add Documentation on global relay buffers
In-Reply-To: <17268.51814.215178.281986@tut.ibm.com>
References: <17268.51814.215178.281986@tut.ibm.com>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation update for creating global buffers.

Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

---

 relayfs.txt |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/relayfs.txt b/Documentation/filesystems/relayfs.txt
--- a/Documentation/filesystems/relayfs.txt
+++ b/Documentation/filesystems/relayfs.txt
@@ -143,7 +143,7 @@ Here's a summary of the API relayfs prov
     subbuf_start(buf, subbuf, prev_subbuf, prev_padding)
     buf_mapped(buf, filp)
     buf_unmapped(buf, filp)
-    create_buf_file(filename, parent, mode, buf)
+    create_buf_file(filename, parent, mode, buf, is_global)
     remove_buf_file(dentry)
 
   helper functions:
@@ -367,6 +367,25 @@ create_buf_file() is defined, remove_buf
 it's responsible for deleting the file(s) created in create_buf_file()
 and is called during relay_close().
 
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
 See the 'exported-relayfile' examples in the relay-apps tarball for
 examples of creating and using relay files in debugfs.
 


