Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263118AbRFJCRQ>; Sat, 9 Jun 2001 22:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264497AbRFJCRG>; Sat, 9 Jun 2001 22:17:06 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52272 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S264496AbRFJCQz>; Sat, 9 Jun 2001 22:16:55 -0400
To: "Bulent Abali" <abali@us.ibm.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Mike Galbraith <mikeg@wen-online.de>,
        Derek Glidden <dglidden@illusionary.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: Please test: workaround to help swapoff behaviour
In-Reply-To: <OF2FF3269C.90D4688C-ON85256A66.006DEAFA@pok.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Jun 2001 20:12:54 -0600
In-Reply-To: <OF2FF3269C.90D4688C-ON85256A66.006DEAFA@pok.ibm.com>
Message-ID: <m1ofrx2ic9.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bulent Abali" <abali@us.ibm.com> writes:

> >Bulent,
> >
> >Could you please check if 2.4.6-pre2+the schedule patch has better
> >swapoff behaviour for you?
> 
> Marcelo,
> 
> It works as expected.  Doesn't lockup the box however swapoff keeps burning
> the CPU cycles.  It took 4 1/2 minutes to swapoff about 256MB of swap
> content.  Shutdown took just as long.  I was hoping that shutdown would
> kill the swapoff process but it doesn't.  It just hangs there.  Shutdown
> is the common case.  Therefore, swapoff needs to be optimized for
> shutdowns.
> You could imagine users frustration waiting for a shutdown when there are
> gigabytes in the swap.
> 
> So to summarize, schedule patch is better than nothing but falls far short.
> I would put it in 2.4.6.  Read on.

The fix is to kill the dead/orphaned swap pages before we get to
swapoff.  At shutdown time there is practically nothing active in
swap, so this should speed things up tremendously.  The dead swap
pages need to be killed as soon as possible to keep us from wasting
RAM and swap, and totally agravating whatever swapping situation is
present.

Once the dead swap pages problem is fixed it is time to optimize
swapoff.  

> ----------
> 
> The problem is with the try_to_unuse() algorithm which is very inefficient.
> I searched the linux-mm archives and Tweedie was on to this. This is what
> he wrote:  "it is much cheaper to find a swap entry for a given page than
> to find the swap cache page for a given swap entry." And he posted a
> patch http://mail.nl.linux.org/linux-mm/2001-03/msg00224.html
> His patch is in the Redhat 7.1 kernel 2.4.2-2 and not in 2.4.5.

> 
> But in any case I believe the patch will not work as expected.
> It seems to me that he is calling the function check_orphaned_swap(page)
> in the wrong place.  He is calling the function while scanning the
> active_list in refill_inactive_scan().  The problem with that is if you
> wait
> 60 seconds or longer the orphaned swap pages will move from active
> to inactive lists. Therefore the function will miss the orphans in inactive
> lists.  Any comments?

The analysis sounds about right.  

We should be killing most of these pages in free_pte.  Or at the very
least putting them on their own list that we can scan them
effectively.  Someone was creating a patch to that effect earlier.

try_to_unuse is inefficient with respect to cpu usage but it is
efficient with respect to swap usage.  If you are doing this on a
running machine where you are removing a swap you don't want an
algorithm that increases your need for swap.  All of the trivial
transformations of try_to_unuse have the property of breaking the
sharing of swap pages.  


Eric

