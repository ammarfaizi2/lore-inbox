Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155178AbQELUDZ>; Fri, 12 May 2000 16:03:25 -0400
Received: by vger.rutgers.edu id <S155276AbQELTyz>; Fri, 12 May 2000 15:54:55 -0400
Received: from clark.casco.net ([204.119.56.2]:51960 "HELO clark.casco.net") by vger.rutgers.edu with SMTP id <S155121AbQELTm1>; Fri, 12 May 2000 15:42:27 -0400
Message-ID: <391C6157.ED2992A1@pioneer.net>
Date: Fri, 12 May 2000 12:53:59 -0700
From: George Anzinger <george@pioneer.net>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.5-15 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@timpanogas.com>
Cc: linux-kernel@vger.rutgers.edu, torvalds@transmeta.com
Subject: Re: Proposal for task_queue() WorkToDo Optimization for Network File  Systems
References: <391B77F6.14E6F9DA@timpanogas.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Jeff,

I wonder if the light weight thread you are talking about might be a
kernel thread running with policy SCHED_FIFO.  On this list about a week
ago there was a patch for the scheduler to separate real time tasks from
the others and MontaVista Software has a scheduler patch that goes a bit
further in this direction at http://www.mvista.com/realtime/rtsched  

This approach allows the scheduler to take care of the context switch
and also allows the system to be customized to allow, should one so
desire, real time tasks to run before the WTD tasks.  I think it is nice
to keep this option open, but then I am a real time nut.

George

"Jeff V. Merkey" wrote:
> 
> Linus,
> 
> It's clear to me after reviewing my posts that I failed utterly in
> explaining this to everyone.  So I am submitting a formal proposal that
> explains the nature of this optimization, how it is implemented inside
> of NetWare, how it works, and what it really entails, and it's potential
> usefulness to Linux.  BTW, My page cache problems are resolved thanks to
> your help today :-).
> 
> Work To Do Model in NetWare
> ---------------------------
> 
> The Work To Do scheduling model in NetWare is an optimization that
> significantly reduces network latency and increases network file system
> bandwidth and performance by providing a specialized scheduling semantic
> for creating implied associativity between network and file system I/O.
> WorkToDo's (WTDs) are not an architecture within NetWare, but an
> optimization.  Since they are an optimization, they don't follow fixed
> rules, and bypass NetWare's normal I/O framework.
> 
> WTD Kernel Implementation
> --------------------------
> 
> A WTD is a great deal like a task procedure in Linux.  It's a structure
> that looks like a callback. i.e.
> 
> struct _WTD {
>    struct _WTD *next;
>    struct _WTD *prior;
>    ULONG (*function)(struct _WTD *wtd);
>    void *context;
>    ULONG flags;
>    BYTE *data;
> } WTD;
> 
> These requests get linked onto a global list i.e.
> 
> WTD_HEAD -> WTD -> WTD -> WTD -> WTD
> 
> The true nature of this optimization is not as a scheduling primitive,
> but that it allows file systems and network drivers to create an implied
> associativity between incoming network packets and file system requests,
> and provides a low latency optimization to process incoming I/O
> quickly.   Work To Do's are scheduled by protocol stacks and the file
> system in NetWare by placing them on a global locked list.  The kernel
> keeps a global list with a single spin lock over the WTD list head of
> all WTD requests.  The system by default creates a very lightweight
> thread object called a "worker thread".  "worker threads" in NetWare are
> little more than a stack with a very minimal structure and a stack
> pointer within the structure.
> 
> The main kernel code paths that perform all context switching always
> check this queue, and if there's a WTD element(s) there, it will swap in
> a worker thread and run the requests one at a time.  The NetWare kernel
> also hooks ALL device interrupt handlers, and remembers which interrupts
> belong to Network cards and which interrupts belong to disks, and on any
> interrupt originating from a network or disk device, will perform
> "preemptive I/O".  I will explain how WTD's are processed during context
> switching, then describe WTD's that are processed using "preemptive
> I/O".
> 
> If any of the requests go to sleep while each WTD element is called in
> order, the kernel will set a flag telling the system to spawn another
> "worker thread", which upon the first worker going to sleep, will run
> the next worker thread and continue the list until all the WTDs are run
> or a preset limit of work to do's in a row is reached.  There are limts
> on how many WTD's can be run in a row for each context switch to prevent
> WTDs from starving all other system threads.  The usual limit is 15.
> This means is 15 WTD's all went to sleep (then 15 worker threads also
> got spawned), the system should context switch, and allow everyone else
> to run, then on the next context switch, process more WTDs.  This is how
> it's implemented in the context switch code in NetWare.  After WTD
> processes complete, the system does not deallocate the "worker threads".
> If 30 "worker threads" got spawned, the system leaves then on a special
> list, and reuses them as WTDs are scheduled and processed.  This allows
> the system to keep worker threads around that "expand" their numbers
> dynamically and handle the measured I/O bandwidth hitting the server
> within a given time frame.  NetWare has a config option that will
> reclaim and deallocate worker threads if they haven't become active in
> several minutes.  It also lets you preallocate large numbers of them if
> you are going to deploy a 1000 user server.
> 
> The context switching description isn't the overall optimization, but
> describes how the base WTD request manager is organized.
> 
> Preemptive I/O
> --------------
> 
> This does look a lot like top and bottom halves in Linux, but WTD's have
> an implied associativity with incoming packets and the target file
> systems.
> 
> All device interrupt handlers are hooked in NetWare to allow the
> interrupt service routine exit procedure to preempt the current running
> process, and swap in a worker thread context when the ISR does it's
> interrupt return.  Incoming network packets have a reserved memory
> header that it scheduled as a WorkToDo element by protocol stacks if
> they are file system requests that may block.  When a LAN card receives
> a packet in NetWare, it calls the protocol stack from the interrupt
> thread.  The protocol stack sniffs the packet, and if the incoming
> packet is a file system request, it will ask the file system if the data
> block is in cache.  If it's in cache, it will imediately format the
> outgoing packet to the user with the cache page, and schedule the return
> packet as a WTD element.  When the Network card ISR completes, if any
> WTD's were scheduled during the interrupt, the kernel swaps in a worker
> thread, and preempts the current running process, and places it at the
> HEAD of the primary scheduling queue and not the tail.  It does this to
> give I/O priority processing in the system.  Any requests that may sleep
> on file locks are also detected by the protocol stacks and converted
> into WTD's (as are some types of routing requests i.e. NLSP routing may
> need to ping another machine for a route, and may go to sleep doing
> it).  The WTD's are then run and in most cases (since the data was in
> cache), the user get's their data back as soon as the ISR completes.
> 
> This has the effect of always processing incoming I/O with the highest
> system priority.  This optimization is why you can actually put 5000
> people on a single NetWare server, and achieve excellent performance and
> response time for every user.  It works by reducing latency
> significantly for Network and Network File System I/O.  The WTD model is
> very useful for mirrored I/O that goes across machines over a network as
> well, and made SFT III a lot less piggish.
> 
> The question is how many pieces of this are already in Linux.  I haven't
> seen quite this optimization, but would propose that it be implemented
> with a special atomic task_queue with a very lightweight thread_object.
> Microsoft uses fibre's which coincidently, appeared in NT three months
> after WorkToDo's were disclosed at a Novell Brainshare Conference in
> front of several of their engineers who were in attendance, though the
> implementation they came up with was not exact (because they really
> didn't know how they worked in NetWare but for some odd reason, had to
> have something like them at the time).
> 
> This optimization is what allows NetWare to support very large numbers
> of clients and with high bandwidth.  The key is how heavy context
> switches are in Linux.  In NetWare, you can do over 1,000,000 on a PPro
> 200Mhz.  Linux seems very heavy by comparison.  I think the preemptive
> I/O optimization alone would allow Linux to Equal NetWare and match it's
> speed and capability with a configuration of 5000 users on a single
> linux server.
> 
> In Linux, the deleterious side effects would be that heavy Network I/O
> would potentially starve applications running on the server (would make
> those who use Network I/O like web servers run faster though).  In
> NetWare, limiting how many work to do's in a row could run, and how
> often new work threads could be spawned tuned most of these issues away
> over the years.
> 
> I respectfully submit this proposal for consideration, review, and
> comment.
> 
> Respectfully Submitted,
> 
> Jeff Merkey
> CEO, TRG
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.rutgers.edu
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
