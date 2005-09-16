Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbVIPXyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbVIPXyi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 19:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbVIPXyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 19:54:38 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:30650 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750771AbVIPXyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 19:54:37 -0400
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] utterly bogus userland API in infinibad
X-Message-Flag: Warning: May contain useful information
References: <20050916181132.GF19626@ftp.linux.org.uk>
	<52fys4lsh9.fsf@cisco.com> <20050916203724.GH19626@ftp.linux.org.uk>
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 16 Sep 2005 16:54:31 -0700
In-Reply-To: <20050916203724.GH19626@ftp.linux.org.uk> (Al Viro's message of
 "Fri, 16 Sep 2005 21:37:24 +0100")
Message-ID: <52psr8k1qg.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 16 Sep 2005 23:54:32.0518 (UTC) FILETIME=[FBEDF660:01C5BB19]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Al> Looks obvious enough.  The very beginning of the function...

Fair enough.  Yes, there's an obvious reference leak there.

    Roland> Not sure I follow this.  The intention is that those file
    Roland> descriptors be available to userspace for poll(), read(),

    Al> ... only in the opener process?  And with insertion and
    Al> reporting done in separate syscalls?  FWIW, we do have an
    Al> interface for passing a bunch of files into descriptor table -
    Al> SCM_RIGHTS datagrams.

I have to confess I'm not familiar with how the kernel implements
SCM_RIGHTS.  Is it something we could use here?

    Al> is broken - anything that checks for ->ucontext and assumes
    Al> that non-NULL means a valid value is going to be screwed by
    Al> that.  Use of local variable would at least deal with that;
    Al> however, you need exclusion and check to deal with multiple
    Al> calls of that sucker, parallel or not.

Yes, good points.  I'll fix that up.

    Al> First of all, this form of write() is no better than ioctl() -
    Al> you get exact same problems combined with lack of warning
    Al> (ioctl() is a warning enough - we all know that its arguments
    Al> can be interpreted in arbitrary ugly way; write() is not
    Al> generally assumed to suffer from that).

Agreed -- as I said before, I don't think this is any better or worse
than ioctl().  The reasons for choosing write() are mostly historial
(write() at least didn't take the BKL).  Now that we have
unlocked_ioctl I have no objection to switching to ioctl().

    Al> Note that quite a few of these guys are simply read() in
    Al> disguise, which is particulary strange since you _do_ have
    Al> extra file descriptors.  Using write() to tell which stuff you
    Al> would like to read and where in userland should we put the
    Al> read value is... odd.

Yes, it is a perversion of write() semantics.  However I don't see a
way to use read(), since there's no way to tell read() what data we
want to get in a particular system call.  For the "event files" we do
use read() because the semantics are quite natural -- "give me the
next event you have queued up."

However, most of the operations on the main "command" file descriptor
are more like transactions that take some inputs and return some
outputs.  For example, the "create queue pair" operation takes a bunch
of inputs like "maximum number of queue entries" and returns a status,
a queue pair number and a handle to the object that was created.

    Al> BTW

    Al>         uobj = pd->uobject;

    Al>         ret = ib_dealloc_pd(pd);
    Al>         if (ret)
    Al>                 goto out;

    Al>         idr_remove(&ib_uverbs_pd_idr, cmd.pd_handle);

    Al>         spin_lock_irq(&file->ucontext->lock);
    Al>         list_del(&uobj->list);
    Al>         spin_unlock_irq(&file->ucontext->lock);

    Al>         kfree(uobj);

    Al> looks funny - can anything else get to uobj via that list
    Al> here?  If so, we are asking for trouble with that kfree()...

I think that code is actually OK.  The list is only used to keep track
of objects that we need to clean up when the file is closed, and we'll
only walk the list in the file's release method, when no one else can
be using it.

    Al> but the points wrt interface are simple:

    Al> 	* you _did_ end up with a multiplexor; you've just got
    Al> it piggybacked on sys_write().  * part of that stuff appears
    Al> to be duplicating sysfs interfaces * a lot of that stuff looks
    Al> much more like a read(2), not write(2).  * documentation
    Al> (however informal) of the list of things accessible via said
    Al> multiplexor is needed for further comments on the interface.

Not sure exactly what documentation you're looking for.  Let me know
if the following is a good start, or if there's something else you
want to know.

The basic objects that we want userspace to be able to work with are:

    Context - resource container that everything else is inside.
      Corresponds to a file descriptor, and no one without access to
      the FD can mess with the context.

    Asynchronous event queue - queue of asynchronous events like
      "adapter port has changed state."  We want this to be something
      userspace can poll(), sleep on, etc.

    Work completion event queue - similar to async event queue, but
      there are possibly multiple queues for a single context.  Queues
      events like "completion notification has been added to
      completion queue."  Similarly want to be able to poll(), sleep
      on individual queues, etc.

    Protection Domain (PD) - Another type of resource container.
      Every queue pair (QP) and memory region (MR) are attached to a
      PD.  Userspace needs to be able to create and destroy PDs, and
      pass a handle to a PD when creating QPs and MRs.

    Memory Region (MR) - Area of memory that IB hardware is allowed
      direct access to.  When created, L_Key and R_Key opaque cookies
      are returned.  Userspace needs to be able to create and destroy
      MRs and have access to the L_Key and R_Key.

    Queue Pair (QP) - Pair of work queues (send queue and receive
      queue) that userspace can put work requests into for processing
      by IB hardware.  Kernel is not involved in the fast path
      operations of adding work requests, but it must handle resource
      allocation when userspace creates a QP.  Userspace also needs to
      be able to ask the kernel to modify and destroy QPs.  The modify
      operation takes a bunch of parameters such as remote address to
      connect to, etc.

    Completion Queue (CQ) - Queue that holds information about
      completed work requests.  Pretty similar to QPs: IB hardware
      writes into the queue and it's read directly from userspace with
      no kernel involvement, but the kernel has to handle resource
      allocation/cleanup.  Also, userspace can request an interrupt
      when something is added to a CQ, and the kernel has to turn that
      interrupt into something userspace can read on the appropriate
      completion event queue.  Every work queue is attached to a CQ,
      so we need to have handles we can pass into the create QP
      operation.

There are a few other types of object like shared receive queues (SRQ)
and memory windows (MW) but they're pretty similar to the main ones I
described above.

Thanks,
  Roland
