Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263375AbTCNQeM>; Fri, 14 Mar 2003 11:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263384AbTCNQeM>; Fri, 14 Mar 2003 11:34:12 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:56217 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S263375AbTCNQeF>; Fri, 14 Mar 2003 11:34:05 -0500
Date: Fri, 14 Mar 2003 17:44:45 +0100
From: Joern Engel <joern@wohnheim.fh-wedel.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: braam@clusterfs.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix stack usage in fs/intermezzo/journal.c
Message-ID: <20030314164445.GC23161@wohnheim.fh-wedel.de>
References: <20030314155352.GD27154@wohnheim.fh-wedel.de> <20030314080930.5ff3cc80.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030314080930.5ff3cc80.rddunlap@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 March 2003 08:09:30 -0800, Randy.Dunlap wrote:
> 
> I guess one of us needs some guidance here.
> I thought that sizeof(*buf) == 1 here, not 4096.  Anybody?
> I don't see how sizeof() can determine the kmalloc-ed size,
> so I would use BUF_SIZE instead, with
> #define BUF_SIZE	4096

I'd love to say you're wrong, but you're not. New patch is below.
FUNCTION_NAME_BUFSIZE should have less name collision than BUF_SIZE,
but someone who knows intermezzo better than me might find a much
nicer name.

Jörn

-- 
Jörn Engel
mailto: joern@wohnheim.fh-wedel.de
http://wohnheim.fh-wedel.de/~joern
Phone: +49 179 6704074

--- linux-2.5.64/fs/intermezzo/journal.c	Mon Feb 24 20:05:05 2003
+++ linux-2.5.64-i2o/fs/intermezzo/journal.c	Fri Mar 14 17:37:18 2003
@@ -1239,12 +1239,15 @@
         return izo_rcvd_write(fset, &rec);
 }
 
+/* FIXME: should the below go into some header file? */
+#define PRESTO_COPY_KML_TAIL_BUFSIZE 4096
 struct file * presto_copy_kml_tail(struct presto_file_set *fset,
                                    unsigned long int start)
 {
         struct file *f;
         int len;
         loff_t read_off, write_off, bytes;
+        char *buf;
 
         ENTRY;
 
@@ -1255,15 +1258,18 @@
                 return f;
         }
 
+        buf = kmalloc(PRESTO_COPY_KML_TAIL_BUFSIZE, GFP_KERNEL);
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
+                if (bytes > PRESTO_COPY_KML_TAIL_BUFSIZE)
+                        toread = PRESTO_COPY_KML_TAIL_BUFSIZE;
                 else
                         toread = bytes;
 
@@ -1274,6 +1280,7 @@
 
                 if (presto_fwrite(f, buf, len, &write_off) != len) {
                         filp_close(f, NULL);
+                        kfree(buf);
                         EXIT;
                         return ERR_PTR(-EIO);
                 }
@@ -1281,6 +1288,7 @@
                 bytes -= len;
         }
 
+        kfree(buf);
         EXIT;
         return f;
 }
@@ -1584,12 +1592,14 @@
         return error;
 }
 
+/* FIXME: should the below go into some header file? */
+#define PRESTO_GET_FILEID_BUFSIZE 4096
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
@@ -1597,6 +1607,10 @@
 
         ENTRY;
 
+        record = kmalloc(PRESTO_GET_FILEID_BUFSIZE, GFP_KERNEL);
+        if (!record)
+                return -ENOMEM;
+
         root = fset->fset_dentry;
 
         uid = cpu_to_le32(dentry->d_inode->i_uid);
@@ -1610,7 +1624,7 @@
                 sizeof(struct kml_suffix);
 
         CDEBUG(D_FILE, "kml size: %d\n", size);
-        if ( size > sizeof(record) )
+        if ( size > PRESTO_GET_FILEID_BUFSIZE )
                 CERROR("InterMezzo: BUFFER OVERFLOW in %s!\n", __FUNCTION__);
 
         memset(&rec, 0, sizeof(rec));
@@ -1633,6 +1647,7 @@
                                    fset->fset_name);
 
         BUFF_FREE(buffer);
+        kfree(record);
         EXIT;
         return error;
 }
