Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbUHQLiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUHQLiP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 07:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUHQLiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 07:38:15 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:33520 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S266425AbUHQLhE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 07:37:04 -0400
Date: Tue, 17 Aug 2004 17:08:39 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: 2.6.8.1-mm1
Message-ID: <20040817113839.GB7005@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040816143710.1cd0bd2c.akpm@osdl.org> <1092722342.3081.68.camel@booger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092722342.3081.68.camel@booger>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found this to be due to task leak in exit code. In release_task:

	a. Task is removed from task-list (unhash_process)
	b. More processing is done (like proc_pid_flush etc)
	   before task finally dies.

The problem is the task can get preempted between a and b. In that window
its CPU can die and migrate_all_tasks will not migrate the task (since
it is not on the list).  This will cause the task to be forever stuck
to the dead cpu.

One option is not to remove the task until the last minute (when
it calls schedule). Rusty however felt that release_task can be 
called from __put_task_struct, which will avoid the problem we have
now. He is most likely going to send a patch for the same.

	
On Tue, Aug 17, 2004 at 12:59:02AM -0500, Nathan Lynch wrote:
> I can consistently hit this BUG_ON in migration_call's CPU_DEAD handling
> by doing:
> 
> while true ; do
> echo 0 > /sys/devices/system/cpu/cpu1/online
> echo 1 > /sys/devices/system/cpu/cpu1/online
> done
> 
> and then starting a kernel build.  It seems to take less than 20
> minutes.  I can also recreate it on ppc64, but only with
> CONFIG_PREEMPT=y (I haven't tried without preempt on i386 yet).
> 
> kernel BUG at kernel/sched.c:4035!                                              
> invalid operand: 0000 [#1]                                                      
> PREEMPT SMP                                                                     
> Modules linked in:                                                              
> CPU:    0                                                                       
> EIP:    0060:[<c0122b1b>]    Not tainted VLI                                    
> EFLAGS: 00010202   (2.6.8.1-mm1)                                                
> EIP is at migration_call+0x1bb/0x300                                            
> eax: 00000001   ebx: c1410f60   ecx: 00000000   edx: deee8ec8                   
> esi: deee8000   edi: 00000001   ebp: deee8ee0   esp: deee8eb8                   
> ds: 007b   es: 007b   ss: 0068                                                  
> Process bash (pid: 2956, threadinfo=deee8000 task=df448150)                     
> Stack: deee8ed4 de6f6630 de6f6630 deee8ed4 00000296 deee8ee4 00000296 c04a5b78  
>        00000001 00000006 deee8ef4 c0136928 deee8000 00000001 c04a7a40 deee8f2c  
>        c01405ac c01a8d79 c04f5700 00000000 deee8000 00000001 00000001 000000ff  
> Call Trace:                                                                     
>  [<c01082ea>] show_stack+0x7a/0x90                                              
>  [<c0108472>] show_registers+0x152/0x1c0                                        
>  [<c01086a0>] die+0x110/0x200                                                   
>  [<c0108b99>] do_invalid_op+0xe9/0xf0                                           
>  [<c0107ed9>] error_code+0x2d/0x38                                              
>  [<c0136928>] notifier_call_chain+0x28/0x50                                     
>  [<c01405ac>] cpu_down+0x11c/0x230                                              
>  [<c02a5d98>] store_online+0x38/0x40                                            
>  [<c02a3117>] sysdev_store+0x37/0x40                                            
>  [<c01a8b8e>] flush_write_buffer+0x2e/0x40                                      
>  [<c01a8bea>] sysfs_write_file+0x4a/0x60                                        
>  [<c016b362>] vfs_write+0xa2/0x100                                              
>  [<c016b471>] sys_write+0x41/0x70                                               
>  [<c010746f>] syscall_call+0x7/0xb                                              
> Code: 0b cd 0f 6f 54 43 c0 eb 8e c7 04 24 6f 34 43 c0 b8 54 2a 12 c0 89 44 24 04
>  e8 e2 3f 00 00 0f 0b 89 00 82 d4 42 c0 e9 4a ff ff ff <0f> 0b c3 0f 6f 54 43 c0
>  e9 2c ff ff ff e8 53 87 2f 00 e9 17 ff
> 
> Nathan
> 

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
