Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbULaMfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbULaMfs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 07:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbULaMfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 07:35:48 -0500
Received: from colin2.muc.de ([193.149.48.15]:36356 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261945AbULaMfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 07:35:39 -0500
Date: 31 Dec 2004 13:35:38 +0100
Date: Fri, 31 Dec 2004 13:35:38 +0100
From: Andi Kleen <ak@muc.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Davide Libenzi <davidel@xmailserver.org>, Mike Hearn <mh@codeweavers.com>,
       Thomas Sailer <sailer@scs.ch>, Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
Message-ID: <20041231123538.GA18209@muc.de>
References: <Pine.LNX.4.58.0412292050550.22893@ppc970.osdl.org> <Pine.LNX.4.58.0412292055540.22893@ppc970.osdl.org> <Pine.LNX.4.58.0412292106400.454@bigblue.dev.mdolabs.com> <Pine.LNX.4.58.0412292256350.22893@ppc970.osdl.org> <Pine.LNX.4.58.0412300953470.2193@bigblue.dev.mdolabs.com> <53046857041230112742acccbe@mail.gmail.com> <Pine.LNX.4.58.0412301130540.22893@ppc970.osdl.org> <Pine.LNX.4.58.0412301436330.22893@ppc970.osdl.org> <m1mzvvjs3k.fsf@muc.de> <Pine.LNX.4.58.0412301628580.2280@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412301628580.2280@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2004 at 04:38:21PM -0800, Linus Torvalds wrote:
> > Can someone repeat again what was wrong with the old ptrace
> > semantics before the initial change that caused all these complex
> > changes?  It seemed to work well for years. How about we just
> > go back to the old state, revert all the recent ptrace changes 
> > and skip all that?
> 
> Let me count the ways that were wrong before the changes:
>  - you couldn't debug any code that set TF. Really. ptrace would totally 
>    destroy the TF state in the controlled process, so it would do 
>    something totally different when debugged.

Well, tough. I assume people who play with TF themselves know
how to handle it without debuggers.  Really adding instruction
parsing for such a corner case seems like extreme overkill to me.

I agree it is not nice, but is it really worth all that complexity
to hide it?

>  - you couldn't even debug signal handlers, because they were _really_ 
>    hard to get into unless you knew where they were and put a breakpoint 
>    on them.

Ok I see this as being a problem. But I bet it could be fixed
much simpler without doing all this complicated and likely-to-be-buggy
popf parsing you added.

>  - you couldn't see the instruction after a system call.

Are you sure? 

>  - ptrace returned bogus TF state after a single-step

I am sure all debuggers in existence deal with that (and they will
need to continue doing so because there are so many old kernels around) 

> descriptors, and we actually do that (badly) in another place: the AMD
> "prefetch" check does exactly the same thing except it seems to get a few
> details wrong (looks like it cannot handle 16-bit code), and only works
> for the current process.

Yes, it was intentional to simplify it. 16bit code is not supposed
to use prefetches (and even if they do the probability of faulting
is pretty small) Also we needed several iterations
to get all the subtle bugs out (and I bet there are some issues left)

-Andi
