Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbUKVBMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbUKVBMW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 20:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbUKVBJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 20:09:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:37099 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261882AbUKVBHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 20:07:40 -0500
Date: Sun, 21 Nov 2004 17:07:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andreas Schwab <schwab@suse.de>
cc: Davide Libenzi <davidel@xmailserver.org>,
       Daniel Jacobowitz <dan@debian.org>,
       Eric Pouech <pouech-eric@wanadoo.fr>,
       Roland McGrath <roland@redhat.com>, Mike Hearn <mh@codeweavers.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <je7joe91wz.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.58.0411211703160.20993@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
 <419E42B3.8070901@wanadoo.fr> <Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org>
 <419E4A76.8020909@wanadoo.fr> <Pine.LNX.4.58.0411191148480.2222@ppc970.osdl.org>
 <419E5A88.1050701@wanadoo.fr> <20041119212327.GA8121@nevyn.them.org>
 <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org> <20041120214915.GA6100@tesore.ph.cox.net>
 <Pine.LNX.4.58.0411211326350.11274@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0411211414460.20993@ppc970.osdl.org> <je7joe91wz.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Nov 2004, Andreas Schwab wrote:
>
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > Now, try to "strace" it, or debug it with gdb, and see if you can repeat 
> > the behaviour.
> 
> You'll always have hard time repeating that under strace or gdb, since a
> debugger uses SIGTRAP for it's own purpose and does not pass it to the
> program.

Sure. But "hard time" and "impossible" are two different things. 

It _should_ be perfectly easy to debug this, by using

	signal SIGTRAP

instead of "continue" when you get a SIGTRAP that wasn't due to anything 
you did.

But try it. It doesn't work. Why? Because the kernel will have cleared TF 
on the signal stack, so even when you do a "signal SIGTRAP", it will only 
run the trap handler _once_, even though it should run it three times 
(once for each instruction in between the "popfl"s.

I do think this is actually a bug, although whether it's the bug that 
causes problems for Wine is not clear at all. I'mm too lazy to build 
and boot an older kernel, but I bet that on an older kernel you _can_ do 
"signal SIGTRAP" three times, and it will work correctly. That would 
indeed make this a regression.

		Linus
