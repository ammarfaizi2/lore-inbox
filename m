Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161033AbVLODtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161033AbVLODtb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 22:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161036AbVLODtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 22:49:31 -0500
Received: from main.gmane.org ([80.91.229.2]:12453 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161033AbVLODta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 22:49:30 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: Help track a memory leak in 2.6.0..14
Date: Thu, 15 Dec 2005 12:44:22 +0900
Message-ID: <dnqp0b$96k$1@sea.gmane.org>
References: <43954489.5040309@thinrope.net> <1133856214.2858.13.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051023)
X-Accept-Language: en-us, en
In-Reply-To: <1133856214.2858.13.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.93.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>Who uses that memory?
> 
> 
> the programs
> 
> slabtop
> xrestop
> cat /proc/meminfo
> 
> are probably good starting points to find the leak; they give a detailed
> overview of various memory pools

Thank you for the info, I didn't know about xrestop :-)

So here is a present state of the machine:
ss ~ # date
Thu Dec 15 12:19:16 JST 2005
ss ~ # free -m
             total       used       free     shared    buffers     cached
Mem:           233        228          5          0         64          8
-/+ buffers/cache:        155         78
Swap:            0          0          0

ss ~ # cat /proc/meminfo
MemTotal:       239460 kB
MemFree:          5588 kB
Buffers:         66212 kB
Cached:           8920 kB
SwapCached:          0 kB
Active:          53708 kB
Inactive:        28328 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       239460 kB
LowFree:          5588 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:           9752 kB
Slab:           148528 kB
CommitLimit:    119728 kB
Committed_AS:    16316 kB
PageTables:        260 kB
VmallocTotal:   794324 kB
VmallocUsed:      2276 kB
VmallocChunk:   791880 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB

ss ~ # ps -A v k-size
  PID TTY      STAT   TIME  MAJFL   TRS   DRS   RSS %MEM COMMAND
 5153 tty2     Ss+    0:01     10   515  4384  2044  0.8 -bash
 4140 ?        Ss     0:00    298   247  4724   860  0.3 /usr/sbin/cupsd
 6572 pts/0    Ss     0:01      2   515  4124  2832  1.1 -bash
 6720 pts/0    R+     0:00      0    55  2676   760  0.3 ps -A v k-size 50
 3448 ?        Ss     0:00     17   133  1894  1044  0.4 /usr/sbin/cannaserver
 6567 ?        Ss     0:00      6   292  6087  2112  0.8 sshd: root@pts/0
 4044 ?        Ss     0:00      4   319  1796   736  0.3 /sbin/dhclient -cf /etc/dhcp/dhclient.co
 4680 ?        Ss     0:00     60    21  2146   500  0.2 login -- kalin
 4485 ?        Ss     0:00      3   292  3103   404  0.1 /usr/sbin/sshd
 3381 ?        Ss     0:00     28   100  1747   564  0.2 /usr/sbin/syslog-ng
 4363 ?        Ss     0:00      0    33  1694   120  0.0 /sbin/rpc.statd
 4681 tty3     Ss+    0:00      0    11  1452    64  0.0 /sbin/agetty 38400 tty3 linux
 4704 tty4     Ss+    0:00      0    11  1452    64  0.0 /sbin/agetty 38400 tty4 linux
 4709 tty5     Ss+    0:00      0    11  1452    60  0.0 /sbin/agetty 38400 tty5 linux
 6015 tty1     Ss+    0:00      1    11  1452   520  0.2 /sbin/agetty 38400 tty1 linux
 4288 ?        Ss     0:00      0    10  1681   116  0.0 /sbin/portmap
 4714 tty6     Ss+    0:00      0    11  1448    60  0.0 /sbin/agetty 38400 tty6 linux
  841 ?        S<s    0:00      1    22  1445   212  0.0 udevd
    1 ?        S      0:00    345    22  1441   160  0.0 init [3]
 4215 ?        Ss     0:07    739    16  2083   212  0.0 /usr/sbin/fnfxd
 4550 ?        Ss     0:00    186     9  1454   284  0.1 /usr/sbin/uptimed
    2 ?        SN     0:00      0     0     0     0  0.0 [ksoftirqd/0]
    3 ?        S<     0:00      0     0     0     0  0.0 [events/0]
    4 ?        S<     0:00      0     0     0     0  0.0 [khelper]
    5 ?        S<     0:00      0     0     0     0  0.0 [kthread]
    7 ?        S<     0:47      0     0     0     0  0.0 [kacpid]
   95 ?        S<     0:00      0     0     0     0  0.0 [kblockd/0]
  134 ?        S      0:00      0     0     0     0  0.0 [pdflush]
  137 ?        S<     0:00      0     0     0     0  0.0 [aio/0]
  136 ?        S      0:01      0     0     0     0  0.0 [kswapd0]
  724 ?        S<     0:00      0     0     0     0  0.0 [kseriod]
  753 ?        S<     0:00      0     0     0     0  0.0 [reiserfs/0]
 1245 ?        S<     0:00      0     0     0     0  0.0 [khubd]
 1410 ?        S      0:00      0     0     0     0  0.0 [pccardd]
 1477 ?        S      0:00      0     0     0     0  0.0 [pccardd]
 4399 ?        S<     0:01      0     0     0     0  0.0 [rpciod/0]
 4400 ?        S      0:00      0     0     0     0  0.0 [lockd]
 5330 ?        S      0:00      0     0     0     0  0.0 [pdflush]

According to slabtop:
 Active / Total Objects (% used)    : 1806688 / 1826914 (98.9%)
 Active / Total Slabs (% used)      : 36958 / 36958 (100.0%)
 Active / Total Caches (% used)     : 64 / 106 (60.4%)
 Active / Total Size (% used)       : 138777.10K / 143195.01K (96.9%)
 Minimum / Average / Maximum Object : 0.02K / 0.08K / 128.00K

  OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
1768936 1768884  99%    0.07K  34018       52    136072K size-64
 19642  16616  84%    0.06K    322       61      1288K buffer_head
 10152   4828  47%    0.14K    376       27      1504K dentry_cache

ss ~ # cat /proc/slabinfo |grep "size-64 "
size-64           1767932 1768000     76   52    1 : tunables   32   16    0 : slabdata  33999
34000      0 : globalstat 21513120 1767964 34005    0    0    1   84    0 : cpustat 614583639
1370079 612951759 1234047

ss ~ # lsmod
Module                  Size  Used by
nfs                   114540  1
lockd                  66920  2 nfs
nfs_acl                 3680  1 nfs
sunrpc                152004  4 nfs,lockd,nfs_acl
usbhid                 27876  0
yenta_socket           26028  2
rsrc_nonstatic         14112  1 yenta_socket
ehci_hcd               33224  0
ohci_hcd               21988  0
usbcore               125660  4 usbhid,ehci_hcd,ohci_hcd
e100                   37984  0
mii                     5568  1 e100

OK, now stop whatever I can, unload most modules and again:

ss ~ # free -m
             total       used       free     shared    buffers     cached
Mem:           233        227          6          0         63         10
-/+ buffers/cache:        153         80
Swap:            0          0          0

ss ~ # ps -A v k-size
  PID TTY      STAT   TIME  MAJFL   TRS   DRS   RSS %MEM COMMAND
 5153 tty2     Ss+    0:01     10   515  4384  2044  0.8 -bash
 6572 pts/0    Ss     0:01      2   515  4124  2840  1.1 -bash
 7352 pts/0    R+     0:00      0    55  2676   756  0.3 ps -A v k-size
 6567 ?        Ss     0:00      6   292  6087  2112  0.8 sshd: root@pts/0
 4044 ?        Ss     0:00      4   319  1796   736  0.3 /sbin/dhclient -cf /etc/dhcp/dhclient.co
 4680 ?        Ss     0:00     60    21  2146   500  0.2 login -- kalin
 4485 ?        Ss     0:00      3   292  3103   404  0.1 /usr/sbin/sshd
 3381 ?        Ss     0:00     28   100  1747   564  0.2 /usr/sbin/syslog-ng
 4681 tty3     Ss+    0:00      0    11  1452    64  0.0 /sbin/agetty 38400 tty3 linux
 4704 tty4     Ss+    0:00      0    11  1452    64  0.0 /sbin/agetty 38400 tty4 linux
 4709 tty5     Ss+    0:00      0    11  1452    60  0.0 /sbin/agetty 38400 tty5 linux
 6015 tty1     Ss+    0:00      1    11  1452   520  0.2 /sbin/agetty 38400 tty1 linux
 4714 tty6     Ss+    0:00      0    11  1448    60  0.0 /sbin/agetty 38400 tty6 linux
  841 ?        S<s    0:00      1    22  1445   256  0.1 udevd
    1 ?        S      0:00    345    22  1441   160  0.0 init [3]
 4550 ?        Ss     0:00    186     9  1454   284  0.1 /usr/sbin/uptimed
    2 ?        SN     0:00      0     0     0     0  0.0 [ksoftirqd/0]
    3 ?        S<     0:00      0     0     0     0  0.0 [events/0]
    4 ?        S<     0:00      0     0     0     0  0.0 [khelper]
    5 ?        S<     0:00      0     0     0     0  0.0 [kthread]
    7 ?        S<     0:47      0     0     0     0  0.0 [kacpid]
   95 ?        S<     0:00      0     0     0     0  0.0 [kblockd/0]
  134 ?        S      0:00      0     0     0     0  0.0 [pdflush]
  137 ?        S<     0:00      0     0     0     0  0.0 [aio/0]
  136 ?        S      0:01      0     0     0     0  0.0 [kswapd0]
  724 ?        S<     0:00      0     0     0     0  0.0 [kseriod]
  753 ?        S<     0:00      0     0     0     0  0.0 [reiserfs/0]
 1245 ?        S<     0:00      0     0     0     0  0.0 [khubd]
 1410 ?        S      0:00      0     0     0     0  0.0 [pccardd]
 1477 ?        S      0:00      0     0     0     0  0.0 [pccardd]
 5330 ?        S      0:00      0     0     0     0  0.0 [pdflush]

ss ~ # cat /proc/slabinfo |grep "size-64 "
size-64           1770831 1770860     76   52    1 : tunables   32   16    0 : slabdata  34055
34055      0 : globalstat 21551153 1770860 34060    0    0    1   84    0 : cpustat 615607009
1372499 613972465 1236227

ss ~ # lsmod
Module                  Size  Used by
yenta_socket           26028  2
rsrc_nonstatic         14112  1 yenta_socket
usbcore               125660  1
e100                   37984  0
mii                     5568  1 e100

Now, I cannot `kill -9 1410` or 1477 (the pccard) or unload yeanta_socket and rsrc_nonstatic (that
never worked).

ss ~ # reboot

Now let's how things changed... From 153MB we are back down to 14MB in use... that is a leak of more
than half my pshysical RAM...

ss ~ # free -m
             total       used       free     shared    buffers     cached
Mem:           233         29        204          0          3         11
-/+ buffers/cache:         14        219
Swap:            0          0          0

ss ~ # cat /proc/meminfo
MemTotal:       239460 kB
MemFree:        209544 kB
Buffers:          3324 kB
Cached:          12276 kB
SwapCached:          0 kB
Active:          14448 kB
Inactive:         5720 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       239460 kB
LowFree:        209544 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:           7996 kB
Slab:             6564 kB
CommitLimit:    119728 kB
Committed_AS:    13456 kB
PageTables:        252 kB
VmallocTotal:   794324 kB
VmallocUsed:      2276 kB
VmallocChunk:   791880 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB

ss ~ # lsmod
Module                  Size  Used by
nfs                   114540  1
lockd                  66920  2 nfs
nfs_acl                 3680  1 nfs
sunrpc                152004  4 nfs,lockd,nfs_acl
usbhid                 27876  0
yenta_socket           26028  2
rsrc_nonstatic         14112  1 yenta_socket
ehci_hcd               33224  0
ohci_hcd               21988  0
usbcore               125660  4 usbhid,ehci_hcd,ohci_hcd
e100                   37984  0
mii                     5568  1 e100
ss ~ # cat /proc/slabinfo |grep "size-64 "
size-64             1264   1300     76   52    1 : tunables   32   16    0 : slabdata     25     25
     0 : globalstat    6357   1280    31    1    0    1   84    0 : cpustat 151935    427 150804    317
ss ~ # ps -A v k-size
  PID TTY      STAT   TIME  MAJFL   TRS   DRS   RSS %MEM COMMAND
 4065 ?        Ss     0:00     10   247  4724  1872  0.7 /usr/sbin/cupsd
 4651 pts/0    Ss     0:00      8   515  3992  2804  1.1 -bash
 4678 pts/0    R+     0:00      0    55  2676   760  0.3 ps -A v k-size
 3969 ?        Ss     0:00      0   319  1796   996  0.4 /sbin/dhclient -cf /etc/dhcp/dhclient.co
 4646 ?        Ss     0:00      2   292  5927  2060  0.8 sshd: root@pts/0
 4410 ?        Ss     0:00      0   292  3103  1508  0.6 /usr/sbin/sshd
 3373 ?        Ss     0:00      0   133  1634   764  0.3 /usr/sbin/cannaserver
 3306 ?        Ss     0:00      0   100  1747   880  0.3 /usr/sbin/syslog-ng
 4288 ?        Ss     0:00      0    33  1698   824  0.3 /sbin/rpc.statd
 4213 ?        Ss     0:00      0    10  1685   648  0.2 /sbin/portmap
 4619 tty3     Ss+    0:00      0    11  1452   528  0.2 /sbin/agetty 38400 tty3 linux
 4621 tty5     Ss+    0:00      0    11  1452   528  0.2 /sbin/agetty 38400 tty5 linux
  801 ?        S<s    0:00      0    22  1449   480  0.2 udevd
 4614 tty1     Ss+    0:00      0    11  1448   524  0.2 /sbin/agetty 38400 tty1 linux
 4618 tty2     Ss+    0:00      0    11  1448   520  0.2 /sbin/agetty 38400 tty2 linux
 4620 tty4     Ss+    0:00      0    11  1448   524  0.2 /sbin/agetty 38400 tty4 linux
 4622 tty6     Ss+    0:00      0    11  1448   524  0.2 /sbin/agetty 38400 tty6 linux
    1 ?        S      0:00     16    22  1441   504  0.2 init [3]
 4140 ?        Ss     0:00      0    16  2083   560  0.2 /usr/sbin/fnfxd
 4475 ?        Ss     0:00      0     9  1450   508  0.2 /usr/sbin/uptimed
    2 ?        SN     0:00      0     0     0     0  0.0 [ksoftirqd/0]
    3 ?        S<     0:00      0     0     0     0  0.0 [events/0]
    4 ?        S<     0:00      0     0     0     0  0.0 [khelper]
    5 ?        S<     0:00      0     0     0     0  0.0 [kthread]
    7 ?        S<     0:00      0     0     0     0  0.0 [kacpid]
   95 ?        S<     0:00      0     0     0     0  0.0 [kblockd/0]
  134 ?        S      0:00      0     0     0     0  0.0 [pdflush]
  135 ?        S      0:00      0     0     0     0  0.0 [pdflush]
  137 ?        S<     0:00      0     0     0     0  0.0 [aio/0]
  136 ?        S      0:00      0     0     0     0  0.0 [kswapd0]
  724 ?        S<     0:00      0     0     0     0  0.0 [kseriod]
  753 ?        S<     0:00      0     0     0     0  0.0 [reiserfs/0]
 1243 ?        S<     0:00      0     0     0     0  0.0 [khubd]
 1411 ?        S      0:00      0     0     0     0  0.0 [pccardd]
 1490 ?        S      0:00      0     0     0     0  0.0 [pccardd]
 4324 ?        S<     0:00      0     0     0     0  0.0 [rpciod/0]
 4325 ?        S      0:00      0     0     0     0  0.0 [lockd]

ss ~ # uname -a
Linux ss 2.6.13.3-ss #1 Tue Oct 18 14:08:05 Local time zone must be set--see zic manu i686 Intel(R)
Pentium(R) III Mobile CPU       800MHz GenuineIntel GNU/Linux

** Hmm, have to check my timezone :-) **

So, given all this info, does anybody see anything strange? What else can I do?
Or, I should put kdb in action...
What else can I compare before and after a reboot?
Will /proc/config.gz provide any info (just trying to save bandwith, can post it anytime)?

This is a vanilla 2.6.13.3 + mppe-mppc-1.3.patch (as module), but the patch/module was never
used/loaded for this session.

NB: In this situation, X was shut down, so xrestop is irrelevant.

Thank you,
Kalin.
-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

