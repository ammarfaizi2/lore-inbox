Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262719AbUKXQfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbUKXQfP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 11:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbUKXQds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 11:33:48 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:63592 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262674AbUKXQbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 11:31:22 -0500
Date: Wed, 24 Nov 2004 16:30:59 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Zou, Nanhai" <nanhai.zou@intel.com>
cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, "Luck, Tony" <tony.luck@intel.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, Andi Kleen <ak@suse.de>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: RE: [PATCH 1/2] setup_arg_pages can insert overlapping vma
In-Reply-To: <894E37DECA393E4D9374E0ACBBE7427013C9AB@pdsmsx402.ccr.corp.intel.com>
Message-ID: <Pine.LNX.4.44.0411241558300.5064-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot for taking this further.

On Wed, 24 Nov 2004, Zou, Nanhai wrote:
> I think ia64 ia32
> subsystem is not vulnerable to this kind of overlapping vm problem,
> because it does not support a.out binary format, 
> X84_64 is vulnerable to this. 
> 
> just do a 
> perl -e'print"\x07\x01".("\x00"x10)."\x00\xe0\xff\xff".("\x00"x16)'>
> evilaout
> you will get it.
>  
> and IA64 is also vulnerable to this kind of bug in 64 bit elf support,
> it just insert a vma of zero page without checking overlap, so user can
> construct a elf with section begin from 0x0 to trigger this BUGON().I
> attach a testcase to trigger this bug
> I don't know what about s390. However, I think it's safe to check
> overlap before we actually insert a vma into vma list.

I expect you're right: I have neither machines nor expertise to say.

> And I also feel check vma overlap everywhere is unnecessary, because
> invert_vm_struct will check it again, so the check is duplicated. It's
> better to have invert_vm_struct return a value then let caller check if
> it successes.
> Here is a patch against 2.6.10.rc2-mm3
> I have tested it on i386, x86_64 and ia64 machines.

Yes, I agree, that's a welcome improvement.  I'm surprised if all
those ia64_elf32_init checks are necessary, but better safe than sorry.

Something crosses my mind, you'll know better than I: is it possible to
construct ELFs or A.OUTs which would need the check in insert_vm_struct
to be even more defensive?  That is, should it also be checking that
vma->vm_end > vma->vm_start (vma being the one to be inserted)?
Or that vma->vm_end <= TASK_SIZE?  If I remember rightly, a 0-length
vma can cause confusion but survive quite well until exit_mmap's
BUG_ON(mm->map_count).

Hugh

