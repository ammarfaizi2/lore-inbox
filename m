Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbVKWOBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbVKWOBX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 09:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVKWOBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 09:01:23 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:59347 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750805AbVKWOBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 09:01:22 -0500
Date: Wed, 23 Nov 2005 19:28:47 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: What protection does sysfs_readdir have with SMP/Preemption?
Message-ID: <20051123135847.GF22714@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <1132695202.13395.15.camel@localhost.localdomain> <20051122213947.GB8575@kroah.com> <20051123045049.GA22714@in.ibm.com> <Pine.LNX.4.58.0511230748000.23751@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0511230748000.23751@gandalf.stny.rr.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 07:56:39AM -0500, Steven Rostedt wrote:
[..]
> 
> The bug that I've been fighting in my own kernel is a memory leak. So I
> started looking into this at what would happen in verious places if an
> allocation didn't work.
> 
> In create_dir:
> 
> 		error = sysfs_make_dirent(p->d_fsdata, *d, k, mode, SYSFS_DIR);
> // Above is where the entry is added to the parent link list.
> 
> 		if (!error) {
> 			error = sysfs_create(*d, mode, init_dir);
> // If sysfs_create fails to allocate an inode, when below
> // does the element get removed from the parent?
> 			if (!error) {
> 				p->d_inode->i_nlink++;
> 				(*d)->d_op = &sysfs_dentry_ops;
> 				d_rehash(*d);
> 			}
> 		}
> 		if (error && (error != -EEXIST)) {
> 			sysfs_put((*d)->d_fsdata);
> // sysfs_put only seems to handle the kobject portion
> 
> 			d_drop(*d);
> // d_drop handles the unhash
> 		}
> 		dput(*d);
> 
> So I'm not sure an error from sysfs_create will remove the object from the
> link list.  In fact, it might be worst since now there's an object on the
> link list that may no long even be an object.
> 
> I'll test this by forcing a failure at sysfs_create.
> 

hmm looks like we got some situation which is not desirable and could lead
to bogus sysfs_dirent in the parent list. It may not be the exact problem
in this case though, but needs fixing IMO.

After sysfs_make_dirent(), the ref count for sysfs dirent will be 2.
(one from allocation, and after linking the new dentry to it). On
error from sysfs_create(), we do sysfs_put() once, decrementing the
ref count to 1. And again when the new dentry for which we couldn't
allocate the d_inode, is d_drop()'ed. In sysfs_d_iput() we again
sysfs_put(), and decrement the sysfs dirent's ref count to 0, which will
be the final sysfs_put(), and it will free the sysfs_dirent but never
unlinks it from the parent list. So, parent list could still will having
links to the freed sysfs_dirent in its s_children list.

so basically list_del_init(&sd->s_sibling) should be done in error path
in create_dir().

Could you also put the appended patch in your trial runs..


Thanks
Maneesh





o Following patch corrects the buggy create_dir() error path. This bug could
  end up in having a bogus sysfs_dirent in the parent list. Now the newly 
  allocated and linked sysfs_dirent is also un-linked in case of error 
  resulting from sysfs_create()

o Many thanks to Steven Rostedt and Ingo Molnar for pointing this out.

Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
---

 linux-2.6.15-rc2-mm1-maneesh/fs/sysfs/dir.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -puN fs/sysfs/dir.c~fix-create_dir-error-path fs/sysfs/dir.c
--- linux-2.6.15-rc2-mm1/fs/sysfs/dir.c~fix-create_dir-error-path	2005-11-23 18:59:36.072449992 +0530
+++ linux-2.6.15-rc2-mm1-maneesh/fs/sysfs/dir.c	2005-11-23 19:07:53.475833184 +0530
@@ -112,7 +112,9 @@ static int create_dir(struct kobject * k
 			}
 		}
 		if (error && (error != -EEXIST)) {
-			sysfs_put((*d)->d_fsdata);
+			struct sysfs_dirent *sd = (*d)->d_fsdata;
+			list_del_init(&sd->s_sibling);
+			sysfs_put(sd);
 			d_drop(*d);
 		}
 		dput(*d);
_


-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
