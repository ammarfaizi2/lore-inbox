Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267444AbRGPQIp>; Mon, 16 Jul 2001 12:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267441AbRGPQIf>; Mon, 16 Jul 2001 12:08:35 -0400
Received: from vti01.vertis.nl ([145.66.4.26]:44042 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S267444AbRGPQIa>;
	Mon, 16 Jul 2001 12:08:30 -0400
Message-ID: <938F7F15145BD311AECE00508B7152DB034C48D9@vts007.vertis.nl>
From: Rolf Fokkens <FokkensR@vertis.nl>
To: "'alan@lxorguk.ukuu.org.uk'" <alan@lxorguk.ukuu.org.uk>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: PATCH: /proc/<PID>/ulimit in 2.4.6
Date: Mon, 16 Jul 2001 18:07:11 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C10E11.5F1E51E0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C10E11.5F1E51E0
Content-Type: text/plain;
	charset="iso-8859-1"

Hi!

I couldn't find an easy way to inspect the ulimit settings of (other)
processes. The attached patch takes care of this.

Rolf


------_=_NextPart_000_01C10E11.5F1E51E0
Content-Type: application/octet-stream;
	name="linux-2.4.6-ulimit.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="linux-2.4.6-ulimit.patch"

There's no easy way in telling the ulimit settings of "other" =
processes. The=0A=
following patch publishes the ulimimit settings in =
/proc/<PID>/ulimit=0A=
=0A=
--- linux/fs/proc/base.c.ulimit	Sat Jul  7 11:37:38 2001=0A=
+++ linux/fs/proc/base.c	Thu Jul 12 18:25:17 2001=0A=
@@ -39,6 +39,7 @@=0A=
 int proc_pid_status(struct task_struct*,char*);=0A=
 int proc_pid_statm(struct task_struct*,char*);=0A=
 int proc_pid_cpu(struct task_struct*,char*);=0A=
+int proc_pid_ulimit(struct task_struct*,char*);=0A=
 =0A=
 static int proc_fd_link(struct inode *inode, struct dentry **dentry, =
struct vfsmount **mnt)=0A=
 {=0A=
@@ -520,6 +521,7 @@=0A=
 	PROC_PID_STATM,=0A=
 	PROC_PID_MAPS,=0A=
 	PROC_PID_CPU,=0A=
+	PROC_PID_ULIMIT,=0A=
 	PROC_PID_FD_DIR =3D 0x8000,	/* 0x8000-0xffff */=0A=
 };=0A=
 =0A=
@@ -539,6 +541,7 @@=0A=
   E(PROC_PID_CWD,	"cwd",		S_IFLNK|S_IRWXUGO),=0A=
   E(PROC_PID_ROOT,	"root",		S_IFLNK|S_IRWXUGO),=0A=
   E(PROC_PID_EXE,	"exe",		S_IFLNK|S_IRWXUGO),=0A=
+  E(PROC_PID_ULIMIT,	"ulimit",	S_IFREG|S_IRUGO),=0A=
   {0,0,NULL,0}=0A=
 };=0A=
 #undef E=0A=
@@ -883,6 +886,10 @@=0A=
 		case PROC_PID_MEM:=0A=
 			inode->i_op =3D &proc_mem_inode_operations;=0A=
 			inode->i_fop =3D &proc_mem_operations;=0A=
+			break;=0A=
+		case PROC_PID_ULIMIT:=0A=
+			inode->i_fop =3D &proc_info_file_operations;=0A=
+			inode->u.proc_i.op.proc_read =3D proc_pid_ulimit;=0A=
 			break;=0A=
 		default:=0A=
 			printk("procfs: impossible type (%d)",p->type);=0A=
--- linux/fs/proc/array.c.ulimit	Sat Jul  7 11:37:38 2001=0A=
+++ linux/fs/proc/array.c	Fri Jul 13 00:48:23 2001=0A=
@@ -36,6 +36,8 @@=0A=
  *			of forissier patch in 2.1.78 by=0A=
  *			Hans Marcus <crowbar@concepts.nl>=0A=
  *=0A=
+ * fokkensr@vertis.nl:	added /proc/<pid>/ulimit=0A=
+ *=0A=
  * aeb@cwi.nl        :  /proc/partitions=0A=
  *=0A=
  *=0A=
@@ -70,6 +72,7 @@=0A=
 #include <linux/smp.h>=0A=
 #include <linux/signal.h>=0A=
 #include <linux/highmem.h>=0A=
+#include <linux/resource.h>=0A=
 =0A=
 #include <asm/uaccess.h>=0A=
 #include <asm/pgtable.h>=0A=
@@ -506,6 +509,28 @@=0A=
 	return sprintf(buffer,"%d %d %d %d %d %d %d\n",=0A=
 		       size, resident, share, trs, lrs, drs, dt);=0A=
 }=0A=
+=0A=
+static int sprintf_rlim (unsigned long rlim, char delim, char * =
buffer)=0A=
+{=0A=
+	if (rlim =3D=3D RLIM_INFINITY) {=0A=
+		return sprintf (buffer, "unlimited%c", delim);=0A=
+	} else {=0A=
+		return sprintf (buffer, "%lu%c", rlim, delim);=0A=
+	}=0A=
+}=0A=
+=0A=
+int proc_pid_ulimit(struct task_struct *task, char * buffer)=0A=
+{=0A=
+	int i, len;=0A=
+=0A=
+	for (i =3D 0, len =3D 0 ; i < RLIM_NLIMITS; i++) {=0A=
+		len +=3D sprintf (buffer + len, "%d: ", i);=0A=
+		len +=3D sprintf_rlim (task->rlim[i].rlim_cur, ' ', buffer + =
len);=0A=
+		len +=3D sprintf_rlim (task->rlim[i].rlim_max, '\n',buffer + =
len);=0A=
+	}=0A=
+        return len;=0A=
+}=0A=
+=0A=
 =0A=
 /*=0A=
  * The way we support synthetic files > 4K=0A=

------_=_NextPart_000_01C10E11.5F1E51E0--
