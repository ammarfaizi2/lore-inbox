Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbVBUKtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVBUKtu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 05:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVBUKtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 05:49:50 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:6807 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S261947AbVBUKtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 05:49:19 -0500
Subject: Re: Odd data corruption problem with LVM/ReiserFS
From: Vladimir Saveliev <vs@namesys.com>
To: Alex Adriaanse <alex.adriaanse@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       reiserfs-list@namesys.com
In-Reply-To: <93ca3067050220212518d94666@mail.gmail.com>
References: <93ca3067050220212518d94666@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1108982927.21144.296.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 21 Feb 2005 13:48:47 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Mon, 2005-02-21 at 08:25, Alex Adriaanse wrote:
> As of this morning I've experienced some very odd data corruption
> problem on my server.  Let me post some background information first.
> 
> For the past few years I've been running this server under Linux 2.4.x
> and Debian Woody.  It has two software RAID 1 partitions, one for the
> ReiserFS root filesystem (md0), and one for LVM running on top of RAID
> 1 (md1).  Under LVM I have three logical volumes, one for /usr, one
> for /var, and one for /home.  All of them run ReiserFS.  Also, during
> daily backups I'd create a snapshot of /var and /home and back that
> up.  I haven't experienced any problems with this, other than
> occasional power outages which might've corruped some log files by
> adding a bunch of NULs to it, but that's never caused problems for me.
> 
> A few weeks ago I decided to upgrade to Debian Sarge.  This was a
> fairly smooth process, and haven't seen any problems with that (and I
> don't think this is related to the problem I described below).  Also,
> last week I decided to upgrade from the 2.4.22 kernel to 2.6.10-ac12. 
> This has been a pretty smooth ride too (until this morning).  One
> exception is that I might not have had swap turned on due to device
> name changes, so yesterday I saw some big processes getting killed due
> to out-of-memory conditions (my server has 256MB non-ECC RAM, normally
> with 512MB of swap).  That swap issue had not been fixed until this
> afternoon, after the crash/corruption.  Yesterday afternoon I also
> updated the metadata of my LVM volume group from version 1 to version
> 2.  Before then I temporarily stopped taking snapshots once I upgraded
> to 2.6.10-ac12 since it didn't like taking snapshots inside LVM1
> volume groups.  This morning was the first time my backup script took
> a snapshot since upgrading to 2.6.10-ac12 (yesterday I had taken a few
> snapshots myself for testing purposes, this seemed to work fine).
> 
> This morning when I tried to login after the backup process (which
> takes snapshots) had started I couldn't get in.  SSH would just hang
> after I sent my username.  After a while I gave up waiting and tried
> to reboot the server by attaching a keyboard and hitting Ctrl-Alt-Del,
> which started the shutdown process.  I can't fully remember if that
> successfully rebooted the server, but I believe I ended up having to
> press the reset button because the shutdown process would hang at some
> point.  The server came back up but some processes wouldn't start due
> to some corrupted files in the /var partition.
> 
> I checked the logs, and saw a bunch of the messages below.  On a
> sidenote, when my backup script isn't able to mount a snapshot, it
> removes it, waits a minute, then tries creating/mounting the snapshot
> again, supposedly up to 10 times, even though those messages, spaced
> apart by one minute, occurred much more than 10 times, but that might
> be a bug in my script.  This was due to occasional problems I had with
> older kernels which sometimes failed to mount the snapshot, but were
> successful when trying again later.
> 
> These are the messages I saw:
> 
> Feb 20 09:59:16 homer kernel: lvcreate: page allocation failure.
> order:0, mode:0xd0
> Feb 20 09:59:16 homer kernel:  [__alloc_pages+440/864] __alloc_pages+0x1b8/0x360
> Feb 20 09:59:16 homer kernel:  [alloc_pl+51/96] alloc_pl+0x33/0x60
> Feb 20 09:59:16 homer kernel:  [client_alloc_pages+28/96]
> client_alloc_pages+0x1c/0x60
> Feb 20 09:59:16 homer kernel:  [vmalloc+32/48] vmalloc+0x20/0x30
> Feb 20 09:59:16 homer kernel:  [kcopyd_client_create+104/192]
> kcopyd_client_create+0x68/0xc0
> Feb 20 09:59:16 homer kernel:  [dm_create_persistent+199/320]
> dm_create_persistent+0xc7/0x140
> Feb 20 09:59:16 homer kernel:  [snapshot_ctr+680/880] snapshot_ctr+0x2a8/0x370
> Feb 20 09:59:16 homer kernel:  [dm_table_add_target+262/432]
> dm_table_add_target+0x106/0x1b0
> Feb 20 09:59:16 homer kernel:  [populate_table+130/224] populate_table+0x82/0xe0
> Feb 20 09:59:16 homer kernel:  [table_load+103/368] table_load+0x67/0x170
> Feb 20 09:59:16 homer kernel:  [ctl_ioctl+241/336] ctl_ioctl+0xf1/0x150
> Feb 20 09:59:16 homer kernel:  [table_load+0/368] table_load+0x0/0x170
> Feb 20 09:59:16 homer kernel:  [sys_ioctl+173/528] sys_ioctl+0xad/0x210
> Feb 20 09:59:16 homer kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> Feb 20 09:59:16 homer kernel: device-mapper: error adding target to table
> Feb 20 09:59:16 homer kernel: lvremove: page allocation failure.
> order:0, mode:0xd0
> Feb 20 09:59:16 homer kernel:  [__alloc_pages+440/864] __alloc_pages+0x1b8/0x360
> Feb 20 09:59:16 homer kernel:  [alloc_pl+51/96] alloc_pl+0x33/0x60
> Feb 20 09:59:16 homer kernel:  [client_alloc_pages+28/96]
> client_alloc_pages+0x1c/0x60
> Feb 20 09:59:16 homer kernel:  [vmalloc+32/48] vmalloc+0x20/0x30
> Feb 20 09:59:16 homer kernel:  [kcopyd_client_create+104/192]
> kcopyd_client_create+0x68/0xc0
> Feb 20 09:59:16 homer kernel:  [dm_create_persistent+199/320]
> dm_create_persistent+0xc7/0x140
> Feb 20 09:59:16 homer kernel:  [snapshot_ctr+680/880] snapshot_ctr+0x2a8/0x370
> Feb 20 09:59:16 homer kernel:  [dm_table_add_target+262/432]
> dm_table_add_target+0x106/0x1b0
> Feb 20 09:59:16 homer kernel:  [populate_table+130/224] populate_table+0x82/0xe0
> Feb 20 09:59:16 homer kernel:  [table_load+103/368] table_load+0x67/0x170
> Feb 20 09:59:16 homer kernel:  [ctl_ioctl+241/336] ctl_ioctl+0xf1/0x150
> Feb 20 09:59:16 homer kernel:  [table_load+0/368] table_load+0x0/0x170
> Feb 20 09:59:16 homer kernel:  [sys_ioctl+173/528] sys_ioctl+0xad/0x210
> Feb 20 09:59:16 homer kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> Feb 20 09:59:16 homer kernel: device-mapper: error adding target to table
> ...
> 
> As far as I can tell all the directories are still intact, but there
> was a good number of files that had been corrupted.  Those files
> looked like they had some chunks removed, and some had a bunch of NUL
> characters (in blocks of 4096 characters).  Some files even had chunks
> of other files inside of them!  I suspect that some of the contents
> from the other files were from different partitions (e.g. /home
> contents in /var file).  I also believe I saw contents from my
> /root/.viminfo in one of the files in /var or /home (and keep in mind
> that my root partition which stores /root does not use LVM)
> 
> /var was not the only volume that was corrupted.  /home was corrupted
> as well.  I first thought files that had been written to within the
> past 24 hours were corrupted, but later I realized that some files
> that haven't been changed for months were corrupted too.
> 
> I did not test /usr for corruption.  Also, from some quick checks I
> did on my root (non-LVM) partition I did not find any corrupted files
> there, as far as I can remember.
> 
> I did a reiserfsck (3.6.19) on /var, which did not report any problems.
> 
> So, I figured I'd just restore those corrupted files from my backups. 
> I restored a few corrupted files, verified that they were in good
> shape, moved on to other parts... only to find out that the I restored
> first had become corrupted again (with a similar type of corruption as
> I saw before)!
> 
You shoult ask lvm mailing list, I guess

> Another thing to keep in mind is that I never removed those snapshots
> after rebooting.  I'd be curious to see if the continual corruption
> goes away if I remove those snapshots, but I'll wait to make sure you
> guys don't want me to try anything else first.
> 
> Also, I did a preliminary memory check to make sure my memory hadn't
> gone bad.  After a single pass of memtest86+ on my memory, it was not
> able to find any memory problems during that pass.
> 
> Anyway, what do you guys think could be the problem?  Could it be that
> the LVM / Device Mapper snapshot feature is solely responsible for
> this corruption?  (I'm sure there's a reason it's marked
> Experimental).
> 
> I know it might be hard to pinpoint without more details.  If you want
> me to provide more details (e.g. LVM data, debugreiserfs data, kernel
> config, more system details, etc.) or run some experiments, I can do
> so, but please let me know ASAP because I'm planning on scrapping my
> entire LVM volume group and restoring it from my backups tomorrow
> unless I'm told otherwise.
> 
> Thanks a lot,
> 
> Alex
> 

