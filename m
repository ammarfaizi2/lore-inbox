Return-Path: <linux-kernel-owner+w=401wt.eu-S1751170AbXANIzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbXANIzu (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 03:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbXANIzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 03:55:50 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:36232 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751170AbXANIzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 03:55:49 -0500
Date: Sun, 14 Jan 2007 09:51:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Dor Laor <dor.laor@qumranet.com>
Cc: Avi Kivity <avik@qumranet.com>,
       kvm-devel <kvm-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [kvm-devel] kvm & dyntick
Message-ID: <20070114085116.GD2913@elte.hu>
References: <45A66106.5030608@qumranet.com> <20070112062006.GA32714@elte.hu> <20070112101931.GA11635@elte.hu> <64F9B87B6B770947A9F8391472E0321609F7A0E2@ehost011-8.exch011.intermedia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64F9B87B6B770947A9F8391472E0321609F7A0E2@ehost011-8.exch011.intermedia.net>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dor Laor <dor.laor@qumranet.com> wrote:

> Afterwards we'll need to compensate the lost alarm signals to the 
> guests by using one of
>  - hrtimers to inject the lost interrupts for specific guests. The 
> problem this will increase the overall load.
>  - Injecting several virtual irq to the guests one after another 
> (using interrupt window exit). The question is how the guest will be 
> effected from this unfair behavior.

well, the most important thing would be to fix qemu to:

 - not use a 1024 /dev/rtc stream of signals as its clock emulation 
   source

i hacked that out of qemu, only to find out that qemu then uses periodic 
itimers. Instead of that it should use one-shot itimers, driven by the 
expiry time of the next clock. I.e. this code in vl.c, in 
host_alarm_handler():

    if (qemu_timer_expired(active_timers[QEMU_TIMER_VIRTUAL],
                           qemu_get_clock(vm_clock)) ||
        qemu_timer_expired(active_timers[QEMU_TIMER_REALTIME],
                           qemu_get_clock(rt_clock))) {

should start an itimer with an expiry time of:

 active_timers[QEMU_TIMER_VIRTUAL]->expire_time - qemu_get_clock(vm_clock)

or:

 active_timers[QEMU_TIMER_REALTIME]->expire_time - qemu_get_clock(rt_clock)

whichever is smaller. Furthermore, whenever timer->expire_time is 
changed in qemu_mod_timer(), this set-the-next-itimer-expiry-time code 
needs to be called. Would anyone like to try that?

this will reduce the host Qemu wakeup rate from 1000-1100/sec to the 
guest's 4-5/sec wakeup rate - resulting in 0.01% CPU overhead from a 
single idle guest. Current unmodified Qemu causes 10-20% CPU overhead 
from a single idle guest.

	Ingo
