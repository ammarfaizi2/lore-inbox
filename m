Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267773AbTBGJxp>; Fri, 7 Feb 2003 04:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267775AbTBGJxp>; Fri, 7 Feb 2003 04:53:45 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15884 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267773AbTBGJxn>; Fri, 7 Feb 2003 04:53:43 -0500
Date: Fri, 7 Feb 2003 10:03:19 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Restore module support.
Message-ID: <20030207100319.A23442@flint.arm.linux.org.uk>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Roman Zippel <zippel@linux-m68k.org>,
	Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	linux-kernel@vger.kernel.org
References: <20030207001006.A19306@flint.arm.linux.org.uk> <20030207045419.9A11B2C0F8@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030207045419.9A11B2C0F8@lists.samba.org>; from rusty@rustcorp.com.au on Fri, Feb 07, 2003 at 03:53:44PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2003 at 03:53:44PM +1100, Rusty Russell wrote:
> Yes.  PPC and PPC64 have the same issues: currently this is done by
> (1) putting nothing in the .init sections (on PPC64), and (2) with
> stubs when jumping outside the module code.
> 
> This gives the same effect as the previous userspace loader: for PPC64
> noone cares about discarding init stuff, so it's firmly on the TODO
> list.  ARM's priorities are obviously different.

As I say, I have this solution working, but its suboptimal, and I'll
probably push this Linus-wards if I can't resolve (2) soon.

> > 2. fix vmalloc and /proc/kcore to be able to cope with a separate module
> >    region located below PAGE_OFFSET.  Currently, neither play well with
> >    this option.
> 
> x86_64 has this, as does sparc64: they do their own allocation.  Does
> ARM require something special in this regard?  I'd love to see what
> you've got...

There are two problems - one I mentioned during on LKML recently:

  Message-ID: <20030131102013.A19646@flint.arm.linux.org.uk>

This seems simple to resolve.  We just need to make get_vm_area() ignore
mappings for invalid areas:

--- orig/mm/vmalloc.c	Tue Nov  5 12:51:41 2002
+++ linux/mm/vmalloc.c	Fri Feb  7 09:48:42 2003
@@ -210,6 +210,8 @@
 
 	write_lock(&vmlist_lock);
 	for (p = &vmlist; (tmp = *p) ;p = &tmp->next) {
+		if (tmp->addr < addr)
+			continue;
 		if ((size + addr) < addr)
 			goto out;
 		if (size + addr <= (unsigned long)tmp->addr)

Since the vmlist is an ordered list, and we place the modules below
VMALLOC_START, this change ensures that we will completely ignore any
vmlist entries below the current minimum address (addr) we're looking
for.

/proc/kcore currently assumes that:

1. all vmlist mappings are above PAGE_OFFSET.
2. all vmlist mappings are within VMALLOC_START to VMALLOC_END

Looking at fs/proc/kcore.c this morning, I have a couple of ideas to
solve this problem.  Patch will follow later today, hopefully without
any ifdefs.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

