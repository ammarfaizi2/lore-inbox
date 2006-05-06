Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWEFHPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWEFHPd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 03:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWEFHPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 03:15:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15112 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751168AbWEFHPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 03:15:32 -0400
Date: Sat, 6 May 2006 08:15:26 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device core: remove redundant call to device_initialize.
Message-ID: <20060506071526.GC18829@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>,
	gregkh@suse.de, linux-kernel@vger.kernel.org
References: <20060505153907.12756.23295.stgit@zion.home.lan> <20060505193542.0332557b.akpm@osdl.org> <20060506071036.GB18829@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060506071036.GB18829@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2006 at 08:10:36AM +0100, Russell King wrote:
> On Fri, May 05, 2006 at 07:35:42PM -0700, Andrew Morton wrote:
> > And indeed platform_device_alloc() already does that.  If that is
> > sufficient then we're in good shape.
> > 
> > If it is not sufficient then more thought would be needed.  We could at
> > least run device_initialize() at the _start_ of platform_device_add(),
> > rather than towards the end.
> 
> Just remove the call to device_initialise() in platform_device_add() -
> that's something I missed when I renamed platform_device_register to
> platform_device_add().

My email last night on the subject was more accurate than this - ETOOEARLY.
Have a patch instead.

# Base git commit: 5528e568a760442e0ec8fd2dea1f0791875a066b
#	([TCP]: Fix snd_cwnd adjustments in tcp_highspeed.c)
#
# Author:    Russell King (Sat May  6 08:13:02 BST 2006)
# Committer: Russell King (Sat May  6 08:13:02 BST 2006)
#	
#	[DRVMODEL] Fix platform_device_add to use device_add
#	
#	platform_device_add() should be using device_add() rather
#	than device_register() - any platform device passed to
#	platform_device_add() should have already been initialised,
#	either by platform_device_alloc() or platform_device_register().
#	
#	Signed-off-by: Russell King
#
#	 drivers/base/platform.c |    2 +-
#	 1 files changed, 1 insertions(+), 1 deletions(-)
#
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -275,7 +275,7 @@ int platform_device_add(struct platform_
 	pr_debug("Registering platform device '%s'. Parent at %s\n",
 		 pdev->dev.bus_id, pdev->dev.parent->bus_id);
 
-	ret = device_register(&pdev->dev);
+	ret = device_add(&pdev->dev);
 	if (ret == 0)
 		return ret;
 


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
