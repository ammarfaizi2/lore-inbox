Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030593AbVKXESn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030593AbVKXESn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 23:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030595AbVKXESn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 23:18:43 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:4052 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030593AbVKXESm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 23:18:42 -0500
Date: Thu, 24 Nov 2005 09:46:08 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: What protection does sysfs_readdir have with SMP/Preemption?
Message-ID: <20051124041608.GA16502@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <1132695202.13395.15.camel@localhost.localdomain> <20051122213947.GB8575@kroah.com> <20051123045049.GA22714@in.ibm.com> <Pine.LNX.4.58.0511230748000.23751@gandalf.stny.rr.com> <20051123135847.GF22714@in.ibm.com> <1132755344.13395.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132755344.13395.32.camel@localhost.localdomain>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 09:15:44AM -0500, Steven Rostedt wrote:
> On Wed, 2005-11-23 at 19:28 +0530, Maneesh Soni wrote:
> 
> > 
> > hmm looks like we got some situation which is not desirable and could lead
> > to bogus sysfs_dirent in the parent list. It may not be the exact problem
> > in this case though, but needs fixing IMO.
> > 
> > After sysfs_make_dirent(), the ref count for sysfs dirent will be 2.
> > (one from allocation, and after linking the new dentry to it). On
> > error from sysfs_create(), we do sysfs_put() once, decrementing the
> > ref count to 1. And again when the new dentry for which we couldn't
> > allocate the d_inode, is d_drop()'ed. In sysfs_d_iput() we again
> > sysfs_put(), and decrement the sysfs dirent's ref count to 0, which will
> > be the final sysfs_put(), and it will free the sysfs_dirent but never
> > unlinks it from the parent list. So, parent list could still will having
> > links to the freed sysfs_dirent in its s_children list.
> > 
> > so basically list_del_init(&sd->s_sibling) should be done in error path
> > in create_dir().
> > 
> > Could you also put the appended patch in your trial runs..
> > 
> 
> I'm already playing around with this. You might want this patch instead.
> I noticed that if sysfs_make_dirent fails to allocate the sd, then a
> null will be passed to sysfs_put.
> 
> But this is not the end of the problems.  I'll follow up on that comment
> right after this.
> 
> -- Steve
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> 
> Index: linux-2.6.15-rc2-git2/fs/sysfs/dir.c
> ===================================================================
> --- linux-2.6.15-rc2-git2.orig/fs/sysfs/dir.c	2005-11-23 08:40:33.000000000 -0500
> +++ linux-2.6.15-rc2-git2/fs/sysfs/dir.c	2005-11-23 08:52:57.000000000 -0500
> @@ -112,7 +112,11 @@
>  			}
>  		}
>  		if (error && (error != -EEXIST)) {
> -			sysfs_put((*d)->d_fsdata);
> +			struct sysfs_dirent *sd = (*d)->d_fsdata;
> +			if (sd) {
> + 				list_del_init(&sd->s_sibling);
> +				sysfs_put(sd);
> +			}
>  			d_drop(*d);
>  		}
>  		dput(*d);
> 
> 

Agreed. This makes more sense.


Thanks
Maneesh


-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
