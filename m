Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264308AbTEZJIa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 05:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264326AbTEZJIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 05:08:30 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:41452 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264308AbTEZJI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 05:08:29 -0400
Date: Mon, 26 May 2003 11:21:38 +0200 (MEST)
Message-Id: <200305260921.h4Q9LcNr022536@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: linux-kernel@vger.kernel.org, lkml@sigkill.net
Subject: Re: [RFC] Fix NMI watchdog documentation
Cc: Valdis.Kletnieks@vt.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 May 2003 01:31:41 -0400, Disconnect <lkml@sigkill.net> wrote:
>> OK, I put together a kernel that had the Latitude blacklist commented out,
>> and it comes up with:
>> 
>> No local APIC present or hardware disabled
>> Initializing CPU#0
>> 
>> So add the Latitude C840 to the "known b0rken" list.
>
>Ditto the Inspiron 8500 - no apic at all (which is different from
>known-broken, since nothing bad happened.)  
...
>Perhaps just a comment above those entries:
>/* Latitude C840 and Inspiron 8500 have no APIC support in hardware */

If these machines are P4-based, then I bet they do have local APICs.
However, if the BIOS boots the kernel with the local APIC disabled
on a P4, we (apic.c) don't try to enable it. The logic behind that
is that "modern" BIOSen _should_ boot with it enabled, unless they're
horribly broken.

So apply the patch below and try the "can we get the machine to hang"
checklist again.

/Mikael

--- linux-2.5.69/arch/i386/kernel/apic.c.~1~	2003-04-20 13:08:15.000000000 +0200
+++ linux-2.5.69/arch/i386/kernel/apic.c	2003-05-26 11:11:19.000000000 +0200
@@ -617,7 +617,7 @@
 		goto no_apic;
 	case X86_VENDOR_INTEL:
 		if (boot_cpu_data.x86 == 6 ||
-		    (boot_cpu_data.x86 == 15 && cpu_has_apic) ||
+		    (boot_cpu_data.x86 == 15) ||
 		    (boot_cpu_data.x86 == 5 && cpu_has_apic))
 			break;
 		goto no_apic;
