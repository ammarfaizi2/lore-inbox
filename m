Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbULWMgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbULWMgs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 07:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbULWMgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 07:36:48 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:39825 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261175AbULWMgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 07:36:44 -0500
Subject: Re: [PATCH 2.4] Fix rlimit check in precheck_file_write()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jason Uhlenkott <jasonuhl@sgi.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041222215759.GA217560@dragonfly.engr.sgi.com>
References: <20041222215759.GA217560@dragonfly.engr.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103801367.13188.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 23 Dec 2004 11:29:33 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-12-22 at 21:57, Jason Uhlenkott wrote:
> Remove a broken assumption that rlimits are 32 bits which can cause
> nasty things to happen on 64-bit machines if we try to write past the
> 2^32-1th character of a file and a larger file size limit exists.
> 
> Signed-off-by: Jason Uhlenkott <jasonuhl@sgi.com>
> 
> --- linux-2.4.29-pre3.orig/mm/filemap.c	2004-11-17 03:54:22.000000000 -0800
> +++ linux-2.4.29-pre3/mm/filemap.c	2004-12-22 13:41:46.000000000 -0800
> @@ -3088,9 +3088,9 @@
>  			send_sig(SIGXFSZ, current, 0);
>  			goto out;
>  		}
> -		if (pos > 0xFFFFFFFFULL || *count > limit - (u32)pos) {
> +		if (*count > limit - pos) {
>  			/* send_sig(SIGXFSZ, current, 0); */
> -			*count = limit - (u32)pos;
> +			*count = limit - pos;
>  		}

Are you sure this is safe for all conceivable 32bit cases as well as
your 64bit one ? I don't think it is looking at the overflow cases in
the if that you removed checking of.

Alan

