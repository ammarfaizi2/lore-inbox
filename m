Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263340AbUFCLkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbUFCLkp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 07:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263932AbUFCLko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 07:40:44 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:58121 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S263340AbUFCLkm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 07:40:42 -0400
Date: Thu, 3 Jun 2004 21:40:29 +1000
To: David Coe <davidc@debian.org>, 252391@bugs.debian.org
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug#252391: kernel-source-2.6.6: Assertion failure in journal_flush() ... "!journal->j_running_transaction"
Message-ID: <20040603114029.GA7912@gondor.apana.org.au>
References: <20040603034037.70176BA0E0@zona.someotherplace.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040603034037.70176BA0E0@zona.someotherplace.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 11:40:37PM -0400, David Coe wrote:
> Package: kernel-source-2.6.6
> Version: 2.6.6-1
> Severity: normal
> 
> I've been using a locally-compiled kernel from this source since May
> 17, without problems; tonight when I tried to "mount -o remount,ro
> /usr" I got the following failure, after which I was unable to sync or
> kill any processes -- a hard reboot "fixed" it, ext3 recovered cleanly.

... 

> A search of the ext3-users mailing list turned up a previous
> discussion of a similar problem, which was apparently left
> unresolved (or at least that thread ended inconclusively) -- see
>   https://www.redhat.com/archives/ext3-users/2003-May/msg00093.html
> which suggests where the problem is.  I see that
> ext3_mark_recovery_complete() still doesn't call
> journal_lock_updates(), as that thread suggests it should.  I haven't
> researched further yet.

Yes that code does look racy.

Andrew, what's stopping a journal_start() from setting j_running_transaction
just before the last spin_lock(&journal->j_state_lock) that guards the
J_ASSERT that was hit below?
 
> Jun  2 21:33:15 zona kernel: Assertion failure in journal_flush() at fs/jbd/journal.c:1309: "!journal->j_running_transaction"
> Jun  2 21:33:15 zona kernel: ------------[ cut here ]------------
> Jun  2 21:33:15 zona kernel: kernel BUG at fs/jbd/journal.c:1309!
> Jun  2 21:33:15 zona kernel: invalid operand: 0000 [#1]
> Jun  2 21:33:15 zona kernel: SMP 
> Jun  2 21:33:15 zona kernel: CPU:    1
> Jun  2 21:33:15 zona kernel: EIP:    0060:[journal_flush+228/460]    Not tainted
> Jun  2 21:33:15 zona kernel: EFLAGS: 00010216   (2.6.6zona-06009se) 
> Jun  2 21:33:15 zona kernel: EIP is at journal_flush+0xe4/0x1cc
> Jun  2 21:33:15 zona kernel: eax: 00000064   ebx: 000016e3   ecx: 00000000   edx: c03548ac
> Jun  2 21:33:15 zona kernel: esi: e716ba00   edi: 00000000   ebp: ce5d3f6c   esp: ce5d3ebc
> Jun  2 21:33:15 zona kernel: ds: 007b   es: 007b   ss: 0068
> Jun  2 21:33:15 zona kernel: Process mount (pid: 5202, threadinfo=ce5d2000 task=e13f4390)
> Jun  2 21:33:15 zona kernel: Stack: c02f45c0 c02f4c80 c02f44b5 0000051d c02f4c60 e716be00 e6e0b400 e716be00 
> Jun  2 21:33:15 zona kernel:        c018161b e716ba00 e716bc00 c01818ea e716be00 e6e0b400 e716be00 e716be50 
> Jun  2 21:33:15 zona kernel:        ce5d3f6c c0147c1b c014c784 e716be00 ce5d3f24 c8412000 e716be00 e716be40 
> Jun  2 21:33:15 zona kernel: Call Trace:
> Jun  2 21:33:15 zona kernel:  [ext3_mark_recovery_complete+23/76] ext3_mark_recovery_complete+0x17/0x4c
> Jun  2 21:33:15 zona kernel:  [ext3_remount+198/296] ext3_remount+0xc6/0x128
> Jun  2 21:33:15 zona kernel:  [fs_may_remount_ro+51/114] fs_may_remount_ro+0x33/0x72
> Jun  2 21:33:15 zona kernel:  [do_remount_sb+152/200] do_remount_sb+0x98/0xc8
> Jun  2 21:33:15 zona kernel:  [do_remount+112/188] do_remount+0x70/0xbc
> Jun  2 21:33:15 zona kernel:  [do_mount+293/392] do_mount+0x125/0x188
> Jun  2 21:33:15 zona kernel:  [copy_mount_options+85/164] copy_mount_options+0x55/0xa4
> Jun  2 21:33:15 zona kernel:  [sys_mount+189/320] sys_mount+0xbd/0x140
> Jun  2 21:33:15 zona kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
> Jun  2 21:33:15 zona kernel: 
> Jun  2 21:33:15 zona kernel: Code: 0f 0b 1d 05 b5 44 2f c0 83 c4 14 83 7e 34 00 74 29 68 a0 4c 
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
