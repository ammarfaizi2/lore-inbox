Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVCCHMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVCCHMf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 02:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVCCHKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 02:10:22 -0500
Received: from fire.osdl.org ([65.172.181.4]:10724 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261537AbVCCHGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 02:06:54 -0500
Date: Wed, 2 Mar 2005 23:06:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeffrey Mahoney <jeffm@suse.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: [PATCH 1/3] openfirmware: generate device table for userspace
Message-Id: <20050302230628.1e2107be.akpm@osdl.org>
In-Reply-To: <20050301211814.GB16465@locomotive.unixthugs.org>
References: <20050301211814.GB16465@locomotive.unixthugs.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffrey Mahoney <jeffm@suse.com> wrote:
>
> This patch converts the usage of struct of_match to struct of_device_id,
>  similar to pci_device_id. This allows a device table to be generated, which 
>  can be parsed by depmod(8) to generate a map file for module loading.

It breaks the power4 build all over the place.  Below is a partial fix, but..

drivers/macintosh/via-pmu.c:157: warning: `async_req_locks' defined but not used
drivers/macintosh/therm_pm72.c:1626: warning: `struct of_match' declared inside parameter list
drivers/macintosh/therm_pm72.c:1626: warning: its scope is only this definition or declaration, which is probably not what you want
drivers/macintosh/therm_pm72.c:1649: error: elements of array `fcu_of_match' have incomplete type
drivers/macintosh/therm_pm72.c:1652: error: unknown field `name' specified in initializer
drivers/macintosh/therm_pm72.c:1652: error: `OF_ANY_MATCH' undeclared here (not in a function)
drivers/macintosh/therm_pm72.c:1652: warning: excess elements in struct initializer
drivers/macintosh/therm_pm72.c:1652: warning: (near initialization for `fcu_of_match[0]')
drivers/macintosh/therm_pm72.c:1653: error: unknown field `type' specified in initializer
drivers/macintosh/therm_pm72.c:1653: warning: excess elements in struct initializer
drivers/macintosh/therm_pm72.c:1653: warning: (near initialization for `fcu_of_match[0]')
drivers/macintosh/therm_pm72.c:1654: error: unknown field `compatible' specified in initializer
drivers/macintosh/therm_pm72.c:1655: error: `OF_ANY_MATCH' undeclared here (not in a function)
drivers/macintosh/therm_pm72.c:1655: warning: excess elements in struct initializer
drivers/macintosh/therm_pm72.c:1655: warning: (near initialization for `fcu_of_match[0]')
drivers/macintosh/therm_pm72.c:1662: warning: initialization from incompatible pointer type
drivers/macintosh/therm_pm72.c:1663: warning: initialization from incompatible pointer type
make[2]: *** [drivers/macintosh/therm_pm72.o] Error 1
make[1]: *** [drivers/macintosh] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [drivers] Error 2
make: *** Waiting for unfinished jobs....


So I'll drop these patches.  Please get it build- and run-tested on ppc64,
resend it all?




arch/ppc64/kernel/of_device.c:20: error: conflicting types for `of_match_device'
include/asm-ppc/of_device.h:28: error: previous declaration of `of_match_device'
arch/ppc64/kernel/of_device.c: In function `of_match_device':
arch/ppc64/kernel/of_device.c:23: error: dereferencing pointer to incomplete type
arch/ppc64/kernel/of_device.c:23: error: dereferencing pointer to incomplete type
arch/ppc64/kernel/of_device.c:23: error: dereferencing pointer to incomplete type
arch/ppc64/kernel/of_device.c:25: error: dereferencing pointer to incomplete type
arch/ppc64/kernel/of_device.c:25: error: dereferencing pointer to incomplete type
arch/ppc64/kernel/of_device.c:25: error: `OF_ANY_MATCH' undeclared (first use in this function)
arch/ppc64/kernel/of_device.c:25: error: (Each undeclared identifier is reported only once
arch/ppc64/kernel/of_device.c:25: error: for each function it appears in.)
arch/ppc64/kernel/of_device.c:27: error: dereferencing pointer to incomplete type
arch/ppc64/kernel/of_device.c:28: error: dereferencing pointer to incomplete type
arch/ppc64/kernel/of_device.c:28: error: dereferencing pointer to incomplete type
arch/ppc64/kernel/of_device.c:30: error: dereferencing pointer to incomplete type
arch/ppc64/kernel/of_device.c:31: error: dereferencing pointer to incomplete type
arch/ppc64/kernel/of_device.c:31: error: dereferencing pointer to incomplete type
arch/ppc64/kernel/of_device.c:33: error: dereferencing pointer to incomplete type
arch/ppc64/kernel/of_device.c:36: error: increment of pointer to unknown structure
arch/ppc64/kernel/of_device.c:36: error: arithmetic on pointer to an incomplete type
arch/ppc64/kernel/of_device.c: In function `of_platform_bus_match':
arch/ppc64/kernel/of_device.c:45: warning: initialization from incompatible pointer type
arch/ppc64/kernel/of_device.c: In function `of_device_probe':
arch/ppc64/kernel/of_device.c:88: warning: passing arg 1 of `of_match_device' from incompatible pointer type
arch/ppc64/kernel/of_device.c:90: warning: passing arg 2 of pointer to function from incompatible pointer type


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc64/kernel/of_device.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff -puN arch/ppc64/kernel/of_device.c~openfirmware-generate-device-table-for-userspace-fix arch/ppc64/kernel/of_device.c
--- 25/arch/ppc64/kernel/of_device.c~openfirmware-generate-device-table-for-userspace-fix	2005-03-03 06:52:37.000000000 -0700
+++ 25-akpm/arch/ppc64/kernel/of_device.c	2005-03-03 06:55:26.000000000 -0700
@@ -3,6 +3,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <asm/errno.h>
 #include <asm/of_device.h>
 
@@ -15,20 +16,20 @@
  * Used by a driver to check whether an of_device present in the
  * system is in its list of supported devices.
  */
-const struct of_match * of_match_device(const struct of_match *matches,
+const struct of_device_id *of_match_device(const struct of_device_id *matches,
 					const struct of_device *dev)
 {
 	if (!dev->node)
 		return NULL;
-	while (matches->name || matches->type || matches->compatible) {
+	while (matches->name[0] || matches->type[0] || matches->compatible[0]) {
 		int match = 1;
-		if (matches->name && matches->name != OF_ANY_MATCH)
+		if (matches->name[0])
 			match &= dev->node->name
 				&& !strcmp(matches->name, dev->node->name);
-		if (matches->type && matches->type != OF_ANY_MATCH)
+		if (matches->type[0])
 			match &= dev->node->type
 				&& !strcmp(matches->type, dev->node->type);
-		if (matches->compatible && matches->compatible != OF_ANY_MATCH)
+		if (matches->compatible[0])
 			match &= device_is_compatible(dev->node,
 				matches->compatible);
 		if (match)
@@ -42,7 +43,7 @@ static int of_platform_bus_match(struct 
 {
 	struct of_device * of_dev = to_of_device(dev);
 	struct of_platform_driver * of_drv = to_of_platform_driver(drv);
-	const struct of_match * matches = of_drv->match_table;
+	const struct of_device_id * matches = of_drv->match_table;
 
 	if (!matches)
 		return 0;
@@ -75,7 +76,7 @@ static int of_device_probe(struct device
 	int error = -ENODEV;
 	struct of_platform_driver *drv;
 	struct of_device *of_dev;
-	const struct of_match *match;
+	const struct of_device_id *match;
 
 	drv = to_of_platform_driver(dev->driver);
 	of_dev = to_of_device(dev);
_

