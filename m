Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbUAHK2P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 05:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbUAHK2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 05:28:14 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:1469 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264261AbUAHK2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 05:28:01 -0500
Date: Thu, 8 Jan 2004 16:02:42 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: Inconsistency in sysfs behavior?
Message-ID: <20040108103242.GA2267@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <Pine.LNX.4.44L0.0401071039150.850-100000@ida.rowland.org> <20040107172750.GC31177@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107172750.GC31177@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 05:24:54PM +0000, Greg KH wrote:
> Note, Pat's email address has changed, I've changed in the CC:
> 
> On Wed, Jan 07, 2004 at 10:48:44AM -0500, Alan Stern wrote:
> > The following appears to be an inconsistency in the way sysfs behaves.  
> > Tell me what you think...
> > 
> > When a user process parks its CWD in a kobject's sysfs directory and then
> > the kobject is unregistered, of course the directory is forced to remain
> > in existence (albeit unlinked) because of the reference held by the
> > process.  But it does not in turn hold a reference to the kobject; the
> > kobject will be deleted immediately if nothing else refers to it.
> > 
> > On the other hand, if a user process opens a sysfs attribute file and then
> > sysfs_remove_file() is called, again the file is forced to remain in
> > existence (albeit unlinked) because of the reference held by the process.  
> > But now it _does_ hold a reference to the kobject; if the kobject is
> > unregistered it will not be deleted until the user process closes the
> > attribute file.
> > 
> > Why this non-parallel behavior?
> 
> Because it is very difficult to determine when a user goes into a
> directory because we are using the ramfs/libfs code.  It also does not
> cause any errors if the kobject is removed, as the vfs cleans up
> properly.
> 

I have faced similar situation while working on sysfs backing store for
leaf dentries.
                                                                                
http://marc.theaimsgroup.com/?l=linux-kernel&m=107269078726254&w=2
                                                                                
The problem is that we have live references to the kobject dentry but 
kobject is gone. Problems can occur if kobject is accessed
through dentry->d_fsdata field. The fix I did was to take a ref. to the
kobject while linking the dentry with the kobject in create_dir(). This
ref. can be released when dentry ref. count goes to zero, that is when
dentry is being freed, through dentry->d_op->d_iput() call. With this
patch we can have a kobject alive during the life time of the corresponding
dentry. 

Please comment.

For testing one has to run the following test on a SMP box:
1) Do insmod/rmmod "dummy.o" network driver in a forever loop.
2) Parallely do "find /sys/class/net | xargs cat" also in a forever loop.

Please build kernel with this sysfs patch from -mm1 tree before running 
this test:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1-rc2/2.6.1-rc2-mm1/broken-out/sysfs_remove_dir-vs-dcache_readdir-race-fix.patch

In -rc2 you get following while running the above two things after some time.

Badness in kobject_get at lib/kobject.c:439
Call Trace:
 [<c024060d>] kobject_get+0x4d/0x4f
 [<c0195937>] check_perm+0x20/0x17d
 [<c015d833>] get_empty_filp+0x75/0xf8
 [<c0195a94>] sysfs_open_file+0x0/0x5
 [<c015b9b5>] dentry_open+0x13b/0x1e1
 [<c015b878>] filp_open+0x67/0x69
 [<c015bde9>] sys_open+0x5b/0x8b
 [<c010af3d>] sysenter_past_esp+0x52/0x71

I think things can go worse, like in check_perm() 

static int check_perm(struct inode * inode, struct file * file)
{
       	struct kobject * kobj = kobject_get(file->f_dentry->d_parent->d_fsdata);
	....
d_fsdata could be pointing to a already freed kobject.

-------------------------------------------------------------------------------



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
