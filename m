Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbTJMNGs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 09:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbTJMNGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 09:06:48 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:17650 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S261733AbTJMNGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 09:06:45 -0400
Date: Mon, 13 Oct 2003 15:07:43 +0200 (DFT)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@isabelle.frec.bull.fr
To: linux-kernel@vger.kernel.org
cc: Sylvain Jeaugey <sylvain.jeaugey@bull.net>
Subject: [RFC] cpuset proposal
Message-ID: <Pine.A41.4.53.0310131503500.173334@isabelle.frec.bull.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We'd like to introduce our 'CPUSET' Linux feature to the world. It has
been discussed a few weeks ago and received some positive feedback on
linux-ia64 and LSE. Since then we have ported it to i386 (as suggested by
Stephen Hemminger) and would appreciate to receive comments from a wider
community.

Any opinion, comment, rant, flame, mark of interest or despise is more
than welcome.

For a more complete description or source code see
http://www.bullopensource.org/cpuset/

We'd be also curious about whether a feature of this kind or addressing
the same issue would be likely to make it into a future version of the
kernel.

Thanks,

	Simon & Sylvain.


What are CPUSETS ?
------------------

CPUSETs are lightweight objects in the linux kernel that enable users to
partition their multiprocessor machine by creating execution areas. This
has been somewhat inspired by the pset or cpumemset patches existing for
Linux 2.4. A virtualization layer has been added so it becomes possible to
split a machine in terms of CPUs.

The main motivation of this patch is to give the linux kernel full
administration capabilities concerning CPUs. CPUSETs are strong jails, and
a process running inside this predefined area won't be able to run on
other processors than those given to him. Some domains in which it can be
useful :

    * Web Servers running multiple instances of the same web application.
    * Servers running different applications (for instance, a web server
      and a database).
    * HPC applications, especially in NUMA machines.



CPUSETS allow to:
-----------------

   1. create sets of CPUs on the system, and bind applications to them
   2. translate the masks of CPUs given to sched_setaffinity() so they
stay inside the set of CPUs. With this mechanism, processors are
virtualized, for the use of sched_setaffinity() and /proc information.
Thus, any former application using this syscall to bind processes to
processors will work with virtual CPUs without any change.
   3. provide a way to create sets of cpus *inside* a set of cpus : hence
a system administrator can partition a system among users, and users can
partition their partition among their applications.
   4. Change on the fly the execution area of a whole set of processes (to
give more resources to a critical application, for example).

These features have been implemented as a kernel patch for Linux 2.6 and a
suite of userland tools.


Typical CPUSET Usage:
---------------------

    * CPU-bound applications : Many applications (as it is often the case
for HPC apps) use to have a "one process on one processor" policy. They
can use sched_setaffinity() to do so, but what if we have to run several
such apps at the same time ? One can do this by creating a cpuset for each
app.
    * Web Serving : A server containing a web server (apache for instance)
and a database (MySQL, Oracle) may want to have one part of the machine
dedicated for each task. A cpuset can be created for each task. If the
server is used to run two instances of this web-system, cpusets can be
used to split the system in two, and then in each partition create one
area for the web server and one area for the database.
    * User administration : an administrator may give fixed numbers of
CPUs to some classes of users and leave the rest to other users, for
instance. He can do so by creating cpusets and assigning them to users.
    * Critical applications : processors inside strict areas may not be
used by other areas. Thus, a critical application (real time ...) may be
run inside an area and be sure that other processes won't use its CPU.
This implies that others applications won't be able to lower its
reactivity. This can be done by creating a cpuset for the critical
application, and another for all the other tasks.


Future:
-------
	* In the future, other features such as associating a memory allocation
policy (such as local node, or round robin) to a set of cpus might be
added.

	* We are looking forward to the inclusion of the cpuset feature in a
more visible project...
