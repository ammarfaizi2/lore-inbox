Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965204AbVIVBeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965204AbVIVBeq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 21:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965205AbVIVBeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 21:34:46 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:52871 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965204AbVIVBep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 21:34:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Yo/BN1KFoyYDgrO6C7vvURM5AAVGjlSXfeYGmEKkSUzbIPKJZoAkGjAJziXRZyf7qQfyRWPD8CWf4fgph0oosSTf+Ej2hdlF+LW4mRwkYb4ynTCmOStlx3DuUYaT9O6ZAsQvEDtSlYd6ts8Lx7md0ZbflOwJ/PFrAkOjirGxM6M=  ;
Message-ID: <433201FC.8040004@yahoo.com.au>
Date: Thu, 22 Sep 2005 10:59:40 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: dwalker@mvista.com
CC: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RT: Checks for cmpxchg in get_task_struct_rcu()
References: <1127345874.19506.43.camel@dhcp153.mvista.com>
In-Reply-To: <1127345874.19506.43.camel@dhcp153.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> Adds a check for cmpxchg in get_task_struct_rcu(), and implements the
> case when it doesn't exist.
> 

I believe this is racy.

> Signed-Off-By: Daniel Walker <dwalker@mvista.com>
> 
> Index: linux-2.6.13/include/linux/sched.h
> ===================================================================
> --- linux-2.6.13.orig/include/linux/sched.h
> +++ linux-2.6.13/include/linux/sched.h
> @@ -1026,13 +1026,21 @@ static inline int get_task_struct_rcu(st
>  {
>  	int oldusage;
>  
> +#ifdef __HAVE_ARCH_CMPXCHG
>  	do {
>  		oldusage = atomic_read(&t->usage);
>  		if (oldusage == 0) {
>  			return 0;
>  		}
>  	} while (cmpxchg(&t->usage.counter,
> -		 oldusage, oldusage + 1) != oldusage);
> +				oldusage, oldusage + 1) != oldusage);
> +#else
> +	oldusage = atomic_read(&t->usage);
> +	if (oldusage == 0) {
> +		return 0;
> +	}

What if t->usage becomes 0 here?

> +	atomic_inc(&t->usage);
> +#endif
>  	return 1;
>  }
>  

You need my atomic_cmpxchg patches that provide an atomic_cmpxchg
(and atomic_inc_not_zero) for all architectures.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
