Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265683AbUABWmN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 17:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265690AbUABWmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 17:42:13 -0500
Received: from mail.shareable.org ([81.29.64.88]:55180 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S265683AbUABWmL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 17:42:11 -0500
Date: Fri, 2 Jan 2004 22:41:50 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] use rcu for fasync_lock
Message-ID: <20040102224150.GA5864@mail.shareable.org>
References: <3FE492EF.2090202@colorfullife.com> <20031221113640.GF3438@mail.shareable.org> <3FE594D0.8000807@colorfullife.com> <20031221141456.GI3438@mail.shareable.org> <3FF5DF59.3090905@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF5DF59.3090905@tmr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> Jamie Lokier wrote:
> >We have found the performance impact of the extra ->poll calls
> >negligable with epoll.  They're simply not slow calls.  It's
> >only when you're doing select() or poll() of many descriptors
> >repeatedly that you notice, and that's already poor usage in other
> >ways.
> 
> I do agree with you, but there is a lot of old software, and software 
> written on/for BSD, which does do this. I'm not prepared to say that BSD 
> does it better, but it's easier to fix in one place, the kernel, than 
> many other places.
> 
> Your point about the complexity is also correct, but perhaps someone 
> will offer a better solution to speeding up select(). I think anything 
> as major as this might be better off in a development series, and that's 
> a clear prod for someone to find a simpler way to do it ;-)

Eliminating up to half of the ->poll calls using wake_up_info() and
reducing the number of wakeups using an event mask argument to ->poll
are not the best ways to speed up select() or poll() for large numbers
of descriptors.

The best way is to maintain poll state in each "struct file".  The
order of complexity for the bitmap scan is still significant, but
->poll calls are limited to the number of transitions which actually
happen.

I think somebody, maybe Richard Gooch, has a patch to do this that's
several years old by now.

-- Jamie
