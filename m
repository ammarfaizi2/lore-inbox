Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264062AbSIVLvr>; Sun, 22 Sep 2002 07:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264070AbSIVLvq>; Sun, 22 Sep 2002 07:51:46 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:62105
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S264062AbSIVLvp>; Sun, 22 Sep 2002 07:51:45 -0400
Message-ID: <3D8DB040.7060402@redhat.com>
Date: Sun, 22 Sep 2002 04:57:52 -0700
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020812
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: first NPT vs. NGPT vs. LinuxThreads benchmark results
X-Enigmail-Version: 0.65.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This is a first mail with additional information about the NPT
library, this time about performance.  The announcement with the
mentioning of 100,000 threads seems to have caused some interest.
Most people concentrated on the scalability aspect which is important.

Now we are able to release a few initial benchmark results.  The
benchmarking was done using a simple benchmark program we developed
during the NPTL development.  This does not mean it is tailored to
show NPTL in especially favorable light.  To the contrary: we used it
to analyze potential weak points of the 1-on-1 approach.

What is measured is simply the time to create and destroy threads,
under various conditions.  Only a certainly, variable number of
threads exist at one time.  If the maximum number of parallel threads
is reached the program waits for a thread to terminate before creating
a new one.  This keeps resource requirements at a manageable level.
New threads are created by possibly more than one thread; the exact
number is the second variable in the test series.

The tests performed were:

create threads in a row:

   for 1 to 20 toplevel threads creating new threads

     create for each toplevel thread up to 1 to 10 children


(The number of times we repeated the thread creation operation is
100,000 - this was only done to get a measurable test time and should
not be confused with earlier 'start up 100,000 parallel threads at once'
tests.)


The result is table with 200 times.  Each time is indexed with the
number of toplevel threads and the maximum number of threads each
toplevel thread can create before having to wait for one to finish.
The created threads do no work at all, they just finish.


The problem the benchmark program has to solve is ideal for an M-on-N
implementation.  It consists simply of creating a new thread, running
it for a tiny bit of time, and terminating it.  In an M-on-N
implementation this only means to modify a few user-level data
structures.  For the startup a data structure describing the thread
must be created, the context (registers etc.) must be set up (NGPT
uses makecontext() which is implemented completely at user level for
x86 on Linux).  At termination time the data structure is disposed off
and that is it.  No system call required.

For an 1-on-1 implementation the situation is a bit more difficult.
The kernel thread underlying the user-level thread has to be created
by the kernel.  Similarly, to terminate a kernel thread the kernel has
to be called.  In total we have at least two exits from the kernel,
two entries and two context switches.


The whole series was run for the old LinuxThreads implementation, NGPT
2.0.2, and the NPTL 0.1 code.  All tests are performed using the
2.5.37 kernel.  The huge number of threads created proved to be enough
to stabilize the measurements.  Running the same benchmark twice
showed little variation (< 1%).  Nevertheless these measurements should
be taken with the usual grain of salt even though we stand behind the
correctness of the result.  All results are reported in µsec
(micro-seconds)

We summarize the result of the benchmark runs in two tables.  In both
cases we flatten one dimension of the measurement result matrix with a
minimal function.

   http://people.redhat.com/drepper/perf-s-100000-pro.pdf

This graph shows the result for the different number of toplevel
threads creating the actual threads we count.  The value used is the
minimal time required of all the runs with different numbers of
threads which can run in parallel.

What we can see is the NGPT is indeed a significant improvement over
LinuxThreads; NGPT is twice as fast.  The thread creation process of
LinuxThreads was really complicated and slow.  What might be surprising
is that a difference to NPTL is so large (a factor of four).

The second summary looks similar

   http://people.redhat.com/drepper/perf-s-100000-par.pdf

This time we display the minimum time needed based on the number of
toplevel threads.  The optimal number of threads which are used by each
toplevel thread determines the time.

In this graph we see the scalability effects.  If too many threads in
parallel try to create even more threads all implementations are
impacted, some more, some less.



The results of this test series are:

- - LinuxThreads indeed had several problems

- - NGPT indeed run much faster (twice the performance)

- - NPTL runs four times faster than NGPT in a benchmark which by all
   means should favor an M-on-N implementation.


We will soon have more benchmarks showing the thread libraries in
other real-world situations, such as IO-intensive workloads.

Any who wishes to run own tests should feel encouraged to do so.
Please share the results especially if they show problems in the NPTL
implementation.


Interested parties are encouraged to join the mailing list created for
the purpose of discussing NPTL:

   https://listman.redhat.com/mailman/listinfo/phil-list


Ulrich Drepper
Ingo Molnar


- -- 
- ---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE9jbBD2ijCOnn/RHQRAkcoAKCS8Gw5ZdanA+N0FT3P7D+A2Q7EKwCeJ3Zo
PhGvJ7TfoXY+MhoE1zG4BrA=
=cssc
-----END PGP SIGNATURE-----

