Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132366AbRAXS2e>; Wed, 24 Jan 2001 13:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132131AbRAXS2Y>; Wed, 24 Jan 2001 13:28:24 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:18692 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S130902AbRAXS2D>; Wed, 24 Jan 2001 13:28:03 -0500
Date: Wed, 24 Jan 2001 21:21:04 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Peter Rival <frival@zk3.dec.com>, Richard Henderson <rth@twiddle.net>
Cc: Greg from Systems <chandler@d2.com>, linux-kernel@vger.kernel.org
Subject: Re: Big Bada Boom...
Message-ID: <20010124212104.A1294@jurassic.park.msu.ru>
In-Reply-To: <Pine.SGI.4.10.10101231316420.29904-100000@hell.d2.com> <3A6ED741.CACC619C@zk3.dec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A6ED741.CACC619C@zk3.dec.com>; from frival@zk3.dec.com on Wed, Jan 24, 2001 at 08:23:13AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 24, 2001 at 08:23:13AM -0500, Peter Rival wrote:
> Yeah, I've been bitten by this quite often.  Basically, just edit arch/alpha/kernel/Makefile and remove irq_pyxis.c from the obj-y
> line.  I'm not positive what systems require it exactly, but rawhide isn't one of them.  I have a totally separate patch from Andrea
> that suggests (to my mind) that it is required for: GENERIC, CIA, CABRIOLET, EV164, EB66P, LX164, PC164, MIATA, RUFFIAN and SX164.  Does
> someone want to verify that and then a quickie patch can be whipped up and sent in.

irq_pyxis.c is needed only for generic, miata, ruffian and sx164.
Here is also cabriolet IRQ fix and compile fix for 2.4.1-pre10.

Ivan.

--- 2.4.1p10/arch/alpha/kernel/Makefile	Sat Dec 30 01:07:19 2000
+++ linux/arch/alpha/kernel/Makefile	Wed Jan 24 20:50:57 2001
@@ -23,7 +23,7 @@ obj-y    := entry.o traps.o process.o os
 # FIXME!
 # These should be made conditional on the stuff that needs them!
 #
-obj-y	 += irq_i8259.o irq_srm.o irq_pyxis.o \
+obj-y	 += irq_i8259.o irq_srm.o \
 	    es1888.o smc37c669.o smc37c93x.o ns87312.o
 
 ifdef CONFIG_VGA_HOSE
@@ -43,7 +43,7 @@ obj-y 	 += core_apecs.o core_cia.o core_
 	    sys_jensen.o sys_miata.o sys_mikasa.o sys_nautilus.o sys_titan.o \
 	    sys_noritake.o sys_rawhide.o sys_ruffian.o sys_rx164.o \
 	    sys_sable.o sys_sio.o sys_sx164.o sys_takara.o sys_rx164.o \
-	    sys_wildfire.o core_wildfire.o
+	    sys_wildfire.o core_wildfire.o irq_pyxis.o
 
 else
 
@@ -93,6 +93,10 @@ endif
 obj-$(CONFIG_ALPHA_SX164) += sys_sx164.o
 obj-$(CONFIG_ALPHA_TAKARA) += sys_takara.o
 obj-$(CONFIG_ALPHA_WILDFIRE) += sys_wildfire.o
+
+ifneq ($(CONFIG_ALPHA_MIATA)$(CONFIG_ALPHA_RUFFIAN)$(CONFIG_ALPHA_SX164),)
+obj-y    += irq_pyxis.o
+endif
 
 endif # GENERIC
 
--- 2.4.1p10/arch/alpha/kernel/sys_cabriolet.c	Fri Oct 27 21:55:01 2000
+++ linux/arch/alpha/kernel/sys_cabriolet.c	Fri Dec 29 15:28:35 2000
@@ -42,7 +42,7 @@ static inline void
 cabriolet_update_irq_hw(unsigned int irq, unsigned long mask)
 {
 	int ofs = (irq - 16) / 8;
-	outb(mask >> (16 + ofs*3), 0x804 + ofs);
+	outb(mask >> (16 + ofs * 8), 0x804 + ofs);
 }
 
 static inline void
--- 2.4.1p10/arch/alpha/kernel/osf_sys.c	Mon Jan  8 18:05:38 2001
+++ linux/arch/alpha/kernel/osf_sys.c	Wed Jan 24 16:03:18 2001
@@ -906,7 +906,6 @@ extern int do_sys_settimeofday(struct ti
 extern int do_getitimer(int which, struct itimerval *value);
 extern int do_setitimer(int which, struct itimerval *, struct itimerval *);
 asmlinkage int sys_utimes(char *, struct timeval *);
-extern int sys_wait4(pid_t, int *, int, struct rusage *);
 extern int do_adjtimex(struct timex *);
 
 struct timeval32
--- 2.4.1p10/arch/alpha/kernel/signal.c	Sun Sep  3 22:48:33 2000
+++ linux/arch/alpha/kernel/signal.c	Wed Jan 24 16:05:14 2001
@@ -30,7 +30,6 @@
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
-asmlinkage int sys_wait4(int, int *, int, struct rusage *);
 asmlinkage void ret_from_sys_call(void);
 asmlinkage int do_signal(sigset_t *, struct pt_regs *,
 			 struct switch_stack *, unsigned long, unsigned long);
--- 2.4.1p10/include/asm-alpha/unistd.h	Mon Jan 22 19:47:59 2001
+++ linux/include/asm-alpha/unistd.h	Wed Jan 24 15:46:56 2001
@@ -572,7 +572,6 @@ static inline long sync(void)
 	return sys_sync();
 }
 
-extern long sys_wait4(int, int *, int, struct rusage *);
 static inline pid_t waitpid(int pid, int * wait_stat, int flags)
 {
 	return sys_wait4(pid, wait_stat, flags, NULL);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
