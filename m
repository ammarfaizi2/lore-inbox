Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbTLALiO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 06:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbTLALiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 06:38:14 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:18102 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263510AbTLALiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 06:38:11 -0500
Date: Mon, 1 Dec 2003 17:07:04 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: James W McMechan <mcmechanjw@juno.com>
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Oops with tmpfs on both 2.4.22 & 2.6.0-test11
Message-ID: <20031201113703.GB6918@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20031130.185915.-1591395.7.mcmechanjw@juno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031130.185915.-1591395.7.mcmechanjw@juno.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 01, 2003 at 05:50:13AM +0000, James W McMechan wrote:
> Hello, I have a test program  which will generate the Oops easily.
> No maintainer was listed for tmpfs and the best Google reference is
> about 2 years back, and it does not seem to be about this issue.
> 
> This Oops both 2.4.22 and 2.6.0-test11
> It results from a ARCH=um bugreport and I kept making the
> test program shorter, now down to one executable line.
> 
> It oops with the list poison address on 2.6.0-test11
> Neither myself nor William Lee Irwin III know what the
> list_del(q);
> list_add(q, &dentry->d_subdirs);
> from fs/libfs.c:90 or 137 is intended to do but he suggested you might
> know
> I think that is where it is corrupting the list entries.
> 
> /* by James_McMechan at hotmail com */                                   
>       
> /* test2 program to Oops shmfs mounted at /dev/shm */
> /* yes it is dumb but unprivileged users should not be able */
> /* to Oops the kernel regardless of how dumb the program */
> #include <sys/types.h>
> #include <dirent.h>
> main()
> {/* off 0 is "." off 1 is ".." off 2 is empty */
>         seekdir(opendir("/dev/shm"), (off_t) 2);
> }
> 
> On Sun, 30 Nov 2003 20:51:01 -0800 William Lee Irwin III
> <wli@holomorphy.com> writes:
> > On Sun, Nov 30, 2003 at 06:06:41PM -0800, James W McMechan wrote:
> > > Have you got a suggestion on who to bug, I have not found
> > > maintainers on tmpfs or now the libfs section.
> > 
> > Hugh Dickins is highly clueful and generally maintains tmpfs. He's
> > fixed bugs in fs/libfs.c before, too.
> > 
> > 
> > -- wli

Hi,

I hope nobody minds me jumping in this thread. I have been looking at this
code for some time and hope I have got the facts correct.

The two list_xxx macros as mentioned (fs/libfs.c:line 137) adjusts the 
cursor dentry to the beginning of the d_subdirs list needed for 
(file->f_pos == 2) as there can be additions in the d_subdirs list after the 
open call and before ->lseek or ->readdir call.

The cursor adjustment in dcache_dir_lseek() (fs/libfs.c: line 90) always
puts the cursor just before the last looked dentry in the while loop. 

But it is problematic when we have an empty directory and (file->f_pos == 2)
In this case we have the loop counter p pointing to the cursor and doing
list_del and list_add_tail of the same list node results in oops.

The following patch takes (file->f_post == 2) as a special case and adjusts 
the cursor dentry by putting it right at the beginning of the d_subdirs
list.


Thanks
Maneesh

 fs/libfs.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff -puN fs/libfs.c~dcache_dir_lseek-fix fs/libfs.c
--- linux-2.6.0-test11/fs/libfs.c~dcache_dir_lseek-fix	2003-12-01 15:48:22.000000000 +0530
+++ linux-2.6.0-test11-maneesh/fs/libfs.c	2003-12-01 16:28:27.000000000 +0530
@@ -75,12 +75,13 @@ loff_t dcache_dir_lseek(struct file *fil
 		file->f_pos = offset;
 		if (file->f_pos >= 2) {
 			struct list_head *p;
+			struct dentry * dentry = file->f_dentry;
 			struct dentry *cursor = file->private_data;
 			loff_t n = file->f_pos - 2;
 
 			spin_lock(&dcache_lock);
-			p = file->f_dentry->d_subdirs.next;
-			while (n && p != &file->f_dentry->d_subdirs) {
+			p = dentry->d_subdirs.next;
+			while (n && p != &dentry->d_subdirs) {
 				struct dentry *next;
 				next = list_entry(p, struct dentry, d_child);
 				if (!d_unhashed(next) && next->d_inode)
@@ -88,7 +89,10 @@ loff_t dcache_dir_lseek(struct file *fil
 				p = p->next;
 			}
 			list_del(&cursor->d_child);
-			list_add_tail(&cursor->d_child, p);
+			if (file->f_pos == 2)
+				list_add(&cursor->d_child, &dentry->d_subdirs);
+			else
+				list_add_tail(&cursor->d_child, p);
 			spin_unlock(&dcache_lock);
 		}
 	}

_




-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
