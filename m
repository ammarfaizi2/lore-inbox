Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbUKSWCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbUKSWCw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 17:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbUKSWBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 17:01:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:4259 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261604AbUKSVx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 16:53:59 -0500
Date: Fri, 19 Nov 2004 13:53:38 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Jacobowitz <dan@debian.org>
cc: Eric Pouech <pouech-eric@wanadoo.fr>, Roland McGrath <roland@redhat.com>,
       Mike Hearn <mh@codeweavers.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <20041119212327.GA8121@nevyn.them.org>
Message-ID: <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
 <419E42B3.8070901@wanadoo.fr> <Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org>
 <419E4A76.8020909@wanadoo.fr> <Pine.LNX.4.58.0411191148480.2222@ppc970.osdl.org>
 <419E5A88.1050701@wanadoo.fr> <20041119212327.GA8121@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Nov 2004, Daniel Jacobowitz wrote:
> 
> I'm getting the feeling that the question of whether to step into
> signal handlers is orthogonal to single-stepping; maybe it should be a
> separate ptrace operation.

I really don't see why. If a controlling process is asking for 
single-stepping, then it damn well should get it. It it doesn't want to 
single-step through a signal handler, then it could decide to just put a 
breakpoint on the return point (possibly by modifying the signal handler 
save area).

It's not like single-stepping into the signal handler in any way removes 
any information (while _not_ single-stepping into it clearly does).

With the patch I just posted (assuming it works for people), Wine should 
at least have the choice. The behaviour now should be:

 - if the app sets TF on its own, it will cause a SIGTRAP which it can 
   catch.
 - if the debugger sets TF with SINGLESTEP, it will single-step into a 
   signal handler.
 - it the app sets TF _and_ you ptrace it, you the ptracer will see the 
   debug event and catch it. However, doing a "continue" at that point
   will remove the TF flag (and always has), the app will normally then
   never see the trap. You can do a "signal SIGTRAP" to actually force
   the trap handler to tun, but that one won't actually single-step (it's 
   a "continue" in all other senses).

It sounds like the third case is what wine wants.

		Linus
