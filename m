Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267470AbUHPGgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267470AbUHPGgN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 02:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267473AbUHPGgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 02:36:13 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:37903 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S267470AbUHPGff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 02:35:35 -0400
Message-ID: <XFMail.20040816033530.fraga@abusar.org>
X-Mailer: XFMail 1.5.5 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
Date: Mon, 16 Aug 2004 03:35:30 -0300 (BRT)
Organization: http://U-br.tk
From: Daniel Fraga <fraga@abusar.org>
To: linux-kernel@vger.kernel.org
Subject: OOPS: 2.6.8.1 QoS and routing conflict (bug)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Hi! First of all the most important:

a) the following "oops" was introduced in the 2.6.8 kernel (2.6.7 and
below are not affected)

b) this is a *reproducible* bug

        ***

[1.] One line summary of the problem:

        Oops when trying to set default route when QoS is configured 
and active

[2.] Full description of the problem/report:

        When I upgraded from 2.6.7 to 2.6.8(.1) kernel, it showed an
Oops (below with ksymoops output) when the initialization scripts tried to 
set the default route with the following command:

        ip route add default via <ip>

        I use wondershaper (lartc.org) script to control my network traffic.
The oops just happens when I use wondershaper script, in other words,
just when HTB is properly configured:

qdisc htb 1: r2q 10 default 20 direct_packets_stat 0
 Sent 12832 bytes 92 pkts (dropped 0, overlimits 0) 

 qdisc sfq 10: quantum 1514b perturb 10sec 
 Sent 432 bytes 8 pkts (dropped 0, overlimits 0) 

 qdisc sfq 20: quantum 1514b perturb 10sec 
 Sent 12400 bytes 84 pkts (dropped 0, overlimits 0) 

 qdisc sfq 30: quantum 1514b perturb 10sec 
 Sent 0 bytes 0 pkts (dropped 0, overlimits 0) 

 qdisc ingress ffff: 
 Sent 12147 bytes 87 pkts (dropped 0, overlimits 0) 

        ***

class htb 1:1 root rate 9000Kbit ceil 9000Kbit burst 6Kb cburst 13117b 
 Sent 12338 bytes 90 pkts (dropped 0, overlimits 0) 
 lended: 0 borrowed: 0 giants: 0
 tokens: 5028 ctokens: 11229

class htb 1:10 parent 1:1 leaf 10: prio 1 rate 9000Kbit ceil 9000Kbit burst 6Kb cburst 13117b 
 Sent 432 bytes 8 pkts (dropped 0, overlimits 0) 
 lended: 8 borrowed: 0 giants: 0
 tokens: 5419 ctokens: 11620

class htb 1:20 parent 1:1 leaf 20: prio 2 rate 8100Kbit ceil 8100Kbit burst 6Kb cburst 11966b 
 Sent 11906 bytes 82 pkts (dropped 0, overlimits 0) 
 lended: 82 borrowed: 0 giants: 0
 tokens: 5587 ctokens: 11340

class htb 1:30 parent 1:1 leaf 30: prio 2 rate 7200Kbit ceil 7200Kbit burst 6Kb cburst 10814b 
 Sent 0 bytes 0 pkts (dropped 0, overlimits 0) 
 lended: 0 borrowed: 0 giants: 0
 tokens: 6825 ctokens: 12017

        ***

filter parent 1: protocol ip pref 10 u32 
filter parent 1: protocol ip pref 10 u32 fh 801: ht divisor 1 
filter parent 1: protocol ip pref 10 u32 fh 801::800 order 2048 key ht 801 bkt 0 flowid 1:20 
  match 00000000/00000000 at 16
filter parent 1: protocol ip pref 10 u32 fh 800: ht divisor 1 
filter parent 1: protocol ip pref 10 u32 fh 800::800 order 2048 key ht 800 bkt 0 flowid 1:10 
  match 00100000/00ff0000 at 0
filter parent 1: protocol ip pref 10 u32 fh 800::801 order 2049 key ht 800 bkt 0 flowid 1:10 
  match 00010000/00ff0000 at 8
filter parent 1: protocol ip pref 10 u32 fh 800::802 order 2050 key ht 800 bkt 0 flowid 1:10 
  match 00060000/00ff0000 at 8
  match 05000000/0f00ffc0 at 0
  match 00100000/00ff0000 at 32
filter parent 1: protocol ip pref 18 u32 
filter parent 1: protocol ip pref 18 u32 fh 801: ht divisor 1 
filter parent 1: protocol ip pref 18 u32 fh 801::800 order 2048 key ht 801 bkt 0 flowid 1:20 
  match 00000000/00000000 at 16
filter parent 1: protocol ip pref 18 u32 fh 800: ht divisor 1 
filter parent 1: protocol ip pref 18 u32 fh 800::800 order 2048 key ht 800 bkt 0 flowid 1:10 
  match 00100000/00ff0000 at 0
filter parent 1: protocol ip pref 18 u32 fh 800::801 order 2049 key ht 800 bkt 0 flowid 1:10 
  match 00010000/00ff0000 at 8
filter parent 1: protocol ip pref 18 u32 fh 800::802 order 2050 key ht 800 bkt 0 flowid 1:10 
  match 00060000/00ff0000 at 8
  match 05000000/0f00ffc0 at 0
  match 00100000/00ff0000 at 32

        ***

        Otherwise (if htb is compiled but *not* configured), default route can 
be set without problems. So I think the problem is related with the changes 
kernel 2.6.8 had in the QoS section.

[3.] Keywords (i.e., modules, networking, kernel):

Module                  Size  Used by
binfmt_misc            11336  1 
8250                   19168  2 
serial_core            21920  1 8250
ipt_LOG                 5952  2 
ipt_REJECT              6528  1 
ipt_state               2016  3 
iptable_filter          2688  1 
ip_tables              17632  4 ipt_LOG,ipt_REJECT,ipt_state,iptable_filter
tun                     8960  0 
sch_ingress             4292  1 
cls_u32                 7524  3 
sch_sfq                 5440  3 
sch_htb                23168  1 
ne2k_pci                7776  0 
8390                    9504  1 ne2k_pci
crc32                   4288  1 8390
ip_conntrack_ftp       71856  0 
ip_conntrack           33120  2 ipt_state,ip_conntrack_ftp
snd_sb16               13804  0 
snd_opl3_lib           10112  1 snd_sb16
snd_hwdep               9156  1 snd_opl3_lib
snd_sb16_dsp           10048  1 snd_sb16
snd_sb_common          15456  2 snd_sb16,snd_sb16_dsp
snd_mpu401_uart         7616  1 snd_sb16
snd_rawmidi            24548  1 snd_mpu401_uart
snd_seq_device          7976  2 snd_opl3_lib,snd_rawmidi
snd_pcm_oss            52200  0 
snd_pcm                93416  2 snd_sb16_dsp,snd_pcm_oss
snd_page_alloc         11208  1 snd_pcm
snd_timer              24868  2 snd_opl3_lib,snd_pcm
snd_mixer_oss          18336  1 snd_pcm_oss
snd                    55428  12 snd_sb16,snd_opl3_lib,snd_hwdep,snd_sb16_dsp,snd_sb_common,snd_mpu401_uart,snd_rawmidi,snd_seq
_device,snd_pcm_oss,snd_pcm,snd_timer,snd_mixer_oss
soundcore               9984  1 snd
pcspkr                  3624  0 
hangcheck_timer         3192  0 
w83781d                31680  0 
i2c_sensor              2784  1 w83781d
i2c_isa                 1984  0 
i2c_core               23088  3 w83781d,i2c_sensor,i2c_isa
rtc                    12248  0 
unix                   27316  214 

[4.] Kernel version (from /proc/version):

Linux version 2.6.8.1 (root@tux) (gcc version 3.4.1) #6 Mon Aug 
16 01:39:30 BRT 2004

[5.] Output of Oops and ksymoops:

        ***
        OOPS
        ***

Unable to handle kernel paging request at virtual address 808bc2dd
 printing eip:
c0249587
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: binfmt_misc 8250 serial_core ipt_LOG ipt_REJECT ipt_state iptable_filter ip_tables tun sch_ingress cls
_u32 sch_sfq sch_htb ne2k_pci 8390 crc32 ip_conntrack_ftp ip_conntrack snd_sb16 snd_opl3_lib snd_hwdep snd_sb16_dsp snd_s
b_common snd_mpu401_uart snd_rawmidi snd_seq_device snd_pcm_oss snd_pcm snd_page_alloc snd_timer snd_mixer_oss snd soundc
ore pcspkr hangcheck_timer w83781d i2c_sensor i2c_isa i2c_core rtc unix
CPU:    0
EIP:    0060:[<c0249587>]    Not tainted
EFLAGS: 00010282   (2.6.8.1)
EIP is at fib_create_info+0x187/0x3a0
eax: 808bc289   ebx: c11798e0   ecx: c11787e0   edx: 00000001
esi: 808bc289   edi: 00000001   ebp: c7fc5270   esp: c59f7c54
ds: 007b   es: 007b   ss: 0068
Process ip (pid: 316, threadinfo=c59f6000 task=c11f6070)
Stack: 00000001 90909090 808bc289 c1179938 c11798e0 c7f93dc0 c59f7cfc c7fc5260
       00000000 c024a64b c59f7ca0 00000000 00000001 00000000 c12e3018 c6d78c00
       00000001 c7fc5270 c7f93dc0 c59f7d70 c59f7dc0 c7f93dc0 c7fc5270 c7fc5260
Call Trace:
 [<c024a64b>] fn_hash_insert+0x6b/0x440
 [<c0248a47>] inet_rtm_newroute+0x47/0x60
 [<c0212010>] rtnetlink_rcv+0x210/0x380
 [<c0248a00>] inet_rtm_newroute+0x0/0x60
 [<c018febb>] pathrelse+0x1b/0x40
 [<c0211e00>] rtnetlink_rcv+0x0/0x380
 [<c0219f82>] netlink_data_ready+0x42/0x60
 [<c02196d9>] netlink_sendskb+0x19/0x40
 [<c0219c9c>] netlink_sendmsg+0x1fc/0x2a0
 [<c0202884>] sock_sendmsg+0x84/0xc0
 [<c019884d>] journal_end+0x8d/0xa0
 [<c0187e82>] reiserfs_dirty_inode+0x62/0xc0
 [<c01a7ce9>] copy_from_user+0x29/0x60
 [<c01a7ce9>] copy_from_user+0x29/0x60
 [<c0207e96>] verify_iovec+0x36/0xa0
 [<c020402d>] sys_sendmsg+0x10d/0x200
 [<c01380bf>] do_anonymous_page+0xff/0x180
 [<c013867a>] handle_mm_fault+0x11a/0x160
 [<c010e766>] do_page_fault+0x1e6/0x4fd
 [<c02025e3>] sock_map_fd+0x103/0x140
 [<c0203460>] __sock_create+0xc0/0x2a0
 [<c0204481>] sys_socketcall+0x1a1/0x1c0
 [<c010e580>] do_page_fault+0x0/0x4fd
 [<c0103d6d>] error_code+0x2d/0x40
 [<c0103b07>] syscall_call+0x7/0xb
Code: 8b 40 54 39 d0 89 44 24 04 75 db 8b 4c 24 08 8b 41 18 39 43
 Segmentation fault

        ***
        KSYMMOOPS:
        ***

ksymoops 2.4.9 on i586 2.6.8.1.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.8.1/ (default)
     -m /usr/src/linux/System.map (default)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address 808bc2dd
c0249587
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0249587>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282   (2.6.8.1)
eax: 808bc289   ebx: c11798e0   ecx: c11787e0   edx: 00000001
esi: 808bc289   edi: 00000001   ebp: c7fc5270   esp: c59f7c54
ds: 007b   es: 007b   ss: 0068
Stack: 00000001 90909090 808bc289 c1179938 c11798e0 c7f93dc0 c59f7cfc c7fc5260
       00000000 c024a64b c59f7ca0 00000000 00000001 00000000 c12e3018 c6d78c00
       00000001 c7fc5270 c7f93dc0 c59f7d70 c59f7dc0 c7f93dc0 c7fc5270 c7fc5260
Call Trace:
 [<c024a64b>] fn_hash_insert+0x6b/0x440
 [<c0248a47>] inet_rtm_newroute+0x47/0x60
 [<c0212010>] rtnetlink_rcv+0x210/0x380
 [<c0248a00>] inet_rtm_newroute+0x0/0x60
 [<c018febb>] pathrelse+0x1b/0x40
 [<c0211e00>] rtnetlink_rcv+0x0/0x380
 [<c0219f82>] netlink_data_ready+0x42/0x60
 [<c02196d9>] netlink_sendskb+0x19/0x40
 [<c0219c9c>] netlink_sendmsg+0x1fc/0x2a0
 [<c0202884>] sock_sendmsg+0x84/0xc0
 [<c019884d>] journal_end+0x8d/0xa0
 [<c0187e82>] reiserfs_dirty_inode+0x62/0xc0
 [<c01a7ce9>] copy_from_user+0x29/0x60
 [<c01a7ce9>] copy_from_user+0x29/0x60
 [<c0207e96>] verify_iovec+0x36/0xa0
 [<c020402d>] sys_sendmsg+0x10d/0x200
 [<c01380bf>] do_anonymous_page+0xff/0x180
 [<c013867a>] handle_mm_fault+0x11a/0x160
 [<c010e766>] do_page_fault+0x1e6/0x4fd
 [<c02025e3>] sock_map_fd+0x103/0x140
 [<c0203460>] __sock_create+0xc0/0x2a0
 [<c0204481>] sys_socketcall+0x1a1/0x1c0
 [<c010e580>] do_page_fault+0x0/0x4fd
 [<c0103d6d>] error_code+0x2d/0x40
 [<c0103b07>] syscall_call+0x7/0xb
Code: 8b 40 54 39 d0 89 44 24 04 75 db 8b 4c 24 08 8b 41 18 39 43


>>EIP; c0249587 <fib_create_info+187/3a0>   <=====

>>eax; 808bc289 <__crc_param_array_get+1e7156/2060cd>
>>ebx; c11798e0 <__crc_device_unregister+23f669/29de1c>
>>ecx; c11787e0 <__crc_device_unregister+23e569/29de1c>
>>esi; 808bc289 <__crc_param_array_get+1e7156/2060cd>
>>ebp; c7fc5270 <__crc_neigh_parms_release+8675/10e751>
>>esp; c59f7c54 <__crc_param_set_ushort+da2bb7/db6de6>

Trace; c024a64b <fn_hash_insert+6b/440>
Trace; c0248a47 <inet_rtm_newroute+47/60>
Trace; c0212010 <rtnetlink_rcv+210/380>
Trace; c0248a00 <inet_rtm_newroute+0/60>
Trace; c018febb <pathrelse+1b/40>
Trace; c0211e00 <rtnetlink_rcv+0/380>
Trace; c0219f82 <netlink_data_ready+42/60>
Trace; c02196d9 <netlink_sendskb+19/40>
Trace; c0219c9c <netlink_sendmsg+1fc/2a0>
Trace; c0202884 <sock_sendmsg+84/c0>
Trace; c019884d <journal_end+8d/a0>
Trace; c0187e82 <reiserfs_dirty_inode+62/c0>
Trace; c01a7ce9 <copy_from_user+29/60>
Trace; c01a7ce9 <copy_from_user+29/60>
Trace; c0207e96 <verify_iovec+36/a0>
Trace; c020402d <sys_sendmsg+10d/200>
Trace; c01380bf <do_anonymous_page+ff/180>
Trace; c013867a <handle_mm_fault+11a/160>
Trace; c010e766 <do_page_fault+1e6/4fd>
Trace; c02025e3 <sock_map_fd+103/140>
Trace; c0203460 <__sock_create+c0/2a0>
Trace; c0204481 <sys_socketcall+1a1/1c0>
Trace; c010e580 <do_page_fault+0/4fd>
Trace; c0103d6d <error_code+2d/40>
Trace; c0103b07 <syscall_call+7/b>

Code;  c0249587 <fib_create_info+187/3a0>
00000000 <_EIP>:
Code;  c0249587 <fib_create_info+187/3a0>   <=====
   0:   8b 40 54                  mov    0x54(%eax),%eax   <=====
Code;  c024958a <fib_create_info+18a/3a0>
   3:   39 d0                     cmp    %edx,%eax
Code;  c024958c <fib_create_info+18c/3a0>
   5:   89 44 24 04               mov    %eax,0x4(%esp)
Code;  c0249590 <fib_create_info+190/3a0>
   9:   75 db                     jne    ffffffe6 <_EIP+0xffffffe6>
Code;  c0249592 <fib_create_info+192/3a0>
   b:   8b 4c 24 08               mov    0x8(%esp),%ecx
Code;  c0249596 <fib_create_info+196/3a0>
   f:   8b 41 18                  mov    0x18(%ecx),%eax
Code;  c0249599 <fib_create_info+199/3a0>
  12:   39 43 00                  cmp    %eax,0x0(%ebx)

[6.] A small shell script or example program which triggers the
     problem (if possible)

ip route add default via <ip>

        or

route add default gw <ip.

        or even something like:

ifconfig  tun1 10.1.0.1  pointopoint 10.1.0.2 mtu 1340

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux tux 2.6.8.1 #6 Mon Aug 16 01:39:30 BRT 2004 i586 unknown unknown GNU/Linux
 
Gnu C                  3.4.1
Gnu make               3.80
binutils               2.15.90
util-linux             2.12
mount                  2.12
module-init-tools      0.9.14
e2fsprogs              1.19
PPP                    2.4.0
nfs-utils              1.0.1
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.2.3
Net-tools              1.54
Kbd                    0.99
Sh-utils               1.12
Modules Loaded         binfmt_misc 8250 serial_core ipt_LOG ipt_REJECT ipt_state iptable_filter ip_tables tun sch_ingress cls_u
32 sch_sfq sch_htb ne2k_pci 8390 crc32 ip_conntrack_ftp ip_conntrack
snd_sb16 snd_opl3_lib snd_hwdep snd_sb16_dsp snd_sb_common snd_mpu401_uart snd_rawmidi snd_seq_device snd_pcm_oss snd_pcm snd_p
age_alloc snd_timer snd_mixer_oss snd soundcore pcspkr hangcheck_timer
w83781d i2c_sensor i2c_isa i2c_core rtc unix

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 501.029
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow k6_mtrr
bogomips        : 993.28

[7.3.] Module information (from /proc/modules):

binfmt_misc 11336 1 - Live 0xc89cc000
8250 19168 2 - Live 0xc89c6000
serial_core 21920 1 8250, Live 0xc89b5000
ipt_LOG 5952 2 - Live 0xc89bc000
ipt_REJECT 6528 1 - Live 0xc89ac000
ipt_state 2016 3 - Live 0xc8949000
iptable_filter 2688 1 - Live 0xc88dc000
ip_tables 17632 4 ipt_LOG,ipt_REJECT,ipt_state,iptable_filter, Live 0xc89af000
tun 8960 0 - Live 0xc89a4000
sch_ingress 4292 1 - Live 0xc89a1000
cls_u32 7524 3 - Live 0xc8995000
sch_sfq 5440 3 - Live 0xc8992000
sch_htb 23168 1 - Live 0xc899a000
ne2k_pci 7776 0 - Live 0xc8941000
8390 9504 1 ne2k_pci, Live 0xc898e000
crc32 4288 1 8390, Live 0xc8944000
ip_conntrack_ftp 71856 0 - Live 0xc897b000
ip_conntrack 33120 2 ipt_state,ip_conntrack_ftp, Live 0xc8971000
snd_sb16 13804 0 - Live 0xc891e000
snd_opl3_lib 10112 1 snd_sb16, Live 0xc893a000
snd_hwdep 9156 1 snd_opl3_lib, Live 0xc8936000
snd_sb16_dsp 10048 1 snd_sb16, Live 0xc8923000
snd_sb_common 15456 2 snd_sb16,snd_sb16_dsp, Live 0xc88e9000
snd_mpu401_uart 7616 1 snd_sb16, Live 0xc890a000
snd_rawmidi 24548 1 snd_mpu401_uart, Live 0xc892f000
snd_seq_device 7976 2 snd_opl3_lib,snd_rawmidi, Live 0xc8901000
snd_pcm_oss 52200 0 - Live 0xc8963000
snd_pcm 93416 2 snd_sb16_dsp,snd_pcm_oss, Live 0xc894b000
snd_page_alloc 11208 1 snd_pcm, Live 0xc88fd000
snd_timer 24868 2 snd_opl3_lib,snd_pcm, Live 0xc8927000
snd_mixer_oss 18336 1 snd_pcm_oss, Live 0xc8904000
snd 55428 12 snd_sb16,snd_opl3_lib,snd_hwdep,snd_sb16_dsp,snd_sb_common,snd_mpu401_uart,snd_rawmidi,snd_seq_device,snd_pcm_oss,
snd_pcm,snd_timer,snd_mixer_oss, Live 0xc890f000
soundcore 9984 1 snd, Live 0xc88ee000
pcspkr 3624 0 - Live 0xc88de000
hangcheck_timer 3192 0 - Live 0xc88b8000
w83781d 31680 0 - Live 0xc88f4000
i2c_sensor 2784 1 w83781d, Live 0xc88da000
i2c_isa 1984 0 - Live 0xc88ba000
i2c_core 23088 3 w83781d,i2c_sensor,i2c_isa, Live 0xc88e2000
rtc 12248 0 - Live 0xc88bd000
unix 27316 214 - Live 0xc88c1000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

fraga@tux ~/src$ cat /proc/ioports 
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : ISAPnP
0220-022f : SoundBlaster
0290-0297 : w83781d
0330-0331 : MPU401 UART
0376-0376 : ide1
0388-0389 : OPL2/3 (left)
038a-038b : OPL2/3 (right)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
5c20-5c3f : 0000:00:03.0
b400-b40f : 0000:00:0f.0
  b400-b407 : ide0
  b408-b40f : ide1
b800-b81f : 0000:00:0b.0
  b800-b81f : ne2k-pci
d000-dfff : PCI Bus #01
  d800-d87f : 0000:01:00.0

fraga@tux ~/src$ cat /proc/iomem   
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000cbfff : Video ROM
000f0000-000fffff : System ROM
00100000-07ffbfff : System RAM
  00100000-0024db4a : Kernel code
  0024db4b-002b4ebf : Kernel data
07ffc000-07ffefff : ACPI Tables
07fff000-07ffffff : ACPI Non-volatile Storage
e3000000-e3000fff : 0000:00:02.0
e3800000-e3ffffff : PCI Bus #01
  e3800000-e380ffff : 0000:01:00.0
e4000000-e4ffffff : 0000:00:00.0
e6000000-e6000fff : 0000:00:0a.1
e6800000-e6800fff : 0000:00:0a.0
e7700000-e7ffffff : PCI Bus #01
  e7800000-e7bfffff : 0000:01:00.0
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

fraga@tux ~/src$ sudo lspci -vvv
00:00.0 Host bridge: ALi Corporation M1541 (rev 04)
        Subsystem: ALi Corporation ALI M1541 Aladdin V/V+ AGP System Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at e4000000 (32-bit, non-prefetchable) [size=16M]
        Capabilities: [b0] AGP version 1.0
                Status: RQ=29 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: ALi Corporation M1541 PCI to AGP Controller (rev 04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: e3800000-e3ffffff
        Prefetchable memory behind bridge: e7700000-e7ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (20000ns max)
        Interrupt: pin A routed to IRQ 3
        Region 0: Memory at e3000000 (32-bit, non-prefetchable) [size=4K]

00:03.0 Bridge: ALi Corporation M7101 PMU
        Subsystem: ALi Corporation ALI M7101 Power Management Controller
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV] (rev c3)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 0

00:0a.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 12
        Region 0: Memory at e6800000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 12
        Region 0: Memory at e6000000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
        Subsystem: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at b800 [size=32]
        Expansion ROM at <unassigned> [disabled] [size=16K]

00:0f.0 IDE interface: ALi Corporation M5229 IDE (rev c1) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at b400 [size=16]

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 86C326 5598/6326 (rev c3) (prog-if 00 [VGA])
        Subsystem: Silicon Integrated Systems [SiS] SiS6326 GUI Accelerator
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min)
        Region 0: Memory at e7800000 (32-bit, prefetchable) [size=4M]
        Region 1: Memory at e3800000 (32-bit, non-prefetchable) [size=64K]
        Region 2: I/O ports at d800 [size=128]
        Expansion ROM at e77f0000 [disabled] [size=64K]
        Capabilities: [50] AGP version 1.0
                Status: RQ=2 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

ip utility, iproute2-ss020116

[X.] Other notes, patches, fixes, workarounds:

        The only workaround was to not use QoS at all.

        Since the bug does not exist in the 2.6.7 kernel, I think
it will be easy to figure it out what's the problem with the
changes made in the 2.6.8 kernel regarding QoS section or even
networking.

        ***

        Thank you very much. 

        Ps: I'll do everything I can to help solve this oops.

