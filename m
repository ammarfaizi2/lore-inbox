Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWBFVKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWBFVKf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 16:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWBFVKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 16:10:34 -0500
Received: from silver.veritas.com ([143.127.12.111]:25745 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750868AbWBFVKe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 16:10:34 -0500
Date: Mon, 6 Feb 2006 21:11:11 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Jean Delvare <khali@linux-fr.org>
cc: Chuck Ebbert <76306.1226@compuserv.com>, Pete Zaitcev <zaitcev@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stop ==== emergency
In-Reply-To: <20060206195504.16b60b93.khali@linux-fr.org>
Message-ID: <Pine.LNX.4.61.0602062057570.4093@goblin.wat.veritas.com>
References: <mailman.1139006040.12873.linux-kernel2news@redhat.com>
 <20060205205709.0b88171b.zaitcev@redhat.com> <Pine.LNX.4.61.0602060841540.6574@goblin.wat.veritas.com>
 <20060206195504.16b60b93.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 06 Feb 2006 21:10:33.0204 (UTC) FILETIME=[C4500B40:01C62B61]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2006, Jean Delvare wrote:
> 
> However, given that printk calls aren't exactly cheap, don't we want to
> merge them where possible?
> 
> --- linux-2.6.16-rc2.orig/arch/i386/kernel/traps.c	2006-02-06 07:50:57.000000000 +0100
> +++ linux-2.6.16-rc2/arch/i386/kernel/traps.c	2006-02-06 19:42:10.000000000 +0100
> @@ -114,8 +114,7 @@
>  
>  static void print_addr_and_symbol(unsigned long addr, char *log_lvl)
>  {
> -	printk(log_lvl);
> -	printk(" [<%08lx>] ", addr);
> +	printk("%s [<%08lx>] ", log_lvl, addr);
> ....
> 
> More merges are possible, but I'm not sure how far we want to go.

I assumed, as I guess Chuck who put in all the printk(log_lvl)s did,
that they wouldn't be deciphered right if as separate args.  But a
glance at vprintk suggests you're right, they're interpreted after
expanding into printk_buf.

But my own interest in minimizing printk calls is rather low at the
moment; and they're hardly time-critical, are they? fast paths won't
be fast if they're doing printk's, and I hope things haven't got so
bad that we need dump_stack to be fast!  Waste more space? expect so.

More important would be: how's the SMP printk behaviour these days?
Does separating log_lvl from message increase the likelihood that the
log_lvls might be misapplied if different CPUs print at the same time?
If so, then I'd say your changes are very important - but please send
them to Andrew rather than to me.

Hugh
