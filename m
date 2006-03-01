Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWCAQqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWCAQqI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 11:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbWCAQqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 11:46:08 -0500
Received: from lixom.net ([66.141.50.11]:45190 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1751622AbWCAQqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 11:46:07 -0500
Date: Wed, 1 Mar 2006 10:45:31 -0600
To: Martin Bligh <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, paulus@samba.org
Subject: [PATCH] Fix powerpc bad_page_fault output  (Re: 2.6.16-rc5-mm1)
Message-ID: <20060301164531.GA17755@pb15.lixom.net>
References: <20060228042439.43e6ef41.akpm@osdl.org> <4404E328.7070807@mbligh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4404E328.7070807@mbligh.org>
User-Agent: Mutt/1.5.11
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 03:56:24PM -0800, Martin Bligh wrote:
> Andrew Morton wrote:
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm1/
> 
> New panic on IBM power4 lpar of P690. 2.6.16-rc5-git3 is OK.
> 
> (config: 
> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/power4)
> 
> http://test.kernel.org/24165/debug/console.log

For what it's worth, this is a NULL pointer dereference in the RCU
code.

Seems that the human-readible parts are printed at a differnet printk level
(well, _at_ a level), so they fell off. Not good.

Andrew and/or Paulus, see patch below.


Thanks,

Olof


---

It seems that the die() output is printk'd without any prink level,
so some distros will log the register dumps and the human readible
format differently.

(I.e. see http://test.kernel.org/24165/debug/console.log, which lacks
the KERN_ALERT parts)

Changing the die() output to include a level will likely confuse users
that currently rely on getting the output where they're getting it,
so instead remove it from the bad_page_fault() output.

Signed-off-by: Olof Johansson <olof@lixom.net>


diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index ec4adcb..fee050a 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -389,7 +389,7 @@ void bad_page_fault(struct pt_regs *regs
 
 	/* kernel has accessed a bad area */
 
-	printk(KERN_ALERT "Unable to handle kernel paging request for ");
+	printk("Unable to handle kernel paging request for ");
 	switch (regs->trap) {
 		case 0x300:
 		case 0x380:
@@ -402,8 +402,7 @@ void bad_page_fault(struct pt_regs *regs
 		default:
 			printk("unknown fault\n");
 	}
-	printk(KERN_ALERT "Faulting instruction address: 0x%08lx\n",
-		regs->nip);
+	printk("Faulting instruction address: 0x%08lx\n", regs->nip);
 
 	die("Kernel access of bad area", regs, sig);
 }
