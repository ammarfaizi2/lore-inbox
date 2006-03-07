Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932611AbWCGCUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbWCGCUz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 21:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbWCGCUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 21:20:55 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:51798 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932611AbWCGCUy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 21:20:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V5BBoPFmRPvcRs4wl7svxh2CCaEThjA6kth4EIBb9ie1rVZ3CDVbOb3xMCb3LEOklomnFtyhmPtNPuBtNoKeN3ZacJm2Yk7lfM5fiZ2+dZY1ky7dRKqVcl86EJNLYbyWji/ZaEkiovE/AFi9A/ESgxPKRSUB9owH4bCi5DuaAmk=
Message-ID: <f158dc670603061820t69045cd3m3a98a9c3af3e49df@mail.gmail.com>
Date: Mon, 6 Mar 2006 21:20:53 -0500
From: "Latchesar Ionkov" <lionkov@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 9pfs double kfree
Cc: "Dave Jones" <davej@redhat.com>, linux-kernel@vger.kernel.org,
       ericvh@gmail.com, rminnich@lanl.gov,
       v9fs-developer@lists.sourceforge.net
In-Reply-To: <20060306163745.65e0f4d8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060306070456.GA16478@redhat.com>
	 <20060306163745.65e0f4d8.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We can't allocate it on the outermost caller's stack. The memory
pointed by v9fs_fcall strucures has variable size and depends on the
incoming 9P messages.

Thanks,
    Lucho

On 3/6/06, Andrew Morton <akpm@osdl.org> wrote:
> Dave Jones <davej@redhat.com> wrote:
> >
> > Probably the first of many found with Coverity.
> >
> > This is kfree'd outside of both arms of the if condition already,
> > so fall through and free it just once.
> >
> > Second variant is double-nasty, it deref's the free'd fcall
> > before it tries to free it a second time.
> >
> > (I wish we had a kfree variant that NULL'd the target when it was free'd)
> >
> > Coverity bugs: 987, 986
> >
> > Signed-off-by: Dave Jones <davej@redhat.com>
> >
> >
> > --- linux-2.6.15.noarch/fs/9p/vfs_super.c~    2006-03-06 01:53:38.000000000 -0500
> > +++ linux-2.6.15.noarch/fs/9p/vfs_super.c     2006-03-06 01:54:36.000000000 -0500
> > @@ -156,7 +156,6 @@ static struct super_block *v9fs_get_sb(s
> >       stat_result = v9fs_t_stat(v9ses, newfid, &fcall);
> >       if (stat_result < 0) {
> >               dprintk(DEBUG_ERROR, "stat error\n");
> > -             kfree(fcall);
> >               v9fs_t_clunk(v9ses, newfid);
> >       } else {
> >               /* Setup the Root Inode */
> > --- linux-2.6.15.noarch/fs/9p/vfs_inode.c~    2006-03-06 01:57:05.000000000 -0500
> > +++ linux-2.6.15.noarch/fs/9p/vfs_inode.c     2006-03-06 01:58:05.000000000 -0500
> > @@ -274,7 +274,6 @@ v9fs_create(struct v9fs_session_info *v9
> >               PRINT_FCALL_ERROR("clone error", fcall);
> >               goto error;
> >       }
> > -     kfree(fcall);
> >
> >       err = v9fs_t_create(v9ses, fid, name, perm, mode, &fcall);
> >       if (err < 0) {
>
> The second hunk is probably right and I guess the first one has to be right
> as well, but it's all rather obscure, complex and (naturally) comment-free.
>
> So I'll duck on this - Eric, could you please handle it?  Consider doing
> away with the dynamically-allocated thing altogether and just allocating it
> on the outermost caller's stack.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
