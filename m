Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbTFONQH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 09:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbTFONQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 09:16:07 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51720 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262252AbTFONQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 09:16:02 -0400
Date: Sun, 15 Jun 2003 14:29:50 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Subject: bad: scheduling while atomic!
Message-ID: <20030615142950.A32102@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	David Woodhouse <dwmw2@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing tonnes of this with UP preempt in 2.5.71.  The following is
just one case which I've been able to track down:

bad: scheduling while atomic! (00000250 0 8 mtdblockd)
[<c02372d0>] (schedule+0x0/0x490) from [<c0335fd0>] (mtd_blktrans_thread+0x220/0x258)
 r7 = 00000000  r6 = C0109FBC  r5 = C0108000  r4 = C0109FB8
[<c0335db0>] (mtd_blktrans_thread+0x0/0x258) from [<c0224554>] (kernel_thread+0x40/0x48)
bad: scheduling while atomic! (00000251 0 8 mtdblockd)
[<c02372d0>] (schedule+0x0/0x490) from [<c0335fd0>] (mtd_blktrans_thread+0x220/0x258)
 r7 = 00000000  r6 = C0109FBC  r5 = C0108000  r4 = C0109FB8
[<c0335db0>] (mtd_blktrans_thread+0x0/0x258) from [<c0224554>] (kernel_thread+0x40/0x48)
bad: scheduling while atomic! (00000252 0 8 mtdblockd)
[<c02372d0>] (schedule+0x0/0x490) from [<c0335fd0>] (mtd_blktrans_thread+0x220/0x258)
 r7 = 00000000  r6 = C0109FBC  r5 = C0108000  r4 = C0109FB8
[<c0335db0>] (mtd_blktrans_thread+0x0/0x258) from [<c0224554>] (kernel_thread+0x40/0x48)

(The extra numbers are: preempt_count, kernel_locked, pid and comm).

This instance seems to be caused by the following code in
drivers/mtd/mtd_blkdevs.c:

         while (!tr->blkcore_priv->exiting) {
                 spin_lock_irq(rq->queue_lock);
 ...
                 spin_unlock_irq(rq->queue_lock);
 ...
                 spin_lock_irq(rq->queue_lock);
 ...
         }

It would be useful if we could balance the spin_locks with the
spin_unlocks. 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

