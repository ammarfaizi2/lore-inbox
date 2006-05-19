Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbWESVH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWESVH4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 17:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWESVH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 17:07:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39350 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964843AbWESVHz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 17:07:55 -0400
Date: Fri, 19 May 2006 14:10:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Christian Kujau" <evil@g-house.de>
Cc: linux-kernel@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: SCSI ABORT with 2.6.17-rc4-mm1
Message-Id: <20060519141032.23de6eee.akpm@osdl.org>
In-Reply-To: <62331.192.18.1.5.1148071784.squirrel@housecafe.dyndns.org>
References: <62331.192.18.1.5.1148071784.squirrel@housecafe.dyndns.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Christian Kujau" <evil@g-house.de> wrote:
>
> [sorry for repost, local MTA problems here...]
> 
> Hi list, Hi Andrew,
> 
> I cannot boot 2.6.17-rc4-mm1 because my rootdisk is a scsi disk and upon
> scsi-init (SYM53C8XX_2) I'm getting:
> 
> May 19 15:39:55 prinz sym0: <895> rev 0x1 at pci 0000:02:09.0 irq 161
> May 19 15:39:55 prinz sym0: Tekram NVRAM, ID 7, Fast-40, LVD, parity checking
> May 19 15:39:55 prinz sym0: SCSI BUS has been reset.
> May 19 15:39:55 prinz scsi0 : sym-2.2.3
> May 19 15:40:08 prinz 0:0:0:0: ABORT operation started.
> May 19 15:40:13 prinz 0:0:0:0: ABORT operation timed-out.
> May 19 15:40:13 prinz 0:0:0:0: DEVICE RESET operation started.
> May 19 15:40:18 prinz 0:0:0:0: DEVICE RESET operation timed-out.
> May 19 15:40:18 prinz 0:0:0:0: BUS RESET operation started.
> May 19 15:40:23 prinz 0:0:0:0: BUS RESET operation timed-out.
> May 19 15:40:23 prinz 0:0:0:0: HOST RESET operation started.
> May 19 15:40:23 prinz sym0: SCSI BUS has been reset.
> May 19 15:40:28 prinz 0:0:0:0: HOST RESET operation timed-out.
> May 19 15:40:28 prinz 0:0:0:0: scsi: Device offlined - not ready after
> error recovery
> May 19 15:40:33 prinz 0:0:1:0: ABORT operation started.
> May 19 15:40:38 prinz 0:0:1:0: ABORT operation timed-out.
> May 19 15:40:38 prinz 0:0:1:0: DEVICE RESET operation started.
> May 19 15:40:43 prinz 0:0:1:0: DEVICE RESET operation timed-out.
> May 19 15:40:43 prinz 0:0:1:0: BUS RESET operation started.
> 
> I have backed out drivers-scsi-use-array_size-macro.patch, but to no
> avail. There are other scsi-related patches in the broken-out
> mm-directory, any hint which one to try first? Sometimes they're dependent
> on each other, so I find it not easy to just "patch -R" all "*scsi*.patch"
> files.
> 
> Please see http://www.nerdbynature.de/bits/2.6.17-rc4-mm1/  for a
> netsconsole-dmesg for 2.6.17-rc4 (working fine) and a the -mm1.
> 
> I've tried different .configs for -mm1, created with:
> 
> - yes ''  | make oldconfig (config-2.6-mm.2.6.17-rc4-mm1.oldconfig_default)
> - yes 'N' | make oldconfig (config-2.6-mm.2.6.17-rc4-mm1.oldconfig_no)
> - make oldlconfig (interactive, config-2.6-mm.2.6.17-rc4-mm1.oldconfig_my)
> 

Thanks for the report, and thanks for testing.  The full demsg output
really helps.


It goes pear-shaped very early:

--- prinz64-nc.2.6.17-rc4.log	Fri May 19 13:56:34 2006
+++ prinz64-nc.2.6.17-rc4-mm1.log	Fri May 19 13:56:58 2006
@@ -12,20 +12,17 @@
 BIOS-e820: 00000000fefffc00 - 00000000ff000000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
 DMI 2.2 present.
+ACPI: Unable to map RSDT header
+node 0 zone Normal missaligned start pfn, enable UNALIGNED_ZONE_BOUNDRIES
+node 0 zone HighMem missaligned start pfn, enable UNALIGNED_ZONE_BOUNDRIES


And from then on, ACPI is kaput.  So your interrupts are kaput, as is the
disk controller.

I had some of this happening too - it's due to some of the MM patches from
Mel and/or Andy.  I also managed to provoke "Too many memory regions,
truncating" out of it.


I hope that's all sorted out now.  Please test next -mm (hopefully
tomorrow) and let us know?

Or, if you're super-keen,
http://www.zip.com.au/~akpm/linux/patches/stuff/x.bz2 is my current rollup
(against 2.6.17-rc4).  It was compilable this morning, but I've since
merged stuff ;) It would be interesting to know if that has fixed the bug.
