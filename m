Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUKTVrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUKTVrl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 16:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUKTVrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 16:47:40 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:28615 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261711AbUKTVrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 16:47:37 -0500
Date: Sat, 20 Nov 2004 14:49:15 -0700
From: Jesse Allen <the3dfxdude@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Daniel Jacobowitz <dan@debian.org>, Eric Pouech <pouech-eric@wanadoo.fr>,
       Roland McGrath <roland@redhat.com>, Mike Hearn <mh@codeweavers.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
Message-ID: <20041120214915.GA6100@tesore.ph.cox.net>
Mail-Followup-To: Jesse Allen <the3dfxdude@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Daniel Jacobowitz <dan@debian.org>,
	Eric Pouech <pouech-eric@wanadoo.fr>,
	Roland McGrath <roland@redhat.com>, Mike Hearn <mh@codeweavers.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	wine-devel <wine-devel@winehq.com>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com> <419E42B3.8070901@wanadoo.fr> <Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org> <419E4A76.8020909@wanadoo.fr> <Pine.LNX.4.58.0411191148480.2222@ppc970.osdl.org> <419E5A88.1050701@wanadoo.fr> <20041119212327.GA8121@nevyn.them.org> <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 01:53:38PM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 19 Nov 2004, Daniel Jacobowitz wrote:
> > 
> > I'm getting the feeling that the question of whether to step into
> > signal handlers is orthogonal to single-stepping; maybe it should be a
> > separate ptrace operation.
> 
> I really don't see why. If a controlling process is asking for 
> single-stepping, then it damn well should get it. It it doesn't want to 
> single-step through a signal handler, then it could decide to just put a 
> breakpoint on the return point (possibly by modifying the signal handler 
> save area).
> 
> It's not like single-stepping into the signal handler in any way removes 
> any information (while _not_ single-stepping into it clearly does).
> 
> With the patch I just posted (assuming it works for people), Wine should 
> at least have the choice. The behaviour now should be:
> 
>  - if the app sets TF on its own, it will cause a SIGTRAP which it can 
>    catch.
>  - if the debugger sets TF with SINGLESTEP, it will single-step into a 
>    signal handler.
>  - it the app sets TF _and_ you ptrace it, you the ptracer will see the 
>    debug event and catch it. However, doing a "continue" at that point
>    will remove the TF flag (and always has), the app will normally then
>    never see the trap. You can do a "signal SIGTRAP" to actually force
>    the trap handler to tun, but that one won't actually single-step (it's 
>    a "continue" in all other senses).
> 
> It sounds like the third case is what wine wants.
> 
> 		Linus


So an app running through wine could set TF on it's own?  It would be a 
good idea to find out what it is doing in the first place.  There has to be
a reason why War3 is so picky after the original change was introduced and
a reason why the latest changes don't seem to fix it. 

I've built a kernel 2.6.10-rc2 with the new ptrace patch.  The program still
says "please insert disc".  I haven't been able to get winedbg to tell me 
anything useful -- the program never crashes anyways.  So I went ahead and I 
captured a debug log.

the command:
WINEDEBUG=+all wine war3/Warcraft\ III.exe -opengl >& war3_and_2.6.10-rc2.log

I scanned for the part right before it calls up to display the error.  I found
that after loading advapi32.dll, the thread 000c creates a mutex and wakes up
000a.  Then 000c gets killed and right after that starts calling up the 
resources for the "insert disc" message box.  I put the log up on my ftp, and 
the interesting part in a seperate file:
ftp://resnet.dnip.net/

Any clue on what may be happening here?  Or maybe another idea on where else to search?


Jesse

