Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbVCSIFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbVCSIFu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 03:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbVCSIFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 03:05:50 -0500
Received: from mailgate1.mysql.com ([213.115.162.47]:59548 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S262431AbVCSIF1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 03:05:27 -0500
Message-ID: <423BDD37.5090604@mysql.com>
Date: Sat, 19 Mar 2005 09:05:11 +0100
From: Jonas Oreland <jonas.oreland@mysql.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050314
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: daniel.ritz@gmx.ch
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>
Subject: Re: yenta_socket "nobody cared - Disabling IRQ #4" - WORKING!!
References: <200503182243.24174.daniel.ritz@gmx.ch> <423B5D7A.1060304@mysql.com> <200503190051.28548.daniel.ritz@gmx.ch>
In-Reply-To: <200503190051.28548.daniel.ritz@gmx.ch>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again and thx again,

SUMMARY: It's working with new hook (wo/ trying second part)
         I'll post again if error comes up again.

Daniel Ritz wrote:
> On Saturday 19 March 2005 00:00, Jonas Oreland wrote:
>>
>>>it's the second time now i see this problem with an atheros chipset in
>>>combination with a TI bridge. last time it was the 1225...
>>>attached a patch that could help...
>>>
>>
>>Report:
>>1) It works somewhat better. irq doesn't get disabled.
>>2) however wlan card get disfunctional. I haven't been able to contact my wap
>>   even if i'm standing on it...
> 
> 
> i was afraid that it could have some side effects. it's probably because just
> writing a 0 to the MFUNC register is stupid...can you try to replace ti12xx_hook()
> in ti113x.h with this one?
> 

yes, now it works!!! (limited testing)
I tried rebooting plugging/unplugging/swsuspending maybe 6 times.
All of them working, that a new record :-)

Should I try "second step" anyway?

>>3) unplug has resulted in kernel panic (twice)
>>   (btw: how do I do to capture and report those)
> 
> 
> at a first guess i would blame the atheros driver which taints the kernel.
> so try _not_ loading the atheros driver and see if it still happens. if
> so the messages please. to capture them you can use a serial console
> (null modem cable to second pc). check out the "remote serial console"
> howto on www.tldp.org

might be...the driver...haven't tried wo/ it.

note: I never got this after new hook,

> 
> 
>>4) when unlug don't produce kernel panic, then there is no way of power-oning that card again.
>>5) booting with the card inserted makes it not power on when yenta_socket is loaded (module)
> 
> 
> anything in dmesg then?

zero

>>comment: the card being disfunction could have something to with the driver.
>>but before it worked sometimes...
>>
>>
>>>--------------
>>>
>>>for TI bridges: turn off interrupts during card power-on. this seems
>>>to be neccessary for some combination of TI bridges with at least CB cards
>>>with atheros chipset...problem is that they produce an interrupt storm
>>>during power-on so the kernel happens to disable the IRQ which is a bad
>>>thing (tm).
>>>adds a generic hook function so that a socket driver can hook into
>>>almost anywhere (by adding more hook points of course). this is the
>>>cleanest way i can think of. and it allows adding more workarounds
>>>for more problems...
>>>for the TI specific interrupt on-off stuff just save the MFUNC register
>>>and set it to 0 to disable all interrupts, restore it afterwards.
>>>
>>>Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>
>>
>>Some thoughts: (not I'm neither pcmcia nor linux expert).
>>
>>The "irq storm", shouldn't that be "acked" in someway.
>>I.e. the card produced a lot of irq's (that get ignored)
>>isn't the "real" solution to capture them, and "do something clever"?
>>
>>Instead of just "shutting the card down".
>>
>>hmmm...wonder if that made sence
> 
> 
> it's the CB device that is making the interrupt storm and the TI
> bridge is stupid enough to let the interrupts thru during power
> on. thing is you can't ack them at this time because the cardbus
> resources are not set up at this time and ack'ing an IRQ is
> device specifc.

ok

>>Question: Why do you think that it worked sometimes before?
> 
> 
> pure luck?

How about 2.4? can you compare cs code with 2.6?
It always worked in 2.4...

/Jonas

> can you also give me a dump of /proc/iomem?

00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cd000-000ce7ff : Adapter ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-0f6effff : System RAM
  00100000-00409648 : Kernel code
  00409649-005183ff : Kernel data
0f6f0000-0f6fffff : reserved
0f700000-3f6effff : System RAM
3f6f0000-3f6f7fff : ACPI Tables
3f6f8000-3f6f9fff : ACPI Non-volatile Storage
3f700000-3fffffff : reserved
40000000-400003ff : 0000:00:1f.1
40001000-40001fff : 0000:02:01.0
  40001000-40001fff : yenta_socket
40400000-407fffff : PCI CardBus #03
40800000-40bfffff : PCI CardBus #03
  40800000-4080ffff : 0000:03:00.0
    40800000-4080ffff : ath
d0000000-d007ffff : 0000:00:02.0
d0080000-d00fffff : 0000:00:02.1
d0100000-d01003ff : 0000:00:1d.7
  d0100000-d01003ff : ehci_hcd
d0100800-d01008ff : 0000:00:1f.5
  d0100800-d01008ff : Intel 82801DB-ICH4
d0100c00-d0100dff : 0000:00:1f.5
  d0100c00-d0100dff : Intel 82801DB-ICH4
d0200000-d020ffff : 0000:02:00.0
  d0200000-d020ffff : tg3
e0000000-e7ffffff : 0000:00:02.0
e8000000-efffffff : 0000:00:02.1
ff800000-ffffffff : reserved

