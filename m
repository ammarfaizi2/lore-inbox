Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422704AbWATAm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422704AbWATAm1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 19:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161468AbWATAm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 19:42:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1201 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161422AbWATAm0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 19:42:26 -0500
Date: Thu, 19 Jan 2006 16:43:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shrink_list: Use of && instead || leads to unintended
 writing of pages
Message-Id: <20060119164341.0fb9c7e3.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0601191602260.13428@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0601191602260.13428@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> The check for laptop mode and sc->may_writepage is intended to not write
> pages if either laptop mode is set or we are not allowed to write.
> 
> The && there means that currently pages may be written in laptop mode and during
> zone_reclaim. This patch also applies to 2.6.15 and 2.6.14!
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
> Index: linux-2.6.16-rc1-mm1/mm/vmscan.c
> ===================================================================
> --- linux-2.6.16-rc1-mm1.orig/mm/vmscan.c	2006-01-19 15:40:28.000000000 -0800
> +++ linux-2.6.16-rc1-mm1/mm/vmscan.c	2006-01-19 15:40:30.000000000 -0800
> @@ -491,7 +491,7 @@ static int shrink_list(struct list_head 
>  				goto keep_locked;
>  			if (!may_enter_fs)
>  				goto keep_locked;
> -			if (laptop_mode && !sc->may_writepage)
> +			if (laptop_mode || !sc->may_writepage)
>  				goto keep_locked;
>  
>  			/* Page is dirty, try to write it out here */

erk.

The effects of this fix will be a) slightly improved memory allocator
latency, b) somehat improved disk writeout patterns and c) somewhat
increased risk of ooms.

So we'll need to sit on it for quite some time to let it settle in, thanks.
