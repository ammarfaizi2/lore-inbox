Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWJJRMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWJJRMy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 13:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbWJJRMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 13:12:54 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:44203 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1750989AbWJJRMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 13:12:53 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Subject: Re: [PATCH 2/5] fdtable: Make fdarray and fdsets equal in size.
Date: Tue, 10 Oct 2006 19:12:56 +0200
User-Agent: KMail/1.9.4
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200610052151.04490.vlobanov@speakeasy.net>
In-Reply-To: <200610052151.04490.vlobanov@speakeasy.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610101912.56280.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 October 2006 06:51, Vadim Lobanov wrote:

> -	nfds = max_t(int, 8 * L1_CACHE_BYTES, roundup_pow_of_two(nr + 1));
> -	if (nfds > NR_OPEN)
> -		nfds = NR_OPEN;
> -
> -  	new_openset = alloc_fdset(nfds);
> -  	new_execset = alloc_fdset(nfds);
> -  	if (!new_openset || !new_execset)
> -  		goto out;
> -	fdt->open_fds = new_openset;
> -	fdt->close_on_exec = new_execset;
> -	fdt->max_fdset = nfds;
> -
>  	nfds = NR_OPEN_DEFAULT;
>  	/*
>  	 * Expand to the max in easy steps, and keep expanding it until
> @@ -271,15 +254,21 @@ static struct fdtable *alloc_fdtable(int
>  				nfds = NR_OPEN;
>    		}
>  	} while (nfds <= nr);

If I understand well, we may allocate very small fdset, while previous minimum 
size was L1_CACHE_BYTES bytes. (512 bits for a 64 bytes cache line)

If you check commit 0c9e63fd38a2fb2181668a0cdd622a3c23cfd567, 
(http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=0c9e63fd38a2fb2181668a0cdd622a3c23cfd567 ) 
you'll find this comment of mine :

3) Reduce size of allocated fdset.  Currently two full pages are
   allocated, that is 32768 bits on x86 for example, and way too much.  The
   minimum is now L1_CACHE_BYTES.

This minimum is mandatory to be sure two tasks wont share the same cache line 
to store their fdset (and possibly do lot of cache line ping pongs)

Eric

