Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbTJHCcC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 22:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbTJHCcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 22:32:02 -0400
Received: from mail.inter-page.com ([12.5.23.93]:43017 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S261298AbTJHCb5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 22:31:57 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'Linus Torvalds'" <torvalds@osdl.org>
Cc: "'Albert Cahalan'" <albert@users.sourceforge.net>,
       "'Ulrich Drepper'" <drepper@redhat.com>,
       "'Mikael Pettersson'" <mikpe@csd.uu.se>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
Date: Tue, 7 Oct 2003 19:31:04 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAeFyz/E9s7UuIuyU9yNzATQEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
In-Reply-To: <Pine.LNX.4.44.0310071743370.32358-100000@home.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<holistic theoretical rumination>

I guess my disconnect happens at the "what do you mean by process" level.

To me, the idea of a process is defined at the heat/light barrier with the
kernel.  A process has unity of interface.  That is, everything on "my side"
of the all encompassing interface is one process, one "me".  File
descriptors are not (in this view) "software level abstractions", they can't
be because they exist beyond the control of the application side of the
process, they must then be properties of the interface between process and
kernel.  That makes them inherently a defining property of the boundary
between "process" and "world".

A "thread" (ne "thread of control") is any one pathway of fact of execution
taking place on "my side" which sees the world through that interface.
Threads within their process are organs within the common function of a
single entity.  They are not independent and they come and go at the
sufferance of the whole.  Threads are organs in the body of a process (even
the posix-style "detached" thread, which is only "detached" in the
who-waits-for-whom when someone dies/exits sense).

There is the implication of singularity to that interface in the use of
those two words.  That singularity exists as expressed fact in the /proc
filesystem as it exists today and I suspect, were you to take a poll, that
is the way most people would think about the words.  (Not that more than
half the people are right about anything more than half the time. 8-)

Without this compositing what makes up the differences between "process"
"process group" "thread" and "thread group".  I doubt I am the only one
confused:

>From 2.6.0-test5:

File: include/linux/sched.h (lines 47 and 53)
#define CLONE_THREAD    0x00010000      /* Same thread group? */
#define CLONE_DETACHED  0x00400000      /* Not used - CLONE_THREAD implies
detached uniquely */

File: kernel/fork.c (line 778) [copy_process]
printk(KERN_WARNING "%s trying to use CLONE_THREAD without CLONE_DETACH\n",
current->comm);


The same implicit unity-of-interface is part-and-parcel of the requirement
that the signal handlers must be the same. 


Now when different processes "just" share the same VM; e.g. the thing that
the current (2.4 and prior) kernels do where you (only) clone the virtual
memory system (etc); has never really felt "thread-like" to me.  I hunger to
give it a different name.  They are like conjoined twins.  They have this
common connection, this body, but they have their separate interface to the
rest of the world.  Their sense of self is distinct even though their bodies
are melded in a poison-one-both-die reality.

The problem is we are trying to cram three paradigms into two words.

So anyway, posix people (yes I know 8-) talk about the M:N relationship (M
posix-threads on N LWPs [or do I have that backwards 8-)]).

The old linux kernel models P:1.  We create a new process, no matter what,
which may be copied or conjoined as we see fit.

The truth is that the new kernel models P:M:N because we can do both the old
thing and the new thing since the techniques are not exclusive of one
another.

When you start with one unified process image you can clone() it in any of
the old ways and produce the conjoined twins (e.g. do a P++ operation).
When you clone with CLONE_THREAD you really ought to be doing an "M++".
Whether the posix thread library does a N++ or an M++ operation for a
pthread_create call is neither here nor there.  And there is no reason that
you cannot conjoin-clone and thread-clone repeatedly and variously from the
same basic seed entity.

The natural extension of this logic would be to simply state that
CLONE_THREAD makes a thread instead of a conjoined clone thingy that you get
in the absence of this flag.  And being a thread, the new entity "will" have
the expected unity of interface as the price of being "more than twins".

In the resulting model there is no /proc/<pid>/<tid>/fd directory because
the unity of process puts it all in /proc/<pid>/fd.  The almost everything
in /proc/<pid>/<tid> is a simlink up one level.  The primary members are the
thread specific cpu and status accumulators/control points.  Similarly the
cpu and status/control points for "non-threaded" process can be implemented
entirely within (unilaterally moved to) /proc/<pid>/<the-only-tid> with
simlinks in /proc/<pid> to /proc/<pid>/<the-only-tid> for everyting but cpu,
and cpu is unilaterally the summary of all the tid(s) of which there happens
to be just one.

It's deterministic.
It's unified.
It will surprise the least number of people. 
It loses no options or features.
It's completely backward compatible.
The distinction between CLONE_THREAD and (CLONE_SIGHAND|CLONE_VM[|CLONE_FS])
remains clear, functional, and valuable.

</holistic theoretical rumination>

Rob.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Linus Torvalds
Sent: Tuesday, October 07, 2003 5:55 PM
To: Robert White
Cc: 'Albert Cahalan'; 'Ulrich Drepper'; 'Mikael Pettersson'; 'Kernel Mailing
List'
Subject: RE: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?


On Tue, 7 Oct 2003, Robert White wrote:
> 
> What is gained by having the independent file descriptor context that
would
> be *broken* for lack of that independence?

You're coming at it from the wrong end. Sharing resources is inherently
bad. If there is no reason to share, you shouldn't share.

The reason people use threads is that sharing the VM space has real 
advantages: it makes context switching much cheaper (fewer hw resources in 
the form of TLB usages) and it allows for much faster synchronization 
through a shared address space.

But the same isn't true of file descriptors or a lot of other software-
level abstractions. There are no inherent advantages to sharing, and in
fact sharing just gives more opportunity for race conditions, bad
interaction etc.

For example, one reason _not_ to share is that the subthread may want to 
be as invisible to the "main thread" as possible. That's just good 
programming practice - trying to isolate and encapsulate as much data as 
possible.

The same way you shouldn't make all your variables global, you shouldn't 
make all your data structures global unless you have a reason.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


