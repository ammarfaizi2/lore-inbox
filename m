Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264993AbTIJQTV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 12:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265109AbTIJQTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 12:19:21 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:22255 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264993AbTIJQTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 12:19:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16223.20183.242571.608500@gargle.gargle.HOWL>
Date: Wed, 10 Sep 2003 18:18:31 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: mathieu.desnoyers@polymtl.ca, linux-kernel@vger.kernel.org,
       mingo@redhat.com
Subject: Re: PROBLEM: APIC on a Pentium Classic SMP, 2.4.21-pre2 and 2.4.21-pre3 ksymoops
In-Reply-To: <Pine.GSO.3.96.1030910121939.5295A-100000@delta.ds2.pg.gda.pl>
References: <200309092031.h89KVWIA027982@harpo.it.uu.se>
	<Pine.GSO.3.96.1030910121939.5295A-100000@delta.ds2.pg.gda.pl>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki writes:
 > > Fixing the oops is easy (see below), but the real problem is
 > > that 2.4.21-pre2 apparently broke MP table parsing on your HW.
 > > I suggest you sprinkle tracing printk()s in setup/smpboot/mpparse
 > > and compare 2.4.20 (good) and later (bad) to see where things
 > > start to diverge.
 > 
 >  There is no need to -- the problem is already known.  Mikael, if you need
 > additional details on how default MP configurations work in our code, feel

I think I nailed it.

First I found one very strange thing in Mathieu's boot log:

--- mpbug-2.4.20	Wed Sep 10 17:19:05 2003
+++ mpbug-2.4.23-pre3	Wed Sep 10 17:18:44 2003
...
+DMI not present.
 Intel MultiProcessor Specification v1.1
 Virtual Wire compatibility mode.
 Default MP configuration #6

This means construct_default_ISA_mptable() still gets called.
Ok so far.

...
 ENABLING IO-APIC IRQs
 Setting 2 in the phys_id_present_map
 ...changing IO-APIC physical APIC ID to 2 ... ok.

smp_found_config is true, we're now in setup_IO_APIC()
and have completed setup_ioapic_ids_from_mpc(). Ok so far.

-init IO_APIC IRQs
-IO-APIC (apicid-pin) 2-0 not connected.

THIS IS BAD. setup_IO_APIC() calls setup_IO_APIC_IRQs(),
which starts by printk()ing the first line above.
This line is missing from the 2.4.23-pre3 dmesg log, which
seems like an impossibility.

At this point I was thinking "memory corruption",
and the following struck me:

What used to be arrays (mp_irqs[] etc) are now pointers to
memory which is sized and allocated by smp_read_mpc().
In the case when construct_default_ISA_mptable() is called,
smp_read_mpc() is _not_ called, the pointers never get initialised,
and reads and writes of these arrays end up in la-la land.

The fix would be to add allocation and initialisation of
these pointers at the start of construct_default_ISA_mptable().

I'll prepare a patch doing this sometime tomorrow.

/Mikael
