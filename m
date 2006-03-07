Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932600AbWCGBtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbWCGBtc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 20:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbWCGBtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 20:49:31 -0500
Received: from xproxy.gmail.com ([66.249.82.195]:15303 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932600AbWCGBtb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 20:49:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cQy+r6XK0RO8MaK73lat9SvbSGqYjgsF89S4ImYrsL1ARDmE1uXzqGvdX6fAnK/0g1nQLFqv7AfQx2nGtxuM2vE65StMJN9UVd4rK/GrriOGAj5EYzbxuQTgGpBx0qFjLOsgZ5/+ZkIVRWRY4JGl/9vUKqMA43NYIkmbCBM1wOA=
Message-ID: <f158dc670603061749t18196e63tab3409441942ac3@mail.gmail.com>
Date: Mon, 6 Mar 2006 20:49:30 -0500
From: "Latchesar Ionkov" <lionkov@gmail.com>
To: "Dave Jones" <davej@redhat.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>, ericvh@gmail.com,
       rminnich@lanl.gov, v9fs-developer@lists.sourceforge.net
Subject: Re: 9pfs double kfree
In-Reply-To: <20060306070456.GA16478@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060306070456.GA16478@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The first issue is a bug, I'll send a patch in a few minutes.

The second one is not a bug. kfree on line 477 is freeing the
strucuture allocated by v9fs_t_walk. v9fs_t_create call overwrites
fcall (after the call it is either NULL or points to another memory
area) so the kfree on line 294 (or line 301 in case of error) don't do
double-free.

There is another bug in the second function though. If v9fs_get_idpool
fails, the execution goes to error label and kfree is called on the
uninitialized fcall. I'll include a fix of this bug too.

Thanks,
    Lucho

On 3/6/06, Dave Jones <davej@redhat.com> wrote:
> Probably the first of many found with Coverity.
>
> This is kfree'd outside of both arms of the if condition already,
> so fall through and free it just once.
>
> Second variant is double-nasty, it deref's the free'd fcall
> before it tries to free it a second time.
>
> (I wish we had a kfree variant that NULL'd the target when it was free'd)
>
> Coverity bugs: 987, 986
>
> Signed-off-by: Dave Jones <davej@redhat.com>
>
>
> --- linux-2.6.15.noarch/fs/9p/vfs_super.c~      2006-03-06 01:53:38.000000000 -0500
> +++ linux-2.6.15.noarch/fs/9p/vfs_super.c       2006-03-06 01:54:36.000000000 -0500
> @@ -156,7 +156,6 @@ static struct super_block *v9fs_get_sb(s
>         stat_result = v9fs_t_stat(v9ses, newfid, &fcall);
>         if (stat_result < 0) {
>                 dprintk(DEBUG_ERROR, "stat error\n");
> -               kfree(fcall);
>                 v9fs_t_clunk(v9ses, newfid);
>         } else {
>                 /* Setup the Root Inode */
> --- linux-2.6.15.noarch/fs/9p/vfs_inode.c~      2006-03-06 01:57:05.000000000 -0500
> +++ linux-2.6.15.noarch/fs/9p/vfs_inode.c       2006-03-06 01:58:05.000000000 -0500
> @@ -274,7 +274,6 @@ v9fs_create(struct v9fs_session_info *v9
>                 PRINT_FCALL_ERROR("clone error", fcall);
>                 goto error;
>         }
> -       kfree(fcall);
>
>         err = v9fs_t_create(v9ses, fid, name, perm, mode, &fcall);
>         if (err < 0) {
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
