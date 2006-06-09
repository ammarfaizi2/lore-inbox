Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbWFIIjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWFIIjf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 04:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWFIIjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 04:39:35 -0400
Received: from mail.gmx.de ([213.165.64.20]:15523 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751448AbWFIIje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 04:39:34 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.17-rc6-rt1
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>, Deepak Saxena <dsaxena@plexity.net>
In-Reply-To: <20060607211455.GA6132@elte.hu>
References: <20060607211455.GA6132@elte.hu>
Content-Type: text/plain
Date: Fri, 09 Jun 2006 10:42:30 +0200
Message-Id: <1149842550.7585.27.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-07 at 23:14 +0200, Ingo Molnar wrote:
> i have released the 2.6.17-rc6-rt1 tree, which can be downloaded from 
> the usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> the biggest change was the port to 2.6.17-rc6, and the moving to John's 
> latest and greatest GTOD queue. Most of the porting was done by Thomas 
> Gleixner (thanks Thomas!). We also picked up the freshest genirq queue 
> from -mm and the freshest PI-futex patchset. There are also lots of ARM 
> fixups and enhancements from Deepak Saxena and Daniel Walker.

I have some fairly strange things going on with this kernel.

First of all, during boot, I end up with these two entries.
BUG: wq(events) setscheduler() returned: -22.
BUG: wq(events) setscheduler() returned: -22.

After boot, it takes a very long time for KDE to finish loading... more
than five minutes for the desktop background to finally appear.  Tasks
which are doing nothing but a ~50ms gettimeofday() select() idle loop
show up in top as using 1 to 3 percent cpu, though strace of these looks
fine.  Starting any threaded app takes ages, whereas plain-jane things
like gcc work fine.  For example, if I fire up xmms, the gui comes up
quickly, but it takes over three minutes from the time I poke play until
the first sound is emitted.  Starting evolution takes even longer.

Hoping that something might show up while running glibc-2.4 make check
to save me from wading through huge truckloads of strace, I tried it.
It repeatedly goes boom.  RT29 goes boom the same way, but doesn't
exhibit the slow threaded app symptom.  Drat.

rt/tst-cpuclock1

kernel BUG at :55017!
invalid opcode: 0000 [#1]
PREEMPT SMP 
Modules linked in: xt_pkttype ipt_LOG xt_limit snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device edd tda9887 saa7134 ir_kbd_i2c ip6t_REJECT xt_tcpudp ipt_REJECT xt_state bt878 prism54 ohci1394 iptable_mangle ieee1394 iptable_nat ip_nat iptable_filter i2c_i801 snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm ip6table_mangle snd_timer snd soundcore snd_page_alloc ip_conntrack nfnetlink ip_tables ip6table_filter ip6_tables x_tables tuner bttv video_buf firmware_class ir_common btcx_risc tveeprom nls_iso8859_1 nls_cp437 nls_utf8
CPU:    0
EIP:    0060:[<b10375ca>]    Not tainted VLI
EFLAGS: 00010202   (2.6.17-rc6-rt1-smp #166) 
EIP is at posix_cpu_timer_set+0x4bc/0x4db
eax: 00000286   ebx: d889ef78   ecx: ea8c72a0   edx: dfea8700
esi: 3b9aca00   edi: d889eef0   ebp: d889eeb8   esp: d889ee60
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process ld-linux.so.2 (pid: 27786, threadinfo=d889e000 task=dfea8700 stack_left=3628 worst_left=-1)
Stack: 00000001 b1555fa8 d889eefc b139cbb0 d889ef78 00000000 d889eee8 d7d1e7d8 
       0000002a 05f5e100 00000000 05f5e100 00000000 ea8c72a0 fffffffd d889eea8 
       b139ef00 00000000 d889eeb8 d889ef78 00000000 d889eef0 d889ef94 b10377fd 
Call Trace:
 [<b1004018>] show_stack_log_lvl+0x9d/0xc2 (36)
 [<b100421f>] show_registers+0x1a6/0x272 (72)
 [<b100441b>] die+0x130/0x2f6 (68)
 [<b1004651>] do_trap+0x70/0xaf (28)
 [<b1004edf>] do_invalid_op+0x97/0xa1 (180)
 [<b1003b4f>] error_code+0x4f/0x54 (148)
 [<b10377fd>] posix_cpu_nsleep+0x105/0x232 (220)
 [<b10345e8>] sys_clock_nanosleep+0xc6/0xcd (32)
 [<b1003023>] syscall_call+0x7/0xb (-4020)
Code: 68 00 00 00 00 c7 45 e0 fd ff ff ff e9 08 fe ff ff c7 41 6c ff ff ff ff c7 45 e0 01 00 00 00 c7 45 e8 01 00 00 00 e9 2f fc ff ff <0f> 0b e9 d6 fb ff ff b8 80 6a 54 b1 e8 f7 78 36 00 e9 ba fd ff 
EIP: [<b10375ca>] posix_cpu_timer_set+0x4bc/0x4db SS:ESP 0068:d889ee60

(gdb) list *posix_cpu_timer_set+0x4bc
0xb10375ea is in posix_cpu_timer_set (posix-cpu-timers.c:724).
719             }
720
721             /*
722              * Disarm any old timer after extracting its expiry time.
723              */
724             BUG_ON(!irqs_disabled());
725
726             ret = 0;
727             spin_lock(&p->sighand->siglock);
728             old_expires = timer->it.cpu.expires;
(gdb)

 ------------[ cut here ]------------
kernel BUG at z:12777!
invalid opcode: 0000 [#2]
PREEMPT SMP 
Modules linked in: xt_pkttype ipt_LOG xt_limit snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device edd tda9887 saa7134 ir_kbd_i2c ip6t_REJECT xt_tcpudp ipt_REJECT xt_state bt878 prism54 ohci1394 iptable_mangle ieee1394 iptable_nat ip_nat iptable_filter i2c_i801 snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm ip6table_mangle snd_timer snd soundcore snd_page_alloc ip_conntrack nfnetlink ip_tables ip6table_filter ip6_tables x_tables tuner bttv video_buf firmware_class ir_common btcx_risc tveeprom nls_iso8859_1 nls_cp437 nls_utf8
CPU:    0
EIP:    0060:[<b139e7d5>]    Not tainted VLI
EFLAGS: 00010246   (2.6.17-rc6-rt1-smp #166) 
EIP is at rt_lock_slowlock+0x10e/0x135
eax: dfea8700   ebx: b1623d40   ecx: b1546a98   edx: d889e000
esi: dfea8700   edi: b1546a80   ebp: d889ecb4   esp: d889ec70
ds: 007b   es: 007b   ss: 0068   preempt: 00000002
Process ld-linux.so.2 (pid: 27786, threadinfo=d889e000 task=dfea8700 stack_left=3132 worst_left=-1)
Stack: 00000000 dfdf2580 00000000 effe2800 00000000 dfd11440 d889ec98 b104c270 
       efcca388 efcca388 d889eca0 effeb4e8 00000000 b243abe0 b1623d40 dfea8700 
       dfea8bb4 d889ecbc b139edfc d889ecc4 b139ee7e d889ed10 b102559d d889ee60 
Call Trace:
 [<b1004018>] show_stack_log_lvl+0x9d/0xc2 (36)
 [<b100421f>] show_registers+0x1a6/0x272 (72)
 [<b100441b>] die+0x130/0x2f6 (68)
 [<b1004651>] do_trap+0x70/0xaf (28)
 [<b1004edf>] do_invalid_op+0x97/0xa1 (180)
 [<b1003b4f>] error_code+0x4f/0x54 (128)
 [<b139edfc>] rt_lock+0x22/0x27 (8)
 [<b139ee7e>] rt_write_lock+0x8/0xa (8)
 [<b102559d>] do_exit+0x2ab/0x953 (76)
 [<b10045e1>] do_trap+0x0/0xaf (68)
 [<b1004651>] do_trap+0x70/0xaf (28)
 [<b1004edf>] do_invalid_op+0x97/0xa1 (180)
 [<b1003b4f>] error_code+0x4f/0x54 (148)
 [<b10377fd>] posix_cpu_nsleep+0x105/0x232 (220)
 [<b10345e8>] sys_clock_nanosleep+0xc6/0xcd (32)
 [<b1003023>] syscall_call+0x7/0xb (-4020)
Code: 00 00 00 00 8b 5d ec 85 db 74 0a 8d 55 c4 89 f8 e8 cd db c9 ff 89 f8 e8 f4 d4 c9 ff 89 f8 e8 c7 0a 00 00 83 c4 38 5b 5e 5f 5d c3 <0f> 0b e9 31 ff ff ff c7 45 bc 00 00 00 00 eb 80 8d 47 08 89 47 
EIP: [<b139e7d5>] rt_lock_slowlock+0x10e/0x135 SS:ESP 0068:d889ec70

 (gdb) list *rt_lock_slowlock+0x10e
 0xb139e7f5 is in rt_lock_slowlock (rtmutex.c:639).
 634             if (try_to_take_rt_mutex(lock __IP__)) {
 635                     spin_unlock(&lock->wait_lock);
 636                     return;
 637             }
 638
 639             BUG_ON(rt_mutex_owner(lock) == current);
 640
 641             /*
 642              * Here we save whatever state the task was in originally,
 643              * we'll restore it at the end of the function and we'll take
 (gdb)

 Fixing recursive fault but reboot is needed!
BUG: scheduling while atomic: ld-linux.so.2/0x00000001/27786
 [<b1004077>] show_trace+0xd/0xf (8)
 [<b10049a6>] dump_stack+0x17/0x19 (12)
 [<b139cf5b>] __schedule+0x814/0x112a (148)
 [<b139d9c1>] schedule+0x30/0xed (28)
 [<b1025b15>] do_exit+0x823/0x953 (76)
 [<b10045e1>] do_trap+0x0/0xaf (68)
 [<b1004651>] do_trap+0x70/0xaf (28)
 [<b1004edf>] do_invalid_op+0x97/0xa1 (180)
 [<b1003b4f>] error_code+0x4f/0x54 (128)
 [<b139edfc>] rt_lock+0x22/0x27 (8)
 [<b139ee7e>] rt_write_lock+0x8/0xa (8)
 [<b102559d>] do_exit+0x2ab/0x953 (76)
 [<b10045e1>] do_trap+0x0/0xaf (68)
 [<b1004651>] do_trap+0x70/0xaf (28)
 [<b1004edf>] do_invalid_op+0x97/0xa1 (180)
 [<b1003b4f>] error_code+0x4f/0x54 (148)
 [<b10377fd>] posix_cpu_nsleep+0x105/0x232 (220)
 [<b10345e8>] sys_clock_nanosleep+0xc6/0xcd (32)
 [<b1003023>] syscall_call+0x7/0xb (-4020)


