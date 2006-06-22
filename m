Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbWFVODD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbWFVODD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 10:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030640AbWFVODB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 10:03:01 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:51389 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1030290AbWFVODA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 10:03:00 -0400
Message-ID: <449AA320.3060700@acm.org>
Date: Thu, 22 Jun 2006 09:03:12 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060517)
MIME-Version: 1.0
To: Peter Palfrader <peter@palfrader.org>, linux-kernel@vger.kernel.org,
       openipmi-developer@lists.sourceforge.net
Subject: Re: [Openipmi-developer] BUG: soft lockup detected on CPU#1, ipmi_si
References: <20060613233521.GO22999@asteria.noreply.org>	<44962116.70302@acm.org> <20060619093851.GL27377@asteria.noreply.org>
In-Reply-To: <20060619093851.GL27377@asteria.noreply.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter, can you make a code change for me and try something out?

If possible, could you change the call to udelay(1) in the function
ipmi_thread() in drivers/char/ipmi_si_intf.c to be a call to schedule()
instead?  I'm guessing that will fix this problem.

-Corey

Peter Palfrader wrote:
> On Sun, 18 Jun 2006, Corey Minyard wrote:
>
>   
>> The IPMI driver spawns a low-priority thread that will poll the driver
>> when it finds there is something to do.  It's possible that the hardware
>> is not setting things properly and is always telling the driver it has
>> to do something.  It's possible that the new version of the firmware
>> enabled interrupts; I think there's a problem with the driver here; it
>> should not really enable the kernel thread if interrupts are working. 
>> The driver should also probably call schedule() instead of udelay() in
>> the kernel thread when a short timeout is requested by the state machine.
>>
>> In either situation, the kernel thread will sit there and spin, and if
>> nothing else is scheduled for 10 seconds on that CPU you will get that
>> warning.  Can you check a few things for me?
>>
>> cat /proc/ipmi/0/si_stats and send me the output.
>>     
>
> After running for about 35 minutes (and one instance of the soft lockup
> warning):
>
> | interrupts_enabled:    0
> | short_timeouts:        8835
> | long_timeouts:         263709
> | timeout_restarts:      0
> | idles:                 793108
> | interrupts:            0
> | attentions:            0
> | flag_fetches:          2137
> | hosed_count:           0
> | complete_transactions: 3516
> | events:                0
> | watchdog_pretimeouts:  0
> | incoming_messages:     0
>
>
>   
>> If you do "top", is the kipmi0 always running?
>>     
>
> Yes, running since the system started around 11:00:
>
> | root      1331  0.8  0.0     0    0 ?        SN   10:59   0:17  \_ [kipmi0]
>
>   
>> Is your IPMI interface KCS or SMIC?  The IPMI driver should report this
>> in the system log at startup.
>>     
>
> It's KCS:
>
> | laura:~# dmesg  | grep -i ipmi
> | [   85.110244] ipmi message handler version 39.0
> | [   85.111491] ipmi device interface
> | [   85.127866] IPMI System Interface driver.
> | [   85.127929] ipmi_si: Trying SMBIOS-specified KCS state machine at I/O address 0xca2, slave address 0x20, irq 0
> | [   85.274699] ipmi: Found new BMC (man_id: 0x000f85,  prod_id: 0x0000, dev_id: 0x00)
> | [   85.274852]  IPMI KCS interface initialized
> | [   85.284710] IPMI Watchdog: driver initialized
>
> Cheers,
> Peter
>   

