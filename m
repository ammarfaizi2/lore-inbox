Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266196AbUHAWkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266196AbUHAWkc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 18:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266197AbUHAWkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 18:40:32 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:45572 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S266196AbUHAWk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 18:40:29 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-O2
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mingo@redhat.com
In-Reply-To: <20040801193043.GA20277@elte.hu>
References: <20040713143947.GG21066@holomorphy.com>
	 <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe>
	 <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe>
	 <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe>
	 <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu>
	 <20040729222657.GA10449@elte.hu>  <20040801193043.GA20277@elte.hu>
Content-Type: text/plain
Date: Mon, 02 Aug 2004 00:40:24 +0200
Message-Id: <1091400024.2092.2.camel@glass.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 (1.5.91-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-01 at 21:30 +0200, Ingo Molnar wrote:
> here's the latest version of the voluntary-preempt patch:
>   
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-O2
> 
> this patch is mainly a stabilization effort. I dropped the irq-threads
> code added in -M5 and rewrote it from scratch based on -L2 - it is
> simpler and should be more robust.
> 
> The same /proc/irq/* configuration switches are still present, but i
> added the following additional rule: if _any_ handler of a given IRQ is
> marked as non-threaded then all handlers will be executed non-threaded
> as well.
> 
> E.g. if you have the following handlers on IRQ 10:
> 
>  10:      11584   IO-APIC-level  eth0, eth1, eth2
> 
> and you change /proc/irq/16/eth1/threaded from 1 to 0 then the eth0 and
> eth2 handlers will be executed non-threaded as well. (This rule only
> enforces what the hardware enforces anyway, none of the previous patches
> allowed true separation of these handlers.)
> 
> i also changed the IO-APIC level-triggered code to be robust when
> redirection is done. The noapic workaround should not be necessary
> anymore.
> 
> the keyboard lockups are now hopefully all gone too - i've tested
> IO-APIC and non-IO-APIC setups as well and NumLock/ScrollLock works fine
> in all sorts of workloads.
> 
> Let me know if you still have any problems.

I'll be away on vacations for about two weeks, but before leaving, I
wanted to test run 2.6.8-rc2-bk11 plus voluntary-preempt-O2 on my P4 box
with both ACPI and IO/APIC enabled, voluntary-preempt=3 and preempt=1
and it seems to be working fine (I still haven't seen any hard locks).

# cat /proc/interrupts
           CPU0
  0:     114044    IO-APIC-edge  timer
  1:        497    IO-APIC-edge  i8042
  8:          1    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 14:       9289    IO-APIC-edge  ide0
 15:         54    IO-APIC-edge  ide1
 17:       1299   IO-APIC-level  Intel 82801BA-ICH2
 19:      13408   IO-APIC-level  uhci_hcd
 20:        279   IO-APIC-level  eth0
 23:          0   IO-APIC-level  uhci_hcd
NMI:          0
LOC:     113967
ERR:          0
MIS:          0

# grep . /proc/irq/*/*/threaded
/proc/irq/14/ide0/threaded:1
/proc/irq/15/ide1/threaded:1
/proc/irq/17/Intel 82801BA-ICH2/threaded:1
/proc/irq/19/uhci_hcd/threaded:1
/proc/irq/1/i8042/threaded:1
/proc/irq/20/eth0/threaded:1
/proc/irq/23/uhci_hcd/threaded:1
/proc/irq/8/rtc/threaded:1
/proc/irq/9/acpi/threaded:1


