Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265839AbRFYBYH>; Sun, 24 Jun 2001 21:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265840AbRFYBX5>; Sun, 24 Jun 2001 21:23:57 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:46749 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S265839AbRFYBXi>; Sun, 24 Jun 2001 21:23:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: "J . A . Magallon" <jamagallon@able.es>, landley@webofficenow.com
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Date: Sun, 24 Jun 2001 14:21:12 -0400
X-Mailer: KMail [version 1.2]
Cc: "J . A . Magallon" <jamagallon@able.es>, landley@webofficenow.com,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Timur Tabi <ttabi@interactivesi.com>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1010622162213.32091B-100000@artax.karlin.mff.cuni.cz> <01062412555901.03436@localhost.localdomain> <20010625003002.A1767@werewolf.able.es>
In-Reply-To: <20010625003002.A1767@werewolf.able.es>
MIME-Version: 1.0
Message-Id: <01062414211303.03436@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 June 2001 18:30, J . A . Magallon wrote:

> Take a programmer comming from other system to linux. If he wants multi-
> threading and protable code, he will choose pthreads. And you say to him:
> do it with 'clone', it is better. Answer: non protable. Again: do it
> with fork(), it is fast in linux. Answer: better for linux, but it is a
> real pain in other systems.

So we should be as bad as other systems?  I'm trying to figure out what 
you're saying here...

> And worst, you are allowing people to program based on a tool that will
> give VERY diferent performance when ported to other systems. They use
> fork(). They port their app to solaris. The performance sucks. It is not
> Solaris fault. It is linux fast fork() that makes people not looking for
> the correct standard tool for what they want todo.

Hang on, the fact the LInux implementation of something is 10x faster than 
somebody else's brain damaged implementation is Linux's fault?

On Linux, there is no real difference between threads and processes.  On some 
other systems, there is unnecessary overhead for processes.  "Threads" are 
from a programming perspective multiple points of execution that share an 
awful lot of state.  Which basically, processes can be if you tell them to 
share this state.

>From a system perspective threads are a hack to avoid a lot of the overhead 
processes have poisoning caches and setting up and tearing down page tables 
and such.  Linux processes don't have this level of overhead.

So -ON LINUX- there isn't much difference between threads and processes.  
Because the process overhead threads try to avoid has been optimized away, 
and thus there is a real world implementation of the two concepts which 
behaves in an extremely similar manner.  Thus the conceptual difference 
between the two is mostly either artificial or irrelevant, certainly in this 
context.  If there is a context without this difference, then in other 
contexts it would appear to be an artifact of implementation.

On Solaris there is a difference between threads and processes, but the 
reason is that Solaris' processes are inefficient (and shown by the 
benchmarks you don't seem to like).

> Instead of trying to enhance linux thread support, you try to move
> programmes to use linux 'specialities'.

No, I'm saying Linux processes right now have 90% of the features of thread 
support as is, and the remaining differences are mostly semantic.  It would 
be fairly easy to take an API like the OS/2 threading model and put it on 
Linux.  From what I remember of the OS/2 threading model, we're talking about 
a couple hours worth of work.

Adding support for the Posix model is harder, but from what I've seen of the 
Posix model this is because it's evil and requires a lot of things that don't 
really have much to do with the concept of threading.

I will admit that Linux (or the traditional unix programming model) has some 
things that don't mesh well with the abstract thread programming model.  
Signals, for example.  But since the traditional abstract threads model 
doesn't try to handle signals at ALL that I am aware of (OS/2 didn't, Dunno 
about NT.  Posix has some strange duct-tape solution I'm not entirely 
familiar with...  In java you can kill or suspend a thread which is 
IMPLEMENTED with signals but conceptually discrete...)

> >> That is comparing apples and oranges.
> >
> >Show me a real-world program that makes the distinction you're making.
> >Something in actual use.
>
> shell scripting, for example.

You've done multi-threaded shell scripting?  I tried to use bash with 
multiple processes and ran into the fact that $$ always gives the root 
process's PID, and nobody had ever apparently decided that this was dumb 
behavior...

> Or multithreaded web servers.

Apache has a thread pool, you know.  Keeps the suckers around...

> With the above
> test (fork() + immediate exec()), you just try to mesaure the speed of
> fork(). Say you have a fork'ing server. On each connection you fork and
> exec the real transfer program.

Like a CGI script, you mean?  Not using mod_perl or mode_php but shelling out?

And you're worried about performance?

> There time for fork matters. It can run
> very fast in Linux but suck in other systems.

And this is linux's problem, is it?

> Just because the programmer
> chose fork() instead of vfork().

So "#define fork vfork" would not be part of the "#ifdef slowaris" block then?

I'm still a bit unclear about what the behavior differences of them actualy 
are.  I believe vfork is the hack that goes really funny if you DON'T exec 
immediately after calling it.  Yet the argument here was about THREADS, which 
don't DO that.  So the entire discussion is a red herring.  If you're going 
to fork and then exec, you're not having multiple points of execution in the 
same program.

Linux can do this efficiently on a process level because its fork is 
efficient (and it has clone() which allows more control over what gets shared 
between processes.)  Solaris makes an artificial distinction between 
processes and threads because A) its fork implementation sucks, B) it doesn't 
allow granualr control over what gets shared between processes.

How does any of this point to a deficiency in Linux rather than Solaris?  
(Don't give me "standards", there's an official standard for EBCDIC.)

> >> The clean battle should be linux fork-exec vs vfork-exec in
> >> Solaris, because for in linux is really a vfork in solaris.
> >
> >But the point of threading is it's a fork WITHOUT an exec.
>
> Not always, see above.

Does "vfork" without "exec" work reliably?  Anybody wanna clear this up?

> >I'm not going to comment on the difference between fork and vfork becaue
> > to be honest I've forgotten what the difference is.  Something to do with
>
> Time.

You are clearly oversimplifying or else "fork" wouldn't exist.  Even Sun 
isn't going to put in an intentionally slower API that's otherwise 
functionally identical to another API.  If nothing else they'd implement one 
as a wrapper that calls the other with the arguments converted.

Rob
