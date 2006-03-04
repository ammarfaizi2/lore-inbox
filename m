Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751810AbWCDPXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbWCDPXr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 10:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbWCDPXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 10:23:47 -0500
Received: from sccrmhc14.comcast.net ([63.240.77.84]:25339 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1751810AbWCDPXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 10:23:46 -0500
Date: Sat, 4 Mar 2006 10:25:13 -0500
From: Latchesar Ionkov <lucho@ionkov.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: [PATCH] v9fs: print 9p messages
Message-ID: <20060304152513.GA24046@ionkov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Print 9p messages.

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>

---
commit 066de5e57e6c8c8a1e0a6c49a342118f474b21e9
tree 1bca71ec5ed8419ee5d5a24cc607fe069940761c
parent c499ec24c31edf270e777a868ffd0daddcfe7ebd
author Latchesar Ionkov <lucho@ionkov.net> Sat, 04 Mar 2006 10:10:04 -0500
committer Latchesar Ionkov <lucho@ionkov.net> Sat, 04 Mar 2006 10:10:04 -0500

 fs/9p/Makefile  |    3 
 fs/9p/debug.h   |    1 
 fs/9p/fcprint.c |  347 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/9p/mux.c     |   15 ++
 4 files changed, 365 insertions(+), 1 deletions(-)

diff --git a/fs/9p/Makefile b/fs/9p/Makefile
index 2f4ce43..e24784f 100644
--- a/fs/9p/Makefile
+++ b/fs/9p/Makefile
@@ -14,5 +14,6 @@ obj-$(CONFIG_9P_FS) := 9p2000.o
 	vfs_dentry.o \
 	error.o \
 	v9fs.o \
-	fid.o
+	fid.o \
+	fcprint.o
 
diff --git a/fs/9p/debug.h b/fs/9p/debug.h
index fe55103..ff54a7b 100644
--- a/fs/9p/debug.h
+++ b/fs/9p/debug.h
@@ -30,6 +30,7 @@
 #define DEBUG_MUX		(1<<5)
 #define DEBUG_TRANS		(1<<6)
 #define DEBUG_SLABS	      	(1<<7)
+#define DEBUG_FCALL		(1<<8)
 
 #define DEBUG_DUMP_PKT		0
 
diff --git a/fs/9p/fcprint.c b/fs/9p/fcprint.c
new file mode 100644
index 0000000..c435675
--- /dev/null
+++ b/fs/9p/fcprint.c
@@ -0,0 +1,347 @@
+/*
+ *  linux/fs/9p/fcprint.c
+ *
+ *  Print 9P call.
+ *
+ *  Copyright (C) 2005 by Latchesar Ionkov <lucho@ionkov.net>
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
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/idr.h>
+
+#include "debug.h"
+#include "v9fs.h"
+#include "9p.h"
+#include "mux.h"
+
+static int
+v9fs_printqid(char *buf, int buflen, struct v9fs_qid *q)
+{
+	int n;
+	char b[10];
+
+	n = 0;
+	if (q->type & V9FS_QTDIR)
+		b[n++] = 'd';
+	if (q->type & V9FS_QTAPPEND)
+		b[n++] = 'a';
+	if (q->type & V9FS_QTAUTH)
+		b[n++] = 'A';
+	if (q->type & V9FS_QTEXCL)
+		b[n++] = 'l';
+	if (q->type & V9FS_QTTMP)
+		b[n++] = 't';
+	if (q->type & V9FS_QTSYMLINK)
+		b[n++] = 'L';
+	b[n] = '\0';
+
+	return snprintf(buf, buflen, "(%.16llx %x %s)", (long long int) q->path, 
+		q->version, b);
+}
+
+static int
+v9fs_printperm(char *buf, int buflen, int perm)
+{
+	int n;
+	char b[15];
+
+	n = 0;
+	if (perm & V9FS_DMDIR)
+		b[n++] = 'd';
+	if (perm & V9FS_DMAPPEND)
+		b[n++] = 'a';
+	if (perm & V9FS_DMAUTH)
+		b[n++] = 'A';
+	if (perm & V9FS_DMEXCL)
+		b[n++] = 'l';
+	if (perm & V9FS_DMTMP)
+		b[n++] = 't';
+	if (perm & V9FS_DMDEVICE)
+		b[n++] = 'D';
+	if (perm & V9FS_DMSOCKET)
+		b[n++] = 'S';
+	if (perm & V9FS_DMNAMEDPIPE)
+		b[n++] = 'P';
+	if (perm & V9FS_DMSYMLINK)
+		b[n++] = 'L';
+	b[n] = '\0';
+
+	return snprintf(buf, buflen, "%s%03o", b, perm&077);
+}
+
+int
+v9fs_printstat(char *buf, int buflen, struct v9fs_stat *st, int extended)
+{
+	int n;
+
+	n = snprintf(buf, buflen, "'%.*s' '%.*s'", st->name.len, 
+		st->name.str, st->uid.len, st->uid.str);
+	if (extended)
+		n += snprintf(buf+n, buflen-n, "(%d)", st->n_uid);
+
+	n += snprintf(buf+n, buflen-n, " '%.*s'", st->gid.len, st->gid.str);
+	if (extended)
+		n += snprintf(buf+n, buflen-n, "(%d)", st->n_gid);
+
+	n += snprintf(buf+n, buflen-n, " '%.*s'", st->muid.len, st->muid.str);
+	if (extended)
+		n += snprintf(buf+n, buflen-n, "(%d)", st->n_muid);
+	
+	n += snprintf(buf+n, buflen-n, " q ");
+	n += v9fs_printqid(buf+n, buflen-n, &st->qid);
+	n += snprintf(buf+n, buflen-n, " m ");
+	n += v9fs_printperm(buf+n, buflen-n, st->mode);
+	n += snprintf(buf+n, buflen-n, " at %d mt %d l %lld",
+		st->atime, st->mtime, (long long int) st->length);
+
+	if (extended)
+		n += snprintf(buf+n, buflen-n, " ext '%.*s'", 
+			st->extension.len, st->extension.str);
+
+	return n;
+}
+
+int
+v9fs_dumpdata(char *buf, int buflen, u8 *data, int datalen)
+{
+	int i, n;
+
+	i = n = 0;
+	while (i < datalen) {
+		n += snprintf(buf + n, buflen - n, "%02x", data[i]);
+		if (i%4 == 3)
+			n += snprintf(buf + n, buflen - n, " ");
+		if (i%32 == 31)
+			n += snprintf(buf + n, buflen - n, "\n");
+
+		i++;
+	}
+	n += snprintf(buf + n, buflen - n, "\n");
+
+	return n;
+}
+
+static int
+v9fs_printdata(char *buf, int buflen, u8 *data, int datalen)
+{
+	return v9fs_dumpdata(buf, buflen, data, datalen<16?datalen:16);
+}
+
+int
+v9fs_printfcall(char *buf, int buflen, struct v9fs_fcall *fc, int extended)
+{
+	int i, ret, type, tag;
+
+	if (!fc)
+		return snprintf(buf, buflen, "<NULL>");
+
+	type = fc->id;
+	tag = fc->tag;
+
+	ret = 0;
+	switch (type) {
+	case TVERSION:
+		ret += snprintf(buf+ret, buflen-ret, 
+			"Tversion tag %u msize %u version '%.*s'", tag,
+			fc->params.tversion.msize, fc->params.tversion.version.len,
+			fc->params.tversion.version.str);
+		break;
+
+	case RVERSION:
+		ret += snprintf(buf+ret, buflen-ret, 
+			"Rversion tag %u msize %u version '%.*s'", tag, 
+			fc->params.rversion.msize, fc->params.rversion.version.len,
+			fc->params.rversion.version.str);
+		break;
+
+	case TAUTH:
+		ret += snprintf(buf+ret, buflen-ret, 
+			"Tauth tag %u afid %d uname '%.*s' aname '%.*s'", tag, 
+			fc->params.tauth.afid, fc->params.tauth.uname.len,
+			fc->params.tauth.uname.str, fc->params.tauth.aname.len, 
+			fc->params.tauth.aname.str);
+		break;
+
+	case RAUTH:
+		ret += snprintf(buf+ret, buflen-ret, "Rauth tag %u qid ", tag); 
+		v9fs_printqid(buf+ret, buflen-ret, &fc->params.rauth.qid);
+		break;
+
+	case TATTACH:
+		ret += snprintf(buf+ret, buflen-ret, 
+			"Tattach tag %u fid %d afid %d uname '%.*s' aname '%.*s'",
+			tag, fc->params.tattach.fid, fc->params.tattach.afid, 
+			fc->params.tattach.uname.len, fc->params.tattach.uname.str,
+			fc->params.tattach.aname.len, fc->params.tattach.aname.str);
+		break;
+
+	case RATTACH:
+		ret += snprintf(buf+ret, buflen-ret, "Rattach tag %u qid ", tag); 
+		v9fs_printqid(buf+ret, buflen-ret, &fc->params.rattach.qid);
+		break;
+
+	case RERROR:
+		ret += snprintf(buf+ret, buflen-ret, "Rerror tag %u ename '%.*s'",
+			tag, fc->params.rerror.error.len, 
+			fc->params.rerror.error.str);
+		if (extended)
+			ret += snprintf(buf+ret, buflen-ret, " ecode %d\n",
+				fc->params.rerror.errno);
+		break;
+
+	case TFLUSH:
+		ret += snprintf(buf+ret, buflen-ret, "Tflush tag %u oldtag %u",
+			tag, fc->params.tflush.oldtag);
+		break;
+
+	case RFLUSH:
+		ret += snprintf(buf+ret, buflen-ret, "Rflush tag %u", tag);
+		break;
+
+	case TWALK:
+		ret += snprintf(buf+ret, buflen-ret, 
+			"Twalk tag %u fid %d newfid %d nwname %d", tag, 
+			fc->params.twalk.fid, fc->params.twalk.newfid, 
+			fc->params.twalk.nwname);
+		for(i = 0; i < fc->params.twalk.nwname; i++)
+			ret += snprintf(buf+ret, buflen-ret," '%.*s'", 
+				fc->params.twalk.wnames[i].len,
+				fc->params.twalk.wnames[i].str);
+		break;
+
+	case RWALK:
+		ret += snprintf(buf+ret, buflen-ret, "Rwalk tag %u nwqid %d", 
+			tag, fc->params.rwalk.nwqid);
+		for(i = 0; i < fc->params.rwalk.nwqid; i++)
+			ret += v9fs_printqid(buf+ret, buflen-ret, 
+				&fc->params.rwalk.wqids[i]);
+		break;
+		
+	case TOPEN:
+		ret += snprintf(buf+ret, buflen-ret, 
+			"Topen tag %u fid %d mode %d", tag,
+			fc->params.topen.fid, fc->params.topen.mode);
+		break;
+		
+	case ROPEN:
+		ret += snprintf(buf+ret, buflen-ret, "Ropen tag %u", tag);
+		ret += v9fs_printqid(buf+ret, buflen-ret, &fc->params.ropen.qid);
+		ret += snprintf(buf+ret, buflen-ret," iounit %d", 
+			fc->params.ropen.iounit);
+		break;
+		
+	case TCREATE:
+		ret += snprintf(buf+ret, buflen-ret, 
+			"Tcreate tag %u fid %d name '%.*s' perm ", tag, 
+			fc->params.tcreate.fid, fc->params.tcreate.name.len,
+			fc->params.tcreate.name.str);
+
+		ret += v9fs_printperm(buf+ret, buflen-ret, fc->params.tcreate.perm);
+		ret += snprintf(buf+ret, buflen-ret, " mode %d", 
+			fc->params.tcreate.mode);
+		break;
+		
+	case RCREATE:
+		ret += snprintf(buf+ret, buflen-ret, "Rcreate tag %u", tag);
+		ret += v9fs_printqid(buf+ret, buflen-ret, &fc->params.rcreate.qid);
+		ret += snprintf(buf+ret, buflen-ret, " iounit %d", 
+			fc->params.rcreate.iounit);
+		break;
+		
+	case TREAD:
+		ret += snprintf(buf+ret, buflen-ret, 
+			"Tread tag %u fid %d offset %lld count %u", tag, 
+			fc->params.tread.fid, 
+			(long long int) fc->params.tread.offset,
+			fc->params.tread.count);
+		break;
+		
+	case RREAD:
+		ret += snprintf(buf+ret, buflen-ret, 
+			"Rread tag %u count %u data ", tag, 
+			fc->params.rread.count);
+		ret += v9fs_printdata(buf+ret, buflen-ret, fc->params.rread.data,
+			fc->params.rread.count);
+		break;
+		
+	case TWRITE:
+		ret += snprintf(buf+ret, buflen-ret, 
+			"Twrite tag %u fid %d offset %lld count %u data ", 
+			tag, fc->params.twrite.fid, 
+			(long long int) fc->params.twrite.offset, 
+			fc->params.twrite.count);
+		ret += v9fs_printdata(buf+ret, buflen-ret, fc->params.twrite.data, 
+			fc->params.twrite.count);
+		break;
+		
+	case RWRITE:
+		ret += snprintf(buf+ret, buflen-ret, "Rwrite tag %u count %u", 
+			tag, fc->params.rwrite.count);
+		break;
+		
+	case TCLUNK:
+		ret += snprintf(buf+ret, buflen-ret, "Tclunk tag %u fid %d", 
+			tag, fc->params.tclunk.fid);
+		break;
+		
+	case RCLUNK:
+		ret += snprintf(buf+ret, buflen-ret, "Rclunk tag %u", tag);
+		break;
+		
+	case TREMOVE:
+		ret += snprintf(buf+ret, buflen-ret, "Tremove tag %u fid %d", 
+			tag, fc->params.tremove.fid);
+		break;
+		
+	case RREMOVE:
+		ret += snprintf(buf+ret, buflen-ret, "Rremove tag %u", tag);
+		break;
+		
+	case TSTAT:
+		ret += snprintf(buf+ret, buflen-ret, "Tstat tag %u fid %d", 
+			tag, fc->params.tstat.fid);
+		break;
+		
+	case RSTAT:
+		ret += snprintf(buf+ret, buflen-ret, "Rstat tag %u ", tag);
+		ret += v9fs_printstat(buf+ret, buflen-ret, &fc->params.rstat.stat,
+			extended);
+		break;
+		
+	case TWSTAT:
+		ret += snprintf(buf+ret, buflen-ret, "Twstat tag %u fid %d ", 
+			tag, fc->params.twstat.fid);
+		ret += v9fs_printstat(buf+ret, buflen-ret, &fc->params.twstat.stat,
+			extended);
+		break;
+		
+	case RWSTAT:
+		ret += snprintf(buf+ret, buflen-ret, "Rwstat tag %u", tag);
+		break;
+
+	default:
+		ret += snprintf(buf+ret, buflen-ret, "unknown type %d", type);
+		break;
+	}
+
+	return ret;
+}
diff --git a/fs/9p/mux.c b/fs/9p/mux.c
index ea1134e..b19d6a6 100644
--- a/fs/9p/mux.c
+++ b/fs/9p/mux.c
@@ -634,6 +634,14 @@ static void v9fs_read_work(void *a)
 			goto error;
 		}
 
+		if ((v9fs_debug_level&DEBUG_FCALL) == DEBUG_FCALL) {
+			char buf[150];
+
+			v9fs_printfcall(buf, sizeof(buf), m->rcall,
+				*m->extended);
+			printk(KERN_NOTICE ">>> %p %s\n", m, buf);
+		}
+
 		rcall = m->rcall;
 		rbuf = m->rbuf;
 		if (m->rpos > n) {
@@ -739,6 +747,13 @@ static struct v9fs_req *v9fs_send_reques
 
 	v9fs_set_tag(tc, n);
 
+	if ((v9fs_debug_level&DEBUG_FCALL) == DEBUG_FCALL) {
+		char buf[150];
+
+		v9fs_printfcall(buf, sizeof(buf), tc, *m->extended);
+		printk(KERN_NOTICE "<<< %p %s\n", m, buf);
+	}
+
 	req->tag = n;
 	req->tcall = tc;
 	req->rcall = NULL;
