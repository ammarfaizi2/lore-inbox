Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbTIVVhz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 17:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbTIVVhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 17:37:54 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:41089 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261957AbTIVVhx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 17:37:53 -0400
Date: Mon, 22 Sep 2003 22:37:32 +0100
From: Jamie Lokier <jamie@shareable.org>
To: John Bradford <john@grabjohn.com>
Cc: arjanv@redhat.com, ebiederm@xmission.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Can we kill f inb_p, outb_p and other random I/O on port 0x80, in 2.6?
Message-ID: <20030922213732.GC29869@mail.jlokier.co.uk>
References: <200309222003.h8MK38kC000353@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309222003.h8MK38kC000353@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
> > Another reason for fixing this is we are killing who knows how much
> > I/O bandwidth with this stream of failing writes to port 0x80.
> 
> Assuming we do stop using I/O to port 0x80 for timing purposes, would
> it be worth adding code to make existing POST cards double as a poor
> man's front panel display once the kernel has booted?

Problem: what if the ISA device is behind a PCI bridge?

At the moment, outb_p followed by inb will be seen by the ISA device
as "write, write, read," giving the ISA device time to propagate state
changes between the end of the first write and the beginning of the
read.

If that is replaced by "write, udelay(1), read," then it will be sent
over the PCI-ISA bridge and may be seen as "write, read" with only a
small delay between them, due to the PCI subsystem delaying the write.

We already see this problem with pure PCI devices.  The standard
solution with PCI devices is to issue a PCI read after the write, to
flush the write.

Over the PCI-ISA bridge, some transaction is needed to flush the first
write, unfortunately, if we want to guarantee the same delays that are
there at the moment.

I think that means we need to keep write to port 0x80, otherwise we
will be changing the behaviour of the many legacy drivers which use _p
operators.

-- Jamie

