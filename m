Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264487AbTK0Lqe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 06:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264488AbTK0Lqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 06:46:34 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:43012 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264487AbTK0Lqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 06:46:32 -0500
Subject: Re: APM Suspend Problem
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Misha Nasledov <misha@nasledov.com>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20031127062057.GA31974@nasledov.com>
References: <20031127062057.GA31974@nasledov.com>
Content-Type: multipart/mixed; boundary="=-84WrG1lrehbj7/vnJglI"
Message-Id: <1069933566.2144.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Thu, 27 Nov 2003 12:46:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-84WrG1lrehbj7/vnJglI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2003-11-27 at 07:20, Misha Nasledov wrote:
> Hi,
> 
> Since about 2.6.0-test9, my ThinkPad T21 no longer suspends with APM. I had
> issues with it suspending before, I don't remember exactly what issues, but I
> know that it definitely worked in -test2. When I hit the key on my laptop to
> suspend, it will turn off the LCD and the HD will spin down, but the machine
> will not actually suspend. Here is what is printed out on the console when I
> hit the suspend key and then when I hit another key to "wake" it up:

Could you please try the attached patch? It allows my system to suspend
and resume using APM flawlessly.

--=-84WrG1lrehbj7/vnJglI
Content-Disposition: attachment; filename=pm-1013.patch
Content-Type: text/x-patch; name=pm-1013.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- 1.11/drivers/base/power/resume.c	Mon Aug 25 11:08:21 2003
+++ edited/drivers/base/power/resume.c	Fri Oct 10 21:06:07 2003
@@ -22,8 +22,17 @@
 
 int resume_device(struct device * dev)
 {
-	if (dev->bus && dev->bus->resume)
-		return dev->bus->resume(dev);
+	if (dev->bus && dev->bus->resume) {
+		int retval;
+
+		/* drop lock so the call can use device_del() to clean up
+		 * after unplugged (or otherwise vanished) child devices
+		 */
+		up(&dpm_sem);
+		retval = dev->bus->resume(dev);
+		down(&dpm_sem);
+		return retval;
+	}
 	return 0;
 }
 

--=-84WrG1lrehbj7/vnJglI--

