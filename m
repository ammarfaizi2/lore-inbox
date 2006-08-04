Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbWHDAFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbWHDAFZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 20:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbWHDAFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 20:05:25 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:16092 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030240AbWHDAFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 20:05:24 -0400
Subject: Re: [PATCH] memory hotadd fixes [2/5] change
	find_next_system_ram's return value manner
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       lhms-devel <lhms-devel@lists.sourceforge.net>,
       "y-goto@jp.fujitsu.com" <y-goto@jp.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060803123322.baa6877b.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060803123322.baa6877b.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Thu, 03 Aug 2006 17:05:21 -0700
Message-Id: <1154649921.5925.40.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-03 at 12:33 +0900, KAMEZAWA Hiroyuki wrote:
> find_next_system_ram() returns valid memory range which meets requested
> area, only used by memory-hot-add.
> This function always rewrite requested resource even if returned area is
> not fully fit in requested one. And sometimes the returnd resource is larger
> than requested area. This annoyes the caller.
> This patch changes the returned value to fit in requested area.
> 
> Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> 
>  kernel/resource.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6.18-rc3/kernel/resource.c
> ===================================================================
> --- linux-2.6.18-rc3.orig/kernel/resource.c	2006-08-01 16:11:56.000000000 +0900
> +++ linux-2.6.18-rc3/kernel/resource.c	2006-08-01 16:38:45.000000000 +0900
> @@ -261,8 +261,10 @@
>  	if (!p)
>  		return -1;
>  	/* copy data */
> -	res->start = p->start;
> -	res->end = p->end;
> +	if (res->start < p->start)
> +		res->start = p->start;
> +	if (res->end > p->end)
> +		res->end = p->end;
>  	return 0;
>  }
>  #endif


This is a needed fix for me.  It looks and works great on x86_64. 

Acked-By: Keith Mannthey <kmannth@us.ibm.com>

