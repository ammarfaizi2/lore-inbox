Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264567AbTK0Rpu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 12:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264570AbTK0Rpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 12:45:50 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:11392 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S264567AbTK0Rpq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 12:45:46 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16326.14408.365320.326423@laputa.namesys.com>
Date: Thu, 27 Nov 2003 20:45:44 +0300
To: Jamie Lokier <jamie@shareable.org>
Cc: "Joseph D. Wagner" <theman@josephdwagner.info>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       "'Matthew Wilcox'" <willy@debian.org>
Subject: Re: [PATCH] fs/locks.c fcntl_setlease did not check if a file was opened for writing before granting a read lease
In-Reply-To: <20031127165043.GA19669@mail.shareable.org>
References: <000301c3b504$689afbf0$0201a8c0@joe>
	<20031127165043.GA19669@mail.shareable.org>
X-Mailer: VM 7.17 under 21.5 (patch 16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier writes:
 > Joseph D. Wagner wrote:
 > > But I THINK this is how a patch would fix the problem, in theory.
 > 
 > Sorry, it won't.
 > 
 > > +	if ((arg == F_RDLCK)
 > > +	    && ((dentry->d_flags & O_WRONLY)
 > > +		|| (dentry->d_flags & O_RDWR)
 > > +		|| (dentry->d_flags & O_CREAT)
 > > +		|| (dentry->d_flags & O_TRUNC)
 > > +		|| (inode->i_flags & O_WRONLY)
 > > +		|| (inode->i_flags & O_RDWR)
 > > +		|| (inode->i_flags & O_CREAT)
 > > +		|| (inode->i_flags & O_TRUNC)))
 > > +		goto out_unlock;
 > 
 > dentry->d_flags is a combination of the S_ flags, not O_ flags.
 > E.g. S_SYNC, S_NOATIME etc.
 > 
 > inode->i_flags is a combination of the DCACHE_ flags.
 > E.g. DCACHE_AUTOFS_PENDING, DCACHE_REFERENCED tc.

I think it is other way around. ->i_flags are combined from S_SYNC (see,
include/linux/fs.h:IS_IMMUTABLE(), for example), and ->d_flags are
combined from DCACHE_*, latter is explicitly stated in
include/linux/dcache.h

 > 
 > To detect if anyone has the file open for writing, you'll a new count
 > field which keeps track of writer references.  Something like this:
 > 
 > 	if ((arg == F_RDLCK)
 > 	    && ((atomic_read(&inode->i_writer_count) != 0)))
 > 
 > You'll also need to modify all the places where that needs to be
 > maintained.
 > 
 > Btw, I'm not sure why the F_WRLCK case needs to check d_count and
 > i_count.  Isn't it enough to check d_count?  Won't all opens reference
 > the inode through a dentry?:
 > 
 > >  	if ((arg == F_WRLCK)
 > >  	    && ((atomic_read(&dentry->d_count) > 1)
 > >  		|| (atomic_read(&inode->i_count) > 1)))
 > 
 > -- Jamie

Nikita.

