Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268698AbUI2RwC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268698AbUI2RwC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 13:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268755AbUI2RwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 13:52:02 -0400
Received: from fire.osdl.org ([65.172.181.4]:8147 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S268698AbUI2Rvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 13:51:54 -0400
Subject: Re: 1 New compile/sparse warning (overnight build)
From: John Cherry <cherry@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20040929173343.GF2322@suse.de>
References: <1096478522.20465.11.camel@cherrybomb.pdx.osdl.net>
	 <20040929173343.GF2322@suse.de>
Content-Type: text/plain
Message-Id: <1096480271.20465.13.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 29 Sep 2004 10:51:12 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-29 at 10:33, Jens Axboe wrote:
> On Wed, Sep 29 2004, John Cherry wrote:
> > This sparse warning was introduced with patch 1.2000 (axboe).
> > In fs/bio.c (line 509),
> > 
> > 	if (copy_from_user(addr, (char *) p, bvec->bv_len))
> > 
> > should probably be
> > 
> > 	if (copy_from_user(addr, (char __user *) p, bvec->bv_len))
> 
> It's not a new warning, just look at your own generated output:

Yes, this bug just moved.  Thanks for the fix.

John

> 
> > New warnings:
> > -------------
> > fs/bio.c:509:30: warning: incorrect type in argument 2 (different
> > address spaces)
> > fs/bio.c:509:30:    expected void const [noderef] *from<asn:1>
> > fs/bio.c:509:30:    got char *<noident>
> > 
> > 
> > Fixed warnings:
> > ---------------
> > fs/bio.c:462:31: warning: incorrect type in argument 2 (different
> > address spaces)
> > fs/bio.c:462:31:    expected void const [noderef] *from<asn:1>
> > fs/bio.c:462:31:    got char *<noident>
> 
> The warning simply moved. This should fix it, though.
> 
> Signed-off-by: Jens Axboe <axboe@suse.de>
> 
> ===== fs/bio.c 1.67 vs edited =====
> --- 1.67/fs/bio.c	2004-09-28 17:59:14 +02:00
> +++ edited/fs/bio.c	2004-09-29 19:34:39 +02:00
> @@ -497,7 +497,7 @@
>  	 * success
>  	 */
>  	if (!write_to_vm) {
> -		unsigned long p = uaddr;
> +		char __user *p = (char __user *) uaddr;
>  
>  		/*
>  		 * for a write, copy in data to kernel pages
> @@ -506,7 +506,7 @@
>  		bio_for_each_segment(bvec, bio, i) {
>  			char *addr = page_address(bvec->bv_page);
>  
> -			if (copy_from_user(addr, (char *) p, bvec->bv_len))
> +			if (copy_from_user(addr, p, bvec->bv_len))
>  				goto cleanup;
>  			p += bvec->bv_len;
>  		}

