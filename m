Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932589AbWCOX0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbWCOX0k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 18:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbWCOX0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 18:26:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49088 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932589AbWCOX0j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 18:26:39 -0500
Date: Wed, 15 Mar 2006 15:28:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Yi Yang <yang.y.yi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.16-rc6-m1 PATCH] Connector: Filesystem Events Connector
Message-Id: <20060315152855.65f89bf1.akpm@osdl.org>
In-Reply-To: <4418375C.5090703@gmail.com>
References: <4418375C.5090703@gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yi Yang <yang.y.yi@gmail.com> wrote:
>
> This patch implements a new connector, Filesystem Event Connector,
>  the user can monitor filesystem activities via it, currently, it
>  can monitor access, attribute change, open, create, modify, delete,
>  move and close of any file or directory.
> 
> Every filesystem event will include tgid, uid and gid of the process
>  which triggered this event, process name, file or directory name 
> operated by it.

Why does Linux need this feature?

It seems quite duplicative of the fsnotify stuff.

>  	/* both times implies a utime(s) call */
>  	if ((ia_valid & (ATTR_ATIME | ATTR_MTIME)) == (ATTR_ATIME | ATTR_MTIME))
>  	{
>  		in_mask |= IN_ATTRIB;
>  		dn_mask |= DN_ATTRIB;
> +		fsevent_mask |= FSEVENT_MODIFY_ATTRIB;
>  	} else if (ia_valid & ATTR_ATIME) {
>  		in_mask |= IN_ACCESS;
>  		dn_mask |= DN_ACCESS;
> +		fsevent_mask |= FSEVENT_ACCESS;
>  	} else if (ia_valid & ATTR_MTIME) {
>  		in_mask |= IN_MODIFY;
>  		dn_mask |= DN_MODIFY;
> +		fsevent_mask |= FSEVENT_MODIFY;
>  	}
>  	if (ia_valid & ATTR_MODE) {
>  		in_mask |= IN_ATTRIB;
>  		dn_mask |= DN_ATTRIB;
> +		fsevent_mask |= FSEVENT_MODIFY_ATTRIB;
>  	}
>  
>  	if (dn_mask)
> @@ -238,6 +279,11 @@ static inline void fsnotify_change(struc
>  		inotify_dentry_parent_queue_event(dentry, in_mask, 0,
>  						  dentry->d_name.name);
>  	}
> +	if (fsevent_mask) {
> +		if (S_ISDIR(inode->i_mode))
> +			fsevent_mask |= FSEVENT_ISDIR;
> +		raise_fsevent(dentry, fsevent_mask);
> +	}
>  }

hmm, I wonder if the compiler is smart enough to recognise that
fsevent_mask isn't used and to eliminate all this new code when
CONFIG_FS_EVENTS=n

> +extern void raise_fsevent_move(struct inode * olddir, const char * oldname, struct inode * newdir, const char * newname, u32 mask);

Try to keep code looking nice in an 80-col display please.


> +int __raise_fsevent(const char * oldname, const char * newname, u32 mask)
> +{
> +	struct cn_msg *msg;
> +	struct fsevent *event;
> +	__u8 * buffer;
> +	int namelen = 0;
> +	static unsigned long last;
> +	static int fsevent_sum = 0;
> +
> +	if (atomic_read(&cn_fs_event_listeners) < 1)
> +		return 0;
> +
> +	spin_lock(&fsevent_ratelimit_lock);
> 

yipes.  We just went through considerable pain fixing performance problems
with inotify, and this patch brings them back, only much much worse.

See ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm1/broken-out/inotify-lock-avoidance-with-parent-watch-status-in-dentry.patch
