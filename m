Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263671AbTDNT2p (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 15:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263676AbTDNT2o (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 15:28:44 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:33704 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263671AbTDNT2e (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 15:28:34 -0400
Date: Mon, 14 Apr 2003 21:40:24 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Dave Jones <davej@codemonkey.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       InterMezzo Development List 
	<intermezzo-devel@lists.sourceforge.net>
Subject: Re: top stack (l)users for 2.5.67
Message-ID: <20030414194024.GE12740@wohnheim.fh-wedel.de>
References: <20030414173047.GJ10347@wohnheim.fh-wedel.de> <1050338275.25353.93.camel@dhcp22.swansea.linux.org.uk> <20030414174645.GK10347@wohnheim.fh-wedel.de> <20030414182544.GA6866@suse.de> <20030414190514.GB12740@wohnheim.fh-wedel.de> <20030414131852.I26054@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030414131852.I26054@schatzie.adilger.int>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 April 2003 13:18:52 -0600, Andreas Dilger wrote:
> 
> I've CC'd the InterMezzo mailing list (which is where the maintainers of
> this code live).  Could someone please post a copy of the original patch
> to the intermezzo-devel@lists.sourceforge.net mailing list?

Attached. (Yes, this is a duplicate for lkml, but it's not that big)

> Actually, my recollection is that there was previously a patch posted
> for fixing this large stack usage the last time this came up.

Yup, I already tried this once before and got some feedback. Just none
from braam@clusterfs.com, who is the contact according to MAINTAINERS.
Should I update that file to intermezzo-devel@lists.sourceforge.net?

Jörn

-- 
With a PC, I always felt limited by the software available. On Unix, 
I am limited only by my knowledge.
-- Peter J. Schoenster

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
