Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267662AbTAQUjH>; Fri, 17 Jan 2003 15:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267663AbTAQUjH>; Fri, 17 Jan 2003 15:39:07 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:2801 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S267662AbTAQUjG>; Fri, 17 Jan 2003 15:39:06 -0500
Date: Fri, 17 Jan 2003 21:48:58 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Jeff Garzik <jgarzik@pobox.com>, rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, kai@tp1.ruhr-uni-bochum.de
Subject: Re: Initcall / device model meltdown?
Message-ID: <20030117204858.GA2359@brodo.de>
References: <20030117193256.GE8304@gtf.org> <3104.1042835842@www5.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3104.1042835842@www5.gmx.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2003 at 09:37:22PM +0100, Jeff Garzik wrote:
> On Fri, Jan 17, 2003 at 07:23:56PM +0000, Russell King wrote:
> > 1. the device model requires a certain initialisation order.
> > 2. modules need to use module_init() which means the initialisation order
> >    is link-order dependent, despite our multi-level initialisation system.

modules don't really need module_init() -- you can use the others, too:
in include/linux/init.h:

/* Don't use these in modules, but some people do... */
#define core_initcall(fn)               module_init(fn)
#define postcore_initcall(fn)           module_init(fn)
#define arch_initcall(fn)               module_init(fn)
#define subsys_initcall(fn)             module_init(fn)
#define fs_initcall(fn)                 module_init(fn)
#define device_initcall(fn)             module_init(fn)
#define late_initcall(fn)               module_init(fn)


So it makes sense to use the appropriate initcall level even in files that
can be compiled as modules, these #defines do their work for you. We should
update that comment, though.

	Dominik

--- linux-original/include/linux/init.h	2003-01-17 16:51:23.000000000 +0100
+++ linux/include/linux/init.h	2003-01-17 21:46:34.000000000 +0100
@@ -129,7 +129,10 @@
 
 #else /* MODULE */
 
-/* Don't use these in modules, but some people do... */
+/* Alternatively, you can still use these initcall levels to
+ * ensure proper initialization order when modularized stuff
+ * is compiled into the kernel.
+ */
 #define core_initcall(fn)		module_init(fn)
 #define postcore_initcall(fn)		module_init(fn)
 #define arch_initcall(fn)		module_init(fn)
