Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbUBYVht (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 16:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbUBYVgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:36:01 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:6598 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261552AbUBYVdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:33:45 -0500
Subject: Re: /proc or ps tools bug?  2.6.3, time is off
From: Albert Cahalan <albert@users.sf.net>
To: George Anzinger <george@mvista.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       David Ford <david+powerix@blue-labs.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <403D0986.8040405@mvista.com>
References: <403C014F.2040504@blue-labs.org>
	 <1077674048.10393.369.camel@cube>  <403C2E56.2060503@blue-labs.org>
	 <1077679677.10393.431.camel@cube>  <403CCD3A.7080200@mvista.com>
	 <1077725042.8084.482.camel@cube>  <403D0986.8040405@mvista.com>
Content-Type: text/plain
Organization: 
Message-Id: <1077736561.10393.486.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 25 Feb 2004 14:16:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger writes:
> Albert Cahalan wrote:
>>  On Wed, 2004-02-25 at 11:28, George Anzinger wrote:

>>> As to small drifts of ~170 PPM, they are caused by code
>>> (ps I would guess) that assumes that jiffies is exactly
>>> 1/HZ whereas it is NOT in the 2.6.* kernel.  The size of
>>> the jiffie that the kernel uses is returned by:
>>>
>>> struct timespec tv;
>>> :
>>> :
>>> clock_res(CLOCK_REALTIME, &tv);
>>>
>>> This will be in nanoseconds (and must be as that is what the wall clock is in).
>>
>> This is NOT sane. Remeber that procps doesn't get to see HZ.
>> Only USER_HZ is available, as the AT_CLKTCK ELF note.
>
> May be, I did not do this, but only cleaned up the internal
> notion of jiffy so timers would work more correctly.  If you
> go back to HZ=100, every thing works better in this regard.
>
> On the other hand, what practical difference does it make?
> Almost no user code even looks at USER_HZ.  Its just things
> like ps and friends as far as I can tell...  Possibly we
> should just fix the utilities to use the above call to get
> the jiffie size...  I don't know the full history, but was
> USER_HZ invented by the 2.5 changes?

USER_HZ was invented by the 2.5 changes.

Linus has decreed that USER_HZ is part of the ABI.
For some reason (ARM port or stubborn glibc hacker?)
he has allowed USER_HZ to be exposed via an ELF note.
Prior to that, he'd refused all attempts to get HZ
exported through /proc/sys and similar.

I'm OK with any integer value as long as I can get it.
On older kernels procps will guess HZ from the uptime
and clock ticks, since there is a long history of
people running with non-standard HZ values.

Since the ABI is that USER_HZ==100, the kernel is
currently in violation. Perhaps the HZ-to-USER_HZ
conversion needs to be redone.

USER_HZ appears in SCSI ioctls, network stats,
an old clock ("clocks"? "times"?) syscall...

>> I think the way to fix this is to skip or add a tick
>> every now and then, so that the long-term HZ is exact.
>
> This is REAL problem for any code that wants to use
> more exact time/ timers than the 1/HZ.  See, for example,
> the high res patch (signature).  You can not just throw
> in an extra tick every so often.

You're just considering short-term time scales.
The extra ticks, over a period of many days, lead
you to the exact time.

I suppose it would be possible to have things both ways.
Raw jiffies is as it is today. Then we have a correction
factor that gets adjusted as needed to ensure that we can
get long-term-exact 1/HZ ticks as:  jiffies + correction

>> Another way is to simply choose between pure old-style
>> tick-based timekeeping and pure new-style cycle-based
>> (TSC or ACPI) timekeeping. Systems with uncooperative
>> hardware have to use the old-style time keeping. This
>> should simply the code greatly.
>
> Hm, the reason 1/HZ is not used is that the x86 hardware
> (PIT, to be exact) can not give a good 1/1000 value...

If using the PIT:

a. no broken attempt at high-res timekeeping
b. add or skip whole ticks as needed for timekeeping

Common timekeeping tasks don't fit neatly on jiffie
ticks anyway. You need 16.683 ticks per NTSC field, etc.

When you fully push timekeeping onto the TSC, ACPI
timer, or PowerPC bus counter, then you can have a
relatively crud-free high-res implementation.



