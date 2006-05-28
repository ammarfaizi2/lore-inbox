Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWE1Jpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWE1Jpa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 05:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWE1Jpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 05:45:30 -0400
Received: from mx5.redainternet.nl ([82.98.244.137]:1039 "EHLO
	mx5.redainternet.nl") by vger.kernel.org with ESMTP id S932105AbWE1Jp3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 05:45:29 -0400
Message-ID: <44797136.4050707@inn.nl>
Date: Sun, 28 May 2006 11:45:26 +0200
From: Arend Freije <afreije@inn.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.8.0.1) Gecko/20060418 SeaMonkey/1.0
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: RAID-1 and Reiser4 issue: umount hangs
References: <4478CF33.80609@inn.nl> <17528.55008.287088.705263@cse.unsw.edu.au>
In-Reply-To: <17528.55008.287088.705263@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> # echo t > /proc/sysrq-trigger
>
> and look at the resulting kernel messages, particularly for the
> unmount process.  If they don't make sense to you, post them.
>
>   
Tnx for your response. After recompiling the kernel with magic_sysrq
enabled, rebooting, and repeating umount with the reiser4 md device, the
following trace contains a reiser4-entry:

> syslog-ng     R running     0  7581      1                7197 (NOTLB)
> umount        D C011B591     0  7588   7200                     (NOTLB)
> f6643c98 00000000 c1808320 c011b591 f7db5ad0 f4d18c00 003d092a 00000000
> 00000000 f7db5ad0 c1808320 00000000 f4d18c00 003d092a f6b33540 c1808320
> 00000000 f4d18c00 003d092a f6b33540 f6b33668 c1808320 00000000 f6643cfc
> Call Trace:
> [<c011b591>] __wake_up_common+0x41/0x70
> [<c0318346>] io_schedule+0x26/0x30
> [<c01469fb>] sync_page+0x4b/0x60
> [<c03184d5>] __wait_on_bit+0x45/0x70
> [<c01469b0>] sync_page+0x0/0x60
> [<c014726d>] wait_on_page_bit+0xad/0xc0
> [<c0136a30>] wake_bit_function+0x0/0x60
> [<c0136a30>] wake_bit_function+0x0/0x60
> [<c01ac2f9>] jwait_io+0x59/0x80
> [<c01c1763>] update_journal_header+0x83/0xb0
> [<c01c272a>] commit_tx+0xca/0x110
> [<c01c29a1>] reiser4_write_logs+0x141/0x1e0
> [<c01b9d91>] commit_current_atom+0x171/0x2c0
> [<c01baabf>] try_commit_txnh+0x13f/0x1e0
> [<c01bab94>] commit_txnh+0x34/0xd0
> [<c01b91bc>] txn_end+0x2c/0x30
> [<c01b91d0>] txn_restart+0x10/0x30
> [<c01b920a>] txn_restart_current+0x1a/0x20
> [<c01b9f1f>] force_commit_atom+0x3f/0x70
> [<c01ba03a>] txnmgr_force_commit_all+0xea/0x130
> [<c01fcb0e>] release_format40+0x7e/0x150
> [<c01b5ea8>] init_context+0x58/0x80
> [<c01c8b89>] reiser4_put_super+0x89/0xf0
> [<c01857ed>] invalidate_inodes+0x5d/0x80
> [<c0170fb6>] generic_shutdown_super+0x156/0x160
> [<c0171b2d>] kill_block_super+0x2d/0x50
> [<c0170d90>] deactivate_super+0x60/0x80
> [<c0188e1f>] sys_umount+0x3f/0x90
> [<c01171b0>] do_page_fault+0x1c0/0x5a8
> [<c0159bc1>] sys_munmap+0x51/0x80
> [<c0188e87>] sys_oldumount+0x17/0x20
> [<c010306b>] sysenter_past_esp+0x54/0x75

Freely inerpreting this trace, I'd say that the umount causes the
reiser4 filesystem to do an extra commit, and the sync_page seems to be
waiting for IO.
Are there other traces of interrest?


