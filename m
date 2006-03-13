Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751540AbWCMTNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbWCMTNs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 14:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbWCMTNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 14:13:48 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:56045 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751540AbWCMTNr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 14:13:47 -0500
Subject: Re: [PATCH 004 of 4] Make address_space_operations->invalidatepage
	return void
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1142267531.9971.5.camel@kleikamp.austin.ibm.com>
References: <20060313104910.15881.patches@notabene>
	 <1060312235331.15985@suse.de>
	 <1142267531.9971.5.camel@kleikamp.austin.ibm.com>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 13:13:45 -0600
Message-Id: <1142277225.9949.3.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-13 at 10:32 -0600, Dave Kleikamp wrote:
> I'll try to stress test jfs with these patches to see if I can trigger
> the an oops here.

While stress testing on a jfs volume (dbench), I hit an assert in jbd:

Assertion failure in journal_invalidatepage() at fs/jbd/transaction.c:1920: "!page_has_buffers(page)"
------------[ cut here ]------------
kernel BUG at fs/jbd/transaction.c:1920!
invalid opcode: 0000 [#1]
PREEMPT 
last sysfs file: /block/hda/hda11/stat
Modules linked in: radeon irda crc_ccitt airo e1000 pcmcia yenta_socket rsrc_nonstatic pcmcia_core ntfs jfs rtc
CPU:    0
EIP:    0060:[<c01c2782>]    Not tainted VLI
EFLAGS: 00010282   (2.6.16-rc5-mm3-nb #1) 
EIP is at journal_invalidatepage+0xba/0xcb
eax: 00000069   ebx: db6e67f0   ecx: d5806dc8   edx: c0452aa3
esi: c1106620   edi: db6e67f0   ebp: db6e67f0   esp: d5806dc4
ds: 007b   es: 007b   ss: 0068
Process evolution (pid: 11320, threadinfo=d5806000 task=d5731570)
Stack: <0>c0452aa3 c041bc55 c0454d69 00000780 c04551ac 00001000 c1106620 00000000 
       c1106620 00000000 c01b4d10 df30b800 c1106620 00000000 c0141369 c1106620 
       00000000 00000001 c01414fb dbdca3e8 c1106620 00000000 ffffffff 00000000 
Call Trace:
 <c01b4d10> ext3_invalidatepage+0x2f/0x33   <c0141369> truncate_complete_page+0x1d/0x42
 <c01414fb> truncate_inode_pages_range+0xbe/0x27a   <c017977c> inotify_inode_is_dead+0x14/0x6e
 <c0413061> __mutex_lock_slowpath+0x25e/0x375   <c04130cd> __mutex_lock_slowpath+0x2ca/0x375
 <c017977c> inotify_inode_is_dead+0x14/0x6e   <c01b34d2> ext3_delete_inode+0x0/0xc9
 <c01416cc> truncate_inode_pages+0x15/0x19   <c01b34e8> ext3_delete_inode+0x16/0xc9
 <c01b34d2> ext3_delete_inode+0x0/0xc9   <c016cd2d> generic_delete_inode+0x89/0x10e
 <c016a193> dput+0x19e/0x1b7   <c0164a28> do_rename+0x135/0x16c
 <c0144d2a> unmap_vmas+0xc7/0x19e   <c014452b> free_pgtables+0x5b/0x65
 <c024c19b> strncpy_from_user+0x35/0x55   <c016147a> do_getname+0x3e/0x5c
 <c0164a9a> sys_renameat+0x3b/0x60   <c0164ad0> sys_rename+0x11/0x15
 <c0102c3b> syscall_call+0x7/0xb  
Code: e8 d7 6c f9 ff 58 8b 06 f6 c4 08 74 29 68 ac 51 45 c0 68 80 07 00 00 68 69 4d 45 c0 68 55 bc 41 c0 68 a3 2a 45 c0 e8 6a 83 f5 ff <0f> 0b 80 07 69 4d 45 c0 83 c4 14 58 5b 5e 5f 5d c3 55 31 ed 57 
 BUG: evolution/11320, lock held at task exit time!
 [dae25194] {inode_init_once}
.. held by:         evolution:11320 [d5731570, 115]
... acquired at:               lock_rename+0x8e/0x94

-- 
David Kleikamp
IBM Linux Technology Center

