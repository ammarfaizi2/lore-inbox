Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262913AbTAJG4c>; Fri, 10 Jan 2003 01:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263280AbTAJG4c>; Fri, 10 Jan 2003 01:56:32 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:60410 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S262913AbTAJG40>;
	Fri, 10 Jan 2003 01:56:26 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15902.28835.127030.199073@harpo.it.uu.se>
Date: Fri, 10 Jan 2003 08:05:07 +0100
To: jamesclv@us.ibm.com
Cc: Jason Lunz <lunz@falooley.org>, linux-kernel@vger.kernel.org
Subject: Re: detecting hyperthreading in linux 2.4.19
In-Reply-To: <200301091337.04957.jamesclv@us.ibm.com>
References: <slrnb1rlct.g2c.lunz@stoli.localnet>
	<200301091337.04957.jamesclv@us.ibm.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Cleverdon writes:
 > On Thursday 09 January 2003 12:02 pm, Jason Lunz wrote:
 > > Is there a way for a userspace program running on linux 2.4.19 to tell
 > > the difference between a single hyperthreaded xeon P4 with HT enabled
 > > and a dual hyperthreaded xeon P4 with HT disabled? The /proc/cpuinfos
 > > for the two cases are indistinguishable.
 > >
 > > Jason
 > >
 > > -
 > 
 > In the kernel that's no problem:
 > 
 > A) If the BIOS writers followed Intel's guidelines, just look at the physical 
 > APIC IDs.  HT siblings have odd IDs, the real ones have even.
 > 
 > B) Check the siblings table built up at boot time and used by the scheduler.
 > 
 > I don't know of any way to do this in userland.  The whole point is that the 
 > sibling processors are supposed to look like real ones.

If the kernel has sched_setaffinity() or some other way of binding a process
to a given CPU (as numbered by the kernel, which may or may not be related
to any physical CPU numbers), then this will do it: execute CPUID on each
CPU and check the initial APIC ID field. If you find one that's non-zero,
then HT is enabled.

My performance monitoring counters driver uses this approach in kernel-space
using smp_call_function(). I don't use the siblings tables because they suck :-)
[I don't think they distinguish between logical CPUs #0 and #1, and they aren't
exported to modules. The CPUID check is simple and portable across kernel versions.]
