Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132805AbRDSWKH>; Thu, 19 Apr 2001 18:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132806AbRDSWJ6>; Thu, 19 Apr 2001 18:09:58 -0400
Received: from ns.suse.de ([213.95.15.193]:15367 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132805AbRDSWJs>;
	Thu, 19 Apr 2001 18:09:48 -0400
Date: Fri, 20 Apr 2001 00:09:46 +0200
From: Andi Kleen <ak@suse.de>
To: Matthew Jacob <mjacob@feral.com>
Cc: "Brian J. Watson" <Brian.J.Watson@compaq.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: active after unmount?
Message-ID: <20010420000946.A4982@gruyere.muc.suse.de>
In-Reply-To: <3ADF5DCB.EEADD4E0@compaq.com> <Pine.BSF.4.21.0104191454390.81926-100000@beppo.feral.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.BSF.4.21.0104191454390.81926-100000@beppo.feral.com>; from mjacob@feral.com on Thu, Apr 19, 2001 at 02:56:15PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 02:56:15PM -0700, Matthew Jacob wrote:
> 
> 
> On Thu, 19 Apr 2001, Brian J. Watson wrote:
> 
> > > Unmounting a SCSI disk device succeeded, and yielded:
> > > 
> > > Red Hat Linux release 6.2 (Zoot)
> > > Kernel 2.4.3 on a 2-processor i686
> > > 
> > > chico login: VFS: Busy inodes after unmount. Self-destruct in 5 seconds. Have
> > > a nice day...
> > > 
> > 
> > 
> > This message comes out of kill_super(). I would guess that somebody's
> > mismanaging VFS refcounts, but there's not enough info here to diagnose the
> > problem. What filesystem are you using? Is this reproducible? What do you have
> > to do between mounting and unmounting to reproduce the problem?
> 
> >>>>>>ext2<<<<<<, haven't reproduced it yet, on a 2x686 256MB memory,
> SCSI midlayer default, with 2.4.3.

I've seen it a lot with the autofs. You can check what it is with the
following small debug patch.

Index: fs/inode.c
===================================================================
RCS file: /cvs/linux/fs/inode.c,v
retrieving revision 1.122
diff -u -u -r1.122 inode.c
--- fs/inode.c	2001/03/24 09:36:25	1.122
+++ fs/inode.c	2001/04/19 22:07:17
@@ -443,6 +443,13 @@
 			count++;
 			continue;
 		}
+#if 1
+		printk("inode %u:%lu busy\n", inode->i_dev, inode->i_ino); 
+		if (inode->i_dentry.next != &inode->i_dentry) 
+			printk("for file %s\n", 
+	list_entry(inode->i_dentry.next, struct dentry, d_alias)->d_name.name);  
+#endif		
+		
 		busy = 1;
 	}
 	/* only unused inodes may be cached with i_count zero */


-Andi
