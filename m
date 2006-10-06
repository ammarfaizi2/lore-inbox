Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422938AbWJFUf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422938AbWJFUf0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422939AbWJFUf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:35:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6342 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422938AbWJFUfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:35:24 -0400
Date: Fri, 6 Oct 2006 13:35:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Amol Lad <amol@verismonetworks.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] ioremap balanced with iounmap for
 drivers/char/epca.c
Message-Id: <20061006133516.c5cbf43b.akpm@osdl.org>
In-Reply-To: <1160110625.19143.83.camel@amol.verismonetworks.com>
References: <1160110625.19143.83.camel@amol.verismonetworks.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Oct 2006 10:27:05 +0530
Amol Lad <amol@verismonetworks.com> wrote:

> ioremap must be balanced by an iounmap and failing to do so can result
> in a memory leak.
> 
> Tested (compilation only):
> - using allmodconfig
> - making sure the files are compiling without any warning/error due to
> new changes
> 
> Signed-off-by: Amol Lad <amol@verismonetworks.com>
> ---
>  epca.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletion(-)
> ---
> diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/drivers/char/epca.c linux-2.6.19-rc1/drivers/char/epca.c
> --- linux-2.6.19-rc1-orig/drivers/char/epca.c	2006-10-05 14:00:42.000000000 +0530
> +++ linux-2.6.19-rc1/drivers/char/epca.c	2006-10-05 14:50:00.000000000 +0530
> @@ -1474,8 +1474,11 @@ static void post_fep_init(unsigned int c
>  	if ((bd->type == PCXEVE || bd->type == PCXE) && (readw(memaddr + XEPORTS) < 3))
>  		shrinkmem = 1;
>  	if (bd->type < PCIXEM)
> -		if (!request_region((int)bd->port, 4, board_desc[bd->type]))
> +		if (!request_region((int)bd->port, 4, board_desc[bd->type])) {
> +			iounmap(bd->re_map_membase);
> +			bd->re_map_membase = NULL;
>  			return;		
> +		}
>  	memwinon(bd, 0);
>  

I think this will do the wrong thing if (bd->type >= PCIXEM).  Maybe it's
OK, but it's not immediately obvious from a quick reading.

I'm quite worried about changes in crufty old drivers like these - if we
break them, the breakage will take a *long* time to be discovered.  Too
late for us to fix them.

Plus a lot of them are just plain badly coded, so extra care is needed to
understand the tricks which they're playing.
