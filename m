Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269645AbRHMB2F>; Sun, 12 Aug 2001 21:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269641AbRHMB1z>; Sun, 12 Aug 2001 21:27:55 -0400
Received: from lanm-pc.com ([64.81.97.118]:53241 "EHLO golux.thyrsus.com")
	by vger.kernel.org with ESMTP id <S269644AbRHMB1K>;
	Sun, 12 Aug 2001 21:27:10 -0400
Date: Sun, 12 Aug 2001 21:24:30 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: S2464 (K7 Thunder) hangs -- some lessons learned
Message-ID: <20010812212430.A9300@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alas, the 2.4.8+ emu10k1 driver does not completely banish the K7 Thunder
lockups problem.  It makes them a lot rarer, though, and enabled us to get to
the next level of diagnosis.

More from the article in progress:

<para>But as it turned out, the story didn't end there.  The 2.4.8+ driver
doesn't completely banish the hangs; early in the morning of the third day,
while I was asleep, Gary tripped over a way to re-induce them by logging
into the machine via <command>ssh</command> while an X build is running.  I
didn't yet know this when I next read my mail and saw a report from Jeffrey
Ingber of the linux-kernel list that he had continued to see emu10k1
lockups after installing 2.4.8 -- but that they were banished by the ALSA
drivers.</para>

<para>Further testing proved, in fact, that the presence of the SB Live!
in the machine can make it vulnerable to lockups triggered by network 
activity even when the emul10k1 support is not configured in at all!  This
takes the operating system out of the picture and suggests a hardware-
or BIOS-level problem. Our suspicions were immediately directed to PCI
IRQ sharing, a well-known source of lossage.</para>

<para>Upon investigation (via <filename>/proc/pci</filename>), we
discovered that the IRQ assignments looked distinctly dubious.  IRQs
shared between on-board devices didn't bother us; we presumed the board
designers had been smart enough to avoid conflicts.  But IRQs shared
between on-board and daughtercard devices looked like they might be
part of the problem.</para>

<para>Unlike some other PCI BIOSes, the S2464's doesn't give you the
capability to wire IRQs to specific card slots.  While looking for this,
however, we found a BIOS setting that seemed relevant -- "Use PCI Interrupt
Entries In MP Table".  When we switched it to `Yes', rebooted, and looked at
<filename>/proc/pci</filename>, the IRQ assignments looked a lot saner --
and when we tested, the <command>ssh</command> hang was gone!</para>

OK, so the lessons here are:

1. The S2464 needs to be configured with "Use PCI Interrupt Entries In MP 
   Table" for sanity to prevail, and

2. When you see a box hang that's clearly related to a daughtercard, *run*
   (do not walk) to your local /proc directory, cat /proc/pci and check out
   the IRQ assignments.

I'm not certain we've nailed the entire problem yet -- we still need to test
with the emu10k1 sound driver linked in.  But it's looking pretty good.

BTW, somebody mailed me an explanation of that BIOS setting ("Use PCI 
Interrupt Entries In MP Table") but I managed to lose it.  Whoever you
are, could you remail?  I want to include some sort of explanation in
the article.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The people cannot delegate to government the power to do anything
which would be unlawful for them to do themselves.
	-- John Locke, "A Treatise Concerning Civil Government"
