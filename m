Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262655AbVAKB1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbVAKB1M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 20:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbVAKB0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 20:26:53 -0500
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:27056 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262796AbVAKBX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 20:23:29 -0500
Message-ID: <41E32ACC.8010103@kolivas.org>
Date: Tue, 11 Jan 2005 12:24:28 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Li Shaohua <shaohua.li@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] ACPI using smp_processor_id in preemptible code
References: <16A54BF5D6E14E4D916CE26C9AD30575F05409@pdsmsx402.ccr.corp.intel.com>	 <20050110095508.GJ1353@elf.ucw.cz> <1105405464.18834.4.camel@sli10-desk.sh.intel.com>
In-Reply-To: <1105405464.18834.4.camel@sli10-desk.sh.intel.com>
Content-Type: multipart/mixed;
 boundary="------------010708080709050009050404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010708080709050009050404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Li Shaohua wrote:
> On Mon, 2005-01-10 at 17:55, Pavel Machek wrote:
> 
>>>>I enabled CPU hotplug and preemptible debugging... now I get...
>>>>
>>>>BUG: using smp_processor_id() in preemptible [00000001] code:
>>>>swapper/0
>>>>caller is acpi_processor_idle+0xb/0x235
>>>>[<c020ba28>] smp_processor_id+0xa8/0xc0
>>>>[<c02338ce>] acpi_processor_idle+0xb/0x235
>>>>[<c02338c3>] acpi_processor_idle+0x0/0x235
>>>>[<c02338ce>] acpi_processor_idle+0xb/0x235
>>>>[<c02338c3>] acpi_processor_idle+0x0/0x235
>>>>[<c02338c3>] acpi_processor_idle+0x0/0x235
>>>>[<c02338c3>] acpi_processor_idle+0x0/0x235
>>>>[<c0101115>] cpu_idle+0x75/0x110
>>>>[<c04f5988>] start_kernel+0x158/0x180
>>>>[<c04f5390>] unknown_bootoption+0x0/0x1e0
>>>
>>>It doesn't trouble to me. It's in idle thread.
>>
>>You mean it does not happen to you? On my machine it fills logs very
>>quickly...
> 
> What I mean is idle thread can't be migrated so this doesn't impact the
> correctness. I guess the preemptible debugging can't recognise such
> situation.

This patch should help. If it's safe to use smp_processor_id() in 
acpi_processor_idle use the alternative call.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

--------------010708080709050009050404
Content-Type: text/x-patch;
 name="fix_acpi_smp_processor_id.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_acpi_smp_processor_id.diff"

Index: linux-2.6.10-mm2/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.10-mm2.orig/drivers/acpi/processor_idle.c	2005-01-11 12:20:31.399070008 +1100
+++ linux-2.6.10-mm2/drivers/acpi/processor_idle.c	2005-01-11 12:22:19.931570560 +1100
@@ -162,7 +162,7 @@
 	int			sleep_ticks = 0;
 	u32			t1, t2 = 0;
 
-	pr = processors[smp_processor_id()];
+	pr = processors[_smp_processor_id()];
 	if (!pr)
 		return;
 

--------------010708080709050009050404--
