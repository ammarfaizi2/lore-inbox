Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289099AbSANWXO>; Mon, 14 Jan 2002 17:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289094AbSANWW5>; Mon, 14 Jan 2002 17:22:57 -0500
Received: from a178d15hel.dial.kolumbus.fi ([212.54.8.178]:35990 "EHLO
	porkkala.jlaako.pp.fi") by vger.kernel.org with ESMTP
	id <S289096AbSANWVq>; Mon, 14 Jan 2002 17:21:46 -0500
Message-ID: <3C435995.24B8880B@kolumbus.fi>
Date: Tue, 15 Jan 2002 00:20:05 +0200
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16Q6FN-0001bD-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > In eepro100.c, wait_for_cmd_done() can busywait for one millisecond
> > > and is called multiple times under spinlock.
> >
> > Did I get that right, as long as spinlocked no sense in 
> > conditional_schedule()
> 
> No conditional schedule, no pre-emption. You would need to rewrite that 
> code to do something like try for 100uS then queue a 1 tick timer to 
> retry asynchronously. That makes the code vastly more complex for an 
> error case and for some drivers where irq mask is required during reset 
> waits won't help.

That wait_for_cmd_done() and similar functions in other drivers are called
let's say 3 times in interrupt handler or spinlocked routine and 20 times in
non-interrupts disabled nor spinlocked functions.

Spinlocked reqions are usually protected by spin_lock_irqsave().

So the code reads

	if (!spin_is_locked(sl))
		conditional_schedule();

This doesn't make the whole problem go away, but could make the situation a
little bit better for most of the time?


 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers

