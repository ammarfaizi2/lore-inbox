Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265106AbUHNUCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265106AbUHNUCb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 16:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265134AbUHNUCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 16:02:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56500 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265106AbUHNUAt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 16:00:49 -0400
Date: Sat, 14 Aug 2004 21:00:48 +0100
From: Matthew Wilcox <willy@debian.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: PATCH [2/7] Fix posix locking code
Message-ID: <20040814200048.GV12936@parcelfarce.linux.theplanet.co.uk>
References: <1092511792.4109.22.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092511792.4109.22.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2004 at 03:29:53PM -0400, Trond Myklebust wrote:
>  	if (!list_empty(&fl->fl_link))
>  		panic("Attempting to free lock on active lock list");
>  
> +	if (fl->fl_ops && fl->fl_ops->fl_release_private) {
> +		fl->fl_ops->fl_release_private(fl);
> +		fl->fl_ops = NULL;
> +	}
> +	fl->fl_lmops = NULL;

So if fl_ops is set, but fl_ops->fl_release_private isn't, we won't set
fl_ops to NULL -- we should probably just do:

	if (fl->fl_ops && fl->fl_ops->fl_release_private)
		fl->fl_ops->fl_release_private(fl);
	fl->fl_ops = NULL;
	fl->fl_lmops = NULL;

> @@ -981,6 +997,8 @@ int locks_mandatory_area(int read_write,
>  		break;
>  	}
>  
> +	if (fl.fl_ops && fl.fl_ops->fl_release_private)
> +		fl.fl_ops->fl_release_private(&fl);
>  	return error;
>  }
>  

I don't see how fl.fl_ops can be non-null here.  We initialise it to
NULL in locks_init_lock() and then don't give the underlying filesystem
an opportunity to set it.

> @@ -626,6 +626,15 @@ extern void close_private_file(struct fi
>   */
>  typedef struct files_struct *fl_owner_t;
>  
> +struct file_lock_operations {
> +	void (*fl_copy_lock)(struct file_lock *, struct file_lock *);
> +	void (*fl_release_private)(struct file_lock *);
> +};
> +
> +struct lock_manager_operations {
> +	int (*fl_compare_owner)(struct file_lock *, struct file_lock *);
> +};
> +
>  /* that will die - we need it for nfs_lock_info */
>  #include <linux/nfs_fs_i.h>
>  
> @@ -649,6 +658,8 @@ struct file_lock {
>  	struct fasync_struct *	fl_fasync; /* for lease break notifications */
>  	unsigned long fl_break_time;	/* for nonblocking lease breaks */
>  
> +	struct file_lock_operations *fl_ops;	/* Callbacks for filesystems */
> +	struct lock_manager_operations *fl_lmops;	/* Callbacks for lockmanagers */
>  	union {
>  		struct nfs_lock_info	nfs_fl;
>  	} fl_u;

I know I said I thought file_lock_operations was the right thing to
do ...  but now I think that this isn't a property of the file_lock so
much as it is a property of the underlying filesystem.  I think putting a
lock_operations into struct file is maybe a bit much.  How about adding
a lock_operations pointer to file_operations?  It'd be a little clunky
to get to -- fl->fl_file->f_op->lock_ops, so I'd be interested in other
suggestions.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
