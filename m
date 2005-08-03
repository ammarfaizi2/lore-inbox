Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbVHCJPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbVHCJPR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 05:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbVHCJNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 05:13:23 -0400
Received: from ns1.suse.de ([195.135.220.2]:15493 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262178AbVHCJNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 05:13:18 -0400
Date: Wed, 3 Aug 2005 11:13:13 +0200
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] MM, NUMA : sys_set_mempolicy() doesnt check if mode < 0
Message-ID: <20050803091313.GM10895@wotan.suse.de>
References: <20050728011540.GA23923@localhost.localdomain> <20050727182445.52be6000.akpm@osdl.org> <20050729074647.GC3726@bragg.suse.de> <42EE9D1B.108@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EE9D1B.108@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2005 at 12:07:23AM +0200, Eric Dumazet wrote:
> MM, NUMA : sys_set_mempolicy() doesnt check if mode < 0
> 
> A kernel BUG() is triggered by a call to set_mempolicy() with a negative 
> first argument.
> This is because the mode is declared as an int, and the validity check 
> doesnt check < 0 values.
> Alternatively, mode could be declared as unsigned int or unsigned long.

Thanks looks good. Andrew, can you apply that one?

-Andi

> 
> Thank you
> Eric
> ---------------------------------
> Test program for x86_64:
> ---------------------------------
> #include <unistd.h>
> #include <stdio.h>
> #include <errno.h>
> #include <linux/unistd.h>
> 
> #define __NR_set_mempolicy      238
> #define __sys_set_mempolicy(mode, nmask, maxnode) _syscall3(int, 
> set_mempolicy, int, mode, unsigned long *, nmask, unsigned long, maxnode)
> static __sys_set_mempolicy(mode, nmask, maxnode)
> 
> unsigned long nodes = 3;
> 
> int main()
> {
> int ret = set_mempolicy(-6, &nodes, 2);
> printf("result=%d errno=%d\n", ret, errno);
> return 0;
> }
> 
> 
> Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>
> 

> --- linux-2.6.13-rc4/mm/mempolicy.c	2005-07-29 00:44:44.000000000 +0200
> +++ linux-2.6.13-rc4-ed/mm/mempolicy.c	2005-08-01 23:52:43.000000000 +0200
> @@ -443,7 +443,7 @@
>  	struct mempolicy *new;
>  	DECLARE_BITMAP(nodes, MAX_NUMNODES);
>  
> -	if (mode > MPOL_MAX)
> +	if ((unsigned int)mode > MPOL_MAX)
>  		return -EINVAL;
>  	err = get_nodes(nodes, nmask, maxnode, mode);
>  	if (err)

