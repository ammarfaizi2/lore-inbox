Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261338AbSIWTLH>; Mon, 23 Sep 2002 15:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261332AbSIWTJx>; Mon, 23 Sep 2002 15:09:53 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27041 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261418AbSIWSmp>;
	Mon, 23 Sep 2002 14:42:45 -0400
To: Ian Carr-de Avelon <avelon@emit.pl>
Cc: linux-kernel@vger.kernel.org
From: bonganilinux@mweb.co.za
Subject: Re: 2.4.20-pre7 i486
Date: Mon, 23 Sep 2002 14:47:03 GMT
X-Posting-IP: 196.34.86.10 via 172.24.158.16
X-Mailer: Endymion MailMan  
Message-Id: <E17tUK2-0003v5-00@laibach.mweb.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
> /usr/src/linux/include/linux/kernel_stat.h: In function `kstat_irqs':
> /usr/src/linux/include/linux/kernel_stat.h:57: `smp_num_cpus' undeclared (first
> use in this function)
> /usr/src/linux/include/linux/kernel_stat.h:57: (Each undeclared identifier is reported
only once
> /usr/src/linux/include/linux/kernel_stat.h:57: for each function it appears in.)make[2]:
*** [ksyms.o] Error 1
> make[2]: Leaving directory `/usr/src/linux/kernel'
> make[1]: *** [first_rule] Error 2
> make[1]: Leaving directory `/usr/src/linux/kernel'
> make: *** [_dir_kernel] Error 2

Strange that this has not being noticed before 2.4 define kstat_irqs as

#if defined (__hppa__) 
/*
 * Number of interrupts per specific IRQ source, since bootup
 */
static inline int kstat_irqs (int irq)
{
        return kstat.irqs[IRQ_REGION(irq)][IRQ_OFFSET(irq)];
}
#elif !defined(CONFIG_ARCH_S390)
/*
 * Number of interrupts per specific IRQ source, since bootup
 */
extern inline int kstat_irqs (int irq)
{
        int i, sum=0;

        for (i = 0 ; i < smp_num_cpus ; i++)
                sum += kstat.irqs[cpu_logical_map(i)][irq];

        return sum;
}
#endif

But smp_num_cpus is only defined for SMP kernels

on the other hand 2.5 defines it as

#if !defined(CONFIG_ARCH_S390)
/*
 * Number of interrupts per specific IRQ source, since bootup
 */
static inline int kstat_irqs (int irq)
{
        int i, sum=0;

        for (i = 0 ; i < NR_CPUS ; i++)
                sum += kstat.irqs[i][irq];

        return sum;
}
#endif

which seems correct cause NR_CPUS is defined as 1 for UP

is this a correct patch?

diff -uNr include/linux/kernel_stat.h~ include/linux/kernel_stat.h 
--- include/linux/kernel_stat.h~	2002-09-23 16:16:45.000000000 +0200
+++ include/linux/kernel_stat.h	2002-09-23 16:42:42.000000000 +0200
@@ -54,7 +54,7 @@
 {
 	int i, sum=0;
 
-	for (i = 0 ; i < smp_num_cpus ; i++)
+	for (i = 0 ; i < NR_CPUS ; i++)
 		sum += kstat.irqs[cpu_logical_map(i)][irq];
 
 	return sum;


---------------------------------------------
This message was sent using M-Web Airmail.
JUST LIKE THAT
Are you ready for 10-digit dialling?
To find out how this will affect your Internet connection go to www.mweb.co.za/ten
http://airmail.mweb.co.za/


