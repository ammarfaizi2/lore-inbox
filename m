Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265602AbUAIEw1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 23:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265652AbUAIEw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 23:52:27 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:2980 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265602AbUAIEwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 23:52:22 -0500
Date: Fri, 9 Jan 2004 10:26:52 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: Inconsistency in sysfs behavior?
Message-ID: <20040109045652.GA16301@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <Pine.LNX.4.44L0.0401071039150.850-100000@ida.rowland.org> <20040107172750.GC31177@kroah.com> <20040108103242.GA2267@in.ibm.com> <20040108201920.GB16183@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040108201920.GB16183@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 12:19:20PM -0800, Greg KH wrote:
> On Thu, Jan 08, 2004 at 04:02:42PM +0530, Maneesh Soni wrote:
> >                                                                                 
> > The problem is that we have live references to the kobject dentry but 
> > kobject is gone. Problems can occur if kobject is accessed
> > through dentry->d_fsdata field. The fix I did was to take a ref. to the
> > kobject while linking the dentry with the kobject in create_dir(). This
> > ref. can be released when dentry ref. count goes to zero, that is when
> > dentry is being freed, through dentry->d_op->d_iput() call. With this
> > patch we can have a kobject alive during the life time of the corresponding
> > dentry. 
> > 
> > Please comment.
> 
> This is the patch already in the -mm tree, right?  I think it's already
> in Pat's pending queue of patches to send off (we're a bit hampered by
> the weather right now in this part of the world...)
> 

No, it is not in the -mm tree. IIRC, I have not seen similar patch earlier. 

If patch looks good, I request Andrew to include. It applies to -rc2-mm1 also.
Re-attached for Andrew.


Thanks
Maneesh



o The following pins the kobject when sysfs assigns dentry and inode to
  the kobject. This ensures that kobject is alive during the life time of
  the dentry and inode, and people holding ref. to the dentry can access the
  kobject without any problems.

o The ref. taken for the kobject is released through dentry->d_op->d_iput()
  call when the dentry ref. count drops to zero and it is being freed. For
  this sysfs_dentry_operations is introduced.


 fs/sysfs/dir.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletion(-)

diff -puN fs/sysfs/dir.c~sysfs-pin-kobject fs/sysfs/dir.c
--- linux-2.6.1-rc2/fs/sysfs/dir.c~sysfs-pin-kobject	2004-01-08 11:54:37.000000000 +0530
+++ linux-2.6.1-rc2-maneesh/fs/sysfs/dir.c	2004-01-08 15:29:17.000000000 +0530
@@ -20,6 +20,18 @@ static int init_dir(struct inode * inode
 	return 0;
 }
 
+static void sysfs_d_iput(struct dentry * dentry, struct inode * inode)
+{
+	struct kobject * kobj = dentry->d_fsdata;
+
+	if (kobj)
+		kobject_put(kobj);
+	iput(inode);
+}
+
+static struct dentry_operations sysfs_dentry_operations = {
+	.d_iput	= &sysfs_d_iput,
+};
 
 static int create_dir(struct kobject * k, struct dentry * p,
 		      const char * n, struct dentry ** d)
@@ -33,7 +45,8 @@ static int create_dir(struct kobject * k
 					 S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO,
 					 init_dir);
 		if (!error) {
-			(*d)->d_fsdata = k;
+			(*d)->d_op = &sysfs_dentry_operations;
+			(*d)->d_fsdata = kobject_get(k);
 			p->d_inode->i_nlink++;
 		}
 		dput(*d);

_

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
