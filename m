Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbTJHAmH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 20:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbTJHAmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 20:42:06 -0400
Received: from mail.inter-page.com ([12.5.23.93]:3592 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S262914AbTJHAmB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 20:42:01 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'Linus Torvalds'" <torvalds@osdl.org>
Cc: "'Albert Cahalan'" <albert@users.sourceforge.net>,
       "'Ulrich Drepper'" <drepper@redhat.com>,
       "'Mikael Pettersson'" <mikpe@csd.uu.se>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
Date: Tue, 7 Oct 2003 17:41:13 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAwtz+A6aJAkeufXSGK2GIiwEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
In-Reply-To: <Pine.LNX.4.44.0310071621280.16239-100000@home.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Linus Torvalds


> And when you have _that_ kind of model (with assymetric specialized 
> threads), it makes perfect sense for the threads to have independent file 
> descriptors.

(Preface disclaimer) I don't "just use pthreads" as the other half of my
life is embedded work using RTXC (od nausium 8-) and on occasion windows
nonsense.  I've also used the LWP features of solaris without the pthread
library.  I experience the differences between the posix thread and the
lightweight process paradigms daily.

What is gained by having the independent file descriptor context that would
be *broken* for lack of that independence?

Even in a game or for very specialized threads that don't talk much if at
all, can you give me one example where two threads simply *must* have the
same file descriptor number active for two separate files at the same time?

That is, where this is the truth table for FDs:

         Thread-A  Thread-B
          File-X    File-Y
Works:     10        10
Broken:    10        11

I can, truthfully, think of two models only.

In the first model each thread is managing FILES_MAX separate files (or at
least THREADS times FILES_PER_THREAD may reasonably exceed FILES_MAX for the
whole process space).  In short, you only "need" to do this if you are
expecting slam up against the maximum open files limit beyond the ability of
the system administrator to extend that limit.

In the second, one has a data space image (process etc) shared across
multiple computers (clustering) or times (restore-from-sleep) and one is
trying to coerce file handle numbers to match the common data without
kernel-level assistance.  And for this one every mental simulation I can
envision ends up stonewalled when the overseer thread tires to make the
overseen image get the right things connected up in "the other" file
descriptor table.

Both models are impractical, and the first can (and you allege already do)
exist using existing options (e.g. not using CLONE_THREAD).

The only other conceivable reason for having two different files open with
the same descriptor number is if you are trying to match up with a system
that requires that the numbers themselves have specific values.  I know of
no such code except for the establishment of standard input (etc) before an
exec().

Since the fork-and-exec model is the only time when certain files simply
must have certain descriptors, and since that is done after the fork, there
is no place imaginable where a running process with multiple threads "needs"
particular descriptor numbers.

So either model can be created and essentially supported in the current code
base.

But should it be?

Here we are with my betters discussing the /proc/self/fd/* (etc) question.
So a lot of effort is being expended to allow a feature (separate file
descriptor tables in conjoined threads) with the consequent complexities in
all the related stuff (fuser etc, elaborated elsewhere in the thread) simply
to create the opportunity for more and interesting errors in a new feature.

You said it yourself (or at least I inferred you to say it 8-), for the
pthread stuff this will not happen anyway because the clone operation
can/will be called by the library with CLONE_FILES set anyway.

Perhaps I am a lesser being, but were the need to arise to do this specific
decoupling, wouldn't this be done using the old semantics anyway?

So CLONE_THREAD is supposed to create (essentially) the conjoined LWP
environment in as much as you are creating a "thread within a process", but
you want to decouple "file" from "process" to separately and multiply
re-couple it with each "thread".  Yet further, you want to leave "file"
bound to "process" if there is only one thread.  That is an expensive
change, especially when it is apparently being done case-by-case. You aren't
unilaterally redefining "process" to be a set of one or more threads, if you
were /proc/<pid>/fd/* would have to disappear in favor of
/proc/<pid>/<tid>/fd/* and /proc/self would mutate into a set of dynamic
references, some to /proc/<pid>/<tid>/whatever and some to just
/proc/<pid>/whatever.

Isn't the complexity itself an indicator of a fracturing paradigm?

What does the paradiagmatic hole around the file descriptor table buy again?


Rob.


