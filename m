Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314456AbSDVTUR>; Mon, 22 Apr 2002 15:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314458AbSDVTUO>; Mon, 22 Apr 2002 15:20:14 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:55820 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S314456AbSDVTUH>; Mon, 22 Apr 2002 15:20:07 -0400
Message-Id: <200204221917.g3MJHOX12519@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: user/system/nice accounting (SMP): need help understanding the code
Date: Mon, 22 Apr 2002 22:19:49 -0200
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L2.0204220935500.507-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 April 2002 14:40, Randy.Dunlap wrote:
> On Mon, 22 Apr 2002, Denis Vlasenko wrote:
> | As you see below, in SMP case update_one_process() is not called
> | in do_timer().
> | OTOH, global grep over entire tree (*.[chsS]) for 'per_cpu_utime'
> | and 'per_cpu_user' did not turn out SMP accounting code.
> | Or maybe I am stupid.
> |
> | Anybody with cluebat?
>
> Sure... ;)
>
> For CONFIG_SMP, each arch/cpu/kernel/*.c calls update_process_times().

Ahh, thanks Randy!

Why I asked? Look at this script:

#!/bin/sh
prev=0
while true; do cat /proc/stat; done | \
grep -F 'cpu  ' | \
cut -d ' ' -f 6 | \
while read next; do
    echo -n .
    diff=$(($next-$prev))
    if test $diff -lt 0; then
        echo "$prev -> $next"
    fi
    prev=$next
done

It catches events when cpu idle counter in /proc/stat goes _backward_.
Typical output is:
.......2099328 -> 2099327
..............................................2099362 -> 2099361
........................................2099391 -> 2099390
............2099401 -> 2099400
.......2099403 -> 2099402
......2099404 -> 2099403
.......2099408 -> 2099407
.......2099413 -> 2099412
..........................2099426 -> 2099425
....................2099437 -> 2099436
.............2099444 -> 2099443
....................2099456 -> 2099455
..............2099464 -> 2099463
....................2099475 -> 2099474
......2099477 -> 2099476
.......2099482 -> 2099481

I hoped this is a race between accounting from timer int and
/proc/stat generation in fs/proc/proc_misc.c
(and there *is* a race but window is tiny)
(patch below, comments welcome). It does not help.

Then I realized I run SMP kernel and accounting isn't
happening in timer int. Will verify this tomorrow,
need to think more about it...
--
vda

# diff -u -8 proc_misc.c.orig proc_misc.c
--- proc_misc.c.orig    Wed Nov 21 03:29:09 2001
+++ proc_misc.c Mon Apr 22 09:07:32 2002
@@ -235,32 +235,33 @@
 };
 #endif

 static int kstat_read_proc(char *page, char **start, off_t off,
                                 int count, int *eof, void *data)
 {
        int i, len;
        extern unsigned long total_forks;
-       unsigned long jif = jiffies;
+       unsigned long jif; /* vda = jiffies; */
        unsigned int sum = 0, user = 0, nice = 0, system = 0;
        int major, disk;

        for (i = 0 ; i < smp_num_cpus; i++) {
                int cpu = cpu_logical_map(i), j;

                user += kstat.per_cpu_user[cpu];
                nice += kstat.per_cpu_nice[cpu];
                system += kstat.per_cpu_system[cpu];
 #if !defined(CONFIG_ARCH_S390)
                for (j = 0 ; j < NR_IRQS ; j++)
                        sum += kstat.irqs[cpu][j];
 #endif
        }

+       jif = jiffies; /* vda */
        len = sprintf(page, "cpu  %u %u %u %lu\n", user, nice, system,
                      jif * smp_num_cpus - (user + nice + system));
        for (i = 0 ; i < smp_num_cpus; i++)
                len += sprintf(page + len, "cpu%d %u %u %u %lu\n",
                        i,
                        kstat.per_cpu_user[cpu_logical_map(i)],
                        kstat.per_cpu_nice[cpu_logical_map(i)],
                        kstat.per_cpu_system[cpu_logical_map(i)],
