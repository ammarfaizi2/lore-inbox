Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317258AbSFGKhJ>; Fri, 7 Jun 2002 06:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317263AbSFGKhI>; Fri, 7 Jun 2002 06:37:08 -0400
Received: from slip-202-135-75-200.ca.au.prserv.net ([202.135.75.200]:9601
	"EHLO wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S317258AbSFGKhH>; Fri, 7 Jun 2002 06:37:07 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
cc: ralf@gnu.org, rhw@memalpha.cx, mingo@redhat.com, paulus@samba.org,
        anton@samba.org, schwidefsky@de.ibm.com, bh@sgi.com, davem@redhat.com,
        ak@suse.de, torvalds@transmeta.com
Subject: Hotplug CPU Boot Changes: BEWARE
Date: Fri, 07 Jun 2002 20:40:36 +1000
Message-Id: <E17GHB3-0000gD-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all (esp port maintainers),

	In writing the hotplug CPU stuff, Linus asked me to alter the
boot sequence to "plug in" CPUs.  I am shortly going to be sending
these patches to him now I have got my x86 box to boot with the
changes.

The changes are as follows:
1) Non-linear CPU support.  No more number/logical map, or
   smp_num_cpus.  This is easy to change over to.

2) The boot sequence used to be:
	smp_boot_cpus()
	smp_commence()
	start idle thread, do initfuncs...

   Now it is:
	start idle thread
	smp_prepare_cpus(int max_cpus)
		=> Probes for cpus, sets up cpu_possible() macro to work.
	do initfuncs
	For each cpu for which cpu_possible(cpu) is true:
		cpu_up(int cpunum)
	smp_cpus_done(max_cpus);

There are two ways to transition: one is to do the minimal hacks so
that the new boot code works (as per my x86 patch).  The other is to
take into account that the next stage (optional by arch) is to
actually bring cpus up and down on the fly, and hence actually write
code that will work after boot as well (as per my ppc patch).

For the patches, see:
	http://www.kernel.org/pub/linux/kernel/people/rusty

Rusty.	
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
