Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751583AbWHSXsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbWHSXsl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 19:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWHSXsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 19:48:41 -0400
Received: from 1wt.eu ([62.212.114.60]:37904 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1750799AbWHSXsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 19:48:40 -0400
Date: Sun, 20 Aug 2006 01:48:06 +0200
From: Willy Tarreau <w@1wt.eu>
To: Solar Designer <solar@openwall.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] getsockopt() early argument sanity checking
Message-ID: <20060819234806.GB27115@1wt.eu>
References: <20060819230532.GA16442@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060819230532.GA16442@openwall.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 03:05:32AM +0400, Solar Designer wrote:
> Willy,
> 
> I propose the attached patch (extracted from 2.4.33-ow1) for inclusion
> into 2.4.34-pre.
> 
> (2.6 kernels could benefit from the same change, too, but at the moment
> I am dealing with proper submission of generic changes like this that
> are a part of 2.4.33-ow1.)
> 
> The patch makes getsockopt(2) sanity-check the value pointed to by
> the optlen argument early on.  This is a security hardening measure
> intended to prevent exploitation of certain potential vulnerabilities in
> socket type specific getsockopt() code on UP systems.
> 
> This change has been a part of -ow patches for some years.

looks valid to me, merged.

Thanks Alexander !
Willy


> Thanks,
> 
> -- 
> Alexander Peslyak <solar at openwall.com>
> GPG key ID: B35D3598  fp: 6429 0D7E F130 C13E C929  6447 73C3 A290 B35D 3598
> http://www.openwall.com - bringing security into open computing environments

> diff -urpPX nopatch linux-2.4.33/net/socket.c linux/net/socket.c
> --- linux-2.4.33/net/socket.c	Wed Jan 19 17:10:14 2005
> +++ linux/net/socket.c	Sat Aug 12 08:51:47 2006
> @@ -1307,10 +1307,18 @@ asmlinkage long sys_setsockopt(int fd, i
>  asmlinkage long sys_getsockopt(int fd, int level, int optname, char *optval, int *optlen)
>  {
>  	int err;
> +	int len;
>  	struct socket *sock;
>  
>  	if ((sock = sockfd_lookup(fd, &err))!=NULL)
>  	{
> +		/* XXX: insufficient for SMP, but should be redundant anyway */
> +		if (get_user(len, optlen))
> +			err = -EFAULT;
> +		else
> +		if (len < 0)
> +			err = -EINVAL;
> +		else
>  		if (level == SOL_SOCKET)
>  			err=sock_getsockopt(sock,level,optname,optval,optlen);
>  		else

