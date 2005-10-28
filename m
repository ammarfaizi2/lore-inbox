Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbVJ1RAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbVJ1RAU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 13:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbVJ1RAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 13:00:20 -0400
Received: from relay01.roc.ny.frontiernet.net ([66.133.182.164]:40326 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S1030254AbVJ1RAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 13:00:19 -0400
Reply-To: <jbowler@acm.org>
From: John Bowler <jbowler@acm.org>
To: "'David Vrabel'" <dvrabel@cantab.net>
Cc: "'Deepak Saxena'" <dsaxena@plexity.net>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] 2.6.14-rc3 ixp4xx_copy_from little endian/alignment
Date: Fri, 28 Oct 2005 09:32:10 -0700
Message-ID: <003d01c5dbdd$25ef6af0$1001a8c0@kalmiopsis>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <43621C40.3030005@cantab.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Vrabel [mailto:dvrabel@cantab.net]
>John Bowler wrote:
>> +/* On a little-endian IXP4XX system (tested on NSLU2) contrary to the
>> + * Intel documentation LDRH/STRH appears to XOR the address with 10b.

This turns out to be a misleading comment, and I have deleted it:

>The Application Note on IXP4xx endianess operation[1] says that (by 
>default) the XScale core operates in address coherency mode (i.e., it 
>flips address bits).  I suspect you need to set BYTE_SWAP_EN in 
>EXP_CNFG1 and use the P bit in the MMU to get data coherency mode for 
>various peripherals (probably all expansion bus periperals and possibly 
>all the APB peripherals).

This is the observed behaviour (address coherency) - the address bits are
flipped on LE - and I hope the rest of the comments in the patch make
this clear because the central problem being fixed is that the command
address seen by the CPU is flipped from 0xAA to 0xA8 on LE systems.

The only problem with the address coherency setting is that the flash
command address bit flipping causes the flash not to work (there's no
way of configuring the MTD code to use a different address for command,
operations which require data coherency, and data operations which require
address coherency, because the command code *does* do data reads to
get the results back.)

*All* the other peripherals on the system work - including the USB which
is on the PCI bus - we do have this patch:

>Also, I've noticed that the PCI_CSR is mis-configured when the XScale 
>core is in little-endian mode.  ABE (AHB is big-endian) /must/ always be 
>set -- remember that the NPEs are always big-endian devices.

This doesn't affect the flash (we've verified that - i.e. *with* the
patch the flash works in LE regardless of the patch for the PCI_CSR
setting).

>Since I'd never run an IXP4xx in little-endian mode I've not looked at 
>this issue in any great depth so I could be wrong here.  Regardless, the 
>proposed hack to the flash map driver is wrong since all expansion bus 
>peripherals are affected not just flash (i.e., the solution needs to be 
>more generic rather than flash driver specific).

No, that's incorrect.  The patch has been demonstrated to be correct with
all devices (along with the PCI_CSR patch, which Deepak has already pushed
upstream).  I.e. *without* the patch everything works (BE and LE) except
the flash is unuseable, *with* the patch the flash works too.

We examined a number of solutions (i.e. I tried them, had systems which
booted with them and looked at the resultant problems).  I haven't tried
setting data coherency, but I'm assuming this would break at least some
of the peripherals.

Of the solutions I tried this is the only solution which allows us to switch
from LE to BE kernel/rootfs and share data which does not change (the NSLU2
configuration partition, the all important NSLU2 ethernet MAC which is
actually inside the boot loader and the RedBoot FIS directory.)

So I'm effectively saying we need data coherency in the flash, but what we
have in everything *else* is working just find with address coherency.

John Bowler <jbowler@acm.org>

