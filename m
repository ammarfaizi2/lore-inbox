Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317843AbSFMVrn>; Thu, 13 Jun 2002 17:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317844AbSFMVrm>; Thu, 13 Jun 2002 17:47:42 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:29817 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S317843AbSFMVrk>; Thu, 13 Jun 2002 17:47:40 -0400
Date: Thu, 13 Jun 2002 16:47:41 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200206132147.QAA20200@tomcat.admin.navo.hpc.mil>
To: mnw21@bigfoot.com, BugTraq Mailing List <bugtraq@securityfocus.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Very large font size crashing X Font Server and Grounding Server to a Halt (was: remote DoS in Mozilla 1.0)
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wakeling <mnw21@bigfoot.com>:
> 
> On Thu, 13 Jun 2002, Federico Sevilla III wrote:
> 
> > I was able to log on to the server with enough time to SIGKILL the
> > xfs-daemon process. Unfortunately this wasn't good enough. The server
> > started running up various processes stuck in "D" state, the OOM killer
> > went on panic mode and started killing things left and right, mostly from
> > what I notice apache and apache-ssl processes with messages like "Out of
> > Memory: Killed process xxxx (apache)". I was also able to do a `free`
> > after killing xfs-daemon and noticed that there was a lot of free memory
> > both physically and on swap.
> > 
> > Within less than ten minutes on this relatively lightly-loaded server, I
> > could not log in to the machine locally, even as root (whose home
> > directory is not NFS-exported) and load levels shot up to around 25, which
> > is definitely abnormal. Existing logged-on processes also got stuck in
> > whatever they were doing (`ps ax`, in particular is what I remember).
> 
> It has always puzzled me that a process using lots of memory can bring 
> down an entire (otherwise relatively idle) server to the extent that one 
> cannot even get mingetty on a local terminal to respond to keypresses. I 
> can confirm that the described situation is not just a one-off.
> 
> It is my experience that a single process using large amounts of memory 
> causes the system to start swapping. Once it starts swapping, every 
> process that does anything (apart from indefinite wait) goes into "I'm 
> ready to do some processing, but my memory is swapped out" state, and the 
> whole system collapses.

Not necessarily. The condition can also be caused by having a large, well
behaved process working its' little heart out properly, and a small process
that grows suddenly (or even slowly - it doesn't take much to push it over
the limit). As the small process grows, the larger one is paged out. Once
the swap space is filled just adding one more page could do it. And it doesn't
matter what process allocates that page. Key: disable oversubscription of
memory.

[snip]

> > While I agree with BugTraq posts in response to this that applications
> > like Mozilla which accept font-sizes from unknown sources should have some
> > check to prevent such large sizes from crashing X and/or the X Font
> > Server, I'm alarmed by (1) the way the X font server allows itself to be
> > crashed like this, and (2) the way the entire Linux kernel seems to have
> > been unable to handle the situation.
> 
> I am in complete agreement with both points, but particularly that the 
> kernel should be able to cope with the situation gracefully. I know one 
> can set limits on processes, but the kernel should still be able to cope 
> if we don't.

It can't decide what causes the problem. There are too may possibilities.

This is NOT a bug. I consider it a problem of a misconfigured server. As long
as memory oversubscription is permitted, there are a LOT of things that can
cause a system failure. Examples are:

	DNS cache table fills memory
	X font server fills memory (the discussed failure)
	Sendmail recieves large Email (2-8MB)
	Web server recieves a lot of requests (though this one is harder and
		needs a lot of static pages to be loaded into memory)
	Database recieves lots of queries for lots of data
	All cron jobs kick off at once, with several requiring lots of memory

(I've even seen that last one kill solaris)
	

> > Suggestions on how to work around this on multiple levels would definitely
> > be appreciated.
> 
> My suggestion would be to set a maximum core size for the xfs-daemon 
> process. Given your setup, something like 400MB seems appropriate - maybe 
> a little lower. Details for doing this seem to differ from linux to linux. 
> Having done that, I would make sure xfs respawns when it dies - that way 
> someone can't just DOS your whole network by asking for a large font.
> Finally, wait for the xfs developers to put in a font size limit, or patch 
> the source yourself.

Also put a maximum limit on the X server.

> Apart from that, I wouldn't move xfs to a bigger server unless you have 
> already had people complaining about its performance. Moving it to a 
> bigger system just changes the constant in the equation - the attacker 
> would only need to specify a 100000 point font instead of a 50000 point 
> font to bring the system down.

Even if the font server survives - the X server wouldn't. In both cases,
only huristics can be applied.

1. Do not generate a font with more than 100 pixels high (around 1 inch
   on display) by the font server. This would have to be a configuration
   item, since there will be cases where that size is unreasonable. Also
   might be a good idea to not cache fonts > X size even if generated.
2. Do not have more than X active fonts at a time (to cover the case of
   multiple fonts at the maximum) where X is based on an external
   configuration (XF86Config parameter limit). Or specify the maximum
   amount of memory to allocate to fonts, when that space is filled, return
   a font error (font not available) to the application. Again, deallocate
   fonts > X size when not in use.

The easiest fix is to disable oversubscription of memory, though that may
cause some daemons to abort if they don't check for allocation failures
(which I do consider a bug).

> I doubt any of my kernel suggestions have not already been thought about, 
> but it was worth a try. Please can this problem be fixed soon?
> 
> Matthew
> 
> -- 
> "If I wanted to kill a battleship, I'd use a s?!tload of Harpoons."
> "NT is a lot cheaper."  -- Paul Tomblin & Petro

Good signature... :)

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
