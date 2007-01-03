Return-Path: <linux-kernel-owner+w=401wt.eu-S1753154AbXACBuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbXACBuI (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 20:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753103AbXACBuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 20:50:08 -0500
Received: from main.gmane.org ([80.91.229.2]:42574 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753130AbXACBuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 20:50:06 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: bbee <bumble.bee@xs4all.nl>
Subject: Re: ata1: spurious interrupt =?utf-8?b?KGlycV9zdGF0?= 0x8 =?utf-8?b?YWN0aXZlX3RhZw==?= -84148995 sactive 0x0) r0xj0
Date: Wed, 3 Jan 2007 01:44:42 +0000 (UTC)
Message-ID: <loom.20070103T020347-255@post.gmane.org>
References: <f4527be0612271812p7282de31j98462aebde16e5a1@mail.gmail.com> <45933A53.1090702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 213.84.219.73 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.9) Gecko/20061224 Firefox/1.5.0.9)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo <htejun <at> gmail.com> writes:
> Andrew Lyon wrote:
> > My system is gigabyte ds3 motherboard with onboard SATA JMicron
> > 20360/20363 AHCI Controller (rev 02), drive connected is WDC
> > WD740ADFD-00 20.0, I am running 2.6.18.6 32 bit, under heavy i/o I get
> > the following messaegs:
> > 
> > ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
> > ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
> > 
> > Is this condition dangerous?
> 
> Not usually.  Might indicate something is going wrong in some really
> rare cases.  I think vendors are getting NCQ right these days.  Maybe
> it's time to remove that printk.

Hi Tejun, it's funny you should say that, because in the subthread at
http://thread.gmane.org/gmane.linux.ide/10264/focus=10334
you seemed to have major issues with this very error and were saying there
could even be data corruption.

I too have this error, on a Asrock 939Dual-SATA2 board wich has the same
controller. Syslog lines like
ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0xf4)
every so often.

However, in my case it gets a lot worse. The following happens infrequently,
usually within 15 days of uptime on a light I/O load:

ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: (irq_stat 0x48000000, interface fatal error)
ata1.00: tag 0 cmd 0xea Emask 0x12 stat 0x37 err 0x0 (ATA bus error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x104)
ata1.00: revalidation failed (errno=-5)
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link down (SStatus 0 SControl 300)
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link down (SStatus 0 SControl 300)
ata1.00: disabled
ata1: EH complete
ata1.00: detaching (SCSI 0:0:0:0)
scsi 0:0:0:0: rejecting I/O to dead device

The drive then dissapears from the system. This is not preceded by any
spurious interrupt messages, but I have a hunch it is related because
following your grave comments in the referenced thread, I looked for a kernel
option to disable NCQ. Astonished to find none, I changed the source using the
flag you added in this patch:
http://article.gmane.org/gmane.linux.ide/11527
With NCQ disabled, the spurious interrupt messages as well as the exceptions
go away.

This has been happening for a few months on a box whose log I'd been neglecting
and I hadn't even noticed the issue since the drive is part of a md array. The
drive would get re-detected when I rebooted the box and md would rebuild the
array.

Here comes the weird part. When I discovered the problem, I backtracked through
the syslog to see when the problems started. They started a few months ago when
I added a DVB card to the system (it is a mythtv box). I noticed in Andrew's
dmesg that he also has a DVB card.

Could the DVB subsystem have anything to do with this? I realize the systems
are completely unrelated..
Perhaps the JMicron chip has noise issues? These are often triggered by adding
tuner cards..

It probably won't make any difference to system performance, but it would be
nice if we could resolve this so I can re-enable NCQ and stop patching my
kernels ;)

Thanks for reading and please CC,

bbee

