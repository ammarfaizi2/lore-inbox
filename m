Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbTKCMry (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 07:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbTKCMrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 07:47:53 -0500
Received: from witte.sonytel.be ([80.88.33.193]:49900 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262038AbTKCMrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 07:47:49 -0500
Date: Mon, 3 Nov 2003 13:47:44 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: ext3/inode/dentry mem leak?
Message-ID: <Pine.GSO.4.21.0311031332280.20074-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

When repartitioning my laptop and restoring all data, my machine got slower and
slower, and almost all memory was exhausted, while nothing but critical
processes were running.

What I did:

    ssh geert@remote.host "cat backup.tar" | tar xf -

The archive was 8.3 GB, but it contained lots of hard links (all
2.2/2.4/2.5/2.6 Linux kernel source trees, with identical files linked
together).  At first restore went quite fast, but it got slower and slower.  In
total it took my `poor' machine (700 MHz Mobile Pentium III, 128 MB RAM) more
than 4 hours, i.e. only 549 kB/s.

After that I gathered some data (see below), rebooted, and restored other
(smaller) archives without such hard links, which was much much faster (4-5
MB/s).

The filesystem was ext3 on a freshly mke2fs'd partition on a PIIX4 IDE disk.
Network is eepro100 Ethernet. Kernel is 2.4.21.

As you can see below, more than 90 MB was in use, which is much more than the
combined resident memory size of all processes. The inode_cache and
dentry_cache are very large.

Is this a known problem? Perhaps it got fixed in a later kernel version?

Thanks!

ps aux:

| USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
| root         1  0.0  0.0  1460   84 ?        S    13:39   0:04 init [2]   
| root         2  0.0  0.0     0    0 ?        SW   13:39   0:05 [keventd]
| root         3  0.0  0.0     0    0 ?        SWN  13:39   0:00 [ksoftirqd_CPU0]
| root         4  0.0  0.0     0    0 ?        SW   13:39   0:19 [kswapd]
| root         5  0.0  0.0     0    0 ?        SW   13:39   0:00 [bdflush]
| root         6  0.0  0.0     0    0 ?        SW   13:39   0:00 [kupdated]
| root         7  0.0  0.0     0    0 ?        SW   13:39   0:00 [kjournald]
| root        67  0.0  0.0     0    0 ?        SW   13:39   0:00 [knodemgrd_0]
| root        69  0.0  0.0     0    0 ?        SW   13:39   0:00 [scsi_eh_0]
| root        71  0.0  0.0     0    0 ?        SW   13:39   0:00 [khubd]
| root       103  0.0  0.0     0    0 ?        SW   13:39   0:00 [kjournald]
| root       105  0.0  0.0     0    0 ?        SW   13:39   0:00 [kjournald]
| root       112  0.0  0.0     0    0 ?        SW   13:39   0:00 [usb-storage-0]
| root       113  0.0  0.0     0    0 ?        SW   13:39   0:00 [scsi_eh_1]
| root       143  0.0  0.2  1676  312 ?        S    13:39   0:00 pump -i eth0
| daemon     151  0.0  0.0  1680    8 ?        S    13:39   0:00 /sbin/portmap
| root       238  0.0  0.2  3040  324 ?        S    13:40   0:00 /usr/sbin/sshd
| root       249  0.0  0.1  1516  228 ?        S    13:40   0:00 /sbin/syslogd
| root       252  0.0  0.0  1596    8 ?        S    13:40   0:00 /sbin/klogd
| root       274  0.0  0.0  1476    8 ?        S    13:40   0:00 /sbin/cardmgr -C config-2.4
| root       286  0.0  0.0  1468   36 ?        S    13:40   0:00 /usr/sbin/acpid -c /etc/acpi/events -S
| root       358  0.0  0.0  1556   68 ?        S    13:40   0:00 /usr/sbin/automount --pid-file=/var/run/autofs/_:var_:autofs_:misc.pid --timeout=300 /var/autofs/misc file /etc/auto.misc
| root       363  0.0  0.0  1556   68 ?        S    13:40   0:00 /usr/sbin/automount --pid-file=/var/run/autofs/_:home.pid --timeout=300 /home file /etc/auto.home
| root       373  0.0  0.0  1744    8 ?        S    13:40   0:00 /usr/sbin/gpm -m /dev/psaux -t ps2 -r 20 -Rms3
| root       384  0.0  0.0  1480   48 ?        S    13:40   0:00 /usr/sbin/ifplugd -i eth0 -q -f -u0 -d20 -w
| root       390  0.0  0.0  1496    4 ?        S    13:40   0:00 /usr/sbin/inetd
| root       401  0.0  0.0     0    0 ?        SW   13:40   0:00 [nfsd]
| root       402  0.0  0.0     0    0 ?        SW   13:40   0:00 [nfsd]
| root       403  0.0  0.0     0    0 ?        SW   13:40   0:00 [nfsd]
| root       404  0.0  0.0     0    0 ?        SW   13:40   0:00 [nfsd]
| root       405  0.0  0.0     0    0 ?        SW   13:40   0:00 [lockd]
| root       406  0.0  0.0     0    0 ?        SW   13:40   0:00 [rpciod]
| root       407  0.0  0.0     0    0 ?        SW   13:40   0:00 [nfsd]
| root       408  0.0  0.0     0    0 ?        SW   13:40   0:00 [nfsd]
| root       409  0.0  0.0     0    0 ?        SW   13:40   0:00 [nfsd]
| root       410  0.0  0.0     0    0 ?        SW   13:40   0:00 [nfsd]
| root       413  0.0  0.0  1764    4 ?        S    13:40   0:00 /usr/sbin/rpc.mountd
| uml-net    422  0.0  0.0  1456   52 ?        S    13:40   0:00 /usr/bin/uml_switch -unix /var/run/uml-utilities/uml_switch.ctl
| root       512  0.0  0.0  1636   28 ?        S    13:40   0:00 /sbin/rpc.statd
| root       560  0.0  0.3  2640  476 tty1     S    13:41   0:00 -bash
| root       561  0.0  0.0  2640   44 tty2     S    13:41   0:00 -bash
| root       562  0.0  0.0  1456   36 tty3     S    13:41   0:00 /sbin/getty 38400 tty3
| root       563  0.0  0.0  1456   36 tty4     S    13:41   0:00 /sbin/getty 38400 tty4
| root       564  0.0  0.0  1456   36 tty5     S    13:41   0:00 /sbin/getty 38400 tty5
| root       565  0.0  0.0  1456   36 tty6     S    13:41   0:00 /sbin/getty 38400 tty6
| root      1728  0.0  0.0     0    0 ?        SW   15:16   0:13 [kjournald]
| root      2466  0.2  1.2  5960 1636 ?        S    21:38   0:00 sshd: root@pts/0
| root      2468  0.0  1.1  2608 1484 pts/0    S    21:38   0:00 -bash
| root      2471  0.0  0.6  2828  840 pts/0    R    21:38   0:00 ps aux

free:

|              total       used       free     shared    buffers     cached
| Mem:        127432     123444       3988          0      17568      10532
| -/+ buffers/cache:      95344      32088
| Swap:       248968       2340     246628

cat /proc/slabinfo:

| slabinfo - version: 1.1
| kmem_cache            61     68    112    2    2    1
| urb_priv               1     59     64    1    1    1
| hpsb_packet            0      0    100    0    0    1
| tcp_tw_bucket          0      0     96    0    0    1
| tcp_bind_bucket       15    113     32    1    1    1
| tcp_open_request       0     59     64    0    1    1
| inet_peer_cache        0     59     64    0    1    1
| ip_fib_hash            9    113     32    1    1    1
| ip_dst_cache           6     24    160    1    1    1
| arp_cache              1     30    128    1    1    1
| blkdev_requests      256    280     96    7    7    1
| journal_head          47   2184     48    1   28    1
| revoke_table           4    253     12    1    1    1
| revoke_record          0      0     32    0    0    1
| dnotify_cache          0      0     20    0    0    1
| file_lock_cache        0     40     96    0    1    1
| fasync_cache           0      0     16    0    0    1
| uid_cache              2    113     32    1    1    1
| skbuff_head_cache    115    120    160    5    5    1
| sock                  43     50    800   10   10    1
| sigqueue               0     29    132    0    1    1
| kiobuf                 0      0     64    0    0    1
| cdev_cache            13    118     64    2    2    1
| bdev_cache             6     59     64    1    1    1
| mnt_cache             17     59     64    1    1    1
| inode_cache        92000 102776    480 12847 12847    1
| dentry_cache      235246 275280    128 9176 9176    1
| dquot                  0      0    128    0    0    1
| filp                 492    510    128   17   17    1
| names_cache            0      2   4096    0    2    1
| buffer_head         9956  10000     96  250  250    1
| mm_struct             25     48    160    2    2    1
| vm_area_struct       433    640     96   16   16    1
| fs_cache              24    113     32    1    1    1
| files_cache           24     36    416    4    4    1
| signal_act            45     51   1312   17   17    1
| size-131072(DMA)       0      0 131072    0    0   32
| size-131072            0      0 131072    0    0   32
| size-65536(DMA)        0      0  65536    0    0   16
| size-65536             0      0  65536    0    0   16
| size-32768(DMA)        0      0  32768    0    0    8
| size-32768             1      1  32768    1    1    8
| size-16384(DMA)        0      0  16384    0    0    4
| size-16384             9      9  16384    9    9    4
| size-8192(DMA)         0      0   8192    0    0    2
| size-8192             11     11   8192   11   11    2
| size-4096(DMA)         0      0   4096    0    0    1
| size-4096             30     30   4096   30   30    1
| size-2048(DMA)         0      0   2048    0    0    1
| size-2048             77     82   2048   40   41    1
| size-1024(DMA)         0      0   1024    0    0    1
| size-1024             34     36   1024    9    9    1
| size-512(DMA)          0      0    512    0    0    1
| size-512             118    120    512   15   15    1
| size-256(DMA)          0      0    256    0    0    1
| size-256              14     15    256    1    1    1
| size-128(DMA)          1     30    128    1    1    1
| size-128            1945   1980    128   66   66    1
| size-64(DMA)           0      0     64    0    0    1
| size-64              170    236     64    4    4    1
| size-32(DMA)          18    113     32    1    1    1
| size-32             9992  11413     32  101  101    1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

