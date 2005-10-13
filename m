Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbVJMSWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbVJMSWE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 14:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbVJMSWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 14:22:04 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61455 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932154AbVJMSWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 14:22:03 -0400
Date: Thu, 13 Oct 2005 19:21:54 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [PATCH] drivers/base - fix sparse warnings
Message-ID: <20051013182154.GB24367@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Ben Dooks <ben-linux@fluff.org>, linux-kernel@vger.kernel.org,
	gregkh@suse.de
References: <20051013165441.GA18360@home.fluff.org> <Pine.LNX.4.64.0510131059510.15297@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510131059510.15297@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2005 at 11:10:15AM -0700, Linus Torvalds wrote:
> On Thu, 13 Oct 2005, Ben Dooks wrote:
> > 
> > The patch does not solve all the sparse errors generated,
> > but reduces the count significantly.
> 
> Well, you should also then remove the _bad_ declarations.
>
> ...
> 
> You made the declaration properly visible, but you should also remove the 
> bogus declaration. A declaration that isn't visible to the definition is 
> always bad - since in the absense of a compiler with global visibility it 
> may or may not actually match what it supposedly declares.

Erm, lets take your example - attribute_container_init().  It's defined
in attribute_container.c, where the base.h include was added:

diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd1/drivers/base/attribute_container.c linux-2.6.14-rc4-bjd2/drivers/base/attribute_container.c
--- linux-2.6.14-rc4-bjd1/drivers/base/attribute_container.c	2005-10-11 10:56:31.000000000 +0100
+++ linux-2.6.14-rc4-bjd2/drivers/base/attribute_container.c	2005-10-13 15:30:01.000000000 +0100
@@ -19,6 +19,8 @@
 #include <linux/list.h>
 #include <linux/module.h>
 
+#include "base.h"
+
 /* This is a private structure used to tie the classdev and the
  * container .. it should never be visible outside this file */
 struct internal_container {

The base.h include contains the definition:

diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd1/drivers/base/base.h linux-2.6.14-rc4-bjd2/drivers/base/base.h
--- linux-2.6.14-rc4-bjd1/drivers/base/base.h	2005-09-01 21:02:36.000000000 +0100
+++ linux-2.6.14-rc4-bjd2/drivers/base/base.h	2005-10-13 15:26:56.000000000 +0100
@@ -1,3 +1,15 @@
+
+/* initialisation functions */
+
+extern int devices_init(void);
+extern int buses_init(void);
+extern int classes_init(void);
+extern int firmware_init(void);
+extern int platform_bus_init(void);
+extern int system_bus_init(void);
+extern int cpu_dev_init(void);
+extern int attribute_container_init(void);
+
 extern int bus_add_device(struct device * dev);
 extern void bus_remove_device(struct device * dev);
 
And base.h was included in init.c and the bogus declaration removed:

diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd1/drivers/base/init.c linux-2.6.14-rc4-bjd2/drivers/base/init.c
--- linux-2.6.14-rc4-bjd1/drivers/base/init.c	2005-06-17 20:48:29.000000000 +0100
+++ linux-2.6.14-rc4-bjd2/drivers/base/init.c	2005-10-13 15:27:05.000000000 +0100
@@ -10,14 +10,8 @@
 #include <linux/device.h>
 #include <linux/init.h>
 
-extern int devices_init(void);
-extern int buses_init(void);
-extern int classes_init(void);
-extern int firmware_init(void);
-extern int platform_bus_init(void);
-extern int system_bus_init(void);
-extern int cpu_dev_init(void);
-extern int attribute_container_init(void);
+#include "base.h"
+
 /**
  *	driver_init - initialize driver model.
  *

I can't see anything that was missed.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
