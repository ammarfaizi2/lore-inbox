Return-Path: <linux-kernel-owner+w=401wt.eu-S1753505AbWLRITB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505AbWLRITB (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 03:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753506AbWLRITB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 03:19:01 -0500
Received: from ns.netcenter.hu ([195.228.254.57]:43500 "EHLO netcenter.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753505AbWLRITB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 03:19:01 -0500
Message-ID: <027b01c7227d$0e26d1f0$0400a8c0@dcccs>
From: =?iso-8859-1?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
To: "David Chinner" <dgc@sgi.com>
Cc: <dgc@sgi.com>, <linux-xfs@oss.sgi.com>, <linux-kernel@vger.kernel.org>
References: <003701c71d78$33ed28d0$0400a8c0@dcccs> <Pine.LNX.4.64.0612120932220.19050@p34.internal.lan> <00ab01c71e53$942af2f0$0400a8c0@dcccs> <000d01c72127$3d7509b0$0400a8c0@dcccs> <20061217224457.GN33919298@melbourne.sgi.com> <026501c72237$0464f7a0$0400a8c0@dcccs> <20061218062444.GH44411608@melbourne.sgi.com>
Subject: Re: xfslogd-spinlock bug?
Date: Mon, 18 Dec 2006 09:17:50 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "David Chinner" <dgc@sgi.com>
To: "Haar János" <djani22@netcenter.hu>
Cc: "David Chinner" <dgc@sgi.com>; <linux-xfs@oss.sgi.com>;
<linux-kernel@vger.kernel.org>
Sent: Monday, December 18, 2006 7:24 AM
Subject: Re: xfslogd-spinlock bug?


> On Mon, Dec 18, 2006 at 12:56:41AM +0100, Haar János wrote:
> > > On Sat, Dec 16, 2006 at 12:19:45PM +0100, Haar JÃ¡nos wrote:
> > > > I dont know there is a context between 2 messages, but i can see,
the
> > > > spinlock bug comes always on cpu #3.
> > > >
> > > > Somebody have any idea?
> > >
> > > Your disk interrupts are directed to CPU 3, and so log I/O completion
> > > occurs on that CPU.
> >
> >            CPU0       CPU1       CPU2       CPU3
> >   0:        100          0          0    4583704   IO-APIC-edge
timer
> >   1:          0          0          0          2   IO-APIC-edge
i8042
> >   4:          0          0          0    3878668   IO-APIC-edge
serial
> .....
> >  14:    3072118          0          0        181   IO-APIC-edge
ide0
> .....
> >  52:          0          0          0  213052723   IO-APIC-fasteoi
eth1
> >  53:          0          0          0   91913759   IO-APIC-fasteoi
eth2
> > 100:          0          0          0   16776910   IO-APIC-fasteoi
eth0
> ....
> >
> > Maybe....
> > I have 3 XFS on this system, with 3 source.
> >
> > 1. 200G one ide hdd.
> > 2. 2x200G mirror on 1 ide + 1 sata hdd.
> > 3. 4x3.3TB strip on NBD.
> >
> > The NBD serves through eth1, and it is on the CPU3, but the ide0 is on
the
> > CPU0.
>
> I'd say your NBD based XFS filesystem is having trouble.
>
> > > Are you using XFS on a NBD?
> >
> > Yes, on the 3. source.
>
> Ok, I've never heard of a problem like this before and you are doing
> something that very few ppl are doing (i.e. XFS on NBD). I'd start
> Hence  I'd start by suspecting a bug in the NBD driver.

Ok, if you have right, this also can be in context with the following issue:

http://download.netcenter.hu/bughunt/20061217/messages.txt   (10KB)


>
> > > > Dec 16 12:08:36 dy-base RSP: 0018:ffff81011fdedbc0  EFLAGS: 00010002
> > > > Dec 16 12:08:36 dy-base RAX: 0000000000000033 RBX: 6b6b6b6b6b6b6b6b
RCX:
> > >                                                      ^^^^^^^^^^^^^^^^
> > > Anyone recognise that pattern?
> >
> > I think i have one idea.
> > This issue can stops sometimes the 5sec automatic restart on crash, and
this
> > shows possible memory corruption, and if the bug occurs in the IRQ
> > handling.... :-)
> > I have a lot of logs about this issue, and the RAX, RBX always the same.
>
> And is this the only place where you see the problem? Or are there
> other stack traces that you see this in as well?

I have used the 2.6.16.18 for a long time, and it was stable, except this
issue. (~20 dump with xfslogd)
And i try the new releases, and now i have more. :-)

What do you think exactly?
I can see in the logs, but search for what?
The RAX, RBX thing, or the xfslogd-spinlock problem or the old nbd-deadlock
+ mem corruption?

[root@NetCenter netlog]# grep "0000000000000033" messages*
messages.1:Dec 11 22:47:21 dy-base RAX: 0000000000000033 RBX:
6b6b6b6b6b6b6b6b RCX: 0000000000000000
messages.1:Dec 12 18:16:35 dy-base RAX: 0000000000000033 RBX:
6b6b6b6b6b6b6b6b RCX: 0000000000000000
messages.1:Dec 13 11:40:05 dy-base RAX: 0000000000000033 RBX:
6b6b6b6b6b6b6b6b RCX: 0000000000000000
messages.1:Dec 14 22:25:32 dy-base RAX: 0000000000000033 RBX:
6b6b6b6b6b6b6b6b RCX: 0000000000000000
messages.1:Dec 15 06:24:44 dy-base RAX: 0000000000000033 RBX:
6b6b6b6b6b6b6b6b RCX: 0000000000000000
messages.1:Dec 16 12:08:36 dy-base RAX: 0000000000000033 RBX:
6b6b6b6b6b6b6b6b RCX: 0000000000000000
messages.11:Oct  3 19:49:44 dy-base RAX: 0000000000000033 RBX:
6b6b6b6b6b6b6b6b RCX: 0000000000000000
messages.11:Oct  7 01:11:17 dy-base RAX: 0000000000000033 RBX:
6b6b6b6b6b6b6b6b RCX: 0000000000000000
messages.13:Sep 21 15:35:31 dy-base RAX: 0000000000000033 RBX:
6b6b6b6b6b6b6b6b RCX: 0000000000000000
messages.15:Sep  3 16:13:35 dy-base RAX: 0000000000000033 RBX:
6b6b6b6b6b6b6b6b RCX: 0000000000000000
messages.15:Sep  5 21:00:38 dy-base RAX: 0000000000000033 RBX:
6b6b6b6b6b6b6b6b RCX: 0000000000000000
messages.2:Dec  9 00:10:47 dy-base RAX: 0000000000000033 RBX:
6b6b6b6b6b6b6b6b RCX: 0000000000000000
messages.2:Dec  9 14:07:01 dy-base RAX: 0000000000000033 RBX:
6b6b6b6b6b6b6b6b RCX: 0000000000000000
messages.2:Dec 10 04:44:48 dy-base RAX: 0000000000000033 RBX:
6b6b6b6b6b6b6b6b RCX: 0000000000000000
messages.3:Nov 30 10:59:21 dy-base RAX: 0000000000000033 RBX:
6b6b6b6b6b6b6b6b RCX: 0000000000000000
messages.3:Dec  2 00:54:23 dy-base RAX: 0000000000000033 RBX:
6b6b6b6b6b6b6b6b RCX: 0000000000000000
messages.5:Nov 13 10:44:49 dy-base RAX: 0000000000000033 RBX:
6b6b6b6b6b6b6b6b RCX: 0000000000000000
messages.5:Nov 14 03:14:14 dy-base RAX: 0000000000000033 RBX:
6b6b6b6b6b6b6b6b RCX: 0000000000000000
messages.5:Nov 14 03:37:07 dy-base RAX: 0000000000000033 RBX:
6b6b6b6b6b6b6b6b RCX: 0000000000000000
messages.5:Nov 15 01:39:54 dy-base RAX: 0000000000000033 RBX:
6b6b6b6b6b6b6b6b RCX: 0000000000000000
messages.6:Nov  6 14:48:54 dy-base RAX: 0000000000000033 RBX:
6b6b6b6b6b6b6b6b RCX: 0000000000000000
messages.6:Nov  7 04:36:13 dy-base RAX: 0000000000000033 RBX:
ffff8100057d2080 RCX: ffff810050d638f8
messages.6:Nov  7 04:36:13 dy-base RDX: 0000000000000008 RSI:
0000000000012cff RDI: 0000000000000033
messages.6:Nov  7 11:12:06 dy-base RAX: 0000000000000033 RBX:
6b6b6b6b6b6b6b6b RCX: 0000000000000000
messages.6:Nov  8 03:20:38 dy-base RAX: 0000000000000033 RBX:
6b6b6b6b6b6b6b6b RCX: 0000000000000000
messages.6:Nov  8 15:02:16 dy-base RAX: 0000000000000033 RBX:
6b6b6b6b6b6b6b6b RCX: 0000000000000000
messages.6:Nov  8 15:27:12 dy-base RAX: 0000000000000033 RBX:
6b6b6b6b6b6b6b6b RCX: 0000000000000000
messages.6:Nov 10 15:29:43 dy-base RAX: 0000000000000033 RBX:
6b6b6b6b6b6b6b6b RCX: 0000000000000000
messages.6:Nov 11 20:44:14 dy-base RAX: 0000000000000033 RBX:
6b6b6b6b6b6b6b6b RCX: 0000000000000000
messages.9:Oct 18 15:31:02 dy-base RAX: 0000000000000033 RBX:
6b6b6b6b6b6b6b6b RCX: 0000000000000000
messages.9:Oct 19 13:53:24 dy-base RAX: 0000000000000033 RBX:
6b6b6b6b6b6b6b6b RCX: 0000000000000000


>
> > > This implies a spinlock inside a wait_queue_head_t is corrupt.
> > >
> > > What are you type of system do you have, and what sort of
> > > workload are you running?
> >
> > OS: Fedora 5, 64bit.
> > HW: dual xeon, with HT, ram 4GB.
> > (the min_free_kbytes limit is set to 128000, because sometimes the e1000
> > driver run out the reserved memory during irq handling.)
>
> That does not sound good. What happens when it does run out of memory?



This is an old problem, on 2.6.16.18 .
The default min_free_kbytes is 38xx , and the GIGE controller easily can be
overflow this little place.
If this happens, the system freez, and i can only use the serial console +
sysreq to dump stack:

download.netcenter.hu/bughunt/20060530/261618-good.txt
download.netcenter.hu/bughunt/20060530/dmesg.txt
download.netcenter.hu/bughunt/20060530/dump.txt

This problem is already fixed with set the min_free_kbytes to 128M.

> Is that when you start to see the above corruptions?

I think no, but i am not 100% sure.

Cheers,

Janos

>
> Cheers,
>
> Dave.
> -- 
> Dave Chinner
> Principal Engineer
> SGI Australian Software Group

