Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVC3Omh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVC3Omh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 09:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVC3Omg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 09:42:36 -0500
Received: from coriana6.CIS.McMaster.CA ([130.113.128.17]:36591 "EHLO
	coriana6.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S261917AbVC3OmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 09:42:14 -0500
Date: Wed, 30 Mar 2005 09:41:40 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: hahn@coffee.psychology.mcmaster.ca
To: kus Kusche Klaus <kus@keba.com>
Cc: linux-kernel@vger.kernel.org, <linux-ide@vger.kernel.org>
Subject: Re: 2.6.11, IDE: Strange scheduling behaviour: high-pri RT process
 not scheduled?
In-Reply-To: <AAD6DA242BC63C488511C611BD51F3673231C2@MAILIT.keba.co.at>
Message-ID: <Pine.LNX.4.44.0503300931350.7542-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-PMX-Version-Mac: 4.7.1.128075, Antispam-Engine: 2.0.3.1, Antispam-Data: 2005.3.30.5
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've written a small test program which enables periodic RTC interrupts 
> at 8192 Hz and then goes into a loop reading /dev/rtc and collecting 
> timing statistics (using the rdtscl macro).

straightforward test, used for many years in the linux community
(I claim to have been the first to publish it on lkml ;)

> The test system runs a 2.6.11 kernel (no SMP) on a Pentium3 500 MHz 
> embedded hardware.

which probably has memory bandwidth of at most a couple hundred MB/s,
which is really horrible by modern standards.

> However, things break seriously when exercising the CF card in parallel 
> (e.g. with a dd if=/dev/hda of=/dev/null):
> 
> * The rtc *interrupt handler* is delayed for up to 250 *micro*seconds. 
> This is very bad for my purpose, but easy to explain: It is roughly the 
> time needed to transfer 512 Bytes from a CF card which can transfer 2 
> Mbyte/sec, and obviously, the CPU blocks all interrupts while making pio
> 
> transfers. (Why? Is this really necessary?)

even with -u1, isn't there still a softirq queue that will delay the wakeup
of your user-space tester?

> * The *test program* is regularly blocked for 63 *milli*seconds, 
> sometimes for up to 300 *milli*seconds, which is absolutely
> unacceptable.

guessing that's VM housekeeping.

> Now the big question:
> *** Why doesn't my rt test program get *any* CPU for 63 jiffies? ***
> (the system ticks at 1000 HZ)

because it's user-space.  the 'rt' is a bit of a misnomer - it's merely
a higher priority, less preemptable job.

> * The dd program obviously gets some CPU regularly (because it copies 2 
> MB/s, and because no other program could cause the 1 % user CPU load). 
> The dd runs at normal shell scheduling priority, so it should be 
> preempted immediately by my test program!

out of curiosity, does running it with "nice -n 19" change anything?

> 2.) Using a realtime-preempt-2.6.12-rc1-V0.7.41-11 kernel with
> PREEMPT_RT:
>     If my test program runs at rtpri 99, the problem is gone: It is 
>     scheduled within 30 microseconds after the rtc interrupt.
>     If my test program runs at rtpri 1, it still suffers from delays 
>     in the 30 to 300 millisecond range.

so your problem is solved, no?

also, did you try a (plain) preemptable kernel?

