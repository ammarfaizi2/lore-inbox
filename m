Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269254AbTCBRXX>; Sun, 2 Mar 2003 12:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269255AbTCBRXX>; Sun, 2 Mar 2003 12:23:23 -0500
Received: from h-64-105-35-98.SNVACAID.covad.net ([64.105.35.98]:53916 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S269254AbTCBRXV>; Sun, 2 Mar 2003 12:23:21 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 2 Mar 2003 09:33:24 -0800
Message-Id: <200303021733.JAA15313@adam.yggdrasil.com>
To: zippel@linux-m68k.org
Subject: Re: Patch/resubmit linux-2.5.63-bk4 try_module_get simplification
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Mar 2003, Roman Zippel wrote:
>On Fri, 28 Feb 2003, Adam J. Richter wrote:

>> 	The following patch shrinks changes the implementation of
>> try_module_get() and friends to eliminate the special stopping of all
>> CPU's when a module is unloaded.  Instead, it uses a read/write
>> semaphore in a perhaps slightly non-intuitive way.

>Hmm, I was waiting a bit for Rusty's comment, but there isn't any...
>Anyway the patch below does the same, but it gets the module ref 
>speculative and calls module_get_sync() if there is a problem.

	That is a clever implemenation!

	I do have a few questions and comments though.

	Is there enough traffic on the module reference counts to make
this trade-off worthwhile?  On x86, the module_ref array is 512 bytes
per module (SMP_CACHE_BYTES=16 x NR_CPUS=32).  For example, my gateway
machine has 49 modules loaded right now, so that would be 24kB.  Even
in iptables, I would think that module reference counts should only be
modified when a rule is added or removed (because you still need to
maintain a separate usage count for each rule to know whether you can
remove it, even if it's not from a loadable module).

	If it's worthwhile to trade off that amount of memory usage
for that amount of reduction in cross-cpu bus traffic, then you
probably should move unload_lock into each struct module rather than
having it be a single statically variable, as it is not protecting any
statically allocated data.

	I also see a bigger corrolary of that trade-off.  If there is
enough traffic to warrant a per-cpu approach for module reference
counts, surely there should be other rw_semaphore users that
experience more traffic on a smaller number of instances than module
references.  So, perhaps your code should be generalized to "struct
big_fast_rw_sem".  In particular, I think such a facility might be
useful for the semaphore guarding name lists, such as network device
names or filesystem type names (for example, file_systems_lock in
fs/filesystems.c).

	I posted a patch some time ago for a module_get() that never
failed but which could only be called when a one of these semaphore
was held with at least a read lock, and required registration of the
relevant semaphores during the module's initialization routine.  ~90%
of users of try_module_get users could use this interface and thereby
avoid rarely used potentially buggy error branches; the remaining
users would continue to try_module_get.  It is precisely these cases
where big_fast_rw_sem might be useful.

	One common characteristic of all of the big_fast_rw_sem uses
that I have in mind, including module reference counts, is that the
counter is statically allocated.  This means that once per-cpu
variables are supported in modules, it will make sense to use
DEFINE_PER_CPU et al instead of declaring an array of NR_CPUS.
This has the advantage that it may use less memory if the platform
is able to determine a smaller maximum number of cpu's at run time,
and can potentially produce faster code if the platform implements
per-cpu using different memory mappings per cpu.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
