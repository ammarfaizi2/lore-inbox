Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbVKOVFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbVKOVFM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 16:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbVKOVFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 16:05:11 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:20369 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750821AbVKOVFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 16:05:10 -0500
Date: Tue, 15 Nov 2005 15:05:04 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Ray Bryant <raybry@mpdtxmail.amd.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-ID: <20051115210504.GE17287@sergelap.austin.ibm.com>
References: <20051114212341.724084000@sergelap> <200511151321.08860.raybry@mpdtxmail.amd.com> <20051115194127.GB17287@sergelap.austin.ibm.com> <200511151430.35504.raybry@mpdtxmail.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511151430.35504.raybry@mpdtxmail.amd.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ray Bryant (raybry@mpdtxmail.amd.com):
> On Tuesday 15 November 2005 13:41, Serge E. Hallyn wrote:
> > Quoting Ray Bryant (raybry@mpdtxmail.amd.com):
> > > On Monday 14 November 2005 15:23, Serge E. Hallyn wrote:
> > > > --
> > > >
> > > > I'm part of a project implementing checkpoint/restart processes.
> > > > After a process or group of processes is checkpointed, killed, and
> > > > restarted, the changing of pids could confuse them.  There are many
> > > > other such issues, but we wanted to start with pids.
> > >
> > > I've read through the rest of this thread, but it seems to me that the
> > > real problems are in the basic assumptions you are making that are
> > > driving the rest of this effort and perhaps we should be examining those
> > > assumptions instead of your patch.
> >
> > Ok.
> >
> > > For example, from what I've read (particularly Hubertus's post that the
> > > pid could be in a register), I'm inferring that what you want to do is to
> > > be able to checkpoint/restart an arbitrary process at an arbitrary time
> > > and without any special support for checkpoint/restart in that process.
> >
> > Yes.
> >
> > > Also (c. f. Dave Hansen's post on the number of Xen virtual machines
> > > required),  you appear to think that the number of processes on the
> > > system for which checkpoint/restart should be enabled is large (more or
> > > less the same as the number of processes on the system).
> >
> > Right.
> >
> > > Am I reading this correctly?
> >
> > As far as I can see, yes.
> >
> > -serge
> 
> Personally, I think that these assumptions are incorrect for a 
> checkpoint/restart facility.   I think that:
> 
> (1)  It is really only possible to checkpoint/restart a cooperative process.
> For this to work with uncooperative processes you have to figure out (for 
> example) how to save and restore the file system state.  (e. g. how do you 
> get the file position set correctly for an open file in the restored program 
> instance?)   And this doesn't even consider what to do with open network 
> connections.

Many of these problems have been solved before.  See for instance Zap
and ckpt (www.cs.wisc.edu/~zandy/ckpt), and more examples at
http://www.checkpointing.org/

Certainly there are pieces of state which are harder to correclty
restore than others, but even network connections have been shown to be
migrateable (see zap, and tpccp for cryopid).  In fact IIUC one of the
hardest things to deal with are ttys.

> Similarly, what does one do about the content of System V shared memory 
> regions or the contents of System V semaphores?   I'm sure there are many 
> more such problems we can come up with a careful study of the Linux/Unix API.

Yup, sysv shmem has been handled before...  And yes, there are plenty
more :)  /proc files, device files, pipes...

> (Note that "cooperation" in this context can also mean "willing to run inside 
> of a container of some kind that supports checkpoint/restart".)
> 
> So you can probably only checkpoint the process at certain points in its 
> lifetime, points which the application should be willing to identify in some 

This has been demonstrated to be not true.  Again, see ckpt for a simple
example.

Oh, right, well willingness to run inside of a container *is* something we
would require :)  Not needed for checkpointing a single process,
however - see ckpt.

> So, I guess my question is wrt the task_pid API is the following:   Given that 
> there are a lot of other problems to solve before transparent checkpointing 
> of uncooperative processes is possible, why should this partial solution be 
> accepted into the main line kernel and "set in stone" so to speak?

It shouldn't.  This was a request for comment, not for inclusion :)  As
you say there are lots of pieces to put together, and we simply decided
to start with trying to solve this one.

In fact what I sent out doesn't even do the stuff we've been talking
about lately - that will come later this week.  This patchset merely lays
the groundwork for that.

-serge
