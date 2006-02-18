Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWBRXms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWBRXms (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 18:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWBRXms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 18:42:48 -0500
Received: from pat.uio.no ([129.240.130.16]:13011 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932336AbWBRXmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 18:42:47 -0500
Subject: Re: Missed error checking for intent's filp in open_namei in 2.6.15
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060218231153.GA32003@linuxhacker.ru>
References: <20060218231153.GA32003@linuxhacker.ru>
Content-Type: text/plain
Date: Sat, 18 Feb 2006 18:42:36 -0500
Message-Id: <1140306156.7869.1.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.359, required 12,
	autolearn=disabled, AWL 1.45, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-19 at 01:11 +0200, Oleg Drokin wrote:
> Hello!
> 
>    It seems there is error check missing in open_namei for errors returned
>    through intent.open.file (from lookup_instantiate_filp).
>    If there is plain open performed, then such a check done inside
>    __path_lookup_intent_open called from path_lookup_open(), but
>    when the open is performed with O_CREAT flag set, then
>    __path_lookup_intent_open is only called with LOOKUP_PARENT set where no file
>    opening can occur yet. Later on lookup_hash is called where exact opening
>    might take place and intent.open.file may be filled. If it is filled
>    with error value of some sort, then we get kernel attempting to dereference
>    this error value as address (and corresponding oops) in nameidata_to_filp()
>    called from filp_open().
>    While this is relatively simple to workaround in ->lookup() method by just
>    checking lookup_instantiate_filp() return value and returning error as
>    needed, this is not so easy in ->d_revalidate(), where we can only return
>    "yes, dentry is valid" or "no, dentry is invalid, perform full lookup again",
>    and just returning 0 on error would cause extra lookup (with potential
>    extra costly RPCs).
>    So in short, I believe that there should be no difference in error handling
>    for opening a file and creating a file in open_namei() and propose
>    this simple patch as a solution.
>    What do you think?

You're going to have to convert that semaphore call to a mutex call if
you want to apply it to 2.6.16 too, but otherwise it looks good.

Cheers,
  Trond

> --- fs/namei.c.orig	2006-02-19 00:33:24.000000000 +0200
> +++ fs/namei.c	2006-02-19 00:46:28.000000000 +0200
> @@ -1575,6 +1575,12 @@ do_last:
>  		goto exit;
>  	}
>  
> +        if (IS_ERR(nd->intent.open.file)) {
> +		up(&dir->d_inode->i_sem);
> +		error = PTR_ERR(nd->intent.open.file);
> +		goto exit_dput;
> +	}
> +
>  	/* Negative dentry, just create the file */
>  	if (!path.dentry->d_inode) {
>  		if (!IS_POSIXACL(dir->d_inode))
> 
> Bye,
>     Oleg

