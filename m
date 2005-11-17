Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161059AbVKQBHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161059AbVKQBHH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 20:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161062AbVKQBHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 20:07:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63421 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161059AbVKQBHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 20:07:05 -0500
Date: Wed, 16 Nov 2005 17:06:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: VIA SATA Raid needs a long time to recover from suspend
Message-Id: <20051116170642.313aeada.akpm@osdl.org>
In-Reply-To: <437AA996.9080505@cfl.rr.com>
References: <437AA996.9080505@cfl.rr.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi <psusi@cfl.rr.com> wrote:
>
> I have been debugging a power management problem for a few days now, and 
> I believe I have finally solved the problem.  Because it involved 
> patching the kernel, I felt I should share the fix here in hopes that it 
> can be improved and/or integrated into future kernels.  Right now I am 
> running 2.6.14.2 on amd64, compiled myself, with the ubuntu breezy amd64 
> distribution. 
> 
> First I'll state the fix.  It involved changing two lines in 
> include/linux/libata.h:
> 
> static inline u8 ata_busy_wait(struct ata_port *ap, unsigned int bits,
>                    unsigned int max)
> {
>     u8 status;
> 
>     do {
>         udelay(100);                                 <-- changed to 100 
> from 10
>         status = ata_chk_status(ap);
>         max--;
>     } while ((status & bits) && (max > 0));
> 
>     return status;
> }
> 
> and:
> 
> static inline u8 ata_wait_idle(struct ata_port *ap)
> {
>     u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 
> 10000);             <-- changed to 10,000 from 1,000
> 
>     if (status & (ATA_BUSY | ATA_DRQ)) {
>         unsigned long l = ap->ioaddr.status_addr;
>         printk(KERN_WARNING
>                "ATA: abnormal status 0x%X on port 0x%lX\n",
>                status, l);
>     }
> 
>     return status;
> }

This change will increase the minimum delay in both ata_wait_idle() and
ata_busy_wait() from 10 usec to 100 usec, which is not a good change.

It would be less damaging to increase the delay in ata_wait_idle() from
1000 to 100,000.  A one second spin is a bit sad, but the hardware's bust,
so that's the least of the user's worries.

The best fix would be to identify the specific _callers_ of these functions
which need their delay increased.   You can do that by adding:

	if (max == 0)
		dump_stack();

at the end of ata_busy_wait().  The resulting stack dumps will tell you
where the offending callsites are.  With luck, it's just one.  If we know
which one, that might point us at some chipset-level delay which we're
forgetting to do, or something like that.

> The problem seems to be that my VIA SATA raid controller requires more 
> time to recover from being suspended.  It looks like the code in 
> sata_via.c restores the task file after a resume, then calls 
> ata_wait_idle to wait for the busy bit to clear.  The problem was that 
> this function timed out before the busy bit cleared, resulting in 
> messages like this:
> 
> ATA: abnormal status 0x80 on port 0xE007
> 
> Then if there was an IO request made immediately after resuming, it 
> would timeout and fail, because it was issued before the hardware was 
> ready.  Changing the timeout resolved this.  I tried changing both the 
> udelay and ata_busy_wait lines to increase the timeout, and it did not 
> seem to matter which I changed, as long as the total timeout was 
> increased by a factor of 100. 
> 
> Since increasing the maximum timeout, suspend and hibernate work great 
> for me.  While experiencing this bug, it may have exposed another bug, 
> which I will mention now in passing.  As I said before, after a resume, 
> if there was an IO request made immediately ( before the busy bit 
> finally did clear ) it would timeout and fail.  It seemed the kernel 
> filled the buffer cache for the requested block with garbage rather than 
> retry the read.  It seems to me that at some point, the read should have 
> been retried.

Or should have returned an IO error.

Yes, this might be a driver bug.  Again, if we know precisely which
callsite is experiencing the timeout then we're better situated to fix it.

