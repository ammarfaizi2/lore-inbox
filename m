Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbWAFF6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWAFF6r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 00:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbWAFF6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 00:58:47 -0500
Received: from gate.crashing.org ([63.228.1.57]:65001 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750978AbWAFF6r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 00:58:47 -0500
Subject: Platform device matching, & weird strncmp usage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 16:59:39 +1100
Message-Id: <1136527179.4840.120.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

In 2.6.15, platform device matching works according to this comment in
the code, or rather are supposed to:


 *	Platform device IDs are assumed to be encoded like this:
 *	"<name><instance>", where <name> is a short description of the
 *	type of device, like "pci" or "floppy", and <instance> is the
 *	enumerated instance of the device, like '0' or '42'.

However, looking a few lines below, I see the actual implemetation:

static int platform_match(struct device * dev, struct device_driver * drv)
{
	struct platform_device *pdev = container_of(dev, struct platform_device, dev);

	return (strncmp(pdev->name, drv->name, BUS_ID_SIZE) == 0);
}

As far as I know, strncmp() is _NOT_ supposed to return 0 if one string
is shorter than the other and they match until that point. Thus the
above will never match unless the <name> portion of pdev->name is
exactly of size BUS_ID_SIZE which is obviously not the case...

Did I miss something or do we expect a "special" semantic for strncmp in
the kernel ?

Ben.


