Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264615AbSJWKgK>; Wed, 23 Oct 2002 06:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264618AbSJWKgJ>; Wed, 23 Oct 2002 06:36:09 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:62118 "EHLO
	crisis.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S264615AbSJWKgH>; Wed, 23 Oct 2002 06:36:07 -0400
To: linux-kernel@vger.kernel.org
Cc: davem@redhat.com
Subject: [BUG] 2.5.44 : /proc/net/arp broken
Organization: Metropolis -- Nowhere
X-Attribution: maz
X-Baby-1: =?iso-8859-1?q?Lo=EBn?= 12 juin 1996 13:10
X-Baby-2: None
X-Love-1: Gone
X-Love-2: Crazy-Cat
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 23 Oct 2002 12:41:56 +0200
Message-ID: <wrphefd5te3.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I just hit a nice little bug : cat /proc/net/arp crashes easily my two
test systems running 2.5.44 (a 486 and a P266, if that matters...).

HowTo :

* Get enough entries in the ARP table :

[system is freshly rebooted]

maz@why:~$ ping 192.168.70.255
PING 192.168.70.255 (192.168.70.255): 56 data bytes
64 bytes from 192.168.70.161: icmp_seq=0 ttl=64 time=13.6 ms
64 bytes from 192.168.70.139: icmp_seq=0 ttl=255 time=15.9 ms (DUP!)
64 bytes from 192.168.70.135: icmp_seq=0 ttl=255 time=17.1 ms (DUP!)
64 bytes from 192.168.70.129: icmp_seq=0 ttl=255 time=18.4 ms (DUP!)
64 bytes from 192.168.70.155: icmp_seq=0 ttl=64 time=19.7 ms (DUP!)
64 bytes from 192.168.70.151: icmp_seq=0 ttl=255 time=21.0 ms (DUP!)
64 bytes from 192.168.70.161: icmp_seq=1 ttl=64 time=3.6 ms
64 bytes from 192.168.70.139: icmp_seq=1 ttl=255 time=4.8 ms (DUP!)
64 bytes from 192.168.70.129: icmp_seq=1 ttl=255 time=6.1 ms (DUP!)
64 bytes from 192.168.70.155: icmp_seq=1 ttl=64 time=7.4 ms (DUP!)
64 bytes from 192.168.70.135: icmp_seq=1 ttl=255 time=8.7 ms (DUP!)
64 bytes from 192.168.70.151: icmp_seq=1 ttl=255 time=10.0 ms (DUP!)
64 bytes from 192.168.70.161: icmp_seq=2 ttl=64 time=3.7 ms
64 bytes from 192.168.70.139: icmp_seq=2 ttl=255 time=4.9 ms (DUP!)
64 bytes from 192.168.70.129: icmp_seq=2 ttl=255 time=6.2 ms (DUP!)
64 bytes from 192.168.70.155: icmp_seq=2 ttl=64 time=7.5 ms (DUP!)
64 bytes from 192.168.70.135: icmp_seq=2 ttl=255 time=8.8 ms (DUP!)
64 bytes from 192.168.70.151: icmp_seq=2 ttl=255 time=10.1 ms (DUP!)

--- 192.168.70.255 ping statistics ---
3 packets transmitted, 3 packets received, +15 duplicates, 0% packet loss
round-trip min/avg/max = 3.6/10.4/21.0 ms

* Crash the machine !

maz@why:~$ cat /proc/net/arp
IP address       HW type     Flags       HW address            Mask     Device
192.168.70.155   0x1         0x2         00:10:DC:42:57:91     *        eth0
0.0.0.0          0x304       0x2         00:00:00:00:00:00     *        lo
192.168.70.151   0x1         0x2         00:50:99:DF:6F:B8     *        eth0
192.168.70.139   0x1         0x2         00:80:C8:4D:DE:C6     *        eth0
192.168.70.129   0x1         0x2         00:00:F8:10:91:AD     *        eth0
192.168.70.135   0x1         0x2         00:60:08:46:30:24     *        eth0
64.69.171.192    0x0         0xc         00:00:00:00:00:00     *        

Note that the last line is completly bogus. At this stage, the machine
is dead, with the following message on the console :

Debug: sleeping function called from illegal context at include/asm/semaphore.h:145
Call Trace: [<c0111c93>]  [<c018f39f>]  [<c01935a0>]  [<c0135ccd>]  [<c0135d9a>]  [<c0108aa7>] 
bad: scheduling while atomic!
Call Trace: [<c0110ade>]  [<c0108ada>] 
Unable to handle kernel paging request at virtual address 40110290
 printing eip:
40110290
*pde = 004ec067
*pte = 00000000
Oops: 0004
znet  
CPU:    0
EIP:    0023:[<40110290>]    Not tainted
EFLAGS: 00010206
eax: 40110290   ebx: 400130ec   ecx: 40013ad8   edx: 40013ae8
esi: 40013ae8   edi: 00000003   ebp: bffffcac   esp: bffffc50
ds: 002b   es: 002b   ss: 002b
Process cat (pid: 283, threadinfo=c06a0000 task=c053a080)
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

EIP is bogus as well, so something must have messed with the stack...

After reboot :

why:~# ksymoops </var/tmp/znet-oops 
ksymoops 2.4.5 on i486 2.5.44.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.44/ (default)
     -m /boot/System.map-2.5.44 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Call Trace: [<c0111c93>]  [<c018f39f>]  [<c01935a0>]  [<c0135ccd>]  [<c0135d9a>]  [<c0108aa7>] 
Call Trace: [<c0110ade>]  [<c0108ada>] 
Unable to handle kernel paging request at virtual address 40110290
40110290
*pde = 004ec067
Oops: 0004
CPU:    0
EIP:    0023:[<40110290>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 40110290   ebx: 400130ec   ecx: 40013ad8   edx: 40013ae8
esi: 40013ae8   edi: 00000003   ebp: bffffcac   esp: bffffc50
ds: 002b   es: 002b   ss: 002b
 <0>Kernel panic: Aiee, killing interrupt handler!
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c0111c93 <__might_sleep+43/50>
Trace; c018f39f <tty_write+10f/1f0>
Trace; c01935a0 <write_chan+0/210>
Trace; c0135ccd <vfs_write+bd/120>
Trace; c0135d9a <sys_write+2a/40>
Trace; c0108aa7 <syscall_call+7/b>
Trace; c0110ade <schedule+2e/260>
Trace; c0108ada <work_resched+5/16>

>>EIP; 40110290 Before first symbol   <=====

>>eax; 40110290 Before first symbol
>>ebx; 400130ec Before first symbol
>>ecx; 40013ad8 Before first symbol
>>edx; 40013ae8 Before first symbol
>>esi; 40013ae8 Before first symbol
>>ebp; bffffcac Before first symbol
>>esp; bffffc50 Before first symbol


2 warnings issued.  Results may not be reliable.

Running arp -a craches the system too, with a different slightly
different call trace.

Any idea anyone ? 2.5.40 didn't show this behaviour, so I guess this
may be a side effect from one of the following change-sets :

ChangeSet@1.781.30.2, 2002-10-16 21:41:11-03:00, acme@conectiva.com.br
  o ipv4: make arp seq_file show method only produce one record per call
ChangeSet@1.781.1.52, 2002-10-13 04:47:51-02:00, acme@conectiva.com.br
  o ipv4: convert /proc/net/arp to seq_file

        M.
-- 
Places change, faces change. Life is so very strange.
