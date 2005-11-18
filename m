Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160999AbVKRRos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160999AbVKRRos (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 12:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161004AbVKRRos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 12:44:48 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:45277 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1160999AbVKRRor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 12:44:47 -0500
Date: Fri, 18 Nov 2005 18:44:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: david singleton <dsingleton@mvista.com>
Cc: Dinakar Guniguntala <dino@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: PI BUG with -rt13
Message-ID: <20051118174454.GA2793@elte.hu>
References: <20051117161817.GA3935@in.ibm.com> <437D0C59.1060607@mvista.com> <20051118092909.GC4858@elte.hu> <20051118132137.GA5639@in.ibm.com> <20051118132715.GA3314@elte.hu> <8311ADE9-5855-11DA-BBAB-000A959BB91E@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8311ADE9-5855-11DA-BBAB-000A959BB91E@mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.4 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* david singleton <dsingleton@mvista.com> wrote:

> >both rt_mutex_free() and rt_mutex_set_owner() must be called with the
> >proper locking. David?
> 
>         Yes, the lock  needs to be protected by the robust semaphore.
>         The locking order is:
> 
>                 mmap_sem to protect the vma that holds the pthread_mutex
> 
>                 robust_sem to protect the futex_mutex chain.
> 
>                 futex_mutex - the rt_mutex associated with the 
> pthread_mutex.

well, also lock->wait_lock and lock->pi_lock. The act of making another 
thread the owner of this particular mutex must be performed carefully.  
Check out rt.c to see what locking dependencies there are. (We can also 
do a lockless cmpxchg for unlocked mutexes, under certain 
circumstances.)

	Ingo
