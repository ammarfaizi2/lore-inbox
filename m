Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWGCWJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWGCWJO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 18:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWGCWJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 18:09:13 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54765 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932142AbWGCWJM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 18:09:12 -0400
Subject: Re: 2.6.17-mm5 + pcmcia/hostap/8139too patches -- inconsistent
	{hardirq-on-W} -> {in-hardirq-W} usage
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Miles Lane <miles.lane@gmail.com>, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1151963034.3108.59.camel@laptopd505.fenrus.org>
References: <a44ae5cd0607031431q8dcc698j1c447b1d51c7cc75@mail.gmail.com>
	 <1151963034.3108.59.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Jul 2006 23:25:57 +0100
Message-Id: <1151965557.16528.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-07-03 am 23:43 +0200, ysgrifennodd Arjan van de Ven:
> The ne2000 drivers use disable_irq as a poor mans locking construct;
> make sure lockdep knows about these.

Actually they use it as a locking construct because the kernel lacks the
constructs it needs (or did when the work was done). We don't have a 

spin_lock_disable_irq(lock, n)

construct which some other OS's do. There are also good reasons for not
having one given so few drivers realy need it.

The underlying problem is that the NE2K chips are slow, especially some
of the ones nailed to PCI with FPGA glue. So slow that worst case taking
a spinlock and uploading a packet drops characters at 9600 baud serial.

The driver disables the on chip IRQ, which for 99.9% of cases then
ensures we don't get further interrupts, then takes the lock. An IRQ
running in parallel on another CPU also holds the lock so that much is
fine.
 
However: the people at Intel designed the original APIC bus to be
somewhat slow, asynchronous and also without a guaranteed "one message
send, one message receive" sematic of any kind.

That means we have a corner case where we also have to
disable_irq_nosync to ensure that an IRQ that left the 8390 but has not
yet arrived at the processor doesn't race with us and lock up the box.
PCI posting is not the issue here, the IRQ bus is itself even more async
than that.

Doing that work means our tx path doesn't totally trash the machine in
these cases.

Alan

