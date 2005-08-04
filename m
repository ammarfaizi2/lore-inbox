Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbVHDJjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbVHDJjS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 05:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbVHDJjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 05:39:18 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:3734 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262453AbVHDJjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 05:39:17 -0400
Date: Thu, 4 Aug 2005 11:38:33 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Nishanth Aravamudan <nacc@us.ibm.com>
cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: Re: [PATCH] push rounding up of relative request to schedule_timeout()
In-Reply-To: <20050804005147.GC4255@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0508041123220.3728@scrub.home>
References: <1122123085.3582.13.camel@localhost.localdomain>
 <Pine.LNX.4.61.0507231456000.3728@scrub.home> <20050723164310.GD4951@us.ibm.com>
 <Pine.LNX.4.61.0507231911540.3743@scrub.home> <20050723191004.GB4345@us.ibm.com>
 <Pine.LNX.4.61.0507232151150.3743@scrub.home> <20050727222914.GB3291@us.ibm.com>
 <Pine.LNX.4.61.0507310046590.3728@scrub.home> <20050801193522.GA24909@us.ibm.com>
 <Pine.LNX.4.61.0508031419000.3728@scrub.home> <20050804005147.GC4255@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andrew, please drop this patch. 
Nish, please stop fucking around with kernel APIs.

On Wed, 3 Aug 2005, Nishanth Aravamudan wrote:

> > The "jiffies_to_msecs(msecs_to_jiffies(timeout_msecs) + 1)" case (when the 
> > process is immediately woken up again) makes the caller suspectible to 
> > timeout manipulations and requires constant reauditing, that no caller 
> > gets it wrong, so it's better to avoid this error source completely.

Nish, did you read this? Is my English this bad?

> --- 2.6.13-rc5/kernel/timer.c	2005-08-01 12:31:53.000000000 -0700
> +++ 2.6.13-rc5-dev/kernel/timer.c	2005-08-03 17:30:10.000000000 -0700
> @@ -1134,7 +1134,7 @@ fastcall signed long __sched schedule_ti
>  		}
>  	}
>  
> -	expire = timeout + jiffies;
> +	expire = timeout + jiffies + 1;
>  
>  	init_timer(&timer);
>  	timer.expires = expire;

And a little later it does:

	timeout = expire - jiffies;

which means callers can get back a larger timeout.
Nish, did you check and fix _all_ users? I can easily find a number of 
users which immediately use the return value as next timeout.
There are _a_lot_ of schedule_timeout(1) for small busy loops, these are 
asking for "please schedule until next tick". Did you check that these are 
still ok?
schedule_timeout() is arguably a broken API, but can we please _first_ 
come up with a plan to fix this, before we break even more?

bye, Roman
