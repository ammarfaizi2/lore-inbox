Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbVIQLvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbVIQLvs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 07:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbVIQLvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 07:51:48 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27660 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751080AbVIQLvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 07:51:48 -0400
Date: Sat, 17 Sep 2005 12:51:38 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: trem <trem@zarb.org>, Andrew Morton <akpm@osdl.org>,
       Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dependance loop on 2.6.14-rc1-mm1
Message-ID: <20050917115138.GA17589@flint.arm.linux.org.uk>
Mail-Followup-To: trem <trem@zarb.org>, Andrew Morton <akpm@osdl.org>,
	Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org
References: <432C00C6.20305@zarb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432C00C6.20305@zarb.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2005 at 01:40:54PM +0200, trem wrote:
> I've tried to compile a 2.6.14-rc1-mm1 on my amd64. When I do the make 
> modules_install,
> I have this warning:
> 
> WARNING: Loop detected:
> /lib/modules/2.6.14-rc1-mm1/kernel/drivers/serial/8250.ko needs 
> serial_core.ko which needs 8250.ko again!

This looks suspicious.  8250 should need serial_core, but there's no
way in hell serial_core should require 8250. 

Seems to be caused by the kgdb patches, which add the following to
serial_core:

+#ifdef CONFIG_KGDB
+       {
+               extern int kgdb_irq;
+
+               if (port->irq == kgdb_irq)
+                       return;
+       }
+#endif
+

and kgdb_irq comes from the 8250 module.

Tom, can this dependency be solved before kgdb goes near mainline
please?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
