Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWGaLzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWGaLzr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 07:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWGaLzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 07:55:47 -0400
Received: from pc1.pod.cz ([213.155.227.146]:22953 "EHLO pc11.op.pod.cz")
	by vger.kernel.org with ESMTP id S1750749AbWGaLzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 07:55:46 -0400
Date: Mon, 31 Jul 2006 13:55:45 +0200
From: Vitezslav Samel <samel@mail.cz>
To: linux-kernel@vger.kernel.org
Subject: too low MAX_MP_BUSSES
Message-ID: <20060731115545.GA3292@pc11.op.pod.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi!

  I tried upgrading our server (i386 arch) from 2.6.16 to 2.6.17 but there
were some odd messages in dmesg:

	MP table busid value (32) for bustype ISA is too large, max. supported is 31

and (repeated 315 times):

	unknown bus type 32

I found out that 50% of the processor time was spent in softirq and the timers
ran too fast. I didn't look for what else was wrong.

  Tracked down to this change in 2.6.17-rc2:

diff -urN linux-2.6.17-rc1/arch/i386/kernel/mpparse.c linux-2.6.17-rc2/arch/i386/kernel/mpparse.c
+       if (m->mpc_busid >= MAX_MP_BUSSES) {
+               printk(KERN_WARNING "MP table busid value (%d) for bustype %s "
+                       " is too large, max. supported is %d\n",
+                       m->mpc_busid, str, MAX_MP_BUSSES - 1);
+               return;
+       }

 Uping the MAX_MP_BUSSES value in include/asm-i386/mach-default/mach_mpspec.h
to 64 makes the machine work O.K.
The system is HP DL380 g4 with 1 Xeon CPU, kernel compiled non-SMP.

  Here is excerpt from mptable output:
---
Bus:            Bus ID  Type
                 0       PCI
                 1       PCI
                 2       PCI
                 3       PCI
                 4       PCI
                 5       PCI
                 6       PCI
                10       PCI
                32       ISA
---
The last item is the offending one.

Please, can you consider up the default value of MAX_MP_BUSSES?

P.S.: also tested 2.6.18-rc3, the same - bad - result

	Cheers,
		Vita
