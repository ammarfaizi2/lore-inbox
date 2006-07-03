Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWGCXPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWGCXPA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 19:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932066AbWGCXPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 19:15:00 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:16142 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750888AbWGCXO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 19:14:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=deXiRV1NtQnK2fBLmcIFp9B7S+GkI0k5bnB29GIrolI9DIw9nUHmTqIXm3lxamMfB1bBPGeNEj4LbnYDM0OjWSieg5uqtCs/uJNM0Bl8zZDCZfX1PIB37147WUXyLd4hFbMk1LlkqoGlYUZc6hvEFhXR9U297vvbQXHoztB/O98=
Message-ID: <a44ae5cd0607031614y2055828as6e0bbe2ce0d52ff1@mail.gmail.com>
Date: Mon, 3 Jul 2006 16:14:58 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.17-mm5 + pcmcia/hostap/8139too patches -- inconsistent {hardirq-on-W} -> {in-hardirq-W} usage
Cc: "Arjan van de Ven" <arjan@infradead.org>, mingo@elte.hu,
       "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1151965557.16528.36.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0607031431q8dcc698j1c447b1d51c7cc75@mail.gmail.com>
	 <1151963034.3108.59.camel@laptopd505.fenrus.org>
	 <1151965557.16528.36.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Llu, 2006-07-03 am 23:43 +0200, ysgrifennodd Arjan van de Ven:
> > The ne2000 drivers use disable_irq as a poor mans locking construct;
> > make sure lockdep knows about these.
>
> Actually they use it as a locking construct because the kernel lacks the
> constructs it needs (or did when the work was done). We don't have a
>
> spin_lock_disable_irq(lock, n)
>
> construct which some other OS's do. There are also good reasons for not
> having one given so few drivers realy need it.
>
> The underlying problem is that the NE2K chips are slow, especially some
> of the ones nailed to PCI with FPGA glue. So slow that worst case taking
> a spinlock and uploading a packet drops characters at 9600 baud serial.
>
> The driver disables the on chip IRQ, which for 99.9% of cases then
> ensures we don't get further interrupts, then takes the lock. An IRQ
> running in parallel on another CPU also holds the lock so that much is
> fine.
>
> However: the people at Intel designed the original APIC bus to be
> somewhat slow, asynchronous and also without a guaranteed "one message
> send, one message receive" sematic of any kind.
>
> That means we have a corner case where we also have to
> disable_irq_nosync to ensure that an IRQ that left the 8390 but has not
> yet arrived at the processor doesn't race with us and lock up the box.
> PCI posting is not the issue here, the IRQ bus is itself even more async
> than that.
>
> Doing that work means our tx path doesn't totally trash the machine in
> these cases.

Well, I get this:
pcmcia: request for exclusive IRQ could not be fulfilled.
pcmcia: the driver needs updating to supported shared IRQ lines.
eth2: NE2000 (DL10022 rev 30): io 0x300, irq 11, hw_addr 00:50:BA:73:92:3D
Which seems to indicate I need to tweak the PCMCIA settings to get this card
working.  I wonder if anyone is going to follow up on enabling shared IRQ
support.

Arjan, the patch you sent does cause the lockdep message to disappear,
but the card doesn't work.  When I plug an ethernet cable into the card,
neither the 10 or 100 LED lights up.  I tried running
"modprobe <modname> debug=1" on 8390 and pcnet_cs, but neither seem
to support modprobe options.  I am recompiling with debugging enabled by
tweaking the debugging values in the files.  I'll send you any useful debug
info I gather.

      Miles
