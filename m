Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316582AbSFUMny>; Fri, 21 Jun 2002 08:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316580AbSFUMnx>; Fri, 21 Jun 2002 08:43:53 -0400
Received: from ns.suse.de ([213.95.15.193]:5896 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316582AbSFUMnw>;
	Fri, 21 Jun 2002 08:43:52 -0400
Date: Fri, 21 Jun 2002 14:43:41 +0200
From: Andi Kleen <ak@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: 2.5.23+ bootflag.c triggers __iounmap: bad address
Message-ID: <20020621144341.A15371@wotan.suse.de>
References: <200206211156.NAA13885@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200206211156.NAA13885@harpo.it.uu.se>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2002 at 01:56:55PM +0200, Mikael Pettersson wrote:
> When booting 2.5.23/.24, my test boxes generate the following:
> 
> (an ASUS P4T-E which has SBF)
> __iounmap: bad address d0802100
> SBF: Simple Boot Flag extension found and enabled.
> __iounmap: bad address d0805040
> __iounmap: bad address d0808080
> SBF: Setting boot flags 0x1
> 
> (an old Intel AL440LX which doesn't have SBF)
> __iounmap: bad address c4800009
> __iounmap: bad address c4804b8c
> __iounmap: bad address c4802009
> 
> These warnings/errors are new since 2.5.23, which makes me
> suspect something's wrong in the 2.5.23 iounmap changes.

Does this patch fix it?


-Andi



--- linux-2.5.23-work/arch/i386/mm/ioremap.c.~2~	Tue Jun 18 02:13:09 2002
+++ linux-2.5.23-work/arch/i386/mm/ioremap.c	Fri Jun 21 14:42:23 2002
@@ -213,9 +213,9 @@
 void iounmap(void *addr)
 { 
 	struct vm_struct *p;
-	if (addr < high_memory) 
+	if (addr <= high_memory) 
 		return; 
-	p = remove_kernel_area(addr); 
+	p = remove_kernel_area(PAGE_MASK & (unsigned long) addr); 
 	if (!p) { 
 		printk("__iounmap: bad address %p\n", addr);
 		return;
