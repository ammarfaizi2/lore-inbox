Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262934AbVHEJjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbVHEJjc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 05:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262936AbVHEJjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 05:39:32 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:14062 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262934AbVHEJiP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 05:38:15 -0400
Message-ID: <42F33379.5030804@namesys.com>
Date: Fri, 05 Aug 2005 13:38:01 +0400
From: "Vladimir V. Saveliev" <vs@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040804
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Guillaume Pelat <gp@winch-hebergement.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Reiserfs 3.6 + quota enabled, crash on delete (or maybe truncate)
References: <42F27161.2020702@winch-hebergement.net>
In-Reply-To: <42F27161.2020702@winch-hebergement.net>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010001050200040205070906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010001050200040205070906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello

Guillaume Pelat wrote:
> Hi,
> 
>  >> I'm having a crash with reiserfs 3.6 + user quota enabled, on
>  >> 2.6.11.10 kernel (no smp), apparently when deleting files (or maybe
>  >>  during a runcate operation). The problem seems to happen under high
>  >>  load.
>  >> When the error occurs, all the processes accessing the reiserfs
>  >> partition seems to hang. This problem happened several times on
>  >> different servers (having the same hardware configuration) during
>  >> last weeks.
> 
>  > The attached patch should help to get rid of clm-2100 and to avoid
>  > crash.
>  > Also, I think you should reiserfsck sda3.
> 
> Thanks for your answer. I tried the patch attached to your mail, but it 
> seems that it doesnt solve my problem :)
> The error also occured after i did a reiserfsck on sda3, I also tested 
> 2.6.13-rc4 with your patch applied, without success (the error also 
> occured on serveral servers having the same hardware configuration).
> 

Would you, please, try to reproduce the problem having reiserfs check mode on.
(it is File systems->Reiserfs support->Enable reiserfs debug mode in kernel configuration)
and with attached patch.

> Here are the error logs:
> 

Was there anything about reiserfs in the logs before this dump?

> ------------[ cut here ]------------
> kernel BUG at fs/reiserfs/prints.c:362!
> invalid operand: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c019ae2f>]    Not tainted VLI
> EFLAGS: 00010296   (2.6.13-rc4-endy)
> EIP is at reiserfs_panic+0x4f/0x80
> eax: 00000053   ebx: c02b8fde   ecx: 00000000   edx: c02dfdac
> esi: 00000000   edi: 00000140   ebp: e75b383c   esp: e75b3824
> ds: 007b   es: 007b   ss: 0068
> Process pure-ftpd (pid: 12771, threadinfo=e75b2000 task=f091d530)
> Stack: c02bd610 c02b8fde c03acdc0 00000fa0 c0971154 00000002 e75b3864 
> c01ac75f
>        00000000 c02bf89c 00000fa0 00000002 00020000 00000000 c097101c 
> 00000000
>        e75b38b8 c01939d3 c097101c 00000fd0 00000000 00000000 00000000 
> 00000000
> Call Trace:
>  [<c0102e5f>] show_stack+0x7f/0xa0
>  [<c0103002>] show_registers+0x152/0x1c0
>  [<c01031f8>] die+0xc8/0x140
>  [<c0103325>] do_trap+0xb5/0xc0
>  [<c010366c>] do_invalid_op+0xbc/0xd0
>  [<c0102aa3>] error_code+0x4f/0x54
>  [<c01ac75f>] direntry_check_left+0x8f/0x90
>  [<c01939d3>] get_num_ver+0x303/0x350
>  [<c01949ac>] ip_check_balance+0x3dc/0xbc0
>  [<c0195948>] check_balance+0x58/0x70
>  [<c019623b>] fix_nodes+0x15b/0x420
>  [<c01a2daf>] reiserfs_cut_from_item+0x10f/0x570

--------------010001050200040205070906
Content-Type: text/plain;
 name="reiserfs-panic-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reiserfs-panic-fix.patch"

 fs/reiserfs/prints.c |    3 ---
 1 files changed, 3 deletions(-)

diff -puN fs/reiserfs/prints.c~reiserfs-panic-fix fs/reiserfs/prints.c
--- linux-2.6.13-rc4-mm1/fs/reiserfs/prints.c~reiserfs-panic-fix	2005-08-05 13:36:09.947391212 +0400
+++ linux-2.6.13-rc4-mm1-vs/fs/reiserfs/prints.c	2005-08-05 13:36:23.346671407 +0400
@@ -359,9 +359,6 @@ void reiserfs_panic(struct super_block *
 	do_reiserfs_warning(fmt);
 	printk(KERN_EMERG "REISERFS: panic (device %s): %s\n",
 	       reiserfs_bdevname(sb), error_buf);
-	BUG();
-
-	/* this is not actually called, but makes reiserfs_panic() "noreturn" */
 	panic("REISERFS: panic (device %s): %s\n",
 	      reiserfs_bdevname(sb), error_buf);
 }

_

--------------010001050200040205070906--
