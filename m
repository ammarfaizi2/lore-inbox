Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbUKRQS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbUKRQS7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 11:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbUKRQRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 11:17:35 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:6416 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262488AbUKRQRG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 11:17:06 -0500
Date: Thu, 18 Nov 2004 16:17:01 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc1-mm5
In-Reply-To: <419CB75C.3080605@aknet.ru>
Message-ID: <Pine.LNX.4.58L.0411181557430.30376@blysk.ds.pg.gda.pl>
References: <41967669.3070707@aknet.ru> <Pine.LNX.4.58L.0411150112520.22313@blysk.ds.pg.gda.pl>
 <4198EFE5.5010003@aknet.ru> <Pine.LNX.4.58L.0411151821050.3265@blysk.ds.pg.gda.pl>
 <419A38EE.8000202@aknet.ru> <Pine.LNX.4.58L.0411162226500.8068@blysk.ds.pg.gda.pl>
 <419CB75C.3080605@aknet.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004, Stas Sergeev wrote:

> Another thing I am wondering about,
> is why the lapic produces the NMI on
> my Athlon so slowly. It is something
> like 1 NMI in 20 seconds or so. And
> it looks like the frequency changes
> from one boot to another.

 The local APIC NMI watchdog, lacking a better source, uses the "cycles
unhalted" event.  As you may guess it doesn't tick when the CPU is in the
halted state (which happens when the system is idle) and thus the NMI
counter's progress depends on the system's activity.  Thy running
something CPU-intensive, like:

int main(void)
{
	while (1);
	return 0;
}

and observe the NMI counter ticking every second.

> It didn't work properly with any kernel,
> so maybe the lapic itself is buggy,
> but maybe this is a kernel's bug that
> can be debugged out somehow? Or is
> there anywhere something that allows
> me to specify the frequency? The rate
> I currently have, is really pretty
> much useless for anything.

 Don't worry -- if your system locks up on anything but the "hlt"  
processor instruction, the watchdog will trigger very soon as the "cycles
unhalted"  event will happen every clock tick.  If it locks up on "hlt",
then you are out of luck -- the event will not happen at all and the
watchdog won't trigger.  This is a shortcoming of the local APIC watchdog
-- unfortunately there is no "clock ticks" event that would work all the
time.

 The I/O APIC watchdog is driven externally and has no such shortcoming.  
But its NMI frequency is much higher, resulting in a more significant hit
to the overall system performance.

  Maciej
