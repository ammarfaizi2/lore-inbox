Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVCGLGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVCGLGx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 06:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVCGLGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 06:06:53 -0500
Received: from cmailm4.svr.pol.co.uk ([195.92.193.211]:23309 "EHLO
	cmailm4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S261747AbVCGLGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 06:06:48 -0500
Message-Id: <200503071106.j27B6fE05365@blake.inputplus.co.uk>
To: Domen Puncer <domen@coderock.org>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       isdn4linux@listserv.isdn4linux.de, jlamanna@gmail.com
Subject: Re: [patch 1/8] isdn_bsdcomp.c - vfree() checking cleanups 
In-Reply-To: <20050307002133.GG32564@nd47.coderock.org> 
Date: Mon, 07 Mar 2005 11:06:40 +0000
From: Ralph Corderoy <ralph@inputplus.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Domen,

> On 07/03/05 00:07 +0000, Ralph Corderoy wrote:
> > > -		if (db->dict) {
> > > -			vfree (db->dict);
> > > -			db->dict = NULL;
> > > -		}
> > > +		vfree (db->dict);
> > > +		db->dict = NULL;
> > 
> > Is it really worth always calling vfree() which calls __vunmap()
> > before db->dict is determined to be NULL in order to turn three
> > lines into two?
> 
> Four lines into two :-)
> 
> > Plus the write to db->dict which might otherwise not be needed.  The
> > old code was clear, clean, and fast, no?
> 
> Shorter and more readable code is always better, right?

No.  Let me try and persuade you.

There's three cases.

    1.  foo will always be NULL at the line in question so no need to
    `vfree(foo); foo = NULL;'.

    2.  foo will never be NULL at the line in question so `vfree(foo);
    foo = NULL;' is mandatory.

    3.  foo will sometimes be NULL, sometimes not.

In that third case, seeing

    if (foo) {
        vfree(foo);
        foo = NULL;
    }

tells the reader that we're dealing with the `foo *maybe* NULL' case
whereas

    vfree(foo);
    foo = NULL;

*suggests* the `foo is never NULL' case.  The reader has to remember
that vfree(NULL) is valid and bear that in mind.

If the reader is about to modify the preceeding lines, knowing the foo
may sometimes be NULL helps.  So I prefer the longer code here because
it better shows the intent of the coder and is more telling about the
state of db->dict.

If you're really keen to save lines, please axe the superfluous
three-line comments.  We read C here, they're unnecessary.

>  		/*
>  		 * Release the dictionary
>  		 */
> -		if (db->dict) {
> -			vfree (db->dict);
> -			db->dict = NULL;
> -		}
> +		vfree (db->dict);
> +		db->dict = NULL;
>  
>  		/*
>  		 * Release the string buffer
>  		 */
> -		if (db->lens) {
> -			vfree (db->lens);
> -			db->lens = NULL;
> -		}
> +		vfree (db->lens);
> +		db->lens = NULL;
>  
>  		/*
>  		 * Finally release the structure itself.

Cheers,


Ralph.

