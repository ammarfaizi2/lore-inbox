Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265370AbRF0S6Q>; Wed, 27 Jun 2001 14:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265372AbRF0S6I>; Wed, 27 Jun 2001 14:58:08 -0400
Received: from pop.gmx.net ([194.221.183.20]:48303 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S265370AbRF0S6C>;
	Wed, 27 Jun 2001 14:58:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Nicolai 'Prefect' Haehnle" <prefect_@gmx.net>
To: linux-net@vger.kernel.org
Subject: 2.4.5 oops in __free_pages from networking soft IRQ / skb_release
Date: Wed, 27 Jun 2001 20:57:56 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01062720360600.00937@leprechaun>
Content-Transfer-Encoding: 7BIT
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

Oops killing soft interrupt in networking subsystem on plain 2.4.5 kernel.

[2.] Full description of the problem/report:

I recently updated the system on my router (486 100Mhz, 12MB RAM) to kernel 
2.4.5. The router has one ethernet interface and an ISDN dialup with dynamic 
IP address (and thus masquerading). I'm using the new netfilter code for 
firewall settings, masquerading, etc...
This is working all fine, but rarely - that is, around every 5 hours with 
heavy load, but sometimes earlier and sometimes later - the kernel locks up 
after an oops in an interrupt handler.

[3.] Keywords (i.e., modules, networking, kernel):

networking, netfilter, iptables, masquerading, free_pages

[4.] Kernel version (from /proc/version):

Linux version 2.4.5 (root@zen) (gcc version 2.95.2.1 19991024 (release)) #3 
Sun Jun 24 17:23:28 CEST 2001

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

ksymoops 2.4.1 on i486 2.4.5.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5/ (default)
     -m /usr/src/linux/System.map (specified)

Warning (compare_maps): ksyms_base symbol 
__VERSIONED_SYMBOL(shmem_file_setup) not found in vmlinux.  Ignoring 
ksyms_base entry
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<c0126ae2>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 702e6e6f ebx: 00000000 ecx: 702e6e6ef edx: 00000000
esi: c06b1700 edi: c0fdb270 ebp: 000000050 esp: c023dde4
ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 0, stackpage=c023d000)
Stack: c01a530d fffff400 c06b1700 c01a58f3 c06b1700 c06b1700 c0098a00 c09150b0
       c0098a00 fffffffa c01a834d c06b1700 00000002 c0045f10 c00b1700 c01ab4f3
       c06b1700 c06b1700 00000000 00000004 c01b40e0 c01b415d c06b1700 00000001
Call Trace: [<c01a530d>] [<c01a58f3>] [<c01a834d>] [<c01ab4f3>] [<c01b40e0>] 
[<c01b415d>] [<c01ac467>]
            [<c01b17b0>] [<c01b4062>] [<c01b40e0>] [<c01b17fa>] [<c01ac467>] 
[<c01b05dc>] [<c01b1754>] [<c01b17b0>]
            [<c01b09e0>] [<c01b0b69>] [<c01b09e0>] [<c01ac467>] [<c01b0826>] 
[<c01b09e0>] [<c01a88cd>] [<c01141af>]
            [<c01080b1>] [<c0105140>] [<c0106c60>] [<c0105140>] [<c0105163>] 
[<c01051c8>] [<c0105000>] [<c0100197>]
Code: 8b 41 18 85 c0 7c 11 ff 49 14 0f 94 c0 84 c0 74 07 89 c8 e8

>>EIP; c0126ae2 <__free_pages+2/20>   <=====
Trace; c01a530d <skb_release_data+3d/70>
Trace; c01a58f3 <skb_linearize+d3/140>
Trace; c01a834d <dev_queue_xmit+6d/1f0>
Trace; c01ab4f3 <neigh_resolve_output+113/190>
Trace; c01b40e0 <ip_finish_output2+0/c0>
Trace; c01b415d <ip_finish_output2+7d/c0>
Trace; c01ac467 <nf_hook_slow+e7/130>
Trace; c01b17b0 <ip_forward_finish+0/50>
Trace; c01b4062 <ip_finish_output+92/f0>
Trace; c01b40e0 <ip_finish_output2+0/c0>
Trace; c01b17fa <ip_forward_finish+4a/50>
Trace; c01ac467 <nf_hook_slow+e7/130>
Trace; c01b05dc <ip_rcv+ec/370>
Trace; c01b1754 <ip_forward+1a4/200>
Trace; c01b17b0 <ip_forward_finish+0/50>
Trace; c01b09e0 <ip_rcv_finish+0/1c0>
Trace; c01b0b69 <ip_rcv_finish+189/1c0>
Trace; c01b09e0 <ip_rcv_finish+0/1c0>
Trace; c01ac467 <nf_hook_slow+e7/130>
Trace; c01b0826 <ip_rcv+336/370>
Trace; c01b09e0 <ip_rcv_finish+0/1c0>
Trace; c01a88cd <net_rx_action+13d/220>
Trace; c01141af <do_softirq+3f/70>
Trace; c01080b1 <do_IRQ+a1/b0>
Trace; c0105140 <default_idle+0/30>
Trace; c0106c60 <ret_from_intr+0/20>
Trace; c0105140 <default_idle+0/30>
Trace; c0105163 <default_idle+23/30>
Trace; c01051c8 <cpu_idle+38/50>
Trace; c0105000 <prepare_namespace+0/10>
Trace; c0100197 <L6+0/2>
Code;  c0126ae2 <__free_pages+2/20>
00000000 <_EIP>:
Code;  c0126ae2 <__free_pages+2/20>   <=====
   0:   8b 41 18                  mov    0x18(%ecx),%eax   <=====
Code;  c0126ae5 <__free_pages+5/20>
   3:   85 c0                     test   %eax,%eax
Code;  c0126ae7 <__free_pages+7/20>
   5:   7c 11                     jl     18 <_EIP+0x18> c0126afa 
<__free_pages+1a/20>
Code;  c0126ae9 <__free_pages+9/20>
   7:   ff 49 14                  decl   0x14(%ecx)
Code;  c0126aec <__free_pages+c/20>
   a:   0f 94 c0                  sete   %al
Code;  c0126aef <__free_pages+f/20>
   d:   84 c0                     test   %al,%al
Code;  c0126af1 <__free_pages+11/20>
   f:   74 07                     je     18 <_EIP+0x18> c0126afa 
<__free_pages+1a/20>
Code;  c0126af3 <__free_pages+13/20>
  11:   89 c8                     mov    %ecx,%eax
Code;  c0126af5 <__free_pages+15/20>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> c0126afa 
<__free_pages+1a/20>
 
Kernel panic: Aiee, killing interrupt handler!
 
1 warning issued.  Results may not be reliable.

[6.] A small shell script or example program which triggers the
     problem (if possible)

I couldn't figure out what exactly (malformed packet, ... ?) causes the crash.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux zen 2.4.5 #3 Sun Jun 24 17:23:28 CEST 2001 i486 unknown
 
Gnu C                  2.95.2.1
Gnu make               3.79.1
binutils               2.10.1
util-linux             2.10r
mount                  2.10r
modutils               2.4.0
e2fsprogs              1.19
isdn4k-utils           3.1pre1
Linux C Library        2.2.1
Dynamic linker (ldd)   2.2.1
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         hisax isdn slhc ne2k-pci 8390

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : unknown
cpu family      : 4
model           : 0
model name      : 486
stepping        : unknown
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : no
cpuid level     : -1
wp              : yes
flags           :
bogomips        : 49.66

[7.3.] Module information (from /proc/modules):

hisax                 134224   3
isdn                   91568   4 [hisax]
slhc                    4832   1 [isdn]
ne2k-pci                4576   1
8390                    6288   0 [ne2k-pci]

[7.4.] SCSI information (from /proc/scsi/scsi)

no scsi devices

[7.5.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

The output from ifconfig:
eth0      Link encap:Ethernet  HWaddr 00:50:BA:E0:CC:C8
          inet addr:192.168.0.1  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:1499 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1282 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          Interrupt:10 Base address:0x6000
 
ippp0     Link encap:Point-to-Point Protocol
          inet addr:217.87.184.242  P-t-P:217.5.114.45  Mask:255.255.255.0
          UP POINTOPOINT RUNNING NOARP  MTU:1500  Metric:1
          RX packets:1116 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1249 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:30
 
lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0

[X.] Other notes, patches, fixes, workarounds:

My iptables configuration:
NAT table has the postrouting MASQUERADE entry

The filter only filters incoming packets: everything but ESTABLISHED 
connections and some TCP SYN packets are DROPped after logging them (with a 
limit of 3 hits per minute).

I hope this will help in squishing out one more nasty bug...

cu,
Nicolai Haehnle

