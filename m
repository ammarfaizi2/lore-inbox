Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbULTRDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbULTRDr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 12:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbULTRDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 12:03:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:26009 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261565AbULTRCv (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Mon, 20 Dec 2004 12:02:51 -0500
Date: Mon, 20 Dec 2004 18:02:48 +0100 (MET)
From: "Loic Domaigne" <loic-dev@gmx.net>
To: piggin@cyberone.com.au
Cc: nptl@bullopensource.org, Linux-Kernel@Vger.Kernel.ORG, mingo@elte.hu
MIME-Version: 1.0
Subject: Re: Re: OSDL Bug 3770
X-Priority: 3 (Normal)
X-Authenticated: #19395655
Message-ID: <9785.1103562168@www38.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nick,

Thanks for your reply! 
 
L = Loic 
N = Nick 

N> lkml: We're discussing the fact that on SMP machines, our realtime 
N> scheduling policies are per-CPU only. This caused a problem where a 
N> high priority task on one CPU caused all lower priority tasks on that 
N> CPU to be starved, while tasks on another CPU with the same low 
N> priority were able to run.

That summary should readily motivate you to make a patch ;-) 

But thing are a bit worse actually. It is easily to build an example 
where a lower priority thread is executing while a higer priority thread
is waiting. For instance, something like: 

CPU0:
Thread with prio 30 gets the CPU.
Thread with prio 25 is waiting.

CPU1:
Thread with prio 20 gets the CPU.
Thread with prio 15 is waiting.

This is a corollary of the OSDL Bug #3770. A practical example has been 
built by Sebastien Decugis. 


L> Although POSIX legally permits such implementation for realtime 
L> policy on SMP machines, this implementation is clearly *NOT* 
L> REASONABLE.
N>
N> Well I haven't done much in the realtime area... but nobody has 
N> complained till now.

But now you have some complains ;-) 


L> The reason is extremely simple: the application *CANNOT* necessarily 
L> known that it gets stuck behind a higher-priority thread (though it 
L> could had run on another CPU if the scheduler had decided otherwise). 
L> That's *NOT* doable to program in a deterministic fashion in such 
L> "realtime"-environement
N>
N>
N> You could use CPU binding. I'd argue that this may be nearly a
N> requirement for any realtime system of significant complexity on 
N> an SMP system.

Agree. Real-world system will likely want to have a control on which 
CPU the threads runs on SMP machine. 

Does Linux tolerate hard CPU binding? By hard CPU binding, I mean 
that the application tells the scheduler "I want to run there", 
and the scheduler schedules the thread(s) "there" regardless if it 
makes sense or not ( The decision is left to the application). 

With such hard CPU binding, it seems to me that our "unfortunate 
behavior" isn't problematic anymore. Because the application can gain 
control again over the scheduler (so to speak). 

On the other hand, if the scheduler might ignore the CPU binding 
(thus, not hard binding, but rather CPU affinity), then I am afraid 
that the issue might remain problematic.  


N> *But*, notice that the program in question did not run on UP and
N> randomly fail on SMP, rather it would not work on single processor 
N> AT ALL.

The test is of course "broken" in some sense, and does nothing useful... 
But the principal goal of this test is showing a potential issue with 
a few lines of code. The fact that the test doesn't work on UP machine 
is _irrelevant_ here. 

Relevant is: if I have compute bound threads of various priority, some 
high priority threads might stuck behind some low priority threads. 
That's not really realtime friendly, isn't it? 


N> The driver really needs to sleep, use a mutex, use a lower priority,
N> or  something in order for it to work.
N>
L>
L> NO! It is not the responsability of the application to fix that 
L> behavior! We can in our case because 'we know', but some 
L> applications don't!!!
L>
N>
N> That's a bit hand-wavy ;) but I don't dismiss it out of hand because 
N> as I said, I'm not so familiar with this area. I would be interested 
N> in an example of some application where this matters, and which 
N> absolutely can't use any synchronisation primitives.

Perhaps it would help to consider a real-world example. Here is an 
example inspired from some Air Traffic Control Systems. 

(*) You have one thread that computes the position of an airplane or 
    "track". This thread has the highest priority because all other 
    tasks like collision avoidance computation etc. depends of 
    airplanes track.

    This thread is essentially compute bound. It tells other 
    interested threads when new data for the airplanes tracks are 
    available (using condvars and co) and goahead with the next tracks. 
    
(*) You have another bunch of threads that computes waiting for relevant 
    stuff for air traffic control, for instance if two trajectories 
    shall interesect. 

    These threads are essentially compute bound too. They are first 
    waiting for the new airplaines positions (from the previous thread) 
    and then proceeds with their computations.

Interesting is that the computation of the airplaines tracks and 
collision avoidance overlap. But, when required, the tracks computation 
has precedence over other tasks. 

The collision avoidance computation has nice scalability property. 
You compute the possible collision pairwise between 2 airplanes. All 
pairs can be computed independantly. 

Now it is not usual that the computations to be quite CPU intensive, and 
so SMP machines are used. With the current Linux scheduling decision, 
some threads responsible for the collision avoidance might get stuck, 
or do I miss something? 

[
Note aside- Of course, it is a simplified version of real systems. 
The Truth is, as usual, more awful. 

And yes! Linux has a niche in Air Traffic Control business
]  


N> If it were that easy, we might have a single queue for _all_ tasks.
N> 
N> The main problem is the cost of synchronisation and cacheline 
N> sharing. A secondary problem is that of CPU affinities - moving a 
N> task to another CPU nearly always has some non zero cost in terms 
N> of cache (and in case of NUMA, memory) efficiency.
N> 
N> Our global queue scheduler was basically crap for more than 4 CPUs. 
N> We could give RT tasks a global queue with little impact to non-RT 
N> workloads (in fact, I think early iterations of the 2.6 scheduler 
N> trialed this)... but let's not cripple the RT apps that do the right 
N> thing (and need scalablility).
 
I do not have the necessary knowledge on the Linux scheduler. And I 
do not pretend that implementing an efficient scheduler on a lot 
number of target platforms as Linux does is an easy thing ( actually, 
I quite admire the work done here! ).  

Perhaps the best alternative would to offer hard CPU binding (if 
not already provided). Hard CPU binding is likely needed by the 
HPC guys too (likely working, on a bunch of SMP machines connected 
together by a high-speed network). 


N> another problem is that scheduling may not be O(1) anymore, 
N> if you have CPU affinity bindings in place.

Designing an O(p) scheduler, where @p is the number of processors is 
theoritically 'easy'. When a thread has been picked-up and assigned to 
a CPU with the O(1) scheduling algorithm, re-iterate the same algorithm 
on the remaining threads / unbound CPU. Since usually p is constant, 
the scheduling algorithm remains hence O(1) for the SMP machine. 
However it doesn't scale with the number of processors. Which can make 
the algorith not really practical...


N> To summaries, I believe that if per-CPU RT queues is allowed within 
N> POSIX, then we want to go with the sanest possible implementation, 
N> and force any broken apps to fix themselves.... 

POSIX is rather vague concerning the scheduling on SMP machine, because 
no real consensus could be reached between the Posix.1b and the Posix.1c 
guys. As a result, POSIX says timidely: 

"For application threads with scheduling allocation domains of size 
greater than one, the rules defined for SCHED_FIFO, SCHED_RR, and 
SCHED_SPORADIC shall be used in an implementation-defined manner."

With such loophole, the term "broken apps" is a kind of fuzzy. 
Minds you, but scheduling the highest prio thread on a CPU and 
blocking the other threads (ignoring hence the SMP feature, and 
having the same scheduling as on an UP) is a perfectly legal 
POSIX implementation... 
With such implementation, you get suddently a lot of 'broken apps' (!) 

In order words, POSIX allows you to put vinegar, strawberry jam, 
red-hot chili pepper and mayo on your hambuger. Whether it really 
tastes is another matter ;-) 


Cheers!
Loic.

-- 
--
// Sender address goes to /dev/null (!!) 
// Use my 32/64 bits, ANSI C89, compliant email-address instead:   

unsigned y[]=
{0,34432,26811,16721,41866,63119,61007,48155,26147,10986};
void x(z){putchar(z);}; unsigned t; 
main(i){if(i<10){t=(y[i]*47560)%65521;x(t>>8);x(t&255);main(++i);}}

Psssst! Mit GMX Handyrechnung senken: http://www.gmx.net/de/go/mail
100 FreeSMS/Monat (GMX TopMail), 50 (GMX ProMail), 10 (GMX FreeMail)
