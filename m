Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263972AbUFKOIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263972AbUFKOIp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 10:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbUFKOIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 10:08:45 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:12810 "EHLO
	zircon.austin.ibm.com") by vger.kernel.org with ESMTP
	id S263972AbUFKOIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 10:08:23 -0400
Subject: Re: [PATCH][RFC] Spinlock-timeout
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>
In-Reply-To: <1086560618.10538.32.camel@gaston>
References: <1086467486.20906.59.camel@dhcp-client215.upt.austin.ibm.com>
	 <1086560618.10538.32.camel@gaston>
Content-Type: multipart/mixed; boundary="=-pj0Xvjy+uCR9YInBA2at"
Message-Id: <1086962902.3476.58.camel@dyn95394175.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 11 Jun 2004 09:08:22 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pj0Xvjy+uCR9YInBA2at
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2004-06-06 at 17:23, Benjamin Herrenschmidt wrote:
> On Sat, 2004-06-05 at 15:31, Jake Moilanen wrote:
> > Here's a patch that will BUG() when a spinlock is held for longer then X
> > seconds.  It is useful for catching deadlocks since not all archs have a
> > NMI watchdog.  
> > 
> > It is also helpful to find locks that are held too long.
> > 
> > Please send comments.
> 
> It would be better to use the timebase on CPUs that have one, no ? Or
> you'll miss cases where either irqs are disabled or you are on a code
> path issued by the timer interrupt, and thus jiffies isn't updated

Here is the ppc64 add-on for the HAVE_ARCH_GET_TB.

Thanks,
Jake


--=-pj0Xvjy+uCR9YInBA2at
Content-Disposition: attachment; filename=spinlock-timeout-2.6-v2-ppc64.patch
Content-Type: text/x-patch; name=spinlock-timeout-2.6-v2-ppc64.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

===== arch/ppc64/kernel/chrp_setup.c 1.47 vs edited =====
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_chrp_setup.c-1.47_T8bKaF	2004-04-27 05:07:31 +00:00
--- arch/ppc64/kernel/chrp_setup.c	2004-06-09 16:38:23 +00:00
*************** chrp_progress(char *s, unsigned short he
*** 405,414 ****
  
  extern void setup_default_decr(void);
  
- /* Some sane defaults: 125 MHz timebase, 1GHz processor */
- #define DEFAULT_TB_FREQ		125000000UL
- #define DEFAULT_PROC_FREQ	(DEFAULT_TB_FREQ * 8)
- 
  void __init pSeries_calibrate_decr(void)
  {
  	struct device_node *cpu;
--- 405,410 ----
===== arch/ppc64/kernel/time.c 1.30 vs edited =====
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_time.c-1.30_TupeZw	2004-05-31 17:41:03 +00:00
--- arch/ppc64/kernel/time.c	2004-06-09 16:38:24 +00:00
*************** static unsigned long first_settimeofday 
*** 81,87 ****
  
  #define XSEC_PER_SEC (1024*1024)
  
! unsigned long tb_ticks_per_jiffy;
  unsigned long tb_ticks_per_usec;
  unsigned long tb_ticks_per_sec;
  unsigned long next_xtime_sync_tb;
--- 81,87 ----
  
  #define XSEC_PER_SEC (1024*1024)
  
! unsigned long tb_ticks_per_jiffy = DEFAULT_TB_FREQ / HZ;
  unsigned long tb_ticks_per_usec;
  unsigned long tb_ticks_per_sec;
  unsigned long next_xtime_sync_tb;
===== include/asm-ppc64/eeh.h 1.10 vs edited =====
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_eeh.h-1.10_XhZlsA	2004-06-01 09:27:13 +00:00
--- include/asm-ppc64/eeh.h	2004-06-09 16:38:28 +00:00
***************
*** 24,29 ****
--- 24,30 ----
  #include <linux/init.h>
  
  struct pci_dev;
+ struct device_node;
  
  /* I/O addresses are converted to EEH "tokens" such that a driver will cause
   * a bad page fault if the address is used directly (i.e. these addresses are
===== include/asm-ppc64/processor.h 1.45 vs edited =====
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_processor.h-1.45_nCcpY2	2004-06-01 09:27:47 +00:00
--- include/asm-ppc64/processor.h	2004-06-09 16:38:28 +00:00
*************** GLUE(.,name):
*** 440,445 ****
--- 440,448 ----
  
  #endif /* __ASSEMBLY__ */
  
+ /* Some sane defaults: 125 MHz timebase, 1GHz processor */
+ #define DEFAULT_TB_FREQ		125000000UL
+ #define DEFAULT_PROC_FREQ	(DEFAULT_TB_FREQ * 8)
  
  /* Macros for setting and retrieving special purpose registers */
  
===== include/asm-ppc64/time.h 1.7 vs edited =====
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_time.h-1.7_ZyJHwv	2002-06-10 02:37:26 +00:00
--- include/asm-ppc64/time.h	2004-06-09 16:38:28 +00:00
***************
*** 20,26 ****
--- 20,30 ----
  
  #include <asm/processor.h>
  #include <asm/paca.h>
+ #ifdef CONFIG_PPC_ISERIES
  #include <asm/iSeries/HvCall.h>
+ #endif
+ 
+ #define HAVE_ARCH_GET_TB
  
  /* time.c */
  extern unsigned long tb_ticks_per_jiffy;

--=-pj0Xvjy+uCR9YInBA2at--

