Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262141AbUJZEqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbUJZEqX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 00:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbUJZBic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:38:32 -0400
Received: from zeus.kernel.org ([204.152.189.113]:985 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262096AbUJZBYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:24:04 -0400
Message-ID: <417D7BF7.2010009@free.fr>
Date: Tue, 26 Oct 2004 00:19:35 +0200
From: Remi Colinet <remi.colinet@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-mm1-V0.2
References: <417D7799.8080307@free.fr>
In-Reply-To: <417D7799.8080307@free.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remi Colinet wrote:

> Hi ,
>
> Patch needed, when CONFIG_HOTPLUG_CPU is enabled, in order to fix a 
> compile error.
>
> --- mm/swap.c.orig      2004-10-22 22:31:58.000000000 +0200
> +++ mm/swap.c   2004-10-22 23:10:44.202728352 +0200
> @@ -423,12 +423,12 @@
> #ifdef CONFIG_HOTPLUG_CPU
> static void lru_drain_cache(unsigned int cpu)
> {
> -       struct pagevec *pvec = &per_cpu(lru_add_pvecs, cpu);
> +       struct pagevec *pvec = &per_cpu_var_locked(lru_add_pvecs, cpu);
>
>       /* CPU is dead, so no locking needed. */
>       if (pagevec_count(pvec))
>               __pagevec_lru_add(pvec);
> -       pvec = &per_cpu(lru_add_active_pvecs, cpu);
> +       pvec = &per_cpu_var_locked(lru_add_active_pvecs, cpu);
>       if (pagevec_count(pvec))
>               __pagevec_lru_add_active(pvec);
> }
>
> Otherwise, I get :
>
>  CC      mm/swap.o
> mm/swap.c: In function `lru_drain_cache':
> mm/swap.c:426: `per_cpu__lru_add_pvecs' undeclared (first use in this 
> function)
> mm/swap.c:426: (Each undeclared identifier is reported only once
> mm/swap.c:426: for each function it appears in.)
> mm/swap.c:426: warning: type defaults to `int' in declaration of `type 
> name'
> mm/swap.c:426: invalid type argument of `unary *'
> mm/swap.c:431: `per_cpu__lru_add_active_pvecs' undeclared (first use 
> in this function)
> mm/swap.c:431: warning: type defaults to `int' in declaration of `type 
> name'
> mm/swap.c:431: invalid type argument of `unary *'
> make[1]: *** [mm/swap.o] Error 1
> make: *** [mm] Error 2

This patch is also needed when CONFIG_HOTPLUG_CPU is enabled 
(fork.c:line 1412, uses takeover_tasklets)

--- kernel/softirq.c.orig       2004-10-26 00:04:51.000000000 +0200
+++ kernel/softirq.c    2004-10-26 00:05:03.000000000 +0200
@@ -464,7 +464,7 @@
        BUG();
 }
 
-static void takeover_tasklets(unsigned int cpu)
+void takeover_tasklets(unsigned int cpu)
 {
        struct tasklet_struct **i;
 

Remi
