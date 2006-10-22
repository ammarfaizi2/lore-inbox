Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161515AbWJVAMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161515AbWJVAMB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 20:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161514AbWJVAMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 20:12:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42379 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751756AbWJVAL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 20:11:59 -0400
Date: Sat, 21 Oct 2006 17:11:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: James Morris <jmorris@namei.org>
cc: Josef Jeff Sipek <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@ftp.linux.org.uk,
       hch@infradead.org
Subject: Re: [PATCH 08 of 23] isofs: change uses of f_{dentry, vfsmnt} to
 use f_path
In-Reply-To: <Pine.LNX.4.64.0610211909210.17454@d.namei>
Message-ID: <Pine.LNX.4.64.0610211702410.3962@g5.osdl.org>
References: <15a2d7465501c952a2af.1161411453@thor.fsl.cs.sunysb.edu>
 <Pine.LNX.4.64.0610211909210.17454@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 21 Oct 2006, James Morris wrote:
>
> What about something like:
> 
> static inline struct inode *fpath_ino(struct file *file)
> {
> 	return file->f_path.dentry->d_inode;
> }

Generally, unless it saves a _lot_ of typing, we've tried to avoid 
gratuitous hiding of details. And "ino" isn't a good name, it's something 
we've traditionally used for the inode _number_. So it would be 
"fpath_inode()" or "file_inode()" or something.

As it is, the difference between

	file->f_dentry->d_inode
	fpath_inode(file)

is not really enough of a win to merit hiding that it's doing two pointer 
dereferences. Now, whether the extra five characters ("path.") merit it, I 
don't know.  I suspect not. If the line turns long, it's often more 
readable to just add a local variable or two, and do

	struct dentry *dentry = file->f_[path.]dentry;
	struct inode *inode = dentry->d_inode;

which in some situations allow for other readability improvements too (eg 
maybe "dentry" or "inode" is used multiple times).

If this was something where we'd expect things to change in the future, 
maybe it would be worth it for _that_ reason. That doesn't sound very 
likely, though - these things have been fairly stable, and even this patch 
is really about syntactic cleanup than any real change.

Adding these kinds of "abstraction layers" is something that people are 
taught is good, but I personally tend to think that it makes it less 
obvious at the code level what the "costs" are. Unless you know things 
intimately, you really have no way of judging whether "fpath_inode()" is 
something expensive or not. 

I dunno. 

		Linus
