Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268028AbUIJXXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268028AbUIJXXy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 19:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268030AbUIJXXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 19:23:54 -0400
Received: from the-village.bc.nu ([81.2.110.252]:42418 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268028AbUIJXXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 19:23:41 -0400
Subject: Re: [PATCH] i386 reduce spurious interrupt noise
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Wedgwood <cw@f00f.org>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20040910231052.GA3078@taniwha.stupidest.org>
References: <20040902192820.GA6427@taniwha.stupidest.org>
	 <Pine.LNX.4.58L.0409102306420.20057@blysk.ds.pg.gda.pl>
	 <20040910231052.GA3078@taniwha.stupidest.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094854872.18282.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 10 Sep 2004 23:21:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-09-11 at 00:10, Chris Wedgwood wrote:
> On Fri, Sep 10, 2004 at 11:23:20PM +0200, Maciej W. Rozycki wrote:
> 
> > > -	printk (KERN_INFO "APIC error on CPU%d: %02lx(%02lx)\n",
> > > +	printk (KERN_DEBUG "APIC error on CPU%d: %02lx(%02lx)\n",
> 
> > This should probably be KERN_ERR even.  This is a serious condition -- if
> > you ever get such a message, then inter-APIC messages get corrupted and
> > this affects system's stability.
> 
> These messages are very common on many platforms, infrequent (once
> very few days to twice a day at most in my observations) and seemingly
> harmless.

On a lot of 2.4 boxes they aren't harmless but thats 2.4 IPI messsage
handling bugs. People sometimes assume an IPI is delivered once - but
its not its delivered "at least once" and when you get a checksum error
like on old dual celerons you get replays.

They also identify kernel bugs in some other bit combinations so they
are useful there too. I'd say this should only go if we are sure 2.6.x
handles IPI replay properly and we mask bits off to see if its real news
or a retry.

> > > -			printk("spurious 8259A interrupt: IRQ%d.\n", irq);
> > > +			printk(KERN_DEBUG "spurious 8259A interrupt: IRQ%d.\n", irq);
> 
> > You may ever get a single message per system boot from this line.
> 
> Sometimes as boot, though often in my experience several minutes after
> boot.

The IDE layer will generate these naturally as will any other code that
happens to clear an IRQ causing event in non IRQ context. Eventually you
clear it just as the IRQ is raised, and the pulse causes the error.

This should really go.

