Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVEBTVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVEBTVl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 15:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVEBTVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 15:21:41 -0400
Received: from mail.tyan.com ([66.122.195.4]:29190 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261722AbVEBTVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 15:21:10 -0400
Message-ID: <3174569B9743D511922F00A0C943142309B07C12@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: x86-64 dual core mapping
Date: Mon, 2 May 2005 12:41:31 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C54F4E.F0824600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C54F4E.F0824600
Content-Type: text/plain

I'm using LinuxBIOS and there is no acpi in that. Also I have tried Normal
BIOS, it also produce that.

Did you check my patch? It fixed that.

regards

YH 

> -----Original Message-----
> From: Andi Kleen [mailto:ak@suse.de] 
> Sent: Monday, May 02, 2005 10:02 AM
> To: YhLu
> Cc: Andi Kleen; linux-kernel@vger.kernel.org
> Subject: Re: x86-64 dual core mapping
> 
> On Thu, Apr 21, 2005 at 07:38:07PM -0700, YhLu wrote:
> > Andi,
> > 
> > I tried 2.6.12-rc3 with dual way dual cpus.
> > 
> > It seems right mapping should be
> > CPU 0(2) -> Node 0 -> Core 0
> > CPU 1(2) -> Node 0 -> Core 1
> > CPU 2(2) -> Node 1 -> Core 0
> > CPU 3(2) -> Node 1 -> Core 1
> > 
> > instead of
> > 
> > CPU 0(2) -> Node 0 -> Core 0
> > CPU 1(2) -> Node 0 -> Core 0
> > CPU 2(2) -> Node 1 -> Core 1
> > CPU 3(2) -> Node 1 -> Core 1
> 
> Hmm, yes, something seems wrong. The last time I tested it 
> worked this way, but maybe the latest merge has broken it 
> again. I will check it later.
> 
> Are you sure you dont have a broken SRAT table? The SRAT 
> table will overwrite the mappings, so if it is wrong the one 
> Linux reports will be too.
> 
> -Andi
> > 
> > YH
> > 
> > 
> > 
> > 
> > CPU 0(2) -> Node 0 -> Core 0
> > Using local APIC NMI watchdog using perfctr0 enabled ExtINT 
> on CPU#0 
> > ENABLING IO-APIC IRQs Using IO-APIC 4 ...changing IO-APIC physical 
> > APIC ID to 4 ... ok.
> > Using IO-APIC 5
> > ...changing IO-APIC physical APIC ID to 5 ... ok.
> > Using IO-APIC 6
> > ...changing IO-APIC physical APIC ID to 6 ... ok.
> > Using IO-APIC 7
> > ...changing IO-APIC physical APIC ID to 7 ... ok.
> > Synchronizing Arb IDs.
> > ..TIMER: vector=0x31 pin1=0 pin2=2
> > testing the IO APIC.......................
> > 
> > 
> > 
> > 
> > .................................... done.
> > Using local APIC timer interrupts.
> > Detected 12.564 MHz APIC timer.
> > Booting processor 1/1 rip 6000 rsp ffff81007ff99f58 
> Initializing CPU#1 
> > masked ExtINT on CPU#1
> > CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> > CPU: L2 Cache: 1024K (64 bytes/line)
> > CPU 1(2) -> Node 0 -> Core 0
> >  stepping 00
> > Synced TSC of CPU 1 difference 30064769976 Booting 
> processor 2/2 rip 
> > 6000 rsp ffff81013ffa3f58 Initializing CPU#2 masked ExtINT on CPU#2
> > CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> > CPU: L2 Cache: 1024K (64 bytes/line)
> > CPU 2(2) -> Node 1 -> Core 1
> >  stepping 00
> > Synced TSC of CPU 2 difference 30064770021 Booting 
> processor 3/3 rip 
> > 6000 rsp ffff81007ff49f58 Initializing CPU#3 masked ExtINT on CPU#3
> > CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> > CPU: L2 Cache: 1024K (64 bytes/line)
> > CPU 3(2) -> Node 1 -> Core 1
> >  stepping 00
> > Synced TSC of CPU 3 difference 30064770021 Brought up 4 CPUs
> 


------_=_NextPart_000_01C54F4E.F0824600
Content-Type: application/octet-stream;
	name="amd_dual_core_id.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="amd_dual_core_id.diff"

--- setup.o.c	2005-04-28 12:41:12.823456408 -0700=0A=
+++ setup.c	2005-04-28 13:11:04.187127736 -0700=0A=
@@ -731,19 +731,20 @@=0A=
 	int node =3D 0;=0A=
 	if (c->x86_num_cores =3D=3D 1)=0A=
 		return;=0A=
-	cpu_core_id[cpu] =3D cpu >> hweight32(c->x86_num_cores - 1);=0A=
+	cpu_core_id[cpu] =3D cpu%c->x86_num_cores;=0A=
 =0A=
 #ifdef CONFIG_NUMA=0A=
 	/* When an ACPI SRAT table is available use the mappings from SRAT=0A=
  	   instead. */=0A=
 	if (acpi_numa <=3D 0) {=0A=
-		node =3D cpu_core_id[cpu];=0A=
+		node =3D cpu >> hweight32(c->x86_num_cores - 1);=0A=
 		if (!node_online(node))=0A=
 			node =3D first_node(node_online_map);=0A=
 		cpu_to_node[cpu] =3D node;=0A=
 	} else {=0A=
 		node =3D cpu_to_node[cpu];=0A=
 	}=0A=
+	phys_proc_id[cpu] =3D node;=0A=
 #endif=0A=
 	printk(KERN_INFO "CPU %d(%d) -> Node %d -> Core %d\n",=0A=
 			cpu, c->x86_num_cores, node, cpu_core_id[cpu]);=0A=
--- smpboot.o.c	2005-04-28 13:00:03.611550488 -0700=0A=
+++ smpboot.c	2005-04-28 12:59:27.151093320 -0700=0A=
@@ -652,7 +652,7 @@=0A=
 		int i;=0A=
 		if (smp_num_siblings > 1) {=0A=
 			for_each_online_cpu (i) {=0A=
-				if (cpu_core_id[cpu] =3D=3D cpu_core_id[i]) {=0A=
+				if (cpu_to_node[cpu] =3D=3D cpu_to_node[i]) {=0A=
 					siblings++;=0A=
 					cpu_set(i, cpu_sibling_map[cpu]);=0A=
 				}=0A=

------_=_NextPart_000_01C54F4E.F0824600--
