Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264383AbSIQRHE>; Tue, 17 Sep 2002 13:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264389AbSIQRHE>; Tue, 17 Sep 2002 13:07:04 -0400
Received: from smtpout.mac.com ([204.179.120.97]:65227 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S264383AbSIQRHC>;
	Tue, 17 Sep 2002 13:07:02 -0400
Date: Tue, 17 Sep 2002 19:11:52 +0200
Subject: Re: Oops in sched.c on PPro SMP
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
To: Andrea Arcangeli <andrea@suse.de>
From: Peter Waechtler <pwaechtler@mac.com>
In-Reply-To: <20020916154233.GH11605@dualathlon.random>
Message-Id: <8F7381E4-CA60-11D6-8873-00039387C942@mac.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag den, 16. September 2002, um 17:42, schrieb Andrea Arcangeli:

> Can you disassemble the .o object using objdump -Dr or can you 
> disassemble such
> piece of code from the vmlinux instead of compiling with the -S flag to
> verify that to verify that? If it really checks against zero then it's a
> miscompilation, it should check against &init_task as said above.
>
>

objdump -Dr vmlinux
--- schedule snippet ---
	if (unlikely(!c)) {
c0117edb:       83 7d f0 00             cmpl   $0x0,0xfffffff0(%ebp)
c0117edf:       75 6f                   jne    c0117f50 <schedule+0x288>

		spin_unlock_irq(&runqueue_lock);
c0117ee1:       b0 01                   mov    $0x1,%al
c0117ee3:       86 05 80 79 30 c0       xchg   %al,0xc0307980
c0117ee9:       fb                      sti

		read_lock(&tasklist_lock);
c0117eea:       b8 a0 79 30 c0          mov    $0xc03079a0,%eax
c0117eef:       f0 83 28 01             lock subl $0x1,(%eax)
c0117ef3:       0f 88 90 12 00 00       js     c0119189 
<.text.lock.sched+0x40>

		for_each_task(p)
			p->counter = (p->counter >> 1) + NICE_TO_TICKS(p->nice);
c0117ef9:       8b 0d 48 c0 2d c0       mov    0xc02dc048,%ecx
c0117eff:       81 f9 00 c0 2d c0       cmp    $0xc02dc000,%ecx
c0117f05:       74 28                   je     c0117f2f <schedule+0x267>
c0117f07:       bb 14 00 00 00          mov    $0x14,%ebx
c0117f0c:       8d 74 26 00             lea    0x0(%esi,1),%esi ;for 
alignment

c0117f10:       8b 51 20                mov    0x20(%ecx),%edx
c0117f13:       d1 fa                   sar    %edx
c0117f15:       89 d8                   mov    %ebx,%eax
c0117f17:       2b 41 24                sub    0x24(%ecx),%eax
c0117f1a:       c1 f8 02                sar    $0x2,%eax
c0117f1d:       8d 54 10 01             lea    0x1(%eax,%edx,1),%edx
c0117f21:       89 51 20                mov    %edx,0x20(%ecx)
c0117f24:       8b 49 48                mov    0x48(%ecx),%ecx
c0117f27:       81 f9 00 c0 2d c0       cmp    $0xc02dc000,%ecx
c0117f2d:       75 e1                   jne    c0117f10 <schedule+0x248>

		read_unlock(&tasklist_lock);
c0117f2f:       f0 ff 05 a0 79 30 c0    lock incl 0xc03079a0
c0117f36:       fa                      cli

		spin_lock_irq(&runqueue_lock);
c0117f37:       f0 fe 0d 80 79 30 c0    lock decb 0xc0307980
c0117f3e:       0f 88 4f 12 00 00       js     c0119193 
<.text.lock.sched+0x4a>

		goto repeat_schedule;
c0117f43:       e9 e4 fe ff ff          jmp    c0117e2c <schedule+0x164>


-----
<.text.lock.sched+0x4a>
c0119189:       e8 66 e9 fe ff          call   c0107af4 
<__read_lock_failed>
c011918e:       e9 65 ed ff ff          jmp    c0117ef8 <schedule+0x230>


c0107af4 <__read_lock_failed>:
c0107af4:       f0 ff 00                lock incl (%eax)
c0107af7:       f3 90                   repz nop
c0107af9:       83 38 01                cmpl   $0x1,(%eax)
c0107afc:       78 f9                   js     c0107af7 
<__read_lock_failed+0x3>
c0107afe:       f0 ff 08                lock decl (%eax)
c0107b01:       0f 88 ed ff ff ff       js     c0107af4 
<__read_lock_failed>
c0107b07:       c3                      ret


--- do_fork snippet ---
	write_lock_irq(&tasklist_lock);

c011a416:       fa                      cli
c011a417:       ba a0 79 30 c0          mov    $0xc03079a0,%edx
c011a41c:       89 d0                   mov    %edx,%eax
c011a41e:       f0 81 28 00 00 00 01    lock subl $0x1000000,(%eax)
c011a425:       0f 85 6c 03 00 00       jne    c011a797 
<.text.lock.fork+0xc4>
; we got the lock

	write_unlock_irq(&tasklist_lock);
c011a53b:       f0 81 05 a0 79 30 c0    lock addl $0x1000000,0xc03079a0
c011a542:       00 00 00 01
c011a546:       fb                      sti

<.text.lock.fork+0xc4>
c011a797:       e8 38 d3 fe ff          call   c0107ad4 
<__write_lock_failed>
c011a79c:       e9 8a fc ff ff          jmp    c011a42b <do_fork+0x597>

c0107ad4 <__write_lock_failed>:
c0107ad4:       f0 81 00 00 00 00 01    lock addl $0x1000000,(%eax)
c0107adb:       f3 90                   repz nop
c0107add:       81 38 00 00 00 01       cmpl   $0x1000000,(%eax)
c0107ae3:       75 f6                   jne    c0107adb 
<__write_lock_failed+0x7>
c0107ae5:       f0 81 28 00 00 00 01    lock subl $0x1000000,(%eax)
c0107aec:       0f 85 e2 ff ff ff       jne    c0107ad4 
<__write_lock_failed>
c0107af2:       c3                      ret
c0107af3:       90                      nop


--- do_exit even more complicated but looks OK ---

> I really suspect an hardware fault here, if you could reproduce easily
> you could try to drop a dimm of ram and retest, you can also try memtst
> from cerberus testsuite or/and memtest86 from the lilo menu.
>

I did that in January - as I encountered these lockups the first time.
I removed some SIMMs, crashed again, exchanged the SIMMs and so on.
memtest86 didn't find anything in one day.

Once I had a machine check exception - sine then I lowered the CPU clock.
After the box was running fine with 180MHz I switched to 200MHz
(yes, I overclocked the CPUs with 233MHz 2 or 3 years - without problems)
2.4.18-SuSE was running fine with the same load over summer. NO lockup
in 2 months.

Now I have to believe that the silicon aged and that tight loop causes
errors? There are similar loops in kernel/exit.c in 2.4.18-SuSE but it
_always_ crashes in schedule().

I also checked the bttv driver and used the 2.4.18-SuSE one in 2.4.19 -
but still crashes. I run the driver almost all the time - I have two
cards, one for watching TV or listen Radio, the other grabs EPG data.

But the box also crashed when I unloaded the drivers over night.
Argh, it seems that I'm forced to use O(1) scheduler!

> So I would say, it's either an hardware issue, or random memory
> corruption generated by some driver. Just some guesses. And if it's the
> irq clobbering the %ecx or the tasklist then something is very wrong in
> the irq code or in the hardware (I'd exclude such possibility, but you
> can try adding _irq to the read_lock/read_unlock of the tasklist_lock to
> disable irq and see if you can still reproduce). If %ecx is checked
> against zero as well something is very wrong, but in the compiler, and
> that would explain things too (you're recommended to use either 2.95 or
> 3.2).
>
I use 2.95.3 out of SuSE 8.0 - everything seems to be compiled correctly.

Perhaps I add a MAGIC to the tasklist to notice when it gets thrashed?
Puh...

> Hope this helps,
>
Thanx for your effort.

