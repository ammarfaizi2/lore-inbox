Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266692AbUG0XIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266692AbUG0XIO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 19:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266698AbUG0XIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 19:08:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:3798 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266692AbUG0XIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 19:08:07 -0400
Date: Tue, 27 Jul 2004 16:11:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: franz_pletz@t-online.de (Franz Pletz)
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [BUG] fs/jbd/checkpoint.c:427: "blocknr != 0"
Message-Id: <20040727161128.5939f8c0.akpm@osdl.org>
In-Reply-To: <41024AA1.5080401@t-online.de>
References: <41024AA1.5080401@t-online.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

franz_pletz@t-online.de (Franz Pletz) wrote:
>
> Hi!
> 
> I got the following error message after trying to mount my data-partition.
> 
> Assertion failure in cleanup_journal_tail() at fs/jbd/checkpoint.c:427: 
> "blocknr != 0"

That's new.

> ------------[ cut here ]------------
> kernel BUG at fs/jbd/checkpoint.c:427!
> invalid operand: 0000 [#1]
> PREEMPT SMP
> Modules linked in: ds yenta_socket pcmcia_core ide_cd cdrom usb_storage 
> scsi_mod psmouse evdev pcspkr adm1021 i2c_i801 i2c_sensor i2c_dev 
> i2c_core natsemi crc32
> CPU:    1
> EIP:    0060:[<c01a9df4>]    Not tainted VLI
> EFLAGS: 00010282   (2.6.8-rc1-mm1)
> EIP is at cleanup_journal_tail+0x12c/0x185
> eax: 0000005a   ebx: ddd3e000   ecx: c032b9bc   edx: c032b9bc
> esi: 00000000   edi: dfd09a00   ebp: 0004e110   esp: ddd3fda8
> ds: 007b   es: 007b   ss: 0068
> Process mount (pid: 8635, threadinfo=ddd3e000 task=df64e0b0)
> Stack: c02fdd80 c02ebf6f c02fcba4 000001ab c02fcbcb ddd3e000 dfd09a00 
> ddd3e000
>         00000000 c01acd79 dfd09a00 c011bda0 ddd3fdd8 ddd3fdd8 00003c70 
> dfd09a14
>         c03de41f dfd09a00 dfd07400 dfa39400 dfa39400 c019f39a dfd09a00 
> c02feca8
> Call Trace:
>   [<c01acd79>] journal_flush+0x101/0x385
>   [<c011bda0>] autoremove_wake_function+0x0/0x57
>   [<c019f39a>] ext3_mark_recovery_complete+0x33/0x81
>   [<c019e957>] ext3_fill_super+0x892/0xbcf
>   [<c016004e>] get_sb_bdev+0x120/0x153
>   [<c019f8e4>] ext3_get_sb+0x2f/0x33
>   [<c019e0c5>] ext3_fill_super+0x0/0xbcf
>   [<c0160273>] do_kern_mount+0x57/0xd3
>   [<c0177ab5>] do_new_mount+0x9c/0xe0
>   [<c0178205>] do_mount+0x145/0x194
>   [<c0178067>] copy_mount_options+0x63/0xbc
>   [<c01786a0>] sys_mount+0xd4/0x158
>   [<c01050fb>] syscall_call+0x7/0xb
> Code: 44 24 10 cb cb 2f c0 c7 44 24 0c ab 01 00 00 c7 44 24 08 a4 cb 2f 
> c0 c7 44 24 04 6f bf 2e c0 c7 04 24 80 dd 2f c0 e8 e3 4a f7 ff <0f> 0b 
> ab 01 a4 cb 2f c0 e9 3f ff ff ff e8 fd d7 13 00 e9 2d ff
>   <6>note: mount[8635] exited with preempt_count 2
> 
> I'm using 2.6.8-rc1-mm1 but experience the same problem with a 2.4 and 
> 2.6.7 kernel. Every other partition can be mounted without any problems.
> I ran fsck on the partition but no errors where found.
> 
> What can I do to rescue my data?
> I do have backups but some recent work will otherwise be lost. :-(

I assume you have a wrecked journal, which is triggering this assert:

	} else {
		first_tid = journal->j_transaction_sequence;
		blocknr = journal->j_head;
	}
	spin_unlock(&journal->j_list_lock);
	J_ASSERT(blocknr != 0);

	/* If the oldest pinned transaction is at the tail of the log
           already then there's not much we can do right now. */

e2fsck should have fixed this up when doing its journal replay.

You could probably get your data back by temporarily removing the journal:

	tune2fs -O ^has_journal /dev/hda1
	e2fsck -f /dev/hda1
	tune2fs -j /dev/hda1
	e2fsck -f /dev/hda1


