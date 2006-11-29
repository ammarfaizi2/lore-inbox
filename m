Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935514AbWK2Mls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935514AbWK2Mls (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 07:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935540AbWK2Mls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 07:41:48 -0500
Received: from jdi.jdi-ict.nl ([82.94.239.5]:44252 "EHLO jdi.jdi-ict.nl")
	by vger.kernel.org with ESMTP id S935514AbWK2Mlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 07:41:47 -0500
Date: Wed, 29 Nov 2006 13:41:37 +0100 (CET)
From: Igmar Palsenberg <i.palsenberg@jdi-ict.nl>
X-X-Sender: igmar@jdi.jdi-ict.nl
To: linux-kernel@vger.kernel.org
cc: erich@areca.com.tw
Subject: 2.6.16.32 stuck in generic_file_aio_write()
Message-ID: <Pine.LNX.4.58.0611291329060.18799@jdi.jdi-ict.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.1.12 (jdi.jdi-ict.nl [127.0.0.1]); Wed, 29 Nov 2006 13:41:38 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I've got a machine which occasionally locks up. I can still sysrq it from 
a serial console, so it's not entirely dead.

A sysrq-t learns me that it's got a large number of httpd processes stuck 
in D state :

httpd         D F7619440  2160 11635   2057         11636       (NOTLB)
dbb7ae14 cc9b0550 c33224a0 f7619440 de187604 00000000 000000b3 00000001
       000000b3 00000000 ffffffff d374a550 c33224a0 0005b8d8 f04af800 
000f75e7
       d374a550 cc9b0550 cc9b0678 ef7d33ec ef7d33e8 cc9b0550 ef7d33fc 
c041bf70
Call Trace:
 [<c041bf70>] __mutex_lock_slowpath+0x92/0x43e
 [<c0148f29>] generic_file_aio_write+0x5c/0xfa
 [<c0148f29>] generic_file_aio_write+0x5c/0xfa
 [<c0148f29>] generic_file_aio_write+0x5c/0xfa
 [<c01746c9>] permission+0xad/0xcb
 [<c01d9c4a>] ext3_file_write+0x3b/0xb0
 [<c0166777>] do_sync_write+0xd5/0x130
 [<c041d1bf>] _spin_unlock+0xb/0xf
 [<c0135c13>] autoremove_wake_function+0x0/0x4b
 [<c0166975>] vfs_write+0x1a3/0x1a8
 [<c0166a39>] sys_write+0x4b/0x74
 [<c0102c03>] sysenter_past_esp+0x54/0x75

After this, the machine is rendered useless (probably due to the fact that 
disk IO isn't working anymore).

The lock debugging gives me this :

D           httpd:11635 [cc9b0550, 116] blocked on mutex: [ef7d33e8] 
{inode_init_once}
.. held by:             httpd:  506 [d67e1000, 121]
... acquired at:               generic_file_aio_write+0x5c/0xfa 


I see similiar things as mentioned in http://lkml.org/lkml/2006/1/10/64, 
with the difference that I'm not running software RAID or SATA (it's an 
Areca ARC-1110).

I can't reproduce it until now, it 'just' happens. Can someone give me a 
pointer where to start looking ?

Erich, I've CC-ed you since the machine is running an Areca RAID config. 
It's also the only used disk subsystem in this machine.


Regards,


	Igmar

