Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWCQNg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWCQNg1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 08:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWCQNg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 08:36:27 -0500
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:26565 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750732AbWCQNg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 08:36:26 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] sched: activate SCHED BATCH expired
Date: Sat, 18 Mar 2006 00:36:10 +1100
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, ck@vds.kolivas.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200603081013.44678.kernel@kolivas.org> <200603172338.10107.kernel@kolivas.org> <441AB8FA.10609@yahoo.com.au>
In-Reply-To: <441AB8FA.10609@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603180036.11326.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 March 2006 00:26, Nick Piggin wrote:
> Con Kolivas wrote:
> > -static inline void __activate_task(task_t *p, runqueue_t *rq)
> > +static void __activate_task(task_t *p, runqueue_t *rq)
> >  {
> > -	enqueue_task(p, rq->active);
> > +	if (batch_task(p))
> > +		enqueue_task(p, rq->expired);
> > +	else
> > +		enqueue_task(p, rq->active);
> >  	inc_nr_running(p, rq);
> >  }
>
> I prefer:
>
>    prio_array_t *target = rq->active;
>    if (batch_task(p))
>      target = rq->expired;
>    enqueue_task(p, target);
>
> Because gcc can use things like predicated instructions for it.
> But perhaps it is smart enough these days to recognise this?
> At least in the past I have seen it start using cmov after doing
> such a conversion.
>
> At any rate, I think it looks nicer as well. IMO, of course.

Well on my one boring architecture here is a before and after, gcc 4.1.0 with 
optimise for size kernel config:
0xb01127da <__activate_task+0>: push   %ebp
0xb01127db <__activate_task+1>: mov    %esp,%ebp
0xb01127dd <__activate_task+3>: push   %esi
0xb01127de <__activate_task+4>: push   %ebx
0xb01127df <__activate_task+5>: mov    %eax,%esi
0xb01127e1 <__activate_task+7>: mov    %edx,%ebx
0xb01127e3 <__activate_task+9>: cmpl   $0x3,0x58(%eax)
0xb01127e7 <__activate_task+13>:        jne    0xb01127ee <__activate_task+20>
0xb01127e9 <__activate_task+15>:        mov    0x44(%edx),%edx
0xb01127ec <__activate_task+18>:        jmp    0xb01127f1 <__activate_task+23>
0xb01127ee <__activate_task+20>:        mov    0x40(%edx),%edx
0xb01127f1 <__activate_task+23>:        mov    %esi,%eax
0xb01127f3 <__activate_task+25>:        call   0xb01124bb <enqueue_task>
0xb01127f8 <__activate_task+30>:        incl   0x8(%ebx)
0xb01127fb <__activate_task+33>:        mov    0x18(%esi),%eax
0xb01127fe <__activate_task+36>:        add    %eax,0xc(%ebx)
0xb0112801 <__activate_task+39>:        pop    %ebx
0xb0112802 <__activate_task+40>:        pop    %esi
0xb0112803 <__activate_task+41>:        pop    %ebp
0xb0112804 <__activate_task+42>:        ret

Your version:
0xb01127da <__activate_task+0>: push   %ebp
0xb01127db <__activate_task+1>: mov    %esp,%ebp
0xb01127dd <__activate_task+3>: push   %esi
0xb01127de <__activate_task+4>: push   %ebx
0xb01127df <__activate_task+5>: mov    %eax,%esi
0xb01127e1 <__activate_task+7>: mov    %edx,%ebx
0xb01127e3 <__activate_task+9>: mov    0x40(%edx),%edx
0xb01127e6 <__activate_task+12>:        cmpl   $0x3,0x58(%eax)
0xb01127ea <__activate_task+16>:        jne    0xb01127ef <__activate_task+21>
0xb01127ec <__activate_task+18>:        mov    0x44(%ebx),%edx
0xb01127ef <__activate_task+21>:        mov    %esi,%eax
0xb01127f1 <__activate_task+23>:        call   0xb01124bb <enqueue_task>
0xb01127f6 <__activate_task+28>:        incl   0x8(%ebx)
0xb01127f9 <__activate_task+31>:        mov    0x18(%esi),%eax
0xb01127fc <__activate_task+34>:        add    %eax,0xc(%ebx)
0xb01127ff <__activate_task+37>:        pop    %ebx
0xb0112800 <__activate_task+38>:        pop    %esi
0xb0112801 <__activate_task+39>:        pop    %ebp
0xb0112802 <__activate_task+40>:        ret

I'm not attached to the style, just the feature. If you think it's warranted 
I'll change it.

Cheers,
Con
