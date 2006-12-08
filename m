Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424174AbWLHDgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424174AbWLHDgb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 22:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424194AbWLHDga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 22:36:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:53493 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1424174AbWLHDg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 22:36:29 -0500
From: Neil Brown <neilb@suse.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Date: Fri, 8 Dec 2006 14:36:27 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17784.56763.794504.185193@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>,
       nfs@lists.sourceforge.net
Subject: Re: Let's get rid of those annoying "VFS is out of sync with lock manager" messages (includes proposed patch)
In-Reply-To: message from Jesper Juhl on Thursday December 7
References: <200612072208.16350.jesper.juhl@gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday December 7, jesper.juhl@gmail.com wrote:
> 
> So I took Neils patch, made the change Trond suggested and the result is 
> below.
> 
> Comments?  Ok to merge?  

Yes, except that you need a changelog comment at the top.  Possibly
based very heavily on the text I wrote, but written to justify the
patch rather than to explain the bug.

NeilBrown

> 
> 
> Signed-off-by: Neil Brown <neilb@suse.de>
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
> 
>  fs/nfs/file.c |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> index cc93865..22572af 100644
> --- a/fs/nfs/file.c
> +++ b/fs/nfs/file.c
> @@ -428,8 +428,8 @@ static int do_vfs_lock(struct file *file
>  			BUG();
>  	}
>  	if (res < 0)
> -		printk(KERN_WARNING "%s: VFS is out of sync with lock manager!\n",
> -				__FUNCTION__);
> +		dprintk("%s: VFS is out of sync with lock manager (res = %d)!\n",
> +				__FUNCTION__, res);
>  	return res;
>  }
>  
> @@ -479,10 +479,13 @@ static int do_setlk(struct file *filp, i
>  		 * we clean up any state on the server. We therefore
>  		 * record the lock call as having succeeded in order to
>  		 * ensure that locks_remove_posix() cleans it out when
> -		 * the process exits.
> +		 * the process exits. Make sure not to sleep if
> +		 * someone else holds the lock.
>  		 */
> -		if (status == -EINTR || status == -ERESTARTSYS)
> +		if (status == -EINTR || status == -ERESTARTSYS) {
> +			fl->fl_flags &= ~FL_SLEEP;
>  			do_vfs_lock(filp, fl);
> +		}
>  	} else
>  		status = do_vfs_lock(filp, fl);
>  	unlock_kernel();
> 
