Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264984AbSKSNkn>; Tue, 19 Nov 2002 08:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265187AbSKSNkn>; Tue, 19 Nov 2002 08:40:43 -0500
Received: from h-64-105-34-70.SNVACAID.covad.net ([64.105.34.70]:19414 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264984AbSKSNkm>; Tue, 19 Nov 2002 08:40:42 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 19 Nov 2002 05:47:38 -0800
Message-Id: <200211191347.FAA11306@adam.yggdrasil.com>
To: rusty@rustcorp.com.au
Subject: Re: Patch: module-init-tools-0.6/modprobe.c - support subdirectories
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
>In message <20021118073247.A10109@adam.yggdrasil.com> you [Adam Richter] write:
>Hmm, I'm not entirely convinced.  Moving back into subdirs introduces
>a namespace which isn't really there.

	As you may already have realized, the phrase "introduces a
namespace which isn't really there" does not show something that you
would be prevented or enabled to do, nor does it argue any real
trade-off (performance, kernel footprint, lines of code to maintain,
etc.).  In comparison, "select all SCSI and IDE drivers without having
to release a new version of the ramdisk maker every time a new SCSI or
IDE driver is added" does identify useful functionality that the
module tree enables.


>However, as you say, it's trivial.

	Yes, I see it as this code complexity trade-off:

	     - Add ~50 lines to modprobe

	       vs.

	     - Need to release new ramdisk builders or have users
	       maintain custom tables to be able to select of modules
	       by functional description (for example, "USB controllers").
	       Users who do not do this may not appreciate it, but it's
	       an important capability for keeping boot image sizes under
	       control.

	Also, from a system administratiion standpoint, you can more
readily tell if, say, you forgot to build sound or firewire entirely,
as opposed to just a few specific drivers.

>> 	I am sorry I was not able to test this change, but it would be
>> a lot of work for me to bring up a system without module device ID
>> table support.  I know your ChangeLog says that support is coming.  I
>> wonder if it would break your module utilities to leave the old macros
>> device ID macros in place and let people run the existing depmod.

>I'm actually tempted to push your patch for the moment, since it might
>be a week before device ID support is tested and polished enough to go
>in, with everything else I am doing.

	I am not attached to a particular format.  It's just that the
disruption of stoppping the device ID tables from working is
unnecessary.  Integrating my change as temporary is fine.


>OTOH, the current method exposes
>kernel internals to external userspace programs, which is why I do it
>differently.

	At the moment you don't do it, so I can't compare.  I can only
point out that requiring a particular ELF format also exposes
internals in another way and that something needs to read the hardware
support advertisements from every module and generate tables
translating that hardware support to module names.  Also bear in mind
that you many need to generate those tables for a kernel different
from the one you are currently running.

>> 	I also worry about about the latency of reading the
>> kernel symbols for all modules every time modprobe is called.  If I
>> want to have all of the modules installed, that's at least 1143
>> modules on x86, and this might be the standard installation of a Linux
>> distribution.  Here again, the existing depmod program could be used.

>Yes, it's a fairly obvious optimization: I'd be very interesting in
>timing measurements.  Another method is to use
>/var/cache/modprobe/`uname-r`.dep and use it if available and more
>recent than any module (removes the requirement for depmod).

	OK, once your new module scheme works well enough so that
I can complete a boot, I should be able to do "time modprobe foo"
pretty readily.

	In the meantime, I think I can guess which approach will be
faster and which one will scale better as the number of modules
available increases (read ~6000 symbols from ~1000 modules and compute
transitive closure for a set of symbols or read and walk a tree from
one file).

	Also, although depmod currently does not do this, it could be
changed to catch any reference loops, making it easier to ensure that
distributions do not ship with these problems, even for obscure
hardware.

	The code for descending into directories could also go away,
given modules.dep.

	Finally, since you seem to think that the trade-off of user
level simplicity at the expense of kernel complexity in this case is
worth it, you might like to consider that this change could reduce or
completely eliminate all references to ELF in modprobe and insmod.
depmod would still have such dependency, but it can be a bigger
program.  

>> 	Finally, I am skeptical of the benefits being worth the cost
>> of putting an ELF relocator and symbol table parser in the kernel.

>From the (just posted) FAQ:

	Great.  I'll submit comments on it separately.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
