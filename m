Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271850AbTGRWqm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 18:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270378AbTGRWqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 18:46:42 -0400
Received: from 69-55-72-145.ppp.netsville.net ([69.55.72.145]:23529 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S271958AbTGRWpt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 18:45:49 -0400
Subject: Re: Linux 2.6.0-test1 Ext3 Ooops. Reboot needed.
From: Chris Mason <mason@suse.com>
To: Ricardo Galli <gallir@uib.es>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200307181228.40142.gallir@uib.es>
References: <200307181228.40142.gallir@uib.es>
Content-Type: text/plain
Organization: 
Message-Id: <1058569154.4016.587.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 18 Jul 2003 18:59:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-18 at 06:28, Ricardo Galli wrote:
> Hi again,
> 	I still see some oops that I think are ext3 related. The machine now is 
> almost hang, it works via ssh but the X/KDE environment just locks up, I had 
> to reboot it.
> 
> 
> Find below the three oops I found during last 24 hours.

I've seen similar oops with reiserfs, single user mode and a 70 proc
write/read/delete loop.  No idea at all yet on the cause.  I was
initially trying to blame akpm's change to keep the inode hashed until
after delete_inode was called (the oops was always during the delete
stage of run), but the logic looks right.

My oops all looked like this:

Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
c01805e7
*pde = 00000000
Oops: 0000 [#1]
CPU:    1
EIP:    0060:[<c01805e7>]    Not tainted
EFLAGS: 00010286
EIP is at find_inode+0x17/0x70
eax: 00000000   ebx: d9bd826c   ecx: 00000000   edx: eb5e992c
esi: f7d416e8   edi: f7f10134   ebp: e8f63d14   esp: e8f63d00
ds: 007b   es: 007b   ss: 0068
Process cp (pid: 1303, threadinfo=e8f62000 task=e66ba0c0)
Stack: f7d416e8 e8f63d54 f7d416e8 eb5e992c f7f10134 e8f63d40 c01807e4
f7d416e8
       f7f10134 c01d5270 e8f63d8c d4b301c8 1a62db00 00000000 f7d416e8
f7f10134
       e8f63d70 c0180f2e f7d416e8 f7f10134 c01d5270 c01d50f0 e8f63d8c
e8f63d74
Call Trace:
 [<c01807e4>] get_new_inode+0x54/0x1b0
 [<c01d5270>] reiserfs_find_actor+0x0/0x30
 [<c0180f2e>] iget5_locked+0xce/0x150
 [<c01d5270>] reiserfs_find_actor+0x0/0x30
 [<c01d50f0>] reiserfs_init_locked_inode+0x0/0x20
 [<c01d52e3>] reiserfs_iget+0x43/0xb0
 [<c01d5270>] reiserfs_find_actor+0x0/0x30
 [<c01d50f0>] reiserfs_init_locked_inode+0x0/0x20
 [<c01cf540>] reiserfs_lookup+0x200/0x2a0
 [<c017e6d9>] d_lookup+0x29/0x50
 [<c01729d9>] real_lookup+0xd9/0x100
 [<c0172cc6>] do_lookup+0x86/0xa0
 [<c0173215>] link_path_walk+0x535/0xa20
 [<c0173c4d>] __user_walk+0x3d/0x60
 [<c016e19b>] vfs_lstat+0x1b/0x60
 [<c017ce53>] dput+0x23/0x2c0
 [<c016e81b>] sys_lstat64+0x1b/0x40
 [<c016233b>] filp_close+0x4b/0x80
 [<c01623f6>] sys_close+0x86/0x100
 [<c010b3ef>] syscall_call+0x7/0xb

Code: 0f 18 00 90 39 b3 90 00 00 00 74 10 85 c0 89 c3 75 ec 31 c0


