Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265634AbSJSR21>; Sat, 19 Oct 2002 13:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265635AbSJSR21>; Sat, 19 Oct 2002 13:28:27 -0400
Received: from host194.steeleye.com ([66.206.164.34]:20239 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S265634AbSJSR20>; Sat, 19 Oct 2002 13:28:26 -0400
Message-Id: <200210191734.g9JHYOk03271@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: William Lee Irwin III <wli@holomorphy.com>,
       James Bottomley <James.Bottomley@HansenPartnership.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Voyager subarchitecture for 2.5.44 
In-Reply-To: Message from William Lee Irwin III <wli@holomorphy.com> 
   of "Fri, 18 Oct 2002 23:32:30 PDT." <20021019063230.GE23425@holomorphy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 19 Oct 2002 12:34:24 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a very interesting architecture. Could you describe vaguely
> (for someone starved enough for time he might have trouble finding
> time to examine your tree) how cpu wakeup with the VIC proceeds? 

You mean how the VIC boots?  Certainly.  Referring to the architecture in

http://www.hansenpartnership.com/voyager/L5arch.html

The VIC is basically a set of 8258 dyads (and voyager has up to 8 of them).  
The boot CPU can send a cross processor interrupt (CPI) to any VIC connected 
CPU.  However, the boot CPU can only modify its own VIC 8258 dyad, so theres a 
masquerade register that temporarily globally drives the VIC processor ID 
lines so that the boot CPU can lower the interrupt mask in a different VIC.

However, each CPU card has only one or two VIC connections, so booting the 
Quad cards is a sort of one-two trick: you VIC boot the VIC connected CPU 
(called the extended CPU) and then it QIC (Quad interrupt controller) boots 
the remaining CPUs.  The QIC works using a cache line interference mechanism 
(so writes to a particular part of memory trigger the CPI).  However, only 
CPUs local to the Quad can masquerade as each other to lower the QIC interrupt 
mask.

> Also, I'd like to say this patch is impressively isolated from generic
> i386 code. Although I've not tested, it seems very clear from the form
> of the code that it will have no impact on UP i386 or other subarches.

Well technically, there's the boot time GDT separation (make boot GDT smaller 
and simpler than the runtime) which affects all x86.

There's also the TSC timer problem which is fixed in the voyager tree, but 
which is still being discussed on lkml.  Without turning off the TSC entirely 
clock jitter is so bad in 2.4.43 that it causes hangs in the softirq code (I 
have four CPUs at 66Mhz and 4 at 166Mhz).

James



