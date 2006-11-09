Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966018AbWKIOPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966018AbWKIOPB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 09:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966022AbWKIOPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 09:15:01 -0500
Received: from SMT02002.global-sp.net ([193.168.50.254]:10194 "EHLO
	SMT02002.global-sp.net") by vger.kernel.org with ESMTP
	id S966018AbWKIOO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 09:14:59 -0500
Message-ID: <45533801.7000809@privacy.net>
Date: Thu, 09 Nov 2006 15:15:29 +0100
From: John <me@privacy.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050905
X-Accept-Language: en, fr
MIME-Version: 1.0
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
CC: auke-jan.h.kok@intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, hpa@zytor.com, saw@saw.sw.com.sg
Subject: Re: Intel 82559 NIC corrupted EEPROM
References: <454B7C3A.3000308@privacy.net> <454BF0F1.5050700@zytor.com> <45506C9A.5010009@privacy.net> <4551B7B8.8080601@privacy.net> <4807377b0611080926x21bd6326xc5e7683100d20948@mail.gmail.com>
In-Reply-To: <4807377b0611080926x21bd6326xc5e7683100d20948@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Nov 2006 14:17:07.0192 (UTC) FILETIME=[BCC9FF80:01C70409]
X-global-asp-net-MailScanner: Found to be clean
X-global-asp-net-MailScanner-SpamCheck: 
X-MailScanner-From: me@privacy.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Brandeburg wrote:

> I suspect that one reason Becker's code works is that it uses IO
> based access (slower, and different method) to the adapter rather
> than memory mapped access.

I've noticed this difference.

> The second thought is that the adapter is in D3, and something about
> your kernel or the driver doesn't successfully wake it up to D0.

On my NICs, the EEPROM ID (Word 0Ah) is set to 0x40a2.
Thus DDPD (bit 6) is set to 0.

DDPD is the "Disable Deep Power Down while PME is disabled" bit.
0 - Deep Power Down is enabled in D3 state while PME-disabled.
1 - Deep Power Down disabled in D3 state while PME-disabled.
This bit should be set to 1b if a TCO controller is being used via the 
SMB because it requires receive functionality at all power states.

Are you suggesting I try and set DDPD to 1?
Or is this completely unrelated?

> An indication of this would be looking at lspci -vv before/after
> loading the driver.

$ diff -u lspci_vv_before_e100.txt lspci_vv_after_e100.txt
--- lspci_vv_before_e100.txt    2006-11-09 14:51:30.000000000 +0100
+++ lspci_vv_after_e100.txt     2006-11-09 14:51:30.000000000 +0100
@@ -74,21 +74,20 @@
         Expansion ROM at 20000000 [disabled] [size=1M]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
-               Status: D0 PME-Enable+ DSel=0 DScale=2 PME-
+               Status: D0 PME-Enable- DSel=0 DScale=2 PME-

  00:09.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 
100] (rev 08)
         Subsystem: Intel Corporation EtherExpress PRO/100B (TX)
-       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
+       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
-       Latency: 32 (2000ns min, 14000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 10
-       Region 0: Memory at e5302000 (32-bit, non-prefetchable) [size=4K]
-       Region 1: I/O ports at dc00 [size=64]
-       Region 2: Memory at e5100000 (32-bit, non-prefetchable) [size=1M]
+       Region 0: Memory at e5302000 (32-bit, non-prefetchable) 
[disabled] [size=4K]
+       Region 1: I/O ports at dc00 [disabled] [size=64]
+       Region 2: Memory at e5100000 (32-bit, non-prefetchable) 
[disabled] [size=1M]
         Expansion ROM at 20100000 [disabled] [size=1M]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
-               Status: D0 PME-Enable+ DSel=0 DScale=2 PME-
+               Status: D0 PME-Enable- DSel=0 DScale=2 PME-

  00:0a.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 
100] (rev 08)
         Subsystem: Intel Corporation EtherExpress PRO/100B (TX)

> Also, after loading/unloading eepro100 does the e100 driver work?

No.

> A third idea is look for a master abort in lspci after e100 fails to
> load.

I don't understand that one.

