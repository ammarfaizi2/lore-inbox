Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263968AbTIITp7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 15:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbTIITp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 15:45:59 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:38155 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S263968AbTIITpz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 15:45:55 -0400
Date: Tue, 9 Sep 2003 20:45:53 +0100
From: John Levon <levon@movementarian.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6][CFT] rmmod floppy kills box fixes + default_device_remove
Message-ID: <20030909194553.GA75492@compsoc.man.ac.uk>
References: <Pine.LNX.4.53.0309072228470.14426@montezuma.fsmlabs.com> <20030908155048.GA10879@kroah.com> <Pine.LNX.4.53.0309081722270.14426@montezuma.fsmlabs.com> <20030908230852.GA3320@kroah.com> <Pine.LNX.4.53.0309090739270.14426@montezuma.fsmlabs.com> <Pine.LNX.4.53.0309091142550.14426@montezuma.fsmlabs.com> <20030909171354.GC5928@kroah.com> <Pine.LNX.4.53.0309091359450.14426@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0309091359450.14426@montezuma.fsmlabs.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19woR0-00054J-Ej*74cPaKq0b9E*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 03:18:20PM -0400, Zwane Mwaikambo wrote:

> > Any thoughts on how to solve this?
> 
> How about something like the following, the kobj_type.done is passed from 
> the driver so the driver's presence can maintain it's persistence and 

This works. Repeat ad infinitum for all the other platform devices in
pcmcia etc, 99% of which don't need to release anything extra.

Alternatively why don't we do something like the below ? This still
allows platform devices to clean up if necessary, but solves the "wait
for last reference" on a sensible level IMHO.

Index: platform.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/base/platform.c,v
retrieving revision 1.11
diff -u -p -r1.11 platform.c
--- platform.c	16 Aug 2003 05:00:10 -0000	1.11
+++ platform.c	9 Sep 2003 18:02:22 -0000
@@ -18,6 +18,16 @@ struct device legacy_bus = {
 	.bus_id		= "legacy",
 };
 
+
+static void platform_device_release(struct device * dev)
+{
+	struct platform_device * pdev = to_platform_device(dev);
+	if (pdev->release)
+		pdev->release(pdev);
+	complete(&pdev->done);
+}
+
+
 /**
  *	platform_device_register - add a platform-level device
  *	@dev:	platform device we're adding
@@ -32,6 +42,12 @@ int platform_device_register(struct plat
 		pdev->dev.parent = &legacy_bus;
 
 	pdev->dev.bus = &platform_bus_type;
+
+	if (pdev->dev.release) {
+		printk("use the other release dude\n");
+	}
+	pdev->dev.release = platform_device_release;
+	init_completion(&pdev->done);
 	
 	snprintf(pdev->dev.bus_id,BUS_ID_SIZE,"%s%u",pdev->name,pdev->id);
 
@@ -44,6 +60,7 @@ void platform_device_unregister(struct p
 {
 	if (pdev)
 		device_unregister(&pdev->dev);
+	wait_for_completion(&pdev->done);
 }
 
 
-- 
Khendon's Law:
If the same point is made twice by the same person, the thread is over.
