Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272671AbTHKOhQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272672AbTHKOhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 10:37:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33037 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S272671AbTHKOhL (ORCPT
	<rfc822;linux-kernel@vger.redhat.com>);
	Mon, 11 Aug 2003 10:37:11 -0400
Date: Mon, 11 Aug 2003 10:37:01 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Dinesh Gandhewar <dinesh_gandhewar@rediffmail.com>,
       mlist-linux-kernel@nntp-server.caltech.edu
Subject: Re: volatile variable
Message-ID: <20030811103701.M23055@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20030801105706.30523.qmail@webmail28.rediffmail.com> <Pine.LNX.4.53.0308010723060.3077@chaos> <1060608783.19194.13.camel@passion.cambridge.redhat.com> <Pine.LNX.4.53.0308110944350.17240@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.53.0308110944350.17240@chaos>; from root@chaos.analogic.com on Mon, Aug 11, 2003 at 10:06:36AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 10:06:36AM -0400, Richard B. Johnson wrote:
> > If 'a' is a local variable that's true. If 'a' is a global as the
> > original poster explicitly declared, then the compiler must assume that
> > function calls (such as the one to schedule()) may modify it, and hence
> > may not optimise away the second and subsequent reads. Therefore, the
> > 'volatile' is not required.
> >
> 
> Again, this is incorrect. If you look at the declaration of schedule(),
> you will note "asmlinkage void schedule(void);". Now look up
> "asmlinkage"
> #define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))
> 
> The regparm(0) atttibute tells gcc that schedule() will get any/all
> of its parameters in registers. Since schedule() receives no parameters,
> that means that, as far as gcc is concerned, it cannot modify
> anything. That said, this may be a bug or it may have been added
> to work around some gcc bug. But, nevertheless, as the declaration
> stands, schedule() will never modify anything because somebody told
> gcc it won't.

You're wrong.  regparm(0) attribute tells GCC to pass all arguments
on the stack.  Also function argument passing (the only thing this
attribute controls) is completely orthogonal to whether a function may
modify global variables or not.
__attribute__((const)) functions are not allowed to write nor read
global memory, __attribute__((pure)) functions are not allowed to
write global memory and all other functions are allowed to both
read and write global memory.
As schedule is neither const nor pure, the compiler must assume
a global variable can be changed by schedule().

	Jakub
