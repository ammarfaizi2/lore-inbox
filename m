Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317385AbSHVWG7>; Thu, 22 Aug 2002 18:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317392AbSHVWG7>; Thu, 22 Aug 2002 18:06:59 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:49429 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S317385AbSHVWG5>;
	Thu, 22 Aug 2002 18:06:57 -0400
Date: Fri, 23 Aug 2002 00:11:06 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, Richard Gooch <rgooch@ras.ucalgary.ca>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: MAX_PID changes in 2.5.31
Message-ID: <20020822221106.GB5471@win.tue.nl>
References: <Pine.LNX.4.44.0208200033400.5253-100000@localhost.localdomain> <1029799751.21212.0.camel@irongate.swansea.linux.org.uk> <20020820003346.GA4592@win.tue.nl> <1029804092.21242.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1029804092.21242.18.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Tue, Aug 20, 2002 at 12:29:11AM +0100, Alan Cox wrote:
> > 
> > > libc5 is very much 16bit pid throughout.
> > 
> > Can you clarify?
> 
> It uses the 16bit assuming syscall entry points, and has no knowledge of
> the 32bit pid stuff when its needed

Ha, Alan - I am a bit slow, and you are a bit brief, but let us see.

I interpreted your "throughout" as "also outside IPC", and hence asked
for clarification. For the moment, let me assume that we are just talking
about SYSV IPC. (You were not thinking about uids instead of pids?)

The kernel has these days new structs shmid64_ds, msqid64_ds
and old structs shmid_ds, msqid_ds.
The system calls sys_shmctl(), sys_msgctl() know what struct to use
by checking whether the caller has set the IPC_64 bit.
(No different entry points.) The assignment is done blindly:
	out.shm_cpid    = in->shm_cpid;
hence will truncate pids.

Today glibc has structs shmid_ds and msqid_ds with int ..pid,
and structs old_shmid_ds and old_msqid_ds with
__ipc_pid_t msg_lspid, msg_lrpid, shm_cpid, shm_lpid.
It uses the new structs and sets IPC_64 when that works.
Otherwise it uses old structs, and warns in case something
was truncated.

So, with a modern glibc all is fine.
Here modern includes glibc 2.1.91, but not glibc 2.1.3.

Earlier glibc, and libc5, don't know about IPC_64 and hence use the
old structures.

Remains the question whether that is bad.
With large pid_t, the four variables msg_lspid, msg_lrpid, shm_cpid,
shm_lpid will be truncated.

Who uses these? Nobody, as far as I can see from a recent collection
of RPMs.

So, it would be interesting to see what I overlooked.
Where are the programs that need these variables?

Andries
