Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266982AbTGGMbR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 08:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266984AbTGGMbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 08:31:17 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:38876 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S266982AbTGGMa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 08:30:58 -0400
Date: Mon, 7 Jul 2003 14:47:48 +0200
From: Vincent Touquet <vincent.touquet@pandora.be>
To: linux-kernel@vger.kernel.org
Subject: Re: [Bug report] System lockups on Tyan S2469 and lots of io [smp boot time problems too :(]
Message-ID: <20030707124747.GF7233@ns.mine.dnsalias.org>
Reply-To: vincent.touquet@pandora.be
References: <20030706210243.GA25645@lea.ulyssis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030706210243.GA25645@lea.ulyssis.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I collected some data we can look at :)

Following is by reproducing the problem on a 2.4.21 Linus kernel,
compiled with magic sysreq. support and all possible debug options (even
frame pointers). Kernel boot options are devfs=mount acpi=off and
nmi_watchdog=1

All of the following data have been acquired as close to the hangup as
possible:

[output of ps -aux]

Several processes stuck in a D state ...

USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  1208  464 ?        S    12:36   0:05 init
root         2  0.0  0.0     0    0 ?        SW   12:36   0:00 [keventd]
root         3  0.0  0.0     0    0 ?        SWN  12:36   0:00 [ksoftirqd_CPU0]
root         4  0.0  0.0     0    0 ?        SWN  12:36   0:00 [ksoftirqd_CPU1]
root         5  0.0  0.0     0    0 ?        SW   12:36   0:00 [kswapd]
root         6  0.0  0.0     0    0 ?        SW   12:36   0:00 [bdflush]
root         7  0.0  0.0     0    0 ?        DW   12:36   0:00 [kupdated]
root         8  0.0  0.0     0    0 ?        RW   12:36   0:00 [scsi_eh_0]
root         9  0.0  0.0     0    0 ?        SW   12:36   0:04 [kjournald]
root        24  0.0  0.1  2604 1912 ?        S    12:37   0:04 /sbin/devfsd /dev
root       122  0.0  0.0     0    0 ?        DW   12:37   0:00 [kjournald]
root       123  0.0  0.0     0    0 ?        SW   12:37   0:00 [kjournald]
root       124  0.0  0.0     0    0 ?        SW   12:37   0:00 [kjournald]
root       125  0.0  0.0     0    0 ?        SW   12:37   0:00 [kjournald]
root       126  0.0  0.0     0    0 ?        SW   12:37   0:00 [kjournald]
root       181  0.0  0.0  1840  960 ?        S    12:37   0:00 dhclient -pf /var/run/dhclient.eth1.pid eth1
daemon     185  0.0  0.0  1316  404 ?        S    12:37   0:00 /sbin/portmap
root       287  0.0  0.0  1288  544 ?        S    12:37   0:00 /sbin/syslogd
root       290  0.0  0.1  1984 1256 ?        S    12:37   0:00 /sbin/klogd
root       321  0.0  0.1  8380 1072 ?        S    12:37   0:00 /usr/sbin/3dmd
root       322  0.0  0.1  8380 1072 ?        S    12:37   0:00 /usr/sbin/3dmd
root       323  0.0  0.1  8380 1072 ?        S    12:37   0:00 /usr/sbin/3dmd
root       325  0.0  0.1  8380 1072 ?        D    12:37   0:02 /usr/sbin/3dmd
root       327  0.0  0.1  8380 1072 ?        S    12:37   0:00 /usr/sbin/3dmd
root       394  0.0  0.0  1308  588 ?        S    12:37   0:00 /usr/sbin/automount --pid-file=/var/run/autofs/_:var_:autofs_:misc.pid --timeout=300 /var/autofs/misc file /etc/auto.misc
root       410  0.0  0.0  1312  592 ?        S    12:37   0:00 /usr/sbin/automount --pid-file=/var/run/autofs/_:var_:autofs_:net.pid --timeout=300 /var/autofs/net program /etc/auto.net
root       601  0.0  0.0  1236  484 ?        S    12:37   0:00 /usr/sbin/inetd
root       605  0.0  0.0  1296  544 ?        S    12:37   0:00 /usr/sbin/lpd
root       702  0.0  0.0  2396  984 ?        S    12:37   0:00 /usr/lib/postfix/master
postfix    706  0.0  0.0  2396  964 ?        S    12:37   0:00 nqmgr -l -n qmgr -t fifo -u -c
root       708  0.0  0.1  3052 1444 ?        S    12:37   0:00 /usr/sbin/nmbd -D
root       709  0.0  0.1  3096 1328 ?        S    12:37   0:00 /usr/sbin/nmbd -D
root       711  0.0  0.1  3868 1392 ?        S    12:37   0:00 /usr/sbin/smbd -D
root       717  0.0  0.1  2684 1348 ?        S    12:37   0:00 /usr/sbin/sshd
root       731  0.0  0.0  1452  748 ?        S    12:37   0:00 /sbin/rpc.statd
root       734  0.0  0.1  1912 1904 ?        SL   12:37   0:00 /usr/sbin/ntpd
root       737  0.0  0.0  1708  752 ?        S    12:37   0:00 /usr/sbin/rpc.nfsd
root       739  0.0  0.0  1708  772 ?        S    12:37   0:00 /usr/sbin/rpc.mountd
daemon     746  0.0  0.0  1316  552 ?        S    12:37   0:00 /usr/sbin/atd
root       749  0.0  0.0  1396  664 ?        S    12:37   0:00 /usr/sbin/cron
root       754  0.0  0.0  2152  656 ?        S    12:37   0:00 /usr/bin/kdm
root       761  0.0  0.0  1200  444 vc/1     S    12:37   0:00 /sbin/getty 38400 tty1
root       762  0.0  0.0  1200  444 vc/2     S    12:37   0:00 /sbin/getty 38400 tty2
root       763  0.0  0.0  1200  444 vc/3     S    12:37   0:00 /sbin/getty 38400 tty3
root       764  0.0  0.0  1200  444 vc/4     S    12:37   0:00 /sbin/getty 38400 tty4
root       765  0.0  0.0  1200  444 vc/5     S    12:37   0:00 /sbin/getty 38400 tty5
root       766  0.0  0.0  1200  444 vc/6     S    12:37   0:00 /sbin/getty 38400 tty6
root       767  2.0  1.3 23720 13924 ?       S<   12:37   2:16 /usr/X11R6/bin/X -dpi 100 vt7 -auth /var/lib/kdm/authfiles/A:0-3HOxUJ
root       769  0.0  0.1  2640 1100 ?        S    12:37   0:00 -:0
root       771  0.0  0.5  8172 5860 ?        S    12:37   0:00 /usr/bin/perl /usr/share/usermin/miniserv.pl /etc/usermin/miniserv.conf
root       772  0.0  0.5  8172 5860 ?        S    12:37   0:00 /usr/bin/perl /usr/share/webmin/miniserv.pl /etc/webmin/miniserv.conf
root       965  0.0  0.1  5764 1808 ?        S    12:39   0:00 sshd: vincent [priv]
vincent    967  0.0  0.1  5852 1892 ?        S    12:39   0:03 sshd: vincent@pts/0
vincent    968  0.0  0.1  2276 1336 pts/0    S    12:39   0:00 -bash
root      1485  0.0  0.1  2288 1388 pts/0    S    12:44   0:05 -su
vincent   2149  0.0  0.0  2040  976 ?        S    12:48   0:00 /bin/sh /usr/bin/x-session-manager
vincent   2174  0.0  0.0  2368  812 ?        S    12:48   0:00 /usr/bin/ssh-agent x-session-manager
vincent   2181  0.0  0.4 15344 4884 ?        S    12:48   0:00 kdeinit: Running...
vincent   2187  0.0  0.5 15904 6028 ?        S    12:48   0:00 kdeinit: klauncher
vincent   2190  0.1  0.6 16368 7228 ?        S    12:48   0:07 kdeinit: kded
vincent   2198  0.0  0.2  5348 2724 ?        S    12:48   0:01 /usr/bin/artsd -F 10 -S 4096 -s 60 -m artsmessage -l 3 -f
vincent   2209  0.0  0.7 18176 7944 ?        S    12:48   0:00 kdeinit: knotify
vincent   2210  0.0  0.4 10800 4804 ?        S    12:48   0:00 ksmserver --restore
vincent   2211  0.1  0.8 17456 8892 ?        S    12:48   0:06 kdeinit: kwin -session 11c0a8000a000105049672100000008610000
vincent   2215  0.0  0.9 17044 9428 ?        S    12:48   0:01 kdeinit: kdesktop
vincent   2217  0.0  1.0 18400 10336 ?       S    12:48   0:04 kdeinit: kicker
vincent   2247  0.0  0.7 16476 7672 ?        S    12:48   0:01 kdeinit: klipper -icon klipper -miniicon klipper
vincent   2252  0.0  0.6 13220 6236 ?        S    12:48   0:00 ksensors -caption KSensors -icon ksensors.png -miniicon ksensors.png
vincent   2253  0.0  0.6 16116 6760 ?        S    12:49   0:00 kdeinit: kwrited
vincent   2258  0.0  0.0  1192  312 pts/1    S    12:49   0:00 /bin/cat
vincent   2497  0.0  0.8 16188 8844 ?        S    12:51   0:05 ksysguard
vincent   2498  0.0  0.0  1316  576 ?        S    12:51   0:04 ksysguardd
vincent   2525  0.0  1.6 24188 16564 ?       S    12:51   0:03 kdeinit: konqueror --silent
vincent   2535  0.0  0.6 16008 6652 ?        S    12:51   0:00 kdeinit: kcookiejar
vincent   2538  0.0  0.3 10496 3176 ?        S    12:51   0:00 kdesud
root      2617  0.0  0.1  4252 1976 ?        S    12:51   0:00 /usr/sbin/smbd -D
root      4216  0.0  0.2  4512 2320 ?        S    13:04   0:03 /usr/sbin/smbd -D
root      6999  0.0  0.1  5764 1808 ?        S    13:24   0:00 sshd: vincent [priv]
vincent   7016  0.0  0.1  5784 1880 ?        S    13:24   0:00 sshd: vincent@pts/2
vincent   7017  0.0  0.1  2276 1336 pts/2    S    13:24   0:00 -bash
root      7053  0.0  0.1  2276 1336 pts/2    S    13:25   0:00 -su
root      7188  0.0  0.1  5764 1808 ?        S    13:25   0:00 sshd: vincent [priv]
vincent   7210  0.0  0.1  5892 1948 ?        S    13:25   0:00 sshd: vincent@pts/3
vincent   7211  0.0  0.1  2284 1376 pts/3    S    13:25   0:00 -bash
root      7273  0.0  0.1  2288 1388 pts/3    S    13:25   0:00 -su
root     17039  0.0  0.1  5764 1808 ?        S    13:48   0:00 sshd: vincent [priv]
vincent  17061  0.0  0.1  5856 1908 ?        S    13:48   0:00 sshd: vincent@pts/4
vincent  17062  0.0  0.1  2284 1380 pts/4    S    13:48   0:00 -bash
postfix  29791  0.0  0.0  2352  924 ?        S    14:17   0:00 pickup -l -t fifo -u -c
root     29818  0.0  0.1  2284 1376 pts/4    S    14:17   0:00 -su
root     29822  0.0  0.0  1736  492 pts/4    S    14:17   0:00 tail -f /var/log/messages
vincent  30131  0.0  0.5 15588 5732 ?        S    14:20   0:00 kdeinit: kio_http http /tmp/ksocket-vincent/klauncher89Rdtc.slave-socket /tmp/ksocket-vincent/konquerorsIO5nb.slave-socket
vincent  30677  0.0  0.5 15588 5708 ?        S    14:24   0:00 kdeinit: kio_http http /tmp/ksocket-vincent/klauncher89Rdtc.slave-socket /tmp/ksocket-vincent/konqueror5UQgBb.slave-socket
vincent  31205  0.1  0.7 16844 8240 ?        S    14:28   0:00 kdeinit: konsole -icon konsole -miniicon konsole
vincent  31206  0.0  0.1  2280 1372 pts/5    S    14:28   0:00 /bin/bash
root     31236  0.0  0.1  2276 1336 pts/5    S    14:28   0:00 -su
root     31622  0.0  0.1  5764 1808 ?        S    14:29   0:00 sshd: vincent [priv]
vincent  31672  0.0  0.1  5784 1880 ?        S    14:29   0:00 sshd: vincent@pts/6
vincent  31673  0.0  0.1  2276 1336 pts/6    S    14:29   0:00 -bash
root     31705  0.0  0.1  2276 1336 pts/6    S    14:29   0:00 -su
callaer  31787  0.0  0.1  2244 1340 pts/6    S    14:29   0:00 -su
root     32418  0.0  0.0  1260  496 pts/2    S    14:30   0:00 vmstat -n 1
callaer  32441  4.7  0.0  1228  372 pts/6    D    14:30   0:02 cp -r /mnt/hercules1/backup_dirk/ ./25_02_2003/
root       462  0.0  0.0  1708  464 pts/3    S    14:31   0:00 sleep .5
root       466  0.0  0.1  2288 1388 pts/0    R    14:31   0:00 -su

Stuck in a D state:

root       122  0.0  0.0     0    0 ?        DW   12:37   0:00 [kjournald]
root       325  0.0  0.1  8380 1072 ?        D    12:37   0:02 /usr/sbin/3dmd
callaer  32441  4.7  0.0  1228  372 pts/6    D    14:30   0:02 cp -r /mnt/hercules1/backup_dirk/ ./25_02_2003

The first is the ext3 journalling daemon ?
The second is the 3ware raid management daemon.
The third is the copying process from ide (/mnt/hercules1) to the array (./)

[The output of vmstat -n 1]
Started right before the copying kicks in:
kalimero:~# vmstat -n 1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0      0 269524  46788 620124    0    0    31    65   81   164  2  1 97  0
 0  0      0 269516  46788 620124    0    0     0   392  123   414  3  2 95  0
 0  0      0 269516  46788 620124    0    0     0     0  132   454  0  1 98  0
FROM HERE ON THE CP KICKS IN
 1  0      0 275520  46960 613908    0    0     4     0  127   504  4 43 53  0
 0  1      0 260100  47084 627812    0    0  3856     0  173   679  0 46 54  0
 0  1      0 204908  47220 681028    0    0 26700     0  562  1212  5 16 79  0
 0  2      0 200952  47240 684824    0    0  1800 59528  350   538  0  5 94  0
 0  2      0 200944  47248 684824    0    0     8 24336  293   447  3  2 95  0
 1  2      0 200944  47248 684824    0    0     0 20372  281   403  0  2 97  0
 0  3      0 200936  47252 684824    0    0     4 21484  445  1051  6  3 91  0
 0  3      0 200904  47264 684824    0    0     4 23664  288   421  1  1 98  0
 1  3      0 200892  47264 684824    0    0     0 12416  218   416  3  1 96  0
 0  3      0 200880  47264 684824    0    0     0     0  114   398  0  1 98  0
 0  3      0 200868  47264 684824    0    0     0     0  111   395  3  1 96  0
 0  3      0 200856  47264 684824    0    0     0     0  114   376  0  1 98  0
 0  3      0 200944  47264 684824    0    0     0   560  134   483  2  2 95  0
 2  3      0 200916  47264 684824    0    0     0     0  124   454  0  1 98  0
 0  3      0 200916  47264 684824    0    0     0     0  109   403  4  2 94  0
 0  3      0 200896  47264 684824    0    0     0     0  119   466  1  1 98  0
 0  3      0 200868  47264 684824    0    0     0     0  125   490  3  1 95  0
 0  3      0 200844  47264 684824    0    0     0   388  127   383  1  1 98  0
 1  3      0 200832  47264 684824    0    0     0     0  125   506  3  1 95  0
 0  3      0 200832  47264 684824    0    0     0     0  108   391  0  1 99  0
 0  3      0 200944  47264 684824    0    0     0     0  124   515  3  2 95  0
 1  3      0 200940  47264 684824    0    0     0     0  132   459  1  1 98  0
 0  3      0 200940  47264 684824    0    0     0   388  122   508  4  1 95  0
 0  3      0 200916  47264 684824    0    0     0     0  122   476  2  0 98  0
 0  3      0 200900  47264 684824    0    0     0     0  120   427  3  2 95  0
 0  3      0 200916  47264 684824    0    0     0     0  110   381  0  2 98  0
 3  3      0 200892  47264 684824    0    0     0     0  108   382  3  0 96  0
 0  3      0 200892  47264 684824    0    0     0   384  124   384  0  2 98  0
 1  3      0 200892  47264 684824    0    0     0     0  118   408  3  2 94  0
 0  3      0 200880  47264 684824    0    0     0     0  112   377  0  2 98  0
 0  3      0 200884  47264 684824    0    0     0     0  292  1184  3  1 95  0
 1  3      0 200880  47264 684824    0    0     0     0  119   459  1  1 98  0
 0  4      0 200856  47264 684824    0    0     0  1864  133   502  3  2 95  0
 1  4      0 200856  47264 684824    0    0     0     0  110   424  1  1 98  0
 0  4      0 200860  47264 684824    0    0     0     0  133   554  3  1 96  0
 0  4      0 200856  47264 684824    0    0     0     0  133   566  2  0 98  0
 0  4      0 200856  47264 684824    0    0     0     0  238  1050  3  2 95  0
 0  4      0 200856  47264 684824    0    0     0   388  241  1065  0  2 98  0
 3  4      0 200852  47264 684824    0    0     0     0  413  1495  3 39 58  0
 2  4      0 200852  47264 684824    0    0     0     0  406  1368  1 15 83  0
 1  4      0 200852  47264 684824    0    0     0     0  180   670  3  3 94  0
 1  4      0 200852  47264 684824    0    0     0     0  123   555  1  1 98  0

Notice that no blocks get read in no more and a very intermittent write out.

[Stack trace]
Finally the stack trace (which I hope is close enough to the hanging,
else I might have to redo it :/)

Jul  7 14:28:30 kalimero kernel: SysRq : Show State
Jul  7 14:28:30 kalimero kernel:
Jul  7 14:28:30 kalimero kernel:                          free                        sibling
Jul  7 14:28:30 kalimero kernel:   task             PC    stack   pid father child younger older
Jul  7 14:28:30 kalimero kernel: init          S C02DF7B8  4124     1      0  2538               (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [__pollwait+62/176] [process_timeout+0/32] [do_select+276/544] [sys_select+794/1200]
Jul  7 14:28:30 kalimero kernel:   [path_release+22/64] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: keventd       R F6AF136C  5844     2      1             3       (L-TLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [console_callback+159/192] [__run_task_queue+173/192] [context_thread+417/672] [context_thread+0/672] [arch_kernel_thread+46/64]
Jul  7 14:28:30 kalimero kernel:   [context_thread+0/672]
Jul  7 14:28:30 kalimero kernel: ksoftirqd_CPU S C1C2FF8C  5860     3      1             4     2 (L-TLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [bh_action+132/224] [tasklet_hi_action+99/160] [ksoftirqd+175/256] [arch_kernel_thread+46/64] [ksoftirqd+0/256] Jul  7 14:28:30 kalimero kernel: ksoftirqd_CPU S F72C0000  5876     4      1             5     3 (L-TLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [bh_action+132/224] [tasklet_hi_action+99/160] [ksoftirqd+175/256] [arch_kernel_thread+46/64] [ksoftirqd+0/256] Jul  7 14:28:30 kalimero kernel: kswapd        S 00000000  6332     5      1             6     4 (L-TLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [kswapd+134/192] [kswapd+0/192] [arch_kernel_thread+46/64] [kswapd+0/192]
Jul  7 14:28:30 kalimero kernel: bdflush       S C02DBE40  6284     6      1             7     5 (L-TLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [interruptible_sleep_on+143/272] [bdflush+335/352] [arch_kernel_thread+46/64] [bdflush+0/352]
Jul  7 14:28:30 kalimero kernel: kupdated      S F7547614  5512     7      1             8     6 (L-TLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [log_start_commit+216/256] [ext3_write_super+62/64] [schedule_timeout+88/176] [process_timeout+0/32] [kupdate+241/480]
Jul  7 14:28:30 kalimero kernel:   [kupdate+0/480] [arch_kernel_thread+46/64] [kupdate+0/480]
Jul  7 14:28:30 kalimero kernel: scsi_eh_0     S 00000000  6080     8      1             9     7 (L-TLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__down_interruptible+221/416] [__down_failed_interruptible+10/16] [.text.lock.scsi_error+229/290] [arch_kernel_thread+46/64] [scsi_error_handler+0/608]
Jul  7 14:28:30 kalimero kernel: kjournald     S F7ED6000  4492     9      1            24     8 (L-TLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [interruptible_sleep_on+143/272] [kjournald+444/720] [ret_from_fork+6/32] [commit_timeout+0/16] [arch_kernel_thread+46/64]
Jul  7 14:28:30 kalimero kernel:   [kjournald+0/720]
Jul  7 14:28:30 kalimero kernel: devfsd        S 380C5067  5000    24      1           122     9 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [devfsd_read+224/1040] [free_uid+32/128] [release_task+324/352] [sys_read+150/448] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: kjournald     S E7792000  5092   122      1           123    24 (L-TLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [interruptible_sleep_on+143/272] [printk+389/512] [kjournald+444/720] [ret_from_fork+6/32] [commit_timeout+0/16]Jul  7 14:28:30 kalimero kernel:   [arch_kernel_thread+46/64] [kjournald+0/720]
Jul  7 14:28:30 kalimero kernel: kjournald     S F7C12000     4   123      1           124   122 (L-TLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [interruptible_sleep_on+143/272] [kjournald+444/720] [ret_from_fork+6/32] [commit_timeout+0/16] [arch_kernel_thread+46/64]
Jul  7 14:28:30 kalimero kernel:   [kjournald+0/720]
Jul  7 14:28:30 kalimero kernel: kjournald     S F7C12000     4   124      1           125   123 (L-TLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [release_console_sem+285/288] [interruptible_sleep_on+143/272] [printk+389/512] [kjournald+444/720] [ret_from_fork+6/32]
Jul  7 14:28:30 kalimero kernel:   [commit_timeout+0/16] [arch_kernel_thread+46/64] [kjournald+0/720]
Jul  7 14:28:30 kalimero kernel: kjournald     S 00000282     4   125      1           126   124 (L-TLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [release_console_sem+285/288] [interruptible_sleep_on+143/272] [printk+389/512] [kjournald+444/720] [ret_from_fork+6/32]
Jul  7 14:28:30 kalimero kernel:   [kjournald+0/720] [commit_timeout+0/16] [arch_kernel_thread+46/64] [kjournald+0/720]
Jul  7 14:28:30 kalimero kernel: kjournald     S 00000282     4   126      1           181   125 (L-TLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [release_console_sem+285/288] [interruptible_sleep_on+143/272] [printk+389/512] [kjournald+444/720] [ret_from_fork+6/32]
Jul  7 14:28:30 kalimero kernel:   [kjournald+0/720] [commit_timeout+0/16] [arch_kernel_thread+46/64] [kjournald+0/720]
Jul  7 14:28:30 kalimero kernel: dhclient      S F7423F2C     0   181      1           185   126 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__alloc_pages+75/400] [__get_free_pages+32/48] [schedule_timeout+88/176] [datagram_poll+46/219] [process_timeout+0/32]
Jul  7 14:28:30 kalimero kernel:   [sock_poll+44/64] [do_select+276/544] [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: portmap       S 00000246     0   185      1           287   181 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [datagram_poll+46/219] [schedule_timeout+165/176] [sock_poll+44/64] [do_pollfd+92/160] [do_poll+158/240]
Jul  7 14:28:30 kalimero kernel:   [sys_poll+355/720] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: syslogd       S F7373F2C     0   287      1           290   185 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__alloc_pages+75/400] [__get_free_pages+32/48] [schedule_timeout+165/176] [datagram_poll+46/219] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1952480/128]
Jul  7 14:28:30 kalimero kernel:   [sock_poll+44/64] [do_select+276/544] [sys_select+794/1200] [do_setitimer+215/256] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: klogd         R 00000000     0   290      1           321   287 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [sock_sendmsg+115/176] [do_syslog+520/1664] [sock_write+153/176] [sys_read+150/448] [sys_time+29/96]
Jul  7 14:28:30 kalimero kernel:   [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: 3dmd          S BFFFF9CC  2384   321      1   322     394   290 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [schedule_timeout+165/176] [sys_rt_sigaction+150/176] [sys_rt_sigprocmask+81/576] [sys_nanosleep+203/336] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: 3dmd          S C02F4000  2384   322    321   327               (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__pollwait+62/176] [schedule_timeout+88/176] [process_timeout+0/32] [do_poll+158/240] [sys_poll+355/720]
Jul  7 14:28:30 kalimero kernel:   [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: 3dmd          S F72C3E30  2388   323    322           325       (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [ip_queue_xmit2+197/592] [schedule_timeout+165/176] [tcp_v4_send_check+70/208] [wait_for_connect+576/624] [tcp_transmit_skb+676/1072]
Jul  7 14:28:30 kalimero kernel:   [tcp_accept+490/848] [alloc_inode+194/336] [inet_accept+48/640] [sock_alloc+25/208] [sys_accept+111/288] [destroy_inode+76/80]
Jul  7 14:28:30 kalimero kernel:   [iput+265/944] [dput+35/496] [fput+300/384] [sys_socketcall+198/576] [sys_ioctl+225/657] [sys_close+120/144]
Jul  7 14:28:30 kalimero kernel:   [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: 3dmd          S 40000000  2388   325    322           327   323 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [unmap_fixup+533/560] [schedule_timeout+88/176] [process_timeout+0/32] [sys_nanosleep+203/336] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: 3dmd          S 00000246  2388   327    322                 325 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [datagram_poll+46/219] [schedule_timeout+165/176] [sock_poll+44/64] [do_pollfd+92/160] [do_poll+158/240]
Jul  7 14:28:30 kalimero kernel:   [sys_poll+355/720] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: automount     S F7C05A9C  5168   394      1           410   321 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__get_free_pages+32/48] [__pollwait+62/176] [schedule_timeout+165/176] [do_pollfd+92/160] [do_poll+158/240]
Jul  7 14:28:30 kalimero kernel:   [sys_poll+355/720] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: automount     S F7960B34  2384   410      1           426   394 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__get_free_pages+32/48] [__pollwait+62/176] [schedule_timeout+165/176] [do_pollfd+92/160] [do_poll+158/240]
Jul  7 14:28:30 kalimero kernel:   [sys_poll+355/720] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: cupsd         S C02DF7B8     0   426      1           601   410 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [process_timeout+0/32] [do_select+276/544] [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: inetd         S C02DF7B8     0   601      1           605   426 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__pollwait+62/176] [schedule_timeout+165/176] [datagram_poll+46/219] [sock_poll+44/64] [do_select+276/544]
Jul  7 14:28:30 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: lpd           S F6F21F2C     0   605      1           702   601 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__alloc_pages+75/400] [schedule_timeout+165/176] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1957506/128] [sock_poll+44/64] [do_select+276/544]
Jul  7 14:28:30 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: master        S C02DF7B8  4612   702      1 29791     708   605 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1957506/128] [process_timeout+0/32] [sock_poll+44/64] [do_select+276/544]
Jul  7 14:28:30 kalimero kernel:   [sys_select+794/1200] [do_setitimer+215/256] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: nqmgr         S F6CA3F2C  4488   706    702         29791       (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__alloc_pages+75/400] [__get_free_pages+32/48] [schedule_timeout+88/176] [process_timeout+0/32] [do_select+276/544]
Jul  7 14:28:30 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: nmbd          S C02F4000     0   708      1   709     711   702 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [process_timeout+0/32] [sock_poll+44/64] [do_select+276/544] [sys_select+794/1200]
Jul  7 14:28:30 kalimero kernel:   [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: nmbd          S F6C84000  4456   709    708                     (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [pipe_wait+122/176] [pipe_read+178/496] [sys_read+150/448] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: smbd          S C02DF7B8     0   711      1  4216     717   708 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__pollwait+62/176] [schedule_timeout+165/176] [do_select+276/544] [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: sshd          S C02DF7B8     0   717      1 17039     731   711 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__pollwait+62/176] [schedule_timeout+165/176] [sock_poll+44/64] [do_select+276/544] [sys_select+794/1200]
Jul  7 14:28:30 kalimero kernel:   [sys_close+120/144] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: rpc.statd     S F6C1FF2C     0   731      1           734   717 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__alloc_pages+75/400] [schedule_timeout+165/176] [datagram_poll+46/219] [sock_poll+44/64] [do_select+276/544]
Jul  7 14:28:30 kalimero kernel:   [sys_select+794/1200] [sys_close+120/144] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: ntpd          S F6C19F2C     0   734      1           737   731 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__alloc_pages+75/400] [__get_free_pages+32/48] [schedule_timeout+165/176] [datagram_poll+46/219] [sock_poll+44/64]
Jul  7 14:28:30 kalimero kernel:   [do_select+276/544] [sys_select+794/1200] [restore_sigcontext+296/320] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: rpc.nfsd      S 00000246     0   737      1           739   734 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [datagram_poll+46/219] [schedule_timeout+165/176] [sock_poll+44/64] [do_pollfd+92/160] [do_poll+158/240]
Jul  7 14:28:30 kalimero kernel:   [sys_poll+355/720] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: rpc.mountd    S 00000246     0   739      1           746   737 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [datagram_poll+46/219] [schedule_timeout+165/176] [sock_poll+44/64] [do_pollfd+92/160] [do_poll+158/240]
Jul  7 14:28:30 kalimero kernel:   [sys_poll+355/720] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: atd           S F6BE3F1C     0   746      1           749   739 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [process_timeout+0/32] [sys_rt_sigprocmask+81/576] [sys_nanosleep+203/336] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: cron          S F6BCFF1C     0   749      1           754   746 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [process_timeout+0/32] [sys_rt_sigprocmask+81/576] [sys_nanosleep+203/336] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: kdm           S F6B95F2C  4712   754      1   769     761   749 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__alloc_pages+75/400] [schedule_timeout+165/176] [datagram_poll+46/219] [sock_poll+44/64] [do_select+276/544]
Jul  7 14:28:30 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: getty         S C01F369B     0   761      1           762   754 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [clear_selection+27/96] [set_cursor+115/144] [con_flush_chars+132/224] [schedule_timeout+165/176] [write_chan+335/512]
Jul  7 14:28:30 kalimero kernel:   [read_chan+579/1616] [tty_read+352/416] [sys_read+150/448] [sys_newuname+57/96] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: getty         S F751E21C  4720   762      1           763   761 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [con_flush_chars+132/224] [schedule_timeout+165/176] [write_chan+335/512] [read_chan+579/1616] [tty_read+352/416]
Jul  7 14:28:30 kalimero kernel:   [sys_read+150/448] [sys_newuname+57/96] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: getty         S F750D21C  4964   763      1           764   762 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [con_flush_chars+132/224] [schedule_timeout+165/176] [write_chan+335/512] [read_chan+579/1616] [tty_read+352/416]
Jul  7 14:28:30 kalimero kernel:   [sys_read+150/448] [sys_newuname+57/96] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: getty         S F739521C  4964   764      1           765   763 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [con_flush_chars+132/224] [schedule_timeout+165/176] [write_chan+335/512] [read_chan+579/1616] [tty_read+352/416]
Jul  7 14:28:30 kalimero kernel:   [sys_read+150/448] [sys_newuname+57/96] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: getty         S F751021C  4612   765      1           766   764 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [con_flush_chars+132/224] [schedule_timeout+165/176] [write_chan+335/512] [read_chan+579/1616] [tty_read+352/416]
Jul  7 14:28:30 kalimero kernel:   [sys_read+150/448] [sys_newuname+57/96] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: getty         S F6B7121C  4964   766      1           771   765 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [con_flush_chars+132/224] [schedule_timeout+165/176] [write_chan+335/512] [read_chan+579/1616] [tty_read+352/416]
Jul  7 14:28:30 kalimero kernel:   [sys_read+150/448] [sys_newuname+57/96] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: XFree86       S C02DF7B8     0   767    754           769       (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1957506/128] [process_timeout+0/32] [sock_poll+44/64] [do_select+276/544]
Jul  7 14:28:30 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: kdm           S 00000282     0   769    754  2149           767 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [do_getitimer+92/176] [sys_wait4+303/1040] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: miniserv.pl   S C02DF7B8     0   771      1           772   766 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [datagram_poll+46/219] [process_timeout+0/32] [sock_poll+44/64] [do_select+276/544]
Jul  7 14:28:30 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: miniserv.pl   S C02DF7B8  5112   772      1          2184   771 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [datagram_poll+46/219] [process_timeout+0/32] [sock_poll+44/64] [do_select+276/544]
Jul  7 14:28:30 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: sshd          S 00000001  2384   965    717   967    6999       (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [journal_alloc_journal_head+27/128] [schedule_timeout+165/176] [journal_dirty_data+522/640] [balance_dirty_state+15/80] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1959618/128]
Jul  7 14:28:30 kalimero kernel:   [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1958327/128] [sock_recvmsg+79/240] [get_empty_filp+133/544] [sock_read+147/160] [sys_read+150/448] [sys_close+120/144]
Jul  7 14:28:30 kalimero kernel:   [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: sshd          S C02DF7B8     0   967    965   968               (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [schedule_timeout+165/176] [do_select+276/544] [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: bash          S F6614000  4964   968    967  1485               (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [tty_check_change+66/160] [sys_wait4+303/1040] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: bash          S 0000000C  4612  1485    968                     (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [do_wp_page+1025/1152] [__global_cli+100/112] [schedule_timeout+165/176] [write_chan+335/512] [read_chan+579/1616]
Jul  7 14:28:30 kalimero kernel:   [tty_read+352/416] [sys_read+150/448] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: x-session-man S 000008A2     0  2149    769  2210               (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [sys_rt_sigaction+150/176] [sys_wait4+303/1040] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: ssh-agent     S F4A93F2C     0  2174   2149          2210       (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__alloc_pages+75/400] [__get_free_pages+32/48] [schedule_timeout+165/176] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1957506/128] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1952576/128]
Jul  7 14:28:30 kalimero kernel:   [sock_poll+44/64] [do_select+276/544] [sys_select+794/1200] [restore_sigcontext+296/320] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: kdeinit       S C02DF7B8     0  2181      1 31205    2215  2209 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [schedule_timeout+165/176] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1957506/128] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1952576/128] [sock_poll+44/64] [do_select+276/544]
Jul  7 14:28:30 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: kdeinit       S F48C4000     0  2184      1          2187   772 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [schedule_timeout+165/176] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1957506/128] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1952576/128] [sock_poll+44/64] [do_select+276/544]
Jul  7 14:28:30 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: kdeinit       S C02DF7B8     0  2187      1          2190  2184 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [schedule_timeout+165/176] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1957506/128] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1952576/128] [sock_poll+44/64] [do_select+276/544]
Jul  7 14:28:30 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: kdeinit       S F49FBF2C     0  2190      1          2209  2187 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__alloc_pages+75/400] [__get_free_pages+32/48] [schedule_timeout+88/176] [process_timeout+0/32] [do_select+276/544]
Jul  7 14:28:30 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: artsd         S C02DF7B8     0  2198   2181          2211       (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1957506/128] [process_timeout+0/32] [sock_poll+44/64] [do_select+276/544]
Jul  7 14:28:30 kalimero kernel:   [sys_select+794/1200] [restore_sigcontext+296/320] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: kdeinit       S F48C5F2C     0  2209      1          2181  2190 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__alloc_pages+75/400] [__get_free_pages+32/48] [schedule_timeout+165/176] [do_select+276/544] [sys_select+794/1200]
Jul  7 14:28:30 kalimero kernel:   [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: ksmserver     S F4A83F2C  4272  2210   2149                2174 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__alloc_pages+75/400] [__get_free_pages+32/48] [schedule_timeout+165/176] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1957506/128] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1952576/128]
Jul  7 14:28:30 kalimero kernel:   [sock_poll+44/64] [do_select+276/544] [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: kdeinit       S C02F4000     0  2211   2181          2497  2198 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__alloc_pages+75/400] [__get_free_pages+32/48] [schedule_timeout+165/176] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1952576/128] [sock_poll+44/64]
Jul  7 14:28:30 kalimero kernel:   [do_select+276/544] [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: kdeinit       S F4869F2C     0  2215      1          2217  2181 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__alloc_pages+75/400] [__get_free_pages+32/48] [schedule_timeout+88/176] [process_timeout+0/32] [do_select+276/544]
Jul  7 14:28:30 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: kdeinit       S C1C12000  4996  2217      1          2247  2215 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__alloc_pages+75/400] [__get_free_pages+32/48] [schedule_timeout+88/176] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1957506/128] [process_timeout+0/32]
Jul  7 14:28:30 kalimero kernel:   [sock_poll+44/64] [do_select+276/544] [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: kdeinit       S 00000282     0  2247      1          2252  2217 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [process_timeout+0/32] [do_select+276/544] [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: ksensors      S F3CD9F2C     0  2252      1          2253  2247 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__alloc_pages+75/400] [__get_free_pages+32/48] [schedule_timeout+88/176] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1957506/128] [process_timeout+0/32]
Jul  7 14:28:30 kalimero kernel:   [sock_poll+44/64] [do_select+276/544] [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: kdeinit       S F3C25F2C     0  2253      1  2258    2535  2252 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__alloc_pages+75/400] [schedule_timeout+165/176] [do_select+276/544] [sys_select+794/1200] [system_call+51/56] Jul  7 14:28:30 kalimero kernel: cat           S C013278C  4964  2258   2253                     (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [do_no_page+140/864] [schedule_timeout+165/176] [read_chan+579/1616] [cp_new_stat64+227/272] [tty_read+352/416] Jul  7 14:28:30 kalimero kernel:   [sys_read+150/448] [sys_fstat64+72/128] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: ksysguard     S F3A11F2C  1360  2497   2181  2498    2525  2211 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__alloc_pages+75/400] [__get_free_pages+32/48] [schedule_timeout+88/176] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1957506/128] [process_timeout+0/32]
Jul  7 14:28:30 kalimero kernel:   [sock_poll+44/64] [do_select+276/544] [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: ksysguardd    S F3B29F2C  4964  2498   2497                     (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__alloc_pages+75/400] [__get_free_pages+32/48] [schedule_timeout+88/176] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1957506/128] [process_timeout+0/32]
Jul  7 14:28:30 kalimero kernel:   [sock_poll+44/64] [do_select+276/544] [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: kdeinit       S F477DF2C     0  2525   2181         30131  2497 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__alloc_pages+75/400] [__get_free_pages+32/48] [schedule_timeout+88/176] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1957506/128] [process_timeout+0/32]
Jul  7 14:28:30 kalimero kernel:   [sock_poll+44/64] [do_select+276/544] [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: kdeinit       S F2E05F2C   272  2535      1          2538  2253 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__alloc_pages+75/400] [__get_free_pages+32/48] [schedule_timeout+165/176] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1957506/128] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1952576/128]
Jul  7 14:28:30 kalimero kernel:   [sock_poll+44/64] [do_select+276/544] [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: kdesud        S F2AEDF2C  5360  2538      1                2535 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__alloc_pages+75/400] [__get_free_pages+32/48] [schedule_timeout+88/176] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1957506/128] [process_timeout+0/32]
Jul  7 14:28:30 kalimero kernel:   [sock_poll+44/64] [do_select+276/544] [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: smbd          S F29CFF2C     0  2617    711          4216       (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__alloc_pages+75/400] [schedule_timeout+88/176] [process_timeout+0/32] [do_select+276/544] [sys_select+794/1200]
Jul  7 14:28:30 kalimero kernel:   [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: smbd          S C02DF7B8  1360  4216    711                2617 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [process_timeout+0/32] [do_select+276/544] [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: sshd          S 00000001   672  6999    717  7016    7188   965 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [journal_alloc_journal_head+27/128] [schedule_timeout+165/176] [journal_dirty_data+522/640] [balance_dirty_state+15/80] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1959618/128]
Jul  7 14:28:30 kalimero kernel:   [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1958327/128] [sock_recvmsg+79/240] [get_empty_filp+133/544] [sock_read+147/160] [sys_read+150/448] [sys_close+120/144]
Jul  7 14:28:30 kalimero kernel:   [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: sshd          S C02DF7B8  4992  7016   6999  7017               (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [schedule_timeout+165/176] [do_select+276/544] [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: bash          S E82E4000    36  7017   7016  7053               (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [tty_check_change+66/160] [sys_wait4+303/1040] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: bash          S 0000000C  2432  7053   7017                     (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [do_wp_page+1025/1152] [__global_cli+100/112] [schedule_timeout+165/176] [write_chan+335/512] [read_chan+579/1616]
Jul  7 14:28:30 kalimero kernel:   [tty_read+352/416] [sys_read+150/448] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: sshd          S 00000001  2384  7188    717  7210   17039  6999 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [journal_alloc_journal_head+27/128] [schedule_timeout+165/176] [journal_dirty_data+522/640] [balance_dirty_state+15/80] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1959618/128]
Jul  7 14:28:30 kalimero kernel:   [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1958327/128] [sock_recvmsg+79/240] [get_empty_filp+133/544] [sock_read+147/160] [sys_read+150/448] [sys_close+120/144]
Jul  7 14:28:30 kalimero kernel:   [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: sshd          S C02DF7B8  2376  7210   7188  7211               (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [schedule_timeout+165/176] [do_select+276/544] [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: bash          S E8228000  2468  7211   7210  7273               (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [tty_check_change+66/160] [sys_wait4+303/1040] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: bash          S 0000000C    16  7273   7211                     (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [do_wp_page+1025/1152] [__global_cli+100/112] [schedule_timeout+165/176] [write_chan+335/512] [read_chan+579/1616]
Jul  7 14:28:30 kalimero kernel:   [tty_read+352/416] [sys_read+150/448] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: sshd          S 00000001     0 17039    717 17061          7188 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [journal_alloc_journal_head+27/128] [schedule_timeout+165/176] [journal_dirty_data+522/640] [balance_dirty_state+15/80] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1959618/128]
Jul  7 14:28:30 kalimero kernel:   [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1958327/128] [sock_recvmsg+79/240] [get_empty_filp+133/544] [sock_read+147/160] [sys_read+150/448] [sys_close+120/144]
Jul  7 14:28:30 kalimero kernel:   [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: sshd          S C02DF7B8    60 17061  17039 17062               (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [schedule_timeout+165/176] [do_select+276/544] [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: bash          S E83D6000     0 17062  17061 29818               (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [tty_check_change+66/160] [sys_wait4+303/1040] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: pickup        S F6EB2000     0 29791    702                 706 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__alloc_pages+75/400] [__get_free_pages+32/48] [schedule_timeout+88/176] [process_timeout+0/32] [sock_poll+44/64]
Jul  7 14:28:30 kalimero kernel:   [do_select+276/544] [sys_select+794/1200] [do_setitimer+215/256] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: bash          S E7A9C000     0 29818  17062 29822               (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [tty_check_change+66/160] [sys_wait4+303/1040] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: tail          S C1C12000     0 29822  29818                     (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [process_timeout+0/32] [sys_nanosleep+203/336] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: kdeinit       S E7EEDF2C  2416 30131   2181         30677  2525 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__alloc_pages+75/400] [__get_free_pages+32/48] [schedule_timeout+88/176] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1957506/128] [process_timeout+0/32]
Jul  7 14:28:30 kalimero kernel:   [sock_poll+44/64] [do_select+276/544] [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: kdeinit       S E7B7BF2C     8 30677   2181         31205 30131 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__alloc_pages+75/400] [__get_free_pages+32/48] [schedule_timeout+88/176] [af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-1957506/128] [process_timeout+0/32]
Jul  7 14:28:30 kalimero kernel:   [sock_poll+44/64] [do_select+276/544] [sys_select+794/1200] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: kdeinit       S E7793F2C     0 31205   2181 31206         30677 (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [__alloc_pages+75/400] [schedule_timeout+88/176] [process_timeout+0/32] [do_select+276/544] [sys_select+794/1200]
Jul  7 14:28:30 kalimero kernel:   [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: bash          S E7B20000     0 31206  31205 31236               (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [tty_check_change+66/160] [sys_wait4+303/1040] [system_call+51/56]
Jul  7 14:28:30 kalimero kernel: bash          S C013278C     0 31236  31206                     (NOTLB)
Jul  7 14:28:30 kalimero kernel: Call Trace:    [do_no_page+140/864] [__global_cli+100/112] [schedule_timeout+165/176] [write_chan+335/512] [read_chan+579/1616]Jul  7 14:28:30 kalimero kernel:   [tty_read+352/416] [sys_read+150/448] [system_call+51/56]
Jul  7 14:31:00 kalimero kernel: 3w-xxxx: scsi0: Unit #0: Command (f7c48400) timed out, resetting card.

Hm, still 90 seconds between the trace and the hang :( No processes seem to be stuck yet.
I'll redo it, to provide a more useful report.
I wonder if anyone can distillate something from these data already ?

regards,

Vincent
