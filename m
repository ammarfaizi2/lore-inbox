Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbWBPVrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWBPVrD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 16:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbWBPVrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 16:47:00 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:8045 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932359AbWBPVrA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 16:47:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=c+CkiqKEedSP4SklItKXpCh7+LlpphC1p1oiswgxuLDainQ9ZwU1PF1CpeKUqwwrgU/YmsEhWt/zIMFlcbOesamoIFPpVtjks3eZUvzkxWIRPuXWfsMIuDLYS7JJjHU7pBtABbAB2RWvSRMrccTTHKjtoV1biM/r70AwDsOESwE=
Message-ID: <9a8748490602161346x6e2802e8r4edf7dcbdafa5e17@mail.gmail.com>
Date: Thu, 16 Feb 2006 22:46:59 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Wrong number of core_siblings in sysfs for Athlon64 X2
Cc: Andi Kleen <ak@suse.de>, Greg Kroah-Hartman <gregkh@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an AMD Athlon64 X2 4400+ CPU (dual core, not SMT capable, so
two cores and two threads) - running a 32bit kernel.

Linux dragon 2.6.16-rc3-git7 #4 SMP PREEMPT Thu Feb 16 22:14:55 CET
2006 i686 athlon-4 i386 GNU/Linux

I just noticed that the number of core siblings reported through sysfs
is wrong. The number of thread siblings is correct and so is the info
reported via /proc/cpuinfo - only sysfs seems to get it wrong.

juhl@dragon:~$ cat /sys/devices/system/cpu/cpu1/topology/thread_siblings
2
juhl@dragon:~$ cat /sys/devices/system/cpu/cpu1/topology/core_siblings
3

two thread siblings makes perfect sense, but 3 core siblings?
Did my cores start to reproduce? - I know CPU's get hot, but I didn't
know that was the reason ;-)

Proc nicely reports 2 cores with same physical id and 2 siblings :

juhl@dragon:~$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
stepping        : 2
cpu MHz         : 2200.724
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
lm 3dnowext 3dnow pni lahf_lm cmp_legacy ts fid vid ttp
bogomips        : 4405.02

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
stepping        : 2
cpu MHz         : 2200.724
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
lm 3dnowext 3dnow pni lahf_lm cmp_legacy ts fid vid ttp
bogomips        : 4399.55


I tried adding some printk's to arch/i386/kernel/smpboot.c to see how
cpu_core_map got initialized, but couldn't spot any errors.

In set_cpu_sibling_map() there's a loop that runs for_each_cpu_mask(i,
cpu_sibling_setup_map) and does
                        cpu_set(i, cpu_core_map[cpu]);
                        cpu_set(cpu, cpu_core_map[i]);
I tried adding printk(KERN_WARNING "DEBUG: i = %d, cpu = %d\n", i, cpu);
just before those cpuset() calls, and that prints out
    DEBUG: i = 0, cpu = 0
    DEBUG: i = 0, cpu = 1
    DEBUG: i = 1, cpu = 1
So we'll set bits 0 & 1 for each of the two cores in cpu_core_map[] ,
which looks sane to me.

So where does the extra core sibling come from that's reported via sysfs?

As far as I can tell, the
    #define topology_core_siblings(cpu)             (cpu_core_map[cpu])
in include/asm-i386/topology.h , will cause this bit of code :

#define define_siblings_show_func(name)                                 \
static ssize_t show_##name(struct sys_device *dev, char *buf)           \
{                                                                       \
        ssize_t len = -1;                                               \
        unsigned int cpu = dev->id;                                     \
        len = cpumask_scnprintf(buf, NR_CPUS+1, topology_##name(cpu));  \
        return (len + sprintf(buf + len, "\n"));                        \
}
...
#ifdef topology_core_siblings
define_siblings_show_func(core_siblings);
...

in drivers/base/topology.c to print out the nr of core siblings based
on what's in cpu_core_map - which as far as I can tell is OK.

Obviously something is wrong, but I just can't seem to spot it.  Any clues?


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
