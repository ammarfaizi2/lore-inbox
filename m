Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbWH1LAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWH1LAT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 07:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWH1LAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 07:00:19 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:58775 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S964804AbWH1LAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 07:00:16 -0400
Date: Mon, 28 Aug 2006 19:00:03 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] select_bad_process: cleanup 'releasing' check
Message-ID: <20060828150003.GA6321@oleg>
References: <20060827182538.GA1779@oleg> <20060828104459.GA14010@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060828104459.GA14010@wotan.suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28, Nick Piggin wrote:
>
> On Sun, Aug 27, 2006 at 10:25:38PM +0400, Oleg Nesterov wrote:
> > 
> > -		releasing = test_tsk_thread_flag(p, TIF_MEMDIE) ||
> > -						p->flags & PF_EXITING;
> > -		if (releasing) {
> > -			if (p->flags & PF_EXITING && p == current) {
> > -				chosen = p;
> > -				*ppoints = ULONG_MAX;
> > -				break;
> > -			}
> > -			return ERR_PTR(-1UL);
> > -		}
> > +		if ((p->flags & PF_EXITING) && p == current) {
> > +			chosen = p;
> > +			*ppoints = ULONG_MAX;
> > +			break;
> > +		}
> > +		if ((p->flags & PF_EXITING) ||
> > +				test_tsk_thread_flag(p, TIF_MEMDIE))
> > +			return ERR_PTR(-1UL);
> > +
> 
> Hmm, actually I think I spot a bug in the original logic: we don't want
> to have more than 1 task with TIF_MEMDIE at once, becaues that gives it
> access to memory reserves (but I saw it first in the new formulation, so
> maybe that does suggest it is more readable ;)
> 
> What I think should be done is the check for TIF_MEMDIE (and return -1)
> first, and then the PF_EXITING test. At which point, if current is found to
> be exiting, it should be chosen but not break... that way a subsequent MEMDIE
> or EXITING task has the chance to trigger the -1 return.

Aha! The logic looked somewhat strange to me, but ...

> Anyway, if you don't want to do all that, I will when my hand gets better.

I have little understanding of this magic, i'd better not to try to fix it.

> Otherwise the 3 patches you sent look good, they could all have an
> 
> Acked-by: Nick Piggin <npiggin@suse.de>

Thanks!

Oleg.

