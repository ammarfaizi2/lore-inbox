Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbTKXGT0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 01:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbTKXGTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 01:19:25 -0500
Received: from fmr03.intel.com ([143.183.121.5]:30088 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S263584AbTKXGTY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 01:19:24 -0500
Subject: Re: not fixed in 2.4.23-rc3 (was: Re: 2.4.22 SMP kernel build for
	hyper threading P4)
From: Len Brown <len.brown@intel.com>
To: Eduard Bloch <edi@gmx.de>
Cc: linux-kernel@vger.kernel.org, davej@redhat.com
In-Reply-To: <20031123204532.GA6093@zombie.inka.de>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC886F@hdsmsx402.hd.intel.com>
	 <20031123204532.GA6093@zombie.inka.de>
Content-Type: text/plain
Organization: 
Message-Id: <1069654747.2812.689.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 24 Nov 2003 01:19:07 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-11-23 at 15:45, Eduard Bloch wrote:
> #include <hallo.h>
> * Brown, Len [Sun, Nov 23 2003, 03:16:11PM]:
> > > weird 1+2xHT mode.

Please try CONFIG_NR_CPUS=8, or apply the patch below to 2.4.23.

smp_boot_cpus() incorrectly assumes that Local APIC ID's are handed out
0,1,2...

But they're handed out 0,1,6,7 on your system.  #6 happens to be your
boot CPU, smp_boot_cpus() brings up #0 and #1, and never asks to boot #7
-- thus 3 logical processors.  If #0 happened to be your boot processor,
you'd get only 2 logical processors.

cheers,
-Len


===== arch/i386/kernel/smpboot.c 1.17 vs edited =====
--- 1.17/arch/i386/kernel/smpboot.c	Mon Nov  3 08:48:33 2003
+++ edited/arch/i386/kernel/smpboot.c	Mon Nov 24 01:06:26 2003
@@ -1106,7 +1106,7 @@
 	 */
 	Dprintk("CPU present map: %lx\n", phys_cpu_present_map);
 
-	for (bit = 0; bit < NR_CPUS; bit++) {
+	for (bit = 0; bit < MAX_APICS; bit++) {
 		apicid = cpu_present_to_apicid(bit);
 		
 		/* don't try to boot BAD_APICID */



