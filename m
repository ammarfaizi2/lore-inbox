Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267505AbUHPKEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267505AbUHPKEV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 06:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267507AbUHPKEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 06:04:21 -0400
Received: from aun.it.uu.se ([130.238.12.36]:1933 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S267505AbUHPKER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 06:04:17 -0400
Date: Mon, 16 Aug 2004 12:04:08 +0200 (MEST)
Message-Id: <200408161004.i7GA48fY002331@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: adrian@humboldt.co.uk
Subject: Re: [PATCH][2.4.27] PowerPC 745x data corruption bug fix
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org,
       paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2004 08:40:51 +0100, Adrian Cox wrote:
>On Mon, 2004-08-16 at 03:54, Mikael Pettersson wrote:
>> On Mon, 16 Aug 2004 08:13:59 +1000, Paul Mackerras wrote:
>
>> >Does CONFIG_MPC10X_BRIDGE mean just MPC107, or is it set for (e.g.)
>> >systems with a MPC106 as well?
>> 
>> I just copied this part from 2.6.8. Currently it
>> seems CONFIG_MPC10X_BRIDGE is set for some platforms
>> (sandpoint and lopec), but it is definitely not set
>> for MPC106 machines like my beige PowerMac G3.
>
>I don't understand how your patch can improve the stability of your
>machine when CONFIG_MPC10X_BRIDGE isn't set. 

See below.

>Pages should be marked coherent for the MPC106 as well as the MPC107,
>but the problem shouldn't be seen unless the processor supports the
>shared cache line state. My original patch only set
>CPU_FTR_NEED_COHERENT for the 745x family, as only 745x plus 604 have
>the shared state, but Tom Rini extended it to cover all the other
>processors. I'm not convinced that extending it was necessary, but the
>performance impact should be low.

CPU_FTR_NEED_COHERENT gets set via two independent mechanisms:

1. The old code base had #ifdef SMP blocks in hashtable.S
   and ppc_mmu.c that enforced _PAGE_COHERENT. Since that's
   now also required in some non-SMP cases, they were
   changed to be controlled by CPU_FTR_NEED_COHERENT. That's
   what CPU_FTR_COMMON is for: enforcing CPU_FTR_NEED_COHERENT
   on SMP. (Ignore CONFIG_MPC10X_BRIDGE. It's noise.)

2. For the 745x CPUs, CPU_FTR_NEED_COHERENT is explicitly
   added to their cpu_features bit mask.

So previously a CPU got _PAGE_COHERENT on SMP.
Now a CPU gets _PAGE_COHERENT on (SMP || 745x).

I suspect the CONFIG_MPC10X_BRIDGE is an attempt to enable
the fix in some other cases too.

>Also, are you sure that you have an MPC106 together with a 7455
>processor?

The kernel says so at boot:
"Found Grackle (MPC106) PCI host bridge at ..."
The CPU has PVR 0x80010201.

>  I thought that the 7455 required a revision D or later
>MPC107.

Apparently not, unless Sonnet hid an MPC107 somewhere on
their Encore/ZIF CPU upgrade card.

/Mikael
