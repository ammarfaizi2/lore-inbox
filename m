Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266307AbSLCVbg>; Tue, 3 Dec 2002 16:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266298AbSLCVbg>; Tue, 3 Dec 2002 16:31:36 -0500
Received: from ip-216-117-200-246.keyway.net ([216.117.200.246]:43512 "EHLO
	korolyov.advancedprojects.com") by vger.kernel.org with ESMTP
	id <S266308AbSLCVbb>; Tue, 3 Dec 2002 16:31:31 -0500
Subject: Oops with kernel pcmcia plus iounmap in interrupt context
From: Kevin Moore <kevin@moore-and-moore.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Dec 2002 13:38:04 -0800
Message-Id: <1038951485.31229.15.camel@korolyov.advancedprojects.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am repeatably getting a hard lock-up with the kernel pcmcia
system when I issue 'cardctl eject' using one of my network
cards (but not when I physically push it out).  In trying to
debug this problem, I ran across what looks to be a bug common
to several of the pcmcia network drivers.  They call (or
can call) iounmap in their xxx_release functions while in
interrupt context.  For the ray_cs driver, I even get
'vfree(): sleeping in interrupt!!' in /var/log/messages on
my laptop - the one that's crashing.  This is in 2.4.xx.

I haven't run any 2.5.x kernels, but browsing the source, it
looks like the iounmap calls are still there.

I also think the above problem may not be related to my kernel
oops.  Oops occurs on a Vaio pcg-505ts laptop (PIIX4 chipset,
Ricoh RL5C475) using the ray_cs driver, but only when the laptop
goes to suspend or I issue 'cardctl eject', not when I push the
card out.  Issuing 'ifconfig eth0 down' first doesn't change
anything.  Pushing the card out gives me 'vfree(): sleeping
in interrupt!!' at each iounmap call in ray_cs instead of
a hard lock-up.  I am also using the same Raylink Aviator 2.4
in a desktop (AMD Thunderbird Via KT133 chipset, Ricoh RF5C296/396)
with no problems (and no vfree messages from the iounmap calls).

I am currently getting oopses on a redhat-8.0 machine with all
updates applied (2.4.18-18.8.0), but I have seen it on redhat 7.2
kernels and an unpatched 2.4.17 I retrieved from kernel.org
(basically any 2.4.x with kernel pcmcia system).  A while ago
I tried with the standalone pcmcia driver package (3.1.30,
I believe), and no oops.  This system has historically had no
problems with the standalone pcmcia package.  The iounmap
calls are also in the standalone ray_cs driver.

I thought I'd experiment a little, and moved the iounmap calls
in ray_cs.c from ray_release() into a separate function
ray_release_task(), which I scheduled from ray_release() using
schedule_task.  This stopped the 'vfree(): sleeping in interrupt!!'
messages, but didn't get rid of the oops.  However, I don't know
much about the pcmcia system, so I may have just introduced
another problem doing this or fixed something unrelated to my oops.

I'm attaching the oops from the stock redhat kernel with no
changes to ray_cs.c.  Any help in tracking this down would be
greatly appreciated.  I am happy to perform additional testing
to help solve this.

Thanks,

Kevin Moore

ksymoops 2.4.5 on i586 2.4.18-18.8.0.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-18.8.0/ (default)
     -m /boot/System.map-2.4.18-18.8.0 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address c88b9001
c88b1cea
*pde = 01515067
Oops: 0000
CPU:    0
EIP:    0010:[<c88b1cea>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c62d25a0   ecx: 00000203   edx: c88b9000
esi: c6418400   edi: c7bb9800   ebp: 00000003   esp: c707fbb8
ds: 0018   es: 0018   ss: 0018
Process cardmgr (pid: 474, stackpage=c707f000)
Stack: c62d25a0 00000001 c707fc0c 00000003 c01098e8 00000003 c6418400 c707fc0c 
       c034a930 00000003 c62d25a0 c707fc0c c0109a40 00000003 c707fc0c c62d25a0 
       c889e000 c889c920 c7070580 c7f5e008 c010befc c889e000 00000200 ffffffd0 
Call Trace: [<c01098e8>] handle_IRQ_event [kernel] 0x34 (0xc707fbc8))
[<c0109a40>] do_IRQ [kernel] 0x6c (0xc707fbe8))
[<c889c920>] pci_socket_array [yenta_socket] 0x0 (0xc707fbfc))
[<c010befc>] call_do_IRQ [kernel] 0x5 (0xc707fc08))
[<c889c920>] pci_socket_array [yenta_socket] 0x0 (0xc707fc18))
[<c889a8c6>] yenta_set_socket [yenta_socket] 0x11e (0xc707fc34))
[<c889a1c7>] pci_set_socket [yenta_socket] 0x2f (0xc707fc54))
[<c889c920>] pci_socket_array [yenta_socket] 0x0 (0xc707fc58))
[<c8890b78>] set_socket [pcmcia_core] 0x10 (0xc707fc60))
[<c88924fd>] pcmcia_release_configuration_R6b0239db [pcmcia_core] 0xfd (0xc707fc6c))
[<c88b014d>] ray_release [ray_cs] 0x24d (0xc707fc94))
[<c88b7100>] dev_list [ray_cs] 0x0 (0xc707fca0))
[<c88af417>] ray_detach [ray_cs] 0xc7 (0xc707fca8))
[<c88a0830>] unbind_request [ds] 0x90 (0xc707fcb8))
[<c88a0f28>] ds_ioctl [ds] 0x38c (0xc707fcd0))
[<c01585b9>] ext2_new_block [kernel] 0x711 (0xc707fd88))
[<c01584a6>] ext2_new_block [kernel] 0x5fe (0xc707fd90))
[<c01d3eef>] alloc_skb [kernel] 0xa3 (0xc707fdd8))
[<c011519c>] __wake_up [kernel] 0x44 (0xc707fe00))
[<c01d1f5b>] sys_sendto [kernel] 0xd7 (0xc707feac))
[<c0126a4b>] vm_enough_memory [kernel] 0x6b (0xc707fedc))
[<c012515e>] do_zap_page_range [kernel] 0x76 (0xc707ff08))
[<c012dd99>] kmem_cache_free [kernel] 0x11 (0xc707ff1c))
[<c0127782>] unmap_fixup [kernel] 0x14a (0xc707ff2c))
[<c0127a23>] do_munmap [kernel] 0x1f7 (0xc707ff48))
[<c0127a76>] do_munmap [kernel] 0x24a (0xc707ff60))
[<c0127a92>] do_munmap [kernel] 0x266 (0xc707ff6c))
[<c0143310>] sys_ioctl [kernel] 0x90 (0xc707ff94))
[<c0108957>] system_call [kernel] 0x33 (0xc707ffc0))
Code: 8a 4a 01 80 f9 7f 76 29 83 3d c0 70 8b c8 01 7f 0d 89 7c 24 


>>EIP; c88b1cea <[ray_cs]ray_interrupt+5a/5a0>   <=====

>>ebx; c62d25a0 <_end+5f43000/847fac0>
>>edx; c88b9000 <.bss.end+1ce1/????>
>>esi; c6418400 <_end+6088e60/847fac0>
>>edi; c7bb9800 <_end+782a260/847fac0>
>>esp; c707fbb8 <_end+6cf0618/847fac0>

Trace; c01098e8 <handle_IRQ_event+34/60>
Trace; c0109a40 <do_IRQ+6c/c8>
Trace; c889c920 <[yenta_socket]pci_socket_array+0/0>
Trace; c010befc <call_do_IRQ+5/d>
Trace; c889c920 <[yenta_socket]pci_socket_array+0/0>
Trace; c889a8c6 <[yenta_socket]yenta_set_socket+11e/18c>
Trace; c889a1c7 <[yenta_socket]pci_set_socket+2f/34>
Trace; c889c920 <[yenta_socket]pci_socket_array+0/0>
Trace; c8890b78 <[pcmcia_core]set_socket+10/14>
Trace; c88924fd <[pcmcia_core]pcmcia_release_configuration+fd/118>
Trace; c88b014d <[ray_cs]ray_release+24d/3d0>
Trace; c88b7100 <[ray_cs]dev_list+0/4>
Trace; c88af417 <[ray_cs]ray_detach+c7/100>
Trace; c88a0830 <[ds]unbind_request+90/d8>
Trace; c88a0f28 <[ds]ds_ioctl+38c/5f4>
Trace; c01585b9 <ext2_new_block+711/af4>
Trace; c01584a6 <ext2_new_block+5fe/af4>
Trace; c01d3eef <alloc_skb+a3/1a0>
Trace; c011519c <__wake_up+44/58>
Trace; c01d1f5b <sys_sendto+d7/e8>
Trace; c0126a4b <vm_enough_memory+6b/ac>
Trace; c012515e <do_zap_page_range+76/e4>
Trace; c012dd99 <kmem_cache_free+11/18>
Trace; c0127782 <unmap_fixup+14a/164>
Trace; c0127a23 <do_munmap+1f7/288>
Trace; c0127a76 <do_munmap+24a/288>
Trace; c0127a92 <do_munmap+266/288>
Trace; c0143310 <sys_ioctl+90/1f8>
Trace; c0108957 <system_call+33/38>

Code;  c88b1cea <[ray_cs]ray_interrupt+5a/5a0>
00000000 <_EIP>:
Code;  c88b1cea <[ray_cs]ray_interrupt+5a/5a0>   <=====
   0:   8a 4a 01                  mov    0x1(%edx),%cl   <=====
Code;  c88b1ced <[ray_cs]ray_interrupt+5d/5a0>
   3:   80 f9 7f                  cmp    $0x7f,%cl
Code;  c88b1cf0 <[ray_cs]ray_interrupt+60/5a0>
   6:   76 29                     jbe    31 <_EIP+0x31>
Code;  c88b1cf2 <[ray_cs]ray_interrupt+62/5a0>
   8:   83 3d c0 70 8b c8 01      cmpl   $0x1,0xc88b70c0
Code;  c88b1cf9 <[ray_cs]ray_interrupt+69/5a0>
   f:   7f 0d                     jg     1e <_EIP+0x1e>
Code;  c88b1cfb <[ray_cs]ray_interrupt+6b/5a0>
  11:   89 7c 24 00               mov    %edi,0x0(%esp,1)

 <0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.

-----------------------------------------------------------------------

Here's some additional info:

- dmesg from problem system: http://www.evonetics.com/ray_cs_dmesg.txt

- trace resulting from vfree being called in interrupt context
  (stock ray_cs.c): http://www.evonetics.com/ray_cs_vfree.txt
  No oops - just warning.

- oops with my changes to ray_cs.c and debugging turned on in
  ray_cs is at http://www.evonetics.com/ray_cs_oops3.txt


