Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262361AbUEBIDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbUEBIDw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 04:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbUEBIDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 04:03:52 -0400
Received: from ozlabs.org ([203.10.76.45]:11199 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262361AbUEBIDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 04:03:42 -0400
Date: Sun, 2 May 2004 18:00:29 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: intermezzo-devel@lists.sf.net, linux-kernel@vger.kernel.org
Subject: 9/10 intermezzos prefer eating memory
Message-ID: <20040502080029.GT20714@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Im sure the 4kB stack brigade wont be too happy about this:

presto_get_fileid: 4672
presto_copy_kml_tail: 4272

This is 2.6. The following patch fixes it. There are still more things
to attack (this is on ppc64 but you get the idea):

presto_ioctl: 1424
presto_journal_unlink: 1056
presto_journal_rename: 1040
presto_journal_rmdir: 1008

Anton

--

diff -puN fs/intermezzo/journal.c~intermezzofix fs/intermezzo/journal.c
--- foobar2/fs/intermezzo/journal.c~intermezzofix	2004-05-02 16:58:36.297497086 +1000
+++ foobar2-anton/fs/intermezzo/journal.c	2004-05-02 17:50:31.696425996 +1000
@@ -1235,12 +1235,15 @@ int presto_write_kml_logical_offset(stru
         return izo_rcvd_write(fset, &rec);
 }
 
+#define BUFSIZE 4096
+
 struct file * presto_copy_kml_tail(struct presto_file_set *fset,
                                    unsigned long int start)
 {
         struct file *f;
         int len;
         loff_t read_off, write_off, bytes;
+        char *buf;
 
         ENTRY;
 
@@ -1251,15 +1254,21 @@ struct file * presto_copy_kml_tail(struc
                 return f;
         }
 
+        buf = kmalloc(BUFSIZE, GFP_KERNEL);
+        if (!buf) {
+                EXIT;
+                return -ENOMEM;
+        }
+        memset(buf, 0, BUFSIZE);
+
         write_off = 0;
         read_off = start;
         bytes = fset->fset_kml.fd_offset - start;
         while (bytes > 0) {
-                char buf[4096];
                 int toread;
 
-                if (bytes > sizeof(buf))
-                        toread = sizeof(buf);
+                if (bytes > BUFSIZE)
+                        toread = BUFSIZE;
                 else
                         toread = bytes;
 
@@ -1270,6 +1279,7 @@ struct file * presto_copy_kml_tail(struc
 
                 if (presto_fwrite(f, buf, len, &write_off) != len) {
                         filp_close(f, NULL);
+                        kfree(buf);
                         EXIT;
                         return ERR_PTR(-EIO);
                 }
@@ -1277,6 +1287,7 @@ struct file * presto_copy_kml_tail(struc
                 bytes -= len;
         }
 
+        kfree(buf);
         EXIT;
         return f;
 }
@@ -1580,12 +1591,14 @@ int presto_journal_setattr(struct rec_in
         return error;
 }
 
+#define RECORD_LENGTH 4096
+
 int presto_get_fileid(int minor, struct presto_file_set *fset,
                       struct dentry *dentry)
 {
         int opcode = KML_OPCODE_GET_FILEID;
         struct rec_info rec;
-        char *buffer, *path, *logrecord, record[4096]; /*include path*/
+        char *buffer, *path, *logrecord, *record; /*include path*/
         struct dentry *root;
         __u32 uid, gid, pathlen;
         int error, size;
@@ -1593,6 +1606,11 @@ int presto_get_fileid(int minor, struct 
 
         ENTRY;
 
+        record = kmalloc(RECORD_LENGTH, GFP_KERNEL);
+        if (!record)
+                return -ENOMEM;
+        memset(record, 0, RECORD_LENGTH);
+
         root = fset->fset_dentry;
 
         uid = cpu_to_le32(dentry->d_inode->i_uid);
@@ -1606,7 +1624,7 @@ int presto_get_fileid(int minor, struct 
                 sizeof(struct kml_suffix);
 
         CDEBUG(D_FILE, "kml size: %d\n", size);
-        if ( size > sizeof(record) )
+        if ( size > RECORD_LENGTH )
                 CERROR("InterMezzo: BUFFER OVERFLOW in %s!\n", __FUNCTION__);
 
         memset(&rec, 0, sizeof(rec));
@@ -1628,6 +1646,7 @@ int presto_get_fileid(int minor, struct 
                                    size_round(le32_to_cpu(pathlen)), path,
                                    fset->fset_name);
 
+        kfree(record);
         BUFF_FREE(buffer);
         EXIT;
         return error;
