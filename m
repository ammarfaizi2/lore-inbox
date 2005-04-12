Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbVDLAie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVDLAie (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 20:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbVDLAie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 20:38:34 -0400
Received: from fmr18.intel.com ([134.134.136.17]:64671 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261832AbVDLAiZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 20:38:25 -0400
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Priority Lists for the RT mutex
Date: Mon, 11 Apr 2005 17:36:30 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A02FA3D12@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Priority Lists for the RT mutex
Thread-Index: AcU+9kwVS9UrncqgRZqXnvbCwfJM8gAAENYg
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Bill Huey \(hui\)" <bhuey@lnxw.com>
Cc: "Ingo Molnar" <mingo@elte.hu>,
       "Sven-Thorsten Dietrich" <sdietrich@mvista.com>,
       "Daniel Walker" <dwalker@mvista.com>, <linux-kernel@vger.kernel.org>,
       "Steven Rostedt" <rostedt@goodmis.org>,
       "Esben Nielsen" <simlo@phys.au.dk>, "Joe Korty" <joe.korty@ccur.com>
X-OriginalArrivalTime: 12 Apr 2005 00:36:32.0995 (UTC) FILETIME=[ACFBBB30:01C53EF7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Bill Huey (hui) [mailto:bhuey@lnxw.com]
>
>> Quick fix: the usual. Enable deadlock detection and if it
>> returns deadlock, assume it is locked already and proceed (or
>> do a recursive mutex, or a trylock).
>
>You have to be joking me ? geez.
>...

This is way *more* common than you think--I've seen it around
some big multithreaded OSS packages [can't remember which now]. 

>> Sure--and because most was for legacy reasons that adhered to
>> POSIX strictly, it was very simple: we need POSIX this, that and
>> that (PI, proper adherence to scheduler policy wake up/rt-behaviour,
>> deadlock detection, etc).
>
>Some of this stuff sounds like recursive locking. Would this be a
>better expression to solve the "top level API locking" problem
>you're referring to ?

Bingo. That's another way to "fix" it. Luckily, recursive locking
can be safely and quickly done in user space (I own this lock,
ergo I just inc the lock count).

The problem with deadlocks is when the scenario gets more complex
and you are trying to lock a mutex and the owner is waiting for
a mutex whose owner is waiting for a mutex that you own...this
more commonly happens when you don't know what the heck is going
on in the code, which unfortunately is very common on people that
inherits big pieces of stacks to maintain.

>> Fortunately in those areas POSIX is not too gray; code to the book.
>> Deal.
>
>I would think that there will have to be a graph discontinuity
>between user/kernel spaces at kernel entry and exit for the deadlock
>detector. Can't say about issues at fork time, but I would expect
>that those objects would have to be destroyed when the process exits.

fork time is not an issue, as POSIX makes forks and thread incompatible
(in a nutshell, only the thread calling fork() survives, all the mutexes
are [IIRC] reinitialized or something like that...).

>The current RT (Ingo's) lock isn't recursive nor is the deadlock
>detector the last time I looked. Do think that this is a problem
>for legacy apps if it gets overload for being the userspace futex
>as well ? (assuming I'm understanding all of this correctly)

Should be not on the recursive side; as I said, that is easy to do
[currently NPTL does it with the futexes]. The deadlock stuff gets
hairier, but it's not such a big of a deal when you have your data
structures setup. It takes time, though.

>> Of course, selling it to the lkml is another story.
>
>I would think that pushing as much of this into userspace would
>make the kernel hooks for it more acceptable. Don't know.

Agreed. Deadlock checking though, has to be done in the kernel. For
the generic case it is the only way to do it sanely.

-- Inaky 

