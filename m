Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbVAHJKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbVAHJKN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVAHIrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 03:47:42 -0500
Received: from mail.kroah.org ([69.55.234.183]:58245 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261889AbVAHFs3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:29 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <1105163257891@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:37 -0800
Message-Id: <1105163257205@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.47, 2005/01/06 16:39:32-08:00, jbarnes@engr.sgi.com

[PATCH] fix oops when reading resourceN files in sysfs

On Thursday, January 6, 2005 12:25 pm, Jesse Barnes wrote:
> [Sorry about the bogus reply, I don't have the original message.]
>
> That shouldn't happen.  Maybe you were running an old version of the tree
> or an old version of my sysfs mmap patch?  When I do a 'bk pull' of
> gregkh's latest usb tree into a recent Linus tree, I get an -EINVAL, not an
> oops.  An earlier version of my patch had this bug though, so maybe that's
> what you're seeing?

Ugg.  How about this?

Zero out newly allocated bin_attributes for legacy I/O, memory and resource
files since we won't fill in all of the file operation methods.  This will
allow the checks in bin.c for the existence of a method to work properly
instead of checking garbage memory.

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/pci-sysfs.c |    1 +
 drivers/pci/probe.c     |    1 +
 2 files changed, 2 insertions(+)


diff -Nru a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
--- a/drivers/pci/pci-sysfs.c	2005-01-07 15:38:33 -08:00
+++ b/drivers/pci/pci-sysfs.c	2005-01-07 15:38:33 -08:00
@@ -295,6 +295,7 @@
 
 		res_attr = kmalloc(sizeof(*res_attr) + 10, GFP_ATOMIC);
 		if (res_attr) {
+			memset(res_attr, 0, sizeof(*res_attr) + 10);
 			pdev->res_attr[i] = res_attr;
 			/* Allocated above after the res_attr struct */
 			res_attr->attr.name = (char *)(res_attr + 1);
diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	2005-01-07 15:38:33 -08:00
+++ b/drivers/pci/probe.c	2005-01-07 15:38:33 -08:00
@@ -41,6 +41,7 @@
 	b->legacy_io = kmalloc(sizeof(struct bin_attribute) * 2,
 			       GFP_ATOMIC);
 	if (b->legacy_io) {
+		memset(b->legacy_io, 0, sizeof(struct bin_attribute) * 2);
 		b->legacy_io->attr.name = "legacy_io";
 		b->legacy_io->size = 0xffff;
 		b->legacy_io->attr.mode = S_IRUSR | S_IWUSR;

