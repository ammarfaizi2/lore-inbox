Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbTJITFN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 15:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbTJITFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 15:05:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:52957 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262354AbTJITFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 15:05:08 -0400
Date: Thu, 9 Oct 2003 12:05:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [RFC] disable_irq()/enable_irq() semantics and ide-probe.c
In-Reply-To: <20031009182743.GD7665@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0310091201490.22318-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 9 Oct 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> The underlined bit is absent on alpha version of the same function.
> 
> Note that this piece is bogus - if .action is NULL, we are already caught
> by IRQ_INPROGRESS check.  So it's not exactly a bug, but considering
> your arguments about exact same check slightly earlier in handle_irq()...

Yes. I'm definitely not claiming the code is beautiful. 

I think it happens to be working ;)

> It's from cset1.437.22.19 by mingo; the same changeset had done unconditional
> removal of IRQ_INPROGRESS, so there it made sense.  After the irq.c part
> had been reverted (1.497.61.30 from you), i8259.c one should be killed
> too, AFAICS...

Yeah, the IRQ_INPROGRESS removal in handle_irq() was buggy: it caused the
bit to be spuriously cleared if an interrupt happened while the previous
interrupt was active (which will _not_ happen in the i8259 case, but does
happen in the edge-triggered case).

The problem, I think, is that all this code grew fairly organically, and 
nobody ever sat down and wrote down the rules. 

Which is why I think it _works_, but it's clearly nonoptimal and sometimes 
confusing.

I suspect the 2.4.x situation is even worse. 

		Linus

