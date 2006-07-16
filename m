Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWGPQdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWGPQdV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 12:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWGPQdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 12:33:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:10105 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751026AbWGPQdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 12:33:20 -0400
X-IronPort-AV: i="4.06,247,1149490800"; 
   d="scan'208"; a="65905568:sNHT40920383"
Message-ID: <44BA6A4A.5090007@intel.com>
Date: Sun, 16 Jul 2006 09:33:14 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.4 (X11/20060617)
MIME-Version: 1.0
To: Shawn Starr <shawn.starr@rogers.com>
CC: linux-kernel@vger.kernel.org, NetDev <netdev@vger.kernel.org>
Subject: Re: [2.6.18-rc2][e1000][swsusp] - Regression - Suspend to disk and
 resume breaks e1000
References: <200607160509.52930.shawn.starr@rogers.com>
In-Reply-To: <200607160509.52930.shawn.starr@rogers.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Starr wrote:
> Hardware
> 
> IBM ThinkPad T42
> E1000 card info: 
> 
> 02:01.0 Ethernet controller: Intel Corporation 82540EP Gigabit Ethernet 
> Controller (Mobile) (rev 03)
>         Subsystem: IBM PRO/1000 MT Mobile Connection
>         Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 9
>         Memory at c0220000 (32-bit, non-prefetchable) [size=128K]
>         Memory at c0200000 (32-bit, non-prefetchable) [size=64K]
>         I/O ports at 8000 [size=64]
>         [virtual] Expansion ROM at ec000000 [disabled] [size=64K]
>         Capabilities: [dc] Power Management version 2
> 
> Steps to reproduce:
> 
> 1) Suspend to disk normally
> 2) Resume from disk, the e1000 will show garbage for network statistics.
> 
> <snip>
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:83 errors:4294967254 dropped:4294967289 overruns:0 
> frame:4294967268
>           TX packets:76 errors:4294967282 dropped:0 overruns:0 
> carrier:4294967275
>           collisions:4294967289 txqueuelen:100
>           RX bytes:50728 (49.5 KiB)  TX bytes:10138 (9.9 KiB)
>           Base address:0x8000 Memory:c0220000-c0240000
> 
> Did something change in the driver that forgot to save the registers / not 
> register back upon resumption from disk? I can't tell from the code how the 
> driver knows its been brought down to S3 or S4 states.
>  
> A workaround is to then suspend to memory and resume, the e1000 will work 
> again. This is repeatable each time.
> 
> Not sure if anyone else noticed this.

[adding netdev to the cc]


unfortunately I didn't.

e1000 has a special e1000_pci_save_state/e1000_pci_restore_state set of 
routines that save and restore the configuration space. the fact that it works 
for suspend to memory to me suggests that there is nothing wrong with that.

I'm surprised that the t42 comes with a PCI/PCI-X e1000, which changes the 
need for this special routine, and the routine does the exact same thing as 
pci_save_state in your case. These special routines are made to handle PCI-E 
cards properly.

Also there are no config_pm changes related to this in 2.6.18-rc2. Most of 
this code has been in the kernel for a few major releases afaik. This code 
worked fine before, so I don't rule out any suspend-related issues. You should 
certainly compare with 2.6.18-rc1 and make sure it was a regression, perhaps 
even bisect the e1000-related changes if you have the time, which is about 22 
patches or so.

I'll see if I can find out some more once I get back to work.

Auke
