Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbVCASIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVCASIK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 13:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVCASIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 13:08:10 -0500
Received: from fire.osdl.org ([65.172.181.4]:13465 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262003AbVCASHr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 13:07:47 -0500
Date: Tue, 1 Mar 2005 10:08:48 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@muc.de>
cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linas Vepstas <linas@austin.ibm.com>,
       "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
In-Reply-To: <m1hdjvi8r3.fsf@muc.de>
Message-ID: <Pine.LNX.4.58.0503011001320.25732@ppc970.osdl.org>
References: <422428EC.3090905@jp.fujitsu.com> <m1hdjvi8r3.fsf@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 Mar 2005, Andi Kleen wrote:
> 
> But what would the default handling be? It would be nice if there
> was a simple way for a driver to say "just shut me down on an error"
> without adding iochk_* to each function. Ideally this would be just
> a standard callback that knows how to clean up the driver.

There can't be any.

The thing is, IO errors just will be very architecture-dependent. Some 
might have exceptions happening, without the exception handler really 
having much of an idea of who caused it, unless that driver had prepared 
it some way, and gotten the proper locks.

A non-converted driver just doesn't _do_ any of that. It doesn't guarantee 
that it's the only one accessing that bus, since it doesn't do the 
"iocheck_clear()/iocheck_read()" things that imply all the locking etc.

So the default handling for iochecks pretty much _has_ to be "report them 
to the user", and then letting the user decide what to do if the hardware 
is going bad.

Shutting down the hardware by default might be a horribly bad thing to do
even _if_ you could pinpoint the driver that caused the problem in the
first place (and that's a big if, and probably depends on the details of
what the actual hw architecture support ends up being). So don't even try. 
The sysadmin may have different preferences than some driver default.

In fact, I'd argue that even a driver that _uses_ the interface should not
necessarily shut itself down on error. Obviously, it should always log the
error, but outside of that it might be good if the operator can decide and
set a flag whether it should try to re-try (which may not always be
possible, of course), shut down, or just continue.

		Linus
