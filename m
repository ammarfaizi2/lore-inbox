Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbUKITOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbUKITOh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 14:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbUKITOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 14:14:37 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:13747 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261630AbUKITOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 14:14:33 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: Synchronization primitives in UML (was: Re: [uml-devel] Re: [patch 09/20] uml: use SIG_IGN for empty sighandler)
Date: Tue, 9 Nov 2004 20:15:10 +0100
User-Agent: KMail/1.7.1
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, cw@f00f.org
References: <200411052036.55541.blaisorblade_spam@yahoo.it> <200411091844.44218.blaisorblade_spam@yahoo.it> <200411092048.iA9Kmjg9004223@ccure.user-mode-linux.org>
In-Reply-To: <200411092048.iA9Kmjg9004223@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411092015.10544.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 November 2004 21:48, Jeff Dike wrote:
> blaisorblade_spam@yahoo.it said:
> > I also understand now what all this is for. When I have time for this,
> > I'll at  least copy and paste your mail into a comment, with any
> > needed adjustment.

> That would be a good idea.

> > For the semaphore issue, I have some ideas (like using futexes) which
> > need to  be developed a bit:

> > 1) I want to create a semaphore API in os_*.
> > 2) It will be able to use socketpairs.
> > 3) It will be able to use futexes, if they are
> > non-persistant and usable  without too much issues (the same way we
> > are going to support Async I/O).
> > 4) It will be used first by the code
> > which could really benefit from the  performance increase.
> > 5) It won't
> > use persistant objects.

> This all sounds good, although there are simplicity benefits to just using
> one underlying mechanism, as long as there are no overriding disadvantages
> to it.
Yes, I would like that, too, but futexes are 2.6 only, and probably also 
NPTL-only (we are going to fix that, at least for SKAS mode), but faster than 
anything else. Nothing apart this.

> > Any comment on these issues? Also, apart TT context switching, is
> > there any  other performance-sensitive use of semaphores, which would
> > benefit from using  futexes?

> Offhand, I think context switching is the most sensitive one.
Ok. But to get TT mode to work against NPTL glibc, which is required for 
futexes, we need to recode the "thread_private" section in uml.lds.S to work 
with NPTL glibc. It seems that binutils does not like that (the error is "not 
enough program header allocated", which refers to the fact that 
SIZEOF_HEADERS is guessed and then used. Not using SIZEOF_HEADERS could help, 
if doing this is possible).

> > Yes, semget and friends are uglier.
> > But don't think that the current nested code is simple to read - three
> >  semaphores at a time, without a clear name, are not the clearer code
> > on the  world.

> What nested code are you talking about?

There are two down() and two up(); additionally, run_helper_thread() manages 
at least another pipe(). I don't see an easy way to simplifying all this, but 
it's needed (or at least some comment should be added). Just a cleanup, 
anyway.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

