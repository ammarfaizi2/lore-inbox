Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751850AbWKFLHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbWKFLHG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 06:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751975AbWKFLHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 06:07:06 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:55982 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751850AbWKFLHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 06:07:03 -0500
Message-ID: <454F16ED.7060204@sw.ru>
Date: Mon, 06 Nov 2006 14:05:17 +0300
From: Vasily Averin <vvs@sw.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Matthew Wilcox <willy@debian.org>
CC: Andy Whitcroft <apw@shadowen.org>, reiserfs-dev@namesys.com,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: 2.6.19-rc4-mm2 -- reiserfs umount panic
References: <20061101235407.a92f94a5.akpm@osdl.org>	<454B5B56.4090307@shadowen.org> <20061103110210.08169843.akpm@osdl.org>
In-Reply-To: <20061103110210.08169843.akpm@osdl.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew,
4 years ago you have patched the Locking document and changed the BKL rule for
remount_fs()

# ChangeSet
#   2003/08/21 00:28:27-07:00 akpm@osdl.org
#   [PATCH] update Documentation/filesystems/Locking
#   From: Matthew Wilcox <willy@debian.org>

locking rules:
 	All may block.
-		BKL	s_lock	mount_sem
-remount_fs:	yes	yes	maybe		(see below)
+			BKL	s_lock	s_umount
+remount_fs:		no	yes	maybe		(see below)

As far as I understand it was a misprint, de-facto BKL is required at least for
reiserfs, where is a long-lived check. Also I've found that currently
remount_fs() is called only from do_remount_sb(), which is called with taken BKL
in all cases:
- do_umount() and do_emergency_remount() acquires BKL directly;
- do_remount() which called from do_mount() with taken BKL;
- get_sb_single() which called from .get_sb() and should have BKL too

If you have not any objections I would like to fix this issue by the patch from
the following letter.

thank you,
	Vasily Averin

Andrew Morton wrote:
> On Fri, 03 Nov 2006 15:08:06 +0000
> Andy Whitcroft <apw@shadowen.org> wrote:
> 
>> Just happened to be watching a console of a test box when it was
>> performing a post job reboot and caught the following panic.  This
>> specific machine is a ppc64.  Sadly these are not part of the job.
>>
>> /me considers how we could fix that.  Perhaps we could just shove a
>> plain reboot at the end of one of the jobs ... hmmm.
>>
>> -apw
>>
>> REISERFS: panic (device sda3): journal_begin called without kernel lock held
>> kernel BUG in reiserfs_panic at fs/reiserfs/prints.c:361!
>> Oops: Exception in kernel mode, sig: 5 [#1]
>> SMP NR_CPUS=32 NUMA
>> Modules linked in:
>> NIP: C000000000125A60 LR: C000000000125A5C CTR: 00000000000D0274
>> REGS: c00000076e693640 TRAP: 0700   Not tainted  (2.6.19-rc4-mm2-autokern1)
>> MSR: 8000000000029032 <EE,ME,IR,DR>  CR: 22008424  XER: 00000000
>> TASK = c00000003fb68250[16416] 'umount' THREAD: c00000076e690000 CPU: 2
>> GPR00: C000000000125A5C C00000076E6938C0 C0000000006662E8 0000000000000050
>> GPR04: 0000000000000000 FFFFFFFFFFFFFFFF 656C206C6F636B20 68656C640D0A726E
>> GPR08: 0000000000000000 C00000000054EAB8 C00000000068F810 C00000000068F808
>> GPR12: 00000000000D0274 C000000000545500 0000000000000000 0000000000000000
>> GPR16: 00000000100A7D10 00000000100A94E0 0000000010070000 0000000000000000
>> GPR20: 0000000010010000 00000000FFFFFFFF 0000000010019218 0000000000000000
>> GPR24: 0000000000000000 000000000000000A C00000076E693BC0 000000000000000A
>> GPR28: C000000000518800 C00000076E693BC0 C000000000579080 C000000000518800
>> NIP [C000000000125A60] .reiserfs_panic+0x6c/0x90
>> LR [C000000000125A5C] .reiserfs_panic+0x68/0x90
>> Call Trace:
>> [C00000076E6938C0] [C000000000125A5C] .reiserfs_panic+0x68/0x90 (unreliable)
>> [C00000076E693940] [C000000000134A38] .reiserfs_check_lock_depth+0x30/0x48
>> [C00000076E6939C0] [C00000000013A654] .do_journal_begin_r+0x58/0x434
>> [C00000076E693AB0] [C00000000013AC54] .journal_begin+0x108/0x170
>> [C00000076E693B50] [C000000000123130] .reiserfs_remount+0x194/0x460
>> [C00000076E693C50] [C0000000000B47D0] .do_remount_sb+0x1a8/0x224
>> [C00000076E693CF0] [C0000000000D0E98] .sys_umount+0x19c/0x2a0
>> [C00000076E693E30] [C00000000000872C] syscall_exit+0x0/0x40
> 
> That thump you heard was the sound of
> vfs-bkl-is-not-required-for-remount_fs.patch getting dropped.  Thanks.

