Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbVLFRFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbVLFRFi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 12:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbVLFRFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 12:05:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23948 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932346AbVLFRFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 12:05:37 -0500
Date: Tue, 6 Dec 2005 12:05:33 -0500
From: Dave Jones <davej@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: gboyce <gboyce@badbelly.com>, linux-kernel@vger.kernel.org
Subject: Re: IDE + CPU Scaling problem on Via EPIA systems
Message-ID: <20051206170533.GB440@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, gboyce <gboyce@badbelly.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0511272350380.17020@localhost.localdomain> <20051128063212.GA18775@redhat.com> <1133713324.3168.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133713324.3168.3.camel@localhost>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 04:22:03PM +0000, Alan Cox wrote:
 > On Llu, 2005-11-28 at 01:32 -0500, Dave Jones wrote:
 > > On some variants of the VIA C3, we need to quiesce all DMA operations
 > > before we do a speed transition. We currently don't do that.
 > > I do have a patch from someone which adds support in the longhaul
 > > driver to wait for IDE transactions to stop, but to do it cleanly,
 > > we really need some callbacks into the IDE layer.
 > 
 > I was under the impression you could turn the IO/MEM enable on the root
 > bridge off momentarily to get the needed DMA pause safely ? Or does it
 > abort rather than retry at that point ?

I haven't tried that. Is that a safe thing to do ?
We do now disable mastering on all pci devices around the transition
as mandated in the spec, but that didn't really do much either.

Here's the patch I got from one user, which 'worked'...


Subject: [CPUFREQ] longhaul - avoid ide timeouts when bus mastering is off.

I really don't like this. Really.
Unfortunatly its necessary, otherwise after the transition, we live
for just a few minutes, and then just lockup.  In an ideal world,
the pm layer would allow some means of walking the device tree
quiescing DMA. Sadly, we don't live in an ideal world.

I'm open to suggestions on better ways to do this, as I'd rather
not push this to Linus' tree.

>From patch by: Ken Staton <ken_staton@agilent.com>
Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.11/arch/i386/kernel/cpu/cpufreq/longhaul.c~	2005-05-24 01:51:51.000000000 -0400
+++ linux-2.6.11/arch/i386/kernel/cpu/cpufreq/longhaul.c	2005-05-24 01:52:07.000000000 -0400
@@ -30,6 +30,8 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/pci.h>
+#include <linux/ide.h>
+#include <linux/delay.h>
 
 #include <asm/msr.h>
 #include <asm/timex.h>
@@ -91,6 +91,25 @@ static char *print_speed(int speed)
 }
 #endif
 
+static void ide_idle(void)
+ {
+	int i;
+	ide_hwif_t *hwif = ide_hwifs;
+	ide_drive_t *drive;
+
+	i = 0;
+	do {
+		drive = &hwif->drives[i];
+		i++;
+		if (strncmp(drive->name,"hd",2) == 0) {
+			while (drive->waiting_for_dma)
+			udelay(10);
+		} else {
+			i = 0;
+		}
+	} while (i != 0);
+}	
+
 
 static unsigned int calc_speed(int mult)
 {
@@ -146,6 +165,7 @@ static void do_powersaver(union msr_long
 	longhaul->bits.RevisionKey = 0;
 
 	preempt_disable();
+	ide_idle();	/* avoid ide timeouts when bus master off */
 	local_irq_save(flags);
 
 	/*

Whilst it may work fine, and 99.9% of VIA systems are likely IDE, it does
nothing about SCSI, so it's not quite perfect.

That said, even a 99% coverage is better than a 0% coverage we currently have.

It also seems quite racy, as it does nothing to prevent new transactions
from beginning after the drive has become idle.

		Dave

