Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbWIES4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWIES4w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 14:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWIES4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 14:56:52 -0400
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:32236 "EHLO
	mail1.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932179AbWIES4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 14:56:50 -0400
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH] Clean up expand_fdtable() and expand_files().
Date: Tue, 5 Sep 2006 11:56:49 -0700
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200609042208.36894.vlobanov@speakeasy.net> <20060905095504.b76dca63.rdunlap@xenotime.net>
In-Reply-To: <20060905095504.b76dca63.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609051156.50150.vlobanov@speakeasy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 September 2006 09:55, Randy.Dunlap wrote:
> On Mon, 4 Sep 2006 22:08:36 -0700 Vadim Lobanov wrote:
> > Hi,
> >
> > This patch performs a code cleanup against the expand_fdtable() and
> > expand_files() functions inside fs/file.c. It aims to make the flow of
> > code within these functions simpler and easier to understand, via added
> > comments and modest refactoring. The patch was generated against
> > 2.6.18-rc5-mm1, and was successfully run live. Please apply.
> >
> > (I'm trying out KMail for this patch. I tested this mailer beforehand to
> > make sure the patch will come out unmangled, but, as with all things
> > software, success is far from guaranteed. :) Please yell if the patch is
> > borked.)
>
> It's not (mechanically) b0rked.
>
> > Signed-off-by: Vadim Lobanov <vlobanov@speakeasy.net>
> >
> > diff -Npru linux-a/fs/file.c linux-b/fs/file.c
> > --- linux-a/fs/file.c	2006-09-01 20:34:12.000000000 -0700
> > +++ linux-b/fs/file.c	2006-09-04 16:42:33.000000000 -0700
> > @@ -296,37 +296,30 @@ static int expand_fdtable(struct files_s
> >  	__releases(files->file_lock)
> >  	__acquires(files->file_lock)
> >  {
> > -	int error = 0;
> > -	struct fdtable *fdt;
> > -	struct fdtable *nfdt = NULL;
> > +	struct fdtable *new_fdt, *cur_fdt;
> >
> >  	spin_unlock(&files->file_lock);
> > -	nfdt = alloc_fdtable(nr);
> > -	if (!nfdt) {
> > -		error = -ENOMEM;
> > -		spin_lock(&files->file_lock);
> > -		goto out;
> > -	}
> > -
> > +	new_fdt = alloc_fdtable(nr);
> >  	spin_lock(&files->file_lock);
> > -	fdt = files_fdtable(files);
> > +	if (!new_fdt)
> > +		return -ENOMEM;
> >  	/*
> > -	 * Check again since another task may have expanded the
> > -	 * fd table while we dropped the lock
> > +	 * Check again since another task may have expanded the fd table while
> > +	 * we dropped the lock
> >  	 */
> > -	if (nr >= fdt->max_fds || nr >= fdt->max_fdset) {
> > -		copy_fdtable(nfdt, fdt);
> > +	cur_fdt = files_fdtable(files);
> > +	if (nr >= cur_fdt->max_fds || nr >= cur_fdt->max_fdset) {
> > +		/* Continue as planned */
> > +		copy_fdtable(new_fdt, cur_fdt);
> > +		rcu_assign_pointer(files->fdt, new_fdt);
> > +		free_fdtable(cur_fdt);
> >  	} else {
> > -		/* Somebody expanded while we dropped file_lock */
> > +		/* Somebody else expanded, so undo our attempt */
> >  		spin_unlock(&files->file_lock);
> > -		__free_fdtable(nfdt);
> > +		__free_fdtable(new_fdt);
> >  		spin_lock(&files->file_lock);
> > -		goto out;
> >  	}
> > -	rcu_assign_pointer(files->fdt, nfdt);
> > -	free_fdtable(fdt);
> > -out:
> > -	return error;
> > +	return 1;
>
> This function didn't previously return a value of 1.
> If it can do so now, please document it in the function comments
> "header".  Using kernel-doc would be good too.

More comments on the function headers. Gotcha. Will resend.

The problem with kernel-doc in this particular instance is that none of the 
other functions in that file have comments in that particular style; they all 
currently use the mostly-unstructured C comments. If anything, it'd be far 
simpler and cleaner to get this particular patch merged first, and then add 
kernel-doc comments to _all_ the functions in this file at once in a later 
patch.

>
> ---
> ~Randy

-- Vadim Lobanov
