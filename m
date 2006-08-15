Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965290AbWHOIQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965290AbWHOIQu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 04:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965291AbWHOIQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 04:16:50 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:24617 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965290AbWHOIQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 04:16:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DQyYord7dpEllrp0s1iOTMNGGrHVtM3ERNKUUcxIECh4hbIrTHtcDHbLBKx+Hyr4fXPEajOetzGM3TMc1Sz1fUgj8ibks9yeJmOlJPzeuTx6ZA9U5xow3XTJdnENwiKR6Kg+c8LumSNeAvYTOMvl5vhYl2WywlFMcomGyc13ILE=
Message-ID: <b0943d9e0608150116j1cde00cco12e816704adb6a57@mail.gmail.com>
Date: Tue, 15 Aug 2006 09:16:48 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH] Fix memory leak in vc_resize/vc_allocate
Cc: linux-kernel@vger.kernel.org, "Antonino A. Daplas" <adaplas@pol.net>
In-Reply-To: <20060814154356.61fc89ca.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060810142221.31793.20635.stgit@localhost.localdomain>
	 <20060814154356.61fc89ca.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/06, Andrew Morton <akpm@osdl.org> wrote:
> On Thu, 10 Aug 2006 15:22:21 +0100
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> > diff --git a/drivers/char/vt.c b/drivers/char/vt.c
> > index da7e66a..31c8b32 100644
> > --- a/drivers/char/vt.c
> > +++ b/drivers/char/vt.c
> > @@ -730,7 +730,8 @@ int vc_allocate(unsigned int currcons)    /
> >           visual_init(vc, currcons, 1);
> >           if (!*vc->vc_uni_pagedir_loc)
> >               con_set_default_unimap(vc);
> > -         vc->vc_screenbuf = kmalloc(vc->vc_screenbuf_size, GFP_KERNEL);
> > +         if (!vc->vc_kmalloced)
> > +             vc->vc_screenbuf = kmalloc(vc->vc_screenbuf_size, GFP_KERNEL);
> >           if (!vc->vc_screenbuf) {
> >               kfree(vc);
> >               vc_cons[currcons].d = NULL;
>
> hm.  Maybe.  I'd worry that the memory at vc->vc_screenbuf isn't of the
> correct size and this patch will convert a leak into a buffer overrun.

My initial attempt was to free the kmalloc'ed buffer and reallocate it
in vc_allocate (similar to the code in vc_resize) but I realised that
vc_screenbuf kmalloced block is always of the vs_screenbuf_size
length.

> Also, what's up with this, in vc_resize()?
>
>         if (vc->vc_kmalloced)
>                 kfree(vc->vc_screenbuf);
>         vc->vc_screenbuf = newscreen;
>         vc->vc_kmalloced = 1;
>
> if vc->vc_kmalloced means "there is kmalloced memory at vc->vc_screenbuf"
> then this is wrong.

I think the above should be fine because vc_resize can be called
either via vc_allocate->visual_init->fbcon_init when the buffer was
not yet allocated or via a tty ioctl etc. and it needs to free the old
buffer.

-- 
Catalin
