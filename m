Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbTDDE1k (for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 23:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbTDDE1k (for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 23:27:40 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:14847
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261373AbTDDE1H (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 23:27:07 -0500
Date: Thu, 3 Apr 2003 23:34:05 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] smp_call_function needs mb() - oopsable
In-Reply-To: <Pine.LNX.4.50.0304032213400.30262-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0304032324330.30262-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0304030937360.27631-100000@home.transmeta.com>
 <Pine.LNX.4.50.0304031951180.30262-100000@montezuma.mastecende.com>
 <Pine.LNX.4.50.0304032213400.30262-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Apr 2003, Zwane Mwaikambo wrote:

> On Thu, 3 Apr 2003, Zwane Mwaikambo wrote:
> 
> > I'm compiling with rmb before the APIC EOI, which is after the local 
> > variable assignments (i'll post the results in a bit, slow build box).

And here is one with the following changes, everything else is left as is. 

asmlinkage void smp_call_function_interrupt(void)
{
	void (*func) (void *info);
	void *info;
	int wait;
	ack_APIC_irq();

	rmb();
	func = call_data->func;
	info = call_data->info;
	wait = call_data->wait;
...

0xc0115b10 <smp_call_function_interrupt>:       push   %esi
0xc0115b11 <smp_call_function_interrupt+1>:     xor    %eax,%eax
0xc0115b13 <smp_call_function_interrupt+3>:     push   %ebx
0xc0115b14 <smp_call_function_interrupt+4>:     xchg   %eax,0xffffd0b0
0xc0115b1a <smp_call_function_interrupt+10>:    lock addl $0x0,0x0(%esp,1)
0xc0115b20 <smp_call_function_interrupt+16>:    mov    0xc05b6620,%eax
0xc0115b25 <smp_call_function_interrupt+21>:    mov    (%eax),%ecx
0xc0115b27 <smp_call_function_interrupt+23>:    mov    0x4(%eax),%edx
0xc0115b2a <smp_call_function_interrupt+26>:    mov    0x10(%eax),%esi
0xc0115b2d <smp_call_function_interrupt+29>:    lock addl $0x0,0x0(%esp,1)
0xc0115b33 <smp_call_function_interrupt+35>:    mov    0xc05b6620,%eax
0xc0115b38 <smp_call_function_interrupt+40>:    lock incl 0x8(%eax)
0xc0115b3c <smp_call_function_interrupt+44>:    mov    $0xffffe000,%ebx
0xc0115b41 <smp_call_function_interrupt+49>:    and    %esp,%ebx
0xc0115b43 <smp_call_function_interrupt+51>:    mov    0x14(%ebx),%eax
0xc0115b46 <smp_call_function_interrupt+54>:    add    $0x10000,%eax
0xc0115b4b <smp_call_function_interrupt+59>:    mov    %eax,0x14(%ebx)
0xc0115b4e <smp_call_function_interrupt+62>:    push   %edx
0xc0115b4f <smp_call_function_interrupt+63>:    call   *%ecx


Unable to handle kernel NULL pointer dereference at virtual address 00000014
 printing eip:
c033d1dc
*pde = 00000000
Oops: 0002 [#1]
CPU:    2
EIP:    0060:[<c033d1dc>]    Not tainted
EFLAGS: 00010006
EIP is at sr_do_ioctl+0x12c/0x250
eax: 00000000   ebx: cbf94000   ecx: c033d1d4   edx: cbf94000
esi: 00000000   edi: cbf94000   ebp: 00000000   esp: cbf95f6c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=cbf94000 task=c151cc80)
Stack: c0115b51 cbe5e7d0 cbf94000 c0106ea0 c010a24a cbf94000 00000000 cbf94000 
       c0106ea0 cbf94000 00000000 00000000 0000007b 0000007b fffffffb c0106ece 
       00000060 00000246 c0106f5a 00000000 000075bc 00000000 0000000d c01217b7 
Call Trace:
 [<c0115b51>] smp_call_function_interrupt+0x41/0x87
 [<c0106ea0>] default_idle+0x0/0x40
 [<c010a24a>] call_function_interrupt+0x1a/0x20
 [<c0106ea0>] default_idle+0x0/0x40
 [<c0106ece>] default_idle+0x2e/0x40
 [<c0106f5a>] cpu_idle+0x3a/0x50
 [<c01217b7>] printk+0x1b7/0x230

Code: 89 50 14 8b 44 24 08 83 c4 10 5b 5e 5f 5d c3 90 8d 74 26 00 
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

(gdb) list *sr_do_ioctl+0x12c
0xc033d1dc is in sr_do_ioctl (drivers/scsi/sr_ioctl.c:172).
167             /* Wake up a process waiting for device */
168           out_free:
169             scsi_release_request(SRpnt);
170             SRpnt = NULL;
171           out:
172             cgc->stat = err;
173             return err;
174     }
175

(gdb) list *smp_call_function_interrupt+0x40
0xc0115b50 is in smp_call_function_interrupt (arch/i386/kernel/smp.c:599).
594             atomic_inc(&call_data->started);
595             /*
596              * At this point the info structure may be out of scope unless wait==1
597              */
598             irq_enter();
599             (*func)(info);
600             irq_exit();
601
602             if (wait) {
603                     mb();

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 50 14                  mov    %edx,0x14(%eax)
Code;  00000003 Before first symbol
   3:   8b 44 24 08               mov    0x8(%esp,1),%eax
Code;  00000007 Before first symbol
   7:   83 c4 10                  add    $0x10,%esp
Code;  0000000a Before first symbol
   a:   5b                        pop    %ebx
Code;  0000000b Before first symbol
   b:   5e                        pop    %esi
Code;  0000000c Before first symbol
   c:   5f                        pop    %edi
Code;  0000000d Before first symbol
   d:   5d                        pop    %ebp
Code;  0000000e Before first symbol
   e:   c3                        ret
Code;  0000000f Before first symbol
   f:   90                        nop
Code;  00000010 Before first symbol
  10:   8d 74 26 00               lea    0x0(%esi,1),%esi

0xc033d1dc <sr_do_ioctl+300>:   mov    %edx,0x14(%eax)
0xc033d1df <sr_do_ioctl+303>:   mov    0x8(%esp,1),%eax
0xc033d1e3 <sr_do_ioctl+307>:   add    $0x10,%esp
0xc033d1e6 <sr_do_ioctl+310>:   pop    %ebx
0xc033d1e7 <sr_do_ioctl+311>:   pop    %esi
0xc033d1e8 <sr_do_ioctl+312>:   pop    %edi
0xc033d1e9 <sr_do_ioctl+313>:   pop    %ebp

-- 
function.linuxpower.ca
