Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVDZHOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVDZHOb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 03:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVDZHOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 03:14:24 -0400
Received: from colino.net ([213.41.131.56]:64240 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261381AbVDZHOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 03:14:10 -0400
Date: Tue, 26 Apr 2005 09:14:03 +0200
From: Colin Leroy <colin@colino.net>
To: Colin Leroy <colin@colino.net>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hfsplus: don't oops on bad FS
Message-ID: <20050426091403.099cee53@colin.toulouse>
In-Reply-To: <20050426085914.2b278856@colin.toulouse>
References: <20050425211915.126ddab5@jack.colino.net>
	<Pine.LNX.4.61.0504252145220.25129@scrub.home>
	<20050425220345.6b2ed6d5@jack.colino.net>
	<Pine.LNX.4.61.0504252218570.25129@scrub.home>
	<20050426085914.2b278856@colin.toulouse>
X-Mailer: Sylpheed-Claws 1.9.6 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2005 08:59:14 +0200
Colin Leroy <colin@colino.net> wrote:

>  cleanup:
> +       kfree(sb->s_fs_info);
> +       sb->s_fs_info = NULL;
> +

Also, that may be wrong: maybe hfsplus_put_super has a job to do if
mounting fails later than "no hfs+ fs found".

My understanding of the driver is limited, that's why my initial patch
did the less possible functionality change. But I'd like to remember
you (maybe you forgot) that my initial patch wasn't about fixing the
s_fs_info leak, but rather fixing an oops that happens in
hfsplus_put_super. That's why I don't think we can run the current code
in hfsplus_put_super from hfsplus_fill_super cleanup part : 

HFS+-fs: unable to find HFS+ superblock
Oops: kernel access of bad area, sig: 11 [#1]
NIP: EA4707F4 LR: EA470AC8 SP: CC91DAA0 REGS: cc91d9f0 TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000004, DSISR: 40000000
TASK = ce48cdf0[20295] 'mount' THREAD: cc91c000
Last syscall: 21
GPR00: 00000000 CC91DAA0 CE48CDF0 CB2FF200 C0373ECC 00000004 E756CD60 3B9ACA00
GPR08: C2B71F60 C0360000 00000000 BE932A74 0000D903 1002957C 10020000 10026810
GPR16: 100267E0 10026840 7FF3F4DD 100267D0 7FF3F4B3 00000000 10026820 10026820
GPR24: 7FF3EF70 EA4709EC EA105714 00000000 00000000 C9341000 C2B71F60 CB2FF200
NIP [ea4707f4] hfsplus_put_super+0x9c/0x114 [hfsplus]
LR [ea470ac8] hfsplus_fill_super+0xdc/0x5a8 [hfsplus]
Call trace:
 [ea470ac8] hfsplus_fill_super+0xdc/0x5a8 [hfsplus]
 [c00644e4] get_sb_bdev+0x14c/0x1d4
 [ea471018] hfsplus_get_sb+0x18/0x28 [hfsplus]
 [c0064824] do_kern_mount+0x5c/0x130
 [c007c774] do_mount+0x46c/0x6cc
 [c007ce18] sys_mount+0x98/0xe8
 [c0004840] ret_from_syscall+0x0/0x44

-- 
Colin
