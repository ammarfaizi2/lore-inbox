Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319574AbSIHHc2>; Sun, 8 Sep 2002 03:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319575AbSIHHc2>; Sun, 8 Sep 2002 03:32:28 -0400
Received: from packet.digeo.com ([12.110.80.53]:49562 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319574AbSIHHcZ>;
	Sun, 8 Sep 2002 03:32:25 -0400
Message-ID: <3D7B0179.2F9ED774@digeo.com>
Date: Sun, 08 Sep 2002 00:51:21 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: LMbench2.0 results
References: <20020907180937.16081.qmail@linuxmail.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Sep 2002 07:37:01.0016 (UTC) FILETIME=[84DCFD80:01C2570A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ciarrocchi wrote:
> 
> ...
> File & VM system latencies in microseconds - smaller is better
> --------------------------------------------------------------
> Host                 OS   0K File      10K File      Mmap    Prot    Page
>                         Create Delete Create Delete  Latency Fault   Fault
> --------- ------------- ------ ------ ------ ------  ------- -----   -----
> frodo      Linux 2.4.18   68.9   16.0  185.8   31.6    425.0 0.789 2.00000
> frodo      Linux 2.4.19   68.9   14.9  186.5   29.8    416.0 0.798 2.00000
> frodo      Linux 2.5.33   77.8   19.1  211.6   38.3    774.0 0.832 3.00000
> frodo     Linux 2.5.33x   77.2   18.8  206.7   37.0    769.0 0.823 3.00000
> 

The create/delete performance is filesystem-specific.

profiling lat_fs on ext3:

c0170b70 236      0.372293    ext3_get_inode_loc      
c014354c 278      0.438548    __find_get_block        
c017cbf0 284      0.448013    journal_cancel_revoke   
c017ee24 291      0.459056    journal_add_journal_head 
c0171030 307      0.484296    ext3_do_update_inode    
c017856c 353      0.556861    journal_get_write_access 
c0178088 487      0.768248    do_get_write_access     
c0114744 530      0.836081    smp_apic_timer_interrupt 
c0178a84 559      0.881829    journal_dirty_metadata  
c0130644 832      1.31249     generic_file_write_nolock 
c0172654 2903     4.57951     ext3_add_entry          
c016ca10 3636     5.73583     ext3_check_dir_entry    
c0107048 47078    74.2661     poll_idle               

ext3_check_dir_entry is just sanity checking.  hmm.

on ext2:

c017f3ec 138      0.239971    ext2_free_blocks        
c012f560 147      0.255621    unlock_page             
c017f954 148      0.25736     ext2_new_block          
c017f2f0 154      0.267793    ext2_get_group_desc     
c0181958 162      0.281705    ext2_new_inode          
c014354c 182      0.316483    __find_get_block        
c0154f64 184      0.319961    __d_lookup              
c0109bc0 232      0.403429    apic_timer_interrupt    
c0143cc4 455      0.791208    __block_prepare_write   
c0114744 459      0.798164    smp_apic_timer_interrupt 
c0130644 1634     2.84139     generic_file_write_nolock 
c0180c64 6084     10.5796     ext2_add_link           
c0107048 42472    73.8554     poll_idle               

This is mostly in ext2_match() - comparing strings while
searching the directory.  memcmp().

ext3 with hashed index directories:

c01803dc 292      0.495251    journal_unlock_journal_head 
c0170b70 313      0.530868    ext3_get_inode_loc      
c01801a4 412      0.698779    journal_add_journal_head 
c014354c 455      0.77171     __find_get_block        
c0171030 489      0.829376    ext3_do_update_inode    
c017df70 515      0.873474    journal_cancel_revoke   
c01798ec 555      0.941316    journal_get_write_access 
c0173208 568      0.963365    ext3_add_entry          
c0179408 804      1.36364     do_get_write_access     
c0179e04 838      1.4213      journal_dirty_metadata  
c0130644 1127     1.91147     generic_file_write_nolock 
c0107048 44117    74.8253     poll_idle               

And yet the test (which tries to run for a fixed walltime)
seems to do the same amount of work.  No idea what's up
with that.

Lessons: use an indexed-directory filesystem, and consistency
checking costs.
