Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318171AbSGWSt6>; Tue, 23 Jul 2002 14:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318172AbSGWSt6>; Tue, 23 Jul 2002 14:49:58 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:43713 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318171AbSGWSt4>;
	Tue, 23 Jul 2002 14:49:56 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: Zwane Mwaikambo <zwane@linuxpower.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.19-rc3-ac2 SMP
Date: Tue, 23 Jul 2002 11:50:14 -0700
User-Agent: KMail/1.4.1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207231409000.32636-100000@linux-box.realnet.co.sz>
In-Reply-To: <Pine.LNX.4.44.0207231409000.32636-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_QNTPC3KIR8DFNBBQI2DN"
Message-Id: <200207231150.14141.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_QNTPC3KIR8DFNBBQI2DN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 23 July 2002 05:11 am, Zwane Mwaikambo wrote:
> On Tue, 23 Jul 2002, Zwane Mwaikambo wrote:
> > Around here the machine gets a vector 0x31 (timer) interrupt on CPU0 =
then
> > locks up since the destination cpu bitmask is 0, It also seems that t=
he
> > code is trying to use logical apic id in places instead of the physic=
al
> > apic id, i saw attempted deliveries to physical apic id 4 and 8, this=
 can
> > possibly explain the APIC receive errors people were reporting?
>
> Correction, the logical/physical apic id problem doesn't appear to be
> there with the summit patch. What i'm currently seeing is a destination=
 of
> 0 with a non flat/physical destination format.

Drat!  I thought I had all the logical vs. physical stuff straightened ou=
t.

Could you give this patch a try?  It dumps all kinds of APIC state info. =
=20
You'll need to put a call to apic_state_dump() into check_timer() just af=
ter=20
the TIMER: printk.

(Hmmm....  Must clean up this patch and submit it to kdb as two new comma=
nds,=20
one for I/O APICs and one for local APICs....)

--=20
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

--------------Boundary-00=_QNTPC3KIR8DFNBBQI2DN
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="apic_error.2.4.19-rc1-ac7"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="apic_error.2.4.19-rc1-ac7"

--- 2.4.19-rc1-ac7/arch/i386/kernel/apic.c	Wed Jul 17 12:02:50 2002
+++ ac7/arch/i386/kernel/apic.c	Thu Jul 18 19:41:57 2002
@@ -1131,13 +1131,100 @@
 			smp_processor_id());
 }
 
+static spinlock_t apic_dump_lock = SPIN_LOCK_UNLOCKED;
+
+static void
+apic_bit_vector_dump(unsigned long addr, char *name)
+{
+	int	n;
+
+	printk("%s:", name);
+	for (n = 256 / 32; --n >= 0; addr += 0x10) {
+		printk(" %08lX", apic_read(addr));
+	}
+	printk("\n");
+}
+
+void
+print_ioapic_rtes(void)
+{
+	register int	apic, rte, rte_max;
+
+	for (apic = 0; apic < nr_ioapics; apic++) {
+		printk("I/O APIC # %d:", apic);
+		rte_max = nr_ioapic_registers[apic]; 
+		for (rte = 0; rte < rte_max; rte++) {
+			if ((rte & 0x3) == 0)
+				printk("\n%02X:", rte);
+			printk(" %08X:%08X",
+				io_apic_read(apic, 0x10 + rte*2),
+				io_apic_read(apic, 0x10 + 1 + rte*2));
+		}
+		printk("\n");
+	}
+}
+
+/* Set breakpoint here.  */
+void
+apic_state_dump_bp(void)
+{
+	cpu_relax();
+}
+
+/*
+ * apic_state_dump -- Print large amounts of APIC and related info.
+ */
+
+void
+apic_state_dump(void)
+{
+	register int	v;
+	unsigned long	flags;
+
+	spin_lock_irqsave(&apic_dump_lock, flags);
+
+	printk("ID=0x%08lX, LVR=0x%08lX, TPR=0x%08lX, ARB=0x%08lX, PROCPRI=0x%08lX\n", apic_read(APIC_ID), apic_read(APIC_LVR), apic_read(APIC_TASKPRI), apic_read(APIC_ARBPRI), apic_read(APIC_PROCPRI));
+	printk("DFR=0x%08lX, LDR=0x%08lX, ICR=0x%08lX\n", apic_read(APIC_DFR), apic_read(APIC_LDR), apic_read(APIC_ICR));
+	printk("SPIV=0x%08lX, ICR=0x%08lX, ICR2=0x%08lX, LVTT=0x%08lX, LVTPC=0x%08lX\n", apic_read(APIC_SPIV), apic_read(APIC_ICR), apic_read(APIC_ICR2), apic_read(APIC_LVTT), apic_read(APIC_LVTPC));
+	printk("LVT0=0x%08lX, LVT1=0x%08lX, LVTERR=0x%08lX\n", apic_read(APIC_LVT0), apic_read(APIC_LVT1), apic_read(APIC_LVTERR));
+	apic_bit_vector_dump(APIC_ISR, "ISR");
+	apic_bit_vector_dump(APIC_TMR, "TMR");
+	apic_bit_vector_dump(APIC_IRR, "IRR");
+	printk("clustered_apic_mode=%d, esr_disable=%d, target_cpus=0x%02X\n", clustered_apic_mode, esr_disable, (u32)target_cpus);
+	printk("apic_broadcast_id=0x%02X\n", (u32)apic_broadcast_id);
+	printk("raw_phys_apicid[]=      ");
+	for (v = 0; v < NR_CPUS; v++) {
+		printk(" %02X", raw_phys_apicid[v]);
+	}
+	printk("\n");
+	printk("cpu_2_logical_apicid[]= ");
+	for (v = 0; v < NR_CPUS; v++) {
+		printk(" %02X", cpu_2_logical_apicid[v]);
+	}
+	printk("\n");
+	printk("cpu_2_physical_apicid[]=");
+	for (v = 0; v < NR_CPUS; v++) {
+		printk(" %02X", cpu_2_physical_apicid[v]);
+	}
+	printk("\n");
+	print_ioapic_rtes();
+
+	spin_unlock_irqrestore(&apic_dump_lock, flags);
+	apic_state_dump_bp();
+}
+
 /*
  * This interrupt should never happen with our APIC/SMP architecture
  */
 
+static spinlock_t smp_error_intr_lock = SPIN_LOCK_UNLOCKED;
+
 asmlinkage void smp_error_interrupt(void)
 {
 	unsigned long v, v1;
+	unsigned long	flags;
+
+	spin_lock_irqsave(&smp_error_intr_lock, flags);
 
 	/* First tickle the hardware, only then report what went on. -- REW */
 	v = apic_read(APIC_ESR);
@@ -1158,6 +1245,11 @@
 	*/
 	printk (KERN_ERR "APIC error on CPU%d: %02lx(%02lx)\n",
 	        smp_processor_id(), v , v1);
+	apic_state_dump();
+	/* APICs tend to spasm when they get errors.  Disable the error intr. */
+	apic_write_around(APIC_LVTERR, ERROR_APIC_VECTOR | APIC_LVT_MASKED);
+
+	spin_unlock_irqrestore(&smp_error_intr_lock, flags);
 }
 
 /*

--------------Boundary-00=_QNTPC3KIR8DFNBBQI2DN--

