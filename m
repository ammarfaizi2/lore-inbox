Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbTHYNc7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 09:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbTHYNc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 09:32:58 -0400
Received: from web41602.mail.yahoo.com ([66.218.93.102]:62291 "HELO
	web41602.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261804AbTHYNbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 09:31:10 -0400
Message-ID: <20030825133108.34846.qmail@web41602.mail.yahoo.com>
Date: Mon, 25 Aug 2003 15:31:08 +0200 (CEST)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Long uptimes / 2.4.19-pre7 / procps-2.0.14
To: procps-list@redhat.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

one of my customers has a machine that has passed the 497 days uptime barrier
a week ago. It's nearly 507 now. I know there are security issues, but it's not
that much affected from where it is and how it's being used, but I'm planning
an upgrade anyway. Before upgrading, I wanted to check if there were errors
or unexpected behaviour due to such uptimes, and in fact I found a few bugs
in procps ; the original one is 2.0.7, but I upgraded it to 2.0.14.

The 2.0.7 did floating point exceptions in top and vmstat. After upgrade to
2.0.14, top behave correctly, but vmstat sends strange CPU usages :

# vmstat 1
   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 1  0  0     32 132612  43700  59212    0    0     6   384  471   470 26 74  0
 0  0  0     32 132616  43700  59212    0    0     0     0  264    85  0  0  0
 0  0  0     32 132616  43700  59212    0    0     0     0  480   122  0 100  0
 1  0  0     32 132616  43700  59212    0    0     0     0  465   133 50 50  0
 0  0  0     32 132616  43700  59212    0    0     0     8  380   113  0  0  0
 0  0  0     32 132616  43700  59212    0    0     0     0  345   102  0  0  0
 0  0  0     32 132616  43700  59212    0    0     0     0  646   193  0 100  0
 0  0  0     32 132616  43700  59212    0    0     0     0  316   107 100  0  0
 0  0  0     32 132616  43700  59212    0    0     0     0  437   154  0 100  0
 0  0  0     32 132616  43700  59212    0    0     0    16  172    50  0  0  0

The machine is really not loaded. It's used as a small HTTP proxy/load-balancer
which receives between 10 and 30 hits/s. Common usages are about 0.1% for the
user and 1% for the system, as reported by top, BTW :

# top
 08:34:14  up 506 days, 23:22,  1 user,  load average: 0.00, 0.01, 0.00
31 processes: 30 sleeping, 1 running, 0 zombie, 0 stopped
CPU states:   0.0% user   0.4% system   0.0% nice   0.0% iowait  99.6% idle
Mem:   255812k av,  123164k used,  132648k free,       0k shrd,   43700k buff
        65108k active,              45876k inactive
Swap:  263160k av,      32k used,  263128k free                   59108k cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
 3377 proxy     15   0  1488 1488   520 S     0.3  0.5 122:52   0 haproxy
    1 root       8   0   508  508   440 S     0.0  0.1   0:04   0 init-sysv

The kernel used was a home-made 2.4.18-wt4, derived mainly from 2.4.19-pre7,
-aa VM, Andre Hedrick's IDE patches (now in mainline), and preempt patches.

I'm just wondering if it's vmstat reporting wrong values or the kernel (or both).
I can still wait several days before upgrading (or even rebooting), so if there
are any suggested fixes to try, I'm OK to give them their chance, provided that
they only affect user-space in a somewhat non-risky way (ie: no module loading
nor hot-kernel patching, nor glibc upgrades). Idem if some of you have ideas of
areas to look at or values to collect just for further reference.

Here are some more info :
# uptime
  7:40am  up 506 days, 15:41,  1 user,  load average: 0.07, 0.02, 0.00
# cat /proc/uptime
43774924.97 43727774.11
# uname -a
Linux proxy 2.4.18-wt4 #1 Mon Apr 1 14:35:08 CEST 2002 i686 unknown
# glibc version = 2.2.4
# distro = formilux 0.1.7
# ps aux
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.1  1252  508 ?        S     2002   0:04 init [4]
root         3  0.0  0.0     0    0 ?        SW    2002   0:00 [keventd]
root         4  0.0  0.0     0    0 ?        SWN   2002   0:24 [ksoftirqd_CPU0]
root         5  0.0  0.0     0    0 ?        SW    2002   0:00 [kswapd]
root         6  0.0  0.0     0    0 ?        SW    2002   0:00 [bdflush]
root         7  0.0  0.0     0    0 ?        SW    2002   0:00 [kupdated]
root         8  0.0  0.0     0    0 ?        SW<   2002   0:00 [mdrecoveryd]
root         9  0.0  0.0     0    0 ?        SW    2002   0:24 [kjournald]
root        24  0.0  0.0     0    0 ?        SW    2002   0:00 [kjournald]
root        25  0.0  0.0     0    0 ?        SW    2002   1:18 [kjournald]
root        43  0.0  0.2  1292  572 ?        S     2002   0:00 crond
root       143  0.0  0.2  1304  628 ?        S     2002  29:42 syslogd
root       145  0.0  0.5  2092 1344 ?        S     2002   0:00 klogd
root       166  0.0  0.1  1280  472 ?        S     2002   0:00 gpm
root       186  0.0  0.1  1232  444 tty3     S     2002   0:00 /sbin/agetty
root       187  0.0  0.1  1232  444 tty4     S     2002   0:00 /sbin/agetty
root       188  0.0  0.1  1232  444 tty5     S     2002   0:00 /sbin/agetty
root       193  0.0  0.1  1232  444 tty6     S     2002   0:00 /sbin/agetty
root       194  0.0  0.1  1232  444 tty7     S     2002   0:00 /sbin/agetty
root      1460  0.0  0.1  1232  444 tty2     S     2002   0:00 /sbin/agetty
root      2966  0.0  0.6  1648 1640 ?        SL    2002   0:00 /usr/sbin/ntpd
proxy     3377  0.1  0.5  2228 1488 ?        S    Jun03 122:46 /usr/sbin/haproxy
root     19487  0.0  0.1  1232  444 tty1     S    Aug13   0:00 /sbin/agetty
root     12881  0.0  0.1  1232  444 ttyS0    S    Aug15   0:00 /sbin/agetty
root      5120  0.0  0.4  2324 1216 pts/0    R    Aug15   0:00 -zsh
root      5125  0.0  0.2  2468  740 pts/0    R    Aug15   0:00 ps aux

Interestingly, there was a warning (and only one) in the system logs about
the clock :
  Jul  1 01:59:59 proxy kernel: Clock: inserting leap second 23:59:60 UTC

BTW, the hardware is a Compaq tasksmart / P3-933 / scsi / Serverworks chipset /
eepro100 module.

Cheers,
Willy


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
