Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbVITLTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbVITLTK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 07:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbVITLTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 07:19:10 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54033 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964977AbVITLTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 07:19:09 -0400
Date: Tue, 20 Sep 2005 12:18:51 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 zaurus: pcmcia now works
Message-ID: <20050920111851.GA26353@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>, rpurdie@rpsys.net,
	lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>
References: <20050920100823.GA16186@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050920100823.GA16186@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 12:08:23PM +0200, Pavel Machek wrote:
> FYI, my hacks now look like (attached). I'll push changes to linux-z
> in few hours.

Some questions:

@@ -57,8 +57,6 @@ void dump_backtrace_entry(unsigned long
 #ifdef CONFIG_KALLSYMS
        printk("[<%08lx>] ", where);
        print_symbol("(%s) ", where);
-       printk("from [<%08lx>] ", from);
-       print_symbol("(%s)\n", from);

The "from" address provides good hints about the exact path we got to
the called function.  You don't really want to get rid of that because
it makes following backtraces harder.  I'm not sure why you've made
the other changes in that file either.

+/* those must never be empty
+   unfortunately they cause problems with older binutils
 ASSERT((__proc_info_end - __proc_info_begin), "missing CPU support")
 ASSERT((__arch_info_end - __arch_info_begin), "no machine record defined")
+*/

Get a better binutils. 8)

diff --git a/drivers/mfd/mcp-core.c b/drivers/mfd/mcp-core.c
--- a/drivers/mfd/mcp-core.c
+++ b/drivers/mfd/mcp-core.c
@@ -19,6 +19,7 @@
 #include <asm/dma.h>
 #include <asm/system.h>

+#include <asm/arch/mcp.h>
 #include "mcp.h"

 #define to_mcp(d)              container_of(d, struct mcp, attached_device)

This looks bogus - why is this needed?

@@ -186,7 +192,12 @@ static int mcp_sa11x0_probe(struct devic
         */
        Ser4MCSR = -1;
        Ser4MCCR1 = data->mccr1;
-       Ser4MCCR0 = data->mccr0 | 0x7f7f;
+#if 1
+       if (machine_is_collie())
+               Ser4MCCR0 = MCCR0_ADM | MCCR0_ExtClk;
+       else
+#endif
+               Ser4MCCR0 = data->mccr0 | 0x7f7f;

Ditto.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
