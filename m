Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbTIGWOR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 18:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbTIGWOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 18:14:17 -0400
Received: from [208.177.141.226] ([208.177.141.226]:61089 "HELO ash.lnxi.com")
	by vger.kernel.org with SMTP id S261613AbTIGWOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 18:14:12 -0400
To: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@redhat.com>
CC: netdev@oss.sgi.com, <linux-kernel@vger.kernel.org>
Subject: How do I track TG3 peculiarities?
From: ebiederman@lnxi.com (Eric W. Biederman)
Date: 07 Sep 2003 16:21:50 -0600
Message-ID: <m31xuss0ht.fsf@maxwell.lnxi.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Running 2.4.21 we are seeing some very weird problems with
the tg3 driver.  The test setup is a medium sized cluster with
256 dual opetron machines running in 32bit mode, against and extreme
networks switch.  All ports running at gigabit speeds.  The current
problem reproducer is to run linpack on all of the nodes.  I am
looking for something simpler.  We have just escalated the problem
from trying a few simple things like swapping drivers to serious
debugging. 

I will do what tracing I can but as I am not especially familiar
with the linux network stack I am asking for help as to suggestions
as to reasonable interpretations of events and places to start looking.
This problem is currently a show stopper for us so we will solve
it one way or another.  

Below is one good oops we have captured.  I would have to check but
I believe we have updated the tg3 driver in this instance to the
one that comes with 2.4.23-pre3.

The very puzzling part is that in the crashes I don't see the tg3
driver at all just the network stack.  All module addresses according
to /proc/ksyms started with at 0xf8, and the tg3 driver was built as
a module.

I have been having trouble understanding why skb_clone would be called
to transmit a packet.  Any ideas?

 <1>Unable to handle kernel NULL pointer dereference at virtual address
00000004
 printing eip:
c0258575
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0258575>]    Not tainted
EFLAGS: 00010016
eax: 00000000   ebx: f7510180   ecx: 00000000   edx: c03f5240
esi: f7616b80   edi: 00000202   ebp: f7bc90e8   esp: f774de44
ds: 0018   es: 0018   ss: 0018
Process init (pid: 15, stackpage=f774d000)
Stack: 00000098 00000286 00000246 f7bc91bc f7616b80 000005a8 c0289554
f7616b80 
       00000020 f7bc9080 c0258114 00000000 00000001 eb307d90 f7bc91bc
f7bc9080 
       c027d3d5 f7bc9080 00000001 00000098 00000000 f774dee4 00000000
c0317c34 
Call Trace:    [<c0289554>] [<c0258114>] [<c027d3d5>] [<c013e02c>]
[<c029dca2>]
  [<c02544c5>] [<c025475e>] [<c0145be3>] [<c01094af>]
Code: 89 50 04 89 81 40 52 3f c0 c7 43 04 00 00 00 00 c7 03 00 00 



************************  HERE IS THE ksymoops *************************





ksymoops 2.4.5 on i686 2.4.21-cm26_lnxi2smp.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-cm26_lnxi2smp/ (default)
     -m /boot/System.map-2.4.21-cm26_lnxi2smp (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (expand_objects): object /tmp/amd76xrom.o for module amd76xrom
has changed since load
ksymoops: No such file or directory
Warning (expand_objects): object /tmp/cfi_cmdset_0002.o for module
cfi_cmdset_0002 has changed since load
Error (expand_objects): cannot stat(/modules/tg3.o) for tg3
Error (expand_objects): cannot stat(/modules/bproc.o) for bproc
ksymoops: No such file or directory
ksymoops: No such file or directory
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/modules/vmadump.o) for vmadump
Error (add_ss_object): cannot stat(/lib/modules/2.4.21-cm26_lnxi2smp/)
Error (regular_file): read_nm_symbols stat
/lib/modules/2.4.21-cm26_lnxi2smp/ failed
ksymoops: No such file or directory
Warning (read_object): no symbols in /lib/modules/2.4.21-cm26_lnxi2smp/
Error (regular_file): read_system_map stat
/boot/System.map-2.4.21-cm26_lnxi2smp failed
ksymoops: No such file or directory
Warning (map_ksym_to_module): cannot match loaded module tg3 to a unique
module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module bproc to a
unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module vmadump to a
unique module object.  Trace may not be reliable.
Fatal Error (find_fullpath): could not find executable ksymoops
[root@bluesteel conman]# ksymoops /tmp/oops
ksymoops 2.4.5 on i686 2.4.21-cm26_lnxi2smp.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-cm26_lnxi2smp/ (default)
     -m /boot/System.map-2.4.21-cm26_lnxi2smp (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
ksymoops: No such file or directory
Warning (map_ksym_to_module): cannot match loaded module ext3 to a
unique module object.  Trace may not be reliable.
 <1>Unable to handle kernel NULL pointer dereference at virtual address
00000004
c0258575
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0258575>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010016
eax: 00000000   ebx: f7510180   ecx: 00000000   edx: c03f5240
esi: f7616b80   edi: 00000202   ebp: f7bc90e8   esp: f774de44
ds: 0018   es: 0018   ss: 0018
Process init (pid: 15, stackpage=f774d000)
Stack: 00000098 00000286 00000246 f7bc91bc f7616b80 000005a8 c0289554
f7616b80 
       00000020 f7bc9080 c0258114 00000000 00000001 eb307d90 f7bc91bc
f7bc9080 
       c027d3d5 f7bc9080 00000001 00000098 00000000 f774dee4 00000000
c0317c34 
Call Trace:    [<c0289554>] [<c0258114>] [<c027d3d5>] [<c013e02c>]
[<c029dca2>]
  [<c02544c5>] [<c025475e>] [<c0145be3>] [<c01094af>]
Code: 89 50 04 89 81 40 52 3f c0 c7 43 04 00 00 00 00 c7 03 00 00 


>>EIP; c0258575 <skb_clone+45/1d0>   <=====

>>ebx; f7510180 <_end+37103a84/38400964>
>>edx; c03f5240 <skb_head_pool+0/1040>
>>esi; f7616b80 <_end+3720a484/38400964>
>>ebp; f7bc90e8 <_end+377bc9ec/38400964>
>>esp; f774de44 <_end+37341748/38400964>

Trace; c0289554 <tcp_write_xmit+184/280>
Trace; c0258114 <alloc_skb+c4/1e0>
Trace; c027d3d5 <tcp_sendmsg+585/10c0>
Trace; c013e02c <__alloc_pages+4c/1a0>
Trace; c029dca2 <inet_sendmsg+42/50>
Trace; c02544c5 <sock_sendmsg+75/c0>
Trace; c025475e <sock_write+ae/c0>
Trace; c0145be3 <sys_write+a3/160>
Trace; c01094af <system_call+33/38>

Code;  c0258575 <skb_clone+45/1d0>
00000000 <_EIP>:
Code;  c0258575 <skb_clone+45/1d0>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c0258578 <skb_clone+48/1d0>
   3:   89 81 40 52 3f c0         mov    %eax,0xc03f5240(%ecx)
Code;  c025857e <skb_clone+4e/1d0>
   9:   c7 43 04 00 00 00 00      movl   $0x0,0x4(%ebx)
Code;  c0258585 <skb_clone+55/1d0>
  10:   c7 03 00 00 00 00         movl   $0x0,(%ebx)


2 warnings and 2 errors issued.  Results may not be reliable.
