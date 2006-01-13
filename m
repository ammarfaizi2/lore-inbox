Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423004AbWAMWNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423004AbWAMWNA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423009AbWAMWNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:13:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45262 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423004AbWAMWM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:12:59 -0500
Date: Fri, 13 Jan 2006 14:14:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Van Hensbergen <ericvh@gmail.com>
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH]: v9fs: add readpage support
Message-Id: <20060113141445.14b6469a.akpm@osdl.org>
In-Reply-To: <a4e6962a0601131345x6bf4ef3ftf3e6c6fb7bb2b530@mail.gmail.com>
References: <20060111011437.451FD5A809A@localhost.localdomain>
	<20060111033821.4b3d4d7b.akpm@osdl.org>
	<a4e6962a0601131345x6bf4ef3ftf3e6c6fb7bb2b530@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Van Hensbergen <ericvh@gmail.com> wrote:
>
> > > @@ -289,6 +289,8 @@ v9fs_file_write(struct file *filp, const
> > >               total += result;
> > >       } while (count);
> > >
> > > +     invalidate_inode_pages2(inode->i_mapping);
> > > +
> > >       return total;
> > >  }
> >
> 
> I went looking for an example of how to do this better.  More or less,
> v9fs reads and writes are similar to DirectIO since they don't go
> through the page-cache.

hm.  Why not?

>  So, I looked at what NFS does when it gets a
> DirectIO write, and it looks (to me) like it does more or less the
> same thing:
> (from nfs_file_direct_write() in fs/nfs/direct.c)
>         retval = nfs_direct_write(inode, ctx, &iov, pos, 1);
>         if (mapping->nrpages)
>                 invalidate_inode_pages2(mapping);
> 
> Now, that being said, it still seems to me to be a bit heavy weight --
> do folks have a better pointer to code that I can use as an example of
> how to do this more efficiently?

Not really.  If that's what you need to do then that's the way to do it. 
We've had nasty races and other problems wrt invalidate_inode_pages2 and
pagefaults, so I suggest you test that mix carefully.

Have you tried fsx-linux?  It's really good for finding data integrity
bugs.  There's a copy in
http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz.

I'd suggest that you want the mapping->nrpages test - it'll be a useful
speedup in the common case.

Of course, someone could come in and add a page to pagecache via a
pagefault at any time after that test, but that's true of
invalidate_inode_pages2() in general.
