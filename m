Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWFMVWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWFMVWg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 17:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWFMVWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 17:22:36 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:19035 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S932262AbWFMVWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 17:22:36 -0400
Message-ID: <448F2C97.2090103@tls.msk.ru>
Date: Wed, 14 Jun 2006 01:22:31 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
CC: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] constify sched.c stat_nam strings
References: <20060613195509.GF24167@rhlx01.fht-esslingen.de>
In-Reply-To: <20060613195509.GF24167@rhlx01.fht-esslingen.de>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr wrote:
> Hi all,
> 
> Signed-off-by: Andreas Mohr <andi@lisas.de>
> 
> 
> diff -urN linux-2.6.17-rc6-mm2.orig/kernel/sched.c linux-2.6.17-rc6-mm2.my/kernel/sched.c
> --- linux-2.6.17-rc6-mm2.orig/kernel/sched.c	2006-06-13 19:28:17.000000000 +0200
> +++ linux-2.6.17-rc6-mm2.my/kernel/sched.c	2006-06-13 19:32:03.000000000 +0200
> @@ -4662,7 +4662,7 @@
>  	task_t *relative;
>  	unsigned state;
>  	unsigned long free = 0;
> -	static const char *stat_nam[] = { "R", "S", "D", "T", "t", "Z", "X" };
> +	static const char * const stat_nam[] = { "R", "S", "D", "T", "t", "Z", "X" };
>  
>  	printk("%-13.13s ", p->comm);
>  	state = p->state ? __ffs(p->state) + 1 : 0;

How about the following instead:

--- kernel/sched.c.orig 2006-05-31 22:23:53.000000000 +0400
+++ kernel/sched.c      2006-06-14 01:19:17.000000000 +0400
@@ -5287,14 +5287,11 @@ static void show_task(task_t *p)
 	task_t *relative;
 	unsigned state;
 	unsigned long free = 0;
-	static const char *stat_nam[] = { "R", "S", "D", "T", "t", "Z", "X" };
+	static const char stat_nam[] = "RSDTtZX";

-	printk("%-13.13s ", p->comm);
 	state = p->state ? __ffs(p->state) + 1 : 0;
-	if (state < ARRAY_SIZE(stat_nam))
-		printk(stat_nam[state]);
-	else
-		printk("?");
+	printk("%-13.13s %c", p->comm,
+		state < sizeof(stat_nam) - 1 ? stat_nam[state] : '?');
 #if (BITS_PER_LONG == 32)
 	printk(" %08lX ", (unsigned long)p);
 #else

?

/mjt
