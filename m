Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266688AbUFWVo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266688AbUFWVo7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 17:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266732AbUFWVml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:42:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:5048 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266720AbUFWVly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:41:54 -0400
Date: Wed, 23 Jun 2004 14:41:50 -0700
From: Chris Wright <chrisw@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make POSIX locks compatible with the NPTL thread model
Message-ID: <20040623144150.H21045@build.pdx.osdl.net>
References: <1088010468.5806.52.camel@lade.trondhjem.org> <20040623122930.K22989@build.pdx.osdl.net> <1088020210.5806.95.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <1088020210.5806.95.camel@lade.trondhjem.org>; from trond.myklebust@fys.uio.no on Wed, Jun 23, 2004 at 03:50:10PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Trond Myklebust (trond.myklebust@fys.uio.no) wrote:
> På on , 23/06/2004 klokka 15:29, skreiv Chris Wright:
> > Just ran some quick tests to verify this patch still works fine with
> > execve() after plain CLONE_FILES as well as full CLONE_THREAD.  Passed
> > my tests.  Nice to see the steal_locks bit go.  However, without this
> > patch (only the prior one, I'm getting an oops).
> 
> Can you show us the Oops? I'm surprised that should be occurring...

Yes, it's a BUG in locks_remove_flock.  The first patch changes
locks_remove_posix, so posix lock is missed on filp_close and the BUG
is hit.  I believe the problem is that locks can have same fl_owner,
w/out having same tgid.

kernel BUG at fs/locks.c:1729!
invalid operand: 0000 [#1]
PREEMPT SMP
Modules linked in:
CPU:    0
EIP:    0060:[<c017b890>]    Not tainted
EFLAGS: 00010246   (2.6.7)
EIP is at locks_remove_flock+0xf1/0x131
eax: d5c67224   ebx: d555cae8   ecx: d5194190   edx: 00000000
esi: d555ca40   edi: d520e45c   ebp: d5346efc   esp: d5346ee8
ds: 007b   es: 007b   ss: 0068
Process lock_clone_exec (pid: 1864, threadinfo=d5346000 task=d5194190)
Stack: 7fffffff 00000000 d520e45c 00000000 d7e438b4 d5346f20 c01635a8 d520e45c
       00000000 d555ca40 d51c2544 d520e45c 00000000 d5866750 d5346f3c c0161c38
       d520e45c d5866750 00000001 00000003 00000009 d5346f64 c012058f d520e45c
Call Trace:
 [<c010529f>] show_stack+0x80/0x96
 [<c0105436>] show_registers+0x15f/0x1ae
 [<c01055d3>] die+0xb5/0x17a
 [<c01059e9>] do_invalid_op+0xb5/0xb7
 [<c0104f45>] error_code+0x2d/0x38
 [<c01635a8>] __fput+0x34/0x142
 [<c0161c38>] filp_close+0x57/0x81
 [<c012058f>] put_files_struct+0x8c/0xff
 [<c012152c>] do_exit+0x1fb/0x63a
 [<c0121a2d>] do_group_exit+0x3d/0x177
 [<c0104469>] sysenter_past_esp+0x52/0x71
Code: 0f 0b c1 06 04 7c 57 c0 e9 68 ff ff ff c7 44 24 04 02 00 00

> Note that with both patches, we still have some problems in the locking
> downcall interface to the filesystem. Currently there exists an
> atomicity problem: after the call to ->lock() there is a window during
> which the filesystem believes that a lock may have been taken/released
> but the VFS has not yet registered this fact. In 2.4.x, this window did
> not exist because the VFS held the BKL from beginning to end.
> 
> As far as NFS is concerned, this makes use of the VFS in order to
> recover from server reboots (which is in fact the only reason why we
> bother to have the VFS track the locking) buggy...
> 
> IMHO, NFS/CIFS/... should just call posix_lock_file() directly from
> their ->lock() method. That way they will also be able to full take
> responsibility for protecting the call.
> 
> Cheers,
>   Trond

-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
