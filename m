Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbVLaOVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbVLaOVu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 09:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVLaOVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 09:21:50 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:14092 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932277AbVLaOVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 09:21:50 -0500
Date: Sat, 31 Dec 2005 15:18:41 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Al Boldi <a1426z@gawab.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, barryn@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] strict VM overcommit accounting for 2.4.32/2.4.33-pre1
Message-ID: <20051231141841.GA5879@w.ods.org>
References: <200512302306.28667.a1426z@gawab.com> <200512310759.02962.a1426z@gawab.com> <20051231073817.GZ15993@alpha.home.local> <200512311702.20525.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512311702.20525.a1426z@gawab.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2005 at 05:02:20PM +0300, Al Boldi wrote:
> Willy Tarreau wrote:
(...)
> > As shown in my previous mail, it allows malloc() to return NULL. I've
> > also successfully verified that it allows mmap() to fail if there is
> > not enough memory. I disabled swap, and set the overcommit_ratio to 95
> > and could not kill the system. Above this, it becomes tricky. At 97, I
> > see the last malloc() calls take a very long time, and at 98, the
> > system still hangs. But 95% without swap seems stable here.
> 
> Thanks, for confirming this!  And I agree that this patch and 2.6 offer an 
> important and necessary workaround to inhibit OOM-killer, but it's no more 
> than a workaround.
> 
> And so the question remains:  Why should overcommit come into play at all 
> when dealing with physical RAM only?

It is very important when you have many processes wasting lots of unused
memory. For instance, when firefox allocates 10 MB and uses only 3, then
the remaining 7 MB can be used by another process. But if finally firefox
tries to use them, and there is no memory left, then chances are that some
processes will be killed. I believe the same problem happens after a fork()
because data gets COWed but I'm not certain about this.

I'd bet that using a heavy GUI under X with no swap an overcommit_ratio
set around 95%, you could get occasionnal malloc() failures. But once
again, I may be wrong.

> Shouldn't it be possible to disable overcommit completely, thus giving kswapd 
> a break from running wild trying to find something to swap/page, which is 
> the reason why the system gets unstable going over 95% in your example.

I think it's going unstable above 95% because there are lots of other
areas consuming memory. I don't know for example if dentry caches,
network buffers, various hash tables, etc... are accounted for.

> Thanks!
> 
> --
> Al

Willy

