Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262421AbULCWFC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbULCWFC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 17:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbULCWEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 17:04:30 -0500
Received: from smtp.istop.com ([66.11.167.126]:14480 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262403AbULCWCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 17:02:40 -0500
From: Daniel Phillips <phillips@istop.com>
To: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Date: Fri, 3 Dec 2004 17:07:26 -0500
User-Agent: KMail/1.7
Cc: Miklos Szeredi <miklos@szeredi.hu>, akpm@osdl.org, torvalds@osdl.org,
       hbryan@us.ibm.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com> <E1CV6vf-0006q1-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.61.0411271200580.12575@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.61.0411271200580.12575@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412031707.27270.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,

On Saturday 27 November 2004 12:07, Rik van Riel wrote:
> On Fri, 19 Nov 2004, Miklos Szeredi wrote:
> > The solution I'm thinking is along the lines of accounting the number
> > of writable pages assigned to FUSE filesystems.  Limiting this should
> > solve the deadlock problem.  This would only impact performance for
> > shared writable mappings, which are rare anyway.
>
> Note that NFS, and any filesystems on iSCSI or g/e/ndb block
> devices have the exact same problem.  To explain why this is
> the case, lets start with the VM allocation and pageout
> thresholds:
>
>    pages_min ------------------
>
>   GFP_ATOMIC ------------------
>
> PF_MEMALLOC ------------------
>
>     0 ------------------
>
> When writing out a dirty page, the pageout code is allowed
> to allocate network buffers down to the PF_MEMALLOC boundary.
>
> However, when receiving the ACK network packets from the server,
> the network stack is only allowed to allocate memory down to the
> GFP_ATOMIC watermark.
>
> This means it is relatively easy to get the system to deadlock,
> under a heavy shared mmap workload.

Why only mmap?  What makes generic_file_write immune to this problem?

> Limiting the number of 
> simultaneous writeouts might make the problem harder to trigger,
> but is still no solution since the network layer could exhaust
> its allowed memory for other packets, and never get around to
> processing the ACKs for the pageout related network traffic!
>
> I have a solution in mind, but it's not pretty. It might be safe
> now that DaveM no longer travels.  Still have to come up with a
> way to avoid being maimed by the other network developers, though...

The network stack is only a specific case of the problem.  In general, 
deadlock is possible whenever an asynchronous task sitting in the memory 
writeout path allocates memory.  That a userspace filesystem shows this 
deadlock is only indirectly due to being in userspace.  The real problem is 
that the userspace task is a separate task from the one trying to do 
writeout, and therefore does not inherit the PF_MEMALLOC state.

A lot of people think that mempool solves this problem, but it does not.  
Consider the case of device mapper raid1:

  - Non PF_MEMALLOC tasks grab all available memory.

  - Normal device mapper writeout queues requests to its own raid1 daemon,
    which has a mempool for submitting multiple requests to underlying
    devices.

  - Non PF_MEMALLOC requests from the raid1 daemon tasks first try to do   
    normal allocation, but that fails, so they start eating into the mempool
    reserve.

  - When the mempool is empty, the next allocation forces the task into
    PF_MEMALLOC mode.

  - The PF_MEMALLOC task initiates writeout

  - The writeout submits a request to device mapper raid1

  - Device mapper queues the request to its daemon

  - The daemon needs memory to set up writes to several disks

  - But normal memory is used up and the mempool is used up too.

  - Gack, we have a problem.

So how is mempool supposed to work anyway?  The idea is, each withdrawal from 
the pool is supposed to be balanced by freeing the object some bounded time 
later, so the system always makes progress.  The fly in the ointment is that 
the mempool can be exhausted by non PF_MEMALLOC tasks that later block on 
memory inversion, and so are unable to restore the pool.  So mempool as a 
general solution is inherently broken.  It works for, e.g., bio allocation, 
where there are no asynchronous memory users in the writeout path, but this 
not the general case.  The hard case where we do have asynchronous users is 
getting more and more common.

So it seems we have an serious problem here that goes way beyond the specific 
examples people have noticed.  As I see it,  the _only_ solution is to 
propagate the MEMALLOC state (and probably NOFS as well) to the asynchronous 
task in some way.  There are many possible variations on how to do this.  A 
lot of suggestions boil down to partitioning memory in various ways.  
However, each new partitioning scheme takes a big step backwards from the 
worthy goal of cache unification.  Moreover, even with partitioning, you 
still need a scheme for knowing when to dip into the partition or the 
partition's reserve if it has one.  In other words, we immediately return to 
the question of how to propagate the PF_MEMALLOC state.  This is the real 
problem, and we need to focus on it.

By the way, what is your secret solution for the network stack?

Regards,

Daniel
