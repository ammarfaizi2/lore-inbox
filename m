Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263372AbTCNPnL>; Fri, 14 Mar 2003 10:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263368AbTCNPnL>; Fri, 14 Mar 2003 10:43:11 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:34452 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S263372AbTCNPnI>; Fri, 14 Mar 2003 10:43:08 -0500
Date: Fri, 14 Mar 2003 16:53:52 +0100
From: Joern Engel <joern@wohnheim.fh-wedel.de>
To: braam@clusterfs.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] fix stack usage in fs/intermezzo/journal.c
Message-ID: <20030314155352.GD27154@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This moves two 4k buffers from stack to heap. Compiles, untested, but
looks trivial.

Alan, is this something for your tree?

Jörn

-- 
When people work hard for you for a pat on the back, you've got
to give them that pat.
-- Robert Heinlein

--- linux-2.5.64/fs/intermezzo/journal.c	Mon Feb 24 20:05:05 2003
+++ linux-2.5.64-i2o/fs/intermezzo/journal.c	Thu Mar 13 13:14:12 2003
@@ -1245,6 +1245,7 @@
         struct file *f;
         int len;
         loff_t read_off, write_off, bytes;
+        char *buf;
 
         ENTRY;
 
@@ -1255,15 +1256,18 @@
                 return f;
         }
 
+        buf = kmalloc(4096, GFP_KERNEL);
+        if (!buf)
+                return ERR_PTR(-ENOMEM);
+
         write_off = 0;
         read_off = start;
         bytes = fset->fset_kml.fd_offset - start;
         while (bytes > 0) {
-                char buf[4096];
                 int toread;
 
-                if (bytes > sizeof(buf))
-                        toread = sizeof(buf);
+                if (bytes > sizeof(*buf))
+                        toread = sizeof(*buf);
                 else
                         toread = bytes;
 
@@ -1274,6 +1278,7 @@
 
                 if (presto_fwrite(f, buf, len, &write_off) != len) {
                         filp_close(f, NULL);
+                        kfree(buf);
                         EXIT;
                         return ERR_PTR(-EIO);
                 }
@@ -1281,6 +1286,7 @@
                 bytes -= len;
         }
 
+        kfree(buf);
         EXIT;
         return f;
 }
@@ -1589,7 +1595,7 @@
 {
         int opcode = KML_OPCODE_GET_FILEID;
         struct rec_info rec;
-        char *buffer, *path, *logrecord, record[4096]; /*include path*/
+        char *buffer, *path, *logrecord, *record; /*include path*/
         struct dentry *root;
         __u32 uid, gid, pathlen;
         int error, size;
@@ -1597,6 +1603,10 @@
 
         ENTRY;
 
+        record = kmalloc(4096, GFP_KERNEL);
+        if (!record)
+                return -ENOMEM;
+
         root = fset->fset_dentry;
 
         uid = cpu_to_le32(dentry->d_inode->i_uid);
@@ -1610,7 +1620,7 @@
                 sizeof(struct kml_suffix);
 
         CDEBUG(D_FILE, "kml size: %d\n", size);
-        if ( size > sizeof(record) )
+        if ( size > sizeof(*record) )
                 CERROR("InterMezzo: BUFFER OVERFLOW in %s!\n", __FUNCTION__);
 
         memset(&rec, 0, sizeof(rec));
@@ -1633,6 +1643,7 @@
                                    fset->fset_name);
 
         BUFF_FREE(buffer);
+        kfree(record);
         EXIT;
         return error;
 }
