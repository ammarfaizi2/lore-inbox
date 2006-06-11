Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWFKMf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWFKMf0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 08:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWFKMf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 08:35:26 -0400
Received: from mail.gmx.de ([213.165.64.21]:38615 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751256AbWFKMfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 08:35:25 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.17-rc6-rt3
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1149942743.8340.14.camel@Homer.TheSimpsons.net>
References: <20060610082406.GA31985@elte.hu>
	 <1149942743.8340.14.camel@Homer.TheSimpsons.net>
Content-Type: text/plain
Date: Sun, 11 Jun 2006 14:38:37 +0200
Message-Id: <1150029517.17158.38.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-10 at 14:32 +0200, Mike Galbraith wrote:
> On Sat, 2006-06-10 at 10:24 +0200, Ingo Molnar wrote:
> > I think all of the regressions reported against rt1 are fixed, please 
> > re-report if any of them is still unfixed.
> 
> Fully repeatable oops when glibc's make check hits rt/tst-cpuclock1.
> This isn't a regression though, it's in rt29 too.
> 
> kernel BUG at :36841! <-- that's fully repeatable too
> invalid opcode: 0000 [#1]
> PREEMPT SMP 
> Modules linked in: xt_pkttype ipt_LOG xt_limit snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device edd tda9887 saa7134 prism54 ohci1394 ieee1394 ir_kbd_i2c bt878 snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc i2c_i801 ip6t_REJECT xt_tcpudp ipt_REJECT xt_state iptable_mangle iptable_nat ip_nat iptable_filter ip6table_mangle ip_conntrack nfnetlink ip_tables ip6table_filter ip6_tables x_tables tuner bttv video_buf firmware_class ir_common btcx_risc tveeprom sd_mod nls_iso8859_1 nls_cp437 nls_utf8
> CPU:    1
> EIP:    0060:[<b103cbaa>]    Not tainted VLI
> EFLAGS: 00010202   (2.6.17-rc6-rt3-smp #169) 
> EIP is at posix_cpu_timer_set+0x505/0x52e
> eax: 00000282   ebx: c9380f6c   ecx: ef8b0b90   edx: dff80e10
> esi: 3b9aca00   edi: c9380ee4   ebp: c9380eac   esp: c9380e54
> ds: 007b   es: 007b   ss: 0068   preempt: 00000001
> Process ld-linux.so.2 (pid: 18428, threadinfo=c9380000 task=dff80e10 stack_left=3616 worst_left=-1)
> Stack: b13f98ed 00000202 c9380edc c9380ee4 c9380e78 b10151dc 00000000 05f5e100 
>        00000000 05f5e100 00000000 ef8b0b90 fffffffd 00000000 c9380ee4 c9380ea4 
>        b10151dc 00000000 00000000 c9380f6c 00000000 c9380ee4 c9380f88 b103ce18 
> Call Trace:
>  [<b10044db>] show_stack_log_lvl+0xaa/0xd5 (32)
>  [<b10046c8>] show_registers+0x1c2/0x28e (68)
>  [<b10048d0>] die+0x13c/0x31d (60)
>  [<b1004b3b>] do_trap+0x8a/0xdb (32)
>  [<b1005589>] do_invalid_op+0xae/0xb8 (192)
>  [<b1003f97>] error_code+0x4f/0x54 (148)
>  [<b103ce18>] posix_cpu_nsleep+0xfd/0x23b (220)
>  [<b103969f>] sys_clock_nanosleep+0xe7/0xee (44)
>  [<b10033e4>] syscall_call+0x7/0xb (-4020)
> Code: 68 00 00 00 00 c7 45 d8 fd ff ff ff e9 db fd ff ff c7 41 6c ff ff ff ff c7 45 d8 01 00 00 00 c7 45 e4 01 00 00 00 e9 e8 fb ff ff <0f> 0b e9 8f fb ff ff b8 80 7a 5a b1 e8 ff cc 3b 00 e9 81 fd ff 
> EIP: [<b103cbaa>] posix_cpu_timer_set+0x505/0x52e SS:ESP 0068:c9380e54
> 
> <peek>
> (gdb) list *posix_cpu_timer_set+0x505
> 0xb103cbaa is in posix_cpu_timer_set (posix-cpu-timers.c:724).
> 719             }
> 720
> 721             /*
> 722              * Disarm any old timer after extracting its expiry time.
> 723              */
> 724             BUG_ON(!irqs_disabled());
> 725
> 726             ret = 0;
> 727             spin_lock(&p->sighand->siglock);
> 728             old_expires = timer->it.cpu.expires;
> (gdb) list *posix_cpu_nsleep+0xfd
> 0xb103ce18 is in posix_cpu_nsleep (posix-cpu-timers.c:1597).
> 1592                    static struct itimerspec zero_it;
> 1593                    struct itimerspec it = { .it_value = *rqtp,
> 1594                                             .it_interval = {} };
> 1595
> 1596                    spin_lock_irq(&timer.it_lock);
> 1597                    error = posix_cpu_timer_set(&timer, flags, &it, NULL);
> 1598                    if (error) {
> 1599                            spin_unlock_irq(&timer.it_lock);
> 1600                            return error;
> 1601                    }
> (gdb)
> <nope, definitely not Kansas>

7796  ...:0 61481.339ms: user_trace_stop+0xe/0x39c  <= (posix_cpu_timer_set+0x31f/0x547) <--at bug_on() time
7796  ...:0 61481.338ms: rt_lock+0x8/0x29  <= (rt_read_lock+0x33/0x46)
7796  D..:1 61481.338ms: _raw_spin_unlock_irqrestore+0xc/0x50  <= (rt_read_lock+0x2c/0x46)
7796  ...:0 61481.337ms: _raw_spin_lock_irqsave+0xd/0x63  <= (rt_read_lock+0x10/0x46)
7796  ...:0 61481.337ms: rt_read_lock+0x9/0x46  <= (posix_cpu_timer_set+0x7f/0x547)
7796  ...:0 61481.337ms: posix_cpu_timer_set+0xe/0x547  <= (posix_cpu_nsleep+0x106/0x251)
7796  ...:0 61481.336ms: rt_lock+0x8/0x29  <= (posix_cpu_nsleep+0xe2/0x251)
7796  ...:1 61481.336ms: rt_mutex_unlock+0xd/0x37  <= (rt_up+0x32/0x59)
7796  ...:0 61481.335ms: rt_up+0xc/0x59  <= (user_trace_start+0x104/0x1dc)
7796  D..:0 61481.335ms: user_trace_start+0xdd/0x1dc  <= (posix_cpu_nsleep+0x161/0x251) <--once, at first use

OK, it's dying on the very first call, with absolutely nothing between
spin_lock_irq() and BUG_ON(!irqs_disabled()), but the spin_lock_irq()
has become rt_lock().  Is the BUG_ON() check bogus for the rt kernel?

	-Mike

