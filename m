Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbULITXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbULITXT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 14:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbULITXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 14:23:18 -0500
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:39330 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S261586AbULITXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 14:23:13 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
To: Ingo Molnar <mingo@elte.hu>
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF737A0ECF.4ECB9A35-ON86256F65.006249D6@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Thu, 9 Dec 2004 12:10:32 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/09/2004 12:10:33 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:
>
>> >But you do have set your reference irq (soundcard) to the highest prio
>> >in the PREEMPT_RT case? I just ask to make sure.
>>
>> Yes, but then I have ALL the IRQ's at the highest priority (plus a
couple
>> other /0 and /1 tasks). [...]
>
>that is the fundamental problem i believe: your 'CPU loop' gets delayed
>by them.

They should not get delayed by them any more than in the PREEMPT_DESKTOP
configuration (other than the threading overhead which we've separately
said should be modest). They should be delayed by them less since we CAN
migrate the RT task away from the IRQ task (at least until I get the case
where multiple concurrent IRQ or /# threads keep both CPU's busy).

>> [...] Please note, I only use latencytest (an audio application) to
>> get an idea of RT performance on a desktop machine before I consider
>> using the kernel for my real application.
>
>but you never want your real application be delayed by things like IDE
>processing or networking workloads, correct?
For the most part, that I/O workload IS because I have the RT application
running. That was one of my points. I cannot reliably starve any of
those activities. The disk reads in my real application simulate a disk
read from a real world device. That data is needed for RT processing
in the simulated system. Some of the network traffic is also RT since
we generate a data stream that is interpreted in real time by other
systems.

>The only thing that should
>have higher priority than your application is the event thread that
>handles the hardware from which you get events. I.e. the soundcard IRQ
>in your case (plus the timer IRQ thread, because your task is also
>timing out).
For the test at my desktop I CAN do that but CHOOSE to not do that
since the real application has to handle the additional overhead.
Again, the set up I have is more of an apples to apples comparison.

>i'm not sure what the primary event source for your application is, but
>i bet it's not the IDE irq thread, nor the network IRQ thread.
I said previously the primary time source is from the shared memory
interface on the PCI bus for the specific application I described.
I could make that higher priority than the rest.

Actually we do use network messages to synchronize with a system that
is not in the cluster. At 20 Hz, we send a network message that
basically means "start execution" to that other system. It cannot
be delayed much either.

>so you are seeing the _inverse_ of advances in the -RT kernel: it's
>getting better and better at preempting your prio 30 CPU loop with the
>higher-prio RT tasks. I.e. the lower-prio CPU loop gets worse and worse
>latencies.
As I stated before (and I think you agree) the overhead of the setup
I have now for PREEMPT_RT should be comparable to that for PREEMPT_DESKTOP.
Neither should have a great advantage / disadvantage over the other.
The overhead for threading is certainly present in _RT but should
be offset to some extent by the improved migration opportunities.
The measurements however, do not seem to confirm that assessment.
Either the measurements are broke or the system is and in either case
should be fixed.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

