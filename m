Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263842AbTDIWp2 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 18:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263860AbTDIWpX (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 18:45:23 -0400
Received: from smtp2.us.dell.com ([143.166.85.133]:63158 "EHLO
	smtp2.us.dell.com") by vger.kernel.org with ESMTP id S263842AbTDIWo7 (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 18:44:59 -0400
Subject: balance_irq()'s move() while in machine_restart() hangs system
From: Matt Domsch <Matt_Domsch@dell.com>
To: mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1049928786.5244.108.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Apr 2003 17:56:38 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo, if one processor is in move() when another processor calls
machine_restart(), the system will hang.  All otherCPUs will move into
the hlt state, but one in move(), by virtue of smp_num_cpus getting set
to 1 in smp_send_stop() before the 4th CPU has completed its work and
gets out of move().  It will loop in move() in this chunk:

		if (direction == 1) {
			cpu++;
			if (cpu >= smp_num_cpus)
				cpu = 0;
		} else {
			cpu--;
			if (cpu == -1)
				cpu = smp_num_cpus-1;
		}
	} while (!IRQ_ALLOWED(cpu,allowed_mask) ||
			(search_idle && !IDLE_ENOUGH(cpu,now)));

with smp_num_cpus=1 and never manage to exit.

Is it fair to change smp_send_stop() to call
smp_call_function(stop_this_cpu, NULL, 1, 1) instead (make it wait for
the other CPUs to complete before continuing)?

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

