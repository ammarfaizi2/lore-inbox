Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264832AbTE1TOS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 15:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264839AbTE1TOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 15:14:18 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:45887 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S264832AbTE1TOQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 15:14:16 -0400
Subject: Re: [BUG] 2.5.70 tty_register_driver
From: Paul Fulghum <paulkf@microgate.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>
In-Reply-To: <1054138158.2107.4.camel@diemos>
References: <1054138158.2107.4.camel@diemos>
Content-Type: text/plain
Organization: 
Message-Id: <1054150058.2025.18.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 28 May 2003 14:27:38 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-28 at 11:09, Paul Fulghum wrote:
> There was a large patch applied in 2.5.70 to
> the tty layer that has broken registration of tty
> devices.

Below is the broken code that was added in 2.5.70
to the tty_register_driver() function in drivers/char/tty_io.c
(apparently submitted by Greg Kroah-Hartman <greg@kroah.com>)

If a tty device uses dynamic major device numbers
(driver->major set to zero), then the new code fails
to honor the driver->minor_start value. Previously
the driver->minor_start specified the starting device
minor number for all calls to tty_register_driver()
regardless of if major is dynamically allocated or
staticly specified.

The result is the device minor numbers change for
dynamically assigned major device numbers resulting
in a loss of compatibility.

tty_register_driver() should be fixed
(along with alloc_chrdev_region) to once again honor
the base minor number.
 
 	if (!driver->major) {
-		error = register_chrdev_region(0, driver->minor_start,
-				       driver->num, driver->name, &tty_fops);
-		if (error > 0)
-			driver->major = error;
+		error = alloc_chrdev_region(&dev, driver->num,
+						(char*)driver->name);
+		if (!error) {
+			driver->major = MAJOR(dev);
+			driver->minor_start = MINOR(dev);
+		}
 	} else {
-		error = get_range(driver);
+		dev = MKDEV(driver->major, driver->minor_start);
+		error = register_chrdev_region(dev, driver->num,
+						(char*)driver->name);
 	}


-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


