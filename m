Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264062AbUDBT4N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 14:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264088AbUDBT4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 14:56:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:10159 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264062AbUDBT4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 14:56:08 -0500
Date: Fri, 2 Apr 2004 11:56:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: markw@osdl.org
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.5-rc3-mm4
Message-Id: <20040402115601.24912093.akpm@osdl.org>
In-Reply-To: <200404021904.i32J4M215682@mail.osdl.org>
References: <20040401020512.0db54102.akpm@osdl.org>
	<200404021904.i32J4M215682@mail.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

markw@osdl.org wrote:
>
> I reran DBT-2 to with ext2 and ext3 (in case you were still interested)
>  on my 4-way Xeon system with 60+ drives:
>  	http://developer.osdl.org/markw/fs/dbt2_project_results.html
> 
>  Aside from the from the drop you're already aware of since 2.6.3, it
>  looks like DBT-2 takes another smaller hit after 2.6.5-rc3-mm2.  Here's
>  a brief summary from the link above:

The profile is interesting:

3671973 poll_idle                                63309.8793
 77750 __copy_from_user_ll                      637.2951
 64788 generic_unplug_device                    487.1278
 62968 DAC960_LP_InterruptHandler               336.7273
 53908 finish_task_switch                       361.7987
 52947 __copy_to_user_ll                        441.2250
 29419 dm_table_unplug_all                      439.0896
 25947 __make_request                            17.9938
 18564 dm_table_any_congested                   199.6129
 13785 update_queue                             104.4318
 13498 try_to_wake_up                            20.3590
 12736 __wake_up                                114.7387
 12560 kmem_cache_alloc                         163.1169
 12221 .text.lock.sched                          40.7367

- There's a ton of idle time there.

- The CPU scheduler is hurting.  Nick and Ingo are patching up a storm to
  fix a similar problem which Jeremy Higdon is observing at 200,000
  IOs/sec.  This will get better.

- That 60-disk LVM array is costing us in the new unplug and congestion
  code.  Jens, didn't you have a tune-up for that in the works?

- I'm surprised that you didn't see big gains from ext3-fsync-speedup,
  even though it appears that the test uses fdatasync().

