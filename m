Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965101AbVINJOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbVINJOZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 05:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965102AbVINJOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 05:14:25 -0400
Received: from gold.veritas.com ([143.127.12.110]:23423 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S965101AbVINJOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 05:14:24 -0400
Date: Wed, 14 Sep 2005 10:14:08 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Kirill Korotaev <dev@sw.ru>
cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, xemul@sw.ru
Subject: Re: [PATCH] error path in setup_arg_pages() misses vm_unacct_memory()
In-Reply-To: <4327E24E.8040200@sw.ru>
Message-ID: <Pine.LNX.4.61.0509141006480.5965@goblin.wat.veritas.com>
References: <4325B188.10404@sw.ru> <20050912132352.6d3a0e3a.akpm@osdl.org>
 <Pine.LNX.4.61.0509131217200.7040@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0509140605320.3433@goblin.wat.veritas.com> <4327E24E.8040200@sw.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 14 Sep 2005 09:14:24.0134 (UTC) FILETIME=[B2DA8A60:01C5B90C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2005, Kirill Korotaev wrote:
> 
> is vma accounting in arch/x86_64/ia32/syscall32.c and arch/ppc64/kernel/vdso.c
> removed due to fixed size of vma (vsyscall/vdso mappings)?
> in other respects it looks ok.

It's removed because without VM_ACCOUNT it was steadily leaking:
the main path was wrong, never mind the error path.  We could add
VM_ACCOUNT to the flags to fix that, but in 99.999% of cases we
should not be accounting these - all mms are sharing the same page.

Ben designed it to allow for gdb setting breakpoints in the vDSO
page (COW then giving a private page), but that's an very unusual
case, which isn't handled quite right anyway: we need to take a
separate look at that sometime - we account for what's VM_WRITE,
not for what ptrace might write to by the backdoor.

> > So x86_64 32-bit and ppc64 vDSO ELFs have been leaking memory into
> > Committed_AS each time they're run.  But don't add VM_ACCOUNT to them,
> > it's inappropriate to reserve against the very unlikely case that gdb
> > be used to COW a vDSO page - we ought to do something about that in
> > do_wp_page, but there are yet other inconsistencies to be resolved.

Hugh
