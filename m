Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293717AbSCKNAH>; Mon, 11 Mar 2002 08:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293718AbSCKM76>; Mon, 11 Mar 2002 07:59:58 -0500
Received: from angband.namesys.com ([212.16.7.85]:26240 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S293717AbSCKM7n>; Mon, 11 Mar 2002 07:59:43 -0500
Date: Mon, 11 Mar 2002 15:59:37 +0300
From: Oleg Drokin <green@namesys.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Message-ID: <20020311155937.A1474@namesys.com>
In-Reply-To: <shswuwkujx5.fsf@charged.uio.no> <200203110018.BAA11921@webserver.ithnet.com> <15499.64058.442959.241470@charged.uio.no> <20020311091458.A24600@namesys.com> <20020311114654.2901890f.skraw@ithnet.com> <20020311135256.A856@namesys.com> <20020311141154.C856@namesys.com> <20020311134717.65fafb85.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
In-Reply-To: <20020311134717.65fafb85.skraw@ithnet.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

On Mon, Mar 11, 2002 at 01:47:17PM +0100, Stephan von Krawczynski wrote:
> What else can I try?
> I checked the setup with another client kernel 2.4.18, and guess what: it has
> the same problem. I have the impression that the problem is somewhere on the
> nfs server side - possibly around the umount case. Trond, Ken?
Just to be sure - have you tried 2.4.17 at the server?
2.4.18 have 2 patches included that were supposed to have another 
stale filehandle problem resolved.
Our test have not shown any problems, but I am interested can you still
reproduce with these 2 patches reversed off the 2.4.18?
Also if you still can trigger, apply back only 1st hunk of G-... patch.

Bye,
    Oleg

--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="A-bigendian-lookup-fix.diff"

--- linux.orig/fs/reiserfs/inode.c Mon, 11 Feb 2002 12:21:42 -0500
+++ linux/fs/reiserfs/inode.c Mon, 18 Feb 2002 19:43:55 -0500
@@ -1207,7 +1211,8 @@
     struct reiserfs_iget4_args *args;
 
     args = opaque;
-    return INODE_PKEY( inode ) -> k_dir_id == args -> objectid;
+    /* args is already in CPU order */
+    return le32_to_cpu(INODE_PKEY(inode)->k_dir_id) == args -> objectid;
 }
 
 struct inode * reiserfs_iget (struct super_block * s, const struct cpu_key * key)


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="G-nfs_stale_inode_access.diff"

--- linux/fs/reiserfs/inode.c.o	Fri Feb  1 14:08:22 2002
+++ linux/fs/reiserfs/inode.c	Fri Feb  1 14:09:40 2002
@@ -1156,6 +1156,7 @@
 	/* a stale NFS handle can trigger this without it being an error */
 	pathrelse (&path_to_sd);
 	make_bad_inode(inode) ;
+	inode->i_nlink = 0;
 	return;
     }
 
@@ -1188,6 +1189,27 @@
 
 }
 
+/**
+ * reiserfs_find_actor() - "find actor" reiserfs supplies to iget4().
+ *
+ * @inode:    inode from hash table to check
+ * @inode_no: inode number we are looking for
+ * @opaque:   "cookie" passed to iget4(). This is &reiserfs_iget4_args.
+ *
+ * This function is called by iget4() to distinguish reiserfs inodes
+ * having the same inode numbers. Such inodes can only exist due to some
+ * error condition. One of them should be bad. Inodes with identical
+ * inode numbers (objectids) are distinguished by parent directory ids.
+ *
+ */
+static int reiserfs_find_actor( struct inode *inode, 
+				unsigned long inode_no, void *opaque )
+{
+    struct reiserfs_iget4_args *args;
+
+    args = opaque;
+    return INODE_PKEY( inode ) -> k_dir_id == args -> objectid;
+}
 
 struct inode * reiserfs_iget (struct super_block * s, const struct cpu_key * key)
 {
@@ -1195,7 +1217,8 @@
     struct reiserfs_iget4_args args ;
 
     args.objectid = key->on_disk_key.k_dir_id ;
-    inode = iget4 (s, key->on_disk_key.k_objectid, 0, (void *)(&args));
+    inode = iget4 (s, key->on_disk_key.k_objectid, 
+		   reiserfs_find_actor, (void *)(&args));
     if (!inode) 
 	return ERR_PTR(-ENOMEM) ;
 

--RASg3xLB4tUQ4RcS--
