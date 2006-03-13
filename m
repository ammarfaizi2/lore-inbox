Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbWCMPw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbWCMPw0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 10:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWCMPwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 10:52:25 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:56635 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751501AbWCMPwZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 10:52:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L8m37e+Nb/iyDhLiH34Vz+EMJlQMQSvn7Ggdjf8dmINH1ODfLQTjhKpMIB42Us+v3xJpIA4VzWIyTNi7vQR/1G3QIUuAAs2Z+fsUinvp1uikHuMm6q0lp+lcx2Q7dv1+viMxHHHD0DwKECcGI1eg2QtXmsSenb3bC/gHJezxOqg=
Message-ID: <661de9470603130752r7337c478w61c80ef4ed3628a4@mail.gmail.com>
Date: Mon, 13 Mar 2006 21:22:24 +0530
From: "Balbir Singh" <bsingharora@gmail.com>
To: "Neil Brown" <neilb@suse.de>
Subject: Re: [PATCH] Fix shrink_dcache_parent() against shrink_dcache_memory() race (3rd updated patch)]
Cc: "Jan Blunck" <jblunck@suse.de>, "Kirill Korotaev" <dev@openvz.org>,
       akpm@osdl.org, viro@zeniv.linux.org.uk, olh@suse.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <17429.1788.586399.181869@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060309165833.GK4243@hasse.suse.de> <441060D2.6090800@openvz.org>
	 <17425.2594.967505.22336@cse.unsw.edu.au> <441138B7.9060809@sw.ru>
	 <20060310105950.GL4243@hasse.suse.de>
	 <17425.26668.678359.918399@cse.unsw.edu.au>
	 <20060310123153.GN4243@hasse.suse.de>
	 <17428.39221.861124.797480@cse.unsw.edu.au>
	 <20060312230331.GO4243@hasse.suse.de>
	 <17429.1788.586399.181869@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmmm.... yes, I think that could work.  Patch below against
> 2.6.16-rc6-mm1.
>
> I cannot see down_read_trylock being slower than dcache_lock, so I
> suspect this shouldn't impact performance.
>
> Does this meet with everyone's approval?
>

I like the umount logic too, it is very similar to my solution of
down_read_trylock() on the umount semaphore, except that it does not
have the PF_XXXXXXX magic involved.

<snip>

> Signed-off-by: Neil Brown <neilb@suse.de>
>
> ### Diffstat output
>  ./fs/dcache.c |   40 ++++++++++++++++++++++++++++------------
>  1 file changed, 28 insertions(+), 12 deletions(-)
>
> diff ./fs/dcache.c~current~ ./fs/dcache.c
> --- ./fs/dcache.c~current~      2006-03-13 16:19:29.000000000 +1100
> +++ ./fs/dcache.c       2006-03-13 16:43:59.000000000 +1100
> @@ -383,6 +383,8 @@ static inline void prune_one_dentry(stru
>  /**
>   * prune_dcache - shrink the dcache
>   * @count: number of entries to try and free
> + * @sb: if given, ignore dentries for other superblocks
> + *         which are being unmounted.
>   *
>   * Shrink the dcache. This is done when we need
>   * more memory, or simply when we need to unmount
> @@ -393,7 +395,7 @@ static inline void prune_one_dentry(stru
>   * all the dentries are in use.
>   */
>
> -static void prune_dcache(int count)
> +static void prune_dcache(int count, struct super_block *sb)
>  {
>         spin_lock(&dcache_lock);
>         for (; count ; count--) {
> @@ -420,15 +422,27 @@ static void prune_dcache(int count)
>                         spin_unlock(&dentry->d_lock);
>                         continue;
>                 }
> -               /* If the dentry was recently referenced, don't free it. */
> -               if (dentry->d_flags & DCACHE_REFERENCED) {
> -                       dentry->d_flags &= ~DCACHE_REFERENCED;
> -                       list_add(&dentry->d_lru, &dentry_unused);
> -                       dentry_stat.nr_unused++;
> -                       spin_unlock(&dentry->d_lock);
> -                       continue;
> +               if (!(dentry->d_flags & DCACHE_REFERENCED) &&
> +                   (!sb || dentry->d_sb == sb)) {

Comments for the if condition please! It is a bit complex and I had to
read it a few times to understand what the condition achieves

> +                       if (sb) {
> +                               prune_one_dentry(dentry);
> +                               continue;
> +                       }
> +                       /* Need to avoid race with generic_shutdown_super */
> +                       if (down_read_trylock(&dentry->d_sb->s_umount) &&
> +                           dentry->d_sb->s_root != NULL) {
> +                               prune_one_dentry(dentry);
> +                               up_read(&dentry->d_sb->s_umount);
> +                               continue;
> +                       }

There is a BUG here. What if down_ready_trylock() succeeds and
dentry->d_sb->s_root == NULL? We will be missing an up_read().

<snip>

Balbir
