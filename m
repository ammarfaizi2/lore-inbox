Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268392AbUIGSs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268392AbUIGSs1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268438AbUIGSpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:45:14 -0400
Received: from moutng.kundenserver.de ([212.227.126.184]:36059 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S268356AbUIGSns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:43:48 -0400
Message-ID: <413E015D.9010805@fs2k2.de>
Date: Tue, 07 Sep 2004 20:43:41 +0200
From: Bernhard Heibler <spam@fs2k2.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Boot of smp system hangs in wakeup_secondary_cpu (Bug No 1659)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:919bb675a7ae8654faa974ca0813e2c2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I try to resolve the following issue. My SMP System hangs during boot.
Software Environment: 2.6.8.1 but also happens with older 2.6 kernels
Hardware Environment: 2 x Pentium 4 Xeon 2.8 GHZ Hyper Threading, Tyan 
Tiger i7505

The hangup doesn't happen always it happens in maybe 33% of boot tries. 
It seams that the problem doesn't happen if Hyper threading is disabled 
in the Bios.

The boot process stops at this point:

....
Booting processor 2/6 eip 3000
Initializing CPU#2
masked ExtINT on CPU#2
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 4767.74 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 6
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#2.
CPU#2: Intel P4/Xeon Extended MCE MSRs (12) available
CPU2: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Booting processor 3/7 eip 3000


The hangup doesn't happen all the time at the same CPU. Sometimes it 
happens at the second sometimes at the third one.
See my bugreport for a older kernel version for the full boot log file:  
http://bugme.osdl.org/show_bug.cgi?id=1659

I have add more printouts to the kernel and found out that the boot 
process gets stuck in the function  wakeup_secondary_cpu in 
arch/i386/kernel/smpboot.c  In my kernel the WAKE_SECONDARY_VIA_INIT 
version of wakeup_secondary  is used:

....
apic_write_around(APIC_ICR, APIC_INT_LEVELTRIG | APIC_INT_ASSERT  | 
APIC_DM_INIT);
Dprintk("Waiting for send to finish...\n");
timeout = 0;
       do {
               Dprintk("+");
               udelay(100);
               send_status = apic_read(APIC_ICR) & APIC_ICR_BUSY;
       } while (send_status && (timeout++ < 1000));
Dprintk("Before wait\n");
######### STUCK HERE ###############
mdelay(10);
Dprintk("Deasserting INIT.\n");

If the problem happens the last thing printed out is my debug output 
before wait. The strange thing is that the problem doesn't seam to 
happen so often since I have added the debug printouts. Could this be a 
timing problem ? Could someone give me some hints how to debug this 
further ? Any hints are welcome.

Thanks
Bernhard.
