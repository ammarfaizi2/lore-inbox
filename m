Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBGSTL>; Wed, 7 Feb 2001 13:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129053AbRBGSTB>; Wed, 7 Feb 2001 13:19:01 -0500
Received: from betty.magenta-netlogic.com ([193.37.229.181]:12817 "EHLO
	betty.magenta-netlogic.com") by vger.kernel.org with ESMTP
	id <S129032AbRBGSS1>; Wed, 7 Feb 2001 13:18:27 -0500
Message-ID: <3A81920A.90601@magenta-netlogic.com>
Date: Wed, 07 Feb 2001 18:20:58 +0000
From: Tony Hoyle <tmh@magenta-netlogic.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; 0.7) Gecko/20010109
X-Accept-Language: en
MIME-Version: 1.0
To: Tony Hoyle <tmh@magenta-netlogic.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ACPI slowdown...
In-Reply-To: <3A818BC4.7020007@magenta-netlogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Hoyle wrote:

I'm talking to myself :-)

OK I see that safe_halt() will re-enable interrupts.  However this is only
called in S1.  If your machine gets as far as S3 you have...

         for (;;) {
                 unsigned long time;
                 unsigned long diff;

                 __cli();
                 if (current->need_resched)
                         goto out;
                 if (acpi_bm_activity())
                         goto sleep2;

                 time = acpi_read_pm_timer();
                 inb(acpi_pblk + ACPI_P_LVL3);
                 /* Dummy read, force synchronization with the PMU */
                 acpi_read_pm_timer();
                 diff = acpi_compare_pm_timers(time, acpi_read_pm_timer());

                 __sti();
                 if (diff < acpi_c3_exit_latency)
                         goto sleep2;
         }

There is no halt here... the interrupts are enabled for only a couple of 
instructions (one comparison and a jump) before being disabled again. 
It seems to me if the computer gets into S3 it'll effectively die until 
some kind of busmaster device wakes it up (DMA?).

The simple fix is to delete lines 332-337 of cpu.c, which disables the 
idle process (and explains why I've had no slowdown on my SMP machine). 
  Lots of people (like me) only use ACPI for the power-off/shutdown 
functionality anyway.  Laptop users will probably have to wait for a 
proper fix (unfortunately the ACPI4Linux mailing list looks dead - it's 
just full of people complaining about 2.4.1...)

Tony

-- 

The only secure computer is one that's unplugged, locked in a safe,
and buried 20 feet under the ground in a secret location... and i'm
not even too sure about that one"--Dennis Huges, FBI.

tmh@magenta-netlogic.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
