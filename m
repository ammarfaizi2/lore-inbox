Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbVJaGtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbVJaGtL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 01:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbVJaGtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 01:49:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8903 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932534AbVJaGtJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 01:49:09 -0500
Date: Sun, 30 Oct 2005 23:48:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH against 2.6.14] truncate() or ftruncate shouldn't change
 mtime if size doesn't change.
Message-Id: <20051030234837.36c7a249.akpm@osdl.org>
In-Reply-To: <1051031063444.9586@suse.de>
References: <20051031173358.9566.patches@notabene>
	<1051031063444.9586@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NeilBrown <neilb@suse.de> wrote:
>
> 
> 
> According to Posix and SUS, truncate(2) and ftruncate(2) only update
> ctime and mtime if the size actually changes.  Linux doesn't currently
> obey this.
> 
> There is no need to test the size under i_sem, as loosing any race
> will not make a noticable different the mtime or ctime.

Well if there's a race then the file may end up not being truncated after
this patch is applied.  But that could have happened anwyay, so I don't see
a need for i_sem synchronisation either.

> (According to SUS, truncate and ftruncate 'may' clear setuid/setgid
>  as well, currently we don't.  Should we?
> )
> 
> 
> Signed-off-by: Neil Brown <neilb@suse.de>
> 
> ### Diffstat output
>  ./fs/open.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff ./fs/open.c~current~ ./fs/open.c
> --- ./fs/open.c~current~	2005-10-31 16:22:44.000000000 +1100
> +++ ./fs/open.c	2005-10-31 16:22:44.000000000 +1100
> @@ -260,7 +260,8 @@ static inline long do_sys_truncate(const
>  		goto dput_and_out;
>  
>  	error = locks_verify_truncate(inode, NULL, length);
> -	if (!error) {
> +	if (!error &&
> +	    length != i_size_read(dentry->d_inode)) {

Odd code layout?

>  		DQUOT_INIT(inode);
>  		error = do_truncate(nd.dentry, length);
>  	}
> @@ -313,7 +314,8 @@ static inline long do_sys_ftruncate(unsi
>  		goto out_putf;
>  
>  	error = locks_verify_truncate(inode, file, length);
> -	if (!error)
> +	if (!error &&
> +	    length != i_size_read(dentry->d_inode))
>  		error = do_truncate(dentry, length);
>  out_putf:
>  	fput(file);

This partially obsoletes the similar optimisation in inode_setattr().  I
guess the optimisation there retains some usefulness for O_TRUNC opens of
zero-length files, but for symettry and micro-efficiency, perhaps we should
remvoe the inode_setattr() test and check for i_size==0 in may_open()?


