Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264565AbTK0Qux (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 11:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264563AbTK0Qux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 11:50:53 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:53121 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264562AbTK0Qut
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 11:50:49 -0500
Date: Thu, 27 Nov 2003 16:50:43 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "Joseph D. Wagner" <theman@josephdwagner.info>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       "'Matthew Wilcox'" <willy@debian.org>
Subject: Re: [PATCH] fs/locks.c fcntl_setlease did not check if a file was opened for writing before granting a read lease
Message-ID: <20031127165043.GA19669@mail.shareable.org>
References: <000301c3b504$689afbf0$0201a8c0@joe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000301c3b504$689afbf0$0201a8c0@joe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph D. Wagner wrote:
> But I THINK this is how a patch would fix the problem, in theory.

Sorry, it won't.

> +	if ((arg == F_RDLCK)
> +	    && ((dentry->d_flags & O_WRONLY)
> +		|| (dentry->d_flags & O_RDWR)
> +		|| (dentry->d_flags & O_CREAT)
> +		|| (dentry->d_flags & O_TRUNC)
> +		|| (inode->i_flags & O_WRONLY)
> +		|| (inode->i_flags & O_RDWR)
> +		|| (inode->i_flags & O_CREAT)
> +		|| (inode->i_flags & O_TRUNC)))
> +		goto out_unlock;

dentry->d_flags is a combination of the S_ flags, not O_ flags.
E.g. S_SYNC, S_NOATIME etc.

inode->i_flags is a combination of the DCACHE_ flags.
E.g. DCACHE_AUTOFS_PENDING, DCACHE_REFERENCED tc.

To detect if anyone has the file open for writing, you'll a new count
field which keeps track of writer references.  Something like this:

	if ((arg == F_RDLCK)
	    && ((atomic_read(&inode->i_writer_count) != 0)))

You'll also need to modify all the places where that needs to be
maintained.

Btw, I'm not sure why the F_WRLCK case needs to check d_count and
i_count.  Isn't it enough to check d_count?  Won't all opens reference
the inode through a dentry?:

>  	if ((arg == F_WRLCK)
>  	    && ((atomic_read(&dentry->d_count) > 1)
>  		|| (atomic_read(&inode->i_count) > 1)))

-- Jamie
