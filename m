Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285358AbRLNMwF>; Fri, 14 Dec 2001 07:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285360AbRLNMvz>; Fri, 14 Dec 2001 07:51:55 -0500
Received: from mons.uio.no ([129.240.130.14]:26797 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S285358AbRLNMvn>;
	Fri, 14 Dec 2001 07:51:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15385.62936.632242.570507@charged.uio.no>
Date: Fri, 14 Dec 2001 13:51:36 +0100
To: dzafman@kahuna.cag.cpqcorp.net
Cc: linux-kernel@vger.kernel.org
Subject: NFS client llseek
In-Reply-To: <200112140057.fBE0vDm05648@kahuna.cag.cpqcorp.net>
In-Reply-To: <200112140057.fBE0vDm05648@kahuna.cag.cpqcorp.net>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == dzafman  <dzafman@kahuna.cag.cpqcorp.net> writes:

     > linux-2.4.16/fs/nfs/file.c
     > --- linux-2.4.16.orig/fs/nfs/file.c Sun Sep 23 09:48:01 2001
     > +++ linux-2.4.16/fs/nfs/file.c Thu Dec 13 15:35:05 2001
     > @@ -39,9 +39,10 @@
     >  static ssize_t nfs_file_write(struct file *, const char *,
     >  size_t, loff_t *); static int nfs_file_flush(struct file *);
     >  static int nfs_fsync(struct file *, struct dentry *dentry, int
     >  datasync);
     > +static loff_t nfs_file_llseek(struct file *, loff_t, int
     > origin);
 
     >  struct file_operations nfs_file_operations = {
     > - llseek: generic_file_llseek,
     > +	llseek:		nfs_file_llseek,
     >  	read: nfs_file_read, write: nfs_file_write, mmap:
     >  	nfs_file_mmap,
     > @@ -142,6 +143,24 @@
     >  	} unlock_kernel(); return status;
     > +} + +static loff_t +nfs_file_llseek(struct file *file, loff_t
     > offset, int origin) +{
     > + struct dentry * dentry = file->f_dentry;
     > + struct inode * inode = dentry->d_inode;
     > + loff_t result;
     > +
     > + /*
     > + * Make sure inode fields are up-to-date, since
     >  	   generic_file_llseek()
     > + * might look at anything in the inode.  Currently, i_size may
     >  	   be
     > + * used.
     > + */
     > + result = nfs_revalidate_inode(NFS_SERVER(inode), inode);
     > + if (!result)
     > + result = generic_file_llseek(file, offset, origin);
     > + return result;
     >  }
 
Just one comment: Isn't it easier to do this in generic_file_llseek()
itself using inode->i_op->revalidate()? That would make it work for
coda and smbfs too...

Cheers,
   Trond
