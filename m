Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267019AbSL3Rtv>; Mon, 30 Dec 2002 12:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267015AbSL3Rtv>; Mon, 30 Dec 2002 12:49:51 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29495 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S267019AbSL3Rtt>; Mon, 30 Dec 2002 12:49:49 -0500
To: Anomalous Force <anomalous_force@yahoo.com>
Cc: david.lang@digitalinsight.com, jdike@karaya.com, wa@almesberger.net,
       alan@lxorguk.ukuu.org.uk, riel@conectiva.com.br, ebiederm@xmission.com,
       linux-kernel@vger.kernel.org
Subject: Re: holy grail
References: <20021230043908.77703.qmail@web13206.mail.yahoo.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 30 Dec 2002 10:57:12 -0700
In-Reply-To: <20021230043908.77703.qmail@web13206.mail.yahoo.com>
Message-ID: <m1adins83r.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anomalous Force <anomalous_force@yahoo.com> writes:

> --- David Lang <david.lang@digitalinsight.com> wrote:
> > 
> > I think people are at the point of working on this becouse it
> > sounds like
> > a worthwhile feature, not becouse it's actually anything that would
> > be
> > used.
> 
> UML sounds like a worthwhile feature, turns out its actually pretty
> useful too. kexec() is supported in its current incarnation. why
> not simply extend it the one step further?

kexec() still has not quite made it into the kernel yet...
Can we at least finish one piece before starting on the next?

> 
> > 
> > what possible application needs to be able to do a seamless kernel
> > upgrade
> > that wouldn't be useing a network?
> 
> "programs will never use more than 640K of memory." - bill gates
> 
> lets talk clusters... the teragrid system being built out of 2024
> redhat 7.2 installs (ncsa alone, not counting the 3 other cluster
> sites). imagine a simple system on the network to push a copy of the
> new kernel and then telling each node to hot-swap. 0 downtime.
> __super__ easy to maintain. how easy would that become???

In this case you stagger the reboots, then if you have failover you
get 0 downtime.

>  how about
> this... an nfs mount point in the grid for /boot such that each node
> then gets the kernel from a central point and hot swaps when a flag
> is set, or a change is detected in the /boot directory. no push even
> needed then. the cost savings from that alone would be worth the
> effort to them.

KABOOM... you just saturated the network with NFS traffic.

> 
> > 
> > if it's a batch processing task, it can checkpoint itself and
> > restart
> > after a reboot.
> > 
> 
> 2024 nodes rebooting, how much time needed while the system is in a
> degraded state?

On MCR (960 nodes at the time) I have rebooted the entire cluster,
including downloading a the kernel over the network in a minute.   And
a complete reinstall of all compute notes in the cluster took about 5
minutes.  With a little care most of the extra management complexity
of a large cluster is due to hardware problems.

There are two very different  problems being considered here:  high
availability clustering, and high performance clustering.  In high
availability clustering you though hardware at the problem so that you
application continues to run.  For high performance computing you
throw even more hardware at the problem so your program runs fast.

At some point the high performance clustering needs the high
reliability techniques because with enough hardware the failure
rate becomes noticeable.  Mean time between failure becomes something
you experience and can easily measure instead. 

Once the hardware has been made as redundant and as reliable as
possible job check-pointing next becomes the only way to run longer
jobs on the system.  Given that one MPI job may span the entire
cluster this is a very interesting problem.  Long term at least that 
is something that needs to be completed.
 
> hence a queue to catch pending irqs while the system swaps over.

And back to the heart of the kexec territory.  Here you simply drop
irqs until the system comes back up.  And then drivers should poll
their hardware to see what state it is in when they come back up.
Additionally it is part of the kexec design to place hardware is a
quiescent state while the kernels are being swapped. 

So there should be no special kernel state that needs to be saved
across kernels.  Just enough state to recreate the user space
abstractions.

Additionally we need a scalable filesystem for the clusters. Lustre
shows some promise.  But it is not done yet.  Things like GFS are
o.k. But I believe they rely on all of the disks being on a single
storage area network which is a bit of a scaleability and reliability
problem.

Eric
