Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbWAIR6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbWAIR6a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbWAIR63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:58:29 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:64188 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1030227AbWAIR61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:58:27 -0500
Message-ID: <43C2B624.C70A4D6E@tv-sign.ru>
Date: Mon, 09 Jan 2006 22:14:44 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       vatsa@in.ibm.com
Subject: Re: [PATCH 5/5][RFC] rcu: start new grace period from rcu_pending()
References: <43C165D7.6EAB8E47@tv-sign.ru> <43C27417.AA1BA306@tv-sign.ru> <20060109173656.GC14738@us.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" wrote:
> 
> On Mon, Jan 09, 2006 at 05:32:55PM +0300, Oleg Nesterov wrote:
> > Oleg Nesterov wrote:
> > >
> > > I think it is better to set ->qs_pending = 1 directly in __rcu_pending():
> >
> > This patch has a bug. I am sending a trivial fix, but now I am not
> > sure myself that 1 timer tick saved worth the code uglification.
> 
> This is indeed an accident waiting to happen -- someone is bound to
> replace the "|" with an "||", a change that is too easy for someone
> to miss.  Once Vatsa is satisfied with the CPU-hotplug aspects of
> this set of patches, if __rcu_pending() still has side-effects, I would
> suggest something like the following:
> 
>         int rcu_pending(int cpu)
>         {
>                 int retval = 0;
> 
>                 if (__rcu_pending(&rcu_ctrlblk, &per_cpu(rcu_data, cpu)))
>                         retval = 1;
>                 if (__rcu_pending(&rcu_bh_ctrlblk, &per_cpu(rcu_bh_data, cpu)))
>                         retval = 1;
>                 return retval;
>         }
> 
> A few more lines, but the intent is much more clear.  And I bet that
> gcc generates reasonable code in either case.
> 
> Or maybe this is just me...

No, me too. For some reasons I can't re-send the patch today, will do
tomorrow.

However, I am not sure anymore that this patch is a good idea. Exactly
because it adds side-effects to rcu_pending().

So, unless somebody on CC: list thinks it may be useful - let's forget
it.

Oleg.
