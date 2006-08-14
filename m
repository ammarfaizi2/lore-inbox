Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932736AbWHNWoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932736AbWHNWoN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 18:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932737AbWHNWoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 18:44:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40592 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932736AbWHNWoM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 18:44:12 -0400
Date: Mon, 14 Aug 2006 15:43:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: catalin.marinas@gmail.com
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
       "Antonino A. Daplas" <adaplas@pol.net>
Subject: Re: [PATCH] Fix memory leak in vc_resize/vc_allocate
Message-Id: <20060814154356.61fc89ca.akpm@osdl.org>
In-Reply-To: <20060810142221.31793.20635.stgit@localhost.localdomain>
References: <20060810142221.31793.20635.stgit@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 15:22:21 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:

> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> Memory leaks can happen in the vc_resize() function in drivers/char/vt.c
> because of the vc->vc_screenbuf variable overriding in vc_allocate(). The
> kmemleak reported trace is as follows:
> 
>   <__kmalloc>
>   <vc_resize>
>   <fbcon_init>
>   <visual_init>
>   <vc_allocate>
>   <con_open>
>   <tty_open>
>   <chrdev_open>
> 
> This patch no longer allocates a screen buffer in vc_allocate() if it was
> already allocated by vc_resize().
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
> 
>  drivers/char/vt.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/char/vt.c b/drivers/char/vt.c
> index da7e66a..31c8b32 100644
> --- a/drivers/char/vt.c
> +++ b/drivers/char/vt.c
> @@ -730,7 +730,8 @@ int vc_allocate(unsigned int currcons)	/
>  	    visual_init(vc, currcons, 1);
>  	    if (!*vc->vc_uni_pagedir_loc)
>  		con_set_default_unimap(vc);
> -	    vc->vc_screenbuf = kmalloc(vc->vc_screenbuf_size, GFP_KERNEL);
> +	    if (!vc->vc_kmalloced)
> +		vc->vc_screenbuf = kmalloc(vc->vc_screenbuf_size, GFP_KERNEL);
>  	    if (!vc->vc_screenbuf) {
>  		kfree(vc);
>  		vc_cons[currcons].d = NULL;

hm.  Maybe.  I'd worry that the memory at vc->vc_screenbuf isn't of the
correct size and this patch will convert a leak into a buffer overrun.

Also, what's up with this, in vc_resize()?

	if (vc->vc_kmalloced)
		kfree(vc->vc_screenbuf);
	vc->vc_screenbuf = newscreen;
	vc->vc_kmalloced = 1;

if vc->vc_kmalloced means "there is kmalloced memory at vc->vc_screenbuf"
then this is wrong.

This code is all pretty twisty and I fear touching it.
