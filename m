Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266416AbUA3GdZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 01:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266422AbUA3GdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 01:33:25 -0500
Received: from flamingo.mail.pas.earthlink.net ([207.217.120.232]:48026 "EHLO
	flamingo.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S266416AbUA3GdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 01:33:22 -0500
Message-ID: <015301c3e6fb$2dbc22b0$0300000a@falcon>
From: "Curt" <curt@northarc.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
References: <01c501c3e6b9$67225f70$0700000a@irrosa><20040129163852.4028c689.akpm@osdl.org><020d01c3e6d0$acd78f60$0700000a@irrosa> <20040129205605.5bd140b2.akpm@osdl.org>
Subject: Re: Raw devices broken in 2.6.1? AND- 2.6.1 I/O degraded?
Date: Fri, 30 Jan 2004 01:34:53 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I finnaly narrowed it down to the disk subsystem, and the test program
shows
> > the meat of it. When there is massive contention for a file, or just
heavy
> > (VERY heavy) volume, the 2.6.1 kernel (presumably the filesystem
portion)
> > falls over dead. The test program doesn't show death, but could by just
> > upping the thrasher count a bit.
>
> 2.6.1 had a readahead bug which will adversely affect workloads such as
> this.  Apart from that, there is still quite a lot of tuning work to be
> done in 2.6.  As the tree settles down, and as more testers come on board.
> People are working on the VM and readahead code as we speak.  It's always
> best to test the most up-to-date tree.

Will do.

> > I have been telling our customers for over a year now "Don't
> > worry, Linux will be able to rock with the new threading model" and
then..
>
> You wouldn't expect huge gain from 2.6 in the I/O department.  Your
> workload is seek-limited.  I am seeing some small benefits from the
> anticipatory I/O scheduler with your test though.

Nice to be amongst people who know that, usually I'm the one beating my head
against customers trying to explain to them how even the fanciest
super-drives will be brought to their knees by our random-access patterns.
My kingdom for a quantum leap in seek penalties.

The gains we (Highwinds-Software) were expecting to see in 2.6.x were in the
thread scheduling, as a massively-multithreaded database application (1000
threads without breaking a sweat) we were very anxious for true kernel-space
LWPs in Linux. Our I/O world is well outside the CPU in RAID stacks, not a
whole lot any kernel can do to help us there, 99% of the time its driver
issues.


> I'm fairly suspicious about the disparity between the time taken for those
> initial large writes.  Two possible reasons come to mind:
>
> 1) Your disk isn't using DMA.  Use `hdparm' to check it, and check your
>    kernel IDE config if it is not using DMA.

To my great surprise DMA was NOT enabled, even though support for it was
(apparantly) compiled into the kernel. Thats a puzzle for another day. On
different hardware the problem did seem to go away.

> 2) 2.4 sets the dirty memory writeback thresholds much higher: 40%/60%
>    vs 10%/40%.  So on a 512M box it is possible that there is much more
>    dirty, unwritten-back memory after the timing period has completed than
>    under 2.6.  Although this difference in tuning can affect real-world
>    workloads, it is really an error in the testing methodology.
Generally,
>    the timing shuld include an fsync() so that all I/O which the program
>    issue has completed.

Yeah I know, but it was late, I just waited for the drive light to turn off
before I ran it the second time ;)

>    Or you can put 2.6 on par by setting
>    /proc/sys/vm/dirty_background_ratio to 40 and dirty_ratio to 60.

Okay will do, is there a good comprehensive resource where I can read up on
these (and presumably many other I/O related) variables?

> Longer-term, if your customers are using scsi, you should ensure that the
> disks do not use a tag queue depth of more than 4 or 8.  More than that
and
> the anticipatory scheduler becomes ineffective and you won't get that
> multithreaded-read goodness.

I've heard-tell of tweaking the elevator paramter to 'deadline', again could
you point me to a resource where I can read up on this? And forgive the
newbie-question, but is this a boot-time parameter, or a bit I can set in
the /proc system, or both?

> Please stay in touch, btw.  If we cannot get applications such as yours
> working well, we've wasted our time...

I'll do what I can to provide real-world feedback, I want this to work too.

-Curt

