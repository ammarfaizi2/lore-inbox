Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267577AbTB1HXa>; Fri, 28 Feb 2003 02:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267581AbTB1HXa>; Fri, 28 Feb 2003 02:23:30 -0500
Received: from packet.digeo.com ([12.110.80.53]:1428 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267577AbTB1HX3>;
	Fri, 28 Feb 2003 02:23:29 -0500
Date: Thu, 27 Feb 2003 23:34:34 -0800
From: Andrew Morton <akpm@digeo.com>
To: maneesh@in.ibm.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, zilvinas@gemtek.lt
Subject: Re: kernel Ooops (2.5.63 bk latest)
Message-Id: <20030227233434.7ed26b83.akpm@digeo.com>
In-Reply-To: <20030228070905.GA11135@in.ibm.com>
References: <20030226113718.GA3568@gemtek.lt>
	<20030228070905.GA11135@in.ibm.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Feb 2003 07:33:39.0660 (UTC) FILETIME=[B64F40C0:01C2DEFB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maneesh Soni <maneesh@in.ibm.com> wrote:
>
> Hi Linus,
> 
> The BUG was caught in d_validate() --> dget(). I think the 
> dentry to be validated can be already on LRU list with d_count 
> as zero. So, dget_locked should be used in place of dget(). 
> dcache_rcu mistakingly used dget. This patch corrects it.
> 
> Please apply the following patch.
> 
> diff -urN linux-2.5.63-bk3/fs/dcache.c linux-2.5.63-bk3-d_validate/fs/dcache.c
> --- linux-2.5.63-bk3/fs/dcache.c	2003-02-28 12:06:09.000000000 +0530
> +++ linux-2.5.63-bk3-d_validate/fs/dcache.c	2003-02-28 12:16:30.000000000 +0530
> @@ -1056,7 +1056,7 @@
>  		 * as it is parsed under dcache_lock
>  		 */
>  		if (dentry == list_entry(lhp, struct dentry, d_hash)) {
> -			dget(dentry);
> +			__dget_locked(dentry);
>  			spin_unlock(&dcache_lock);
>  			return 1;

Is this correct?  If smbfs is playing around with dentries which are on
dentry_unused and which have a zero refcount then these can be freed up at
any time.  The filesystem should have taken a ref on the dentry to prevent it
from being scavenged.

Isn't the bug over in smb_fill_cache(), which does:

	newdent = d_lookup(...);
	...
	ctl.cache->dentry[ctl.idx] = newdent;
	...
	dput(newdent);

I suspect we need to take an extra ref on the dentry when it is copied to the
cache, and put that ref back when smb_readdir() has finished using the dentry
(it looks like it's already doing that).

If so, the same problem is present in 2.4, but nobody noticed because 2.4 is
already using __dget_locked() and escapes the BUG check.

