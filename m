Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264536AbTEPSZh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 14:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264537AbTEPSZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 14:25:37 -0400
Received: from netmail02.services.quay.plus.net ([212.159.14.221]:52922 "HELO
	netmail02.services.quay.plus.net") by vger.kernel.org with SMTP
	id S264536AbTEPSZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 14:25:35 -0400
Message-ID: <002c01c31bcd$45a73ee0$0200a8c0@libra>
From: "Al Sutton" <al.sutton@alsutton.com>
To: <linux-kernel@vger.kernel.org>
Subject: Is there a memory leak in the 2.4 kernel series?
Date: Fri, 16 May 2003 18:04:54 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

I have a number of machines which I have to administer, all of which are
currently running a base of RedHat Linux 7.2 which a run a mixture of 2.4.20
kernels compiled on the machine from the source, or RedHats latest 2.4.18 ot
2.4.20 rpms, all of them have varying harward (from Dell PowerEdge 1650's,
to hand build systems based around SiS's Chipsets) all of which exhibit
symptoms which I beleive could be a kernel memory leak.

As an example, I have a system which has 256Mb of Ram running a
compiled-from-source 2.4.20 kernel, and normally runs apache httpd, tomcat,
and postgres. After 2 months of running I shut down all applications and the
output of free showed 200Mb+ in use, 20MB in swap, and approx 5Mb in
buffers. After rebooting the machine and restarting all the apps it showed
80Mb used, 0MB swap, 5MB of buffers, which seemed odd.

As a second example I have a Poweredge 350 which does little more than using
ip tables as a firewall and runs snort and ssh, which after 127 days of
uptime  the free output looks like this;

             total       used       free     shared    buffers     cached
Mem:        126104     123748       2356          0      16028      86604
-/+ buffers/cache:      21116     104988
Swap:       265064       2780     262284

and ps -vax looks like this;

PID TTY      STAT   TIME  MAJFL   TRS   DRS  RSS %MEM COMMAND
    1 ?        S      0:06    122    23  1392  460  0.3 init [3]
    2 ?        SW     0:00      0     0     0    0  0.0 [keventd]
    3 ?        SW     0:00      0     0     0    0  0.0 [kapmd]
    4 ?        SWN    0:00      0     0     0    0  0.0 [ksoftirqd_CPU0]
    5 ?        SW     0:18      0     0     0    0  0.0 [kswapd]
    6 ?        SW     0:00      0     0     0    0  0.0 [bdflush]
    7 ?        SW     0:00      0     0     0    0  0.0 [kupdated]
    8 ?        SW     0:00      0     0     0    0  0.0 [mdrecoveryd]
   12 ?        SW     1:52      0     0     0    0  0.0 [kjournald]
   87 ?        SW     0:00      0     0     0    0  0.0 [khubd]
  678 ?        S      0:48    117    23  1452  568  0.4 syslogd -m 0
  683 ?        S      0:32     38    18  2021  496  0.3 klogd -2
  795 ?        S      0:00     23    13  1386  456  0.3 /usr/sbin/apmd -p
10 -w
  828 ?        S      0:05     57    18  1573  596  0.4 crond
  847 ?        S      0:00     17    12  1435  480  0.3 /usr/sbin/atd
  854 ?        S      1:46     31   714  1729  784  0.6 /usr/local/sbin/sshd
  860 ?        SL     0:02    336   174  1637 1804  1.4 /usr/local/bin/ntpd
  865 tty1     S      0:00    104     6  1381  372  0.2 /sbin/mingetty tty1
  866 tty2     S      0:00    104     6  1381  372  0.2 /sbin/mingetty tty2
  867 tty3     S      0:00    104     6  1381  372  0.2 /sbin/mingetty tty3
  868 tty4     S      0:00    104     6  1381  372  0.2 /sbin/mingetty tty4
  869 tty5     S      0:00    104     6  1381  372  0.2 /sbin/mingetty tty5
  870 tty6     S      0:00    104     6  1381  372  0.2 /sbin/mingetty tty6
 2284 ?        S     52:47    504   313  9678 8016  6.3
/usr/local/bin/snort -c
15194 ?        S      0:00     10   460  2947 1108  0.8 sendmail: accepting
conn
21933 ?        S      0:00    166   714  5209 1520  1.2 /usr/local/sbin/sshd
21935 ?        S      0:00     53   714  5225 1740  1.3 /usr/local/sbin/sshd
21936 pts/0    S      0:00    275   484  2027 1328  1.0 -bash
21976 pts/0    S      0:00    257   673  1786 1168  0.9 ssh
another.machine.name
22514 ?        S      0:00    166   714  5209 1520  1.2 /usr/local/sbin/sshd
22516 ?        S      0:00     53   714  5225 1732  1.3 /usr/local/sbin/sshd
22517 pts/1    S      0:00    276   484  2063 1368  1.0 -bash
22635 ?        S      0:00    166   714  5209 1520  1.2 /usr/local/sbin/sshd
22637 ?        S      0:00     53   714  5225 1732  1.3 /usr/local/sbin/sshd
22638 pts/2    S      0:00    276   484  2063 1368  1.0 -bash
22686 pts/2    R      0:00    161    59  2572  684  0.5 ps -vax

which, when you add up the memory output from ps -vax does not appear to
tally with the memory usage reported by free.

Out of the 20ish machines I'm running on the various kernels all seem to
exhibit the behaviour of  increasing memory usage over time that can not be
cured by shutting down the applications on the system.

Does anyone have any hints/pointers as to how I can investigate this further
to see what may be causing the problem?

Thanks,

Al.


