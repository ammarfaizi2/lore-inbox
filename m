Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262822AbRE3V4t>; Wed, 30 May 2001 17:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262823AbRE3V4j>; Wed, 30 May 2001 17:56:39 -0400
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:64765 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S262822AbRE3V40>; Wed, 30 May 2001 17:56:26 -0400
From: "Christopher B. Liebman" <liebman@sponsera.com>
To: "Diefenbaugh, Paul S" <paul.s.diefenbaugh@intel.com>,
        "Jens Axboe" <axboe@suse.de>,
        "Mark Hahn" <hahn@coffee.psychology.mcmaster.ca>
Cc: "Acpi@Phobos. Fachschaften. Tu-Muenchen. De" 
	<acpi@phobos.fachschaften.tu-muenchen.de>,
        <linux-kernel@vger.kernel.org>, <alan@lxorguk.ukuu.org.uk>,
        <andre@linux-ide.org>
Subject: RE: [Acpi] RE: [patch]: ide dma timeout retry in pio
Date: Wed, 30 May 2001 17:55:40 -0400
Message-ID: <EAEOIAEILFNMCKKHDGFGKECBCAAA.liebman@sponsera.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <9678C2B4D848D41187450090276D1FAE097F515A@FMSMSX32>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: acpi-admin@phobos.fachschaften.tu-muenchen.de
> [mailto:acpi-admin@phobos.fachschaften.tu-muenchen.de]On Behalf Of
> Diefenbaugh, Paul S
>
> Chris/All:
>
> I think your assumptions are correct.  I'm guessing that IDE DMA
> activity is
> not being properly handled when the CPU is in C3, resulting in memory (and
> therefore file system) corruption.  We haven't seen corruption on our
> development systems, but this is probably due to the fact that we don't
> explicitly enable IDE DMA transfers (?).
>
> I'm concerned that the CPU is being put into C3 during what appears to be
> times of high bus mastering activity.  The default policy (prpolicy.c) is
> configured to only use C3 when bus mastering (BM_STS) is silent for 4 or
> more 'quantums'.  You can see if this is working by causing disk activity
> while cat'ing the file '/proc/acpi/processor/0/status': the C3 counter
> should not be incrementing (or not by much, anyway).

Hmmmm  I'll have to look at this a bit more....  but you can also keep from
C3 *and* C2 states by not having an idle CPU.  For instance
"./setiathome -verbose -nice 19" Prevents the C3 state quite nicely! :-)

>
> The C3 handler should block bus master activity while the CPU is
> in C3.  DMA
> activity (writes) during C3 would result in cache-incoherency
> (since the CPU
> is not snooping) and thus memory corruption.  The idea is to block bus
> mastering activity while in C3 (ARB_DIS), but allow the CPU to wakeup
> whenever bus mastering is requested (BM_RLD).  I'm betting that DMA is
> happening during C3 resulting in fs corruption.

*or* that the bus master request wakes up the cpu but for some reason the
requestor is not granted the bus?  So that you end up with DMA timeouts and
the FS gets corrupt because no data is getting written?

>
> To verify if C3 is really the culprit we should try disabling its use on a
> vulnerable system.  I'd recommend mapping the C3 handler to use
> C2 instead,
> which could be done by modifying the switch statement in pr_power_idle()
> within prpower.c (see below).  Note that we'll still be setting BM_RLD for
> C3's during pr_power_activate_state(), but this shouldn't be an issue.
>
[example code snipped]
>
> Could somebody give this a try and let me know?
>

I've already done something very similar to this.  I set
"processor->power.state[PR_C3].is_valid" to false near the end of
pr_power_set_default_policy().  And did not have any hang/corruption
problems. The test I was using was three "find / >/dev/null" instances
running 10-15 seconds apart.  Without C3 disabled it would hang/crash within
the first few minutes.  With this disabled it ran fine all the way thru.
Would it help if I tried this as you suggested and still calling
pr_power_activate_state()?

	-- Chris

