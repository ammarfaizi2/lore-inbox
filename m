Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262308AbRE3VLi>; Wed, 30 May 2001 17:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262315AbRE3VL3>; Wed, 30 May 2001 17:11:29 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:41432 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S262308AbRE3VLT>; Wed, 30 May 2001 17:11:19 -0400
Message-ID: <9678C2B4D848D41187450090276D1FAE097F515A@FMSMSX32>
From: "Diefenbaugh, Paul S" <paul.s.diefenbaugh@intel.com>
To: "'Christopher B. Liebman'" <liebman@sponsera.com>,
        Jens Axboe <axboe@suse.de>,
        Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Cc: "Acpi@Phobos. Fachschaften. Tu-Muenchen. De" 
	<acpi@phobos.fachschaften.tu-muenchen.de>,
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        andre@linux-ide.org
Subject: RE: [patch]: ide dma timeout retry in pio
Date: Wed, 30 May 2001 14:09:24 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris/All:

I think your assumptions are correct.  I'm guessing that IDE DMA activity is
not being properly handled when the CPU is in C3, resulting in memory (and
therefore file system) corruption.  We haven't seen corruption on our
development systems, but this is probably due to the fact that we don't
explicitly enable IDE DMA transfers (?).

I'm concerned that the CPU is being put into C3 during what appears to be
times of high bus mastering activity.  The default policy (prpolicy.c) is
configured to only use C3 when bus mastering (BM_STS) is silent for 4 or
more 'quantums'.  You can see if this is working by causing disk activity
while cat'ing the file '/proc/acpi/processor/0/status': the C3 counter
should not be incrementing (or not by much, anyway).

The C3 handler should block bus master activity while the CPU is in C3.  DMA
activity (writes) during C3 would result in cache-incoherency (since the CPU
is not snooping) and thus memory corruption.  The idea is to block bus
mastering activity while in C3 (ARB_DIS), but allow the CPU to wakeup
whenever bus mastering is requested (BM_RLD).  I'm betting that DMA is
happening during C3 resulting in fs corruption.

To verify if C3 is really the culprit we should try disabling its use on a
vulnerable system.  I'd recommend mapping the C3 handler to use C2 instead,
which could be done by modifying the switch statement in pr_power_idle()
within prpower.c (see below).  Note that we'll still be setting BM_RLD for
C3's during pr_power_activate_state(), but this shouldn't be an issue.

	case PR_C2:
	case PR_C3:
		/* Interrupts must be disabled during C2 transitions */
		disable();
		/* See how long we're asleep for */
		acpi_get_timer(&start_ticks);
		/* Invoke C2 */
		acpi_os_in8(processor->power.p_lvl2);
		/* Dummy op - must do something useless after P_LVL2 read */
		acpi_hw_register_bit_access(ACPI_READ, ACPI_MTX_DO_NOT_LOCK,

			BM_STS);
		/* Compute time elapsed */
		acpi_get_timer(&end_ticks);
		/* Re-enable interrupts */
		enable();
		break;
	
	<remove previous 'case PR_C3'>

Could somebody give this a try and let me know?

Thanks,

-- Paul Diefenbaugh
   Intel Corporation


-----Original Message-----
From: Christopher B. Liebman [mailto:liebman@sponsera.com]
Sent: Monday, May 28, 2001 1:13 PM
To: Jens Axboe; Mark Hahn
Cc: Acpi@Phobos. Fachschaften. Tu-Muenchen. De;
linux-kernel@vger.kernel.org; alan@lxorguk.ukuu.org.uk;
andre@linux-ide.org
Subject: RE: [patch]: ide dma timeout retry in pio


I think that this may be an issue with ACPI processor power saving...  I
have documented issues with ide DMA timeouts when the processor is put into
the C3 power state.  One of the things that happens in this state is that
buss master arbitration is *disabled*.....  bus master activity is
*supposed* to transition the system back to a C0 power state.  I'll bet
there are some issues with the Linux IDE dma and disabling bus master
arbitration......  ideas?  thoughts?  patches? ;-)

	-- Chris

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Mark Hahn
>
> I seem to recall Andre saying that the problem arises when the
> ide DMA engine looses PCI arbitration during a burst.  shorter
> bursts would seem like the best workaround if this is the problem...
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

