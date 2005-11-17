Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161120AbVKQD4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161120AbVKQD4L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 22:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161125AbVKQD4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 22:56:11 -0500
Received: from ms-smtp-02-smtplb.tampabay.rr.com ([65.32.5.132]:46025 "EHLO
	ms-smtp-02.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1161120AbVKQD4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 22:56:10 -0500
Message-ID: <437BFF4A.4060402@cfl.rr.com>
Date: Wed, 16 Nov 2005 22:55:54 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: VIA SATA Raid needs a long time to recover from suspend
References: <437AA996.9080505@cfl.rr.com> <20051116170642.313aeada.akpm@osdl.org>
In-Reply-To: <20051116170642.313aeada.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>This change will increase the minimum delay in both ata_wait_idle() and
>ata_busy_wait() from 10 usec to 100 usec, which is not a good change.
>
>It would be less damaging to increase the delay in ata_wait_idle() from
>1000 to 100,000.  A one second spin is a bit sad, but the hardware's bust,
>so that's the least of the user's worries.
>
>The best fix would be to identify the specific _callers_ of these functions
>which need their delay increased.   You can do that by adding:
>
>	if (max == 0)
>		dump_stack();
>
>at the end of ata_busy_wait().  The resulting stack dumps will tell you
>where the offending callsites are.  With luck, it's just one.  If we know
>which one, that might point us at some chipset-level delay which we're
>forgetting to do, or something like that.
>
>  
>

Right, changing ata_wait_idle's maximum to 100,000 would be a better fix 
as it would not effect the minimum wait time.  Thanks for the 
dump_stack() tip, I put that in and this is the call stack dumped for 
the two timeouts following a resume ( though without the stack dump, 
there were 6 timeouts reported, 3 on each channel ):

[    2.650217] Call Trace:<ffffffff88048782>{:libata:ata_dev_select+102} 
<ffffffff880488fa>{:libata:ata_qc_issue_prot+31}
[    2.650244]        <ffffffff8804ba48>{:libata:ata_scsi_translate+172} 
<ffffffff880244bd>{:scsi_mod:scsi_done+0}
[    2.650269]        <ffffffff880244bd>{:scsi_mod:scsi_done+0} 
<ffffffff8804bd06>{:libata:ata_scsi_queuecmd+219}
[    2.650291]        <ffffffff88024686>{:scsi_mod:scsi_dispatch_cmd+433}
[    2.650305]        <ffffffff8802978e>{:scsi_mod:scsi_request_fn+611} 
<ffffffff80148ea3>{sync_page+0}
[    2.650326]        <ffffffff80224858>{generic_unplug_device+7} 
<ffffffff80224851>{generic_unplug_device+0}
[    2.650334]        <ffffffff8807c118>{:dm_mod:dm_table_unplug_all+49} 
<ffffffff8807a0f1>{:dm_mod:dm_unplug_all+29}
[    2.650354]        <ffffffff8807c118>{:dm_mod:dm_table_unplug_all+49} 
<ffffffff8807a0f1>{:dm_mod:dm_unplug_all+29}
[    2.650372]        <ffffffff80164a08>{block_sync_page+58} 
<ffffffff80148ed6>{sync_page+51}
[    2.650381]        <ffffffff8028eb11>{__wait_on_bit_lock+55} 
<ffffffff801490fd>{__lock_page+94}
[    2.650392]        <ffffffff8013d37f>{wake_bit_function+0} 
<ffffffff80149374>{find_get_page+12}
[    2.650402]        <ffffffff8014a4de>{do_generic_mapping_read+472} 
<ffffffff8014947f>{file_read_actor+0}
[    2.650410]        <ffffffff8014af0a>{__generic_file_aio_read+333} 
<ffffffff8014b0c0>{generic_file_read+187}
[    2.650433]        <ffffffff8013d274>{autoremove_wake_function+0} 
<ffffffff80163898>{vfs_read+200}
[    2.650453]        <ffffffff8016ba1f>{kernel_read+65} 
<ffffffff8016d4c7>{do_execve+291}
[    2.650464]        <ffffffff8010cc31>{sys_execve+51} 
<ffffffff80139bd8>{worker_thread+0}
[    2.650475]        <ffffffff8010ef34>{execve+100} 
<ffffffff80139bd8>{worker_thread+0}
[    2.650482]        <ffffffff801397bb>{__call_usermodehelper+0} 
<ffffffff80139abc>{____call_usermodehelper+134}
[    2.650496]        <ffffffff8010eec6>{child_rip+8} 
<ffffffff80139bd8>{worker_thread+0}
[    2.650504]        <ffffffff801397bb>{__call_usermodehelper+0} 
<ffffffff80139a36>{____call_usermodehelper+0}
[    2.650514]        <ffffffff8010eebe>{child_rip+0}
[    2.693624] ATA: abnormal status 0x80 on port 0xE007
[    2.693626]
[    2.693627] Call 
Trace:<ffffffff880488fa>{:libata:ata_qc_issue_prot+31} 
<ffffffff8804ba48>{:libata:ata_scsi_translate+172}
[    2.693646]        <ffffffff880244bd>{:scsi_mod:scsi_done+0} 
<ffffffff880244bd>{:scsi_mod:scsi_done+0}
[    2.693670]        <ffffffff8804bd06>{:libata:ata_scsi_queuecmd+219} 
<ffffffff88024686>{:scsi_mod:scsi_dispatch_cmd+433}
[    2.693694]        <ffffffff8802978e>{:scsi_mod:scsi_request_fn+611} 
<ffffffff80148ea3>{sync_page+0}
[    2.693712]        <ffffffff80224858>{generic_unplug_device+7} 
<ffffffff80224851>{generic_unplug_device+0}
[    2.693720]        <ffffffff8807c118>{:dm_mod:dm_table_unplug_all+49} 
<ffffffff8807a0f1>{:dm_mod:dm_unplug_all+29}
[    2.693738]        <ffffffff8807c118>{:dm_mod:dm_table_unplug_all+49} 
<ffffffff8807a0f1>{:dm_mod:dm_unplug_all+29}
[    2.693756]        <ffffffff80164a08>{block_sync_page+58} 
<ffffffff80148ed6>{sync_page+51}
[    2.693765]        <ffffffff8028eb11>{__wait_on_bit_lock+55} 
<ffffffff801490fd>{__lock_page+94}
[    2.693775]        <ffffffff8013d37f>{wake_bit_function+0} 
<ffffffff80149374>{find_get_page+12}
[    2.693785]        <ffffffff8014a4de>{do_generic_mapping_read+472} 
<ffffffff8014947f>{file_read_actor+0}
[    2.693793]        <ffffffff8014af0a>{__generic_file_aio_read+333} 
<ffffffff8014b0c0>{generic_file_read+187}
[    2.693816]        <ffffffff8013d274>{autoremove_wake_function+0} 
<ffffffff80163898>{vfs_read+200}
[    2.693835]        <ffffffff8016ba1f>{kernel_read+65} 
<ffffffff8016d4c7>{do_execve+291}
[    2.693846]        <ffffffff8010cc31>{sys_execve+51} 
<ffffffff80139bd8>{worker_thread+0}
[    2.693857]        <ffffffff8010ef34>{execve+100} 
<ffffffff80139bd8>{worker_thread+0}
[    2.693864]        <ffffffff801397bb>{__call_usermodehelper+0} 
<ffffffff80139abc>{____call_usermodehelper+134}
[    2.693878]        <ffffffff8010eec6>{child_rip+8} 
<ffffffff80139bd8>{worker_thread+0}
[    2.693885]        <ffffffff801397bb>{__call_usermodehelper+0} 
<ffffffff80139a36>{____call_usermodehelper+0}
[    2.693896]        <ffffffff8010eebe>{child_rip+0}


Maybe a better fix would be to insert a delay after the resume but 
before the driver even tries to access the hardware.  Maybe somewhere in 
a method in the DSDT?

>Or should have returned an IO error.
>
>Yes, this might be a driver bug.  Again, if we know precisely which
>callsite is experiencing the timeout then we're better situated to fix it.
>
>
>  
>
I made the timeouts happen again by returning the timeouts to the way 
they were before, and issuing the command:

echo mem > /sys/power/state ; df

After the abnormal status messages, around 30 seconds went by, then this:

[   14.596710] ata1: command 0x25 timeout, stat 0x50 host_stat 0x1
[   14.596715]
[   14.596716] Call 
Trace:<ffffffff880498e2>{:libata:ata_eng_timeout+496} 
<ffffffff88027690>{:scsi_mod:scsi_error_handler+0}
[   14.596752]        <ffffffff8804af99>{:libata:ata_scsi_error+21} 
<ffffffff88027706>{:scsi_mod:scsi_error_handler+118}
[   14.596775]        <ffffffff88027690>{:scsi_mod:scsi_error_handler+0} 
<ffffffff88027690>{:scsi_mod:scsi_error_handler+0}
[   14.596803]        <ffffffff8013d0d8>{kthread+191} 
<ffffffff80139bd8>{worker_thread+0}
[   14.596814]        <ffffffff8010eec6>{child_rip+8} 
<ffffffff80139bd8>{worker_thread+0}
[   14.596822]        <ffffffff8013cf04>{keventd_create_kthread+0} 
<ffffffff8013d019>{kthread+0}
[   14.596833]        <ffffffff8010eebe>{child_rip+0}
[   14.597403] ReiserFS: warning: is_tree_node: node level 2295 does not 
match to the expected one 1
[   14.597408] ReiserFS: dm-5: warning: vs-5150: search_by_key: invalid 
format found in block 32828. Fsck?
[   14.597414] ReiserFS: dm-5: warning: vs-13070: 
reiserfs_read_locked_inode: i/o failure occurred trying to find stat 
data of [2 1455 0x0 SD]

Bash reports command not found when trying to run df even now as I write 
this. 

I also noticed that during the 30 seconds or so that the system was 
trying to load df before libata timed out the request, the cpu was 
pegged at 100% utilization. 


