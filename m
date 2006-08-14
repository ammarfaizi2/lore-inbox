Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932743AbWHNXoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932743AbWHNXoq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 19:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965068AbWHNXoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 19:44:46 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:29032 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932741AbWHNXop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 19:44:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding:sender;
        b=eobLMuD4dbMkVM6Fe5sm3ktebZLzzVNyAeOSf+EjZqWumAH9pAckhI5H0Ll9N4ePFk2lPs/M64Xj+W6jLjSjCUn05Xv4kSzCVubfIrkaRN2bNoZOA07VAl/eQKBUNF+6wdZUHvcE3EsvyPRllLLLc+8nf0HDQZPbaMRCgZKtBms=
Subject: Re: [PATCH] Fix memory leak in vc_resize/vc_allocate
From: "Antonino A. Daplas" <adaplas@pol.net>
To: Andrew Morton <akpm@osdl.org>
Cc: catalin.marinas@gmail.com, Catalin Marinas <catalin.marinas@arm.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060814154356.61fc89ca.akpm@osdl.org>
References: <20060810142221.31793.20635.stgit@localhost.localdomain>
	 <20060814154356.61fc89ca.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 15 Aug 2006 07:44:33 +0800
Message-Id: <1155599074.3917.8.camel@daplas.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-14 at 15:43 -0700, Andrew Morton wrote:
> On Thu, 10 Aug 2006 15:22:21 +0100
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> > From: Catalin Marinas <catalin.marinas@arm.com>
> > 
> > Memory leaks can happen in the vc_resize() function in drivers/char/vt.c
> > because of the vc->vc_screenbuf variable overriding in vc_allocate(). The
> > kmemleak reported trace is as follows:
> > 
> >   <__kmalloc>
> >   <vc_resize>
> >   <fbcon_init>
> >   <visual_init>
> >   <vc_allocate>
> >   <con_open>
> >   <tty_open>
> >   <chrdev_open>
> > 
> > This patch no longer allocates a screen buffer in vc_allocate() if it was
> > already allocated by vc_resize().
> > 
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> > 
> >  drivers/char/vt.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/char/vt.c b/drivers/char/vt.c
> > index da7e66a..31c8b32 100644
> > --- a/drivers/char/vt.c
> > +++ b/drivers/char/vt.c
> > @@ -730,7 +730,8 @@ int vc_allocate(unsigned int currcons)	/
> >  	    visual_init(vc, currcons, 1);
> >  	    if (!*vc->vc_uni_pagedir_loc)
> >  		con_set_default_unimap(vc);
> > -	    vc->vc_screenbuf = kmalloc(vc->vc_screenbuf_size, GFP_KERNEL);
> > +	    if (!vc->vc_kmalloced)
> > +		vc->vc_screenbuf = kmalloc(vc->vc_screenbuf_size, GFP_KERNEL);
> >  	    if (!vc->vc_screenbuf) {
> >  		kfree(vc);
> >  		vc_cons[currcons].d = NULL;
> 
> hm.  Maybe.  I'd worry that the memory at vc->vc_screenbuf isn't of the
> correct size and this patch will convert a leak into a buffer overrun.

It's a safe test, visual_init() will assure that screenbuf_size will
always be correct. 

> Also, what's up with this, in vc_resize()?
> 
> 	if (vc->vc_kmalloced)
> 		kfree(vc->vc_screenbuf);
> 	vc->vc_screenbuf = newscreen;
> 	vc->vc_kmalloced = 1;
> 
> if vc->vc_kmalloced means "there is kmalloced memory at vc->vc_screenbuf"
> then this is wrong.

vc_screenbuf is either of the bootmem type or the kmalloced type as
indicated by vc->vc_kmalloced.

> 
> This code is all pretty twisty and I fear touching it.

Yes, but the patch as is should be okay.

Tony

