Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278428AbRK0NUZ>; Tue, 27 Nov 2001 08:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278690AbRK0NUQ>; Tue, 27 Nov 2001 08:20:16 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:34813 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S278428AbRK0NUL>;
	Tue, 27 Nov 2001 08:20:11 -0500
Date: Tue, 27 Nov 2001 18:57:39 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Rusty <rusty@rustcorp.com.au>
Subject: smp_call_function & BH handlers
Message-ID: <20011127185739.H14200@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Why is it ok to call smp_call_function from bottom half handlers? This 
could lead to deadlock in the way which we encounterd. (tried on 2.4.14 kernel)

CPU 0				     CPU 1
-----				     -----	
schedule()			     do_fork
   read_lock(&tasklist_lock)	     spinning for write_lock_irq(&tasklist_lock)
	.
	.
	.
  interrupted by a timer handler
    calls smp_call_function()
      waiting for response from CPU 1

IMO this looks like a genereic problem and not specific to tasklist_lock and can
happen with other locks also. The solution for the above problem can be 

(1) Do not use smp_call_function even from bottom half handlers.
(2) Enabling interrupts if CPU has to spin due to xxx_lock_irq() and disabling
    them when the CPU gets the lock.

Though the deadlock we faced doesnot occur, using read_lock_irq(&tasklist_lock)
in schedule(). 

The comments above smp_call_function() also say that it can return negative
status code upon failure. But it doesnot do that and keep waiting for response
from other cpus. Why is it necessary to wait for response if we specify nowait
in the parameter?

I hope I have not missed anything here. 

Thanks
Maneesh

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/locking/rcupdate.html


