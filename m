Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbUDRRFb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 13:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbUDRRFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 13:05:31 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:54492 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262176AbUDRRF0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 13:05:26 -0400
Date: Sun, 18 Apr 2004 22:36:13 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: rusty@au1.ibm.com, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       lhcs-devel@lists.sourceforge.net
Subject: CPU Hotplug broken -mm5 onwards
Message-ID: <20040418170613.GA21769@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I found that I can't boot with CONFIG_HOTPLUG_CPU defined in both
mm5 and mm6. Debugging this revealed it to be because exec path can now require 
cpu hotplug sem (sched_migrate_task) and this has lead to a deadlock between 
flush_workqueue and __call_usermodehelper. 

flush_workqueue takes cpu hotplug sem and blocks until workqueue is flushed.
__call_usermodehelper, one of the queued work function, blocks because it
also needs cpu hotplug sem during exec.  As of result of this, exec does not 
progress and system does not boot.

I feel we can fix this by converting cpucontrol to a reader-writer semaphore or 
big-reader-lock(?). One problem with reader-writer semaphore is there does not
seem to be any down_write_interruptible, which is needed by cpu_down/up.

Comments?

BTW, I think a cpu_is_offline check is needed in sched_migrate_task, since
dest_cpu could have been downed by the time it has acquired the semaphore. 
In which case, we could end up adding the task to dead cpu's runqueue?
An alternate solution would be to put the same check in __migrate_task.



-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
