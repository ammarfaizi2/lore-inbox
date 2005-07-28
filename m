Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVG1OC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVG1OC6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 10:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVG1OAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 10:00:51 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:53932 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261464AbVG1N6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 09:58:32 -0400
Message-Id: <200507281358.j6SDwBRZ026263@ms-smtp-03-eri0.texas.rr.com>
From: ericvh@gmail.com
Date: Thu, 28 Jul 2005 08:57:23 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.13-rc3-mm2] v9fs: add fd based transport
Cc: v9fs-developer@lists.sourceforge.net, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

v9fs: add file-descriptor based transport as was requested by LANL and
Plan 9 from User Space folks.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---
commit e65b41c8081e0f7227a16d39a4bc65e2924d7680
tree 4cfd78c690d2e9852736499fe9d0a311c78beee8
parent eefccf73f82b2bdf353cd05b8e5d6142210bc80f
author Eric Van Hensbergen <ericvh@gmail.com> Thu, 28 Jul 2005 08:45:14 -0500
committer Eric Van Hensbergen <ericvh@gmail.com> Thu, 28 Jul 2005 08:45:14 -0500

 Documentation/filesystems/v9fs.txt |   13 +++
 fs/9p/Makefile                     |    1 
 fs/9p/trans_fd.c                   |  136 ++++++++++++++++++++++++++++++++++++
 fs/9p/transport.h                  |    1 
 fs/9p/v9fs.c                       |   27 +++++++
 fs/9p/v9fs.h                       |    4 +
 6 files changed, 178 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/v9fs.txt b/Documentation/filesystems/v9fs.txt
--- a/Documentation/filesystems/v9fs.txt
+++ b/Documentation/filesystems/v9fs.txt
@@ -26,9 +26,12 @@ OPTIONS
 =======
 
   proto=name	select an alternative transport.  Valid options are
-  		currently either unix (specifying a named pipe mount
-		point) or tcp (specifying a normal TCP/IP connection)
-
+  		currently:
+ 			unix - specifying a named pipe mount point 
+ 			tcp  - specifying a normal TCP/IP connection
+ 			fd   - used passed file descriptors for connection
+                                (see rfdno and wfdno)
+ 
   name=name	user name to attempt mount as on the remote server.  The
   		server may override or ignore this value.  Certain user
 		names may require authentication.
@@ -46,6 +49,10 @@ OPTIONS
 			0x40 = display transport debug
 			0x80 = display allocation debug
 
+  rfdno=n	the file descriptor for reading with proto=fd
+
+  wfdno=n	the file descriptor for writing with proto=fd
+
   maxdata=n	the number of bytes to use for 9P packet payload (msize)
 
   port=n	port to connect to on the remote server
diff --git a/fs/9p/Makefile b/fs/9p/Makefile
--- a/fs/9p/Makefile
+++ b/fs/9p/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_9P_FS) := 9p2000.o
 	vfs_dentry.o \
 	error.o \
 	mux.o \
+	trans_fd.o \
 	trans_sock.o \
 	9p.o \
 	conv.o \
diff --git a/fs/9p/trans_fd.c b/fs/9p/trans_fd.c
new file mode 100644
--- /dev/null
+++ b/fs/9p/trans_fd.c
@@ -0,0 +1,136 @@
+/*
+ * linux/fs/9p/trans_fd.c
+ *
+ * File Descriptor Transport Layer
+ *
+ *  Copyright (C) 2005 by Eric Van Hensbergen <ericvh@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
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
+#include <linux/net.h>
+#include <linux/ipv6.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/un.h>
+#include <asm/uaccess.h>
+#include <linux/inet.h>
+#include <linux/idr.h>
+#include <linux/file.h>
+
+#include "debug.h"
+#include "v9fs.h"
+#include "transport.h"
+
+struct v9fs_trans_fd {
+	struct file *in_file;
+	struct file *out_file;
+};
+
+/**
+ * v9fs_fd_recv - receive from a socket
+ * @v9ses: session information
+ * @v: buffer to receive data into
+ * @len: size of receive buffer
+ *
+ */
+
+static int v9fs_fd_recv(struct v9fs_transport *trans, void *v, int len)
+{
+	struct v9fs_trans_fd *ts = trans ? trans->priv : NULL;
+
+	return kernel_read(ts->in_file, ts->in_file->f_pos, v, len);
+}
+
+/**
+ * v9fs_fd_send - send to a socket
+ * @v9ses: session information
+ * @v: buffer to send data from
+ * @len: size of send buffer
+ *
+ */
+
+static int v9fs_fd_send(struct v9fs_transport *trans, void *v, int len)
+{
+	struct v9fs_trans_fd *ts = trans ? trans->priv : NULL;
+	mm_segment_t oldfs = get_fs();
+	int ret = 0;
+
+	set_fs(get_ds());
+	/* The cast to a user pointer is valid due to the set_fs() */
+	ret = vfs_write(ts->out_file, (void __user *)v, len, &ts->out_file->f_pos);
+	set_fs(oldfs);
+
+	return ret;
+}
+
+/**
+ * v9fs_fd_init - initialize file descriptor transport
+ * @v9ses: session information
+ * @addr: address of server to mount
+ * @data: mount options
+ *
+ */
+
+static int
+v9fs_fd_init(struct v9fs_session_info *v9ses, const char *addr, char *data)
+{
+	struct v9fs_trans_fd *ts = NULL;
+	struct v9fs_transport *trans = v9ses->transport;
+
+	sema_init(&trans->writelock, 1);
+	sema_init(&trans->readlock, 1);
+
+	ts = kmalloc(sizeof(struct v9fs_trans_fd), GFP_KERNEL);
+
+	if (!ts)
+		return -ENOMEM;
+
+	trans->priv = ts;
+
+	ts->in_file = fget( v9ses->rfdno );
+	ts->out_file = fget( v9ses->wfdno );
+
+	trans->status = Connected;
+
+	return 0;
+}
+
+
+/**
+ * v9fs_fd_close - shutdown file descriptor
+ * @trans: private socket structure
+ *
+ */
+
+static void v9fs_fd_close(struct v9fs_transport *trans)
+{
+	struct v9fs_trans_fd *ts = trans ? trans->priv : NULL;
+
+	kfree(ts);
+}
+
+struct v9fs_transport v9fs_trans_fd = {
+	.init = v9fs_fd_init,
+	.write = v9fs_fd_send,
+	.read = v9fs_fd_recv,
+	.close = v9fs_fd_close,
+};
+
diff --git a/fs/9p/transport.h b/fs/9p/transport.h
--- a/fs/9p/transport.h
+++ b/fs/9p/transport.h
@@ -43,3 +43,4 @@ struct v9fs_transport {
 
 extern struct v9fs_transport v9fs_trans_tcp;
 extern struct v9fs_transport v9fs_trans_unix;
+extern struct v9fs_transport v9fs_trans_fd;
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -50,10 +50,11 @@ int v9fs_debug_level = 0;	/* feature-rif
 enum {
 	/* Options that take integer arguments */
 	Opt_port, Opt_msize, Opt_uid, Opt_gid, Opt_afid, Opt_debug,
+	Opt_rfdno, Opt_wfdno,
 	/* String options */
 	Opt_name, Opt_remotename,
 	/* Options that take no arguments */
-	Opt_legacy, Opt_nodevmap, Opt_unix, Opt_tcp,
+	Opt_legacy, Opt_nodevmap, Opt_unix, Opt_tcp, Opt_fd,
 	/* Error token */
 	Opt_err
 };
@@ -64,13 +65,17 @@ static match_table_t tokens = {
 	{Opt_uid, "uid=%u"},
 	{Opt_gid, "gid=%u"},
 	{Opt_afid, "afid=%u"},
+	{Opt_rfdno, "rfdno=%u"},
+	{Opt_wfdno, "wfdno=%u"},
 	{Opt_debug, "debug=%u"},
 	{Opt_name, "name=%s"},
 	{Opt_remotename, "aname=%s"},
 	{Opt_unix, "proto=unix"},
 	{Opt_tcp, "proto=tcp"},
+	{Opt_fd, "proto=fd"},
 	{Opt_tcp, "tcp"},
 	{Opt_unix, "unix"},
+	{Opt_fd, "fd"},
 	{Opt_legacy, "noextend"},
 	{Opt_nodevmap, "nodevmap"},
 	{Opt_err, NULL}
@@ -101,6 +106,8 @@ static void v9fs_parse_options(char *opt
 	v9ses->extended = 1;
 	v9ses->afid = ~0;
 	v9ses->debug = 0;
+	v9ses->rfdno = ~0;
+	v9ses->wfdno = ~0;
 
 	if (!options)
 		return;
@@ -134,6 +141,12 @@ static void v9fs_parse_options(char *opt
 		case Opt_afid:
 			v9ses->afid = option;
 			break;
+		case Opt_rfdno:
+			v9ses->rfdno = option;
+			break;
+		case Opt_wfdno:
+			v9ses->wfdno = option;
+			break;
 		case Opt_debug:
 			v9ses->debug = option;
 			break;
@@ -143,6 +156,9 @@ static void v9fs_parse_options(char *opt
 		case Opt_unix:
 			v9ses->proto = PROTO_UNIX;
 			break;
+		case Opt_fd:
+			v9ses->proto = PROTO_FD;
+			break;
 		case Opt_name:
 			match_strcpy(v9ses->name, &args[0]);
 			break;
@@ -277,6 +293,15 @@ v9fs_session_init(struct v9fs_session_in
 		trans_proto = &v9fs_trans_unix;
 		*v9ses->remotename = 0;
 		break;
+	case PROTO_FD:
+		trans_proto = &v9fs_trans_fd;
+		*v9ses->remotename = 0;
+		if((v9ses->wfdno == ~0) || (v9ses->rfdno == ~0)) {
+			printk(KERN_ERR "v9fs: Insufficient options for proto=fd\n");
+			retval = -ENOPROTOOPT;
+			goto SessCleanUp;
+		}
+		break;
 	default:
 		printk(KERN_ERR "v9fs: Bad mount protocol %d\n", v9ses->proto);
 		retval = -ENOPROTOOPT;
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -46,6 +46,9 @@ struct v9fs_session_info {
 	unsigned short debug;	/* debug level */
 	unsigned short proto;	/* protocol to use */
 	unsigned int afid;	/* authentication fid */
+	unsigned int rfdno;	/* read file descriptor number */
+	unsigned int wfdno;	/* write file descriptor number */
+
 
 	char *name;		/* user name to mount as */
 	char *remotename;	/* name of remote hierarchy being mounted */
@@ -78,6 +81,7 @@ struct v9fs_session_info {
 enum {
 	PROTO_TCP,
 	PROTO_UNIX,
+	PROTO_FD,
 };
 
 int v9fs_session_init(struct v9fs_session_info *, const char *, char *);
