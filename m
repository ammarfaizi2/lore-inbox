Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <160760-10502>; Sat, 9 Jan 1999 09:13:11 -0500
Received: by vger.rutgers.edu id <160768-5730>; Sat, 9 Jan 1999 07:07:14 -0500
Received: from lilly.ping.de ([195.37.120.2]:9845 "HELO lilly.ping.de" ident: "qmailr") by vger.rutgers.edu with SMTP id <169782-3419>; Fri, 8 Jan 1999 15:20:15 -0500
Message-ID: <19990108232340.A12950@kg1.ping.de>
Date: Fri, 8 Jan 1999 23:23:40 +0100
From: Kurt Garloff <K.Garloff@ping.de>
To: root@chaos.analogic.com, Pavel Machek <pavel@atrey.karlin.mff.cuni.cz>
Cc: MOLNAR Ingo <mingo@chiara.csoma.elte.hu>, "B. James Phillippe" <bryan@terran.org>, Linux kernel list <linux-kernel@vger.rutgers.edu>, Chris Wedgwood <cw@ix.net.nz>
Subject: Re: [PATCH] HZ change for ix86
Mail-Followup-To: root@chaos.analogic.com, Pavel Machek <pavel@atrey.karlin.mff.cuni.cz>, MOLNAR Ingo <mingo@chiara.csoma.elte.hu>, "B. James Phillippe" <bryan@terran.org>, Linux kernel list <linux-kernel@vger.rutgers.edu>, Chris Wedgwood <cw@ix.net.nz>
References: <19990107140917.23736@atrey.karlin.mff.cuni.cz> <Pine.LNX.3.95.990108085724.1428A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.90.4i
In-Reply-To: <Pine.LNX.3.95.990108085724.1428A-100000@chaos.analogic.com>; from Richard B. Johnson on Fri, Jan 08, 1999 at 09:14:14AM -0500
X-Operating-System: Linux 2.1.132 i686
Sender: owner-linux-kernel@vger.rutgers.edu

On Fri, Jan 08, 1999 at 09:14:14AM -0500, Richard B. Johnson wrote:
> On Thu, 7 Jan 1999, Pavel Machek wrote:
> 
> > You should _not_ need to increase HZ. But there've always been obscure
> > "feature" in scheduler, and increased HZ work around it.
> > 
> > 								Pavel
> 
> There seems to be a general misinformation about what the HZ value is.
> I will "simplicate and add lightness".
> 
> If your code does:
> 		while (1)
>                      ;
> 
> The CPU gets taken away from you HZ times per second so that other
> tasks can use the CPU cycles you are wasting. Under these conditions
> it seems like a good idea to make the HZ value as high as possible.
> 
> However, if your code is doing:
> 
> 		UncompressFonts(...........);
>                 ReadAudioFromDsp(...........);
>                 ConvolveImageData(..........);
>                 
> 	you don't want the CPU taken away until you are done.
> 
> For most interactive applications, it has been experimentally determined
> that 100 Hz is (about) right because human beings can't detect flicker
> above 80 Hz. In other words, getting the CPU stolen 100 times per second
> doesn't produce visual effects. The higher the HZ value, the more
> often the CPU gets stolen from the interactive user. There are trade-
> offs as with most everything.
> 
> More is not better. More is just different.

I think you didn't describe the tradeoff correctly. The amount of time a
process gets are independent of HZ. HZ just defines its granularity.

Let me describe this with a picture, where we have two runnable processes A
and B:     .   .   .   .   .   .   .   .
 HZ = 100: AAAAAAAABBBBBBBBAAAAAAAABBBBBBBB
 HZ = 400: AABBAABBAABBAABBAABBAABBAABBAABB

Both processes have the same priority and get the same amount of CPU. This
is independent of the HZ value.

Basically, there are timeslices which are 1/HZ long (1/100s on ix86). Every
1/100s the time interrupt interrupts the CPU and the scheduler is run and
decides which process should get the CPU. Most processes won't even be
considered, as they are waiting for something and thus sleeping (S in ps).
The ones that are runnable (R in ps) will be considered and their priority
and the amount of time the current process already had the CPU will be used
to calculate (goodness) which process is next. Note that not on every timer
tick, the current process will be changed, so you don't have a 100HZ
switching frequency.
There are some exceptions: Real time (SCHED_FIFO or SCHED_RR) will be
treated differently.  If a sleeping process becomes runnable (which happens
by an asynchronous event which is processed by the kernel), it will
immediately get the CPU => Good interactive performance. Also signals, I
believe, can result in the scheduler being run. Also the scheduler is run on
some other occasions, e.g. whenever the current process goes to sleep or
performs certain system calls. 
[This is my understanding of the scheduler from reading the code and reading
 postings in the kernel-list, and some details might be slightly wrong.
 Please correct me, if you know better.]


Now, if the scheduler itself and the task switching (and the cache updating)
did not need any time, it would be better to have very high HZ values,
because the multitasking would be more fine grained and the picture of
parallel running processes would be more perfect.

However, there is some overhead: Every time the timer generates an
interrupt, the CPU has to go to kernel mode (GPL 0) which takes some time,
has to run the scheduler and calculate priorities, which takes some time and
to choose a process and go back to user mode (GPL 3), which again takes some
time. If we changed the process, the contents of the caches will be mostly
useless, which again costs some performance.

Now, with the 386, Linus decided that 100HZ is a good compromise between
good parallelism and scheduling overhead. When he started working on the
alpha, much later, these machines were much faster and 1024HZ seemed the way
to go. So, no wonder people with today's iP-II machines, which are as fast
as the alphas some years ago, think that 100HZ is too low. 

There are some situations they may be right. If you have a couple of
processes which need the CPU, a higher HZ value would give a better
multitasking feeling. Note, that it's only a better impression, nopt that
your system is really faster. (It might be a little bit, if your processes
are implemented in a way, they wait for something, but cannot sleep for some
reason. Most time this is a poor design in your software, however.)

However, in normal situations (and there are exceptions, I know), if you
have many runnable processes, you do something wrong, as normally processes
should sleep, cause they have to wait for something. 

Also the above stated exceptions on the scheduler running out of order are
important and make the HZ value less important.

Ingo Molnar told me, that there was sort of a bug in the SMP scheduler code
which caused a woken up thread to only get the CPU after the next HZ tick,
if it was to run on the other CPU. This resulted in poor performance in some
of my multithreaded numerical apps, and on researching why this happens, I
saw it took some time till the subthread was woken up. It got remarkably
better after I set my scheduler to 400HZ, that's why I created the patch.
Note that I had rc5des runnning (SCHED_IDLE with Rik's patch) in the
background.

Now he told me, that this was fixed in 2.2.0-preX, but I couldn't test yet.
I'm really curious to see how it performs, when rc5des running reniced with
the new kernels as Ingo also told me it will be almost like idle.


Maybe there were or even are other scheduler strangenesses which cause a
slight performance increase or better interactive feeling with higher HZ
values. Also there might be (probably poorly designed) processes which
might profit from higher HZ values.


So the question is: We can increase the HZ value on Pentium or PII class
machines without wasting too much time. So it won't hurt anybody and
probably even result in slightly better performance for some cases. And it
will allow more fine grained time accounting, BTW. (It's no accident that
the resolution of the time command is only 1/100s for user and system time
on the ix86.)

However, as I know Linus, he will ask another question: Do we need it?
Isn't it better to fix the issues with the scheduler (if there are any left)
and tell the people to fix their apps instead of changing the kernel?
Linus never likes anything which just hides problems, and a higher HZ value
might hide problems with the scheduler or other parts of the kernel or
applications.


I think there is some advantage in having higher HZ values: The more precise
time accounting and the possibility to have more fine grained priorities.
However none of these is really important and I doubt that Linus will be
convinced by this. As said, the real reason for increasing HZ is probably
solved by MIngo's 2.2.0 scheduler changes.

So, please give better reasons.
Maybe some pseudo-RT apps?
Maybe userspace apps which do things the kernel doesn't properly support, so
they cannot sleep?


Sorry, this got too long! Have a nice evening ...
-- 
Kurt Garloff <kurt@garloff.de>                           [Dortmund, FRG]  
Plasma physics, high perf. computing              [Linux-ix86,-axp, DUX]
PGP key on http://www.garloff.de/kurt/        [Linux SCSI driver: DC390]

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
