Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbUKCPSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbUKCPSd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 10:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbUKCPSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 10:18:33 -0500
Received: from natnoddy.rzone.de ([81.169.145.166]:48119 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S261627AbUKCPS2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 10:18:28 -0500
Date: Wed, 3 Nov 2004 16:17:44 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: jgilbert@biomail.ucsd.edu, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: oops in 2.6.10-rc1-mm2 module_refcount
Message-ID: <20041103151744.GA12672@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	jgilbert@biomail.ucsd.edu, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20041103070419.GA8322@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103070419.GA8322@dominikbrodowski.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unable to handle kernel NULL pointer dereference at virtual address 000000a0
> printing eip:
> c0146807
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT 
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c0146807>]    Not tainted VLI
> EFLAGS: 00010282   (2.6.10-rc1-mm2-pleiades) 
> EIP is at module_refcount+0x7/0x10

module_refcount() on non-modules fails [in contrary to try_module_get()],
causing this bug when accessing /proc/bus/pccard/drivers and a pcmcia driver
is built into the kernel.

Applies on top of 
- pcmcia-17-device-model-integration.patch
- pcmcia-18a-client_t-and-pcmcia_device-integration.patch
- pcmcia-18b-error-on-leftover-devices.patch
- pcmcia-19-netdevice-integration.patch

Signed-off-by: Dominik Brodowski <linux@brodo.de>

--- linux/drivers/pcmcia/ds.c.original	2004-11-03 16:03:16.836857136 +0100
+++ linux/drivers/pcmcia/ds.c	2004-11-03 16:09:52.792662704 +0100
@@ -313,7 +313,7 @@
 
 	*p += sprintf(*p, "%-24.24s 1 %d\n", p_drv->drv.name, 
 #ifdef CONFIG_MODULE_UNLOAD
-		      module_refcount(p_drv->owner)
+		     (p_drv->owner) ? module_refcount(p_drv->owner) : 1
 #else
 		      1
 #endif
