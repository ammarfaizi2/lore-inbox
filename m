Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262424AbUKVVO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbUKVVO3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 16:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbUKVVNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 16:13:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:38845 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262431AbUKVVLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 16:11:33 -0500
Date: Mon, 22 Nov 2004 13:10:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Eric Pouech <pouech-eric@wanadoo.fr>
cc: Jesse Allen <the3dfxdude@gmail.com>, Daniel Jacobowitz <dan@debian.org>,
       Roland McGrath <roland@redhat.com>, Mike Hearn <mh@codeweavers.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <41A251A6.2030205@wanadoo.fr>
Message-ID: <Pine.LNX.4.58.0411221300460.20993@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
 <419E42B3.8070901@wanadoo.fr> <Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org>
 <419E4A76.8020909@wanadoo.fr> <Pine.LNX.4.58.0411191148480.2222@ppc970.osdl.org>
 <419E5A88.1050701@wanadoo.fr> <20041119212327.GA8121@nevyn.them.org>
 <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org> <20041120214915.GA6100@tesore.ph.cox.net>
 <41A251A6.2030205@wanadoo.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Nov 2004, Eric Pouech wrote:
> 
> For the linux folks, here a small comparison of what happens in the working 
> (old) case and in the non-working (new) case:
> 
> In both case
> 
> - Wine gets a first SIGTRAP (in it's sig_trap handler)
> 	+ Wine converts it into a Windows exception (w-exception in short).
> 	  This includes creating a context for the generic CPU registers
> 	+ This w-exception is sent to the w-exception handler the program
> 	  installed (this one can modifiy the all registers)
> 		o this handler touches one of the i386 debug registers
> 	+ as we need to update the debug registers values (and we don't do in
> 	  the signal handler return), this task is delegated to the Wine server
> 	  (our central process, which is in charge of synchronisation...)
> 		> the Wine server ptrace-attach:es to the process which handled
> 		  the SIGTRAP.
> 		> Wine server wait4:s on the SIGSTOP (after ptrace:attach)
> 		> modify (with ptrace) the debug registers
> 		> and resumes excution (ptrace: cont)
> 	+ wine terminates the sig trap handler and resumes the execution with
> 	  the modified basic registers (from the saved context), and the
> 	  modified debug registers (from the Wine server round trip)
> - a second sig trap is generated
> 	> since the wine server is still ptrace:attached, it gets the signal.	
> 
> What differs then in both execution:
> - in the working case, the sig trap handler is called on the client side, 
> whereas it's never called in the non-working case. We do have a couple of 
> protection (to avoid some misbehaving apps), but none of them get triggered. So 
> it seems like the trap handler is not called (ugh).

This actually implies that the current -bk tree with my latest patch may 
actually fix it.

One of the things that 2.6.9 did wrong was exactly that it cleared TF too
much in the ptrace interface. The current development tree is a lot more
careful about that, and it fixes the horrid test-case that I used to debug
it. The test-case (when run under gdb) actually does something similar to
what Wine appears to do.

> - in Windows trap handling, the TF is explictly reset before calling the windows 
> exception handler (which is what Wine does, before calling the window exception 
> handler). Of course the handler can set it back if it wants to continue single 
> stepping.

TF will be still set in Linux when ptrace gets access, but the ptracer can
choose to clear it with PTRACE_PEEKUSR/PTRACE_POKEUSR (or with
PTRACE_GETREGS/SETREGS). I assume you already do that, since I think that
has been true forever (although maybe you don't: PTRACE_CONTINUE used to 
unconditionally clear TF, so it may be that Wine may need some minor 
modification to not do that - but the good news is that mod should be 
backwards-compatible, so it should be pretty easy).

I actually broke down and am downloading the latest source tree of wine,
let's see if I can find the place you do this.

		Linus
