Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129809AbQKFWth>; Mon, 6 Nov 2000 17:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129630AbQKFWt3>; Mon, 6 Nov 2000 17:49:29 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:38159 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129408AbQKFWtN>; Mon, 6 Nov 2000 17:49:13 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Date: Tue, 7 Nov 2000 09:19:12 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14855.11872.519531.583123@notabene.cse.unsw.edu.au>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, ryan <ryan@netidea.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: Kernel 2.4.0test10 crash (RAID+SMP)
In-Reply-To: message from Jeff Garzik on Monday November 6
In-Reply-To: <1459.973469046@kao2.melbourne.sgi.com>
	<3A060BE5.8877F477@netidea.com>
	<14854.8617.282831.205647@notabene.cse.unsw.edu.au>
	<3A067318.E9C6ADDF@mandrakesoft.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday November 6, jgarzik@mandrakesoft.com wrote:
> Neil Brown wrote:
> > It looks like an interupt is happening while another interrupt is
> > happening, which should be impossible... but it isn't.
> 
> If multiple interrupts are hitting a single code path (like IDE irqs 14
> -and- 15), you definitely have to think about that.  The reentrancy
> guarantee only exists when a single IRQ is assigned to a single
> handler...
> 
> 	Jeff

Maybe I wasn't very clear in the description of the problem (it was a
busy day) and just hoped that the nature of the patch would make the
nature of the problem clear.

The b_end_io routine that raid1 attaches to io request buffer_heads
that are used for resyncing had a side effect of re-enabling
interrupts.  As it is called from an interrupt context, this is
clearly a bug.  It allowed another interrupt to be serviced before a
previous interrupt had been completed, which is a problem waiting to
happen.
In this case, it became a real problem because the first interrupt had
grabbed a spinlock (I didn't bother to discover which one) and the
second interrupt tried to grab the same spinlock. This produced the
deadlock which the NMI-Oopser detected and reported.

When I have (sometime today) convinced myself that I have found all
the spin_{,un}lock_irq() calls that could be called from interrupt
context and corrected them to spin_{,un}lock_irq{save,restore}()
calls, I will send the patch to Linus.

NeilBrown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
