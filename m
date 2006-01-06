Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752295AbWAFGDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbWAFGDY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 01:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752331AbWAFGDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 01:03:24 -0500
Received: from gate.crashing.org ([63.228.1.57]:3050 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1752271AbWAFGDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 01:03:23 -0500
Subject: Re: Platform device matching, & weird strncmp usage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1136527179.4840.120.camel@localhost.localdomain>
References: <1136527179.4840.120.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 17:04:17 +1100
Message-Id: <1136527457.4840.123.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-06 at 16:59 +1100, Benjamin Herrenschmidt wrote:
> Hi !
> 
> In 2.6.15, platform device matching works according to this comment in
> the code, or rather are supposed to:

  .../...

Just in case my analysis is correct, here's an untested fix:

---

Platform device matching doesn't work when an "id" is used.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

--- linux-work.orig/drivers/base/platform.c	2005-11-24 17:18:43.000000000 +1100
+++ linux-work/drivers/base/platform.c	2006-01-06 16:59:59.000000000 +1100
@@ -447,7 +447,8 @@ static int platform_match(struct device 
 {
 	struct platform_device *pdev = container_of(dev, struct platform_device, dev);
 
-	return (strncmp(pdev->name, drv->name, BUS_ID_SIZE) == 0);
+	return strncmp(pdev->name, drv->name,
+			min(BUS_ID_SIZE, strlen(drv->name))) == 0;
 }
 
 static int platform_suspend(struct device * dev, pm_message_t state)


