Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266335AbSKOOP4>; Fri, 15 Nov 2002 09:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266347AbSKOOP4>; Fri, 15 Nov 2002 09:15:56 -0500
Received: from pD9E235A7.dip.t-dialin.net ([217.226.53.167]:19584 "EHLO
	darkside.22.kls.lan") by vger.kernel.org with ESMTP
	id <S266335AbSKOOPx>; Fri, 15 Nov 2002 09:15:53 -0500
Date: Fri, 15 Nov 2002 15:22:44 +0100
From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
To: linux-kernel@vger.kernel.org
Cc: Elrond@Wunder-Nett.org
Subject: /proc/stat interface and 32bit jiffies / kernel_stat
Message-ID: <20021115142244.GG5957@darkside.ddts.net>
Mail-Followup-To: Mario 'BitKoenig' Holbe <Mario.Holbe@RZ.TU-Ilmenau.DE>,
	linux-kernel@vger.kernel.org, Elrond@Wunder-Nett.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

my name is Mario Holbe.
Among others, I'm running a 2-CPU i386 system with a current
uptime of 348 days.

Since around 250 days uptime, we recognize kernel statistics
overflows, which result in serveral problems in HZ calculations
in the procps utilities:

$ uptime
Unknown HZ value! (28) Assume 0.
 14:49:20 up 348 days, 33 min, ...
$ cat /proc/stat
cpu  259658341 5066163 336423925 1117681229
cpu0 129832988 2535697 168074057 2706455735
cpu1 129825353 2530466 168349868 2706192790

As you can see, the 'unused jiffies' counter in the cpu
summary flows over, since 2706455735 + 2706192790 > 2^32.

Besides the general problem, that jiffies and kernel_stat
components are 32bit on i386 platforms:

        sched.h:extern unsigned long volatile jiffies;

  kernel_stat.h:struct kernel_stat {
  kernel_stat.h:	unsigned int per_cpu_user[NR_CPUS],
  kernel_stat.h:	per_cpu_nice[NR_CPUS],
  kernel_stat.h:	per_cpu_system[NR_CPUS];

... and therefor flow over after around 500 days, on SMP
systems the summary calculations in the proc-fs:

    proc_misc.c:	unsigned int sum = 0, user = 0, nice = 0, system = 0;

... already flow over after around 500 / NR_CPUS days,
this means, on a 2-CPU system after around 250 days, on
a 4-CPU system after around 125 days and so on.
[Yes, I know, it's some 2^(32 - round_up(log2(NR_CPUS)))
calculation in real :)]

Resulting in - at least - permanent warnings in procps
utilities.

Since it should not be a big problem to fix this, to
at least reduce the problem back to the 500 days
jiffies-overflow problem, I'd suggest to do so.

No need to mention, that 64bit jiffies and statistics on
all platforms at all would be great :)
Yes, I know the performance implications resulting in this
for 32bit platforms.

Btw... Could anybody please explain me the problems to
expect while a jiffies overflow? Would a kernel possibly
survive this at all and if, what's the chance to? :)


PS: Please CC: me in replies, because I'm not on the list.


regards,
   Mario
-- 
We are the Bore. Resistance is futile. You will be bored.
