Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264831AbRFSXTw>; Tue, 19 Jun 2001 19:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264833AbRFSXTm>; Tue, 19 Jun 2001 19:19:42 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:30341 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S264831AbRFSXTb>; Tue, 19 Jun 2001 19:19:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Larry McVoy <lm@bitmover.com>, Matthew Kirkwood <matthew@hairy.beasts.org>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Date: Tue, 19 Jun 2001 14:18:03 -0400
X-Mailer: KMail [version 1.2]
Cc: Larry McVoy <lm@bitmover.com>, Dan Kegel <dank@kegel.com>,
        ognen@gene.pbi.nrc.ca,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        laughing@shared-source.org
In-Reply-To: <20010619090956.R3089@work.bitmover.com> <Pine.LNX.4.30.0106191714320.11271-100000@sphinx.mythic-beasts.com> <20010619095239.T3089@work.bitmover.com>
In-Reply-To: <20010619095239.T3089@work.bitmover.com>
MIME-Version: 1.0
Message-Id: <01061914180302.04670@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 June 2001 12:52, Larry McVoy wrote:
> On Tue, Jun 19, 2001 at 05:26:09PM +0100, Matthew Kirkwood wrote:
> > On Tue, 19 Jun 2001, Larry McVoy wrote:
> > >     ``Think of it this way: threads are like salt, not like pasta. You
> > >     like salt, I like salt, we all like salt. But we eat more pasta.''
> >
> > This is oft-quoted but has, IMO, the property of not actually
> > making any sense.
>
> Hmm.  Makes sense to me.  All it is saying is that you can't make a good
> dinner out of a pile of salt.  It was originally said to some GUI people
> who wanted to use a thread per object, every button, scrollbar, canvas,
> text widget, menu, etc., are all threads.  What they didn't figure out is
> that a thread needs a stack, the stack is the dominating space term, and
> they were looking at a typical desktop with around 9,000 objects.  Times,
> at that point, an 8K stack.  That was 73MB in stacks.  Pretty darned stupid
> when you look at it that way, huh?

I've seen worse.

Back around '93 or so I took a look at Linux and wound up putting OS/2 on my 
desktop instead of Linux for 2 reasons.

1) Diamond Stealth video card.  It worked in OS/2, didn't work in Linux, and 
the reason was you guys couldn't get vendor support while IBM could.  
According to this list, it was entirely possible this sort of problem would 
NEVER be addressed.  (We got around it with reverse engineering and critical 
mass, but at the time hardware was changing way faster than we could keep up 
with it.)

2) Not only did Linux not have threads (at all), it didn't plan to have 
threads, and anybody who brought up the idea of threads was dismissed.  
Considering this was long before clone, and SMP hardware was starting to come 
into the high and and looked like it might wind up on the desktop eventually 
(who knew MS would keep DOS around another ten years, unable to understand 
two processors, to displays, two mice, two keyboards, and barely able to cope 
with two hard drives under a 26 letter limit...)

So I wound up work at IBM doing OS/2 development for a couple years.  On a 
project called Feature Install, which was based on a subclassed folder in the 
workplace shell (object oriented desktop).  The idea was you fill up a folder 
with files, drag and drop them from diskette to desktop, and they install 
themselves automatically.  (Went out the window when a single install object 
had to span two disks, but oh well.  By then, they were stuck with the 
design.  I inherited it after a year or two of scar tissue had accumulated.)

They created THREE threads for every single object, and they objects could 
nest arbitrarily deep.  (Modular installs with sub-components.)  The OS had a 
default of 1024 threads (expandable to 4096, I believe, before they hit a 64k 
limit somewhere in the coding).  When they made up a test object hierarchy 
for all the components of the entire OS, it created so many threads the 
system ran out and got completely hosed.  I had a command line window open, 
but couldn't RUN anything, since anything it tried to spawn required a thread 
to run.  (Child of the shell.)

One three finger salute later, the desktop comes back up automatically, with 
this nasty tangle of objects STILL there, and of course hoses itself AGAIN as 
the desktop instantiates all those objects in memory with their three threads 
apiece, and runs out again...

Those were the days.  If I remember correctly, I replace ALL those threads 
with a single thread doing all the work, a mutex protected linked list of 
work to do, and an event semaphore to tell it to do it.

> Nobody is arguing that having more than one thread of execution in an
> application is a bad idea.  On an SMP machine, having the same number of
> processes/threads as there are CPUs is a requirement to get the scaling
> if that app is all you are running.  That's fine.  But on a uniprocessor,
> threads are basically stupid.

Sometimes they're an easy way to get asynchronous behavior, and to perform 
work in the background without the GUI being locked up.  But the difference 
between "processes" and "threads" there is academic.  Processes with shared 
memory and some variant of semaphores to avoid killing each other in it.  
Same thing.

And I think the most I've ever REALLY used is about three for a whole 
program.  (Unless you're talking about a server with a thread pool handling 
connections.  And yeah that could be done with poll and non-blocking I/O, but 
not if you're shelling out to ssh and such...)

>  The only place that I know of where it is
> necessary is for I/O which blocks.  And even there you only need enough
> to overlap the I/O such that it streams.  And processes will, and do,
> work fine for that.

And nonblocking GUI elements, and breaking up work for multiple processors, 
and probably a few other things.

But I think the MAIN difference between the two camps is that the people who 
despise threads consider them to be a lot different from processes, and the 
people who like threads consider it a semantic argument.  I worry about cache 
trashing with too much shared data in an SMP system, but like the fact you 
automatically have synchronization primitives in a threading environment 
which might not be there if you're just dealing with processes.

I've used the filesystem for synchronization.  Back around 1991 I wrote my 
own fidonet compatable multinode BBS under DOS with desqview, including the 
mail tosser, from scratch in Borland C++ with nothing but file locking to 
keep the instances from killing each other, and I got 30 messages/second 
throughput on a 33 mhz 386.  The mail tosser could catch new posts in the 
middle of a stream of incoming messages from the network without ever having 
to look at an individual message message twice, and packed the message bases 
during the act of posting.  (And a bunch of fancy features I won't bore you 
with, especially the way delete worked.)

After doing all that with stone knives and bearskins, I -APPRECIATED- a 32 
bit flat memory model with threads. :)

> I think the general thrust of us ``anti-thread'' people is that a few
> are fine, a lot is stupid, and the model encourages a lot.  It's just
> like perl5, C++, pick-your-favorite-feature-rich-language in that
> exceptional programmers will do a good job with the problem but average
> programmers will do a horrible job.  Given that there are only a few
> exceptional programmers and a never ending wave of average programmers,
> the argument is that one should tailor the paradigm for the common case,
> not for the exceptional case.

There has not been and never will be a language in which it is the least bit 
difficult to write bad programs.

I don't remember who said that, but it should be on your list.  (Ask Nancy 
Lebowitz.)

Bondage and discipline languages that enforce somebody's idea of good 
programming practice usually just result in WORSE bad programs, and fewer 
good programs written by people who know how to play with fire without 
burning themselves.  Saying you can't have threads because they can be 
misused and "you shouldn't program that way" would be truly dumb.  (Turned ME 
off for a couple years, anyway.)

Rob
