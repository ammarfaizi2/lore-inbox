Return-Path: <linux-kernel-owner+w=401wt.eu-S1425529AbWLHOfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425529AbWLHOfS (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 09:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425526AbWLHOfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 09:35:18 -0500
Received: from wx-out-0506.google.com ([66.249.82.232]:41507 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425527AbWLHOfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 09:35:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h48DuHZ44QpfwjtvoleGfua3TEWDV4O+zHrUbmxRRfmvvLMbD3rj7J9WlWAWT272Ocqj3XiSHBRGp65fV+yzu4KNzM2axOxWvUUTSlGXgAnPqhVoht1G/AU/+nsI9q9gz8x26R7k6dHlPi3M7T8DI9P5CNQiXRYZHQwoHVH33J4=
Message-ID: <9a8748490612080635o3432d410gbb147c977de21499@mail.gmail.com>
Date: Fri, 8 Dec 2006 15:35:15 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Neil Brown" <neilb@suse.de>
Subject: Re: Let's get rid of those annoying "VFS is out of sync with lock manager" messages (includes proposed patch)
Cc: linux-kernel@vger.kernel.org,
       "Trond Myklebust" <trond.myklebust@fys.uio.no>,
       nfs@lists.sourceforge.net
In-Reply-To: <17784.56763.794504.185193@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200612072208.16350.jesper.juhl@gmail.com>
	 <17784.56763.794504.185193@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/06, Neil Brown <neilb@suse.de> wrote:
> On Thursday December 7, jesper.juhl@gmail.com wrote:
> >
> > So I took Neils patch, made the change Trond suggested and the result is
> > below.
> >
> > Comments?  Ok to merge?
>
> Yes, except that you need a changelog comment at the top.  Possibly
> based very heavily on the text I wrote, but written to justify the
> patch rather than to explain the bug.
>
> NeilBrown
>

How about this for a changelog entry?  :

Convert "VFS is out of sync with lock manager!" printk in
do_vfs_lock() to dprintk() since the message is useless in normal use
but could possibly be useful as a debugging aid.
Also turn off FL_SLEEP when calling do_vfs_lock() just in case after
getting -EINTR or -ERESTARTSYS.


> >
> >
> > Signed-off-by: Neil Brown <neilb@suse.de>
> > Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> > ---
> >
> >  fs/nfs/file.c |   11 +++++++----
> >  1 files changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> > index cc93865..22572af 100644
> > --- a/fs/nfs/file.c
> > +++ b/fs/nfs/file.c
> > @@ -428,8 +428,8 @@ static int do_vfs_lock(struct file *file
> >                       BUG();
> >       }
> >       if (res < 0)
> > -             printk(KERN_WARNING "%s: VFS is out of sync with lock manager!\n",
> > -                             __FUNCTION__);
> > +             dprintk("%s: VFS is out of sync with lock manager (res = %d)!\n",
> > +                             __FUNCTION__, res);
> >       return res;
> >  }
> >
> > @@ -479,10 +479,13 @@ static int do_setlk(struct file *filp, i
> >                * we clean up any state on the server. We therefore
> >                * record the lock call as having succeeded in order to
> >                * ensure that locks_remove_posix() cleans it out when
> > -              * the process exits.
> > +              * the process exits. Make sure not to sleep if
> > +              * someone else holds the lock.
> >                */
> > -             if (status == -EINTR || status == -ERESTARTSYS)
> > +             if (status == -EINTR || status == -ERESTARTSYS) {
> > +                     fl->fl_flags &= ~FL_SLEEP;
> >                       do_vfs_lock(filp, fl);
> > +             }
> >       } else
> >               status = do_vfs_lock(filp, fl);
> >       unlock_kernel();
> >
>


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
