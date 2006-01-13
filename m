Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161200AbWAMVpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161200AbWAMVpr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 16:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161571AbWAMVpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 16:45:47 -0500
Received: from uproxy.gmail.com ([66.249.92.204]:16159 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161568AbWAMVpq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 16:45:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ABOLpbUzH6RX7TmRQCDjloFSzjugUaGh11CC6v1TvjpZQLgHetowubohiW64drYYjK3wzlIIdbdUDHO35V70LU113gdj52rUe1SpzhQQMlBfcDXa+TKe8AztvCvy1m3kEWo4xdNrz0oLpgu6CLF55pmKP48WwR9Cs57RezPOQnE=
Message-ID: <a4e6962a0601131345x6bf4ef3ftf3e6c6fb7bb2b530@mail.gmail.com>
Date: Fri, 13 Jan 2006 15:45:44 -0600
From: Eric Van Hensbergen <ericvh@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH]: v9fs: add readpage support
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       Linux FS Devel <linux-fsdevel@vger.kernel.org>
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

Okay, I had a chance to go back and look into this deeper when applied
on top of Lucho's new mux code.  It appears (to Lucho and I) that the
the v9fs_mux_rpc() code zero's out *rcall really early on, so I don't
see where this could lead to a double kfree.  If you still think we
are missing something, let me know and I'll have another look.

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

I went looking for an example of how to do this better.  More or less,
v9fs reads and writes are similar to DirectIO since they don't go
through the page-cache.  So, I looked at what NFS does when it gets a
DirectIO write, and it looks (to me) like it does more or less the
same thing:
(from nfs_file_direct_write() in fs/nfs/direct.c)
        retval = nfs_direct_write(inode, ctx, &iov, pos, 1);
        if (mapping->nrpages)
                invalidate_inode_pages2(mapping);

Now, that being said, it still seems to me to be a bit heavy weight --
do folks have a better pointer to code that I can use as an example of
how to do this more efficiently?

       -eric
