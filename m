Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBGRwG>; Wed, 7 Feb 2001 12:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129057AbRBGRv4>; Wed, 7 Feb 2001 12:51:56 -0500
Received: from betty.magenta-netlogic.com ([193.37.229.181]:18960 "EHLO
	betty.magenta-netlogic.com") by vger.kernel.org with ESMTP
	id <S129032AbRBGRvm>; Wed, 7 Feb 2001 12:51:42 -0500
Message-ID: <3A818BC4.7020007@magenta-netlogic.com>
Date: Wed, 07 Feb 2001 17:54:12 +0000
From: Tony Hoyle <tmh@magenta-netlogic.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; 0.7) Gecko/20010109
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ACPI slowdown... 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying to track down what makes ACPI kill the system in 2.4.1.

In the acpi_idle function (drivers/acpi/cpu.c), it seems to spend most 
of its time with interrupts disabled, only enabling them to check 
need_resched occasionally.

In the 'sleep1' state the following code is executed:

         for (;;) {
                 unsigned long time;
                 unsigned long diff;

                 __cli();
                 if (current->need_resched)
                         goto out;
                 time = acpi_read_pm_timer();
                 safe_halt();
                 diff = acpi_compare_pm_timers(time, acpi_read_pm_timer());
                 if (diff > acpi_c2_enter_latency
                     && acpi_max_c_state >= 2)
                         goto sleep2;
         }

This looks wrong to me.  It's basically looping with interrupts 
disabled.  I can't see how current->need_resched could be updated at 
all, so the loop will only terminate when the PM timer tells it to.

Isn't disabling interrupts a bad thing anyway?  Wouldn't it be better to 
leave them enabled (this is uniprocessor only so there shouldn't be 
concurrency issues).

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
