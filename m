Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318316AbSGYDcU>; Wed, 24 Jul 2002 23:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318323AbSGYDcU>; Wed, 24 Jul 2002 23:32:20 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:45021 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318316AbSGYDcS>; Wed, 24 Jul 2002 23:32:18 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: 2.4.19-rc3-ac2 SMP
Date: Wed, 24 Jul 2002 20:34:01 -0700
User-Agent: KMail/1.4.1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207241643010.17209-100000@linux-box.realnet.co.sz>
In-Reply-To: <Pine.LNX.4.44.0207241643010.17209-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_PKCSSOHP4N2RWQVSAOML"
Message-Id: <200207242034.01605.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_PKCSSOHP4N2RWQVSAOML
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday 24 July 2002 08:26 am, Zwane Mwaikambo wrote:
[ Snip! ]
>raw_phys_apicid[]=3D       00 01 02 03 00 00 00 00 00 00 00 00 00 00 00 =
00 00
>00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> cpu_2_logical_apicid[]=3D  01 01 02 08 FF FF FF FF FF FF FF FF FF FF FF=
 FF FF
> FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
> cpu_2_physical_apicid[]=3D 02 00 01 03 FF FF FF FF FF FF FF FF FF FF FF=
 FF FF
> FF F F FF FF FF FF FF FF FF FF FF FF FF FF FF

Ah ha!  Note that while the CPU records in the {MPS,ACPI/MADT} table are =
in=20
numerical order (as preserved in raw_phys_apicid), the boot CPU is # 02. =
 The=20
flat code in smp_boot_cpus assumes that the boot CPU will be the first re=
cord=20
in the list.  Oops.

Try the attached patch and see if it helps.

[ Snip! ]

>
> Regards,
> =09Zwane

--=20
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

--------------Boundary-00=_PKCSSOHP4N2RWQVSAOML
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.4.19-rc3-ac3_flat_hack.2002-07-24"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.4.19-rc3-ac3_flat_hack.2002-07-24"

--- ac3/arch/i386/kernel/smpboot.c.df	Tue Jul 23 15:02:49 2002
+++ ac3/arch/i386/kernel/smpboot.c	Wed Jul 24 18:02:24 2002
@@ -1077,6 +1077,7 @@
 	 */
 	Dprintk("CPU present map: %lx\n", phys_cpu_present_map);
 
+	cpu = 1;
 	for (bit = 0; bit < NR_CPUS; bit++) {
 		if (!(phys_cpu_present_map & (1UL << bit)))
 			continue;
@@ -1093,7 +1094,7 @@
 		else if (clustered_apic_logical)
 			log_apicid = ((bit >> 2) << 4) | (1 << (bit & 0x3));
 		else
-			log_apicid = 1u << bit;
+			log_apicid = 1u << cpu;
 
 		do_boot_cpu(phys_apicid, log_apicid);
 
@@ -1104,6 +1105,8 @@
 				(phys_cpu_present_map & (1ul << bit)))
 			printk("CPU #%d not responding - cannot use it.\n",
 								bit);
+		else
+			++cpu;
 	}
 
 	/*

--------------Boundary-00=_PKCSSOHP4N2RWQVSAOML--

