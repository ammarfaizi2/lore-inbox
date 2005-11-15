Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965066AbVKOWzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbVKOWzw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 17:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbVKOWzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 17:55:52 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:12476 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S965066AbVKOWzv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 17:55:51 -0500
Message-ID: <437A6772.6020700@fr.ibm.com>
Date: Tue, 15 Nov 2005 23:55:46 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ray Bryant <raybry@mpdtxmail.amd.com>
CC: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
References: <20051114212341.724084000@sergelap> <200511151321.08860.raybry@mpdtxmail.amd.com> <20051115194127.GB17287@sergelap.austin.ibm.com> <200511151430.35504.raybry@mpdtxmail.amd.com>
In-Reply-To: <200511151430.35504.raybry@mpdtxmail.amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Bryant wrote:

> Personally, I think that these assumptions are incorrect for a 
> checkpoint/restart facility.   I think that:
> 
> (1)  It is really only possible to checkpoint/restart a cooperative process.

What do you mean by cooperative ? that the code should be modified to
cooperate with a checkpoint/restart tool ? do you have something else in mind ?

> For this to work with uncooperative processes you have to figure out (for 
> example) how to save and restore the file system state.

Files are definitely very difficult to handle efficiently but there are
ways to deal with them. One way is not to deal with them at all and let the
application organize its data in such a way that we don't have to
checkpoint the file system, share storage is one solution, copying files
from a checkpointed node to another node is an other. It can be very
inefficient but it works.

But, I agree with you, we don't want to checkpoint a filesystem.

> (e. g. how do you get the file position set correctly for an open file in
> the restored program instance?)

well, if the file is available, lseek() should do the job. Pipes are more
difficult to handle than regular files in fact.

> And this doesn't even consider what to do with open network connections.

network connections are indeed very tricky. The network code is very
complex, very large, plenty of protocols to handle but it can be done for
TCP/IP by blocking the traffic, checkpointing the data and checkpointing
the PCBs. But tell me more, what are the main issues for you ?

Private interconnect are a challenge.

> Similarly, what does one do about the content of System V shared memory 
> regions or the contents of System V semaphores? 

Well, they have to be constrained in a known set of processes, or a
container, to make sure we are not checkpointing a moving target.

> I'm sure there are many more such problems we can come up with a careful
> study of the Linux/Unix API.

Oh yes, the UNIX API is very large but in checkpoint/restart we care more
about implementation. This can be tricky.

> (Note that "cooperation" in this context can also mean "willing to run inside 
> of a container of some kind that supports checkpoint/restart".)

Indeed !

We need an isolation mecanism to make sure we control the boundaries of an
application. We don't want any leaks when we initiate a checkpoint.

> So you can probably only checkpoint the process at certain points in its 
> lifetime, points which the application should be willing to identify in some 
> way. 

We do need to reach a quiescience point. a SIGSTOP is enough or a container
wide schedule(), a la software suspend. But no more.

> And I would argue that at such points in time, you can require that 
> the current register state doesn't include the results of a system call such 
> as getpid(), couldn't you?

Well, what if that register holds a virtualized pid, this is no more an
issue, nop ?

> (2)  Checkpoint/Restart really only makes sense for a long running, resource 
> intensive job.   (e. g. for a job that is doing a lot of work and hence, for 
> which, recovery is hard -- perhaps as hard as re-running the entire job).

HPC industry is indeed an obvious target.

However, we have successfully checkpinted desktop applications like
openoffice, thunderbird, mozilla, emacs, etc. We are still working on pty
in order to migrate terminals. We think in can also be useful in that area
and others.

> By their very nature, there are probably only a few such jobs running on the 
> system.    If there are lots of such jobs on the system, then re-running each 
> one can't be that hard, can it?

hmm, didn't get your point here ? can you elaborate ?

> So, I guess my question is wrt the task_pid API is the following:   Given that 
> there are a lot of other problems to solve before transparent checkpointing 
> of uncooperative processes is possible, why should this partial solution be 
> accepted into the main line kernel and "set in stone" so to speak?

Well, let's say that we want to present this one step after the other and
try to have each step brings some interesting value to the linux kernel.

Process aggregation is the first big step, other projects have shown
interest in this area, PAGG for instance. Isolation is another. The
virtualization step could be thought as dedicated to checkpoint/restart but
we're pretty sure it should help some projects like vserser that need to
virtualize some ancestor pid. On that subject, having a way to manage
cluster wide pids could be useful to HPC batch managers.

> Don't get me wrong, I would love for there to be a commonly accepted 
> checkpoint/restart API.    But I don't think that this can be done 
> transparently at the kernel level and without some cooperation from the 
> target task.

Well, we've already migrated some pretty ugly applications, database
engines, without modifying them :)

C.
