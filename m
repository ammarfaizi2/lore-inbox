Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263155AbTIVUhx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 16:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263197AbTIVUhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 16:37:53 -0400
Received: from ece-237-233.ece.gatech.edu ([130.207.237.233]:10112 "EHLO
	cc335-gr01") by vger.kernel.org with ESMTP id S263155AbTIVUh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 16:37:29 -0400
Date: Mon, 22 Sep 2003 16:37:43 -0400
From: Dheeraj <dheeraj@ece.gatech.edu>
To: linux-kernel@vger.kernel.org
Subject: Multiple Oops'es and Hard locked machine 
Message-ID: <20030922203742.GA630@bharati>
Reply-To: dheeraj@ece.gatech.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Just Home
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. When I load a simplest netfilter hook into the kernel as an external module,
   and insmod-rmmod-insmod operation results in an Oops and a hard-lock; I can
   only power recycle there upon.

2. I am trying to add a simple netfilter hook as given below:

~~~~~~~~~~~~~~~ stealer.c~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/*
  my petty attempts at programming
*/


#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>

#include <linux/skbuff.h>
#include <linux/in.h>
#include <linux/netfilter_ipv4.h>
#include <linux/ip.h>


static unsigned int preproc_hook (unsigned int hook,
                                  struct sk_buff **skb,
                                  const struct net_device *in,
                                  const struct net_device *out,
                                  int (*okfn)(struct sk_buff *)
        )
{
        printk("%s\n", in->name);
        return NF_ACCEPT;
}

static struct nf_hook_ops preproc_hook_ops =
{
        .hook     = preproc_hook,
        .owner    = THIS_MODULE,
        .pf       = PF_INET,
        .hooknum  = NF_IP_LOCAL_IN,
        .priority = NF_IP_PRI_FILTER + 1
};

static int stealer_init(void)
{
        printk("In the init code of stealer\n");
        return nf_register_hook(&preproc_hook_ops);
}

static void stealer_cleanup(void)
{
        printk("In the cleanup code of stealer \n");
        return;
}


module_init(stealer_init);
module_exit(stealer_cleanup);

MODULE_LICENSE("Dual BSD/GPL");

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Scenario 1:
=========
  when i build stealer.ko and
  insmod stealer.ko
  rmmod stealer.ko
  insmod stealer.ko
the following Oops results


Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c02dbe34>]    Tainted: GF  VLI
EFLAGS: 00010246
EIP is at nf_register_hook+0x58/0xa9
eax: c04876c8   ebx: 00000000   ecx: 00000000   edx: f88cb448
esi: 00000001   edi: 00000000   ebp: f88cb448   esp: f7653f84
ds: 007b   es: 007b   ss: 0068
Process insmod (pid: 298, threadinfo=f7652000 task=f767a080)
Stack: c04876c8 c03b7cf0 f88cb480 f7652000 c03b7cd8 f88cb03b f88cb448 c013a126
       c0473568 00000001 f88cb480 4014c008 080486bd bffffdd4 f7652000 c0349463
       4014c008 00026565 0804b050 080486bd bffffdd4 bffffd88 00000080 0000007b
Call Trace:
 [<f88cb03b>] stealer_init+0x1b/0x1f [stealer]
 [<c013a126>] sys_init_module+0xfa/0x20b
 [<c0349463>] syscall_call+0x7/0xb

Code: 89 f8 8b 14 dd 40 76 48 c0 3c 02 8b 0a 74 04 0f 18 01 90 8d 04 dd 40 76 48
 c0 39 c2 74 21 8b 75 18 89 04 24 3b 72 18 7c 16 89 fb <8b> 01 89 ca 80 fb 02 89
 c1 74 04 0f 18 00 90 3b 14 24 75 e5 8b
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

===>>>>> the relevant code is the 'list_for_each' macro in nf_register_hook
         function


Scenario 2:
==========

If I insmod the same module and them rmmod it, then initiate any network
traffic a simple ping from another box
the following Oops results

cc335-gr01:~# ttyS1: LSR safety check engaged!
ttyS1: LSR safety check engaged!
stealer: no version for "struct_module" found: kernel tainted.
In the init code of stealer
eth0    
eth0    
eth0    
eth0    
eth0    
eth0    
eth0    
eth0    
eth0    
eth0    
In the cleanup code of stealer
Unable to handle kernel paging request at virtual address f88cb448
 printing eip:
c02dc21a        
*pde = 01afb067
Oops: 0000 [#1]               
PREEMPT      
CPU:    0         
EIP:    0060:[<c02dc21a>]    Tainted: GF  VLI   
EFLAGS: 00010293                
EIP is at nf_iterate+0x24/0xb7    
eax: f88cb448   ebx: c0439e94   ecx: 00000002   edx: f78d3e80  
esi: 80000000   edi: c04876c8   ebp: c02e4589   esp: c0439e48  
ds: 007b   es: 007b   ss: 0068                              
Process swapper (pid: 0, threadinfo=c0438000 task=c03b39c0) 
Stack: 00000920 00000020 000000aa f7964ff0 f798daa0 f78d2020 00000001 00000000 
       00000002 c02dc612 c04876c8 c0439eb4 00000001 c1b00800 00000000 c0439e94
       c02e4589 80000000 00000000 f88cb448 f78d202                       
Call Trace:           
 [<c02dc612>] nf_hook_slow+0x84/0x146                                     
 [<c02e4589>] ip_local_deliver_finish+0x0/0x153                                 
 [<c02e4102>] ip_local_deliver+0x1a9/0x1c7
 [<c02e4589>] ip_local_deliver_finish+0x0/0x153
 [<c02e442d>] ip_rcv+0x30d/0x469
 [<c0345625>] packet_rcv_spkt+0x18d/0x22a
 [<c02d2f8b>] netif_receive_skb+0x196/0x215
 [<c02d307f>] process_backlog+0x75/0x11b
 [<c02d319a>] net_rx_action+0x75/0x12e
 [<c012855a>] do_softirq+0x92/0x94
 [<c010ea13>] do_IRQ+0x102/0x135
 [<c0107000>] _stext+0x0/0x5d
 [<c0349dd0>] common_interrupt+0x18/0x20
 [<c0107000>] _stext+0x0/0x5d
 [<c012007b>] try_to_free_low+0xa4/0x13f
 [<c010b041>] default_idle+0x23/0x26
 [<c010b09f>] cpu_idle+0x2c/0x35
 [<c043a6d6>] start_kernel+0x187/0x1b5
 [<c043a426>] unknown_bootoption+0x0/0xfd

Code: fe ff ff 83 c4 18 c3 55 57 56 53 83 ec 14 8b 5c 24 3c 8b 7c 24 28 8b 6c 24
 40 8b 03 8b 74 24 44 8b 00 89 03 80 3d 81 4e 3b c0 02 <8b> 10 74 04 0f 18 02 90
 39 f8 74 1e 8b 03 3b 70 18 7e 26 8b 00
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

==>>> the relevant code in the nf_iterate procedure is at
      list_for_each_continue_rcu(*i, head)

================================================================
3. Networking, Modules, kernel

4.
cc335-gr01:~# cat /proc/version 
Linux version 2.6.0-test5-mm2 (root@cc335-gr01) (gcc version 3.3.2 20030908 (Debian prerelease)) #3 Mon Sep 22 14:33:36 EDT 2003
cc335-gr01:~# 

5.

(gdb) disassemble nf_iterate
Dump of assembler code for function nf_iterate:
0xc02dc1f6 <nf_iterate+0>:      push   %ebp
0xc02dc1f7 <nf_iterate+1>:      push   %edi
0xc02dc1f8 <nf_iterate+2>:      push   %esi
0xc02dc1f9 <nf_iterate+3>:      push   %ebx
0xc02dc1fa <nf_iterate+4>:      sub    $0x14,%esp
0xc02dc1fd <nf_iterate+7>:      mov    0x3c(%esp,1),%ebx
0xc02dc201 <nf_iterate+11>:     mov    0x28(%esp,1),%edi
0xc02dc205 <nf_iterate+15>:     mov    0x40(%esp,1),%ebp
0xc02dc209 <nf_iterate+19>:     mov    (%ebx),%eax
0xc02dc20b <nf_iterate+21>:     mov    0x44(%esp,1),%esi
0xc02dc20f <nf_iterate+25>:     mov    (%eax),%eax
0xc02dc211 <nf_iterate+27>:     mov    %eax,(%ebx)
0xc02dc213 <nf_iterate+29>:     cmpb   $0x2,0xc03b4e81
0xc02dc21a <nf_iterate+36>:     mov    (%eax),%edx
0xc02dc21c <nf_iterate+38>:     je     0xc02dc222 <nf_iterate+44>
0xc02dc21e <nf_iterate+40>:     lea    0x0(%esi,1),%esi
0xc02dc222 <nf_iterate+44>:     cmp    %edi,%eax
0xc02dc224 <nf_iterate+46>:     je     0xc02dc244 <nf_iterate+78>
0xc02dc226 <nf_iterate+48>:     mov    (%ebx),%eax
0xc02dc228 <nf_iterate+50>:     cmp    0x18(%eax),%esi
0xc02dc22b <nf_iterate+53>:     jle    0xc02dc253 <nf_iterate+93>
0xc02dc22d <nf_iterate+55>:     mov    (%eax),%eax
0xc02dc22f <nf_iterate+57>:     mov    %eax,(%ebx)
0xc02dc231 <nf_iterate+59>:     cmpb   $0x2,0xc03b4e81
0xc02dc238 <nf_iterate+66>:     mov    (%eax),%edx
0xc02dc23a <nf_iterate+68>:     je     0xc02dc240 <nf_iterate+74>
0xc02dc23c <nf_iterate+70>:     lea    0x0(%esi,1),%esi
0xc02dc240 <nf_iterate+74>:     cmp    %edi,%eax
0xc02dc242 <nf_iterate+76>:     jne    0xc02dc226 <nf_iterate+48>
0xc02dc244 <nf_iterate+78>:     mov    $0x1,%edx
0xc02dc249 <nf_iterate+83>:     add    $0x14,%esp
0xc02dc24c <nf_iterate+86>:     mov    %edx,%eax
0xc02dc24e <nf_iterate+88>:     pop    %ebx
0xc02dc24f <nf_iterate+89>:     pop    %esi
0xc02dc250 <nf_iterate+90>:     pop    %edi
0xc02dc251 <nf_iterate+91>:     pop    %ebp
0xc02dc252 <nf_iterate+92>:     ret    
0xc02dc253 <nf_iterate+93>:     mov    0x38(%esp,1),%edx
0xc02dc257 <nf_iterate+97>:     mov    %ebp,0x10(%esp,1)
0xc02dc25b <nf_iterate+101>:    mov    %edx,0xc(%esp,1)
0xc02dc25f <nf_iterate+105>:    mov    0x34(%esp,1),%edx
0xc02dc263 <nf_iterate+109>:    mov    %edx,0x8(%esp,1)
0xc02dc267 <nf_iterate+113>:    mov    0x2c(%esp,1),%edx
0xc02dc26b <nf_iterate+117>:    mov    %edx,0x4(%esp,1)
0xc02dc26f <nf_iterate+121>:    mov    0x30(%esp,1),%edx
0xc02dc273 <nf_iterate+125>:    mov    %edx,(%esp,1)
0xc02dc276 <nf_iterate+128>:    call   *0x8(%eax)
0xc02dc279 <nf_iterate+131>:    mov    $0x2,%edx
0xc02dc27e <nf_iterate+136>:    cmp    $0x2,%eax
0xc02dc281 <nf_iterate+139>:    je,pn  0xc02dc249 <nf_iterate+83>
0xc02dc284 <nf_iterate+142>:    cmp    $0x2,%eax
0xc02dc287 <nf_iterate+145>:    ja     0xc02dc294 <nf_iterate+158>
0xc02dc289 <nf_iterate+147>:    xor    %edx,%edx
---Type <return> to continue, or q <return> to quit---
0xc02dc28b <nf_iterate+149>:    test   %eax,%eax
0xc02dc28d <nf_iterate+151>:    je,pn  0xc02dc249 <nf_iterate+83>
0xc02dc290 <nf_iterate+154>:    mov    (%ebx),%eax
0xc02dc292 <nf_iterate+156>:    jmp    0xc02dc22d <nf_iterate+55>
0xc02dc294 <nf_iterate+158>:    cmp    $0x3,%eax
0xc02dc297 <nf_iterate+161>:    mov    $0x3,%edx
0xc02dc29c <nf_iterate+166>:    je,pn  0xc02dc249 <nf_iterate+83>
0xc02dc29f <nf_iterate+169>:    cmp    $0x4,%eax
0xc02dc2a2 <nf_iterate+172>:    jne    0xc02dc290 <nf_iterate+154>
0xc02dc2a4 <nf_iterate+174>:    mov    (%ebx),%eax
0xc02dc2a6 <nf_iterate+176>:    mov    0x4(%eax),%eax
0xc02dc2a9 <nf_iterate+179>:    mov    %eax,(%ebx)
0xc02dc2ab <nf_iterate+181>:    jmp    0xc02dc22d <nf_iterate+55>
End of assembler dump.


(gdb) disassemble nf_register_hook
Dump of assembler code for function nf_register_hook:
0xc02dbddc <nf_register_hook+0>:        push   %ebp
0xc02dbddd <nf_register_hook+1>:        mov    $0xffffe000,%eax
0xc02dbde2 <nf_register_hook+6>:        and    %esp,%eax
0xc02dbde4 <nf_register_hook+8>:        push   %edi
0xc02dbde5 <nf_register_hook+9>:        push   %esi
0xc02dbde6 <nf_register_hook+10>:       push   %ebx
0xc02dbde7 <nf_register_hook+11>:       sub    $0x4,%esp
0xc02dbdea <nf_register_hook+14>:       mov    0x18(%esp,1),%ebp
0xc02dbdee <nf_register_hook+18>:       addl   $0x100,0x14(%eax)
0xc02dbdf5 <nf_register_hook+25>:       addl   $0x1,0x14(%eax)
0xc02dbdf9 <nf_register_hook+29>:       movzbl 0xc03b4e81,%edi
0xc02dbe00 <nf_register_hook+36>:       mov    0x10(%ebp),%edx
0xc02dbe03 <nf_register_hook+39>:       mov    0x14(%ebp),%eax
0xc02dbe06 <nf_register_hook+42>:       lea    (%eax,%edx,8),%ebx
0xc02dbe09 <nf_register_hook+45>:       mov    %edi,%eax
0xc02dbe0b <nf_register_hook+47>:       mov    0xc0487640(,%ebx,8),%edx
0xc02dbe12 <nf_register_hook+54>:       cmp    $0x2,%al
0xc02dbe14 <nf_register_hook+56>:       mov    (%edx),%ecx
0xc02dbe16 <nf_register_hook+58>:       je     0xc02dbe1c <nf_register_hook+64>
0xc02dbe18 <nf_register_hook+60>:       lea    0x0(%esi,1),%esi
0xc02dbe1c <nf_register_hook+64>:       lea    0xc0487640(,%ebx,8),%eax
0xc02dbe23 <nf_register_hook+71>:       cmp    %eax,%edx
0xc02dbe25 <nf_register_hook+73>:       je     0xc02dbe48 <nf_register_hook+108>
0xc02dbe27 <nf_register_hook+75>:       mov    0x18(%ebp),%esi
0xc02dbe2a <nf_register_hook+78>:       mov    %eax,(%esp,1)
0xc02dbe2d <nf_register_hook+81>:       cmp    0x18(%edx),%esi
0xc02dbe30 <nf_register_hook+84>:       jl     0xc02dbe48 <nf_register_hook+108>
0xc02dbe32 <nf_register_hook+86>:       mov    %edi,%ebx
0xc02dbe34 <nf_register_hook+88>:       mov    (%ecx),%eax
0xc02dbe36 <nf_register_hook+90>:       mov    %ecx,%edx
0xc02dbe38 <nf_register_hook+92>:       cmp    $0x2,%bl
0xc02dbe3b <nf_register_hook+95>:       mov    %eax,%ecx
0xc02dbe3d <nf_register_hook+97>:       je     0xc02dbe43 <nf_register_hook+103>
0xc02dbe3f <nf_register_hook+99>:       lea    0x0(%esi,1),%esi
0xc02dbe43 <nf_register_hook+103>:      cmp    (%esp,1),%edx
0xc02dbe46 <nf_register_hook+106>:      jne    0xc02dbe2d <nf_register_hook+81>
0xc02dbe48 <nf_register_hook+108>:      mov    0x4(%edx),%eax
0xc02dbe4b <nf_register_hook+111>:      mov    (%eax),%edx
0xc02dbe4d <nf_register_hook+113>:      mov    %eax,0x4(%ebp)
0xc02dbe50 <nf_register_hook+116>:      mov    %edx,0x0(%ebp)
0xc02dbe53 <nf_register_hook+119>:      mov    %ebp,(%eax)
0xc02dbe55 <nf_register_hook+121>:      mov    %ebp,0x4(%edx)
0xc02dbe58 <nf_register_hook+124>:      mov    $0xffffe000,%eax
0xc02dbe5d <nf_register_hook+129>:      and    %esp,%eax
0xc02dbe5f <nf_register_hook+131>:      subl   $0x1,0x14(%eax)
0xc02dbe63 <nf_register_hook+135>:      mov    0x8(%eax),%eax
0xc02dbe66 <nf_register_hook+138>:      test   $0x8,%al
0xc02dbe68 <nf_register_hook+140>:      jne    0xc02dbe7e <nf_register_hook+162>
0xc02dbe6a <nf_register_hook+142>:      call   0xc012855c <local_bh_enable>
0xc02dbe6f <nf_register_hook+147>:      call   0xc02d4727 <synchronize_net>
0xc02dbe74 <nf_register_hook+152>:      add    $0x4,%esp
0xc02dbe77 <nf_register_hook+155>:      pop    %ebx
0xc02dbe78 <nf_register_hook+156>:      xor    %eax,%eax
---Type <return> to continue, or q <return> to quit---
0xc02dbe7a <nf_register_hook+158>:      pop    %esi
0xc02dbe7b <nf_register_hook+159>:      pop    %edi
0xc02dbe7c <nf_register_hook+160>:      pop    %ebp
0xc02dbe7d <nf_register_hook+161>:      ret    
0xc02dbe7e <nf_register_hook+162>:      call   0xc012144f <preempt_schedule>
0xc02dbe83 <nf_register_hook+167>:      jmp    0xc02dbe6a <nf_register_hook+142>
End of assembler dump.
(gdb) 


================
6.  See section 2 above

7.

7.1
cc335-gr01:/usr/src/linux-2.6.0-test5/Documentation# ../scripts/ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux cc335-gr01 2.6.0-test5-mm2 #3 Mon Sep 22 14:33:36 EDT 2003 i686 GNU/Linux
 
Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
e2fsprogs              1.35-WIP
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.12
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.90
Modules Loaded         snd_intel8x0 snd_ac97_codec snd_mpu401_uart

7.2

cc335-gr01:/usr/src/linux-2.6.0-test5/Documentation# cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping        : 9
cpu MHz         : 2993.260
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5914.62


7.3
cc335-gr01:/usr/src/linux-2.6.0-test5/Documentation# cat /proc/modules 
snd_intel8x0 31652 0 - Live 0xf88fb000
snd_ac97_codec 52484 1 snd_intel8x0, Live 0xf88ed000
snd_mpu401_uart 7808 1 snd_intel8x0, Live 0xf88cf000
snd_rawmidi 24864 1 snd_mpu401_uart, Live 0xf88d4000

7.4

00:00.0 Host bridge: Intel Corp.: Unknown device 2570 (rev 02)
	Subsystem: Dell Computer Corporation: Unknown device 0151
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [e4] #09 [0106]
	Capabilities: [a0] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=2 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp.: Unknown device 2571 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fd000000-feafffff
	Prefetchable memory behind bridge: f0000000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp.: Unknown device 24d2 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Dell Computer Corporation: Unknown device 0151
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at ff80 [size=32]

00:1d.1 USB Controller: Intel Corp.: Unknown device 24d4 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Dell Computer Corporation: Unknown device 0151
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at ff60 [size=32]

00:1d.2 USB Controller: Intel Corp.: Unknown device 24d7 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Dell Computer Corporation: Unknown device 0151
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at ff40 [size=32]

00:1d.3 USB Controller: Intel Corp.: Unknown device 24de (rev 02) (prog-if 00 [UHCI])
	Subsystem: Dell Computer Corporation: Unknown device 0151
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at ff20 [size=32]

00:1d.7 USB Controller: Intel Corp.: Unknown device 24dd (rev 02) (prog-if 20 [EHCI])
	Subsystem: Dell Computer Corporation: Unknown device 0151
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 23
	Region 0: Memory at ffa80800 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [20a0]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev c2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fcf00000-fcffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp.: Unknown device 24d0 (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp.: Unknown device 24db (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Dell Computer Corporation: Unknown device 0151
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at <ignored>
	Region 1: I/O ports at <ignored>
	Region 2: I/O ports at <ignored>
	Region 3: I/O ports at <ignored>
	Region 4: I/O ports at ffa0 [size=16]
	Region 5: Memory at febffc00 (32-bit, non-prefetchable) [size=1K]

00:1f.2 IDE interface: Intel Corp.: Unknown device 24d1 (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Dell Computer Corporation: Unknown device 0151
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at fe00 [size=8]
	Region 1: I/O ports at fe10 [size=4]
	Region 2: I/O ports at fe20 [size=8]
	Region 3: I/O ports at fe30 [size=4]
	Region 4: I/O ports at fea0 [size=16]

00:1f.3 SMBus: Intel Corp.: Unknown device 24d3 (rev 02)
	Subsystem: Dell Computer Corporation: Unknown device 0151
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 17
	Region 4: I/O ports at eda0 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp.: Unknown device 24d5 (rev 02)
	Subsystem: Dell Computer Corporation: Unknown device 0151
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at ee00 [size=256]
	Region 1: I/O ports at edc0 [size=64]
	Region 2: Memory at febffa00 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at febff900 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV11GL [Quadro2 MXR/EX] (rev b2) (prog-if 00 [VGA])
	Subsystem: nVidia Corporation: Unknown device 0070
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at fea00000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

02:0c.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
	Subsystem: Dell Computer Corporation: Unknown device 0151
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), cache line size 10
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at fcfe0000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at df40 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

7.6.
cc335-gr01:/usr/src/linux-2.6.0-test5/Documentation# cat /proc/scsi/scsi 
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: _NEC     Model: CD-RW NR-9100A   Rev: 108A
  Type:   CD-ROM                           ANSI SCSI revision: 02
cc335-gr01:/usr/src/linux-2.6.0-test5/Documentation# 

7.7

I think the nf_hooks data structure is somehow corrupted .

possibly rmmod is messed up ??

cc335-gr01:/usr/src/linux-2.6.0-test5/Documentation# insmod --version
module-init-tools version 0.9.14


========================================================================



truely
dheeraj

-- 
It is better to be silent and be thought a fool than to speak and remove all doubt
