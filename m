Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267612AbUIJRmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267612AbUIJRmd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 13:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267614AbUIJRmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 13:42:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:12174 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267612AbUIJRmb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 13:42:31 -0400
Date: Fri, 10 Sep 2004 10:42:28 -0700
From: Chris Wright <chrisw@osdl.org>
To: Roland McGrath <roland@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix sigqueue accounting for posix-timers broken by new RLIMIT_SIGPENDING tracking code
Message-ID: <20040910104228.K1924@build.pdx.osdl.net>
References: <200409100510.i8A5AVD7025919@magilla.sf.frob.com> <20040909234900.Q1973@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040909234900.Q1973@build.pdx.osdl.net>; from chrisw@osdl.org on Thu, Sep 09, 2004 at 11:49:00PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Wright (chrisw@osdl.org) wrote:
> * Roland McGrath (roland@redhat.com) wrote:
> > 
> > The introduction of RLIMIT_SIGPENDING and the associated tracking code was
> > broken for the case of preallocated sigqueue elements, i.e. posix-timers.
> > It wrongly includes the timer's preallocated sigqueue structs in the count
> > towards the per-user when allocating them, but (rightly) does not decrement
> > the count when they are freed.  
> 
> Are you sure?  IOW, are you seeing a leak of the count?  The sigqueue
> structure has a lifetime the same as the timer, IIRC.  So each time the
> signal is sent/received there's no accounting, because it's reused.
> But timer create/delete does sigqueue_alloc -> __sigqueue_alloc which
> does the inc. and sigqueue_free -> __sigqueue_free which does the dec.
> I'm fairly sure I had tested this.

Yeah, I re-read the code and re-ran my tests just now to verify.  Current
code is correct.  In fact, this patch is wrong.  It unbalances the inc/dec
such that sigqueue_alloc() won't inc, yet final sigqueue_free (at timer
destruction) will still dec.  Please don't apply this patch.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
