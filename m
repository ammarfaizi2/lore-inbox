Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264102AbUESHxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264102AbUESHxn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 03:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264103AbUESHxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 03:53:43 -0400
Received: from ultra1.eskimo.com ([204.122.16.64]:26640 "EHLO
	ultra1.eskimo.com") by vger.kernel.org with ESMTP id S264102AbUESHxj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 03:53:39 -0400
Date: Wed, 19 May 2004 00:53:36 -0700
From: Elladan <elladan@eskimo.com>
To: linux-kernel@vger.kernel.org
Subject: Consistent deadlock+crash in 2.6.5 when writing large file to CFSd (over NFS)
Message-ID: <20040519075336.GA2020@eskimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting consistent crashes in 2.6.5 when I write a large file to cfs
(crypto file system).  This is a user daemon that implements an NFS
export of encrypted files on disk.

Basically, what appears to happen is that it's deadlocking something in
the IO system.  I can't really tell what, because the entire system
seizes up soon afterward.

The behavior is as follows:

1. cp largefile /crypt/ell/  (largefile is on disk b, the crypto area is
   on disk a)
2. Disk activity is high for a brief period of time (a few seconds)
3. Disk activity falls to nothing.  A quick inspection with ps alx
   indicates that more and more processes are stacking up in D state,
   blocked on "schedu".  These may be processes accessing any disk.
4. Periodically, the system may unfreeze briefly, causing a huge burst
   of IO.  But it'll stop again within a few seconds.
5. Eventually, the system will deadlock completely and have to be power
   cycled.
6. However, until it deadlocks, some commands are able to touch the
   disks, and I'm able to look at some directories that aren't already
   in cache etc.

Here's some random data:

Linux tandu 2.6.5 #12 Sun Apr 25 13:01:19 PDT 2004 i686 GNU/Linux

Module                  Size  Used by
usblp                  11200  0 
pl2303                 14980  0 
usbserial              27056  1 pl2303
joydev                  8256  0 
ehci_hcd               24132  0 
ohci_hcd               16900  0 
nvidia_agp              5788  1 
tuner                  17100  0 
tvaudio                20428  0 
bttv                  141804  0 
video_buf              16580  1 bttv
i2c_algo_bit            8904  1 bttv
v4l2_common             4928  1 bttv
btcx_risc               3848  1 bttv
videodev                7296  1 bttv
snd_emu10k1            92292  0 
snd_rawmidi            20448  1 snd_emu10k1
snd_pcm_oss            49124  0 
snd_mixer_oss          17408  1 snd_pcm_oss
snd_pcm                85348  2 snd_emu10k1,snd_pcm_oss
snd_timer              21636  1 snd_pcm
snd_seq_device          6536  2 snd_emu10k1,snd_rawmidi
snd_ac97_codec         61444  1 snd_emu10k1
snd_page_alloc          8964  2 snd_emu10k1,snd_pcm
snd_util_mem            3264  1 snd_emu10k1
snd_hwdep               7264  1 snd_emu10k1
snd                    45732  10 snd_emu10k1,snd_rawmidi,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_seq_device,snd_ac97_codec,snd_util_mem,snd_hwdep
soundcore               7392  2 bttv,snd
i2c_sensor              2368  0 
i2c_isa                 1664  0 
i2c_nforce2             5120  0 
i2c_core               18756  7 tuner,tvaudio,bttv,i2c_algo_bit,i2c_sensor,i2c_isa,i2c_nforce2
agpgart                28072  1 nvidia_agp
sg                     29472  0 


F   UID   PID  PPID PRI  NI   VSZ  RSS WCHAN  STAT TTY        TIME COMMAND
4     0     1     0  16   0  1528  528 schedu S    ?          0:04 init [2]  
1     0     2     1  34  19     0    0 ksofti SN   ?          0:00 [ksoftirqd/0]
5     0     3     1   5 -10     0    0 worker S<   ?          0:00 [events/0]
1     0     4     3   5 -10     0    0 worker S<   ?          0:00 [kblockd/0]
1     0     6     3  20   0     0    0 pdflus S    ?          0:00 [pdflush]
1     0     5     1  15   0     0    0 hub_th S    ?          0:00 [khubd]
1     0     7     3  15   0     0    0 pdflus S    ?          0:00 [pdflush]
1     0     9     3  10 -10     0    0 worker S<   ?          0:00 [aio/0]
1     0     8     1  15   0     0    0 kswapd S    ?          0:00 [kswapd0]
1     0    10     1  19   0     0    0 down_i S    ?          0:00 [khpsbpkt]
1     0    11     1  19   0     0    0 serio_ S    ?          0:00 [kseriod]
1     0    12     1  15   0     0    0 kjourn S    ?          0:00 [kjournald]
1     0   172     1  16   0     0    0 kjourn S    ?          0:00 [kjournald]
1     0   173     1  15   0     0    0 kjourn S    ?          0:00 [kjournald]
1     0   174     3   5 -10     0    0 worker S<   ?          0:00 [reiserfs/0]
1     0   175     1  18   0     0    0 kjourn S    ?          0:00 [kjournald]
1     0   176     1  16   0     0    0 kjourn S    ?          0:00 [kjournald]
1     0   177     1  15   0     0    0 kjourn S    ?          0:00 [kjournald]
5     1  1259     1  16   0  1640  444 schedu Ss   ?          0:00 /sbin/portmap
5     0  1357     1  15   0  2284  820 schedu Ds   ?          0:00 /sbin/syslogd
5     0  1360     1  16   0  2488 1460 syslog Ss   ?          0:00 /sbin/klogd
5     0  1396     1  16   0  2900 1732 schedu Ss   ?          0:00 /usr/sbin/named
5     0  1413     1  16   0  2616 1040 schedu S    ?          0:00 ptal-mlcd mlc:usb:photosmart_7200_series -devidmatch MDL:photosmart 7200 series; -devidmatch SN:CN39G3B8CPI5; -device /dev/usb/lp[0-9]* /dev/usblp[0-9]*
5     0  1416     1  17   0  3216  856 schedu S    ?          0:00 ptal-printd mlc:usb:photosmart_7200_series -morepipes 9 -like /etc/ptal/ptal-printd-like
5     0  1419     1  19   0  3220  844 schedu S    ?          0:00 ptal-photod mlc:usb:photosmart_7200_series -maxaltports 26
5     0  1425     1  18   0  2404  924 schedu Ss   ?          0:00 /sbin/rpc.statd
5     0  1459     1  16   0  2416  948 schedu S    ?          0:00 /usr/sbin/ez-ipupdate -d -c /etc/ez-ipupdate/tandu.conf -F /var/run/ez-ipupdate/tandu.pid
5     0  1463     1  18   0  2768 1160 schedu Ss   ?          0:00 /usr/sbin/famd -T 0
5     0  1473     1  15   0  2264  716 schedu Ss   ?          0:00 /usr/sbin/inetd
1     1  1484     1  17   0  4068 1296 schedu Ss   ?          0:00 lpd Waiting  
4     0  1499     1  24   0  2540 1236 wait4  S    ?          0:00 /bin/sh /usr/bin/mysqld_safe
4   102  1534  1499  15   0 67340 7840 schedu S    ?          0:00 /usr/sbin/mysqld --basedir=/usr --datadir=/var/lib/mysql --user=mysql --pid-file=/var/run/mysqld/mysqld.pid --skip-locking --port=3306 --socket=/var/run/mysqld/mysqld.sock
1   108  1550     1  16   0 104248 14612 schedu Ss ?          0:00 /usr/bin/mythbackend --daemon --logfile /var/log/mythtv/mythbackend.log --pidfile /var/run/mythtv/mythbackend.pid
0    31  1595     1  15   0 17112 2180 schedu S    ?          0:00 /usr/lib/postgresql/bin/postmaster -D /var/lib/postgres/data
1    31  1599  1595  15   0  7912 1972 schedu S    ?          0:00 postgres: stats buffer process                              
1    31  1600  1599  15   0  7052 2036 schedu S    ?          0:00 postgres: stats collector process                           
0   108  1607  1606  34  19 59776 32492 schedu DN  ?          2:17 mythtranscode -c 1007 -s 2004-05-15T21:00:00 -p autodetect -d -l
1    31  1621     1  15   0  4556 1592 schedu Ss   ?          0:00 /usr/lib/postgresql/bin/pg_autovacuum -D -p 5432 -L /var/log/postgresql/autovacuum_log
5     0  1631     1  18   0  1548  476 schedu Ss   ?          0:00 /usr/sbin/smartd
5     0  1685     1  18   0 

Note that mythtranscode appears to have seized up in this dump.  Also
note that the dump stops right where it appears to stop.  The computer
crashed.

No, the kernel isn't tainted.

Any ideas?

-J
