Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314075AbSDVHJv>; Mon, 22 Apr 2002 03:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314078AbSDVHJu>; Mon, 22 Apr 2002 03:09:50 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:53508 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S314075AbSDVHJt>; Mon, 22 Apr 2002 03:09:49 -0400
Message-Id: <200204220707.g3M77EX10483@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: /proc/stat weirdness
Date: Mon, 22 Apr 2002 10:10:25 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33.0204220216520.32680-100000@coffee.psychology.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 April 2002 04:18, Mark Hahn wrote:
> why not figure out if theres a code-based reason?
> just add some code in the kernel to check for the case,
> and dump some extra data.

Hehe. I caught it (imho, not tested).
jiffies is saved to local variable before user,nice,system is calculated,
what if delta(user+nice+system) was == delta(jiffies)
[i.e. no idle ticks since last readout by e.g. top]
and a jiffy just ended and got accounted into one of user,nice,system?
We'll get delta(user+nice+system) > delta(jiffies),
delta(idle)=delta(jiffies)-delta(user+nice+system) - negative!

File: proc_misc.c
....
static int kstat_read_proc(char *page, char **start, off_t off,
                                 int count, int *eof, void *data)
{
        int i, len;
        extern unsigned long total_forks;
        unsigned long jif = jiffies; <*********** jiffies saved
        unsigned int sum = 0, user = 0, nice = 0, system = 0;
        int major, disk;

        for (i = 0 ; i < smp_num_cpus; i++) {
                int cpu = cpu_logical_map(i), j;

                user += kstat.per_cpu_user[cpu]; <***
                nice += kstat.per_cpu_nice[cpu]; <*** accounting
                system += kstat.per_cpu_system[cpu]; <***
#if !defined(CONFIG_ARCH_S390)
                for (j = 0 ; j < NR_IRQS ; j++)
                        sum += kstat.irqs[cpu][j];
#endif
        }

        len = sprintf(page, "cpu  %u %u %u %lu\n", user, nice, system,
                      jif * smp_num_cpus - (user + nice + system));
--
vda
