Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281022AbRKLWGd>; Mon, 12 Nov 2001 17:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281030AbRKLWGX>; Mon, 12 Nov 2001 17:06:23 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:61930 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S281022AbRKLWGM>; Mon, 12 Nov 2001 17:06:12 -0500
Message-ID: <3BF047EF.883A1D@nortelnetworks.com>
Date: Mon, 12 Nov 2001 17:06:39 -0500
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: I'd like a bit of help on tracing my oops
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been doing some work on customizing the 2.2 kernel to add class-based
scheduling.  It all seems to be going fairly well except that today for the
first time I started seeing kernel panics.  It appears to be in the
setscheduler() routine, but I'm looking for some pointers on tracking it down.

The output in /var/log/messages is as follows:

Nov 12 16:02:59 pcary1k7 kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000009c (error 40000000)
Nov 12 16:02:59 pcary1k7 kernel: NIP: 90016720 XER: 00000000 LR: 900166D8 REGS:
9bfa5d30 TRAP: 3100
Nov 12 16:02:59 pcary1k7 kernel: MSR: 00001032 [IRDRME]
Nov 12 16:02:59 pcary1k7 kernel: TASK = 9bfa4000[651] 'setsched' mm->pgd
ad589000 Last syscall: 156
Nov 12 16:02:59 pcary1k7 kernel: last math 9bfa4000
Nov 12 16:02:59 pcary1k7 kernel: GPR00: 000001C4 9BFA5E00 9BFA4000 00000001
00008000 00000004 9BFA5E08 00000000
Nov 12 16:02:59 pcary1k7 kernel: GPR08: 80000548 00000000 90016958 00000000
42242242 10018F0C 00000000 100B3E50
Nov 12 16:02:59 pcary1k7 kernel: GPR16: 10010000 10040000 00000000 00000000
00009032 0BFA5E40 0BFA4000 90004250
Nov 12 16:02:59 pcary1k7 kernel: GPR24: 90003ED0 10000BC8 2802678C 00000004
FFFFFFF2 00000008 00000273 9BFA5E00
Nov 12 16:02:59 pcary1k7 kernel: Call backtrace:
Nov 12 16:02:59 pcary1k7 kernel: 00000000 90016970 90003F24 10000A38 0FE4373C
00000000
Nov 12 16:02:59 pcary1k7 kernel: Kernel panic: kernel access of bad area pc
90016720 lr 900166d8 address 9C tsk setsched/651


Running ksymoops on that file gives:



Nov 12 16:02:59 pcary1k7 kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000009c (error 40000000)
Nov 12 16:02:59 pcary1k7 kernel: NIP: 90016720 XER: 00000000 LR: 900166D8 REGS:
9bfa5d30 TRAP: 3100
Nov 12 16:02:59 pcary1k7 kernel: MSR: 00001032 [IRDRME]
Nov 12 16:02:59 pcary1k7 kernel: TASK = 9bfa4000[651] 'setsched' mm->pgd
ad589000 Last syscall: 156
Nov 12 16:02:59 pcary1k7 kernel: last math 9bfa4000
Nov 12 16:02:59 pcary1k7 kernel: GPR00: 000001C4 9BFA5E00 9BFA4000 00000001
00008000 00000004 9BFA5E08 00000000
Nov 12 16:02:59 pcary1k7 kernel: GPR08: 80000548 00000000 90016958 00000000
42242242 10018F0C 00000000 100B3E50
Nov 12 16:02:59 pcary1k7 kernel: GPR16: 10010000 10040000 00000000 00000000
00009032 0BFA5E40 0BFA4000 90004250
Nov 12 16:02:59 pcary1k7 kernel: GPR24: 90003ED0 10000BC8 2802678C 00000004
FFFFFFF2 00000008 00000273 9BFA5E00
Nov 12 16:02:59 pcary1k7 kernel: Call backtrace:
Nov 12 16:02:59 pcary1k7 kernel: 00000000 90016970 90003F24 10000A38 0FE4373C
00000000
Nov 12 16:02:59 pcary1k7 kernel: Kernel panic: kernel access of bad area pc
90016720 lr 900166d8 address 9C tsk setsched/651
Warning, Code line not seen, dumping what data is available
 
>>NIP: 90016720 <setscheduler+c0/2f8>
Trace: 00000000 Before first symbol
Trace: 90016970 <sys_sched_setscheduler+18/30>
Trace: 90003f24 <syscall_ret_1+0/a0>
Trace: 10000a38 Before first symbol
Trace: 0fe4373c Before first symbol
Trace: 00000000 Before first symbol
>>NIP: 90016720 <setscheduler+c0/2f8> 

At this point I'm not entirely certain how to track down the exact line of code
where it's dying.  If I am reading it right, then the program counter was at
90016720, is this correct?  Then disassembling vmlinux in gdb should give me the
instruction corresponding to that address, at which point I need to correlate
that to the actual code to figure out what's happening, correct?  Is it expected
that disassembling vmlinux will give the same code as doing a make <file.s> in
the linux tree?

Thanks,

Chris
                                                                                                                              
-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
