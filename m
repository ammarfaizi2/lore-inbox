Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262596AbTCRXGR>; Tue, 18 Mar 2003 18:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262600AbTCRXGR>; Tue, 18 Mar 2003 18:06:17 -0500
Received: from sabre.velocet.net ([216.138.209.205]:22290 "HELO
	sabre.velocet.net") by vger.kernel.org with SMTP id <S262596AbTCRXGP>;
	Tue, 18 Mar 2003 18:06:15 -0500
To: linux-kernel <linux-kernel@vger.kernel.org>
Reply-To: gsstark@mit.edu
Subject: 2.4.20-ac2 Memory Leak?
From: Gregory Stark <gsstark@mit.edu>
Date: 18 Mar 2003 18:17:07 -0500
Message-ID: <8765qgb6z0.fsf@stark.dyndns.tv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My router box has a problem, it seems to be running out of memory. Programs
that worked fine earlier are now swapping like crazy. 

What confuses me is that if I add up all the RSS of the processes I get 5.9M,
a number drastically lower than the available RAM on the machine (24M) and
drastically lower than the amount of RAM "free" says is taken (22M).

It seems something in kernel space has taken a ton of memory out of play?
Or is my diagnosis wrong?


USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.8  1216  196 ?        S    Mar09   0:06 init [2] 
root         2  0.0  0.0     0    0 ?        SW   Mar09   0:02 [keventd]
root         3  0.0  0.0     0    0 ?        SWN  Mar09   0:01 [ksoftirqd_CPU0]
root         4  0.0  0.0     0    0 ?        SW   Mar09   0:25 [kswapd]
root         5  0.0  0.0     0    0 ?        SW   Mar09   0:00 [bdflush]
root         6  0.0  0.0     0    0 ?        SW   Mar09   0:00 [kupdated]
root       111  0.0  0.0     0    0 ?        SW   Mar09   0:00 [eth0]
root       118  0.0  0.8  1408  192 ?        S    Mar09   0:08 dhclient -pf /var/run/dhclient.eth0.pid eth0
root       182  0.0  1.1  1284  248 ?        S    Mar09   0:18 /sbin/syslogd
root       185  0.0  0.7  1840  168 ?        S    Mar09   0:04 /sbin/klogd
root       205  0.0  0.6  1236  156 ?        S    Mar09   0:00 /usr/sbin/inetd
root       212  0.0  1.0  2688  240 ?        S    Mar09   0:00 /usr/sbin/sshd
root       224  0.0  0.6  2308  140 tty1     S    Mar09   0:03 -bash
stark      225  0.0  0.5  2276  116 tty2     S    Mar09   0:01 -bash
stark      226  0.0  0.6  2300  144 tty3     S    Mar09   0:06 -bash
root       227  0.0  0.5  1200  116 tty4     S    Mar09   0:00 /sbin/getty 38400 tty4
root       228  0.0  0.5  1200  116 tty5     S    Mar09   0:00 /sbin/getty 38400 tty5
root       229  0.0  0.5  1200  116 tty6     S    Mar09   0:00 /sbin/getty 38400 tty6
root       236  0.0  0.6  1736  144 tty1     S    Mar09   0:03 tail -100f /var/log/ppp.log
root       245  0.0  0.8  2000  184 ?        S    Mar09   1:09 pppd call provider
root       253  0.0  0.0     0    0 ?        SW   Mar09   0:00 [eth1]
root       303  0.0  0.7  2088  160 ?        S    Mar09   0:25 /usr/sbin/zhm arilinn.mit.edu neskaya.mit.edu
root       494  0.0  0.5  5772  128 ?        S    Mar09   0:00 /usr/sbin/sshd
stark      496  0.0  1.5  5904  356 ?        S    Mar09   1:47 /usr/sbin/sshd
stark      497  0.5  2.7  3412  620 ?        S    Mar09  69:08 zwgc -ttymode -nofork -f /home/stark/.zwgc.desc
root      1315  0.0  0.7  1440  160 ?        S    Mar10   0:07 /usr/sbin/dhcpd -q eth1
root     11109  0.0  1.9  2316  432 tty2     S    14:02   0:01 bash
root     11367  0.0  1.9  2316  432 tty2     S    18:07   0:00 bash
root     11368  0.0  3.3  2488  744 tty2     R    18:07   0:00 ps auxww



        total:    used:    free:  shared: buffers:  cached:
Mem:  22962176 22597632   364544        0   245760  3223552
Swap: 67489792  4120576 63369216
MemTotal:        22424 kB
MemFree:           356 kB
MemShared:           0 kB
Buffers:           240 kB
Cached:           2352 kB
SwapCached:        796 kB
Active:           3008 kB
Inact_dirty:       192 kB
Inact_clean:       340 kB
Inact_target:      708 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        22424 kB
LowFree:           356 kB
SwapTotal:       65908 kB
SwapFree:        61884 kB
Committed_AS:     8552 kB



Module                  Size  Used by    Not tainted
ipt_MASQUERADE          1784   0  (autoclean)
ipt_LOG                 3384   1  (autoclean)
ipt_state                536   1  (autoclean)
ipt_TCPMSS              2360   1  (autoclean)
ip_nat_ftp              3568   0  (unused)
iptable_nat            21016   2  [ipt_MASQUERADE ip_nat_ftp]
ip_conntrack_irc        3152   0  (unused)
ip_conntrack_ftp        4208   1  [ip_nat_ftp]
ip_conntrack           27776   4  [ipt_MASQUERADE ipt_state ip_nat_ftp iptable_nat ip_conntrack_irc ip_conntrack_ftp]
ethertap                3108   1 
iptable_filter          1644   1  (autoclean)
ip_tables              14296   8  [ipt_MASQUERADE ipt_LOG ipt_state ipt_TCPMSS iptable_nat iptable_filter]
pppoe                   7820   1 
pppox                   1176   1  [pppoe]
ppp_generic            19836   3  (autoclean) [pppoe pppox]
slhc                    5104   0  (autoclean) [ppp_generic]
8139too                14216   2 
rtc                     6588   0  (autoclean)


-- 
greg

