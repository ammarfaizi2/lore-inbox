Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWIDWAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWIDWAx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 18:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWIDWAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 18:00:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25281 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751447AbWIDWAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 18:00:52 -0400
Date: Mon, 4 Sep 2006 15:00:27 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andreas Hobein <ah2@delair.de>
cc: Oleg Nesterov <oleg@tv-sign.ru>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>, Markus Gutschke <markus@google.com>
Subject: Re: Trouble with ptrace self-attach rule since kernel > 2.6.14
In-Reply-To: <200609042342.41184.ah2@delair.de>
Message-ID: <Pine.LNX.4.64.0609041452520.27779@g5.osdl.org>
References: <200608312305.47515.ah2@delair.de> <20060904152307.GA98@oleg>
 <200609041756.18343.ah2@delair.de> <200609042342.41184.ah2@delair.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Sep 2006, Andreas Hobein wrote:
> 
> I've tested tracing child threads from the parent thread as well as tracing 
> siblings and parent threads from a child. All tests where successful when 
> reverting the above mentioned changes.

The problems tend to happen when the thread leader exits while one of the 
sub-threads is being traced, and the tracer thread ends up being 
re-parented to be the child of the traced thread (or something like that - 
I forget the exact details).

There was also some problem with the tracer doing an exit() without 
detaching, or something. 

We may have fixed most of the problems since - Oleg has certainly been 
cleaning up some of this, and it's possible that the problems we had are 
ok now. 

Even back when it was broken, _normal_ use never showed the problem (ie no 
well-behaved ptrace use would cause anything bad to happen). But the 
breakage was a local DoS attack, where you could either force an oops or a 
unkillable process, I forget which.

There was an exploit for at least one of the exploits, so maybe somebody 
could test that exploit together with the one-line revert.

That said, it sounds like both of the people who ever noticed this are 
reasonably happy with their work-arounds, so I'm hoping we can simply 
decide not to care, and just keep doing the simpler "you can't ptrace your 
own thread group" thing. That rule simply avoids a lot of special cases.

			Linus
