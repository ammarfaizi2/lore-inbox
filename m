Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVCUKRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVCUKRY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 05:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbVCUKRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 05:17:23 -0500
Received: from cmailm1.svr.pol.co.uk ([195.92.193.18]:47628 "EHLO
	cmailm1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S261418AbVCUKRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 05:17:16 -0500
Message-Id: <200503211017.j2LAH7r04610@blake.inputplus.co.uk>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] don't do pointless NULL checks and casts before kfree() in security/ 
In-Reply-To: <Pine.LNX.4.62.0503201528290.2501@dragon.hyggekrogen.localhost> 
Date: Mon, 21 Mar 2005 10:17:06 +0000
From: Ralph Corderoy <ralph@inputplus.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jesper,

> > > the short version also have the real bennefits of generating
> > > shorter and faster code as well as being shorter "on-screen".
> > 
> > Faster code?  I'd have thought avoiding the function call outweighed
> > the overhead of checking before calling.
> 
> I haven't actually measured it, but that would be my guess from
> looking at the actual code gcc generates.
> ...
> void cond_policydb_destroy(struct policydb *p)
> {
>  220:   55                      push   %ebp
>  221:   89 e5                   mov    %esp,%ebp
>  223:   53                      push   %ebx
>  224:   89 c3                   mov    %eax,%ebx
>         if (p->bool_val_to_struct)
>  226:   8b 40 78                mov    0x78(%eax),%eax
>  229:   85 c0                   test   %eax,%eax
>  22b:   75 13                   jne    240 <cond_policydb_destroy+0x20>
>                 kfree(p->bool_val_to_struct);
>         avtab_destroy(&p->te_cond_avtab);
>  22d:   8d 43 7c                lea    0x7c(%ebx),%eax
>  230:   e8 fc ff ff ff          call   231 <cond_policydb_destroy+0x11>
>         cond_list_destroy(p->cond_list);
>  235:   8b 83 84 00 00 00       mov    0x84(%ebx),%eax
>  23b:   5b                      pop    %ebx
>  23c:   c9                      leave
>  23d:   eb c1                   jmp    200 <cond_list_destroy>
>  23f:   90                      nop
>  240:   e8 fc ff ff ff          call   241 <cond_policydb_destroy+0x21>
>  245:   8d 43 7c                lea    0x7c(%ebx),%eax
>  248:   e8 fc ff ff ff          call   249 <cond_policydb_destroy+0x29>
>  24d:   8b 83 84 00 00 00       mov    0x84(%ebx),%eax
>  253:   5b                      pop    %ebx
>  254:   c9                      leave
>  255:   eb a9                   jmp    200 <cond_list_destroy>
>  257:   89 f6                   mov    %esi,%esi
>  259:   8d bc 27 00 00 00 00    lea    0x0(%edi),%edi
> 
> [...]
> ...
> First of all that's significantly shorter, so we'll gain a bit of
> memory and I'd guess it would improve cache behaviour as well (but I
> don't know enough to say for sure).

Yes, the original's awful isn't it.  I'm used to ARM rather than x86 and
so didn't expect such bloat by having the condition.

> I'm also assuming that in the vast majority of cases (not just here,
> but all over the kernel) the pointer being tested will end up being
> !=NULL so we'll end up doing the function call in any case, so saving
> the conditional should be an overall win.

Fair enough, you've persuaded me.  Thanks for taking the time.

Cheers,


Ralph.

