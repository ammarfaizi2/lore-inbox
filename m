Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262843AbUKXUj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262843AbUKXUj7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 15:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbUKXUjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 15:39:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:52623 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262850AbUKXUie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 15:38:34 -0500
Date: Wed, 24 Nov 2004 12:38:32 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Zou, Nanhai" <nanhai.zou@intel.com>
Cc: Hugh Dickins <hugh@veritas.com>, Chris Wright <chrisw@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       "Luck, Tony" <tony.luck@intel.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH 1/2] setup_arg_pages can insert overlapping vma
Message-ID: <20041124123829.U2357@build.pdx.osdl.net>
References: <894E37DECA393E4D9374E0ACBBE7427013C9AB@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <894E37DECA393E4D9374E0ACBBE7427013C9AB@pdsmsx402.ccr.corp.intel.com>; from nanhai.zou@intel.com on Wed, Nov 24, 2004 at 09:04:28AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zou, Nanhai (nanhai.zou@intel.com) wrote:
>  <<ia64-vm-overlap.tar.gz>>  <<vma-overlap-fix.patch>> I think ia64 ia32
> subsystem is not vulnerable to this kind of overlapping vm problem,
> because it does not support a.out binary format, 

I am able to map a section over the arg pages, and for some reason this
case segfaults (in the application).  Disassembly shows garbage left
behind in that page.  AFAICT, this can only cause the app to segfault in
userspace.

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

Yes, I was able to reproduce a similar bug last night on ia64 by placing
a 1k section at 0x1000, and this patch indeed fixes it up.

> I don't know what about s390. However, I think it's safe to check
> overlap before we actually insert a vma into vma list.
>  
> And I also feel check vma overlap everywhere is unnecessary, because
> invert_vm_struct will check it again, so the check is duplicated. It's
> better to have invert_vm_struct return a value then let caller check if
> it successes.

Yes I agree.  That's the question I asked early on.  With no answer I
took defensive route to be sure the BUG() wasn't there for some valid
reason I was missing.  This looks better.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
