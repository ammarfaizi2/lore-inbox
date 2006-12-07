Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163195AbWLGTAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163195AbWLGTAi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 14:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163199AbWLGTAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 14:00:38 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:56625 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163195AbWLGTAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 14:00:37 -0500
In-Reply-To: <457849E2.3080909@garzik.org>
References: <20061206234942.79d6db01.akpm@osdl.org>	<1165125055.5320.14.camel@gullible>	<20061203011625.60268114.akpm@osdl.org>	<Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>	<20061205123958.497a7bd6.akpm@osdl.org>	<6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com>	<20061205132643.d16db23b.akpm@osdl.org>	<adaac22c9cu.fsf@cisco.com>	<20061205135753.9c3844f8.akpm@osdl.org>	<Pine.LNX.4.64N.0612061506460.29000@blysk.ds.pg.gda.pl>	<20061206075729.b2b6aa52.akpm@osdl.org>	<Pine.LNX.4.64.0612060822260.3542@woody.osdl.org>	<Pine.LNX.4.64.0612061719420.3542@woody.osdl.org>	<20061206224207.8a8335ee.akpm@osdl.org>	<9392.1165487379@redhat.com> <20061207024211.be739a4a.akpm@osdl.org> <457849E2.3080909@garzik.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <72C77C91-B552-4BDE-B50A-13E16F448BCA@freescale.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, macro@linux-mips.org,
       David Howells <dhowells@redhat.com>, rdreier@cisco.com,
       ben.collins@ubuntu.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] Export current_is_keventd() for libphy
Date: Thu, 7 Dec 2006 12:59:42 -0600
To: Jeff Garzik <jeff@garzik.org>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 7, 2006, at 11:05, Jeff Garzik wrote:

> Yes, I merged the code, but looking deeper at phy its clear I  
> missed some things.
>
> Looking into libphy's workqueue stuff, it has the following sequence:
>
> 	disable interrupts
> 	schedule_work()
>
> 	... time passes ...
> 	... workqueue routine is called ...
>
> 	enable interrupts
> 	handle interrupt
>
> I really have to question if a workqueue was the best choice of  
> direction for such a sequence.  You don't want to put off handling  
> an interrupt, with interrupts disabled, for a potentially unbounded  
> amount of time.
>
> Maybe the best course of action is to mark it with CONFIG_BROKEN  
> until it gets fixed.


Yes, this is one of the design choices I made to be able to lock  
properly around MDIO transactions.

1) MDIO transactions take a long time
2) Some interfaces provide an interrupt to indicate the transaction  
has completed.

So I didn't want an irq-disabling spin lock.  It would prevent 2 from  
ever being used, and would mean all interrupts were disabled for  
thousands of cycles for MDIO transactions.

So I decreed that no MDIO transactions can happen in interrupt  
context.  But the registers to disable the specific PHY's interrupt  
are only accessible through MDIO, so in order to be able to follow  
that edict AND ever handle the interrupt, I need to disable the  
interrupt.  But I only disable the PHY's interrupt (which is likely  
shared among some devices).  I agree it's ugly, but I haven't yet  
figured out another way to do it.

I'd love to eliminate the work queue altogether.  I keep thinking  
that I could do something with semaphores, or spin_trylocks, but I'm  
not sure about the best way to let the interrupt handlers do their  
thing.

Andy

