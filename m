Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317831AbSFMVKP>; Thu, 13 Jun 2002 17:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317833AbSFMVKO>; Thu, 13 Jun 2002 17:10:14 -0400
Received: from server3.jumpleads.com ([217.151.96.171]:9432 "EHLO
	server3.jumpleads.com") by vger.kernel.org with ESMTP
	id <S317831AbSFMVKN>; Thu, 13 Jun 2002 17:10:13 -0400
Date: Thu, 13 Jun 2002 22:10:08 +0100 (BST)
From: Matthew Wakeling <mnw21@bigfoot.com>
X-X-Sender: mnw21@server3.jumpleads.com
To: BugTraq Mailing List <bugtraq@securityfocus.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Very large font size crashing X Font Server and Grounding Server
 to a Halt (was: remote DoS in Mozilla 1.0)
In-Reply-To: <Pine.LNX.4.44.0206130908550.985-100000@kalabaw>
Message-ID: <Pine.LNX.4.44.0206132128570.4999-100000@server3.jumpleads.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2002, Federico Sevilla III wrote:

> I was able to log on to the server with enough time to SIGKILL the
> xfs-daemon process. Unfortunately this wasn't good enough. The server
> started running up various processes stuck in "D" state, the OOM killer
> went on panic mode and started killing things left and right, mostly from
> what I notice apache and apache-ssl processes with messages like "Out of
> Memory: Killed process xxxx (apache)". I was also able to do a `free`
> after killing xfs-daemon and noticed that there was a lot of free memory
> both physically and on swap.
> 
> Within less than ten minutes on this relatively lightly-loaded server, I
> could not log in to the machine locally, even as root (whose home
> directory is not NFS-exported) and load levels shot up to around 25, which
> is definitely abnormal. Existing logged-on processes also got stuck in
> whatever they were doing (`ps ax`, in particular is what I remember).

It has always puzzled me that a process using lots of memory can bring 
down an entire (otherwise relatively idle) server to the extent that one 
cannot even get mingetty on a local terminal to respond to keypresses. I 
can confirm that the described situation is not just a one-off.

It is my experience that a single process using large amounts of memory 
causes the system to start swapping. Once it starts swapping, every 
process that does anything (apart from indefinite wait) goes into "I'm 
ready to do some processing, but my memory is swapped out" state, and the 
whole system collapses.

I don't know if Linux prioritises swap-ins as well as CPU time, but 
perhaps this would be a good way of stabilising this circumstance. One 
could arrange the dynamic process priorities so that the bad neighbour 
(read: exploited xfs-daemon) gets less than its fair share of physical 
RAM, therefore letting the rest of the system live. Perhaps one could 
limit the number of processes that are having their swap-in serviced at 
any one time, and make the ones that are being serviced the ones with the 
highest dynamic priority.

I don't know what exactly is causing the problem, but it is possible that 
pages are being paged in, the process runs on them for a quantum, and then 
paged out. In this case, it might help to dictate a minimum time a page 
can be "in", measured in the amount of work the owning process manages to 
do.

My other quibble is that the out-of-memory killer seems to choose 
processes fairly randomly. Ideally, it should kill the process that is 
causing the problem - which in my experience is always the biggest process 
in the system, or the process which has grown the fastest recently. 
However, it should probably be positively discouraged from killing things 
like apache (where most of the process space is shared), or gettys (which 
are firstly small, and secondly likely to be respawned by someone at the 
first opportunity).

> Attempted reboots locally via Ctrl-Alt-Delete and Magic SysRq failed
> because (1) I had disabled ctrl-alt-delete mapping in inittab "for
> security", and (2) I had not compiled Magic SysRq support on this
> particular server. More notes to self.

I think that if you had not disabled ctrl-alt-delete, it wouldn't have 
done much good anyway, since usually that key combination just tells init 
to spawn a shutdown process, which has just as much chance of getting 
resources as any other process in the system.

> While I agree with BugTraq posts in response to this that applications
> like Mozilla which accept font-sizes from unknown sources should have some
> check to prevent such large sizes from crashing X and/or the X Font
> Server, I'm alarmed by (1) the way the X font server allows itself to be
> crashed like this, and (2) the way the entire Linux kernel seems to have
> been unable to handle the situation.

I am in complete agreement with both points, but particularly that the 
kernel should be able to cope with the situation gracefully. I know one 
can set limits on processes, but the kernel should still be able to cope 
if we don't.

> Suggestions on how to work around this on multiple levels would definitely
> be appreciated.

My suggestion would be to set a maximum core size for the xfs-daemon 
process. Given your setup, something like 400MB seems appropriate - maybe 
a little lower. Details for doing this seem to differ from linux to linux. 
Having done that, I would make sure xfs respawns when it dies - that way 
someone can't just DOS your whole network by asking for a large font.
Finally, wait for the xfs developers to put in a font size limit, or patch 
the source yourself.

Apart from that, I wouldn't move xfs to a bigger server unless you have 
already had people complaining about its performance. Moving it to a 
bigger system just changes the constant in the equation - the attacker 
would only need to specify a 100000 point font instead of a 50000 point 
font to bring the system down.

I doubt any of my kernel suggestions have not already been thought about, 
but it was worth a try. Please can this problem be fixed soon?

Matthew

-- 
"If I wanted to kill a battleship, I'd use a s?!tload of Harpoons."
"NT is a lot cheaper."  -- Paul Tomblin & Petro


