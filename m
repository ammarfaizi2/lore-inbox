Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbVIXHyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbVIXHyE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 03:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbVIXHyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 03:54:04 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:6406 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932147AbVIXHyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 03:54:03 -0400
Date: Sat, 24 Sep 2005 09:51:23 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] sys_epoll_wait() timeout saga ...
Message-ID: <20050924075123.GA24999@alpha.home.local>
References: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain> <20050924040534.GB18716@alpha.home.local> <29495f1d05092321447417503@mail.gmail.com> <20050924061500.GA24628@alpha.home.local> <Pine.LNX.4.58.0509240030370.24744@shell2.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509240030370.24744@shell2.speakeasy.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2005 at 12:33:05AM -0700, Vadim Lobanov wrote:
> On Sat, 24 Sep 2005, Willy Tarreau wrote:
> 
> > On Fri, Sep 23, 2005 at 09:44:10PM -0700, Nish Aravamudan wrote:
> > > > >        * that why (t * HZ) / 1000.
> > > > >        */
> > > > > -     jtimeout = timeout == -1 || timeout > (MAX_SCHEDULE_TIMEOUT - 1000) / HZ ?
> > > > > +     jtimeout = timeout < 0 || (timeout / 1000) >= (MAX_SCHEDULE_TIMEOUT / HZ) ?
> > > > >               MAX_SCHEDULE_TIMEOUT: (timeout * HZ + 999) / 1000;
> > > >
> > > > Here, I'm not certain that gcc will optimize the divide. It would be better
> > > > anyway to write this which is equivalent, and a pure integer comparison :
> > > >
> > > > +       jtimeout = timeout < 0 || timeout >= 1000 * MAX_SCHEDULE_TIMEOUT / HZ ?
> > > > >               MAX_SCHEDULE_TIMEOUT: (timeout * HZ + 999) / 1000;
> > >
> > > Just a question here, maybe it's dumb.
> >
> > Your question is not dumb, this code is not trivial at all !
> >
> > > * and / have the same priority in the order of operations, yes? If so,
> > > won't the the 1000 * MAX_SCHEDULE_TIMEOUT overflow
> > > (MAX_SCHEDULE_TIMEOUT is LONG_MAX)?
> >
> > Yes it can, and that's why I said that gcc should send a warning when
> > comparing an int with something too large for an int. But I should have
> > forced the constant to be evaluated as long long. At the moment, the
> > constant cannot overflow, but it can reach a value so high that
> > timeout/1000 will never reach it. Example :
> >   MAX_SCHEDULE_TIMEOUT=LONG_MAX
> >   HZ=250
> >   timeout=LONG_MAX-1
> >   => timeout/1000 < MAX_SCHEDULE_TIMEOUT/HZ
> >   but (timeout * HZ + 999) / 1000 will still overflow !
> >
> > So I finally think that the safest test would be to avoid the timeout
> > range which can overflow in the computation, using something like this
> > (but which will limit the timeout to 49 days on HZ=1000 machines) :
> >
> > +       jtimeout = timeout < 0 || \
> > +                    timeout >= (1000ULL * MAX_SCHEDULE_TIMEOUT / HZ) || \
> > +                    timeout >= (LONG_MAX / HZ - 1000) ?
> >                    MAX_SCHEDULE_TIMEOUT: (timeout * HZ + 999) / 1000;
> 
> It seems that we can make the second overflow test be less strict by
> doing the following instead:
>     timeout >= (LONG_MAX - 1000) / HZ
> Unless I'm confused. :-)

oops, you're right. Then it produces the following patch :


diff -purN linux-2.6.13/fs/eventpoll.c linux-2.6.13-epoll/fs/eventpoll.c
--- linux-2.6.13/fs/eventpoll.c	Sun Sep 11 08:25:26 2005
+++ linux-2.6.13-epoll/fs/eventpoll.c	Sat Sep 24 09:49:43 2005
@@ -1504,9 +1504,12 @@ static int ep_poll(struct eventpoll *ep,
 	/*
 	 * Calculate the timeout by checking for the "infinite" value ( -1 )
 	 * and the overflow condition. The passed timeout is in milliseconds,
-	 * that why (t * HZ) / 1000.
+	 * that why (t * HZ) / 1000. Note that we also want to avoid an
+	 * overflow in the multiply.
 	 */
-	jtimeout = timeout == -1 || timeout > (MAX_SCHEDULE_TIMEOUT - 1000) / HZ ?
+	jtimeout = timeout < 0 ||
+		timeout > (MAX_SCHEDULE_TIMEOUT * 1000ULL / HZ) ||
+		timeout > (LONG_MAX - 1000) / HZ ?
 		MAX_SCHEDULE_TIMEOUT: (timeout * HZ + 999) / 1000;
 
 retry:


Interestingly, as long as MAC_SCHEDULE_TIMEOUT == LONG_MAX, the check is
identical to the initial one (and does not add any divide) !

Regards,
Willy

