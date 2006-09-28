Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031303AbWI1AmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031303AbWI1AmI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 20:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031304AbWI1AmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 20:42:07 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:60909 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1031088AbWI1AmF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 20:42:05 -0400
Subject: Re: 2.6.18-rt1
From: john stultz <johnstul@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20060922115854.GA12684@elte.hu>
References: <20060920141907.GA30765@elte.hu> <45118EEC.2080700@cybsft.com>
	 <20060920194958.GA24691@elte.hu> <4511A57D.9070500@cybsft.com>
	 <1158784863.5724.1027.camel@localhost.localdomain>
	 <4511A98A.4080908@cybsft.com>
	 <1158866166.12028.9.camel@localhost.localdomain>
	 <20060922115854.GA12684@elte.hu>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 17:42:03 -0700
Message-Id: <1159404123.5532.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-22 at 13:58 +0200, Ingo Molnar wrote: 
> * john stultz <johnstul@us.ibm.com> wrote:
> 
> > I'm seeing a similar issue. Although the log is a bit futzed. Maybe 
> > its the sd_mod?
> > 
> >  at virtual address 75010000le kernel paging requestproc filesystem
> 
> would be nice to figure out why it crashes - unfortunately i cannot 
> trigger it. Could it be some build tool incompatibility perhaps? Some 
> sizing issue (some module struct gets too large)?

Been looking a bit deeper into this again:

BUG: unable to handle kernel paging request at virtual address 75010000
printing eip:
c01354ea      
*pde = cccccccc
stopped custom tracer.
Oops: 0000 [#1]
SMP           
Modules linked in:
CPU:    1     
EIP:    0060:[<c01354ea>]    Not tainted VLI
EFLAGS: 00010282   (2.6.18-rtjohn #9)
EIP is at lookup_symbol+0x37/0x5b
eax: 00000018   ebx: c0387a10   ecx: f7df7e58   edx: c0349c7e
esi: 75010000   edi: f881a229   ebp: c038a524   esp: f7df7e5c
ds: 007b   es: 007b   ss: 0068   preempt: 00000000
Process insmod (pid: 453, ti=f7df6000 task=c2b54030 task.ti=f7df6000)
Stack: f881f940 f8820c80 f881a229 f7df7ea4 c013555c f881a229 c03855a0
c038a524
       f881f940 f8820c80 f881a229 00000000 c01362dd f881a229 f7df7ea0
f7df7ea4
       00000001 00000000 f881a229 f881f940 000004f0 0000003c c0136855
f881922c
Call Trace:   
[<c013555c>] __find_symbol+0x26/0x2e0
[<c01362dd>] resolve_symbol+0x23/0x5f
[<c0136855>] simplify_symbols+0x7e/0xf0
[<c01375b0>] load_module+0x7c4/0xc14
[<c0137a60>] sys_init_module+0x3d/0x171
[<c0102855>] sysenter_past_esp+0x56/0x79
Code: 55 53 ff 74 24 1c 68 5f 9c 34 c0 e8 df 80 fe ff 83 c4 10 39 eb 73
31 53 68 7e 9c 34 c0 e8 cd 80 fe ff 5e 5f 8b 73 04 8b 7c 24 14 <ac> ae
75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 75 04 89
EIP: [<c01354ea>] lookup_symbol+0x37/0x5b SS:ESP 0068:f7df7e5c


Put some debugging into __find_symbol() and came up w/ this:

lookup_symbol: scsi_print_sense_hdr 0xc0385590 0xc038a514

Where it goes through that range in kernel_symbol increments.

The last one it checks before crashing is: 0xc0387a10

>From Symbol.map:
c0385590 R __start___ksymtab
c038a514 R __stop___ksymtab

That looks right. Now looking up 0xc0387a10, there's no symbol there.

c03879e8 r __ksymtab_find_next_bit
c03879f0 r __ksymtab_find_next_zero_bit
c03879f8 R __write_lock_failed
c0387a18 R __read_lock_failed
c0387a2c r __ksymtab___delay
c0387a34 r __ksymtab___const_udelay
c0387a3c r __ksymtab___udelay
c0387a44 r __ksymtab___ndelay

That __read/__write_lock_failed bit looks wrong.

That's as far as I've gotten so far, but will email with more as I find
it.

thanks
-john

