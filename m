Return-Path: <linux-kernel-owner+w=401wt.eu-S1753262AbWLQX5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbWLQX5j (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 18:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753264AbWLQX5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 18:57:38 -0500
Received: from ns.netcenter.hu ([195.228.254.57]:40808 "EHLO netcenter.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753262AbWLQX5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 18:57:38 -0500
Message-ID: <026501c72237$0464f7a0$0400a8c0@dcccs>
From: =?iso-8859-1?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
To: "David Chinner" <dgc@sgi.com>
Cc: <linux-xfs@oss.sgi.com>, <linux-kernel@vger.kernel.org>
References: <003701c71d78$33ed28d0$0400a8c0@dcccs> <Pine.LNX.4.64.0612120932220.19050@p34.internal.lan> <00ab01c71e53$942af2f0$0400a8c0@dcccs> <000d01c72127$3d7509b0$0400a8c0@dcccs> <20061217224457.GN33919298@melbourne.sgi.com>
Subject: Re: xfslogd-spinlock bug?
Date: Mon, 18 Dec 2006 00:56:41 +0100
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
Cc: <linux-xfs@oss.sgi.com>; <linux-kernel@vger.kernel.org>
Sent: Sunday, December 17, 2006 11:44 PM
Subject: Re: xfslogd-spinlock bug?


> On Sat, Dec 16, 2006 at 12:19:45PM +0100, Haar János wrote:
> > Hi
> >
> > I have some news.
> >
> > I dont know there is a context between 2 messages, but i can see, the
> > spinlock bug comes always on cpu #3.
> >
> > Somebody have any idea?
>
> Your disk interrupts are directed to CPU 3, and so log I/O completion
> occurs on that CPU.

           CPU0       CPU1       CPU2       CPU3
  0:        100          0          0    4583704   IO-APIC-edge      timer
  1:          0          0          0          2   IO-APIC-edge      i8042
  4:          0          0          0    3878668   IO-APIC-edge      serial
  8:          0          0          0          0   IO-APIC-edge      rtc
  9:          0          0          0          0   IO-APIC-fasteoi   acpi
 12:          0          0          0          3   IO-APIC-edge      i8042
 14:    3072118          0          0        181   IO-APIC-edge      ide0
 16:          0          0          0          0   IO-APIC-fasteoi
uhci_hcd:usb2
 18:          0          0          0          0   IO-APIC-fasteoi
uhci_hcd:usb4
 19:          0          0          0          0   IO-APIC-fasteoi
uhci_hcd:usb3
 23:          0          0          0          0   IO-APIC-fasteoi
ehci_hcd:usb1
 52:          0          0          0  213052723   IO-APIC-fasteoi   eth1
 53:          0          0          0   91913759   IO-APIC-fasteoi   eth2
100:          0          0          0   16776910   IO-APIC-fasteoi   eth0
NMI:      42271      43187      42234      43168
LOC:    4584247    4584219    4584215    4584198
ERR:          0

Maybe....
I have 3 XFS on this system, with 3 source.

1. 200G one ide hdd.
2. 2x200G mirror on 1 ide + 1 sata hdd.
3. 4x3.3TB strip on NBD.

The NBD serves through eth1, and it is on the CPU3, but the ide0 is on the
CPU0.


>
> > Dec 16 12:08:36 dy-base BUG: spinlock bad magic on CPU#3, xfslogd/3/317
> > Dec 16 12:08:36 dy-base general protection fault: 0000 [1]
> > Dec 16 12:08:36 dy-base SMP
> > Dec 16 12:08:36 dy-base
> > Dec 16 12:08:36 dy-base CPU 3
> > Dec 16 12:08:36 dy-base
> > Dec 16 12:08:36 dy-base Modules linked in:
> > Dec 16 12:08:36 dy-base  nbd
>
> Are you using XFS on a NBD?

Yes, on the 3. source.
I used it about 1.5 years.

(The nbd deadlock is fixed on my system, thanks to Herbert Xu on 2.6.14.)

>
> > Dec 16 12:08:36 dy-base  rd
> > Dec 16 12:08:36 dy-base  netconsole
> > Dec 16 12:08:36 dy-base  e1000
> > Dec 16 12:08:36 dy-base  video
> > Dec 16 12:08:36 dy-base
> > Dec 16 12:08:36 dy-base Pid: 317, comm: xfslogd/3 Not tainted 2.6.19 #1
> > Dec 16 12:08:36 dy-base RIP: 0010:[<ffffffff803f3aba>]
> > Dec 16 12:08:36 dy-base  [<ffffffff803f3aba>] spin_bug+0x69/0xdf
> > Dec 16 12:08:36 dy-base RSP: 0018:ffff81011fdedbc0  EFLAGS: 00010002
> > Dec 16 12:08:36 dy-base RAX: 0000000000000033 RBX: 6b6b6b6b6b6b6b6b RCX:
>                                                      ^^^^^^^^^^^^^^^^
> Anyone recognise that pattern?

I think i have one idea.
This issue can stops sometimes the 5sec automatic restart on crash, and this
shows possible memory corruption, and if the bug occurs in the IRQ
handling.... :-)
I have a lot of logs about this issue, and the RAX, RBX always the same.

>
> > Dec 16 12:08:36 dy-base Call Trace:
> > Dec 16 12:08:36 dy-base  [<ffffffff803f3bdc>] _raw_spin_lock+0x23/0xf1
> > Dec 16 12:08:36 dy-base  [<ffffffff805e7f2b>]
_spin_lock_irqsave+0x11/0x18
> > Dec 16 12:08:36 dy-base  [<ffffffff80222aab>] __wake_up+0x22/0x50
> > Dec 16 12:08:36 dy-base  [<ffffffff803c97f9>] xfs_buf_unpin+0x21/0x23
> > Dec 16 12:08:36 dy-base  [<ffffffff803970a4>]
xfs_buf_item_unpin+0x2e/0xa6
>
> This implies a spinlock inside a wait_queue_head_t is corrupt.
>
> What are you type of system do you have, and what sort of
> workload are you running?

OS: Fedora 5, 64bit.
HW: dual xeon, with HT, ram 4GB.
(the min_free_kbytes limit is set to 128000, because sometimes the e1000
driver run out the reserved memory during irq handling.)

Workload:

I use this system for free web storage.
(2x apache 2.0.xx,   12x pure-ftpd, 2x mysql but sql only use the source #2
fs.)

The normal system load is ~20-40, but currently i have a little problem with
apache, because it sometimes starts to read a lot from the big XFS device,
and eats all memory, the load is rising to 700-800.
At this point i use httpd restart, and everithing go back to normal, but if
i offline.....

Thanks a lot!

Janos

>
> Cheers,
>
> Dave.
> -- 
> Dave Chinner
> Principal Engineer
> SGI Australian Software Group

