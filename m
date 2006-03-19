Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWCSXNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWCSXNA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 18:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWCSXNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 18:13:00 -0500
Received: from hera.kernel.org ([140.211.167.34]:38795 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751198AbWCSXM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 18:12:58 -0500
Date: Sun, 19 Mar 2006 23:12:16 GMT
From: Eric Van Hensbergen <ericvh@hera.kernel.org>
Message-Id: <200603192312.k2JNCG6W031766@hera.kernel.org>
To: akpm@osdl.org
Subject: [PATCH] 9p: fix name consistency problems
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       ericvh@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] 9p: name consistency

There were a number of conflicting naming schemes used in the v9fs project.
The directory was fs/9p, but MAINTAINERS and Documentation referred to v9fs.
The module name itself was 9p2000, and the file system type was 9P.  This
patch attempts to clean that up, changing all references to 9p in order to
match the directory name.  We'll also start using 9p instead of v9fs as our
patch prefix.

There is also a minor consistency cleanup in the options changing the name
option to uname in order to more closely match the Plan 9 options.

Signed-off-by: Eric Van Hensbergevan <ericvh@gmail.com>

---

 Documentation/filesystems/9p.txt   |   99 ++++++++
 Documentation/filesystems/v9fs.txt |   99 --------
 MAINTAINERS                        |   24 +-
 fs/9p/9p.c                         |  429 ------------------------------------
 fs/9p/Makefile                     |    6 -
 fs/9p/fcall.c                      |  429 ++++++++++++++++++++++++++++++++++++
 fs/9p/v9fs.c                       |    8 -
 fs/9p/vfs_super.c                  |    2 
 8 files changed, 548 insertions(+), 548 deletions(-)
 create mode 100644 Documentation/filesystems/9p.txt
 delete mode 100644 Documentation/filesystems/v9fs.txt
 delete mode 100644 fs/9p/9p.c
 create mode 100644 fs/9p/fcall.c

1498ea8226e240f8777273e7b868eb665b21b782
diff --git a/Documentation/filesystems/9p.txt b/Documentation/filesystems/9p.txt
new file mode 100644
index 0000000..24c7a9c
--- /dev/null
+++ b/Documentation/filesystems/9p.txt
@@ -0,0 +1,99 @@
+			V9FS: 9P2000 for Linux
+			======================
+
+ABOUT
+=====
+
+v9fs is a Unix implementation of the Plan 9 9p remote filesystem protocol.
+
+This software was originally developed by Ron Minnich <rminnich@lanl.gov>
+and Maya Gokhale <maya@lanl.gov>.  Additional development by Greg Watson
+<gwatson@lanl.gov> and most recently Eric Van Hensbergen
+<ericvh@gmail.com> and Latchesar Ionkov <lucho@ionkov.net>.
+
+USAGE
+=====
+
+For remote file server:
+
+	mount -t 9P 10.10.1.2 /mnt/9
+
+For Plan 9 From User Space applications (http://swtch.com/plan9)
+
+	mount -t 9P `namespace`/acme /mnt/9 -o proto=unix,name=$USER
+
+OPTIONS
+=======
+
+  proto=name	select an alternative transport.  Valid options are
+  		currently:
+ 			unix - specifying a named pipe mount point
+ 			tcp  - specifying a normal TCP/IP connection
+ 			fd   - used passed file descriptors for connection
+                                (see rfdno and wfdno)
+
+  name=name	user name to attempt mount as on the remote server.  The
+  		server may override or ignore this value.  Certain user
+		names may require authentication.
+
+  aname=name	aname specifies the file tree to access when the server is
+  		offering several exported file systems.
+
+  debug=n	specifies debug level.  The debug level is a bitmask.
+  			0x01 = display verbose error messages
+			0x02 = developer debug (DEBUG_CURRENT)
+			0x04 = display 9P trace
+			0x08 = display VFS trace
+			0x10 = display Marshalling debug
+			0x20 = display RPC debug
+			0x40 = display transport debug
+			0x80 = display allocation debug
+
+  rfdno=n	the file descriptor for reading with proto=fd
+
+  wfdno=n	the file descriptor for writing with proto=fd
+
+  maxdata=n	the number of bytes to use for 9P packet payload (msize)
+
+  port=n	port to connect to on the remote server
+
+  noextend	force legacy mode (no 9P2000.u semantics)
+
+  uid		attempt to mount as a particular uid
+
+  gid		attempt to mount with a particular gid
+
+  afid		security channel - used by Plan 9 authentication protocols
+
+  nodevmap	do not map special files - represent them as normal files.
+  		This can be used to share devices/named pipes/sockets between
+		hosts.  This functionality will be expanded in later versions.
+
+RESOURCES
+=========
+
+The Linux version of the 9P server is now maintained under the npfs project
+on sourceforge (http://sourceforge.net/projects/npfs).
+
+There are user and developer mailing lists available through the v9fs project
+on sourceforge (http://sourceforge.net/projects/v9fs).
+
+News and other information is maintained on SWiK (http://swik.net/v9fs).
+
+Bug reports may be issued through the kernel.org bugzilla 
+(http://bugzilla.kernel.org)
+
+For more information on the Plan 9 Operating System check out
+http://plan9.bell-labs.com/plan9
+
+For information on Plan 9 from User Space (Plan 9 applications and libraries
+ported to Linux/BSD/OSX/etc) check out http://swtch.com/plan9
+
+
+STATUS
+======
+
+The 2.6 kernel support is working on PPC and x86.
+
+PLEASE USE THE SOURCEFORGE BUG-TRACKER TO REPORT PROBLEMS.
+
diff --git a/Documentation/filesystems/v9fs.txt b/Documentation/filesystems/v9fs.txt
deleted file mode 100644
index 24c7a9c..0000000
--- a/Documentation/filesystems/v9fs.txt
+++ /dev/null
@@ -1,99 +0,0 @@
-			V9FS: 9P2000 for Linux
-			======================
-
-ABOUT
-=====
-
-v9fs is a Unix implementation of the Plan 9 9p remote filesystem protocol.
-
-This software was originally developed by Ron Minnich <rminnich@lanl.gov>
-and Maya Gokhale <maya@lanl.gov>.  Additional development by Greg Watson
-<gwatson@lanl.gov> and most recently Eric Van Hensbergen
-<ericvh@gmail.com> and Latchesar Ionkov <lucho@ionkov.net>.
-
-USAGE
-=====
-
-For remote file server:
-
-	mount -t 9P 10.10.1.2 /mnt/9
-
-For Plan 9 From User Space applications (http://swtch.com/plan9)
-
-	mount -t 9P `namespace`/acme /mnt/9 -o proto=unix,name=$USER
-
-OPTIONS
-=======
-
-  proto=name	select an alternative transport.  Valid options are
-  		currently:
- 			unix - specifying a named pipe mount point
- 			tcp  - specifying a normal TCP/IP connection
- 			fd   - used passed file descriptors for connection
-                                (see rfdno and wfdno)
-
-  name=name	user name to attempt mount as on the remote server.  The
-  		server may override or ignore this value.  Certain user
-		names may require authentication.
-
-  aname=name	aname specifies the file tree to access when the server is
-  		offering several exported file systems.
-
-  debug=n	specifies debug level.  The debug level is a bitmask.
-  			0x01 = display verbose error messages
-			0x02 = developer debug (DEBUG_CURRENT)
-			0x04 = display 9P trace
-			0x08 = display VFS trace
-			0x10 = display Marshalling debug
-			0x20 = display RPC debug
-			0x40 = display transport debug
-			0x80 = display allocation debug
-
-  rfdno=n	the file descriptor for reading with proto=fd
-
-  wfdno=n	the file descriptor for writing with proto=fd
-
-  maxdata=n	the number of bytes to use for 9P packet payload (msize)
-
-  port=n	port to connect to on the remote server
-
-  noextend	force legacy mode (no 9P2000.u semantics)
-
-  uid		attempt to mount as a particular uid
-
-  gid		attempt to mount with a particular gid
-
-  afid		security channel - used by Plan 9 authentication protocols
-
-  nodevmap	do not map special files - represent them as normal files.
-  		This can be used to share devices/named pipes/sockets between
-		hosts.  This functionality will be expanded in later versions.
-
-RESOURCES
-=========
-
-The Linux version of the 9P server is now maintained under the npfs project
-on sourceforge (http://sourceforge.net/projects/npfs).
-
-There are user and developer mailing lists available through the v9fs project
-on sourceforge (http://sourceforge.net/projects/v9fs).
-
-News and other information is maintained on SWiK (http://swik.net/v9fs).
-
-Bug reports may be issued through the kernel.org bugzilla 
-(http://bugzilla.kernel.org)
-
-For more information on the Plan 9 Operating System check out
-http://plan9.bell-labs.com/plan9
-
-For information on Plan 9 from User Space (Plan 9 applications and libraries
-ported to Linux/BSD/OSX/etc) check out http://swtch.com/plan9
-
-
-STATUS
-======
-
-The 2.6 kernel support is working on PPC and x86.
-
-PLEASE USE THE SOURCEFORGE BUG-TRACKER TO REPORT PROBLEMS.
-
diff --git a/MAINTAINERS b/MAINTAINERS
index 3d7d30d..229d649 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -147,6 +147,18 @@ M:	p_gortmaker@yahoo.com
 L:	netdev@vger.kernel.org
 S:	Maintained
 
+9P FILE SYSTEM
+P:      Eric Van Hensbergen
+M:      ericvh@gmail.com
+P:      Ron Minnich
+M:      rminnich@lanl.gov
+P:      Latchesar Ionkov
+M:      lucho@ionkov.net
+L:      v9fs-developer@lists.sourceforge.net
+W:      http://v9fs.sf.net
+T:      git kernel.org:/pub/scm/linux/kernel/ericvh/v9fs.git
+S:      Maintained
+
 A2232 SERIAL BOARD DRIVER
 P:	Enver Haase
 M:	ehaase@inf.fu-berlin.de
@@ -2965,18 +2977,6 @@ L:	rio500-users@lists.sourceforge.net
 W:	http://rio500.sourceforge.net
 S:	Maintained
 
-V9FS FILE SYSTEM
-P:      Eric Van Hensbergen
-M:      ericvh@gmail.com
-P:      Ron Minnich
-M:      rminnich@lanl.gov
-P:      Latchesar Ionkov
-M:      lucho@ionkov.net
-L:      v9fs-developer@lists.sourceforge.net
-W:      http://v9fs.sf.net
-T:      git kernel.org:/pub/scm/linux/kernel/ericvh/v9fs-devel.git
-S:      Maintained
-
 VIDEO FOR LINUX
 P:	Mauro Carvalho Chehab
 M:	mchehab@infradead.org
diff --git a/fs/9p/9p.c b/fs/9p/9p.c
deleted file mode 100644
index 1d7ef3a..0000000
--- a/fs/9p/9p.c
+++ /dev/null
@@ -1,429 +0,0 @@
-/*
- *  linux/fs/9p/9p.c
- *
- *  This file contains functions to perform synchronous 9P calls
- *
- *  Copyright (C) 2004 by Latchesar Ionkov <lucho@ionkov.net>
- *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
- *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to:
- *  Free Software Foundation
- *  51 Franklin Street, Fifth Floor
- *  Boston, MA  02111-1301  USA
- *
- */
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/errno.h>
-#include <linux/fs.h>
-#include <linux/idr.h>
-
-#include "debug.h"
-#include "v9fs.h"
-#include "9p.h"
-#include "conv.h"
-#include "mux.h"
-
-/**
- * v9fs_t_version - negotiate protocol parameters with sever
- * @v9ses: 9P2000 session information
- * @msize: requested max size packet
- * @version: requested version.extension string
- * @fcall: pointer to response fcall pointer
- *
- */
-
-int
-v9fs_t_version(struct v9fs_session_info *v9ses, u32 msize,
-	       char *version, struct v9fs_fcall **rcp)
-{
-	int ret;
-	struct v9fs_fcall *tc;
-
-	dprintk(DEBUG_9P, "msize: %d version: %s\n", msize, version);
-	tc = v9fs_create_tversion(msize, version);
-
-	if (!IS_ERR(tc)) {
-		ret = v9fs_mux_rpc(v9ses->mux, tc, rcp);
-		kfree(tc);
-	} else
-		ret = PTR_ERR(tc);
-
-	return ret;
-}
-
-/**
- * v9fs_t_attach - mount the server
- * @v9ses: 9P2000 session information
- * @uname: user name doing the attach
- * @aname: remote name being attached to
- * @fid: mount fid to attatch to root node
- * @afid: authentication fid (in this case result key)
- * @fcall: pointer to response fcall pointer
- *
- */
-
-int
-v9fs_t_attach(struct v9fs_session_info *v9ses, char *uname, char *aname,
-	      u32 fid, u32 afid, struct v9fs_fcall **rcp)
-{
-	int ret;
-	struct v9fs_fcall* tc;
-
-	dprintk(DEBUG_9P, "uname '%s' aname '%s' fid %d afid %d\n", uname,
-		aname, fid, afid);
-
-	tc = v9fs_create_tattach(fid, afid, uname, aname);
-	if (!IS_ERR(tc)) {
-		ret = v9fs_mux_rpc(v9ses->mux, tc, rcp);
-		kfree(tc);
-	} else
-		ret = PTR_ERR(tc);
-
-	return ret;
-}
-
-static void v9fs_t_clunk_cb(void *a, struct v9fs_fcall *tc,
-	struct v9fs_fcall *rc, int err)
-{
-	int fid;
-	struct v9fs_session_info *v9ses;
-
-	if (err)
-		return;
-
-	fid = tc->params.tclunk.fid;
-	kfree(tc);
-
-	if (!rc)
-		return;
-
-	v9ses = a;
-	if (rc->id == RCLUNK)
-		v9fs_put_idpool(fid, &v9ses->fidpool);
-
-	kfree(rc);
-}
-
-/**
- * v9fs_t_clunk - release a fid (finish a transaction)
- * @v9ses: 9P2000 session information
- * @fid: fid to release
- * @fcall: pointer to response fcall pointer
- *
- */
-
-int
-v9fs_t_clunk(struct v9fs_session_info *v9ses, u32 fid)
-{
-	int ret;
-	struct v9fs_fcall *tc, *rc;
-
-	dprintk(DEBUG_9P, "fid %d\n", fid);
-
-	rc = NULL;
-	tc = v9fs_create_tclunk(fid);
-	if (!IS_ERR(tc))
-		ret = v9fs_mux_rpc(v9ses->mux, tc, &rc);
-	else
-		ret = PTR_ERR(tc);
-
-	if (ret)
-		dprintk(DEBUG_ERROR, "failed fid %d err %d\n", fid, ret);
-
-	v9fs_t_clunk_cb(v9ses, tc, rc, ret);
-	return ret;
-}
-
-/**
- * v9fs_v9fs_t_flush - flush a pending transaction
- * @v9ses: 9P2000 session information
- * @tag: tag to release
- *
- */
-
-int v9fs_t_flush(struct v9fs_session_info *v9ses, u16 oldtag)
-{
-	int ret;
-	struct v9fs_fcall *tc;
-
-	dprintk(DEBUG_9P, "oldtag %d\n", oldtag);
-
-	tc = v9fs_create_tflush(oldtag);
-	if (!IS_ERR(tc)) {
-		ret = v9fs_mux_rpc(v9ses->mux, tc, NULL);
-		kfree(tc);
-	} else
-		ret = PTR_ERR(tc);
-
-	return ret;
-}
-
-/**
- * v9fs_t_stat - read a file's meta-data
- * @v9ses: 9P2000 session information
- * @fid: fid pointing to file or directory to get info about
- * @fcall: pointer to response fcall
- *
- */
-
-int
-v9fs_t_stat(struct v9fs_session_info *v9ses, u32 fid, struct v9fs_fcall **rcp)
-{
-	int ret;
-	struct v9fs_fcall *tc;
-
-	dprintk(DEBUG_9P, "fid %d\n", fid);
-
-	ret = -ENOMEM;
-	tc = v9fs_create_tstat(fid);
-	if (!IS_ERR(tc)) {
-		ret = v9fs_mux_rpc(v9ses->mux, tc, rcp);
-		kfree(tc);
-	} else
-		ret = PTR_ERR(tc);
-
-	return ret;
-}
-
-/**
- * v9fs_t_wstat - write a file's meta-data
- * @v9ses: 9P2000 session information
- * @fid: fid pointing to file or directory to write info about
- * @stat: metadata
- * @fcall: pointer to response fcall
- *
- */
-
-int
-v9fs_t_wstat(struct v9fs_session_info *v9ses, u32 fid,
-	     struct v9fs_wstat *wstat, struct v9fs_fcall **rcp)
-{
-	int ret;
-	struct v9fs_fcall *tc;
-
-	dprintk(DEBUG_9P, "fid %d\n", fid);
-
-	tc = v9fs_create_twstat(fid, wstat, v9ses->extended);
-	if (!IS_ERR(tc)) {
-		ret = v9fs_mux_rpc(v9ses->mux, tc, rcp);
-		kfree(tc);
-	} else
-		ret = PTR_ERR(tc);
-
-	return ret;
-}
-
-/**
- * v9fs_t_walk - walk a fid to a new file or directory
- * @v9ses: 9P2000 session information
- * @fid: fid to walk
- * @newfid: new fid (for clone operations)
- * @name: path to walk fid to
- * @fcall: pointer to response fcall
- *
- */
-
-/* TODO: support multiple walk */
-
-int
-v9fs_t_walk(struct v9fs_session_info *v9ses, u32 fid, u32 newfid,
-	    char *name, struct v9fs_fcall **rcp)
-{
-	int ret;
-	struct v9fs_fcall *tc;
-	int nwname;
-
-	dprintk(DEBUG_9P, "fid %d newfid %d wname '%s'\n", fid, newfid, name);
-
-	if (name)
-		nwname = 1;
-	else
-		nwname = 0;
-
-	tc = v9fs_create_twalk(fid, newfid, nwname, &name);
-	if (!IS_ERR(tc)) {
-		ret = v9fs_mux_rpc(v9ses->mux, tc, rcp);
-		kfree(tc);
-	} else
-		ret = PTR_ERR(tc);
-
-	return ret;
-}
-
-/**
- * v9fs_t_open - open a file
- *
- * @v9ses - 9P2000 session information
- * @fid - fid to open
- * @mode - mode to open file (R, RW, etc)
- * @fcall - pointer to response fcall
- *
- */
-
-int
-v9fs_t_open(struct v9fs_session_info *v9ses, u32 fid, u8 mode,
-	    struct v9fs_fcall **rcp)
-{
-	int ret;
-	struct v9fs_fcall *tc;
-
-	dprintk(DEBUG_9P, "fid %d mode %d\n", fid, mode);
-
-	tc = v9fs_create_topen(fid, mode);
-	if (!IS_ERR(tc)) {
-		ret = v9fs_mux_rpc(v9ses->mux, tc, rcp);
-		kfree(tc);
-	} else
-		ret = PTR_ERR(tc);
-
-	return ret;
-}
-
-/**
- * v9fs_t_remove - remove a file or directory
- * @v9ses: 9P2000 session information
- * @fid: fid to remove
- * @fcall: pointer to response fcall
- *
- */
-
-int
-v9fs_t_remove(struct v9fs_session_info *v9ses, u32 fid,
-	      struct v9fs_fcall **rcp)
-{
-	int ret;
-	struct v9fs_fcall *tc;
-
-	dprintk(DEBUG_9P, "fid %d\n", fid);
-
-	tc = v9fs_create_tremove(fid);
-	if (!IS_ERR(tc)) {
-		ret = v9fs_mux_rpc(v9ses->mux, tc, rcp);
-		kfree(tc);
-	} else
-		ret = PTR_ERR(tc);
-
-	return ret;
-}
-
-/**
- * v9fs_t_create - create a file or directory
- * @v9ses: 9P2000 session information
- * @fid: fid to create
- * @name: name of the file or directory to create
- * @perm: permissions to create with
- * @mode: mode to open file (R, RW, etc)
- * @fcall: pointer to response fcall
- *
- */
-
-int
-v9fs_t_create(struct v9fs_session_info *v9ses, u32 fid, char *name, u32 perm, 
-	u8 mode, char *extension, struct v9fs_fcall **rcp)
-{
-	int ret;
-	struct v9fs_fcall *tc;
-
-	dprintk(DEBUG_9P, "fid %d name '%s' perm %x mode %d\n",
-		fid, name, perm, mode);
-
-	tc = v9fs_create_tcreate(fid, name, perm, mode, extension, 
-		v9ses->extended);
-
-	if (!IS_ERR(tc)) {
-		ret = v9fs_mux_rpc(v9ses->mux, tc, rcp);
-		kfree(tc);
-	} else
-		ret = PTR_ERR(tc);
-
-	return ret;
-}
-
-/**
- * v9fs_t_read - read data
- * @v9ses: 9P2000 session information
- * @fid: fid to read from
- * @offset: offset to start read at
- * @count: how many bytes to read
- * @fcall: pointer to response fcall (with data)
- *
- */
-
-int
-v9fs_t_read(struct v9fs_session_info *v9ses, u32 fid, u64 offset,
-	    u32 count, struct v9fs_fcall **rcp)
-{
-	int ret;
-	struct v9fs_fcall *tc, *rc;
-
-	dprintk(DEBUG_9P, "fid %d offset 0x%llux count 0x%x\n", fid,
-		(long long unsigned) offset, count);
-
-	tc = v9fs_create_tread(fid, offset, count);
-	if (!IS_ERR(tc)) {
-		ret = v9fs_mux_rpc(v9ses->mux, tc, &rc);
-		if (!ret)
-			ret = rc->params.rread.count;
-		if (rcp)
-			*rcp = rc;
-		else
-			kfree(rc);
-
-		kfree(tc);
-	} else
-		ret = PTR_ERR(tc);
-
-	return ret;
-}
-
-/**
- * v9fs_t_write - write data
- * @v9ses: 9P2000 session information
- * @fid: fid to write to
- * @offset: offset to start write at
- * @count: how many bytes to write
- * @fcall: pointer to response fcall
- *
- */
-
-int
-v9fs_t_write(struct v9fs_session_info *v9ses, u32 fid, u64 offset, u32 count,
-	const char __user *data, struct v9fs_fcall **rcp)
-{
-	int ret;
-	struct v9fs_fcall *tc, *rc;
-
-	dprintk(DEBUG_9P, "fid %d offset 0x%llux count 0x%x\n", fid,
-		(long long unsigned) offset, count);
-
-	tc = v9fs_create_twrite(fid, offset, count, data);
-	if (!IS_ERR(tc)) {
-		ret = v9fs_mux_rpc(v9ses->mux, tc, &rc);
-
-		if (!ret)
-			ret = rc->params.rwrite.count;
-		if (rcp)
-			*rcp = rc;
-		else
-			kfree(rc);
-
-		kfree(tc);
-	} else
-		ret = PTR_ERR(tc);
-
-	return ret;
-}
-
diff --git a/fs/9p/Makefile b/fs/9p/Makefile
index 12d5242..87897f8 100644
--- a/fs/9p/Makefile
+++ b/fs/9p/Makefile
@@ -1,9 +1,9 @@
-obj-$(CONFIG_9P_FS) := 9p2000.o
+obj-$(CONFIG_9P_FS) := 9p.o
 
-9p2000-objs := \
+9p-objs := \
 	trans_fd.o \
 	mux.o \
-	9p.o \
+	fcall.o \
 	conv.o \
 	vfs_super.o \
 	vfs_inode.o \
diff --git a/fs/9p/fcall.c b/fs/9p/fcall.c
new file mode 100644
index 0000000..ed7f033
--- /dev/null
+++ b/fs/9p/fcall.c
@@ -0,0 +1,429 @@
+/*
+ *  linux/fs/9p/fcall.c
+ *
+ *  This file contains functions to perform synchronous 9P calls
+ *
+ *  Copyright (C) 2004 by Latchesar Ionkov <lucho@ionkov.net>
+ *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
+ *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to:
+ *  Free Software Foundation
+ *  51 Franklin Street, Fifth Floor
+ *  Boston, MA  02111-1301  USA
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/idr.h>
+
+#include "debug.h"
+#include "v9fs.h"
+#include "9p.h"
+#include "conv.h"
+#include "mux.h"
+
+/**
+ * v9fs_t_version - negotiate protocol parameters with sever
+ * @v9ses: 9P2000 session information
+ * @msize: requested max size packet
+ * @version: requested version.extension string
+ * @fcall: pointer to response fcall pointer
+ *
+ */
+
+int
+v9fs_t_version(struct v9fs_session_info *v9ses, u32 msize,
+	       char *version, struct v9fs_fcall **rcp)
+{
+	int ret;
+	struct v9fs_fcall *tc;
+
+	dprintk(DEBUG_9P, "msize: %d version: %s\n", msize, version);
+	tc = v9fs_create_tversion(msize, version);
+
+	if (!IS_ERR(tc)) {
+		ret = v9fs_mux_rpc(v9ses->mux, tc, rcp);
+		kfree(tc);
+	} else
+		ret = PTR_ERR(tc);
+
+	return ret;
+}
+
+/**
+ * v9fs_t_attach - mount the server
+ * @v9ses: 9P2000 session information
+ * @uname: user name doing the attach
+ * @aname: remote name being attached to
+ * @fid: mount fid to attatch to root node
+ * @afid: authentication fid (in this case result key)
+ * @fcall: pointer to response fcall pointer
+ *
+ */
+
+int
+v9fs_t_attach(struct v9fs_session_info *v9ses, char *uname, char *aname,
+	      u32 fid, u32 afid, struct v9fs_fcall **rcp)
+{
+	int ret;
+	struct v9fs_fcall* tc;
+
+	dprintk(DEBUG_9P, "uname '%s' aname '%s' fid %d afid %d\n", uname,
+		aname, fid, afid);
+
+	tc = v9fs_create_tattach(fid, afid, uname, aname);
+	if (!IS_ERR(tc)) {
+		ret = v9fs_mux_rpc(v9ses->mux, tc, rcp);
+		kfree(tc);
+	} else
+		ret = PTR_ERR(tc);
+
+	return ret;
+}
+
+static void v9fs_t_clunk_cb(void *a, struct v9fs_fcall *tc,
+	struct v9fs_fcall *rc, int err)
+{
+	int fid;
+	struct v9fs_session_info *v9ses;
+
+	if (err)
+		return;
+
+	fid = tc->params.tclunk.fid;
+	kfree(tc);
+
+	if (!rc)
+		return;
+
+	v9ses = a;
+	if (rc->id == RCLUNK)
+		v9fs_put_idpool(fid, &v9ses->fidpool);
+
+	kfree(rc);
+}
+
+/**
+ * v9fs_t_clunk - release a fid (finish a transaction)
+ * @v9ses: 9P2000 session information
+ * @fid: fid to release
+ * @fcall: pointer to response fcall pointer
+ *
+ */
+
+int
+v9fs_t_clunk(struct v9fs_session_info *v9ses, u32 fid)
+{
+	int ret;
+	struct v9fs_fcall *tc, *rc;
+
+	dprintk(DEBUG_9P, "fid %d\n", fid);
+
+	rc = NULL;
+	tc = v9fs_create_tclunk(fid);
+	if (!IS_ERR(tc))
+		ret = v9fs_mux_rpc(v9ses->mux, tc, &rc);
+	else
+		ret = PTR_ERR(tc);
+
+	if (ret)
+		dprintk(DEBUG_ERROR, "failed fid %d err %d\n", fid, ret);
+
+	v9fs_t_clunk_cb(v9ses, tc, rc, ret);
+	return ret;
+}
+
+/**
+ * v9fs_v9fs_t_flush - flush a pending transaction
+ * @v9ses: 9P2000 session information
+ * @tag: tag to release
+ *
+ */
+
+int v9fs_t_flush(struct v9fs_session_info *v9ses, u16 oldtag)
+{
+	int ret;
+	struct v9fs_fcall *tc;
+
+	dprintk(DEBUG_9P, "oldtag %d\n", oldtag);
+
+	tc = v9fs_create_tflush(oldtag);
+	if (!IS_ERR(tc)) {
+		ret = v9fs_mux_rpc(v9ses->mux, tc, NULL);
+		kfree(tc);
+	} else
+		ret = PTR_ERR(tc);
+
+	return ret;
+}
+
+/**
+ * v9fs_t_stat - read a file's meta-data
+ * @v9ses: 9P2000 session information
+ * @fid: fid pointing to file or directory to get info about
+ * @fcall: pointer to response fcall
+ *
+ */
+
+int
+v9fs_t_stat(struct v9fs_session_info *v9ses, u32 fid, struct v9fs_fcall **rcp)
+{
+	int ret;
+	struct v9fs_fcall *tc;
+
+	dprintk(DEBUG_9P, "fid %d\n", fid);
+
+	ret = -ENOMEM;
+	tc = v9fs_create_tstat(fid);
+	if (!IS_ERR(tc)) {
+		ret = v9fs_mux_rpc(v9ses->mux, tc, rcp);
+		kfree(tc);
+	} else
+		ret = PTR_ERR(tc);
+
+	return ret;
+}
+
+/**
+ * v9fs_t_wstat - write a file's meta-data
+ * @v9ses: 9P2000 session information
+ * @fid: fid pointing to file or directory to write info about
+ * @stat: metadata
+ * @fcall: pointer to response fcall
+ *
+ */
+
+int
+v9fs_t_wstat(struct v9fs_session_info *v9ses, u32 fid,
+	     struct v9fs_wstat *wstat, struct v9fs_fcall **rcp)
+{
+	int ret;
+	struct v9fs_fcall *tc;
+
+	dprintk(DEBUG_9P, "fid %d\n", fid);
+
+	tc = v9fs_create_twstat(fid, wstat, v9ses->extended);
+	if (!IS_ERR(tc)) {
+		ret = v9fs_mux_rpc(v9ses->mux, tc, rcp);
+		kfree(tc);
+	} else
+		ret = PTR_ERR(tc);
+
+	return ret;
+}
+
+/**
+ * v9fs_t_walk - walk a fid to a new file or directory
+ * @v9ses: 9P2000 session information
+ * @fid: fid to walk
+ * @newfid: new fid (for clone operations)
+ * @name: path to walk fid to
+ * @fcall: pointer to response fcall
+ *
+ */
+
+/* TODO: support multiple walk */
+
+int
+v9fs_t_walk(struct v9fs_session_info *v9ses, u32 fid, u32 newfid,
+	    char *name, struct v9fs_fcall **rcp)
+{
+	int ret;
+	struct v9fs_fcall *tc;
+	int nwname;
+
+	dprintk(DEBUG_9P, "fid %d newfid %d wname '%s'\n", fid, newfid, name);
+
+	if (name)
+		nwname = 1;
+	else
+		nwname = 0;
+
+	tc = v9fs_create_twalk(fid, newfid, nwname, &name);
+	if (!IS_ERR(tc)) {
+		ret = v9fs_mux_rpc(v9ses->mux, tc, rcp);
+		kfree(tc);
+	} else
+		ret = PTR_ERR(tc);
+
+	return ret;
+}
+
+/**
+ * v9fs_t_open - open a file
+ *
+ * @v9ses - 9P2000 session information
+ * @fid - fid to open
+ * @mode - mode to open file (R, RW, etc)
+ * @fcall - pointer to response fcall
+ *
+ */
+
+int
+v9fs_t_open(struct v9fs_session_info *v9ses, u32 fid, u8 mode,
+	    struct v9fs_fcall **rcp)
+{
+	int ret;
+	struct v9fs_fcall *tc;
+
+	dprintk(DEBUG_9P, "fid %d mode %d\n", fid, mode);
+
+	tc = v9fs_create_topen(fid, mode);
+	if (!IS_ERR(tc)) {
+		ret = v9fs_mux_rpc(v9ses->mux, tc, rcp);
+		kfree(tc);
+	} else
+		ret = PTR_ERR(tc);
+
+	return ret;
+}
+
+/**
+ * v9fs_t_remove - remove a file or directory
+ * @v9ses: 9P2000 session information
+ * @fid: fid to remove
+ * @fcall: pointer to response fcall
+ *
+ */
+
+int
+v9fs_t_remove(struct v9fs_session_info *v9ses, u32 fid,
+	      struct v9fs_fcall **rcp)
+{
+	int ret;
+	struct v9fs_fcall *tc;
+
+	dprintk(DEBUG_9P, "fid %d\n", fid);
+
+	tc = v9fs_create_tremove(fid);
+	if (!IS_ERR(tc)) {
+		ret = v9fs_mux_rpc(v9ses->mux, tc, rcp);
+		kfree(tc);
+	} else
+		ret = PTR_ERR(tc);
+
+	return ret;
+}
+
+/**
+ * v9fs_t_create - create a file or directory
+ * @v9ses: 9P2000 session information
+ * @fid: fid to create
+ * @name: name of the file or directory to create
+ * @perm: permissions to create with
+ * @mode: mode to open file (R, RW, etc)
+ * @fcall: pointer to response fcall
+ *
+ */
+
+int
+v9fs_t_create(struct v9fs_session_info *v9ses, u32 fid, char *name, u32 perm, 
+	u8 mode, char *extension, struct v9fs_fcall **rcp)
+{
+	int ret;
+	struct v9fs_fcall *tc;
+
+	dprintk(DEBUG_9P, "fid %d name '%s' perm %x mode %d\n",
+		fid, name, perm, mode);
+
+	tc = v9fs_create_tcreate(fid, name, perm, mode, extension, 
+		v9ses->extended);
+
+	if (!IS_ERR(tc)) {
+		ret = v9fs_mux_rpc(v9ses->mux, tc, rcp);
+		kfree(tc);
+	} else
+		ret = PTR_ERR(tc);
+
+	return ret;
+}
+
+/**
+ * v9fs_t_read - read data
+ * @v9ses: 9P2000 session information
+ * @fid: fid to read from
+ * @offset: offset to start read at
+ * @count: how many bytes to read
+ * @fcall: pointer to response fcall (with data)
+ *
+ */
+
+int
+v9fs_t_read(struct v9fs_session_info *v9ses, u32 fid, u64 offset,
+	    u32 count, struct v9fs_fcall **rcp)
+{
+	int ret;
+	struct v9fs_fcall *tc, *rc;
+
+	dprintk(DEBUG_9P, "fid %d offset 0x%llux count 0x%x\n", fid,
+		(long long unsigned) offset, count);
+
+	tc = v9fs_create_tread(fid, offset, count);
+	if (!IS_ERR(tc)) {
+		ret = v9fs_mux_rpc(v9ses->mux, tc, &rc);
+		if (!ret)
+			ret = rc->params.rread.count;
+		if (rcp)
+			*rcp = rc;
+		else
+			kfree(rc);
+
+		kfree(tc);
+	} else
+		ret = PTR_ERR(tc);
+
+	return ret;
+}
+
+/**
+ * v9fs_t_write - write data
+ * @v9ses: 9P2000 session information
+ * @fid: fid to write to
+ * @offset: offset to start write at
+ * @count: how many bytes to write
+ * @fcall: pointer to response fcall
+ *
+ */
+
+int
+v9fs_t_write(struct v9fs_session_info *v9ses, u32 fid, u64 offset, u32 count,
+	const char __user *data, struct v9fs_fcall **rcp)
+{
+	int ret;
+	struct v9fs_fcall *tc, *rc;
+
+	dprintk(DEBUG_9P, "fid %d offset 0x%llux count 0x%x\n", fid,
+		(long long unsigned) offset, count);
+
+	tc = v9fs_create_twrite(fid, offset, count, data);
+	if (!IS_ERR(tc)) {
+		ret = v9fs_mux_rpc(v9ses->mux, tc, &rc);
+
+		if (!ret)
+			ret = rc->params.rwrite.count;
+		if (rcp)
+			*rcp = rc;
+		else
+			kfree(rc);
+
+		kfree(tc);
+	} else
+		ret = PTR_ERR(tc);
+
+	return ret;
+}
+
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index e49e7d1..70cacdf 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -50,7 +50,7 @@ enum {
 	Opt_port, Opt_msize, Opt_uid, Opt_gid, Opt_afid, Opt_debug,
 	Opt_rfdno, Opt_wfdno,
 	/* String options */
-	Opt_name, Opt_remotename,
+	Opt_uname, Opt_remotename,
 	/* Options that take no arguments */
 	Opt_legacy, Opt_nodevmap, Opt_unix, Opt_tcp, Opt_fd,
 	/* Error token */
@@ -66,7 +66,7 @@ static match_table_t tokens = {
 	{Opt_rfdno, "rfdno=%u"},
 	{Opt_wfdno, "wfdno=%u"},
 	{Opt_debug, "debug=%x"},
-	{Opt_name, "name=%s"},
+	{Opt_uname, "uname=%s"},
 	{Opt_remotename, "aname=%s"},
 	{Opt_unix, "proto=unix"},
 	{Opt_tcp, "proto=tcp"},
@@ -115,7 +115,7 @@ static void v9fs_parse_options(char *opt
 		if (!*p)
 			continue;
 		token = match_token(p, tokens, args);
-		if (token < Opt_name) {
+		if (token < Opt_uname) {
 			if ((ret = match_int(&args[0], &option)) < 0) {
 				dprintk(DEBUG_ERROR,
 					"integer field, but no integer?\n");
@@ -157,7 +157,7 @@ static void v9fs_parse_options(char *opt
 		case Opt_fd:
 			v9ses->proto = PROTO_FD;
 			break;
-		case Opt_name:
+		case Opt_uname:
 			match_strcpy(v9ses->name, &args[0]);
 			break;
 		case Opt_remotename:
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 083ed5a..b0a0ae5 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -261,7 +261,7 @@ static struct super_operations v9fs_supe
 };
 
 struct file_system_type v9fs_fs_type = {
-	.name = "9P",
+	.name = "9p",
 	.get_sb = v9fs_get_sb,
 	.kill_sb = v9fs_kill_super,
 	.owner = THIS_MODULE,
-- 
1.1.0
