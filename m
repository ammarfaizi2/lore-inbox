Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317444AbSGJC06>; Tue, 9 Jul 2002 22:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317470AbSGJC05>; Tue, 9 Jul 2002 22:26:57 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:29340 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317444AbSGJC0z>;
	Tue, 9 Jul 2002 22:26:55 -0400
Subject: Re: [RFC] bt_ioremap question / cyclone-timer_A1 patch
From: john stultz <johnstul@us.ibm.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200207091103.NAA05525@harpo.it.uu.se>
References: <200207091103.NAA05525@harpo.it.uu.se>
Content-Type: multipart/mixed; boundary="=-frIRiYKM2DZIIFH7DMEx"
X-Mailer: Ximian Evolution 1.0.7 
Date: 09 Jul 2002 19:18:59 -0700
Message-Id: <1026267539.32190.70.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-frIRiYKM2DZIIFH7DMEx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2002-07-09 at 04:03, Mikael Pettersson wrote:
> On 08 Jul 2002 19:36:23 -0700, john stultz wrote:
> >Mainly I'm concerned about my usage of bt_ioremap. Early in the boot
> >processes, I need to map in a couple of chipset registers and poke
> >values into them.
> 
> How early? If this is just to get gettimeofday() working, can't it
> wait until the regular initcalls are done?

I guess I might be able to pull it out and do the initialization
somewhere else, but really time_init() seems like the best spot.

> > However one of the registers needs to be kept mapped
> >for the life of the system (look for "cyclone_timer" below). I couldn't
> >find any documentation on whether memory mapped with bt_ioremap can be
> >held across mem_init(). It seems to "just work" but I wanted to find out
> >if I really should be re-mapping the register w/ ioremap once it becomes
> >available. 
> 
> If you look in include/asm-i386/fixmap.h you'll see that the BT ioremap
> pages are temporary, and they do disappear once mem_init() [or whatever]
> is done [pgtable.h sets VMALLOC_END to just below FIXADDR_START, which
> protects the permanent fixmaps but intensionally not the temporary ones].
> If it seemed to work for you then that's just luck, or perhaps it does
> work in highmem kernels?
> 
> For things that must be mapped very early and continue to be mapped as
> long as the kernel is up, you need a permanent fixmap. fixmap.h has a
> number of permanent fixmaps defined #ifdef CONFIG_* and you can easily
> add your own there, under #ifdef CONFIG_X86_IBMEXA.

Thank you for the pointer. I gave it a whirl (see attached) and it seems
to work fine! If anyone notices that I'm still just horribly lucky and
I've done everything wrong, please let me know. :)

Thanks again for the feedback and suggestions!
-john

ps: Again, if anyone feels so inclined to try this patch, do note that
it depends on my tsc-disable patch to apply cleanly. Send me a note and
I'll fwd you my latest version.

--=-frIRiYKM2DZIIFH7DMEx
Content-Disposition: attachment; filename=linux-2.4.19-rc1_cyclone-timer_A2.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=linux-2.4.19-rc1_cyclone-timer_A2.patch;
	charset=ISO-8859-1

diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Tue Jul  9 18:49:52 2002
+++ b/Documentation/Configure.help	Tue Jul  9 18:49:52 2002
@@ -257,6 +257,11 @@
   You will need a new lynxer.elf file to flash your firmware with - send
   email to Martin.Bligh@us.ibm.com
=20
+IBM Enterprise X-Architecture support
+CONFIG_X86_IBMEXA
+  This option makes use of a performance counter on the Cyclone chipset=20
+  for calculating do_gettimeofday, greatly improving its performance.=20
+
 IO-APIC support on uniprocessors
 CONFIG_X86_UP_IOAPIC
   An IO-APIC (I/O Advanced Programmable Interrupt Controller) is an
diff -Nru a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Tue Jul  9 18:49:52 2002
+++ b/arch/i386/config.in	Tue Jul  9 18:49:52 2002
@@ -201,6 +201,7 @@
 	bool 'Multi-node NUMA system support' CONFIG_X86_NUMA
 	if [ "$CONFIG_X86_NUMA" =3D "y" ]; then
 		bool 'Multiquad (IBM/Sequent) NUMAQ support' CONFIG_MULTIQUAD
+		bool 'IBM Enterprise X-Architecture support' CONFIG_X86_IBMEXA
 	fi
 fi
=20
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Tue Jul  9 18:49:52 2002
+++ b/arch/i386/kernel/time.c	Tue Jul  9 18:49:52 2002
@@ -253,6 +253,92 @@
=20
 static unsigned long (*do_gettimeoffset)(void) =3D do_slow_gettimeoffset;
=20
+
+
+#ifdef CONFIG_X86_IBMEXA
+#define CYCLONE_CBAR_ADDR 0xFEB00CD0
+#define CYCLONE_PMCC_OFFSET 0x51A0
+#define CYCLONE_MPMC_OFFSET 0x51D0
+#define CYCLONE_MPCS_OFFSET 0x51A8
+#define CYCLONE_TIMER_FREQ 100000000
+static u32* cyclone_timer;	/*Cyclone MPMC0 register*/
+static void init_cyclone_clock(void)
+{
+	u32* reg;=09
+	u32 base;	/*saved cyclone base address*/
+	u32 pageaddr; /*page that contains cyclone_timer register*/
+	u32 offset;	/*offset from pageaddr to cyclone_timer register*/
+
+	/*find base address*/
+	reg =3D bt_ioremap(CYCLONE_CBAR_ADDR, 4);
+	if(!reg) return;
+	base =3D *reg;=09
+	bt_iounmap(reg, 4);
+
+	/*setup PMCC*/
+	reg =3D bt_ioremap(base + CYCLONE_PMCC_OFFSET, 8);
+	if(!reg) return;
+	reg[0] =3D 0x00000001;
+	bt_iounmap(reg, 8);
+
+	/*setup MPCS*/
+	reg =3D bt_ioremap(base + CYCLONE_MPCS_OFFSET, 8);
+	if(!reg) return;
+	reg[0] =3D 0x00000001;
+	bt_iounmap(reg, 8);
+
+	/*map in cyclone_timer w/ set_fixmap*/
+	pageaddr =3D (base + CYCLONE_MPMC_OFFSET)&PAGE_MASK;
+	offset =3D (base + CYCLONE_MPMC_OFFSET)&(~PAGE_MASK);
+
+	set_fixmap(FIX_CYCLONE_TIMER, pageaddr);
+=09
+	cyclone_timer =3D fix_to_virt(FIX_CYCLONE_TIMER) + offset;
+}
+
+static u32 last_cyclone_timer;
+
+static inline void mark_timeoffset_cyclone(void)
+{
+	int count;
+=09
+	/*quickly read the cyclone timer*/
+	if(cyclone_timer)
+		last_cyclone_timer =3D cyclone_timer[0];
+=09
+	/*calculate delay_at_last_interrupt*/
+	spin_lock(&i8253_lock);
+	outb_p(0x00, 0x43);     /* latch the count ASAP */
+
+	count =3D inb_p(0x40);    /* read the latched count */
+	count |=3D inb(0x40) << 8;
+	spin_unlock(&i8253_lock);
+
+	count =3D ((LATCH-1) - count) * TICK_SIZE;
+	delay_at_last_interrupt =3D (count + LATCH/2) / LATCH;
+}
+
+static unsigned long do_gettimeoffset_cyclone(void)
+{
+	u32 offset;
+
+	if(!cyclone_timer)
+		return delay_at_last_interrupt;
+
+	/* Read the cyclone timer */
+	offset =3D cyclone_timer[0];
+	=09
+	/* .. relative to previous jiffy*/
+	offset =3D offset - last_cyclone_timer;
+
+	/*convert cyclone ticks to microseconds*/=09
+	offset =3D offset*(1000000/CYCLONE_TIMER_FREQ);=20
+
+	/* our adjusted time offset in microseconds */
+	return delay_at_last_interrupt + offset;
+}
+#endif /*CONFIG_X86_IBMEXA*/
+
 #else
=20
 #define do_gettimeoffset()	do_fast_gettimeoffset()
@@ -459,6 +545,7 @@
 }
=20
 static int use_tsc;
+static int use_cyclone =3D1; /*XXX should be autodetected*/
=20
 /*
  * This is the same as the above, except we _also_ save the current
@@ -506,6 +593,10 @@
 		count =3D ((LATCH-1) - count) * TICK_SIZE;
 		delay_at_last_interrupt =3D (count + LATCH/2) / LATCH;
 	}
+#ifdef CONFIG_X86_IBMEXA
+ 	if(use_cyclone)
+		mark_timeoffset_cyclone();
+#endif /*CONFIG_X86_IBMEXA*/
 =20
 	do_timer_interrupt(irq, NULL, regs);
=20
@@ -695,6 +786,14 @@
 			}
 		}
 	}
+
+#ifdef CONFIG_X86_IBMEXA
+ 	if((!use_tsc) && use_cyclone){
+		printk("IBM EXA: Starting Cyclone Clock.\n");
+		do_gettimeoffset =3D do_gettimeoffset_cyclone;
+		init_cyclone_clock();
+	}
+#endif /*CONFIG_X86_IBMEXA*/
=20
 #ifdef CONFIG_VISWS
 	printk("Starting Cobalt Timer system clock\n");
diff -Nru a/include/asm-i386/fixmap.h b/include/asm-i386/fixmap.h
--- a/include/asm-i386/fixmap.h	Tue Jul  9 18:49:52 2002
+++ b/include/asm-i386/fixmap.h	Tue Jul  9 18:49:52 2002
@@ -61,6 +61,9 @@
 	FIX_LI_PCIA,	/* Lithium PCI Bridge A */
 	FIX_LI_PCIB,	/* Lithium PCI Bridge B */
 #endif
+#ifdef CONFIG_X86_IBMEXA
+	FIX_CYCLONE_TIMER, /*cyclone timer register*/
+#endif=20
 #ifdef CONFIG_HIGHMEM
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_END =3D FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,

--=-frIRiYKM2DZIIFH7DMEx--

