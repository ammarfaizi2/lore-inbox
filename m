Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757521AbWK0JTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757521AbWK0JTc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 04:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757530AbWK0JTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 04:19:31 -0500
Received: from nz-out-0102.google.com ([64.233.162.202]:2573 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1757521AbWK0JTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 04:19:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GQOIRADf3Kclje092PxrHSJmWkfkFNWhP8YB7Vk2vGloF8BrxSc0ZynGCj9lqoR56/Kqf6xunVnejtvbP2fC0jil+fzYa9V29a1tzMWl7dbn/qp+E/7GnmKlcz9Mfx502OPUO6VtKylE67CsCH7tbgedJNkmr4T8yi5+8oCY0Wo=
Message-ID: <9a8748490611270119pc812377veec5a4de7c27337@mail.gmail.com>
Date: Mon, 27 Nov 2006 10:19:29 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Subject: Re: [NFS] 2.6.17.8 - do_vfs_lock: VFS is out of sync with lock manager!
Cc: "Neil Brown" <neilb@suse.de>, nfs@lists.sourceforge.net,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <9a8748490611210443w7711b962u3fb35aef14746582@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490608080739w2e14e5ceg44a7bf0a3b475704@mail.gmail.com>
	 <17636.4462.975774.528003@cse.unsw.edu.au>
	 <9a8748490608170258s32df0272r60c8c540e5871485@mail.gmail.com>
	 <17641.10665.116168.867041@cse.unsw.edu.au>
	 <1156190098.6158.109.camel@localhost>
	 <9a8748490611210443w7711b962u3fb35aef14746582@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any chance we could get the patch below (or something similar) pushed
into 2.6.19?


On 21/11/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 21/08/06, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> > On Mon, 2006-08-21 at 13:34 +1000, Neil Brown wrote:
> > > Looking in fs/nfs/file.c (at 2.6.18-rc4-mm1 if it matters, but 2.6.17
> > > is much the same)
> > >
> > >  - do_vfs_lock is only called when the filesystem was mounted with
> > >     -o nolock  EXCEPT
> > >  - If a lock request to the server in interrupted (when mounted with
> > >      -o intr) then do_vfs_lock is called to try to get the lock
> > >     locally.  Normally equivalent code will be called inside
> > >     fs/lockd/clntproc.c when the server replies that the lock has been
> > >     gained.  In the case of an interrupt though this doesn't happen
> > >     but the lock may still have happened on the server.  So we record
> > >     locally that the lock was gained, to ensure that it gets unlocked
> > >     when the process exits.
> > >
> > > As you don't have '-o nolocks' you must be hitting the second case.
> > > The lock call to the server returns -EINTR or -ERESTARTSYS and
> > > do_vfs_lock is called just-in-case.
> > > As this is a just-in-case call, it is quite possible that the lock is
> > > held by some other process, so getting an error is entirely possible.
> > > So printing the message in this case seems wrong.
> > >
> > > On the other hand, printing the message in any other case seems wrong
> > > too, as server locking is not being used, so there is nothing to get
> > > out of sync with.
> > >
> > > As a further complication, I don't think that in the just-in-case
> > > situation that it should risk waiting for the lock.
> > > Now maybe we can be sure there is a pending signal which will break
> > > out of any wait (though I'm worried about -ERESTARTSYS - that doesn't
> > > imply a signal does it?), but I would feel more comfortable if
> > > FL_SLEEP were turned off in that path.
> > >
> > > So: Trond:  Any obvious errors in the above?
> > > Is the following patch ok?
> >
> > Could we instead replace it with a dprintk() that returns the value of
> > "res"? That will keep it useful for debugging purposes.
> >
>
> How about the below?
> (compile tested only)
>
> Neil: I left your Signed-off-by line since I just modified your patch slightly.
>
> Since Gmail will probably mangle the inline patch, it is attached as well.
>
>
> Signed-off-by: Neil Brown <neilb@suse.de>
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> --
>
>  fs/nfs/file.c |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> index cc93865..22572af 100644
> --- a/fs/nfs/file.c
> +++ b/fs/nfs/file.c
> @@ -428,8 +428,8 @@ static int do_vfs_lock(struct file *file
>                         BUG();
>         }
>         if (res < 0)
> -               printk(KERN_WARNING "%s: VFS is out of sync with lock
> manager!\n",
> -                               __FUNCTION__);
> +               dprintk("%s: VFS is out of sync with lock manager (res
> = %d)!\n",
> +                               __FUNCTION__, res);
>         return res;
>  }
>
> @@ -479,10 +479,13 @@ static int do_setlk(struct file *filp, i
>                  * we clean up any state on the server. We therefore
>                  * record the lock call as having succeeded in order to
>                  * ensure that locks_remove_posix() cleans it out when
> -                * the process exits.
> +                * the process exits. Make sure not to sleep if
> +                * someone else holds the lock.
>                  */
> -               if (status == -EINTR || status == -ERESTARTSYS)
> +               if (status == -EINTR || status == -ERESTARTSYS) {
> +                       fl->fl_flags &= ~FL_SLEEP;
>                         do_vfs_lock(filp, fl);
> +               }
>         } else
>                 status = do_vfs_lock(filp, fl);
>         unlock_kernel();
>



-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
