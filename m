Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbUJZMCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbUJZMCD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 08:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbUJZMCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 08:02:02 -0400
Received: from alog0342.analogic.com ([208.224.222.118]:5248 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262242AbUJZMBv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 08:01:51 -0400
Date: Tue, 26 Oct 2004 08:01:01 -0400 (EDT)
From: linux-os <root@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Corey Minyard <minyard@acm.org>
cc: "Maciej W. Rozycki" <macro@linux-mips.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Race betwen the NMI handler and the RTC clock in practially all
 kernels II
In-Reply-To: <417D786F.4020101@acm.org>
Message-ID: <Pine.LNX.4.61.0410260754430.7982@chaos.analogic.com>
References: <417D2305.3020209@acm.org.suse.lists.linux.kernel>
 <p73u0sik2fa.fsf@verdi.suse.de> <Pine.LNX.4.58L.0410252054370.24374@blysk.ds.pg.gda.pl>
 <20041025201758.GG9142@wotan.suse.de> <20041025204144.GA27518@wotan.suse.de>
 <Pine.LNX.4.58L.0410252157440.10974@blysk.ds.pg.gda.pl> <417D786F.4020101@acm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2004, Corey Minyard wrote:

> Maciej W. Rozycki wrote:
>
>> On Mon, 25 Oct 2004, Andi Kleen wrote:
>> 
>> 
>>> So it's impossible to check the old value. The original code is the only
>>> way to do this (if it's even needed, Intel also doesn't say anything
>>> about this bit being a flip-flop). Only possible change would be to write 
>>> an alternative index.
>>> 
>> 
>> You can't read the old value, but you can have a shadow variable written
>> every time the real index is written.  Since NMIs are not preemptible and
>> this is a simple producer-consumer access, no mutex around accesses to the
>> variable is needed.
>>

Yes it is!

 	Task 1			NMI
 	-------			----
 	Sets index register
 				Sets index register to something else
 	Reads wrong value

The NMI, by definition can't be masked so there is nothing that
can be done with interrupts to prevent task 1 from getting
the wrong value except spin-locks.

Anybody who accesses that shared device must use that device's
spin-lock and the lock must be obtained prior to caching the
shadow value.


>>  Maciej
>> 
> If you look at my patch, it does create a shadow index.
>
> And you need a mutex for SMP systems.  If one processor is handling an NMI, 
> another processor may still be accessing the device.
>
> The complexity comes because the claiming of the lock, the CPU that owns the 
> lock, and the index has to be atomic because the NMI handler has to know all 
> these things when the lock is claimed.
>
> -Corey

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 GrumpyMips).
                  98.36% of all statistics are fiction.
