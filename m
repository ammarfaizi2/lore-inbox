Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <156899-8100>; Mon, 11 Jan 1999 15:48:40 -0500
Received: by vger.rutgers.edu id <160502-8100>; Mon, 11 Jan 1999 13:08:54 -0500
Received: from ponzo.sonic.net ([208.201.224.170]:30781 "HELO ponzo.sonic.net" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with SMTP id <160516-8093>; Mon, 11 Jan 1999 12:31:39 -0500
Date: Mon, 11 Jan 1999 09:25:18 -0800
From: Scott Doty <scott@sonic.net>
To: linux-kernel@vger.rutgers.edu
Subject: Kernel Threads: Dr. Russinovich's response
Message-ID: <19990111092517.A13966@sonic.net>
References: <199812170249.VAA24987@escape.widomaker.com> <Pine.SUN.3.95.981218022548.796A-100000@gemini.math.tau.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.95.1i
In-Reply-To: <Pine.SUN.3.95.981218022548.796A-100000@gemini.math.tau.ac.il>; from Liran Zvibel on Fri, Dec 18, 1998 at 02:30:22AM +0200
Sender: owner-linux-kernel@vger.rutgers.edu

The following is Dr. Russinovich's response to criticisms of his
article.  He points out: "I expect my criticisms will help, not
hinder, efforts to get Linux ready for the enterprise" -- for this
reason, I thought I'd better forward it.

(Minor change:  I've reformatted the paragraphs.)

 -Scott
 - - -[ begin forwarded message ]- - -
Date: Thu, 07 Jan 1999 13:16:20 -0500
From: Mark Russinovich <mark@sysinternals.com>
Subject: Re: Linux threads -- as seen in NT Magazine (Alan, Linus,
  please read)

You are receiving this e-mail in response to correspondence you've
sent me or Windows NT Magazine regarding my statements about Linux
and enterprise applications.

-----------------------------------------

I've exchanged several rounds of e-mails with Linux developers that, in
spite of my arguments, propose that there is really nothing wrong with
Linux's support for SMPs (as of 2.1.132, which is close to what will be
called Linux 2.2).  I have been straightened out on a few minor
(peripheral) misconceptions I had, like my original belief that the X
library was not reentrant. However, I can only conclude that I've done a
poor job of explaining my reasoning. I hope to clarify things here, and
want to avoid and endless religious argument by focusing on substantive
technical shortcomings of Linux’s support for enterprise applications.

Before I start, I want to make it clear that what I view as flaws in Linux
won't necessarily affect day-to-day applications: they definitely affect
enterprise (network server) applications like Web serves, database servers
and mail servers, where competing in the enterprise means delivering the
highest performance possible. The SMP support and evolution to real kernel
threads is a work in progress that lags far behind commercial UNIX and
Windows NT. I expect my criticisms will help, not hinder, efforts to get
Linux ready for the enterprise.

The major limitations with Linux's thread support and SMP scalability are:

 - the implementation of select() is not suitable for high-performance
   enterprise applications
 - the non-reentrancy of the read() and write() paths will cripple the
   ability of enterprise applications to scale on even 2-way SMPs
 - the lack of asynchronous I/O make the implementation of enterprise
   applications more complex, and also affects their ability to scale
 - even with asynchronous I/O, there must be support in the kernel
   scheduler to avoid thread 'overscheduling', a concept that I'll explain

Given the fact that Linux does not support asynchronous I/O, a network
server application must rely on select() as its method to wait for
incoming client requests. Most network server applications are based on
TCP, where clients connect via a publicized socket port address. The
server will perform a listen() on the socket and then select() to wait for
connections. In order to scale on a SMP the application must have multiple
threads waiting for incoming connections (alternate architectures where
only one thread waits for requests and dispatches other threads to handle
them introduces serialization of execution and a level of interprocess
synchronization that will adversely affect performance). The problem with
this approach on Linux is that whenever a connection is ready on a listen
socket, all the threads blocked on the select() for the non-blocking
accept() will be signaled and woken. Only one thread will successfully
perform the accept(), and the rest of the threads will block. This effect
of having all waiters wake when there is I/O on a shared socket has been
called the 'thundering herd' problem. Threads wake up to take CPU time,
introduce context switching, and add addition system calls, all for no
benifit.


The non-reentrancy of the read() and write() paths has been downplayed by
even the core Linux developers, which comes as a surprise to me. To
demonstrate why this is such a major problem when it comes to enterprise
application scalability, I'll elaborate. Let's take a multithreaded SMP
network server application that is being driven by clients to maximum
throughput. Server applications accept incoming client requests, typically
read some data and then write (send) it back to the client. If the
application is being driven to capacity by the clients, the bottleneck
will become the read and write paths through the kernel. Assuming that
these calls don't block because the data being read is in a memory cache
(a web cache or database cache), and given that these paths are
non-reentrant, read and write execution is serialized across the SMP. That
means that at any given point in time there can be at most one thread on
the entire machine reading or writing.

While this might not seem like a big deal, it is actually probably the
biggest problem with Linux’s ability to compete in the enterprise right
now. On Windows NT, the network driver write path is serialized by NT's
NDIS network driver library, and this alone has put an upper ceiling on
NT's ability to scale and to compete with Solaris. Microsoft is addressing
this in NT 5 (and NT 4SP4) by deserializing the NIC write path. My point
is that just serializing the network driver is enough to affect
scalability - try to imagine what effect serializing the entire read and
write paths has.

The next limitation is Linux's lack of asynchronous I/O. This causes
problems when a network server application does not find requested file
data (eg. a web page or database records) in its in-memory cache. The
application will have to dedicate a thread to reading the required data.
Because there is no asynchronous I/O, the thread reading the data will
become indisposed when it blocks waiting for the disk. Thus, in the
absence of asynchronous I/O Linux is confronted with a dilemma: either
launch one thread for each client request, or limit scalability by having
a limited pool of threads, some or all of which can become a bottleneck
because they block for file I/O. Either approach limits scalability even
in situations where you have a 99% hit rate, but the misses (which account
for much larger responses for caching servers) account for 90% of the
bandwidth. This is the real world...

Even if asynchronous I/O is implemented (I've seen a request for it on the
current Linux wish list), scheduler support must be added to avoid
'overscheduling'. Overscheduling results when all threads in a server's
thread pool race to get new work. Most of the threads lose the race,
block, and race again. This is inefficient. The only way around it is to
keep threads slightly starved such that they never block waiting for a
request to process. This allows new requests to be serviced immediately
while responses requiring I/O are managed asynchronously on blocked
threads.

When more than two threads are active (running) on a CPU, they introduce
context-switching overhead as they compete for CPU time. Thus, the goal of
a server application is to have roughly one active thread per CPU at any
given point in time. Without scheduler support this can only be reasonably
accomplished by limiting the number of threads the server application
creates for each CPU so that the lack of threads itself will result in
missing opportunities to service new requests. Without asynchronous I/O,
however, this hurts scalability (as the above paragraph describes). NT
solves this problem with the notion of 'completion ports', where a
completion port represents completed I/O on a number of file descriptors,
and the scheduler limits the application to having only a certain number
of threads active per port. When a server thread blocks on I/O it becomes
inactive and the scheduler will wake up another one that is blocked on the
port so that the goal of the 1 thread/CPU goal can be maintained. This
model works well with asynchronous IO and SMPs and explains NT's good
standing in TPC and (unaccelerated) SpecWeb benchmarks.

Several of developers have boasted about how elegant Linux's clone model
is.  From an administrative point of view, it leaves something to be
desired. On other operating systems where a process is the container for
threads, the threads can be managed as a unit. They are visibly
identifiable as a unit and administrative tools and programming APIs can
treat them as a unit. On Linux, the flexibility introduced (which I see no
clear argument for) means that they can only be treated as unit
programmatically if they decide to share the same process group. From the
visibility standpoint of an administrator wanting to kill a set of clones
that share an address space, or monitor their resource usage as a unit,
the model is lacking. I can only surmise that Linux kernel developers
believe clones are elegant because their implementation has the minimal
impact on the kernel possible to approximate real kernel threads. I
understand the perspective, but the result is less than elegant.

After careful examination of LinuxThreads, the defacto Linux threading
library, it appears to me that there is at least one sever performance
problem with its current implementation. That problem lies in the way that
the thread library manages signals on behalf of all the threads by
implementing global signal handlers. This is especially problematic
because all threads that perform a sigwait() call will wake-up when a I/O
is ready for any file descriptor, regardless of whether any given thread
happens to be waiting for I/O on that descriptor. The thread library
performs a check for each thread to see if its wait was satisfied, and if
not, puts the thread back in a wait state.

This makes sigwait() useless in any multithreaded application that cares
about performance. What I don't understand about the LinuxThreads
implementation is why the library doesn't take advantage of process groups
to handle signal broadcast, and otherwise let each thread manage its own
signal handlers, using process ids for targeted delivery? Is this
implementation required because of Linux architectural limitation or has
it simply not been optimized? In the same vein, why is there a need for a
'manager' thread to begin with?

A less significant area where the Linux thread model can be viewed as
immature is in the fact that the Memory Manager is unaware of threads.
When it performs working set tuning (swapping out pages belonging to a
process) it will tend to be much more aggressive with clones sharing an
address space, since the tuning algorithms will be invoked on the same
address space on behalf of each clone process that shares it. Several
tuning parameters are store privately in a clone's task control block,
like the swapout target, so the Memory Manager will be unaware of any
tuning it has just recently performed on that address space, and blindly
go through its algorithms anew.

Thus, there are a number of critical areas that must be addressed before
Linux can be considered to have a real (competitive) kernel-mode threads
implementation and a scalable SMP architecture. And until it has these
things Linux cannot compete in the enterprise with UNIX rivals or with
Window NT.

Thanks for your e-mail.

-Mark

Mark Russinovich, Ph.D.
Windows NT Internals Columnist, Windows NT Magazine
	   http://www.winntmag.com
The Systems Internals Home Page 
	   http://www.sysinternals.com
 - - -[ end forwarded message ]- - -

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
