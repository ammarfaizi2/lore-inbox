Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbVL1Wg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbVL1Wg7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 17:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbVL1Wg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 17:36:59 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:18032 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964930AbVL1Wg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 17:36:59 -0500
Date: Wed, 28 Dec 2005 14:36:54 -0800
To: linux-kernel@vger.kernel.org
Subject: hfsplus oops in 2.6.14
Message-ID: <20051228223654.GA3183@darjeeling.triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: joshk@darjeeling.triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hfsplus oopses trying to mount a filesystem on 2.6.14 / x86_64:

% sudo mount /dev/sda3 /mnt/m1
Unable to load NLS charset utf8
Unable to load NLS charset utf8
Unable to handle kernel NULL pointer dereference at 0000000000000018 RIP:
<ffffffff8859a44a>{:hfsplus:hfsplus_asc2uni+74}
PGD 3bda4067 PUD 3e5d2067 PMD 0
Oops: 0000 [1] PREEMPT
CPU 0
Modules linked in: hfsplus orinoco_plx orinoco hermes skge ipt_state ipt_MASQUERADE ipt_iprange ipt_LOG iptable_mangle iptable_filter iptable_nat ip_nat ip_tables ip_conntrack nfsd exportfs lp gameport snd_mpu401_uart snd_seq_device nvidia i2c_viapro w83627hf hwmon_vid i2c_isa sd_mod eth1394 sbp2 joydev evdev ohci1394
ieee1394 ehci_hcd
Pid: 3403, comm: mount Tainted: P      2.6.14 #2
RIP: 0010:[<ffffffff8859a44a>] <ffffffff8859a44a>{:hfsplus:hfsplus_asc2uni+74}
RSP: 0018:ffff81003bd479c8  EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 000000000000001d
RDX: ffff81003bd479de RSI: 000000000000001d RDI: ffffffff8859b35c
RBP: 000000000000001d R08: 0000000000000003 R09: 0000000000000001
R10: 0000000000000000 R11: ffffffff8020b6b0 R12: ffffffff8859b35c
R13: ffff81003d506806 R14: 0000000000000001 R15: 0000000000000000
FS:  00002aaaab00e6d0(0000) GS:ffffffff80519800(0000) knlGS:0000000055ee0bb0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000018 CR3: 000000003a854000 CR4: 00000000000006e0
Process mount (pid: 3403, threadinfo ffff81003bd46000, task ffff81003ad895d0)
Stack: 0000000000000000 ffffffff801921f5 0000000000000000 ffff81003d506800
       ffff81003b032540 ffff81003d576c00 0000000000000000 ffff81003ab5d400
       ffff81003bd47c88 ffffffff88595561
Call Trace:<ffffffff801921f5>{d_alloc+149} <ffffffff88595561>{:hfsplus:hfsplus_cat_build_key+33}
       <ffffffff88592baa>{:hfsplus:hfsplus_fill_super+1066}
       <ffffffff801813ab>{do_open+763} <ffffffff80181594>{blkdev_get+132}
       <ffffffff80214071>{vsnprintf+1473} <ffffffff80214154>{snprintf+68}
       <ffffffff80197482>{get_filesystem+18} <ffffffff8018017a>{sget+1194}
       <ffffffff8017ed40>{set_bdev_super+0} <ffffffff80180418>{get_sb_bdev+280}
       <ffffffff88592780>{:hfsplus:hfsplus_fill_super+0} <ffffffff8017f5cc>{do_kern_mount+204}
       <ffffffff8019915e>{do_mount+1742} <ffffffff80167130>{do_no_page+1264}
       <ffffffff8010f44d>{error_exit+0} <ffffffff8015b1f1>{buffered_rmqueue+625}
       <ffffffff803cdea3>{do_page_fault+1171} <ffffffff8015b380>{__alloc_pages+256}
       <ffffffff8015b93e>{__get_free_pages+30} <ffffffff801992ab>{sys_mount+155}
       <ffffffff8010eb5a>{system_call+126}

This was because I did not have nls_utf8 available, and the check in
hfsplus_fill_super checks the wrong pointer for NULLness (it checks the
saved nls, not the new one that it needs to use.) Here's a one-liner
patch against 2.6.15-rc7, if it still matters - it seems to.

Signed-off-by: Joshua Kwan <joshk@triplehelix.org>

--- linux-2.6.14/fs/hfsplus/super.c~	2005-12-28 14:35:46.000000000 -0800
+++ linux-2.6.14/fs/hfsplus/super.c	2005-12-28 14:36:04.000000000 -0800
@@ -320,7 +320,7 @@
 	/* temporarily use utf8 to correctly find the hidden dir below */
 	nls = sbi->nls;
 	sbi->nls = load_nls("utf8");
-	if (!nls) {
+	if (!sbi->nls) {
 		printk("HFS+: unable to load nls for utf8\n");
 		err = -EINVAL;
 		goto cleanup;

-- 
Joshua Kwan
