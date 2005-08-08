Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbVHHJGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbVHHJGF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 05:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbVHHJGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 05:06:05 -0400
Received: from mx2.elte.hu ([157.181.151.9]:48850 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S1750778AbVHHJGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 05:06:04 -0400
Date: Mon, 8 Aug 2005 11:06:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
Cc: dwalker@mvista.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] IPV4 spinlock_casting
Message-ID: <20050808090659.GA11879@elte.hu>
References: <1123466661.20677.14.camel@localhost.localdomain> <20050808090457.GA11771@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050808090457.GA11771@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > Fix a compile error in net/ipv4/route.c when RT patch is applied:
> 
> > Index: linux-2.6.13-rc4-RT-V0.7.52-14/net/ipv4/route.c
> 
> are you sure you are seeing this with the -52-14 patch? If yes then 
> please send me your .config.
> 
> the build error showed a more fundamental bug, which had to be solved 
> differently. The problem was the code in route.c, the problem was this:
> 
>  # define rt_hash_lock_addr(slot) NULL
>  # define rt_hash_lock_init()
> 
> where NULL has no type. The solution for the build problem would have 
> been to cast the NULL to spinlock_t *, but we need this spinlock so 
> the correct solution was to add a || defined(PREEMPT_RT) to the #if 
> defined(CONFIG_SMP) line above. Solving the build problem alone only 
> fixes the symptom, not the bug.

it just occured to me that !PREEMPT_RT builds would be affected by the
#else branch, so i committed the build fix below into -52-15.

	Ingo

Index: linux/net/ipv4/route.c
===================================================================
--- linux.orig/net/ipv4/route.c
+++ linux/net/ipv4/route.c
@@ -231,7 +231,7 @@ static spinlock_t	*rt_hash_locks;
 			spin_lock_init(&rt_hash_locks[i]); \
 		}
 #else
-# define rt_hash_lock_addr(slot) NULL
+# define rt_hash_lock_addr(slot) ((spinlock_t *)NULL)
 # define rt_hash_lock_init()
 #endif
 
