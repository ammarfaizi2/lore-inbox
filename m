Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbUKEKsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbUKEKsh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 05:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbUKEKsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 05:48:37 -0500
Received: from colin2.muc.de ([193.149.48.15]:20484 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261586AbUKEKsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 05:48:33 -0500
Date: 5 Nov 2004 11:48:32 +0100
Date: Fri, 5 Nov 2004 11:48:32 +0100
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Lorenzo Allegrucci <l_allegrucci@yahoo.it>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm3
Message-ID: <20041105104832.GA93999@muc.de>
References: <20041105001328.3ba97e08.akpm@osdl.org> <200411051041.17940.l_allegrucci@yahoo.it> <20041105021758.09d582bf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105021758.09d582bf.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 02:17:58AM -0800, Andrew Morton wrote:
> Lorenzo Allegrucci <l_allegrucci@yahoo.it> wrote:
> >
> > On Friday 05 November 2004 09:13, Andrew Morton wrote:
> >  > 
> >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm3/
> > 
> >  ------------[ cut here ]------------
> >  kernel BUG at mm/memory.c:156!
> >  invalid operand: 0000 [#1]
> >  PREEMPT 
> >  Modules linked in: ipv6 tun dm_mod emu10k1 sound soundcore ac97_codec unix
> >  CPU:    0
> >  EIP:    0060:[clear_page_range+276/304]    Not tainted VLI
> >  EFLAGS: 00010206   (2.6.10-rc1-mm3) 
> >  EIP is at clear_page_range+0x114/0x130
> >  eax: daffc000   ebx: 00483fff   ecx: c03b7088   edx: daffc000
> >  esi: 00000000   edi: 00080000   ebp: dca51ed0   esp: dca51ea8
> >  ds: 007b   es: 007b   ss: 0068
> >  Process shmt04 (pid: 4854, threadinfo=dca51000 task=de374510)
> 
> hm, I thought I ran ltp.  Andi, this is due to the 4level patches.  I can
> reproduce it with non-PAE x86.  But testing was interrupted by the apparent
> suicide of an IDE disk :(

Ok, I think that was a BUG_ON I added later to check for something.
I think problem is that last is off by one at this point. That is ok.
I think it's safe to just remove it.

I will do a non PAE i386 LTP run with this now.  Lorenzo can you
check it solves the problem for you?

-Andi

Remove bogus BUG_ON.

Signed-off-by: Andi Kleen <ak@muc.de>


diff -u linux-2.6.10rc1-mm3/mm/memory.c-o linux-2.6.10rc1-mm3/mm/memory.c
--- linux-2.6.10rc1-mm3/mm/memory.c-o	2004-11-05 11:42:00.000000000 +0100
+++ linux-2.6.10rc1-mm3/mm/memory.c	2004-11-05 11:45:37.000000000 +0100
@@ -153,7 +153,6 @@
 		return;
 	}
 	BUG_ON(addr & ~PGDIR_MASK);
-	BUG_ON(end & ~PGDIR_MASK);
 	pgd_start = pml4_pgd_offset(pml4, addr);
 	free = 0;
 	pgd = pgd_start;


