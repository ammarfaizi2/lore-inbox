Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbUK0EOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbUK0EOF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 23:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbUK0ENs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 23:13:48 -0500
Received: from zeus.kernel.org ([204.152.189.113]:65215 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262119AbUKZTN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:13:57 -0500
Date: Thu, 25 Nov 2004 15:33:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [patch, 2.6.10-rc2] floppy boot-time detection fix
Message-ID: <20041125143337.GA32051@elte.hu>
References: <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041124112745.GA3294@elte.hu> <21889.195.245.190.93.1101377024.squirrel@195.245.190.93> <20041125120133.GA22431@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125120133.GA22431@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> the -RT patchset doesnt properly detect my fd0 device, so there's
> definitely something broken in that area. The unpatched -rc2-mm3
> kernel detects it fine. Might be an effect of IRQ threading - the
> floppy hardware/driver is a fragile beast.

found the bug that causes the fd detection failure. It's a generic race
in the upstream floppy driver, which happens to work by chance in the
vanilla kernel but breaks when IRQ and softirq threading is enabled:

when the FDC hardware is initialized, it sometimes generates a floppy
interrupt right away - without being told to. This interrupt can hit the
detection code that executes right after the initialization code, in
particular it can get intermixed with user_reset_fdc() that the
detection code uses. The fd driver is fundamentally single-threaded when
it comes to handling events: an unexpected irq that arrives in the wrong
moment can confuse the reset_fdc() code, which, with softirq and hardirq
threading on, executes in keventd.

in the stock kernel this stale irq doesnt seem to hit the detection code
in the wrong moment, but i think under certain circumstances it may
still happen. One of the typical incarnations of the race was the
following message:

 reset set in interrupt, calling c0258400

and googling for "reset set in interrupt, calling" does turn up a fair
number of bootlogs (most of them 2.4 ones) that show such a detection
failure, so i think upstream wants to have the fix too.

the fix is simple: delay a bit after initialization, to make sure the
stale irq does not interfere with the detection code. It will be safely
ignored, since do_floppy is still NULL. It might look sloppy that i went
for a delay, but delay i think it is better than waiting for the irq to
occur, because i dont think there's a guarantee that fdc initialization
triggers an interrupt, so waiting for it could hang the boot process. A
delay OTOH is totally harmless.

The attached patch implements this fix, which resolves the detection
problem on my testbox.

here's again how a failure looks like:

 Floppy drive(s): fd0 is 1.44M
 reset set in interrupt, calling c0258400
 floppy0: no floppy controllers found

and this is how it works with the fix:

 Floppy drive(s): fd0 is 1.44M
 FDC 0 is a post-1991 82077

i've tested this on vanilla 2.6.10-rc2-mm3 too (to make sure this doesnt
break the floppy driver), and it should work fine in -BK too.

(this does not solve the irq threading related SMP lockup though, i'm
attacking that problem next - now that my fd0 gets detected fine ;-) )

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/drivers/block/floppy.c.orig
+++ linux/drivers/block/floppy.c
@@ -4504,6 +4578,13 @@ int __init floppy_init(void)
 		floppy_track_buffer = NULL;
 		max_buffer_sectors = 0;
 	}
+	/*
+	 * Small 10 msec delay to let through any interrupt that
+	 * initialization might have triggered, to not
+	 * confuse detection:
+	 */
+	current->state = TASK_UNINTERRUPTIBLE;
+	schedule_timeout(HZ/100 + 1);
 
 	for (i = 0; i < N_FDC; i++) {
 		fdc = i;
