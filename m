Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbUDPVfa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbUDPVdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:33:25 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33545 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263829AbUDPVct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:32:49 -0400
Date: Fri, 16 Apr 2004 22:32:44 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dave Jones <davej@redhat.com>, trond.myklebust@fys.uio.no,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS thinko
Message-ID: <20040416223244.G29820@flint.arm.linux.org.uk>
Mail-Followup-To: Dave Jones <davej@redhat.com>, trond.myklebust@fys.uio.no,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040416211628.GM20937@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040416211628.GM20937@redhat.com>; from davej@redhat.com on Fri, Apr 16, 2004 at 10:16:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 10:16:28PM +0100, Dave Jones wrote:
> Dereferencing 'exp' before the check for NULL.

Hmm.  If we're referencing 'ek' to get at exp, 'ek' isn't an error,
so it shouldn't be passed into PTR_ERR().

> --- linux-2.6.5/include/linux/nfsd/export.h~	2004-04-16 22:13:28.000000000 +0100
> +++ linux-2.6.5/include/linux/nfsd/export.h	2004-04-16 22:14:21.000000000 +0100
> @@ -118,13 +118,15 @@
>  	if (ek && !IS_ERR(ek)) {
>  		struct svc_export *exp = ek->ek_export;
>  		int err;
> +		if (!exp)
> +			goto out;
>  		cache_get(&exp->h);
>  		expkey_put(&ek->h, &svc_expkey_cache);
> -		if (exp &&
> -		    (err = cache_check(&svc_export_cache, &exp->h, reqp)))
> +		if (err = cache_check(&svc_export_cache, &exp->h, reqp))
>  			exp = ERR_PTR(err);
>  		return exp;
>  	} else
> +out:
>  		return ERR_PTR(PTR_ERR(ek));
>  }

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
