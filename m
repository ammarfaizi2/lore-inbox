Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263913AbUCPQUB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 11:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263369AbUCPQL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 11:11:59 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:44229 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263268AbUCPQKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 11:10:22 -0500
Subject: Re: finding out the value of HZ from userspace
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: arjanv@redhat.com, peterw@aurema.com, ak@muc.de, Richard.Curnow@superh.com
Content-Type: text/plain
Organization: 
Message-Id: <1079453698.2255.661.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 16 Mar 2004 11:14:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[various people]

>> This horrible hack of converting all tick values to 100
>> (from 1000) for export to user space because a large number
>> of user space programs assume that HZ is 100 would NOT be
>> necessary if there was a mechanism whereby user space
>> programs could find out how many ticks there are in a
>> second instead of having to make assumptions.
>
> there is one. Nothing uses it
> (sysconf() provides this info)

If you have a recent glibc on a recent kernel, it might.
You could also get a -1 or a supposed ABI value that
has nothing to do with the kernel currently running.
The most reliable way is to first look around on the
stack in search of ELF notes, and then fall back to
some horribly gross hacks as needed.

> /proc/interrupts "leaks" the value of HZ.  On x86, for instance:
> ( cat /proc/interrupts; sleep 5; cat /proc/interrupts )  |  grep timer

That doesn't really count. The code could be set to do a
dozen interrupts per jiffie tick. Jiffies are what matter.

>> It seem to change from system to system and between 2.4
>> (100 on i386) to 2.6 (1000 on i386).
>
> And can also be tweaked when compiling, and depends on architecture, and...

Yep. For Linux 2.4.xx and up, ELF notes provide the data.
For older systems, you need to compute the ratio of uptime
to total jiffies.

>> This horrible hack of converting all tick values to 100
>> (from 1000) for export to user space because a large number
>> of user space programs assume that HZ is 100 would NOT be
>> necessary if there was a mechanism whereby user space
>> programs could find out how many ticks there are in a
>> second instead of having to make assumptions.
>
> Already exists for a long time - AT_CLKTCK. glibc has a
> nice wrapper for it too (sysconf)

AT_CLKTCK is new with the 2.4 kernel. When it is missing or
unsupported by an old glibc, the sysconf() call returns
a guess instead of an error code. So sysconf() is worthless
if you want to support old kernels (Debian!) or old glibc.

> This is not only obscure sysctls, ps and top are
> also consumers of such jiffies values in /proc

They follow AT_CLKTCK when it is available, not a HZ
value from some header file. So you can change HZ quite
a bit and these tools won't mind.

> 1) Because Linux had long time HZ=100 hardcoded
>    (except on Alphas) and lots of applications
>    probably use that value today (as HZ in their
>    source and not sysconf(...))  - especially
>    since 2.4 (at least most of them) has HZ=100
>    except for 64bit CPUs).

That is severely broken anyway.

At least with Linux 2.4 kernels, many ports have used
a hardware-specific HZ value. All did, really, if you
consider user-mode Linux. My table:

  10  S/390 (sometimes)  
  20  user-mode Linux  
  32  ia64 emulator  
  64  StrongARM /Shark
 100  normal Linux
 128  MIPS, ARM  
1000  ARM
1024  Alpha, ia64
1200  Alpha

Any app supporting Linux 2.4 with an old glibc or
supporting Linux 2.2 will need to do something evil.

> A related issue that's bugged me for a long time is lack
> of userspace access to the quantity that's called
> 'freq_scale' in 2.4, where it's (1<<SHIFT_HZ)/HZ for
> HZ!=100 and 128/128.125 for HZ==100.  (I haven't started
> to reverse-engineer the equivalent value in 2.6, I took
> a quick look once and concluded things had got a little
> more hairy.)
>
> My interest is that I maintain (in spare-time) an NTP
> application called chrony (http://chrony.sunsite.dk/),
> originally written to be good for dial-up, i.e. NTP
> servers accessible for a short window once or twice a day.
> This app wants to tune the parameters it passes to
> adjtimex() to take a best shot at keeping the system
> clock correct over the potentially 'long' offline period.
> To do this well, it has to reverse-compensate for the
> freq_scale multiplier that the kernel will apply to the
> frequency value passed to adjtimex().  Getting the right
> value for this across different kernels has always been
> a fragile exercise.

Arrrrgh!!!!  I thought I had it bad.

Fortunately this is a fresh new reason to beg Linus for
some data. (all previous arguments have been rejected)
What would be useful for you?

HZ   (-1 for tickless?)
USER_HZ
freq_scale
some boolean to indicate ppc-like (pure cycle counter) time
???



