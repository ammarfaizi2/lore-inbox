Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317030AbSHAUS0>; Thu, 1 Aug 2002 16:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317037AbSHAUSZ>; Thu, 1 Aug 2002 16:18:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59144 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317030AbSHAUSX>; Thu, 1 Aug 2002 16:18:23 -0400
Date: Thu, 1 Aug 2002 13:21:38 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: David Howells <dhowells@redhat.com>, <alan@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: manipulating sigmask from filesystems and drivers 
In-Reply-To: <10545.1028232628@redhat.com>
Message-ID: <Pine.LNX.4.33.0208011315220.12103-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 1 Aug 2002, David Woodhouse wrote:
> 
> torvalds@transmeta.com said:
> >  They should be waiting in TASK_UNINTERRUPTIBLE, and we should add a
> > flag  to distinguish between "increases load average" and "doesn't".
> 
> The disadvantage of this approach is that it encourages people to be lazy
> and sleep with signals disabled, instead of implementing proper cleanup
> code. 
> 
> I'm more in favour of removing TASK_UNINTERRUPTIBLE entirely, or at least 
> making people apply for a special licence to be permitted to use it :)

Can't do that.

Easy reason: there are tons of code sequences that _cannot_ take signals.  
The only way to make a signal go away is to actually deliver it, and there
are documented interfaces that are guaranteed to complete without
delivering a signal. The trivial case is a disk read: real applications
break if you return partial results in order to handle signals in the
middle.

In short, this is not something that can be discussed. It's a cold fact, a
law of UNIX if you will.

There are enough reasons to discourage people from using uninterruptible 
sleep ("this f*cking application won't die when the network goes down") 
that I don't think this is an issue. We need to handle both cases, and 
while we can expand on the two cases we have now, we can't remove them.

		Linus

