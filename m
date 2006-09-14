Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWINRLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWINRLx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 13:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWINRLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 13:11:53 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:45941 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750771AbWINRLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 13:11:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dZPoSAFUh+DK6dosqNWIOR00lyoXhSNlqxW2HSMeiT0Pc5tZSIKlQjIiJDYJ101WPwpFG4lcJy3Qnket7rRHqYMqcmshSvEGP83h6rQ7ud6G4BsezFcxQRlnD1e7zZn5efcz+XiSVxrwNiE/RKmxEzwtBfyuIoT3Rt4Tn+8tEl4=
Message-ID: <b324b5ad0609141011h9eae8d7re0da11fffa7ab859@mail.gmail.com>
Date: Thu, 14 Sep 2006 10:11:49 -0700
From: "David Singleton" <daviado@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: OpPoint summary
Cc: linux-pm@lists.osdl.org, "kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060914055529.GA18031@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060911082025.GD1898@elf.ucw.cz>
	 <20060911195546.GB11901@elf.ucw.cz> <4505CCDA.8020501@gmail.com>
	 <20060911210026.GG11901@elf.ucw.cz> <4505DDA6.8080603@gmail.com>
	 <20060911225617.GB13474@elf.ucw.cz>
	 <20060912001701.GC14234@linux.intel.com>
	 <20060912033700.GD27397@kroah.com>
	 <b324b5ad0609131650q1b7a78cfsa90e3fbe8d7b4093@mail.gmail.com>
	 <20060914055529.GA18031@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Care to resend your patches in the proper format, through email so that
> we can see them, and possibly get some testing in -mm if they look sane?
>
> thanks,
>
> greg k-h
>

Greg,
   here's the arm-pxa7x patch which creates operating points for the much more
complex ARM platform.  It illustrates the straight forward nature of creating
operating points, both frequency and sleep states, for different and more
complex architectures, and eliminates the need to have users pass in all
the parameters needed to create an operating point.


Signed-Off-by: David Singleton <dsingleton@mvista.com>

 arch/arm/Kconfig                      |    2
 arch/arm/mach-pxa/Makefile            |    3
 arch/arm/mach-pxa/mainstone_freq.c    |  211 +++
 arch/arm/mach-pxa/mainstone_oppoint.c | 1910 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-pxa/mainstone_volt.c    |  363 ++++++
 include/asm-arm/arch-pxa/oppoint.h    |  119 ++
 include/asm-arm/arch-pxa/pxa-regs.h   |    8
 7 files changed, 2614 insertions(+), 2 deletions(-)

Index: linux-2.6.17/arch/arm/mach-pxa/Makefile
===================================================================
--- linux-2.6.17.orig/arch/arm/mach-pxa/Makefile
+++ linux-2.6.17/arch/arm/mach-pxa/Makefile
@@ -10,7 +10,8 @@ obj-$(CONFIG_PXA27x) += pxa27x.o
 # Specific board support
 obj-$(CONFIG_ARCH_LUBBOCK) += lubbock.o
 obj-$(CONFIG_MACH_LOGICPD_PXA270) += lpd270.o
-obj-$(CONFIG_MACH_MAINSTONE) += mainstone.o
+obj-$(CONFIG_MACH_MAINSTONE) += mainstone.o mainstone_oppoint.o \
+mainstone_freq.o  mainstone_volt.o
 obj-$(CONFIG_ARCH_PXA_IDP) += idp.o
 obj-$(CONFIG_MACH_TRIZEPS4)    += trizeps4.o
 obj-$(CONFIG_PXA_SHARP_C7xx)   += corgi.o corgi_ssp.o corgi_lcd.o
sharpsl_pm.o corgi_pm.o
Index: linux-2.6.17/arch/arm/mach-pxa/mainstone_freq.c
===================================================================
--- /dev/null
+++ linux-2.6.17/arch/arm/mach-pxa/mainstone_freq.c
@@ -0,0 +1,211 @@
+/*
+ * linux/arch/arm/mach-pxa/mainstone_freq.c
+ *
+ * Functions to change CPU frequencies on the Bulverde processor
+ * adopted from Intel code for MontaVista Linux.
+ *
+ * Author: David Singleton <dsingleton@mvista.com>
+ *
+ * 2006 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/hardirq.h>
+#include <asm/io.h>
+
+#include <asm/hardware.h>
+#include <asm/arch/oppoint.h>
+#include <asm/arch/pxa-regs.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+
+#include <asm/arch/mainstone.h>
+
+/*
+ * Since CPDIS and PPDIS is always the same, we use only one definition here.
+ */
+#define        PDIS    0       /* Core PLL and Peripheral PLL is
enabled after FCS. */
+
+/*
+ *     Available CPU frequency list for Bulverde.
+ */
+static unsigned int cpufreq_matrix[N_NUM][L_NUM + 1];
+static void mainstone_freq_debug_info(void);
+static volatile int *ramstart;
+
+/*
+ *  Init according to mainstone manual.
+ */
+static void mainstone_initialize_freq_matrix(void)
+{
+       int n, l;
+
+       memset(&cpufreq_matrix, 0, sizeof(cpufreq_matrix));
+
+       for (n = 2; n < N_NUM + 2; n++) {
+               for (l = 2; l <= L_NUM; l++) {
+                       cpufreq_matrix[n - 2][l - 2] = (13 * n * l / 2) * 1000;
+                       if (cpufreq_matrix[n - 2][l - 2] > BLVD_MAX_FREQ)
+                               cpufreq_matrix[n - 2][l - 2] = 0;
+               }
+       }
+}
+
+/*
+ * This should be called with a valid freq point that was
+ * obtained via mainstone_validate_speed
+ */
+void mainstone_set_freq(unsigned int CLKCFGValue)
+{
+       unsigned long flags;
+       unsigned int unused;
+       volatile int v;
+
+       local_irq_save(flags);
+
+       /*
+        * force a tlb fault to get the mapping into the tlb
+        * (otherwise this will occur below when the sdram is turned off and
+        * something-bad(tm) will happen)
+        */
+       v = *(volatile unsigned long *)ramstart;
+       *(volatile unsigned long *)ramstart = v;
+
+       MST_LEDDAT1 = CLKCFGValue;
+
+       __asm__ __volatile__(" \n\
+               ldr     r4, [%1]                        @load MDREFR \n\
+               mcr     p14, 0, %2, c6, c0, 0           @ set CCLKCFG[FCS] \n\
+               ldr     r5, =0xe3dfefff \n\
+               and     r4, r4, r5      \n\
+               str     r4,  [%1]                       @restore \n\
+               ":"=&r"(unused)
+                            :"r"(&MDREFR), "r"(CLKCFGValue), "r"(ramstart)
+                            :"r4", "r5");
+
+       MST_LEDDAT1 = 0x0002;
+       /*
+          NOTE: if we don't turn off IRQs up top, there is no point
+          to restoring them here.
+        */
+       local_irq_restore(flags);
+
+       /* spit out some info about what happened */
+       mainstone_freq_debug_info();
+
+}
+
+extern void mainstone_get_current_info(struct md_opt *);
+
+static void mainstone_freq_debug_info(void)
+{
+       unsigned int sysbus, run, t, turbo, mem, m = 1;
+       struct md_opt opt;
+
+       mainstone_get_current_info(&opt);
+
+       run = 13000 * opt.l;
+       turbo = (13000 * opt.l * opt.n) >> 1;
+       sysbus = (opt.b) ? run : (run / 2);
+       t = opt.regs.clkcfg & 0x1;
+
+       /* If CCCR[A] is on */
+       if (opt.cccra) {
+               mem = sysbus;
+       } else {
+               /* If A=0
+                  m initialized to 1 (for l=2-10)
+                */
+               if (opt.l > 10)
+                       m = 2;  /* for l=11-20 */
+               if (opt.l > 20)
+                       m = 4;  /* for l=21-31 */
+               mem = run / m;
+       }
+}
+
+int mainstone_get_freq(void)
+{
+       unsigned int freq, n, l, ccsr;
+
+       ccsr = CCSR;
+
+       l = ccsr & CCCR_L_MASK; /* Get L */
+       n = (ccsr & CCCR_N_MASK) >> 7;  /* Get 2N */
+
+       if (n < 2)
+               n = 2;
+
+       /* Shift to divide by 2 because N is really 2N */
+       freq = (13000 * l * n) >> 1;    /*      in kHz */
+
+       return freq;
+}
+
+unsigned int mainstone_read_clkcfg(void)
+{
+       unsigned int value = 0;
+       unsigned int un_used;
+
+        __asm__ __volatile__("mrc      p14, 0, %0, c6, c0, 0":
"=r"(value) : "r"(un_used) );
+
+       return value;
+}
+
+static int mainstone_init_freqs(void)
+{
+       int cpu_ver;
+
+       asm volatile ("mrc%? p15, 0, %0, c0, c0":"=r" (cpu_ver));
+
+       /*
+          Bulverde     A0:     0x69054110,
+          A1 :         0x69054111
+        */
+       if ((cpu_ver & 0x0000f000) >> 12 == 4 &&
+           (cpu_ver & 0xffff0000) >> 16 == 0x6905) {
+               /*    It is an xscale core bulverde chip. */
+               return 1;
+       }
+
+       return 0;
+}
+
+int mainstone_clk_init(void)
+{
+       unsigned int freq;
+
+       /*
+        * In order to turn the sdram back on (see below) we need to
+        * r/w the sdram.  We need to do this without the cache and
+        * write buffer in the way.  So, we temporarily ioremap the
+        * first page of sdram as uncached i/o memory and use the
+        * aliased address
+        */
+
+       /* map the first page of sdram to an uncached virtual page */
+       ramstart = (int *)ioremap(PHYS_OFFSET, 4096);
+
+       freq = mainstone_get_freq();    /*      in kHz */
+       printk(KERN_INFO "Init freq: %dkHz.\n", freq);
+
+       mainstone_initialize_freq_matrix();
+
+       if (mainstone_init_freqs()) {
+               printk(KERN_INFO "CPU frequency change initialized.\n");
+       }
+       return 0;
+}
+
+void mainstone_freq_cleanup(void)
+{
+       /* unmap the page we used*/
+       iounmap((void *)ramstart);
+}
Index: linux-2.6.17/arch/arm/mach-pxa/mainstone_volt.c
===================================================================
--- /dev/null
+++ linux-2.6.17/arch/arm/mach-pxa/mainstone_volt.c
@@ -0,0 +1,363 @@
+/*
+ * linux/arch/arm/mach-pxa/mainstone_volt.c
+ *
+ * Bulverde voltage change driver.
+ *
+ * Author: David Singleton dsingleton@mvista.com MontaVista Software, Inc.
+ *
+ * 2006 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <asm/hardware.h>
+#include <asm/arch/oppoint.h>
+#include <asm/arch/pxa-regs.h>
+
+/* For ioremap */
+#include <asm/io.h>
+
+#define CP15R0_REV_MASK                0x0000000f
+#define PXA270_C5              0x7
+
+static u32 chiprev;
+static unsigned int blvd_min_vol, blvd_max_vol;
+static int mvdt_size;
+
+static volatile int *ramstart;
+
+struct MvDAC {
+       unsigned int mv;
+       unsigned int DACIn;
+} *mvDACtable;
+
+/*
+ *  Transfer desired mv to required DAC value.
+ *  Vcore = 1.3v - ( 712uv * DACIn )
+ */
+static struct MvDAC table_c0[] = {
+       {1425, 0},
+       {1400, 69},
+       {1300, 248},
+       {1200, 428},
+       {1100, 601},
+       {1000, 777},
+       {950, 872},
+       {868, 1010},
+       {861, 0xFFFFFFFF},
+};
+
+/*
+ *  Transfer desired mv to required DAC value, update for new boards,
+ *  according to "Intel PXA27x Processor Developer's Kit User's Guide,
+ *  April 2004, Revision 4.001"
+ *  Vcore = 1.5V - (587uV * DAC(input)).
+ */
+static struct MvDAC table_c5[] = {
+       {1500, 0},
+       {1484,25},
+       {1471,50},
+       {1456,75},
+       {1441,100},
+       {1427,125},
+       {1412,150},
+       {1397,175},
+       {1383,200},
+       {1368,225},
+       {1353,250},
+       {1339,275},
+       {1323,300},
+       {1309,325},
+       {1294,350},
+       {1280,375},
+       {1265,400},
+       {1251,425},
+       {1236,450},
+       {1221,475},
+       {1207,500},
+       {1192,525},
+       {1177,550},
+       {1162,575},
+       {1148,600},
+       {1133,625},
+       {1118,650},
+       {1104,675},
+       {1089,700},
+       {1074,725},
+       {1060,750},
+       {1045,775},
+       {1030,800},
+       {1016,825},
+       {1001,850},
+       {986,875},
+       {972,900},
+       {957,925},
+       {942,950},
+       {928,975},
+       {913,1000},
+       {899, 1023},
+};
+
+unsigned int mainstone_validate_voltage(unsigned int mv)
+{
+       /*
+        *      Just to check whether user specified mv
+        *      can be set to the CPU.
+        */
+       if ((mv >= blvd_min_vol) && (mv <= blvd_max_vol)) {
+               return mv;
+       } else {
+               return 0;
+       }
+}
+
+/*
+ * Prepare for a voltage change, possibly coupled with a frequency
+ * change
+ */
+static void power_change_cmd(unsigned int DACValue, int coupled);
+void mainstone_prep_set_voltage(unsigned int mv)
+{
+        power_change_cmd(mv2DAC(mv), 1 /* coupled */ );
+}
+
+
+unsigned int mv2DAC(unsigned int mv)
+{
+       int i, num = mvdt_size;
+
+       if (mvDACtable[0].mv <= mv) {   /* Max or bigger */
+               /* Return the first one */
+               return mvDACtable[0].DACIn;
+       }
+
+       if (mvDACtable[num - 1].mv >= mv) {     /* Min or smaller */
+               /* Return the last one */
+               return mvDACtable[num - 1].DACIn;
+       }
+
+       /*
+        * The biggest and smallest value cases are covered, now the
+        *  loop may skip those
+        */
+       for (i = 1; i <= (num - 1); i++) {
+               if ((mvDACtable[i].mv >= mv) && (mvDACtable[i + 1].mv < mv)) {
+                       return mvDACtable[i].DACIn;
+               }
+       }
+
+       /* Should never get here */
+       return 0;
+}
+extern void mainstone_change_voltage(void);
+void vm_setvoltage(unsigned int DACValue)
+{
+       power_change_cmd(DACValue, 0 /* not-coupled */ );
+       /* Execute voltage change sequence      */
+       mainstone_change_voltage();     /* set VC on the PWRMODE on CP14 */
+}
+/*
+ *     According to bulverde's manual, set the core's voltage.
+ */
+void mainstone_set_voltage(unsigned int mv)
+{
+       vm_setvoltage(mv2DAC(mv));
+}
+
+/*
+ *     Functionality: Initialize PWR I2C.
+ *     Argument:      None
+ *     Return:        void
+*/
+int mainstone_vcs_init(void)
+{
+       /*
+        * we distinguish new and old boards by proc chip
+        * revision, we assume new boards have C5 proc
+        * revision and we use the new table (table_c5) for them,
+        * for all other boards we use the old table (table_c0).
+        * Note, the logics won't work and inaccurate voltage
+        * will be set if C5 proc installed to old board
+        * and vice versa.
+        */
+
+       asm("mrc%? p15, 0, %0, c0, c0" : "=r" (chiprev));
+
+       chiprev &= CP15R0_REV_MASK;
+
+       if ( chiprev == PXA270_C5 ) {
+               mvDACtable = table_c5;
+               mvdt_size = sizeof(table_c5) / sizeof(struct MvDAC);
+               blvd_min_vol = BLVD_MIN_VOL_C5;
+               blvd_max_vol = BLVD_MAX_VOL_C5;
+       } else {
+               mvDACtable = table_c0;
+               mvdt_size = sizeof(table_c0) / sizeof(struct MvDAC);
+               blvd_min_vol = BLVD_MIN_VOL_C0;
+               blvd_max_vol = BLVD_MAX_VOL_C0;
+       }
+
+       CKEN |= 0x1 << 15;
+       CKEN |= 0x1 << 14;
+       PCFR |= 0x60;
+
+       /* map the first page of sdram to an uncached virtual page */
+       ramstart = (int *)ioremap(PHYS_OFFSET, 4096);
+
+       printk(KERN_INFO "CPU voltage change initialized.\n");
+
+       return 0;
+}
+
+void mainstone_voltage_cleanup(void)
+{
+       /* unmap the page we used*/
+       iounmap((void *)ramstart);
+}
+
+
+void mainstone_change_voltage(void)
+{
+       unsigned long flags;
+       unsigned int unused;
+
+
+       local_irq_save(flags);
+
+       __asm__ __volatile__("\n\
+    @ BV B0 WORKAROUND - Core hangs on voltage change at different\n\
+    @ alignments and at different core clock frequencies\n\
+    @ To ensure that no external fetches occur, we want to store the next\n\
+    @ several instructions that occur after the voltage change inside\n\
+    @ the cache. The load dependency stall near the retry label ensures \n\
+    @ that any outstanding instruction cacheline loads are complete before \n\
+    @ the mcr instruction is executed on the 2nd pass. This procedure \n\
+    @ ensures us that the internal bus will not be busy. \n\
+                                       \n\
+    b      2f                          \n\
+    nop                                        \n\
+    .align  5                          \n\
+2:                                     \n\
+    ldr     r0, [%1]                   @ APB register read and compare \n\
+    cmp     r0, #0                     @ fence for pending slow apb reads \n\
+                                       \n\
+    mov     r0, #8                     @ VC bit for PWRMODE \n\
+    movs    r1, #1                     @ don't execute mcr on 1st pass \n\
+                                       \n\
+    @ %1 points to uncacheable memory to force memory read \n\
+                                       \n\
+retry:                                 \n\
+    ldreq   r3, [%2]                   @ only stall on the 2nd pass\n\
+    cmpeq   r3, #0                     @ cmp causes fence on mem transfers\n\
+    cmp     r1, #0                     @ is this the 2nd pass? \n\
+    mcreq   p14, 0, r0, c7, c0, 0      @ write to PWRMODE on 2nd pass only \n\
+                                       \n\
+    @ Read VC bit until it is 0, indicates that the VoltageChange is done.\n\
+    @ On first pass, we never set the VC bit, so it will be clear already.\n\
+                                       \n\
+VoltageChange_loop:                    \n\
+    mrc     p14, 0, r3, c7, c0, 0      \n\
+    tst     r3, #0x8                   \n\
+    bne     VoltageChange_loop         \n\
+                                       \n\
+    subs    r1, r1, #1         @ update conditional execution counter\n\
+    beq     retry":"=&r"(unused)
+                            :"r"(&CCCR), "r"(ramstart)
+                            :"r0", "r1", "r3");
+
+       local_irq_restore(flags);
+
+}
+
+static void clr_all_sqc(void)
+{
+       int i = 0;
+       for (i = 0; i < 32; i++)
+               PCMD(i) &= ~PCMD_SQC;
+}
+
+static void clr_all_mbc(void)
+{
+       int i = 0;
+       for (i = 0; i < 32; i++)
+               PCMD(i) &= ~PCMD_MBC;
+}
+
+static void clr_all_dce(void)
+{
+       int i = 0;
+       for (i = 0; i < 32; i++)
+               PCMD(i) &= ~PCMD_DCE;
+}
+
+static void set_mbc_bit(int ReadPointer, int NumOfBytes)
+{
+       PCMD0 |= PCMD_MBC;
+       PCMD1 |= PCMD_MBC;
+}
+
+static void set_lc_bit(int ReadPointer, int NumOfBytes)
+{
+       PCMD0 |= PCMD_LC;
+       PCMD1 |= PCMD_LC;
+       PCMD2 |= PCMD_LC;
+}
+
+static void set_cmd_data(unsigned char *DataArray, int StartPoint, int size)
+{
+       PCMD0 &= 0xFFFFFF00;
+       PCMD0 |= DataArray[0];
+       PCMD1 &= 0xFFFFFF00;
+       PCMD1 |= DataArray[1];
+       PCMD2 &= 0xFFFFFF00;
+       PCMD2 |= DataArray[2];
+}
+
+/* coupled indicates that this VCS is to be coupled with a FCS */
+static void power_change_cmd(unsigned int DACValue, int coupled)
+{
+       unsigned char dataArray[3];
+
+       dataArray[0] = 0;                               /* Command 0 */
+       dataArray[1] = (DACValue & 0x000000FF);         /* data LSB */
+       dataArray[2] = (DACValue & 0x0000FF00) >> 8;    /* data MSB */
+
+       PVCR = 0;
+
+       PCFR &= ~PCFR_FVC;
+       PVCR &= 0xFFFFF07F;     /*      no delay is necessary   */
+       PVCR &= 0xFFFFFF80;     /*  clear slave address         */
+       PVCR |= 0x20;           /*      set slave address       */
+
+       PVCR &= 0xFE0FFFFF;     /*      clear read pointer 0    */
+       PVCR |= 0;
+
+       /*  DCE and SQC are not necessary for single command */
+       clr_all_sqc();
+       clr_all_dce();
+
+       clr_all_mbc();
+       set_mbc_bit(0, 2);
+
+       /*  indicate the last byte of this command is holded in this register */
+       PCMD2 &= ~PCMD_MBC;
+
+       /*  indicate this is the first command and last command also        */
+       set_lc_bit(0, 3);
+
+       /*  programming the command data bit        */
+       set_cmd_data(dataArray, 0, 2);
+
+       /* Enable Power I2C */
+       PCFR |= PCFR_PI2CEN;
+
+       if (coupled) {
+               /* Enable Power I2C and FVC */
+               PCFR |= PCFR_FVC;
+       }
+}
Index: linux-2.6.17/include/asm-arm/arch-pxa/pxa-regs.h
===================================================================
--- linux-2.6.17.orig/include/asm-arm/arch-pxa/pxa-regs.h
+++ linux-2.6.17/include/asm-arm/arch-pxa/pxa-regs.h
@@ -2042,6 +2042,14 @@
 #define MDMRS          __REG(0x48000040)  /* MRS value to be written
to SDRAM */
 #define BOOT_DEF       __REG(0x48000044)  /* Read-Only Boot-Time
Register. Contains BOOT_SEL and PKG_SEL */

+#define MDREFR_DRI 0xFFF
+#define MSC0_RDF (0xF << 20)
+#define MSC0_RDN (0xF << 24)
+#define MSC0_RRR (0x7 << 12)
+#define MDREFR_RFU 0xC0200000
+#define MDCNFG_DTC0 (0x3 << 8)
+#define MDCNFG_DTC2 (0x3 << 24)
+
 /*
  * More handy macros for PCMCIA
  *
Index: linux-2.6.17/include/asm-arm/arch-pxa/oppoint.h
===================================================================
--- /dev/null
+++ linux-2.6.17/include/asm-arm/arch-pxa/oppoint.h
@@ -0,0 +1,119 @@
+/*
+ * include/asm-arm/arch-pxa/oppoint.h
+ *
+ * Bulverde-specific definitions for OpPoint.  If further PXA boards are
+ * supported in the future, will split into board-specific files.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ * Copyright (C) 2002, 2006 MontaVista Software <source@mvista.com>
+ *
+ * Based on arch/ppc/platforms/ibm405lp_dpm.h by Bishop Brock.
+ */
+
+#ifndef __ASM_ARM_PXA_POWEROP_H__
+#define __ASM_ARM_PXA_POWEROP_H__
+
+#ifdef __KERNEL__
+#ifndef __ASSEMBLER__
+#include <linux/config.h>
+#include <linux/notifier.h>
+#include <linux/ioctl.h>
+#include <linux/miscdevice.h>
+
+#define CCLKCFG_TURBO   0x1
+#define CCLKCFG_FCS     0x2
+
+#define L_NUM   31              /*  30 different L numbers. */
+#define N_NUM   7               /*  7 N numbers. */
+
+#define BLVD_MIN_FREQ       13000
+/* latest PowerPoint documentation indicates 624000, not 540000*/
+#define BLVD_MAX_FREQ       624000
+
+void mainstone_set_freq(unsigned int);
+
+int mainstone_clk_init(void);
+unsigned int mainstone_read_clkcfg(void);
+void mainstone_freq_cleanup(void);
+
+#define BLVD_MAX_VOL_C5        1500    /*  in mV.  */
+#define BLVD_MIN_VOL_C5        899     /*  in Mv.  */
+#define BLVD_MAX_VOL_C0        1400    /*  in mV.  */
+#define BLVD_MIN_VOL_C0        850     /*  in Mv.  */
+
+unsigned int mv2DAC(unsigned int mv);
+void vm_setvoltage(unsigned int);
+unsigned int mainstone_validate_voltage(unsigned int mv);
+
+void mainstone_set_voltage(unsigned int mv);
+void mainstone_prep_set_voltage(unsigned int mv);
+int mainstone_vcs_init(void);
+
+void mainstone_set_freq(unsigned int);
+
+int mainstone_clk_init(void);
+unsigned int mainstone_read_clkcfg(void);
+void mainstone_freq_cleanup(void);
+
+enum {
+       CPUMODE_RUN,
+       CPUMODE_IDLE,
+       CPUMODE_STANDBY,
+       CPUMODE_SLEEP,
+       CPUMODE_RESERVED,
+       CPUMODE_SENSE,
+       CPUMODE_RESERVED2,
+       CPUMODE_DEEPSLEEP,
+};
+
+#define PM_SUSPEND_DEEP        ((__force suspend_state_t) 2)
+
+struct oppoint_regs {
+       unsigned int    cccr;
+       unsigned int    clkcfg;
+       unsigned int    voltage;        /*This is not a register.*/
+};
+
+/*
+ * Instances of this structure define valid Bulverde operating points for DPM.
+ * Voltages are represented in mV, and frequencies are represented in KHz.
+ */
+
+struct md_opt {
+       /* Specified values */
+        int v;         /* Target voltage in mV*/
+        int l;         /* Run Mode to Oscillator ratio */
+        int n;         /* Turbo-Mode to Run-Mode ratio */
+        int b;         /* Fast Bus Mode */
+        int half_turbo;/* Half Turbo bit */
+        int cccra;     /* the 'A' bit of the CCCR register,
+                         alternate MEMC clock */
+       int cpll_enabled; /* core PLL is ON?  (Bulverde >="C0" feature)*/
+       int ppll_enabled; /* peripherial PLL is ON? (Bulverde >="C0" feature)*/
+
+       int sleep_mode;
+        /*Calculated values*/
+       unsigned int lcd;       /*in KHz  */
+       unsigned int lpj;       /*New value for loops_per_jiffy */
+       unsigned int cpu;       /*CPU frequency in KHz */
+       unsigned int turbo;     /* Turbo bit in clkcfg */
+
+       struct oppoint_regs regs;   /* Register values */
+};
+
+#endif /* __ASSEMBLER__ */
+#endif /* __KERNEL__ */
+#endif
Index: linux-2.6.17/arch/arm/mach-pxa/mainstone_oppoint.c
===================================================================
--- /dev/null
+++ linux-2.6.17/arch/arm/mach-pxa/mainstone_oppoint.c
@@ -0,0 +1,1910 @@
+/*
+ * arch/arm/mach-pxa/mainstone_oppoint.c  PM support for Intel PXA27x
+ *
+ * Author: <source@mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ * Copyright (C) 2002, 2005, 2006 MontaVista Software <source@mvista.com>.
+ *
+ * Based on code by Matthew Locke, Dmitry Chigirev, and Bishop Brock.
+ */
+#define DEBUG
+#include <linux/config.h>
+
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/pm.h>
+
+#include <linux/proc_fs.h>
+#include <linux/delay.h>
+#include <linux/cpufreq.h>
+
+#include <asm/uaccess.h>
+
+#include <asm/hardware.h>
+#include <asm/arch/oppoint.h>
+#include <asm/arch/pxa-regs.h>
+
+static int saved_loops_per_jiffy = 0;
+static int saved_cpu_freq = 0;
+
+#define BULVERDE_DEFAULT_VOLTAGE 1400
+
+#define FSCALER_NOP         0
+#define FSCALER_CPUFREQ        (1 << 0)
+#define FSCALER_SLEEP    (1 << 1)
+#define FSCALER_STANDBY        (1 << 2)
+#define FSCALER_DEEPSLEEP      (1 << 3)
+#define FSCALER_WAKEUP  (1 << 4)
+#define FSCALER_VOLTAGE        (1 << 5)
+#define FSCALER_XPLLON   (1 << 6)
+#define FSCALER_HALFTURBO_ON   (1 << 7)
+#define FSCALER_HALFTURBO_OFF  (1 << 8)
+#define FSCALER_TURBO_ON       (1 << 9)
+#define FSCALER_TURBO_OFF      (1 << 10)
+
+#define FSCALER_TURBO (FSCALER_TURBO_ON | FSCALER_TURBO_OFF)
+
+#define FSCALER_ANY_SLEEPMODE     (FSCALER_SLEEP | \
+                                  FSCALER_STANDBY | \
+                                  FSCALER_DEEPSLEEP)
+
+#define CCCR_CPDIS_BIT_ON        (1 << 31)
+#define CCCR_PPDIS_BIT_ON        (1 << 30)
+#define CCCR_CPDIS_BIT_OFF      (0 << 31)
+#define CCCR_PPDIS_BIT_OFF      (0 << 30)
+#define CCCR_PLL_EARLY_EN_BIT_ON   (1 << 26)
+#define CCSR_CPLL_LOCKED          (1 << 29)
+#define CCSR_PPLL_LOCKED          (1 << 28)
+
+/* CLKCFG
+   | 31------------------------------------------- | 3 | 2  | 1 | 0 |
+   | --------------------------------------------- | B | HT | F | T |
+*/
+#define CLKCFG_B_BIT          (1 << 3)
+#define CLKCFG_HT_BIT        (1 << 2)
+#define CLKCFG_F_BIT          (1 << 1)
+#define CLKCFG_T_BIT          1
+
+/* Initialize the machine-dependent operating point from a list of parameters,
+   which has already been installed in the pp field of the operating point.
+   Some of the parameters may be specified with a value of -1 to indicate a
+   default value. */
+
+#define        PLL_L_MAX       31
+#define        PLL_N_MAX       8
+
+/* The MIN for L is 2 in the Yellow Book tables, but L=1 really means
+   13M mode, so L min includes 1 */
+#define        PLL_L_MIN       1
+#define        PLL_N_MIN       2
+
+/* memory timing (MSC0,DTC,DRI) constants (see Blob and Intel BBU sources) */
+#define XLLI_MSC0_13 0x11101110
+#define XLLI_MSC0_19 0x11101110
+#define XLLI_MSC0_26 0x11201120  /* 26 MHz setting */
+#define XLLI_MSC0_32 0x11201120
+#define XLLI_MSC0_39 0x11301130   /* 39 MHz setting */
+#define XLLI_MSC0_45 0x11301130
+#define XLLI_MSC0_52 0x11401140  /* @ 52 MHz setting */
+#define XLLI_MSC0_58 0x11401140
+#define XLLI_MSC0_65 0x11501150  /* @ 65 MHz setting */
+#define XLLI_MSC0_68 0x11501150
+#define XLLI_MSC0_71 0x11501150  /* @ 71.5 MHz setting */
+#define XLLI_MSC0_74 0x11601160
+#define XLLI_MSC0_78 0x12601260  /* @ 78 MHz setting */
+#define XLLI_MSC0_81 0x12601260
+#define XLLI_MSC0_84 0x12601260  /*  @ 84.5 MHz setting */
+#define XLLI_MSC0_87 0x12701270
+#define XLLI_MSC0_91 0x12701270  /* 91 MHz setting */
+#define XLLI_MSC0_94 0x12701270  /* 94.2 MHz setting */
+#define XLLI_MSC0_97 0x12701270  /* 97.5 MHz setting */
+#define XLLI_MSC0_100 0x12801280 /* 100.7 MHz setting */
+#define XLLI_MSC0_104 0x12801280 /* 104 MHz setting */
+#define XLLI_MSC0_110 0x12901290
+#define XLLI_MSC0_117 0x13901390 /* 117 MHz setting */
+#define XLLI_MSC0_124 0x13A013A0
+#define XLLI_MSC0_130 0x13A013A0 /* 130 MHz setting */
+#define XLLI_MSC0_136 0x13B013B0
+#define XLLI_MSC0_143 0x13B013B0
+#define XLLI_MSC0_149 0x13C013C0
+#define XLLI_MSC0_156 0x14C014C0
+#define XLLI_MSC0_162 0x14C014C0
+#define XLLI_MSC0_169 0x14C014C0
+#define XLLI_MSC0_175 0x14C014C0
+#define XLLI_MSC0_182 0x14C014C0
+#define XLLI_MSC0_188 0x14C014C0
+#define XLLI_MSC0_195 0x15C015C0
+#define XLLI_MSC0_201 0x15D015D0
+#define XLLI_MSC0_208 0x15D015D0
+
+/* DTC settings depend on 16/32 bit SDRAM we have (32 is chosen) */
+#define XLLI_DTC_13 0x00000000
+#define XLLI_DTC_19 0x00000000
+#define XLLI_DTC_26 0x00000000
+#define XLLI_DTC_32 0x00000000
+#define XLLI_DTC_39 0x00000000
+#define XLLI_DTC_45 0x00000000
+#define XLLI_DTC_52 0x00000000
+#define XLLI_DTC_58 0x01000100
+#define XLLI_DTC_65 0x01000100
+#define XLLI_DTC_68 0x01000100
+#define XLLI_DTC_71 0x01000100
+#define XLLI_DTC_74 0x01000100
+#define XLLI_DTC_78 0x01000100
+#define XLLI_DTC_81 0x01000100
+#define XLLI_DTC_84 0x01000100
+#define XLLI_DTC_87 0x01000100
+#define XLLI_DTC_91 0x02000200
+#define XLLI_DTC_94 0x02000200
+#define XLLI_DTC_97 0x02000200
+#define XLLI_DTC_100 0x02000200
+#define XLLI_DTC_104 0x02000200
+/* 110-208 MHz setting - SDCLK Halved*/
+#define XLLI_DTC_110 0x01000100
+#define XLLI_DTC_117 0x01000100
+#define XLLI_DTC_124 0x01000100
+#define XLLI_DTC_130 0x01000100
+#define XLLI_DTC_136 0x01000100
+#define XLLI_DTC_143 0x01000100
+#define XLLI_DTC_149 0x01000100
+#define XLLI_DTC_156 0x01000100
+#define XLLI_DTC_162 0x01000100
+#define XLLI_DTC_169 0x01000100
+#define XLLI_DTC_175 0x01000100
+/*  182-208 MHz setting - SDCLK Halved - Close to edge, so bump up */
+#define XLLI_DTC_182 0x02000200
+#define XLLI_DTC_188 0x02000200
+#define XLLI_DTC_195 0x02000200
+#define XLLI_DTC_201 0x02000200
+#define XLLI_DTC_208 0x02000200
+
+/*       Optimal values for DRI (refreash interval) settings for
+ * various MemClk settings (MDREFR)
+ */
+#define XLLI_DRI_13 0x002
+#define XLLI_DRI_19 0x003
+#define XLLI_DRI_26 0x005
+#define XLLI_DRI_32 0x006
+#define XLLI_DRI_39 0x008
+#define XLLI_DRI_45 0x00A
+#define XLLI_DRI_52 0x00B
+#define XLLI_DRI_58 0x00D
+#define XLLI_DRI_65 0x00E
+#define XLLI_DRI_68 0x00F
+#define XLLI_DRI_71 0x010
+#define XLLI_DRI_74 0x011
+#define XLLI_DRI_78 0x012
+#define XLLI_DRI_81 0x012
+#define XLLI_DRI_84 0x013
+#define XLLI_DRI_87 0x014
+#define XLLI_DRI_91 0x015
+#define XLLI_DRI_94 0x016
+#define XLLI_DRI_97 0x016
+#define XLLI_DRI_100 0x017
+#define XLLI_DRI_104 0x018
+#define XLLI_DRI_110 0x01A
+#define XLLI_DRI_117 0x01B
+#define XLLI_DRI_124 0x01D
+#define XLLI_DRI_130 0x01E
+#define XLLI_DRI_136 0x020
+#define XLLI_DRI_143 0x021
+#define XLLI_DRI_149 0x023
+#define XLLI_DRI_156 0x025
+#define XLLI_DRI_162 0x026
+#define XLLI_DRI_169 0x028
+#define XLLI_DRI_175 0x029
+#define XLLI_DRI_182 0x02B
+#define XLLI_DRI_188 0x02D
+#define XLLI_DRI_195 0x02E
+#define XLLI_DRI_201 0x030
+#define XLLI_DRI_208 0x031
+
+
+
+/* timings for memory controller set up (masked values) */
+struct mem_timings{
+       unsigned int msc0; /* for MSC0 */
+       unsigned int dtc; /* for MDCNFG */
+       unsigned int dri; /* for MDREFR */
+};
+
+static int pxa27x_transition(struct oppoint *cur, struct oppoint *new);
+
+static struct oppoint m13 = {
+       .name = "13m",
+       .type = PM_FREQ_CHANGE,
+       .prepare_transition  = cpufreq_prepare_transition,
+       .transition = pxa27x_transition,
+       .finish_transition = cpufreq_finish_transition,
+};
+
+static struct oppoint mext13 = {
+       .name = "13mext",
+       .type = PM_FREQ_CHANGE,
+       .voltage = 1500,
+       .prepare_transition  = cpufreq_prepare_transition,
+       .transition = pxa27x_transition,
+       .finish_transition = cpufreq_finish_transition,
+};
+
+static struct oppoint sleep = {
+       .name = "sleep",
+       .type = PM_FREQ_CHANGE,
+       .voltage = 1500,
+       .frequency = 0,
+       .latency = 150,
+       .prepare_transition  = cpufreq_prepare_transition,
+       .transition = pxa27x_transition,
+       .finish_transition = cpufreq_finish_transition,
+};
+
+static struct oppoint deepsleep = {
+       .name = "deepsleep",
+       .type = PM_FREQ_CHANGE,
+       .voltage = 1500,
+       .frequency = 0,
+       .latency = 1000,
+       .prepare_transition  = cpufreq_prepare_transition,
+       .transition = pxa27x_transition,
+       .finish_transition = cpufreq_finish_transition,
+};
+
+static struct oppoint standby = {
+       .name = "pxastandby",
+       .type = PM_FREQ_CHANGE,
+       .voltage = 1500,
+       .frequency = 0,
+       .latency = 150,
+       .prepare_transition  = cpufreq_prepare_transition,
+       .transition = pxa27x_transition,
+       .finish_transition = cpufreq_finish_transition,
+};
+
+static struct oppoint lowest = {
+       .name = "lowest",
+       .type = PM_FREQ_CHANGE,
+       .frequency = 0,
+       .voltage = 0,
+       .latency = 100,
+       .prepare_transition  = cpufreq_prepare_transition,
+       .transition = pxa27x_transition,
+       .finish_transition = cpufreq_finish_transition,
+};
+
+static struct oppoint low = {
+       .name = "low",
+       .type = PM_FREQ_CHANGE,
+       .frequency = 0,
+       .voltage = 0,
+       .latency = 100,
+       .prepare_transition  = cpufreq_prepare_transition,
+       .transition = pxa27x_transition,
+       .finish_transition = cpufreq_finish_transition,
+};
+
+static struct oppoint mediumlow = {
+       .name = "mediumlow",
+       .type = PM_FREQ_CHANGE,
+       .frequency = 0,
+       .voltage = 0,
+       .latency = 100,
+       .prepare_transition  = cpufreq_prepare_transition,
+       .transition = pxa27x_transition,
+       .finish_transition = cpufreq_finish_transition,
+};
+
+static struct oppoint medium = {
+       .name = "medium",
+       .type = PM_FREQ_CHANGE,
+       .frequency = 0,
+       .voltage = 0,
+       .latency = 100,
+       .prepare_transition  = cpufreq_prepare_transition,
+       .transition = pxa27x_transition,
+       .finish_transition = cpufreq_finish_transition,
+};
+
+static struct oppoint mediumhigh = {
+       .name = "mediumhigh",
+       .type = PM_FREQ_CHANGE,
+       .frequency = 0,
+       .voltage = 0,
+       .latency = 100,
+       .prepare_transition  = cpufreq_prepare_transition,
+       .transition = pxa27x_transition,
+       .finish_transition = cpufreq_finish_transition,
+};
+
+static struct oppoint high = {
+       .name = "high",
+       .type = PM_FREQ_CHANGE,
+       .frequency = 0,
+       .voltage = 0,
+       .latency = 100,
+       .prepare_transition  = cpufreq_prepare_transition,
+       .transition = pxa27x_transition,
+       .finish_transition = cpufreq_finish_transition,
+};
+
+static struct oppoint highest = {
+       .name = "highest",
+       .type = PM_FREQ_CHANGE,
+       .frequency = 0,
+       .voltage = 0,
+       .latency = 100,
+       .prepare_transition  = cpufreq_prepare_transition,
+       .transition = pxa27x_transition,
+       .finish_transition = cpufreq_finish_transition,
+};
+
+static struct md_opt mhz104 = {
+       .v = 900,
+       .l = 8,
+       .n = 2,
+       .b = 1,
+       .half_turbo = 0,
+       .cccra = 1,
+       .cpll_enabled = 1,
+       .ppll_enabled = 1,
+       .sleep_mode = 0,
+};
+
+static struct md_opt mhz208 = {
+       .v = 1050,
+       .l = 16,
+       .n = 2,
+       .b = 1,
+       .half_turbo = 0,
+       .cccra = 0,
+       .cpll_enabled = 1,
+       .ppll_enabled = 1,
+       .sleep_mode = 0,
+};
+
+static struct md_opt mhz312 = {
+       .v = 1250,
+       .l = 16,
+       .n = 3,
+       .b = 1,
+       .half_turbo = 0,
+       .cccra = 0,
+       .cpll_enabled = 1,
+       .ppll_enabled = 1,
+       .sleep_mode = 0,
+};
+
+static struct md_opt mhz208hi = {
+       .v = 1150,
+       .l = 16,
+       .n = 2,
+       .b = 1,
+       .half_turbo = 0,
+       .cccra = 1,
+       .cpll_enabled = 1,
+       .ppll_enabled = 1,
+       .sleep_mode = 0,
+};
+
+static struct md_opt mhz312hi = {
+       .v = 1250,
+       .l = 16,
+       .n = 3,
+       .b = 1,
+       .half_turbo = 0,
+       .cccra = 1,
+       .cpll_enabled = 1,
+       .ppll_enabled = 1,
+       .sleep_mode = 0,
+};
+
+static struct md_opt mhz416hi = {
+       .v = 1350,
+       .l = 16,
+       .n = 4,
+       .b = 1,
+       .half_turbo = 0,
+       .cccra = 1,
+       .cpll_enabled = 1,
+       .ppll_enabled = 1,
+       .sleep_mode = 0,
+};
+
+static struct md_opt mhz520hi = {
+       .v = 1450,
+       .l = 16,
+       .n = 5,
+       .b = 1,
+       .half_turbo = 0,
+       .cccra = 1,
+       .cpll_enabled = 1,
+       .ppll_enabled = 1,
+       .sleep_mode = 0,
+};
+
+static struct md_opt md_sleep = {
+       .v = 1500,
+       .l = 0,
+       .n = 0,
+       .b = 0,
+       .half_turbo = -1,
+       .cccra = 0,
+       .cpll_enabled = 0,
+       .ppll_enabled = 0,
+       .sleep_mode = 3,
+};
+
+static struct md_opt md_deepsleep = {
+       .v = 1500,
+       .l = 0,
+       .n = 0,
+       .b = 0,
+       .half_turbo = -1,
+       .cccra = 0,
+       .cpll_enabled = 0,
+       .ppll_enabled = 0,
+       .sleep_mode = 7,
+};
+
+static struct md_opt md_standby = {
+       .v = 1500,
+       .l = 1,
+       .n = 2,
+       .b = 0,
+       .half_turbo = -1,
+       .cccra = 0,
+       .cpll_enabled = 0,
+       .ppll_enabled = 0,
+       .sleep_mode = -1,
+};
+
+static struct md_opt md_13m = {
+       .v = 1500,
+       .l = 1,
+       .n = 2,
+       .b = 0,
+       .half_turbo = -1,
+       .cccra = 0,
+       .cpll_enabled = 0,
+       .ppll_enabled = 0,
+       .sleep_mode = -1,
+};
+
+static struct md_opt md_13mext = {
+       .v = 1500,
+       .l = 1,
+       .n = 2,
+       .b = 0,
+       .half_turbo = -1,
+       .cccra = 0,
+       .cpll_enabled = 0,
+       .ppll_enabled = 0,
+       .sleep_mode = -1,
+};
+
+static void
+mainstone_setup_opt(struct oppoint *op, uint freq, struct md_opt *md)
+{
+       op->frequency = freq * 1000;
+       op->md_data = (void *)md;
+       op->voltage = md->v;
+}
+
+static unsigned int fscaler_flags = 0;
+
+void mainstone_fully_define_opt(struct oppoint *cur,
+                                  struct oppoint *new);
+static int mainstone_fscale(struct oppoint *cur, struct oppoint *new);
+static void mainstone_fscaler(struct oppoint_regs *regs);
+
+extern void mainstone_set_voltage(unsigned int mv);
+extern void mainstone_prep_set_voltage(unsigned int mv);
+extern int mainstone_vcs_init(void);
+extern void mainstone_voltage_cleanup(void);
+
+static unsigned long
+calculate_memclk(unsigned long cccr, unsigned long clkcfg)
+{
+       unsigned long M, memclk;
+       u32 L;
+
+       L = cccr & 0x1f;
+       if (cccr & (1 << 25)) {
+               if  (clkcfg & CLKCFG_B_BIT)
+                       memclk = (L*13);
+               else
+                       memclk = (L*13)/2;
+       }
+       else {
+               if (L <= 10) M = 1;
+               else if (L <= 20) M = 2;
+               else M = 4;
+
+               memclk = (L*13)/M;
+       }
+
+       return memclk;
+}
+
+static unsigned long
+calculate_new_memclk(struct oppoint_regs *regs)
+{
+       return calculate_memclk(regs->cccr, regs->clkcfg);
+}
+
+static unsigned long
+calculate_cur_memclk(void)
+{
+       unsigned long cccr = CCCR;
+       return calculate_memclk(cccr, mainstone_read_clkcfg());
+}
+
+/* Returns optimal timings for memory controller
+ * a - [A]
+ * b - [B]
+ * l - value of L
+ */
+static struct mem_timings get_optimal_mem_timings(int a, int b, int l){
+       struct mem_timings ret = {
+               .msc0 = 0,
+               .dtc = 0,
+               .dri = 0,
+       };
+
+       if (a!=0 && b==0) {
+               switch (l) {
+               case 2:
+                       ret.msc0 = XLLI_MSC0_13;
+                       ret.dtc = XLLI_DTC_13;
+                       ret.dri = XLLI_DRI_13;
+                       break;
+               case 3:
+                       ret.msc0 = XLLI_MSC0_19;
+                       ret.dtc = XLLI_DTC_19;
+                       ret.dri = XLLI_DRI_19;
+                       break;
+               case 4:
+                       ret.msc0 = XLLI_MSC0_26;
+                       ret.dtc = XLLI_DTC_26;
+                       ret.dri = XLLI_DRI_26;
+                       break;
+               case 5:
+                       ret.msc0 = XLLI_MSC0_32;
+                       ret.dtc = XLLI_DTC_32;
+                       ret.dri = XLLI_DRI_32;
+                       break;
+               case 6:
+                       ret.msc0 = XLLI_MSC0_39;
+                       ret.dtc = XLLI_DTC_39;
+                       ret.dri = XLLI_DRI_39;
+                       break;
+               case 7:
+                       ret.msc0 = XLLI_MSC0_45;
+                       ret.dtc = XLLI_DTC_45;
+                       ret.dri = XLLI_DRI_45;
+                       break;
+               case 8:
+                       ret.msc0 = XLLI_MSC0_52;
+                       ret.dtc = XLLI_DTC_52;
+                       ret.dri = XLLI_DRI_52;
+                       break;
+               case 9:
+                       ret.msc0 = XLLI_MSC0_58;
+                       ret.dtc = XLLI_DTC_58;
+                       ret.dri = XLLI_DRI_58;
+                       break;
+               case 10:
+                       ret.msc0 = XLLI_MSC0_65;
+                       ret.dtc = XLLI_DTC_65;
+                       ret.dri = XLLI_DRI_65;
+                       break;
+                       /*
+                        *       L11 - L20 ARE THE SAME for A0Bx
+                        */
+               case 11:
+                       ret.msc0 = XLLI_MSC0_71;
+                       ret.dtc = XLLI_DTC_71;
+                       ret.dri = XLLI_DRI_71;
+                       break;
+               case 12:
+                       ret.msc0 = XLLI_MSC0_78;
+                       ret.dtc = XLLI_DTC_78;
+                       ret.dri = XLLI_DRI_78;
+                       break;
+               case 13:
+                       ret.msc0 = XLLI_MSC0_84;
+                       ret.dtc = XLLI_DTC_84;
+                       ret.dri = XLLI_DRI_84;
+                       break;
+               case 14:
+                       ret.msc0 = XLLI_MSC0_91;
+                       ret.dtc = XLLI_DTC_91;
+                       ret.dri = XLLI_DRI_91;
+                       break;
+               case 15:
+                       ret.msc0 = XLLI_MSC0_97;
+                       ret.dtc = XLLI_DTC_97;
+                       ret.dri = XLLI_DRI_97;
+                       break;
+               case 16:
+                       ret.msc0 = XLLI_MSC0_104;
+                       ret.dtc = XLLI_DTC_104;
+                       ret.dri = XLLI_DRI_104;
+                       break;
+               case 17:
+                       ret.msc0 = XLLI_MSC0_110;
+                       ret.dtc = XLLI_DTC_110;
+                       ret.dri = XLLI_DRI_110;
+                       break;
+               case 18:
+                       ret.msc0 = XLLI_MSC0_117;
+                       ret.dtc = XLLI_DTC_117;
+                       ret.dri = XLLI_DRI_117;
+                       break;
+               case 19:
+                       ret.msc0 = XLLI_MSC0_124;
+                       ret.dtc = XLLI_DTC_124;
+                       ret.dri = XLLI_DRI_124;
+                       break;
+               case 20:
+                       ret.msc0 = XLLI_MSC0_130;
+                       ret.dtc = XLLI_DTC_130;
+                       ret.dri = XLLI_DRI_130;
+                       break;
+               case 21:
+                       ret.msc0 = XLLI_MSC0_136;
+                       ret.dtc = XLLI_DTC_136;
+                       ret.dri = XLLI_DRI_136;
+                       break;
+               case 22:
+                       ret.msc0 = XLLI_MSC0_143;
+                       ret.dtc = XLLI_DTC_143;
+                       ret.dri = XLLI_DRI_143;
+                       break;
+               case 23:
+                       ret.msc0 = XLLI_MSC0_149;
+                       ret.dtc = XLLI_DTC_149;
+                       ret.dri = XLLI_DRI_149;
+                       break;
+               case 24:
+                       ret.msc0 = XLLI_MSC0_156;
+                       ret.dtc = XLLI_DTC_156;
+                       ret.dri = XLLI_DRI_156;
+                       break;
+               case 25:
+                       ret.msc0 = XLLI_MSC0_162;
+                       ret.dtc = XLLI_DTC_162;
+                       ret.dri = XLLI_DRI_162;
+                       break;
+               case 26:
+                       ret.msc0 = XLLI_MSC0_169;
+                       ret.dtc = XLLI_DTC_169;
+                       ret.dri = XLLI_DRI_169;
+                       break;
+               case 27:
+                       ret.msc0 = XLLI_MSC0_175;
+                       ret.dtc = XLLI_DTC_175;
+                       ret.dri = XLLI_DRI_175;
+                       break;
+               case 28:
+                       ret.msc0 = XLLI_MSC0_182;
+                       ret.dtc = XLLI_DTC_182;
+                       ret.dri = XLLI_DRI_182;
+                       break;
+               case 29:
+                       ret.msc0 = XLLI_MSC0_188;
+                       ret.dtc = XLLI_DTC_188;
+                       ret.dri = XLLI_DRI_188;
+                       break;
+               case 30:
+                       ret.msc0 = XLLI_MSC0_195;
+                       ret.dtc = XLLI_DTC_195;
+                       ret.dri = XLLI_DRI_195;
+                       break;
+               case 31:
+                       ret.msc0 = XLLI_MSC0_201;
+                       ret.dtc = XLLI_DTC_201;
+                       ret.dri = XLLI_DRI_201;
+               }
+
+       } else if (a!=0 && b!=0) {
+         switch (l) {
+               case 2:
+                       ret.msc0 = XLLI_MSC0_26;
+                       ret.dtc = XLLI_DTC_26;
+                       ret.dri = XLLI_DRI_26;
+                       break;
+               case 3:
+                       ret.msc0 = XLLI_MSC0_39;
+                       ret.dtc = XLLI_DTC_39;
+                       ret.dri = XLLI_DRI_39;
+                       break;
+               case 4:
+                       ret.msc0 = XLLI_MSC0_52;
+                       ret.dtc = XLLI_DTC_52;
+                       ret.dri = XLLI_DRI_52;
+                       break;
+               case 5:
+                       ret.msc0 = XLLI_MSC0_65;
+                       ret.dtc = XLLI_DTC_65;
+                       ret.dri = XLLI_DRI_65;
+                       break;
+               case 6:
+                       ret.msc0 = XLLI_MSC0_78;
+                       ret.dtc = XLLI_DTC_78;
+                       ret.dri = XLLI_DRI_78;
+                       break;
+               case 7:
+                       ret.msc0 = XLLI_MSC0_91;
+                       ret.dtc = XLLI_DTC_91;
+                       ret.dri = XLLI_DRI_91;
+                       break;
+               case 8:
+                       ret.msc0 = XLLI_MSC0_104;
+                       ret.dtc = XLLI_DTC_104;
+                       ret.dri = XLLI_DRI_104;
+                       break;
+               case 9:
+                       ret.msc0 = XLLI_MSC0_117;
+                       ret.dtc = XLLI_DTC_117;
+                       ret.dri = XLLI_DRI_117;
+                       break;
+               case 10:
+                       ret.msc0 = XLLI_MSC0_130;
+                       ret.dtc = XLLI_DTC_130;
+                       ret.dri = XLLI_DRI_130;
+                       break;
+               case 11:
+                       ret.msc0 = XLLI_MSC0_143;
+                       ret.dtc = XLLI_DTC_143;
+                       ret.dri = XLLI_DRI_143;
+                       break;
+               case 12:
+                       ret.msc0 = XLLI_MSC0_156;
+                       ret.dtc = XLLI_DTC_156;
+                       ret.dri = XLLI_DRI_156;
+                       break;
+               case 13:
+                       ret.msc0 = XLLI_MSC0_169;
+                       ret.dtc = XLLI_DTC_169;
+                       ret.dri = XLLI_DRI_169;
+                       break;
+               case 14:
+                       ret.msc0 = XLLI_MSC0_182;
+                       ret.dtc = XLLI_DTC_182;
+                       ret.dri = XLLI_DRI_182;
+                       break;
+               case 15:
+                       ret.msc0 = XLLI_MSC0_195;
+                       ret.dtc = XLLI_DTC_195;
+                       ret.dri = XLLI_DRI_195;
+                       break;
+               case 16:
+                       ret.msc0 = XLLI_MSC0_208;
+                       ret.dtc = XLLI_DTC_208;
+                       ret.dri = XLLI_DRI_208;
+               }
+       } else {
+         /* A0Bx */
+               switch (l) {
+               case 2:
+                       ret.msc0 = XLLI_MSC0_26;
+                       ret.dtc = XLLI_DTC_26;
+                       ret.dri = XLLI_DRI_26;
+                       break;
+               case 3:
+                       ret.msc0 = XLLI_MSC0_39;
+                       ret.dtc = XLLI_DTC_39;
+                       ret.dri = XLLI_DRI_39;
+                       break;
+               case 4:
+                       ret.msc0 = XLLI_MSC0_52;
+                       ret.dtc = XLLI_DTC_52;
+                       ret.dri = XLLI_DRI_52;
+                       break;
+               case 5:
+                       ret.msc0 = XLLI_MSC0_65;
+                       ret.dtc = XLLI_DTC_65;
+                       ret.dri = XLLI_DRI_65;
+                       break;
+               case 6:
+                       ret.msc0 = XLLI_MSC0_78;
+                       ret.dtc = XLLI_DTC_78;
+                       ret.dri = XLLI_DRI_78;
+                       break;
+               case 7:
+                       ret.msc0 = XLLI_MSC0_91;
+                       ret.dtc = XLLI_DTC_91;
+                       ret.dri = XLLI_DRI_91;
+                       break;
+               case 8:
+                       ret.msc0 = XLLI_MSC0_104;
+                       ret.dtc = XLLI_DTC_104;
+                       ret.dri = XLLI_DRI_104;
+                       break;
+               case 9:
+                       ret.msc0 = XLLI_MSC0_117;
+                       ret.dtc = XLLI_DTC_117;
+                       ret.dri = XLLI_DRI_117;
+                       break;
+               case 10:
+                       ret.msc0 = XLLI_MSC0_130;
+                       ret.dtc = XLLI_DTC_130;
+                       ret.dri = XLLI_DRI_130;
+                       break;
+               case 11:
+                       ret.msc0 = XLLI_MSC0_71;
+                       ret.dtc = XLLI_DTC_71;
+                       ret.dri = XLLI_DRI_71;
+                       break;
+               case 12:
+                       ret.msc0 = XLLI_MSC0_78;
+                       ret.dtc = XLLI_DTC_78;
+                       ret.dri = XLLI_DRI_78;
+                       break;
+               case 13:
+                       ret.msc0 = XLLI_MSC0_84;
+                       ret.dtc = XLLI_DTC_84;
+                       ret.dri = XLLI_DRI_84;
+                       break;
+               case 14:
+                       ret.msc0 = XLLI_MSC0_91;
+                       ret.dtc = XLLI_DTC_91;
+                       ret.dri = XLLI_DRI_91;
+                       break;
+               case 15:
+                       ret.msc0 = XLLI_MSC0_97;
+                       ret.dtc = XLLI_DTC_97;
+                       ret.dri = XLLI_DRI_97;
+                       break;
+               case 16:
+                       ret.msc0 = XLLI_MSC0_104;
+                       ret.dtc = XLLI_DTC_104;
+                       ret.dri = XLLI_DRI_104;
+                       break;
+               case 17:
+                       ret.msc0 = XLLI_MSC0_110;
+                       ret.dtc = XLLI_DTC_110;
+                       ret.dri = XLLI_DRI_110;
+                       break;
+               case 18:
+                       ret.msc0 = XLLI_MSC0_117;
+                       ret.dtc = XLLI_DTC_117;
+                       ret.dri = XLLI_DRI_117;
+                       break;
+               case 19:
+                       ret.msc0 = XLLI_MSC0_124;
+                       ret.dtc = XLLI_DTC_124;
+                       ret.dri = XLLI_DRI_124;
+                       break;
+               case 20:
+                       ret.msc0 = XLLI_MSC0_130;
+                       ret.dtc = XLLI_DTC_130;
+                       ret.dri = XLLI_DRI_130;
+                       break;
+               case 21:
+                       ret.msc0 = XLLI_MSC0_68;
+                       ret.dtc = XLLI_DTC_68;
+                       ret.dri = XLLI_DRI_68;
+                       break;
+               case 22:
+                       ret.msc0 = XLLI_MSC0_71;
+                       ret.dtc = XLLI_DTC_71;
+                       ret.dri = XLLI_DRI_71;
+                       break;
+               case 23:
+                       ret.msc0 = XLLI_MSC0_74;
+                       ret.dtc = XLLI_DTC_74;
+                       ret.dri = XLLI_DRI_74;
+                       break;
+               case 24:
+                       ret.msc0 = XLLI_MSC0_78;
+                       ret.dtc = XLLI_DTC_78;
+                       ret.dri = XLLI_DRI_78;
+                       break;
+               case 25:
+                       ret.msc0 = XLLI_MSC0_81;
+                       ret.dtc = XLLI_DTC_81;
+                       ret.dri = XLLI_DRI_81;
+                       break;
+               case 26:
+                       ret.msc0 = XLLI_MSC0_84;
+                       ret.dtc = XLLI_DTC_84;
+                       ret.dri = XLLI_DRI_84;
+                       break;
+               case 27:
+                       ret.msc0 = XLLI_MSC0_87;
+                       ret.dtc = XLLI_DTC_87;
+                       ret.dri = XLLI_DRI_87;
+                       break;
+               case 28:
+                       ret.msc0 = XLLI_MSC0_91;
+                       ret.dtc = XLLI_DTC_91;
+                       ret.dri = XLLI_DRI_91;
+                       break;
+               case 29:
+                       ret.msc0 = XLLI_MSC0_94;
+                       ret.dtc = XLLI_DTC_94;
+                       ret.dri = XLLI_DRI_94;
+                       break;
+               case 30:
+                       ret.msc0 = XLLI_MSC0_97;
+                       ret.dtc = XLLI_DTC_97;
+                       ret.dri = XLLI_DRI_97;
+                       break;
+               case 31:
+                       ret.msc0 = XLLI_MSC0_100;
+                       ret.dtc = XLLI_DTC_100;
+                       ret.dri = XLLI_DRI_100;
+               }
+       }
+
+       return ret;
+}
+
+static void assign_optimal_mem_timings(
+       unsigned int* msc0_reg,
+       unsigned int* mdrefr_reg,
+       unsigned int* mdcnfg_reg,
+       int a, int b, int l
+       )
+{
+       unsigned int msc0_reg_tmp = (*msc0_reg);
+       unsigned int mdrefr_reg_tmp = (*mdrefr_reg);
+       unsigned int mdcnfg_reg_tmp = (*mdcnfg_reg);
+       struct mem_timings timings = get_optimal_mem_timings(a,b,l);
+
+       /* clear bits which are set by get_optimal_mem_timings*/
+       msc0_reg_tmp &= ~(MSC0_RDF & MSC0_RDN & MSC0_RRR);
+       mdrefr_reg_tmp &= ~(MDREFR_RFU & MDREFR_DRI);
+       mdcnfg_reg_tmp &= ~(MDCNFG_DTC0 & MDCNFG_DTC2);
+
+       /* prepare appropriate timings */
+       msc0_reg_tmp |= timings.msc0;
+       mdrefr_reg_tmp |= timings.dri;
+       mdcnfg_reg_tmp |= timings.dtc;
+
+       /* set timings (all bits one time) */
+       (*msc0_reg) = msc0_reg_tmp;
+       (*mdrefr_reg) = mdrefr_reg_tmp;
+       (*mdcnfg_reg) = mdcnfg_reg_tmp;
+}
+
+static void set_mdrefr_value(u32 new_mdrefr)
+{
+       unsigned long s, old_mdrefr, errata62;
+       old_mdrefr = MDREFR;
+       /* E62 (28007106.pdf): Memory controller may hang while clearing
+        * MDREFR[K1DB2] or MDREFR[K2DB2]
+        */
+       errata62 = (((old_mdrefr & MDREFR_K1DB2) != 0) &&
+               ((new_mdrefr & MDREFR_K1DB2) == 0)) ||
+               (((old_mdrefr & MDREFR_K2DB2) != 0) &&
+               ((new_mdrefr & MDREFR_K2DB2) == 0));
+
+       if (errata62) {
+               unsigned long oscr_0 = OSCR;
+               unsigned long oscr_1 = oscr_0;
+               /* Step 1 - disable interrupts */
+               local_irq_save(s);
+               /* Step 2 - leave KxDB2, but set MDREFR[DRI] (bits 0-11) to
+                *  0xFFF
+                */
+               MDREFR = MDREFR | MDREFR_DRI;
+               /* Step 3 - read MDREFR one time */
+               MDREFR;
+               /* Step 4 - wait 1.6167us
+                * (3.25MHz clock increments OSCR0 7 times)
+                */
+               while (oscr_1-oscr_0 < 7) {
+                       cpu_relax();
+                       oscr_1 = OSCR;
+               }
+
+       }
+
+       /* Step 5 - clear K1DB1 and/or K2DB2, and set MDREFR[DRI] to
+        * proper value at the same time
+        */
+
+       /*Set MDREFR as if no errata workaround is needed*/
+       MDREFR = new_mdrefr;
+
+       if (errata62) {
+               /* Step 6 - read MDREFR one time*/
+               MDREFR;
+               /* Step 7 - enable interrupts*/
+               local_irq_restore(s);
+       }
+}
+
+static void mainstone_scale_cpufreq(struct oppoint_regs *regs)
+{
+       unsigned long new_memclk, cur_memclk;
+       u32 new_mdrefr, cur_mdrefr, read_mdrefr;
+       u32 new_msc0, new_mdcnfg;
+       int set_mdrefr = 0, scaling_up = 0;
+       int l, a, b;
+
+       l = regs->cccr & CCCR_L_MASK;   /* Get L */
+       b = (regs->clkcfg >> 3) & 0x1;
+       a = (regs->cccr >> 25) & 0x1;   /* cccr[A]: bit 25 */
+
+       cur_memclk = calculate_cur_memclk();
+       new_memclk = calculate_new_memclk(regs);
+
+       new_mdrefr = cur_mdrefr = MDREFR;
+       new_msc0 = MSC0;
+       new_mdcnfg = MDCNFG;
+
+       if (new_memclk != cur_memclk) {
+               /* SDCLK0,SDCLK1,SDCLK2 = MEMCLK - by default (<=52MHz) */
+               new_mdrefr &= ~( MDREFR_K0DB2 | MDREFR_K0DB4 |
+                       MDREFR_K1DB2 | MDREFR_K2DB2 );
+
+               if ((new_memclk > 52) && (new_memclk <= 104)) {
+                       /* SDCLK0 = MEMCLK/2, SDCLK1,SDCLK2 = MEMCLK */
+                       new_mdrefr |= MDREFR_K0DB2;
+               }
+               else if (new_memclk > 104){
+                       /* SDCLK0 = MEMCLK/4,  SDCLK1 and SDCLK2 = MEMCLK/2 */
+                       new_mdrefr |= (MDREFR_K0DB4 | MDREFR_K1DB2 |
MDREFR_K2DB2);
+               }
+
+               /* clock increasing or decreasing? */
+               if (new_memclk > cur_memclk) scaling_up = 1;
+       }
+
+       /* set MDREFR if necessary */
+       if (new_mdrefr != cur_mdrefr){
+               set_mdrefr = 1;
+               /* also adjust timings  as long as we change MDREFR value */
+               assign_optimal_mem_timings(
+                                          &new_msc0,
+                                          &new_mdrefr,
+                                          &new_mdcnfg,
+                                          a,b,l
+                                          );
+       }
+
+       /* if memclk is scaling up, set MDREFR before freq change
+        * (2800002.pdf:6.5.1.4)
+        */
+       if (set_mdrefr && scaling_up) {
+               MSC0 = new_msc0;
+               set_mdrefr_value(new_mdrefr);
+               MDCNFG = new_mdcnfg;
+               read_mdrefr = MDREFR;
+       }
+
+       CCCR = regs->cccr;
+       mainstone_set_freq(regs->clkcfg);
+
+       /* if memclk is scaling down, set MDREFR after freq change
+        * (2800002.pdf:6.5.1.4)
+        */
+       if (set_mdrefr && !scaling_up) {
+               MSC0 = new_msc0;
+               set_mdrefr_value(new_mdrefr);
+               MDCNFG = new_mdcnfg;
+               read_mdrefr = MDREFR;
+       }
+}
+
+static void mainstone_scale_voltage(struct oppoint_regs *regs)
+{
+       mainstone_set_voltage(regs->voltage);
+}
+
+static void mainstone_scale_voltage_coupled(struct oppoint_regs *regs)
+{
+       mainstone_prep_set_voltage(regs->voltage);
+}
+
+static void calculate_lcd_freq(struct md_opt *opt)
+{
+       int k = 1;              /* lcd divisor */
+
+       /* L is verified to be between PLL_L_MAX and PLL_L_MIN in */
+       if (opt->l == -1) {
+               opt->lcd = -1;
+               return;
+       }
+
+       if (opt->l > 16) {
+               /* When L=17-31, K=4 */
+               k = 4;
+       } else if (opt->l > 7) {
+               /* When L=8-16, K=2 */
+               k = 2;
+       }
+
+       /* Else, when L=2-7, K=1 */
+
+       opt->lcd = 13000 * opt->l / k;
+}
+
+static void calculate_reg_values(struct md_opt *opt)
+{
+       int f = 0;              /* frequency change bit */
+       int turbo = 0;          /* turbo mode bit; depends on N value */
+
+       opt->regs.voltage = opt->v;
+/*
+  CCCR
+    | 31| 30|29-28| 27| 26| 25|24-11| 10| 9 | 8 | 7 |6-5  | 4 | 3 | 2 | 1 | 0 |
+    | C | P |     | L | P |   |     |         |     |             |
+    | P | P |     | C | L |   |     |         |     |             |
+    | D | D |resrv| D | L | A |resrv|  2 * N   |resrv|    L          |
+    | I | I |     | 2 | . |   |     |         |     |             |
+    | S | S |     | 6 | . |   |     |         |     |             |
+
+    A: Alternate setting for MEMC clock
+       0 = MEM clock frequency as specified in YB's table 3-7
+       1 = MEM clock frq = System Bus Frequency
+
+
+  CLKCFG
+    | 31------------------------------------------- | 3 | 2  | 1 | 0 |
+    | --------------------------------------------- | B | HT | F | T |
+
+    B = Fast-Bus Mode  0: System Bus is half of run-mode
+                      1: System Bus is equal to run-mode
+                      NOTE: only allowed when L <= 16
+
+    HT = Half-Turbo    0: core frequency = run or turbo, depending on T bit
+                      1: core frequency = turbo frequency / 2
+                      NOTE: only allowed when 2N = 6 or 2N = 8
+
+    F = Frequency change
+                      0: No frequency change is performed
+                      1: Do frequency-change
+
+    T = Turbo Mode     0: CPU operates at run Frequency
+                      1: CPU operates at Turbo Frequency (when n2 > 2)
+
+*/
+       /* Set the CLKCFG with B, T, and HT */
+       if (opt->b != -1 && opt->n != -1) {
+               f = 1;
+
+               /*When N2=2, Turbo Mode equals Run Mode, so it
+                  does not really matter if this is >2 or >=2
+                */
+               if (opt->n > 2) {
+                       turbo = 0x1;
+               }
+               opt->regs.clkcfg = (opt->b << 3) + (f << 1) + turbo;
+       } else {
+               f = 0x1;
+               opt->regs.clkcfg = (f << 1);
+       }
+
+       /*
+          What about when n2=0 ... it is not defined by the yellow
+          book
+        */
+       if (opt->n != -1) {
+               /* N2 is 4 bits, L is 5 bits */
+               opt->regs.cccr = ((opt->n & 0xF) << 7) + (opt->l & 0x1F);
+       }
+
+       if (opt->cccra > 0) {
+               /* Turn on the CCCR[A] bit */
+               opt->regs.cccr |= (1 << 25);
+       }
+
+       /* 13M Mode */
+       if (opt->l == 1) {
+       }
+
+       if ( (opt->l > 1) && (opt->cpll_enabled == 0) ) {
+                printk(KERN_WARNING
+                 "DPM: internal error if l>1 CPLL must be On\n");
+       }
+       if( (opt->cpll_enabled == 1) && (opt->ppll_enabled == 0) ){
+                printk(KERN_WARNING
+                "DPM: internal error CPLL=On PPLL=Off is NOT
supported in hardware\n");
+       }
+       if(opt->cpll_enabled == 0) {
+                opt->regs.cccr |= (CCCR_CPDIS_BIT_ON);
+       }
+       if(opt->ppll_enabled == 0) {
+                opt->regs.cccr |= (CCCR_PPDIS_BIT_ON);
+       }
+
+}
+
+/* This routine computes the "forward" frequency scaler flags
+ * for moving the system
+ * from the current operating point to the new operating point.  The resulting
+ * fscaler is applied to the registers of the new operating point.
+ */
+void compute_fscaler_flags(struct md_opt *cur, struct md_opt *new)
+{
+       int current_n, ccsr;
+
+       ccsr = CCSR;
+       current_n = (ccsr & CCCR_N_MASK) >> 7;
+       fscaler_flags = FSCALER_NOP;
+       /* If new CPU is 0, that means sleep, we do NOT switch PLLs
+          if going to sleep.
+        */
+       if (!new->cpu) {
+               if (new->sleep_mode == CPUMODE_DEEPSLEEP) {
+                       fscaler_flags |= FSCALER_DEEPSLEEP;
+               } else if (new->sleep_mode == CPUMODE_STANDBY) {
+                       fscaler_flags |= FSCALER_STANDBY;
+               } else {
+                       fscaler_flags |= FSCALER_SLEEP;
+               }
+       } else {
+
+               /*
+                * If exiting 13M mode, set the flag so we can do the extra
+                * work to get out before the frequency change
+                */
+               if( ((cur->cpll_enabled == 0) && (new->cpll_enabled ==1)) ||
+                       ((cur->ppll_enabled == 0) && (new->ppll_enabled ==1)) ){
+                       fscaler_flags |= FSCALER_XPLLON;
+               }
+
+       }
+
+
+       /* if CPU is *something*, it means we are not going to sleep */
+       if ((new->cpu) &&
+           /* And something has indeed changed */
+           ((new->regs.cccr != cur->regs.cccr) ||
+            (new->regs.clkcfg != cur->regs.clkcfg))) {
+
+               /* Find out if it is *just* a turbo bit change */
+               if ((cur->l == new->l) &&
+                   (cur->cccra == new->cccra) &&
+                   (cur->b == new->b) &&
+                   (cur->half_turbo == new->half_turbo)) {
+                       /*
+                        * If the real, current N is a turbo freq and
+                        * the new N is not a turbo freq, then set
+                        * TURBO_OFF and do not change N
+                        */
+                       if ((cur->n > 1) && (new->n == 2)) {
+                               fscaler_flags |= FSCALER_TURBO_OFF;
+                       }
+                       /*
+                        * Else if the current operating point's N is
+                        * not-turbo and the new N is the desired
+                        * destination N, then set TURBO_ON
+                        */
+                       else if ((cur->n == 2) && (new->n == current_n)) {
+                               /*
+                                * Desired N must be what is current
+                                * set in the CCCR/CCSR
+                                */
+                               fscaler_flags |= FSCALER_TURBO_ON;
+                       }
+                       /* Else, fall through to regular FCS     */
+               }
+               if (!(fscaler_flags & FSCALER_TURBO)) {
+                       /* It this is not a Turbo bit only change, it
+                          must be a regular FCS
+                        */
+                       fscaler_flags |= FSCALER_CPUFREQ;
+               }
+               loops_per_jiffy = new->lpj;
+       }
+
+       if (new->half_turbo != cur->half_turbo) {
+               loops_per_jiffy = new->lpj;
+
+               if (new->half_turbo)
+                       fscaler_flags |= FSCALER_HALFTURBO_ON;
+               else
+                       fscaler_flags |= FSCALER_HALFTURBO_OFF;
+       }
+
+       if (new->regs.voltage != cur->regs.voltage)
+               fscaler_flags |= FSCALER_VOLTAGE;
+
+}
+
+static int pxa27x_transition(struct oppoint *cur, struct oppoint *new)
+{
+       int rc = 0;
+       unsigned target_v;
+       struct md_opt *md_cur, *md_new;
+
+       pr_debug("%s: %s => %s\n", __FUNCTION__, cur->name, new->name);
+
+       md_cur = (struct md_opt *)cur->md_data;
+       md_new = (struct md_opt *)new->md_data;
+
+       /* fully define the new opt, if necessary, based on values
+          from the current opt
+        */
+       mainstone_fully_define_opt(cur, new);
+       target_v = md_new->v;
+
+       /* In accordance with Yellow Book section 3.7.6.3, "Coupling
+          Voltage Change with Frequency Change", always set the
+          voltage first (setting the FVC bit in the PCFR) and then do
+          the frequency change
+        */
+       rc = mainstone_fscale(cur, new);
+       if (rc == 0)
+               current_state = new;
+
+       udelay(new->latency);
+
+       return rc;
+}
+
+static int mainstone_fscale(struct oppoint *c, struct oppoint *n)
+{
+       struct md_opt *cur = (struct md_opt *)c->md_data;
+       struct md_opt *new = (struct md_opt *)n->md_data;
+
+       compute_fscaler_flags(cur, new);
+
+       mainstone_fscaler(&new->regs);
+
+}
+
+void mainstone_fully_define_opt(struct oppoint *c, struct oppoint *n)
+{
+       struct md_opt *cur = (struct md_opt *)c->md_data;
+       struct md_opt *new = (struct md_opt *)n->md_data;
+
+       if (new->v == -1)
+               new->v = cur->v;
+       if (new->l == -1)
+               new->l = cur->l;
+       if (new->n == -1)
+               new->n = cur->n;
+       if (new->b == -1)
+               new->b = cur->b;
+       if (new->half_turbo == -1)
+               new->half_turbo = cur->half_turbo;
+       if (new->cccra == -1)
+               new->cccra = cur->cccra;
+       if (new->cpll_enabled == -1)
+               new->cpll_enabled = cur->cpll_enabled;
+       if (new->ppll_enabled == -1)
+               new->ppll_enabled = cur->ppll_enabled;
+       if (new->sleep_mode == -1)
+               new->sleep_mode = cur->sleep_mode;
+
+#ifdef CONFIG_BULVERDE_B0
+       /* for "B0"-revision PLLs have the same value */
+       new->ppll_enabled = new->cpll_enabled;
+#endif
+       /* PXA27x manual ("Yellow book") 3.5.5 (Table 3-7) states that
+        * CPLL-"On" and PPLL-"Off"
+        * configuration is forbidden (all others seem to be OK for "B0")
+        * for "C0" boards we suppose that this configuration is also enabled.
+        * PXA27x manual ("Yellow book") also states at 3.5.7.1 (page 3-25)
+        * that "CCCR[PPDIS] and CCCR[CPDIS] must always be identical and
+        * changed together". "If PLLs are to be turned off using xPDIS then
+        * set xPDIS before frequency change and clear xPDIS after frequency
+        * change"
+        */
+
+       if (new->n > 2) {
+               new->turbo = 1;
+               /* turbo mode: 13K * L * (N/2)
+                  Shift at the end to divide N by 2 for Turbo mode or
+                  by 4 for Half-Turbo mode )
+                */
+               new->cpu = (13000 * new->l * new->n) >>
+                   ((new->half_turbo == 1) ? 2 : 1);
+       } else {
+               new->turbo = 0;
+               /* run mode */
+               new->cpu = 13000 * new->l;
+       }
+       /* lcd freq is derived from L */
+       calculate_lcd_freq(new);
+       calculate_reg_values(new);
+       /* We want to keep a baseline loops_per_jiffy/cpu-freq ratio
+          to work off of for future calculations, especially when
+          emerging from sleep when there is no current cpu frequency
+          to calculate from (because cpu-freq of 0 means sleep).
+        */
+       if (!saved_loops_per_jiffy) {
+               saved_loops_per_jiffy = loops_per_jiffy;
+               saved_cpu_freq = cur->cpu;
+       }
+       if (!saved_cpu_freq) {
+               saved_cpu_freq = c->frequency;
+       }
+       /*
+        * a dedicated method for updating jiffies when frequency is changed
+        */
+       if (new->cpu) {
+               /* Normal change (not sleep), just compute. Always use
+                  the "baseline" lpj and freq */
+               new->lpj = oppoint_compute_lpj(saved_loops_per_jiffy,
+                   saved_cpu_freq, new->cpu);
+       } else {
+               /* If sleeping, keep the old LPJ */
+               new->lpj = loops_per_jiffy;
+       }
+}
+
+static void xpll_on(struct oppoint_regs *regs, int fscaler_flags)
+{
+       int tmp_cccr, tmp_ccsr;
+       int new_cpllon=0, new_pllon=0, cur_cpllon=0;
+       int  cur_pllon=0, start_cpll=0, start_pll=0;
+
+       tmp_ccsr = CCSR;
+
+       if ((regs->cccr & CCCR_CPDIS_BIT_ON) == 0)
+               new_cpllon=1;
+       if ((regs->cccr & CCCR_PPDIS_BIT_ON) == 0)
+               new_pllon=1;
+       if (((tmp_ccsr >> 31) & 0x1) == 0)
+               cur_cpllon=1;
+       if (((tmp_ccsr >> 30) & 0x1) == 0)
+               cur_pllon=1;
+
+       if ((new_cpllon == 1) && (cur_cpllon == 0)) {
+               start_cpll=1;
+       }
+       if ((new_pllon == 1) && (cur_pllon == 0)) {
+               start_pll=1;
+       }
+
+       if (!(fscaler_flags & FSCALER_XPLLON)) {
+               return;
+       }
+       if ((start_cpll == 0) && (start_pll == 0)) {
+               return;
+       }
+       /* NOTE: the Yellow Book says that exiting 13M mode requires a
+          PLL relock, which takes at least 120uS, so the book suggests
+          the OS could use a timer to keep busy until it is time to
+          check the CCSR bits which must happen before changing the
+          frequency back.
+
+          For now, we'll just loop.
+        */
+
+       /* From Yellow Book, page 3-31, section 3.5.7.5 13M Mode
+
+          Exiting 13M Mode:
+
+          1. Remain in 13M mode, but early enable the PLL via
+          CCCR[CPDIS, PPDIS]=11, and CCCR[PLL_EARLY_EN]=1. Doing
+          so will allow the PLL to be started early.
+
+          2. Read CCCR and compare to make sure that the data was
+          correctly written.
+
+          3. Check to see if CCS[CPLOCK] and CCSR[PPLOCK] bits are
+          both set. Once these bits are both high, the PLLs are
+          locked and you may move on.
+
+          4. Note that the CPU is still in 13M mode, but the PLLs are
+          started.
+
+          5. Exit from 13M mode by writing CCCR[CPDIS, PPDIS]=00, but
+          maintain CCCR[PLL_EARLY_EN]=1. This bit will be cleared
+          by the imminent frequency change.
+        */
+
+       /* Step 1 */
+       tmp_cccr = CCCR;
+       if (start_cpll)
+               tmp_cccr |= CCCR_CPDIS_BIT_ON;
+       if (start_pll)
+               tmp_cccr |= CCCR_PPDIS_BIT_ON;
+       tmp_cccr |= CCCR_PLL_EARLY_EN_BIT_ON;
+
+       CCCR = tmp_cccr;
+
+       /* Step 2 */
+       tmp_cccr = CCCR;
+
+       if ((tmp_cccr & CCCR_PLL_EARLY_EN_BIT_ON) != CCCR_PLL_EARLY_EN_BIT_ON) {
+               printk(KERN_WARNING
+                      "DPM: Warning: PLL_EARLY_EN is NOT on\n");
+       }
+       if ((start_cpll==1) &&
+             ((tmp_cccr & CCCR_CPDIS_BIT_ON) != CCCR_CPDIS_BIT_ON)) {
+               printk(KERN_WARNING
+                      "DPM: Warning: CPDIS is NOT on\n");
+       }
+       if ((start_pll==1) &&
+             (tmp_cccr & CCCR_PPDIS_BIT_ON) != CCCR_PPDIS_BIT_ON) {
+               printk(KERN_WARNING
+                      "DPM: Warning: PPDIS is NOT on\n");
+       }
+
+       /* Step 3 */
+       {
+               /* Note: the point of this is to "wait" for the lock
+                  bits to be set; the Yellow Book says this may take
+                  a while, but observation indicates that it is
+                  instantaneous
+                */
+
+               long volatile int i = 0;
+
+               int cpll_complete=1;
+               int pll_complete=1;
+               if (start_cpll==1)
+                       cpll_complete=0;
+               if (start_pll==1)
+                       pll_complete=0;
+
+               /*loop  arbitrary big value to prevent  looping forever */
+               for (i = 0; i < 999999; i++) {
+                       tmp_ccsr = CCSR;
+
+                       if ((tmp_ccsr & CCSR_CPLL_LOCKED) == CCSR_CPLL_LOCKED) {
+                               /*CPLL locked*/
+                               cpll_complete=1;
+                       }
+                       if ((tmp_ccsr & CCSR_PPLL_LOCKED) == CCSR_PPLL_LOCKED) {
+                               /*PPLL locked*/
+                               pll_complete=1;
+                       }
+                       if ((cpll_complete == 1) && (pll_complete == 1)) {
+                               break;
+                       }
+               }
+       }
+
+       /* Step 4: NOP */
+
+       /* Step 5
+          Clear the PLL disable bits - do NOT do it here.
+        */
+
+       /* But leave EARLY_EN on; it will be cleared by the frequency change */
+       regs->cccr |= CCCR_PLL_EARLY_EN_BIT_ON;
+       /* Do not set it now
+          Step 6: Now go continue on with frequency change
+          We do this step later as if voltage is too low,
+          we must ensure that it rised up  before entereng to higher
+          freq mode or simultaniously
+        */
+}
+
+static void mainstone_fscaler(struct oppoint_regs *regs)
+{
+       unsigned int cccr, clkcfg = 0;
+       unsigned long s;
+
+       /* If no flags are set, don't waste time here, just return */
+       if (fscaler_flags == FSCALER_NOP)
+               return;
+
+       if (!(fscaler_flags & FSCALER_ANY_SLEEPMODE))
+               local_irq_save(s);
+
+       /* If exiting 13M mode (turn on  PLL(s) ), do some extra work
+          before changing the CPU frequency or voltage.
+          We may turn on a combination of PLLs supported by hardware
+          only. Otherwise xpll_on(...) hang the system.
+        */
+       if (fscaler_flags & FSCALER_XPLLON)
+               xpll_on(regs, fscaler_flags);
+
+       /* if not sleeping, and have a voltage change
+          note that SLEEPMODE will handle voltage itself
+        */
+       if (((fscaler_flags & FSCALER_ANY_SLEEPMODE) == 0) &&
+           (fscaler_flags & FSCALER_VOLTAGE)) {
+               if (fscaler_flags & FSCALER_CPUFREQ) {
+                       /* coupled voltage & freq change */
+                       mainstone_scale_voltage_coupled(regs);
+               } else {
+                       /* Scale CPU voltage un-coupled with freq */
+                       mainstone_scale_voltage(regs);
+               }
+       }
+
+       if (fscaler_flags & FSCALER_CPUFREQ)    /* Scale CPU freq */
+               mainstone_scale_cpufreq(regs);
+
+       if ((fscaler_flags & FSCALER_VOLTAGE) &&
+           (fscaler_flags & FSCALER_CPUFREQ))
+               PCFR &= ~PCFR_FVC;
+
+       if (fscaler_flags & FSCALER_TURBO) {
+
+               clkcfg = mainstone_read_clkcfg();
+
+               /* Section 3.5.7 of the Yellow Book says that the F
+                  bit will be left on after a FCS, so we need to
+                  explicitly clear it. But do not change the B bit
+                */
+               clkcfg &= ~(CLKCFG_F_BIT);
+
+               if (fscaler_flags & FSCALER_TURBO_ON) {
+                       clkcfg = clkcfg | (CLKCFG_T_BIT);
+               } else {
+                       clkcfg = clkcfg & ~(CLKCFG_T_BIT);
+               }
+
+               /* enable */
+               mainstone_set_freq(clkcfg);
+       }
+
+       if ((fscaler_flags & FSCALER_HALFTURBO_ON) ||
+           (fscaler_flags & FSCALER_HALFTURBO_OFF)) {
+               if ((fscaler_flags & FSCALER_CPUFREQ) ||
+                   (fscaler_flags & FSCALER_VOLTAGE)) {
+
+                       /*
+                          From the Yellow Book, p 3-106:
+
+                          "Any two writes to CLKCFG or PWRMODE
+                          registers must be separated by siz 13-MHz
+                          cycles.  This requirement is achieved by
+                          doing the write to the CLKCFG or POWERMODE
+                          reigster, performing a read of CCCR, and
+                          then comparing the value in the CLKCFG or
+                          POWERMODE register to the written value
+                          until it matches."
+
+                          Since the setting of half turbo is a
+                          separate write to CLKCFG, we need to adhere
+                          to this requirement.
+                        */
+                       cccr = CCCR;
+                       clkcfg = mainstone_read_clkcfg();
+                       while (clkcfg != regs->clkcfg)
+                               clkcfg = mainstone_read_clkcfg();
+               }
+
+               if (clkcfg == 0)
+                       clkcfg = regs->clkcfg;
+               /* Turn off f-bit.
+
+                  According to the Yellow Book, page 3-23, "If only
+                  HT is set, F is clear, and B is not altered, then
+                  the core PLL is not stopped."
+                */
+               clkcfg = clkcfg & ~(CLKCFG_F_BIT);
+               /* set half turbo bit */
+               if (fscaler_flags & FSCALER_HALFTURBO_ON) {
+                       clkcfg = clkcfg | (CLKCFG_HT_BIT);
+               } else {
+                       clkcfg = clkcfg & ~(CLKCFG_HT_BIT);
+               }
+
+               /* enable */
+               mainstone_set_freq(clkcfg);
+       }
+
+       /* Devices only need to scale on a core frequency
+          change. Half-Turbo changes are separate from the regular
+          frequency changes, so Half-Turbo changes do not need to
+          trigger a device recalculation.
+
+          NOTE: turbo-mode-only changes could someday also be
+          optimized like Half-Turbo (to not trigger a device
+          recalc).
+        */
+
+       if (fscaler_flags & FSCALER_ANY_SLEEPMODE) {
+               /* NOTE: voltage needs i2c, so be sure to change
+                  voltage BEFORE* calling device_suspend
+                */
+
+               if (fscaler_flags & FSCALER_VOLTAGE) {
+                       /* Scale CPU voltage un-coupled with freq */
+                       mainstone_scale_voltage(regs);
+               }
+
+               if (fscaler_flags & FSCALER_SLEEP) {
+                       pm_suspend(&sleep);
+               } else if (fscaler_flags & FSCALER_STANDBY) {
+                       pm_suspend(&standby);
+               } else if (fscaler_flags & FSCALER_DEEPSLEEP) {
+                       pm_suspend(&deepsleep);
+               }
+
+               /* Here when we wake up. */
+
+       } else {
+               local_irq_restore(s);
+       }
+}
+
+/*
+ * Fully determine the current machine-dependent operating point, and fill in a
+ * structure presented by the caller.
+ */
+
+void mainstone_get_current_info(void)
+{
+       unsigned int tmp_cccr;
+       unsigned int cpdis;
+       unsigned int ppdis;
+       struct md_opt *opt = (struct md_opt *)current_state->md_data;
+
+       /* You should read CCSR to see what's up...but there is no A
+          bit in the CCSR, so we'll grab it from the CCCR.
+        */
+       tmp_cccr = CCCR;
+       opt->cccra = (tmp_cccr >> 25) & 0x1;    /* cccr[A]: bit 25 */
+
+       /* NOTE: the current voltage is not obtained, but will be left
+          as 0 in the opt which will mean no voltage change at all
+        */
+
+       opt->regs.cccr = CCSR;
+
+       opt->l = opt->regs.cccr & CCCR_L_MASK;  /* Get L */
+       opt->n = (opt->regs.cccr & CCCR_N_MASK) >> 7;   /* Get 2N */
+
+       /* This should never really be less than 2 */
+       if (opt->n < 2) {
+               opt->n = 2;
+       }
+
+       opt->regs.clkcfg = mainstone_read_clkcfg();
+       opt->b = (opt->regs.clkcfg >> 3) & 0x1; /* Fast Bus (b): bit 3 */
+       opt->turbo = opt->regs.clkcfg & 0x1;    /* Turbo is bit 1 */
+       opt->half_turbo = (opt->regs.clkcfg >> 2) & 0x1;/* HalfTurbo: bit 2 */
+
+       calculate_lcd_freq(opt);
+
+       /* are any of the PLLs is on? */
+       cpdis = ((opt->regs.cccr >> 31) & 0x1);
+       ppdis = ((opt->regs.cccr >> 30) & 0x1);
+       /*
+        * Newer revisions still require that if CPLL is On
+        * then PPLL must also be On.
+        */
+       if ((cpdis == 0) && (ppdis != 0)) {
+               /*
+                * CPLL=On PPLL=Off is NOT supported with hardware.
+                * NOTE:"B0"-revision has even more restrictive requirments
+                * to PLLs
+                */
+               printk("OpPoint: cpdis and ppdis are not in sync!\n");
+       }
+
+       opt->cpll_enabled = (cpdis == 0);
+       opt->ppll_enabled = (ppdis == 0);
+
+       /* Shift 1 to divide by 2 (because opt->n is really 2*N */
+       if (opt->turbo) {
+               opt->cpu = (13000 * opt->l * opt->n) >> 1;
+       } else {
+               /*
+                * turbo bit is off, so skip N multiplier (no matter
+                * what N really is) and use Run frequency (13K * L)
+                */
+               opt->cpu = 13000 * opt->l;
+       }
+}
+
+static void oppoint_print_opt(struct oppoint *opt)
+{
+       struct md_opt *md_opt = (struct md_opt *)opt->md_data;
+
+       printk("OpPoint : Table of defined operating points:\n");
+       printk("\t%s freq %d volt %d latency %d\n", opt->name,
+            opt->frequency, opt->voltage, opt->latency);
+
+       printk("        Name  Vol   CPU    L    N    A    B   HT  PLL
CPLL Sleep LCD\n");
+
+       printk("%12s %5d%5d%5d%5d%5d%5d%5d%5d%5d%5d%5d\n",
+           opt->name, (md_opt->v), (md_opt->cpu / 1000), md_opt->l, md_opt->n,
+           md_opt->cccra, md_opt->b, md_opt->half_turbo, md_opt->cpll_enabled,
+           md_opt->ppll_enabled, md_opt->sleep_mode, (md_opt->lcd / 1000));
+       return ;
+}
+
+/* Crystal clock: 13MHz */
+#define BASE_CLK  13000000
+
+int __init oppoint_mainstone_init(void)
+{
+       unsigned int freq;
+       unsigned long ccsr;
+       unsigned int l;
+
+       printk("Mainstone OpPoint Power Management\n");
+
+       mainstone_clk_init();
+       mainstone_vcs_init();
+        ccsr = CCSR;
+        l  = ccsr & 0x1f;
+        freq  = l * BASE_CLK;
+
+       /*
+        * supported operating point sets.
+        * 104, 208, 312
+        * 208, 312, 416, 520
+        */
+       switch (freq) {
+           case 104000000: {
+               mainstone_setup_opt(&low, 104, &mhz104);
+               oppoint_print_opt(&low);
+               mainstone_setup_opt(&medium, 208, &mhz208);
+               oppoint_print_opt(&medium);
+               mainstone_setup_opt(&high, 312, &mhz312);
+               oppoint_print_opt(&high);
+               current_state = &medium;
+               break;
+           }
+           case 208000000: {
+               mainstone_setup_opt(&low, 208, &mhz208hi);
+               oppoint_print_opt(&low);
+               mainstone_setup_opt(&medium, 312, &mhz312hi);
+               oppoint_print_opt(&medium);
+               mainstone_setup_opt(&high, 416, &mhz416hi);
+               oppoint_print_opt(&high);
+               mainstone_setup_opt(&highest, 520, &mhz520hi);
+               oppoint_print_opt(&highest);
+               break;
+
+           }
+           default: {
+               printk("OpPoint: unknown frequency set %d\n", freq);
+               break;
+           }
+       }
+
+        if (lowest.frequency)
+               register_operating_point(&lowest);
+        if (low.frequency)
+                register_operating_point(&low);
+        if (mediumlow.frequency)
+                register_operating_point(&mediumlow);
+        if (medium.frequency)
+                register_operating_point(&medium);
+        if (mediumhigh.frequency)
+                register_operating_point(&mediumhigh);
+        if (high.frequency) {
+                register_operating_point(&high);
+               current_state = &high;
+        }
+        if (highest.frequency) {
+                register_operating_point(&highest);
+               current_state = &highest;
+        }
+       /*
+        * add sleep states
+        */
+       mainstone_setup_opt(&sleep, 0, &md_sleep);
+       register_operating_point(&sleep);
+       oppoint_print_opt(&sleep);
+       mainstone_setup_opt(&deepsleep, 0, &md_deepsleep);
+       register_operating_point(&deepsleep);
+       oppoint_print_opt(&deepsleep);
+       mainstone_setup_opt(&standby, 0, &md_standby);
+       register_operating_point(&standby);
+       oppoint_print_opt(&standby);
+
+       return 0;
+}
+
+void __exit oppoint_mainstone_exit(void) {
+       mainstone_freq_cleanup();
+       mainstone_voltage_cleanup();
+}
+
+__initcall(oppoint_mainstone_init);
+__exitcall(oppoint_mainstone_exit);
Index: linux-2.6.17/arch/arm/Kconfig
===================================================================
--- linux-2.6.17.orig/arch/arm/Kconfig
+++ linux-2.6.17/arch/arm/Kconfig
@@ -690,7 +690,7 @@ config XIP_PHYS_ADDR

 endmenu

-if (ARCH_SA1100 || ARCH_INTEGRATOR || ARCH_OMAP)
+if (ARCH_SA1100 || ARCH_INTEGRATOR || ARCH_OMAP || ARCH_PXA)

 menu "CPU Frequency scaling"



David
