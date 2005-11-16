Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbVKPRy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbVKPRy7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 12:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbVKPRy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 12:54:59 -0500
Received: from asclepius3.uwa.edu.au ([130.95.128.60]:33179 "EHLO
	asclepius.uwa.edu.au") by vger.kernel.org with ESMTP
	id S1030289AbVKPRy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 12:54:59 -0500
X-UWA-Client-IP: 130.95.13.9 (UWA)
Date: Thu, 17 Nov 2005 01:52:47 +0800
From: Bernard Blackham <bernard@blackham.com.au>
To: "Hua Zhong (hzhong)" <hzhong@cisco.com>
Cc: Ray Bryant <raybry@mpdtxmail.amd.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-ID: <20051116175247.GA16804@ucc.gu.uwa.edu.au>
References: <75D9B5F4E50C8B4BB27622BD06C2B82BD4D428@xmb-sjc-235.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75D9B5F4E50C8B4BB27622BD06C2B82BD4D428@xmb-sjc-235.amer.cisco.com>
Organization: Dagobah Systems
User-Agent: Mutt/1.5.10i
X-SpamTest-Info: Profile: Formal (287/051115)
X-SpamTest-Info: Profile: Detect Hard [UCS 290904]
X-SpamTest-Info: Profile: SysLog
X-SpamTest-Info: Profile: Marking Spam - Subject (UCS) [02-08-04]
X-SpamTest-Status: Not detected
X-SpamTest-Version: SMTP-Filter Version 2.0.0 [0125], KAS/Release
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 06:24:44PM -0800, Hua Zhong (hzhong) wrote:
> I did some checkpoint/restart work on Linux about 5 years ago (you may
> still be able to google "CRAK"), so I'm jumping in with my 2 cents.

Ditto - CryoPID.

> > Personally, I think that these assumptions are incorrect for a 
> > checkpoint/restart facility.   I think that:
> > 
> > (1)  It is really only possible to checkpoint/restart a 
> > cooperative process.

I agree that some processes are, but the majority are not.

> It's hard, but not impossible, at least theoretically.

Not that hard. Most of the information, if not exported by the
kernel through other means, can be ascertained from within the
process itself. For example, FD offsets can be obtained with lseek,
network connection endpoints with get{sock,peer}name, etc. With a
little help from ptrace, it's trivial.

> > For this to work with uncooperative processes you have to 
> > figure out (for example) how to save and restore the file 
> > system state.  (e.g. how do you get the file position set
> > correctly for an open file in the restored program instance?)
> 
> This is actually one of the simplest problems in checkpoint/restart.

Remote syscalls is how CryoPID does it. Inject some code into the
target and execute it. CryoPID can also scrape out the contents of
unlinked (eg, temporary) files (in svn version). You can establish
what FIFOs joined which FDs of what processes through /proc, and
capture the in-flight buffers with some more ptracing.

> You'd need kernel support to save the state, and restart could be
> done entirely in user space to restore the file descriptors.

Just for file offsets? I disagree =)

> > And this doesn't even consider what to do with open network 
> > connections.
> 
> Right, this is really hard. I played with it 5 years ago and I had semi
> success on restoring network connections (with my limited understanding
> on Linux networking and some really ugly hacks). I could restart a
> killed remote Emacs X session with about 50% success rate.

TCP connections can be done with tcpcp (tcpcp.sf.net) and CryoPID
already supports it (although the patch hasn't been ported past
2.6.11).

UDP connections are not a hassle being stateless (though CryoPID
doesn't yet, because it's too easy :)

Unix sockets can be reconnected, but of course protocols might get
hopelessly confused. However, I am working with the Gtk+ display
migration code to freeze Gtk+ applications. gtk-demo freezes quite
happily as does gvim. The Gtk+ guys are working hard to squash some
remaining bugs to make more apps supported.

However with some prethought, you could hook your X app up to
something like Xmove and migrate any X application that way.


> > Similarly, what does one do about the content of System V shared
> > memory regions or the contents of System V semaphores?

The contents are not so much an issue, as the ids themselves. They
face much the same problem as PIDs - you attach/detach to a SHM
segment by its shmid. These are allocated by the kernel, but cached
in the process. Some method of requesting a particular shmid would
make life easier for checkpointing. Ditto semaphores and message
queues.

> > I'm sure there are many more such problems we can come up with a
> > careful study of the Linux/Unix API.

For many processes, there isn't all that much that can't be saved
from userspace. Help from kernel space would certainly make things
easier/faster/more reliable. This task_pid API being one of them.

> > So, I guess my question is wrt the task_pid API is the
> > following:   Given that there are a lot of other problems to
> > solve before transparent checkpointing of uncooperative
> > processes is possible, why should this partial solution be
> > accepted into the main line kernel and "set in stone" so to
> > speak?
> 
> I agree with this. Before we see a mature checkpoint/restart solution
> already implemented, there is no point in doing the vpid thing.

Fair enough.  I'm actually implementing multithreading support for
CryoPID at the moment.  It currently resumes with the original PIDs
by editing last_pid in /dev/kmem and forking - a temporary racy
hack, until a better solution (such as this) appeared.  (It fails if
the PID is in use, or if anybody else on the system fork()s before
you do).  I'll give the task_pid patches a try and see how much
easier life is.

I'm delighted to see Serge and the vserver guys putting the time
into this! Thanks!

Regards,

Bernard.

