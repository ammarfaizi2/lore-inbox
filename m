Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318796AbSG0SIE>; Sat, 27 Jul 2002 14:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318797AbSG0SIE>; Sat, 27 Jul 2002 14:08:04 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18951 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318796AbSG0SID>; Sat, 27 Jul 2002 14:08:03 -0400
Date: Sat, 27 Jul 2002 19:11:19 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com
Subject: Serial Oopsen caused by global IRQ chanes
Message-ID: <20020727191119.C32766@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Two people have now reported to me a couple of oopsen which appear to be
caused by a change in 2.5.29 to synchronize_irq(), which I believe has
made synchronize_irq() useless.

In effect, we no longer guarantee that any IRQ handlers for a particular
IRQ will have finished running by the time free_irq() returns.  So, code
which has:

int bar;
int *foo = &bar;

irq_handler()
{
	*foo = 0;
}

void module_exit(void)
{
	free_irq(irq, NULL);
	foo = NULL;
}

is currently broken in two ways:

1. it's possible for irq_handler to dereference foo on another CPU _after_
   free_irq has returned.
2. it's possible for the module to be unloaded while the irq_handler is
   still running on another CPU.

Would someone else (Ingo?) like to comment on the above please?
The serial code regularly trips up because of this on SMP boxen.

Thanks.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

