Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272473AbTGaNHZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 09:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272476AbTGaNHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 09:07:25 -0400
Received: from skunk.physik.uni-erlangen.de ([131.188.163.240]:36069 "EHLO
	skunk.physik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S272473AbTGaNHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 09:07:24 -0400
From: Christian Vogel <vogel@skunk.physik.uni-erlangen.de>
Date: Thu, 31 Jul 2003 15:07:22 +0200
To: linux-kernel@vger.kernel.org
Subject: linux-2.6.0-test2: Never using pm_idle (CPU wasting power)
Message-ID: <20030731150722.A5938@skunk.physik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

on a Thinkpad 600X I noticed the CPU getting very hot. It turned
out that pm_idle was never called (which invokes the ACPI pm_idle
call in this case) and default_idle was used instead.

	/* arch/i386/kernel/process.c, line 723 */
	void cpu_idle (void)
	{
		/* endless idle loop with no priority at all */
		while (1) {
			void (*idle)(void) = pm_idle;
			if (!idle)
				idle = default_idle; /* once on bootup */
			irq_stat[smp_processor_id()].idle_timestamp = jiffies;
			while (!need_resched())
				idle();
			schedule();  /* never reached */
		}
	}

The schedule() is never reached (need_resched() is never 0) and
so the idle-variable is not updated. pm_idle is NULL on the
first call to cpu_idle on this thinkpad, and so I stay idling
in the default_idle()-function.

By moving the "void *idle = pm_idle; if(!idle)..." in the inner
while()-loop the notebook calls pm_idle (as it get's updated by ACPI)
and stays cool.

	Chris

-- 
Programming today is a race between software engineers striving to build
bigger and better idiot-proof programs, and the Universe trying to
produce bigger and better idiots.  So far, the Universe is winning.
 -- Rich Cook
