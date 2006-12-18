Return-Path: <linux-kernel-owner+w=401wt.eu-S1753367AbWLRGZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbWLRGZB (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 01:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753369AbWLRGZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 01:25:00 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:50529 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753367AbWLRGZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 01:25:00 -0500
Date: Mon, 18 Dec 2006 17:24:44 +1100
From: David Chinner <dgc@sgi.com>
To: Haar =?iso-8859-1?Q?J=E1nos?= <djani22@netcenter.hu>
Cc: David Chinner <dgc@sgi.com>, linux-xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: xfslogd-spinlock bug?
Message-ID: <20061218062444.GH44411608@melbourne.sgi.com>
References: <003701c71d78$33ed28d0$0400a8c0@dcccs> <Pine.LNX.4.64.0612120932220.19050@p34.internal.lan> <00ab01c71e53$942af2f0$0400a8c0@dcccs> <000d01c72127$3d7509b0$0400a8c0@dcccs> <20061217224457.GN33919298@melbourne.sgi.com> <026501c72237$0464f7a0$0400a8c0@dcccs>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <026501c72237$0464f7a0$0400a8c0@dcccs>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 12:56:41AM +0100, Haar János wrote:
> > On Sat, Dec 16, 2006 at 12:19:45PM +0100, Haar JÃ¡nos wrote:
> > > I dont know there is a context between 2 messages, but i can see, the
> > > spinlock bug comes always on cpu #3.
> > >
> > > Somebody have any idea?
> >
> > Your disk interrupts are directed to CPU 3, and so log I/O completion
> > occurs on that CPU.
> 
>            CPU0       CPU1       CPU2       CPU3
>   0:        100          0          0    4583704   IO-APIC-edge      timer
>   1:          0          0          0          2   IO-APIC-edge      i8042
>   4:          0          0          0    3878668   IO-APIC-edge      serial
.....
>  14:    3072118          0          0        181   IO-APIC-edge      ide0
.....
>  52:          0          0          0  213052723   IO-APIC-fasteoi   eth1
>  53:          0          0          0   91913759   IO-APIC-fasteoi   eth2
> 100:          0          0          0   16776910   IO-APIC-fasteoi   eth0
....
> 
> Maybe....
> I have 3 XFS on this system, with 3 source.
> 
> 1. 200G one ide hdd.
> 2. 2x200G mirror on 1 ide + 1 sata hdd.
> 3. 4x3.3TB strip on NBD.
> 
> The NBD serves through eth1, and it is on the CPU3, but the ide0 is on the
> CPU0.

I'd say your NBD based XFS filesystem is having trouble.

> > Are you using XFS on a NBD?
> 
> Yes, on the 3. source.

Ok, I've never heard of a problem like this before and you are doing
something that very few ppl are doing (i.e. XFS on NBD). I'd start
Hence  I'd start by suspecting a bug in the NBD driver.

> > > Dec 16 12:08:36 dy-base RSP: 0018:ffff81011fdedbc0  EFLAGS: 00010002
> > > Dec 16 12:08:36 dy-base RAX: 0000000000000033 RBX: 6b6b6b6b6b6b6b6b RCX:
> >                                                      ^^^^^^^^^^^^^^^^
> > Anyone recognise that pattern?
> 
> I think i have one idea.
> This issue can stops sometimes the 5sec automatic restart on crash, and this
> shows possible memory corruption, and if the bug occurs in the IRQ
> handling.... :-)
> I have a lot of logs about this issue, and the RAX, RBX always the same.

And is this the only place where you see the problem? Or are there
other stack traces that you see this in as well?

> > This implies a spinlock inside a wait_queue_head_t is corrupt.
> >
> > What are you type of system do you have, and what sort of
> > workload are you running?
> 
> OS: Fedora 5, 64bit.
> HW: dual xeon, with HT, ram 4GB.
> (the min_free_kbytes limit is set to 128000, because sometimes the e1000
> driver run out the reserved memory during irq handling.)

That does not sound good. What happens when it does run out of memory?
Is that when you start to see the above corruptions?

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
