Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422999AbWJaJJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422999AbWJaJJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 04:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422989AbWJaJJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 04:09:59 -0500
Received: from ns1.suse.de ([195.135.220.2]:23444 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161619AbWJaJJ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 04:09:57 -0500
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 31 Oct 2006 20:09:50 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17735.4830.610969.866898@cse.unsw.edu.au>
Cc: jens.axboe@oracle.com, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH 002 of 6] md: Change lifetime rules for 'md' devices.
In-Reply-To: message from Andrew Morton on Tuesday October 31
References: <20061031164814.4884.patches@notabene>
	<1061031060051.5046@suse.de>
	<20061031002245.dfd1bb66.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday October 31, akpm@osdl.org wrote:
> On Tue, 31 Oct 2006 17:00:51 +1100
> NeilBrown <neilb@suse.de> wrote:
> 
> > Currently md devices are created when first opened and remain in existence
> > until the module is unloaded.
> > This isn't a major problem, but it somewhat ugly.
> > 
> > This patch changes the lifetime rules so that an md device will
> > disappear on the last close if it has no state.
> 
> This kills the G5:
> 
> 
> EXT3-fs: recovery complete.
> EXT3-fs: mounted filesystem with ordered data mode.
> Oops: Kernel access of bad area, sig: 11 [#1]
> SMP NR_CPUS=4 
> Modules linked in:
> NIP: C0000000001A31B8 LR: C00000000018E5DC CTR: C0000000001A3404
> REGS: c0000000017ff4a0 TRAP: 0300   Not tainted  (2.6.19-rc4-mm1)
> MSR: 9000000000009032 <EE,ME,IR,DR>  CR: 84000048  XER: 00000000
> DAR: 6B6B6B6B6B6B6BB3, DSISR: 0000000040000000
> TASK = c00000000ff2b7f0[1899] 'nash' THREAD: c0000000017fc000 CPU: 1
> GPR00: 0000000000000008 C0000000017FF720 C0000000006B26D0 6B6B6B6B6B6B6B7B 
..
> NIP [C0000000001A31B8] .kobject_uevent+0xac/0x55c
> LR [C00000000018E5DC] .__elv_unregister_queue+0x20/0x44
> Call Trace:
> [C0000000017FF720] [C000000000562508] read_pipe_fops+0xd0/0xd8 (unreliable)
> [C0000000017FF840] [C00000000018E5DC] .__elv_unregister_queue+0x20/0x44
> [C0000000017FF8D0] [C000000000195548] .blk_unregister_queue+0x58/0x9c
> [C0000000017FF960] [C00000000019683C] .unlink_gendisk+0x1c/0x50
> [C0000000017FF9F0] [C000000000122840] .del_gendisk+0x98/0x22c

I'm guessing we need

diff .prev/block/elevator.c ./block/elevator.c
--- .prev/block/elevator.c	2006-10-31 20:06:22.000000000 +1100
+++ ./block/elevator.c	2006-10-31 20:06:40.000000000 +1100
@@ -926,7 +926,7 @@ static void __elv_unregister_queue(eleva
 
 void elv_unregister_queue(struct request_queue *q)
 {
-	if (q)
+	if (q && q->elevator)
 		__elv_unregister_queue(q->elevator);
 }


Jens?  md never registers and elevator for its queue.

> 
> Also, it'd be nice to enable CONFIG_MUST_CHECK and take a look at a few
> things...
> 
> drivers/md/md.c: In function `bind_rdev_to_array':
> drivers/md/md.c:1379: warning: ignoring return value of `kobject_add', declared with attribute warn_unused_result
> drivers/md/md.c:1385: warning: ignoring return value of `sysfs_create_link', declared with attribute warn_unused_result
> drivers/md/md.c: In function `md_probe':
> drivers/md/md.c:2986: warning: ignoring return value of `kobject_register', declared with attribute warn_unused_result
> drivers/md/md.c: In function `do_md_run':
> drivers/md/md.c:3135: warning: ignoring return value of `sysfs_create_group', declared with attribute warn_unused_result
> drivers/md/md.c:3150: warning: ignoring return value of `sysfs_create_link', declared with attribute warn_unused_result
> drivers/md/md.c: In function `md_check_recovery':
> drivers/md/md.c:5446: warning: ignoring return value of `sysfs_create_link', declared with attribute warn_unused_result

I guess... I saw mail a while ago about why we really should be
checking those.  I'll have to dig it up again.

NeilBrown
