Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267208AbTBUHSL>; Fri, 21 Feb 2003 02:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267216AbTBUHSL>; Fri, 21 Feb 2003 02:18:11 -0500
Received: from franka.aracnet.com ([216.99.193.44]:13240 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267208AbTBUHSH>; Fri, 21 Feb 2003 02:18:07 -0500
Date: Thu, 20 Feb 2003 23:28:07 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Strange performance change 59 -> 61/62
Message-ID: <17930000.1045812486@[10.10.2.4]>
In-Reply-To: <17280000.1045811967@[10.10.2.4]>
References: <32720000.1045671824@[10.10.2.4]> <20030219101957.05088aa1.akpm@digeo.com> <17280000.1045811967@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> I'm comparing 59-mjb6 to 61-mjb1 and notice some strange performance
>>> differences that I can't explain ... not a big drop, but odd.
>>> ...
>>> 
>>> 1562 .text.lock.file_table
>>> 583 dentry_open
>>> 551 get_empty_filp
>> 
>> The first one here is fget().  That's causing problems on ppc64 as well - the
>> machine is spending as long in fget as it is in copy_foo_user() in dbench
>> runs.
>> 
>> One possibility is that we're calling fget() more often than previously,
>> although that would be rather odd.  Can you add the below patch, and monitor
>> /proc/meminfo:nr_fgets?

Some more stats ... which look rather suspicious. 600% increase for
dentry_open and __mark_inode_dirty? Hmmmmm.

      5198    35.9% .text.lock.file_table
      4562     2.6% total
       736    19.5% get_empty_filp
       568   617.4% dentry_open
       510   607.1% __mark_inode_dirty
       285    11.3% atomic_dec_and_lock
       272    11.9% __fput
       230    23.0% dput
       167     8.9% file_move
       159     1.0% page_remove_rmap
       128    67.7% vma_merge
       118    17.1% current_kernel_time
        66     1.0% page_add_rmap
        62     0.0% can_vma_merge_after
        50     2.3% do_schedule
...
       -56   -16.0% do_brk
       -67    -8.5% sys_brk
       -73    -0.5% do_anonymous_page
       -83   -45.6% do_lookup
      -109   -11.3% fd_install
      -114    -3.9% __copy_from_user_ll
      -133   -10.9% do_generic_mapping_read
      -282   -18.4% vfs_read
      -314   -34.4% file_ra_state_init
      -373    -7.7% vm_enough_memory
      -445    -5.5% d_lookup
     -1693    -3.8% default_idle

