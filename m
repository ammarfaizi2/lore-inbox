Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130369AbQLRL5s>; Mon, 18 Dec 2000 06:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130367AbQLRL52>; Mon, 18 Dec 2000 06:57:28 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:65295 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129387AbQLRL50>; Mon, 18 Dec 2000 06:57:26 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: trond.myklebust@fys.uio.no
Date: Mon, 18 Dec 2000 22:26:29 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14909.62565.397454.950907@notabene.cse.unsw.edu.au>
Cc: "M.H.VanLeeuwen" <vanl@megsinet.net>, neilb@cse.unsw.edu.au,
        linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at /usr/src/linux/include/linux/nfs_fs.h:167! - reproducible
In-Reply-To: message from Trond Myklebust on Monday December 18
In-Reply-To: <3A3BE424.4A7FB8D9@megsinet.net>
	<14909.57536.917716.473278@charged.uio.no>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday December 18, trond.myklebust@fys.uio.no wrote:
> >>>>> " " == M H VanLeeuwen <vanl@megsinet.net> writes:
> 
>      > Trond, Neil I don't know if this is a loopback bug or an NFS
>      > bug but since nfs_fs.h was implicated so I thought one of you
>      > may be interested.
>  
>      > Could you let me know if you know this problem has already been
>      > fixed or if you need more info.
> 
> Hi,
>  
> As far as I'm concerned, it's a loopback bug.

I read it the same way.
Actually, I cannot see the point of copying the "struct file"!  Why
not just take a reference to it?  The comment tries to justify it, but
I don't buy it.

Would you mind trying the following patch (totally untested, but
obviously correct :-)

NeilBrown

--- drivers/block/loop.c	2000/12/18 10:25:22	1.1
+++ drivers/block/loop.c	2000/12/18 11:23:52
@@ -441,37 +441,18 @@
 		if (!aops->prepare_write || !aops->commit_write)
 			lo->lo_flags |= LO_FLAGS_READ_ONLY;
 
-		error = get_write_access(inode);
-		if (error)
-			goto out_putf;
 
 		/* Backed by a regular file - we need to hold onto a file
-		   structure for this file.  Friggin' NFS can't live without
-		   it on write and for reading we use do_generic_file_read(),
-		   so...  We create a new file structure based on the one
-		   passed to us via 'arg'.  This is to avoid changing the file
-		   structure that the caller is using */
+		   structure for this file.  There is no reliable way to
+		   copy it (due to a filesys private field that may be ref-counted)
+		   so we just keep a reference to the file like a "dup" would.
+		*/
 
 		lo->lo_device = inode->i_dev;
 		lo->lo_flags = LO_FLAGS_DO_BMAP;
 
-		error = -ENFILE;
-		lo->lo_backing_file = get_empty_filp();
-		if (lo->lo_backing_file == NULL) {
-			put_write_access(inode);
-			goto out_putf;
-		}
-
-		lo->lo_backing_file->f_mode = file->f_mode;
-		lo->lo_backing_file->f_pos = file->f_pos;
-		lo->lo_backing_file->f_flags = file->f_flags;
-		lo->lo_backing_file->f_owner = file->f_owner;
-		lo->lo_backing_file->f_dentry = file->f_dentry;
-		lo->lo_backing_file->f_vfsmnt = mntget(file->f_vfsmnt);
-		lo->lo_backing_file->f_op = fops_get(file->f_op);
-		lo->lo_backing_file->private_data = file->private_data;
-		file_moveto(lo->lo_backing_file, file);
-
+		lo->lo_backing_file = file;
+		get_file(file);
 		error = 0;
 	}
 
@@ -539,8 +520,6 @@
 
 	if (lo->lo_backing_file != NULL) {
 		struct file *filp = lo->lo_backing_file;
-		if ((filp->f_mode & FMODE_WRITE) == 0)
-			put_write_access(filp->f_dentry->d_inode);
 		fput(filp);
 		lo->lo_backing_file = NULL;
 	} else {


> 
> Somebody appears to be trying to copy a 'struct file' in the routine
> 'loop_set_fd'. This will cause havoc in any and all filesystems that
> rely on f_ops->open() , f_ops->release() to maintain internal data.
> In this case, it's the file's RPC authorizations, that are getting
> garbage-collected from beneath you once the original struct file gets
> fput() at the end of the routine.
> 
> Cheers,
>   Trond
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
