Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbTDUVkt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 17:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbTDUVkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 17:40:49 -0400
Received: from siaag1af.compuserve.com ([149.174.40.8]:46745 "EHLO
	siaag1af.compuserve.com") by vger.kernel.org with ESMTP
	id S262671AbTDUVkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 17:40:46 -0400
Date: Mon, 21 Apr 2003 17:48:39 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] 2.5.68 Fix IO_APIC IRQ assignment bug
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304211752_MC3-1-3560-DA1F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Oops, meant to send this to l-k:

Linus Torvalds wrote:

>> Looks like the fix for the "ran out of interrupt sources" panic
>>has a problem.  It will eventually assign a device the same IRQ
>>number as the first system vector, i.e. the local APIC timer.
 ...
> Did you actually see this on hardware?

  In my dreams. :)  But someone must have such hardware or the panic
wouldn't have been removed...

  Only reason I found it at all is I had changed the exact same lines
in my patch (and mine had a much bigger bug than that.)

>Btw, why would you _want_ your redirect table to look like that?
>
>> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
>> 00 001 01  0    0    0   0   0    1    1    E7     <== timer at level E
>> 01 001 01  0    0    0   0   0    1    1    30     <== start at 30, not
31

 The patch does two things:

  1.  Reserves all of priority level E for the timers --
      legacy timer at E7, first system vector DF.
      This is might be worth doing (but first system
      vector should be E0.)

  2.  Starts assigning devices at 0x30 instead of 0x31.

(1) is probably worth doing (first system vector should be E0, though.)

> Starting at 31 is better, because..
 ...
> Then we'd have devices at 81 and 89 (two per block of 16 is ok, but 80
> isn't ok because we use that for system calls).
>
> And having two devices in the 8x series means that it takes more irq
> sources to overflow and start to re-use the 3x block - and we want to

 But doesn't IRQ 0x80, even though it is software-initiated, contend
with 'real' device interrupts at priority 8, which would mean there are
three possible sources (80, 81 and 89?)  That's what I was assuming...



------
 Chuck



------
 Chuck
