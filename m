Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267501AbUHKClh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267501AbUHKClh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 22:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267790AbUHKClg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 22:41:36 -0400
Received: from smtp3.akamai.com ([63.116.109.25]:64681 "EHLO smtp3.akamai.com")
	by vger.kernel.org with ESMTP id S267501AbUHKClb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 22:41:31 -0400
Message-ID: <41198757.44B373C1@akamai.com>
Date: Tue, 10 Aug 2004 19:41:27 -0700
From: Prasanna Meda <pmeda@akamai.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: sendfile bugs(?)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



There seems to be couple of issues in sendfile code.
   - read_write.c: sys_sendfile:do_sendfile checks for ppos
       to be NULL,  the intension is checking the contents for
       zero.
  - locks_verify_write() may checks at different offset for
      permission, and copy at different offset, since it is also
      using out_file->f_pos.  And also it will be cleaner to
      update out_file->f_pos atomically only when it succeeds.
      It also deletes the dependency on f_pos from filemap.c.

Thanks,
Prasanna.

--- fs/read_write.c.saved       Tue Aug 10 19:10:35 2004
+++ fs/read_write.c     Tue Aug 10 19:34:09 2004
@@ -546,6 +546,7 @@
        loff_t pos;
        ssize_t retval;
        int fput_needed_in, fput_needed_out;
+       struct sendfile_target target;

        /*
         * Get input file, and verify that it is ok..
@@ -562,7 +563,7 @@
                goto fput_in;
        if (!in_file->f_op || !in_file->f_op->sendfile)
                goto fput_in;
-       if (!ppos)
+       if (!*ppos)
                ppos = &in_file->f_pos;
        retval = locks_verify_area(FLOCK_VERIFY_READ, in_inode, in_file,
*ppos, count);
        if (retval)
@@ -585,7 +586,10 @@
        if (!out_file->f_op || !out_file->f_op->sendpage)
                goto fput_out;
        out_inode = out_file->f_dentry->d_inode;
-       retval = locks_verify_area(FLOCK_VERIFY_WRITE, out_inode,
out_file, out_file->f_pos, count);
+
+       target.file = out_file;
+       target.pos = out_file->f_pos;
+       retval = locks_verify_area(FLOCK_VERIFY_WRITE, out_inode,
out_file, target.pos, count);
        if (retval)
                goto fput_out;

@@ -607,10 +611,12 @@
                count = max - pos;
        }

-       retval = in_file->f_op->sendfile(in_file, ppos, count,
file_send_actor, out_file);
+       retval = in_file->f_op->sendfile(in_file, ppos, count,
file_send_actor, &target);

        if (*ppos > max)
                retval = -EOVERFLOW;
+       if (!retval)
+               out_file->f_pos = target.pos;

 fput_out:
        fput_light(out_file, fput_needed_out);
--- include/linux/fs.h.saved    Tue Aug 10 19:17:05 2004
+++ include/linux/fs.h  Tue Aug 10 19:24:53 2004
@@ -851,9 +851,15 @@
        size_t count;
        char __user * buf;
        int error;
+       loff_t *pos;
 } read_descriptor_t;

 typedef int (*read_actor_t)(read_descriptor_t *, struct page *,
unsigned long, unsigned long);
+
+struct sendfile_target {
+       struct file *file;
+       loff_t pos;
+};

 /*
  * NOTE:
--- mm/filemap.c.saved  Tue Aug 10 19:13:07 2004
+++ mm/filemap.c        Tue Aug 10 19:24:35 2004
@@ -941,13 +941,14 @@
 {
        ssize_t written;
        unsigned long count = desc->count;
-       struct file *file = (struct file *) desc->buf;
+       struct file *file = desc->buf;
+       loff_t *ppos = desc->pos;

        if (size > count)
                size = count;

        written = file->f_op->sendpage(file, page, offset,
-                                      size, &file->f_pos, size<count);
+                                      size, ppos, size<count);
        if (written < 0) {
                desc->error = written;
                written = 0;
@@ -958,17 +959,19 @@
 }

 ssize_t generic_file_sendfile(struct file *in_file, loff_t *ppos,
-                        size_t count, read_actor_t actor, void __user
*target)
+                        size_t count, read_actor_t actor, void __user
*arg)
 {
        read_descriptor_t desc;
+       struct sendfile_target *target = arg;

        if (!count)
                return 0;

        desc.written = 0;
        desc.count = count;
-       desc.buf = target;
+       desc.buf = target->file;
        desc.error = 0;
+       desc.pos = &target->pos;

        do_generic_file_read(in_file, ppos, &desc, actor);
        if (desc.written)

