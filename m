Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263201AbVAFXuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263201AbVAFXuW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 18:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbVAFXrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 18:47:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3295 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263201AbVAFXk6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 18:40:58 -0500
Message-ID: <41DDCC78.9080201@pobox.com>
Date: Thu, 06 Jan 2005 18:40:40 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Warner <andyw@pobox.com>
CC: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance
 tests
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain> <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org> <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org> <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org> <41AEB44D.2040805@pobox.com> <20041201223441.3820fbc0.akpm@osdl.org> <41AEBD95.7030804@pobox.com> <20041202083030.A30927@florence.linkmargin.com>
In-Reply-To: <20041202083030.A30927@florence.linkmargin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Warner wrote:
> Jeff Garzik wrote:
> 
>>[...]
>>I am currently chasing a 2.6.8->2.6.9 SATA regression, which causes 
>>ata_piix (Intel ICH5/6/7) to not-find some SATA devices on x86-64 SMP, 
>>but works on UP.  Potentially related to >=4GB of RAM.
>>
>>
>>
>>Details, in case anyone is interested:
>>Unless my code is screwed up (certainly possible), PIO data-in [using 
>>the insw() call] seems to return all zeroes on a true-blue SMP machine, 
>>for the identify-device command.  When this happens, libata (correctly) 
>>detects a bad id page and bails.  (problem doesn't show up on single CPU 
>>w/ HT)
> 
> 
> Ah, I might have been here recently, with the pass-thru stuff.
> 
> What I saw was that in an SMP machine:
> 
> 1. queue_work() can result in the work running (on another
>    CPU) instantly.
> 
> 2. Having one CPU beat on PIO registers reading data from one port
>    would significantly alter the timing of the CMD->BSY->DRQ sequence
>    used in PIO. This behaviour was far worse for competing ports
>    within one chip, which I put down to arbitration problems.
> 
> 3. CPU utilisation would go through the roof. Effectively the
>    entire pio_task state machine reduced to a busy spin loop.
> 
> 4. The state machine needed some tweaks, especially in error
>    handling cases.
> 
> I made some changes, which effectively solved the problem for promise
> TX4-150 cards, and was going to test the results on other chipsets
> next week before speaking up. Specifically, I have seen some
> issues with SiI 3114 cards.
> 
> I was trying to explore using interrupts instead of polling state
> but for some reason, I was not getting them for PIO data operations,
> or I misunderstand the spec, after removing ata_qc_set_polling() - again
> I saw a difference in behaviour between the Promise & SiI cards
> here.
> 
> I'm about to go offline for 3 days, and hadn't prepared for this
> yet. The best I can do is provide a patch (attached) that applies
> against 2.6.9. It also seems to apply against libata-2.6, but
> barfs a bit against libata-dev-2.6.
> 
> The changes boil down to these:
> 
> 1. Minor changes in how status/error regs are read.
>    Including attempts to use altstatus, while I was
>    exploring interrupts.
> 
> 2. State machine logic changes.
> 
> 3. Replace calls to queue_work() with queue_delayed_work()
>    to stop SMP machines going crazy.
> 
> With these changes, on a platform consisting of 2.6.9 and
> Promise TX4-150 cards, I can move terabytes of parallel
> PIO data, without error.
> 
> My gut says that the PIO mechanism should be overhauled, I
> composed a "how much should we pay for this muffler" email
> to linux-ide at least twice while working on this, but never
> sent it - wanting to send a solution in rather than just
> making more comments from the peanut gallery.
> 
> I'll pick up the thread on this next week, when I'm back online.
> I hope this helps.

Please let me know if you still have problems?

The PIO SMP problems seem to be fixed here.

	Jeff



