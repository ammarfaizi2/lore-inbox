Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263563AbUEPLw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263563AbUEPLw4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 07:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbUEPLw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 07:52:56 -0400
Received: from aun.it.uu.se ([130.238.12.36]:53449 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263563AbUEPLwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 07:52:53 -0400
Date: Sun, 16 May 2004 13:52:43 +0200 (MEST)
Message-Id: <200405161152.i4GBqh00007266@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: Re: [PATCH][1/7] perfctr-2.7.2 for 2.6.6-mm2: core
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 May 2004 22:39:37 -0700, Andrew Morton wrote:
>Mikael Pettersson <mikpe@csd.uu.se> wrote:
>>
>>  The per-process perfctrs used to be accessed via /proc/pid/perfctr,
>>  but the /proc/pid/-now-denotes-that-posixy-process-grop-thingy
>>  change in 2.6 broke that, so I went away from /proc/pid/ last year.
>> 
>>  The per-process perfctrs would need their own file system mount point,
>>  with files or directories named by actual kernel task id. readdir()
>>  won't be fun to implement. The top-level access point can certainly
>>  be in a special fs, the question is whether I must go further and
>>  do that also for the individual control data fields?
>> 
>>  The global-mode perfctrs could be accessed via /dev/cpu/$cpu/gperfctr
>>  for per-cpu operations, and /dev/cpu/gperfctr/$file for global
>>  operations (like start and stop). However, global-mode perfctrs
>>  are considerably less important than per-process perfctrs, and
>>  I'd rather remove them until the per-process stuff is done.
>
>Well standing back and squinting at the problem:
>
>As it collects samples globally, oprofile is a system-wide thing.  And a
>filesytem is a system-wide thing too, so one maps onto the other nicely.
>
>But perfctr is a *per process* thing, and that doesn't map onto a
>filesystem abstraction very well at all.
>
>So unless someone comes up with a cunning way of getting your square peg
>into a filesystem's round hole, I'd be inclined to stick with a syscall
>interface.  Six syscalls would be preferable to
>one-which-contains-a-switch-statement, please.

If I drop the global-mode counters I'll still need seven calls:
six for the per-process counters, and one get-information call.
There is information that user-space needs which no other
kernel interface provides (AFAIK): the timebase-to-core multiplier
on PowerPC, and the set of forbidden(*) CPUs on x86/x86_64.
I also export several CPU feature flags. One of them, the
"can use overflow interrupt counters" flag, can't be detected
by user-space from the CPU type alone since it also depends
on local APIC availability, which in turn depends on kernel
.config, DMI scan, and kernel boot options.

I think I can eliminate the structure marshalling code, but
it will require padding structures with dummy fields for
future hardware extensions.

So seven syscalls, sys_vperfctr+0,...,sys_vperfctr+6, no
global-mode counters, and no marshalling code. Sounds Ok?

/Mikael

(*) You can thank Intel's HT P4 for that. Hyperthreaded P4s are
_asymmetric_ wrt the availability of the performance counters.
The solution is to restrict processes to thread #0 in each physical
CPU, but users must be told about this so they don't try to change
affinity to one of the forbidden (non-thread-#0) CPUs.
There are safety checks in place, so if they do so anyway their
counters are terminated before any damage is done.
