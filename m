Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965057AbVKVVlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965057AbVKVVlp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbVKVVlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:41:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:6534 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965057AbVKVVlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:41:44 -0500
Date: Tue, 22 Nov 2005 13:39:47 -0800
From: Greg KH <greg@kroah.com>
To: Steven Rostedt <rostedt@goodmis.org>, Maneesh Soni <maneesh@in.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: What protection does sysfs_readdir have with SMP/Preemption?
Message-ID: <20051122213947.GB8575@kroah.com>
References: <1132695202.13395.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132695202.13395.15.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 04:33:22PM -0500, Steven Rostedt wrote:
> Hi,
> 
> I'm developing a custom kernel on top of Ingo's -rt patch. My kernel
> makes race conditions in the vanilla kernel show up very well :-)
> 
> I just hit a bug, actually a page fault in fs/sysfs/dir.c in
> sysfs_readdir:
> 
> 
> 
> 			for (p=q->next; p!= &parent_sd->s_children; p=p->next) {
> 				struct sysfs_dirent *next;
> 				const char * name;
> 				int len;
> 
> 				next = list_entry(p, struct sysfs_dirent,
> 						   s_sibling);
> 				if (!next->s_element)
> 					continue;
> 
> 				name = sysfs_get_name(next);
> 				len = strlen(name);
> 				if (next->s_dentry)
> 					ino = next->s_dentry->d_inode->i_ino;
> 
> ^^^^
> This is where I had a bad pointer reference.
> 
> 				else
> 					ino = iunique(sysfs_sb, 2);
> 
> 				if (filldir(dirent, name, len, filp->f_pos, ino,
> 						 dt_type(next)) < 0)
> 					return 0;
> 
> 
> Looking at this code, I don't see anything protecting the s_dentry. For
> example, couldn't the following happen:
> 
> sysfs_create_dir is called, which calls create_dir.  Now we create a
> dentry with no d_inode. In sysfs_make_dirent which calls
> sysfs_new_dirent which adds to the parents s_children. Then
> sysfs_make_dirent sets s_dentry = dentry (the one that was just made
> with no d_inode assigned yet).  Then create_dir calls sysfs_create which
> finally assigns the d_inode.
> 
> So, either there is some hidden protection and my modification to the
> kernel has caused this to bug, or we have just been lucky the whole time
> in the vanilla kernel.

I think we've been lucky :(

Maneesh, any ideas?

thanks,

greg k-h
