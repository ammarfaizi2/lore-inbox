Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318539AbSIKIiP>; Wed, 11 Sep 2002 04:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318541AbSIKIiP>; Wed, 11 Sep 2002 04:38:15 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:60882 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S318539AbSIKIiO>; Wed, 11 Sep 2002 04:38:14 -0400
Date: Wed, 11 Sep 2002 14:29:45 +0530 (IST)
From: "Hanumanthu. H" <hanumanthu.hanok@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pid_max hang again...
Message-ID: <Pine.LNX.4.33.0209111428280.20725-100000@ccvsbarc.wipro.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> I don't know what the problem is. The present scheme is very
>> efficient on the average (since the pid space is very large,
>> much larger than the number of processes, this scan is hardly
>> ever done)

> The scan itself i don't mind. It is the rescan that bothers me

And most of others too. One thing that strikes some minds
immediatly after looking at current pid allocation, is the need
for improvement. Well, even though the proposals are be clumsy,
in-efficient (really ?) we should not ignore the fact that this
is an area to improve. Ok, here is my final (more better) proposal
which fixes the atomicity problem addressed by ManFred.


Lets us have a structure to represent pid, session, pgrp and tgid.

struct idobject {
	struct idobject	*id_next;
	struct idobject *id_prev;
	int		value;
	atomic_t	users;
	task_t		*taskp;
};

Rather than linking task_structs in pid_hash table, we maintain
these ID objects in pidhash table. So, remove pidhash link ptrs
from task struct and put them in idobject structure. The members
represent:

id_next & id_prev : links to hash next & prev entries in pidhash
		    table

value		  : the value represented by this object

users		  : number of users for this object. This counts
		    the number of references for this object.

taskp		  : task that uses this object as PID


And each task_struct will have the following pointers:


	struct idobject *pidp;	   // ptr to pid object
	struct idobject *sessionp; // ptr to session object
	struct idobject *pgrpp;	   // ptr to pgrp object
	struct idobject *tgidp;    // ptr to thread grp object

(To avoid all changes at once, we can retain their non-ptr
 versions i.e session, pid, pgrp and tgid members of task_struct).

A task acquire's pid by calling set_pid() function, giving its
task_struct so that pid assignment would be atomic (i,e to address
the issue raised by Manfred). set_pid() allocates an idobject
structure, assigns a free pid and sets the objp->taskp to the
given task. Based on the pid, it hashes the idobject structure
into pidhash table. All this by holding lastpid_lock only, so that
pid assignments won't be duplicated.

Upon acquiring a pid, pidp's users member will be incremented by 1.
Likewise sessionp, pgrpp and tgidp users also will be incremented
whenever this task establishes relationship with them.

When a process is exiting, it decrements `users' members of
these objects and if they become zero, it un-hashes the object
based on its value.

This design allows two things:

1. Atomicity in object allocation

2. Efficiency in pid allocation, because reduction in
   search time and avoiding tasklist_lock.

If people does not bother in maintaining few more pointers,
we can achive an efficient way of tracking all members of
a session or process group.

Hmm...does this idea make any better sense ? If people have
any comments, please let me know..  If this is going to be
another clumsy, in-efficient idea, I will assure that I will
stop thinking about it :-)


Regards
Hanumanthu

