Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266505AbUIMKbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266505AbUIMKbV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 06:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266508AbUIMKbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 06:31:21 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:46292 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S266505AbUIMKbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 06:31:19 -0400
Date: Mon, 13 Sep 2004 12:31:58 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Jens Axboe <axboe@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       Chris Wedgwood <cw@f00f.org>, Arjan van de Ven <arjanv@redhat.com>,
       Hugh Dickins <hugh@veritas.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20040913103158.GA17625@dualathlon.random>
References: <20040910152852.GC15643@x30.random> <20040910153421.GD24434@devserv.devel.redhat.com> <1095016687.1306.667.camel@krustophenia.net> <20040912192515.GA8165@taniwha.stupidest.org> <20040912193542.GB28791@elte.hu> <20040912203308.GA3049@dualathlon.random> <1095025000.22893.52.camel@krustophenia.net> <20040912220720.GC3049@dualathlon.random> <1095027951.22893.69.camel@krustophenia.net> <20040913073259.GF2326@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913073259.GF2326@suse.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 09:32:59AM +0200, Jens Axboe wrote:
> completion from hardirq context, SCSI is the exception since it does it
> defers the completion to softirq context.

which btw doesn't really make much difference at all to run it in irq
context with irq enabled since it'll run from irq context anyways and
you'll still depend on nested hardirqs to avoid huge latencies from
softirq handlers (the most difference between softirq and hardirq with
irq enabled happens if you can use spin_lock_bh instead of spin_lock_irq
in the critical sections to protect against other cpus).

softirq runs inside an hardirq in all common cases, so a softirq is
still an hardirq and to allow other hardirq to run you need nested
interrupts in the hardware (which again explains why it's a bad idea to
forbid nesting by design, and really I don't buy the slowdown argument,
enter/exit kernel would happen anyways, it's just the pipeline will be
stalled once and the cache may be trashed a bit, but irqs have not an
huge memory footprint anyways).
