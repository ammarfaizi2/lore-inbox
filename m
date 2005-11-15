Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965039AbVKOUbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbVKOUbs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 15:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbVKOUbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 15:31:47 -0500
Received: from amdext3.amd.com ([139.95.251.6]:42889 "EHLO amdext3.amd.com")
	by vger.kernel.org with ESMTP id S965040AbVKOUbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 15:31:46 -0500
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
From: "Ray Bryant" <raybry@mpdtxmail.amd.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Date: Tue, 15 Nov 2005 15:30:34 -0500
User-Agent: KMail/1.8
cc: linux-kernel@vger.kernel.org, "Hubertus Franke" <frankeh@watson.ibm.com>,
       "Dave Hansen" <haveblue@us.ibm.com>
References: <20051114212341.724084000@sergelap>
 <200511151321.08860.raybry@mpdtxmail.amd.com>
 <20051115194127.GB17287@sergelap.austin.ibm.com>
In-Reply-To: <20051115194127.GB17287@sergelap.austin.ibm.com>
MIME-Version: 1.0
Message-ID: <200511151430.35504.raybry@mpdtxmail.amd.com>
X-OriginalArrivalTime: 15 Nov 2005 20:30:36.0216 (UTC)
 FILETIME=[6F4F7380:01C5EA23]
X-WSS-ID: 6F649AE612C6063381-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 November 2005 13:41, Serge E. Hallyn wrote:
> Quoting Ray Bryant (raybry@mpdtxmail.amd.com):
> > On Monday 14 November 2005 15:23, Serge E. Hallyn wrote:
> > > --
> > >
> > > I'm part of a project implementing checkpoint/restart processes.
> > > After a process or group of processes is checkpointed, killed, and
> > > restarted, the changing of pids could confuse them.  There are many
> > > other such issues, but we wanted to start with pids.
> >
> > I've read through the rest of this thread, but it seems to me that the
> > real problems are in the basic assumptions you are making that are
> > driving the rest of this effort and perhaps we should be examining those
> > assumptions instead of your patch.
>
> Ok.
>
> > For example, from what I've read (particularly Hubertus's post that the
> > pid could be in a register), I'm inferring that what you want to do is to
> > be able to checkpoint/restart an arbitrary process at an arbitrary time
> > and without any special support for checkpoint/restart in that process.
>
> Yes.
>
> > Also (c. f. Dave Hansen's post on the number of Xen virtual machines
> > required),  you appear to think that the number of processes on the
> > system for which checkpoint/restart should be enabled is large (more or
> > less the same as the number of processes on the system).
>
> Right.
>
> > Am I reading this correctly?
>
> As far as I can see, yes.
>
> -serge

Personally, I think that these assumptions are incorrect for a 
checkpoint/restart facility.   I think that:

(1)  It is really only possible to checkpoint/restart a cooperative process.
For this to work with uncooperative processes you have to figure out (for 
example) how to save and restore the file system state.  (e. g. how do you 
get the file position set correctly for an open file in the restored program 
instance?)   And this doesn't even consider what to do with open network 
connections.

Similarly, what does one do about the content of System V shared memory 
regions or the contents of System V semaphores?   I'm sure there are many 
more such problems we can come up with a careful study of the Linux/Unix API.

(Note that "cooperation" in this context can also mean "willing to run inside 
of a container of some kind that supports checkpoint/restart".)

So you can probably only checkpoint the process at certain points in its 
lifetime, points which the application should be willing to identify in some 
way.    And I would argue that at such points in time, you can require that 
the current register state doesn't include the results of a system call such 
as getpid(), couldn't you?

(2)  Checkpoint/Restart really only makes sense for a long running, resource 
intensive job.   (e. g. for a job that is doing a lot of work and hence, for 
which, recovery is hard -- perhaps as hard as re-running the entire job).
By their very nature, there are probably only a few such jobs running on the 
system.    If there are lots of such jobs on the system, then re-running each 
one can't be that hard, can it?

So, I guess my question is wrt the task_pid API is the following:   Given that 
there are a lot of other problems to solve before transparent checkpointing 
of uncooperative processes is possible, why should this partial solution be 
accepted into the main line kernel and "set in stone" so to speak?

Don't get me wrong, I would love for there to be a commonly accepted 
checkpoint/restart API.    But I don't think that this can be done 
transparently at the kernel level and without some cooperation from the 
target task.
-- 
Ray Bryant
AMD Performance Labs                   Austin, Tx
512-602-0038 (o)                 512-507-7807 (c)

