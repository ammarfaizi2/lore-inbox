Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWAKNFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWAKNFv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 08:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWAKNFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 08:05:51 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:2553 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751173AbWAKNFu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 08:05:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r7jF+psnDwXzIvAiJG03UFGzyiYK3FA1GSpr7xs06+ptGxw928jgiGVYQMResdCzDAua2WYDO2SRJ8vWtmUtME6YHBEFgJ3XOVkz6ZKncc8gIPFAk8xvCMP9tyy7qlv8IPDr8Ngz8dj68Fd0lQ7gVbhXc9x1Le4qbm0SUAB4vOU=
Message-ID: <a4e6962a0601110505r1f13f78cp2dfda7e6bb2d23fe@mail.gmail.com>
Date: Wed, 11 Jan 2006 07:05:48 -0600
From: Eric Van Hensbergen <ericvh@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH]: v9fs: add readpage support
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.org
In-Reply-To: <20060111033821.4b3d4d7b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060111011437.451FD5A809A@localhost.localdomain>
	 <20060111033821.4b3d4d7b.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/06, Andrew Morton <akpm@osdl.org> wrote:
> ericvh@gmail.com (Eric Van Hensbergen) wrote:
> >
> > Subject: [PATCH] v9fs: add readpage support
> >
> > v9fs mmap support was originally removed from v9fs at Al Viro's request,
> > but recently there have been requests from folks who want readpage
> > functionality (primarily to enable execution of files mounted via 9P).
> > This patch adds readpage support (but not writepage which contained most of
> > the objectionable code).  It passes FSX (and other regressions) so it
> > should be relatively safe.
> >
> > +
> > +static int v9fs_vfs_readpage(struct file *filp, struct page *page)
> > +{
> > +     char *buffer = NULL;
> > +     int retval = -EIO;
> > +     loff_t offset = page_offset(page);
> > +     int count = PAGE_CACHE_SIZE;
> > +     struct inode *inode = filp->f_dentry->d_inode;
> > +     struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
> > +     int rsize = v9ses->maxdata - V9FS_IOHDRSZ;
> > +     struct v9fs_fid *v9f = filp->private_data;
> > +     struct v9fs_fcall *fcall = NULL;
> > +     int fid = v9f->fid;
> > +     int total = 0;
> > +     int result = 0;
> > +
> > +     buffer = kmap(page);
> > +     do {
> > +             if (count < rsize)
> > +                     rsize = count;
> > +
> > +             result = v9fs_t_read(v9ses, fid, offset, rsize, &fcall);
> > +
> > +             if (result < 0) {
> > +                     printk(KERN_ERR "v9fs_t_read returned %d\n",
> > +                            result);
> > +
> > +                     kfree(fcall);
> > +                     goto UnmapAndUnlock;
> > +             } else
> > +                     offset += result;
> > +
> > +             memcpy(buffer, fcall->params.rread.data, result);
> > +
> > +             count -= result;
> > +             buffer += result;
> > +             total += result;
> > +
> > +             kfree(fcall);
>
> Minor thing: from my reading of v9fs_mux_rpc() there's potential for a
> double-kfree here.  Either v9fs_mux_rpc() needs to be changed to
> unambiguously zero out *rcall (or, better, v9fs_t_read does it) or you need
> to zero fcall on each go around the loop.
>
>

Okay I'll take a look at this in the context of both the old mux and
the new mux code.

> > +             if (result < rsize)
> > +                     break;
> > +     } while (count);
> > +
> > +     memset(buffer, 0, count);
> > +     flush_dcache_page(page);
> > +     SetPageUptodate(page);
>
> if (result < rsize), is the page really up to date?
>

maybe?  Its been a while since I looked at this code, but I believe
the logic is that if you are approaching the end of the file you'll
get less than rsize bytes back and then you just fill in the rest of
the page with zeros.

> > +     retval = 0;
> > +
> > +      UnmapAndUnlock:
> > +     kunmap(page);
>
> eww, do you really indent labels like that?
>

No, something funky happened and I didn't proof the patch like I should have.

> > diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> > index 6852f0e..feddc5c 100644
> > --- a/fs/9p/vfs_file.c
> > +++ b/fs/9p/vfs_file.c
> > @@ -289,6 +289,8 @@ v9fs_file_write(struct file *filp, const
> >               total += result;
> >       } while (count);
> >
> > +     invalidate_inode_pages2(inode->i_mapping);
> > +
> >       return total;
> >  }
>
> That's a really scary function you have there.  Can you explain the
> thinking behind its use here?  What are we trying to achieve?
>

Its quite possible I've done the wrong thing here.  The intent is to
make sure that any stuff that might be in the page cache due to an
mmap is flushed when I do a write.  This approach is overkill, I
should probably just flush anything in the cache that the write
affects.

I'll take another look at the mux stuff and also see if I can come up
with a less brute-force approach to invalidating the page cache.

thanks for the comments.

      -eric
