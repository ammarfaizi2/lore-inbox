Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262776AbVCWRzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbVCWRzb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 12:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262741AbVCWRzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 12:55:31 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:17120 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262776AbVCWRy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 12:54:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=o+y5igfwi7XgJJMP+cKC2c700WhbzsdV/7hiVVYwwt33NwB3FDCTMVy/x/DvrEuuQSUtrn+ZADNoe1I57XQdt2lxe5C77zlNpzF6PK0To36pdTIkamULtf9k7it9n4D6WZzCp5IViE+4Flo4sd4jy59Nr1M+ZBXb22j6oGfvf2k=
Message-ID: <3b2b3200503230954346e0665@mail.gmail.com>
Date: Wed, 23 Mar 2005 12:54:55 -0500
From: Linh Dang <dang.linh@gmail.com>
Reply-To: Linh Dang <dang.linh@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Hack to get dvd-burning at 8x (instead of 3x) with ide-cd (2.6.11)
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1339_28582172.1111600495951"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1339_28582172.1111600495951
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I'd like to receive  comments/guide-lines about a hack I made to the
2.6.11 kernel to improve DVD-burning speed (using growisofs.)

The basic idea is the 16-pages pipe between mkisofs and growisofs is
too small for DVD burning (typical 4GB of data.)

In the hack, pipe_new will simply check for, if privileges permitted,
the enviroment variable
PIPE_MAX_ORDER to see if a (much) longer pipe is requested.

This hack enable me to burn DVD at 8X (instead of 3X) on my old
P3-450MHz (with growisofs and mkisofs running at SCHED_FIFO.)

-- 
Linh Dang

------=_Part_1339_28582172.1111600495951
Content-Type: text/x-patch; name="pipe_fs.i.h.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="pipe_fs.i.h.diff"

--- linux-2.6.11/include/linux/pipe_fs_i.h=09        2005/03/17 15:39:38
+++ linux-2.6.11-vpipe/include/linux/pipe_fs_i.h=092005/03/23 17:27:12
@@ -21,7 +21,6 @@ struct pipe_buf_operations {
 struct pipe_inode_info {
 =09wait_queue_head_t wait;
 =09unsigned int nrbufs, curbuf;
-=09struct pipe_buffer bufs[PIPE_BUFFERS];
 =09struct page *tmp_page;
 =09unsigned int start;
 =09unsigned int readers;
@@ -31,6 +30,8 @@ struct pipe_inode_info {
 =09unsigned int w_counter;
 =09struct fasync_struct *fasync_readers;
 =09struct fasync_struct *fasync_writers;
+        unsigned max_nr_buffers;
+=09struct pipe_buffer bufs[0];
 };
=20
 /* Differs from PIPE_BUF in that PIPE_SIZE is the length of the actual

------=_Part_1339_28582172.1111600495951
Content-Type: text/x-patch; name="pipe.c.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="pipe.c.diff"

--- linux-2.6.11/fs/pipe.c=09        2005/03/17 15:30:32
+++ linux-2.6.11-vpipe/fs/pipe.c=092005/03/23 17:16:46
@@ -160,7 +160,7 @@ pipe_readv(struct file *filp, const stru
 =09=09=09if (!buf->len) {
 =09=09=09=09buf->ops =3D NULL;
 =09=09=09=09ops->release(info, buf);
-=09=09=09=09curbuf =3D (curbuf + 1) & (PIPE_BUFFERS-1);
+=09=09=09=09curbuf =3D (curbuf + 1) & (info->max_nr_buffers - 1);
 =09=09=09=09info->curbuf =3D curbuf;
 =09=09=09=09info->nrbufs =3D --bufs;
 =09=09=09=09do_wakeup =3D 1;
@@ -243,7 +243,7 @@ pipe_writev(struct file *filp, const str
=20
 =09/* We try to merge small writes */
 =09if (info->nrbufs && total_len < PAGE_SIZE) {
-=09=09int lastbuf =3D (info->curbuf + info->nrbufs - 1) & (PIPE_BUFFERS-1)=
;
+=09=09int lastbuf =3D (info->curbuf + info->nrbufs - 1) & (info->max_nr_bu=
ffers-1);
 =09=09struct pipe_buffer *buf =3D info->bufs + lastbuf;
 =09=09struct pipe_buf_operations *ops =3D buf->ops;
 =09=09int offset =3D buf->offset + buf->len;
@@ -270,9 +270,9 @@ pipe_writev(struct file *filp, const str
 =09=09=09break;
 =09=09}
 =09=09bufs =3D info->nrbufs;
-=09=09if (bufs < PIPE_BUFFERS) {
+=09=09if (bufs < info->max_nr_buffers) {
 =09=09=09ssize_t chars;
-=09=09=09int newbuf =3D (info->curbuf + bufs) & (PIPE_BUFFERS-1);
+=09=09=09int newbuf =3D (info->curbuf + bufs) & (info->max_nr_buffers-1);
 =09=09=09struct pipe_buffer *buf =3D info->bufs + newbuf;
 =09=09=09struct page *page =3D info->tmp_page;
 =09=09=09int error;
@@ -315,7 +315,7 @@ pipe_writev(struct file *filp, const str
 =09=09=09if (!total_len)
 =09=09=09=09break;
 =09=09}
-=09=09if (bufs < PIPE_BUFFERS)
+=09=09if (bufs < info->max_nr_buffers)
 =09=09=09continue;
 =09=09if (filp->f_flags & O_NONBLOCK) {
 =09=09=09if (!ret) ret =3D -EAGAIN;
@@ -382,7 +382,7 @@ pipe_ioctl(struct inode *pino, struct fi
 =09=09=09nrbufs =3D info->nrbufs;
 =09=09=09while (--nrbufs >=3D 0) {
 =09=09=09=09count +=3D info->bufs[buf].len;
-=09=09=09=09buf =3D (buf+1) & (PIPE_BUFFERS-1);
+=09=09=09=09buf =3D (buf+1) & (info->max_nr_buffers-1);
 =09=09=09}
 =09=09=09up(PIPE_SEM(*inode));
 =09=09=09return put_user(count, (int __user *)arg);
@@ -412,7 +412,7 @@ pipe_poll(struct file *filp, poll_table=20
 =09}
=20
 =09if (filp->f_mode & FMODE_WRITE) {
-=09=09mask |=3D (nrbufs < PIPE_BUFFERS) ? POLLOUT | POLLWRNORM : 0;
+=09=09mask |=3D (nrbufs < info->max_nr_buffers) ? POLLOUT | POLLWRNORM : 0=
;
 =09=09if (!PIPE_READERS(*inode))
 =09=09=09mask |=3D POLLERR;
 =09}
@@ -641,7 +641,7 @@ void free_pipe_info(struct inode *inode)
 =09struct pipe_inode_info *info =3D inode->i_pipe;
=20
 =09inode->i_pipe =3D NULL;
-=09for (i =3D 0; i < PIPE_BUFFERS; i++) {
+=09for (i =3D 0; i < info->max_nr_buffers; i++) {
 =09=09struct pipe_buffer *buf =3D info->bufs + i;
 =09=09if (buf->ops)
 =09=09=09buf->ops->release(info, buf);
@@ -653,13 +653,59 @@ void free_pipe_info(struct inode *inode)
=20
 struct inode* pipe_new(struct inode* inode)
 {
+#define ENV "PIPE_MAX_ORDER=3D"
 =09struct pipe_inode_info *info;
+        struct mm_struct       *mm =3D current ? get_task_mm(current) : NU=
LL;
+
+
+        char*                   env            =3D NULL;
+        unsigned                env_len        =3D 0;
+        unsigned                max_nr_buffers =3D PIPE_BUFFERS;
+
+        if (unlikely(capable(CAP_SYS_RESOURCE))) {
+                if (mm) {
+                        env_len =3D mm->env_end - mm->env_start;
+                        env     =3D kmalloc(env_len, GFP_KERNEL);
+                        access_process_vm(current, mm->env_start, env, env=
_len, 0);
+                        mmput(mm);
+                }
+
+                if (env) {
+                        const char* env_end =3D env + env_len;
+                        char*       p       =3D env;
+                        char*       dummy;
+
+
+                        while (p < env_end && strncmp(p, ENV, sizeof(ENV))=
)
+                                p =3D memscan(p, '\0', env_end - p) + 1;
+
+                        if (p < env_end && strncmp(p, ENV, sizeof(ENV)) =
=3D=3D 0) {
+                                unsigned  pipe_nr_buffers_order =3D
+                                        simple_strtoul(strchr(p, '=3D'), &=
dummy, 10);
+
+                                if (pipe_nr_buffers_order < 4)
+                                        pipe_nr_buffers_order =3D 4;
+
+                                if (pipe_nr_buffers_order > 16)
+                                        pipe_nr_buffers_order =3D 16;
+
+                                max_nr_buffers =3D 1 << pipe_nr_buffers_or=
der;
+                        }
+
+                        kfree(env);
+                }
+        }
+
+
+=09info =3D kcalloc(1, sizeof(struct pipe_inode_info) +
+                       sizeof(struct pipe_buffer) * max_nr_buffers,
+                                       GFP_KERNEL);
=20
-=09info =3D kmalloc(sizeof(struct pipe_inode_info), GFP_KERNEL);
 =09if (!info)
-=09=09goto fail_page;
-=09memset(info, 0, sizeof(*info));
-=09inode->i_pipe =3D info;
+                goto fail_page;
+
+        info->max_nr_buffers =3D max_nr_buffers;
+=09inode->i_pipe        =3D info;
=20
 =09init_waitqueue_head(PIPE_WAIT(*inode));
 =09PIPE_RCOUNTER(*inode) =3D PIPE_WCOUNTER(*inode) =3D 1;

------=_Part_1339_28582172.1111600495951--
