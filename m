Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264659AbUEVClP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264659AbUEVClP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 22:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264633AbUEVClP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 22:41:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:1453 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264659AbUEVCkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 22:40:16 -0400
X-Authenticated: #18147109
From: Gerald Schaefer <gerald.schaefer@gmx.net>
Reply-To: gerald.schaefer@gmx.net
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH] shrink hash sizes on small machines, take 2
Date: Wed, 19 May 2004 19:40:03 +0200
User-Agent: KMail/1.6.2
References: <200405181432.24895.gerald.schaefer@gmx.net> <20040518174210.GD28735@waste.org>
In-Reply-To: <20040518174210.GD28735@waste.org>
Cc: akpm@osdl.org, arnd@arndb.de, schwidefsky@de.ibm.com,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405191940.03273.gerald.schaefer@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 May 2004 19:42, you wrote:
> num_physpages should represent the memory available to the kernel for
> normal use and should not reflect any other reserved memory. Otherwise
> it'll unduly influence the hash sizes both with and without this
> patch.
This is a very good point, Arnd and I have been looking at our "mem=" hack
and it does look a little bit fishy...
There are possibly more things affected in the s390 kernel with "mem="
parameter, not only num_physpages (max_low_pfn, etc.), so we will have to
take a closer look and see what Martin thinks about it.

> Index: mm/fs/dcache.c
> ===================================================================
> --- mm.orig/fs/dcache.c       2004-05-18 12:29:28.000000000 -0500
> +++ mm/fs/dcache.c    2004-05-18 12:37:42.000000000 -0500
> @@ -1625,7 +1625,7 @@
>       /* Base hash sizes on available memory, with a reserve equal to
>             150% of current kernel size */
>  
> -     reserve = (mempages - nr_free_pages()) * 3/2;
> +     reserve = min((mempages - nr_free_pages()) * 3/2, mempages - 1);
>       mempages -= reserve;
>  
>       names_cachep = kmem_cache_create("names_cache",
This patch is o.k. for us, in our case (with "mem=") it would more or less
restore the previous situation (without the calculation, but still with a
potential memory problem on our side)

--
Gerald
