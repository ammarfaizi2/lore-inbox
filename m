Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263494AbTJQScQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 14:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263583AbTJQScQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 14:32:16 -0400
Received: from mail.kroah.org ([65.200.24.183]:27032 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263494AbTJQScO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 14:32:14 -0400
Date: Fri, 17 Oct 2003 11:27:54 -0700
From: Greg KH <greg@kroah.com>
To: clemens@dwf.com
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       reg@orion.dwf.com
Subject: Re: [ANNOUNCE] udev 003 release
Message-ID: <20031017182754.GA10714@kroah.com>
References: <20031017055652.GA7712@kroah.com> <200310171757.h9HHvGiY006997@orion.dwf.com> <20031017181923.GA10649@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031017181923.GA10649@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17, 2003 at 11:19:23AM -0700, Greg KH wrote:
> 
> Ah, yeah, udev seg faults right now for partitions.  Let me try to track
> down the bug, give me a bit of time...

Here's a patch that fixes the partition logic for me.  Sorry about this, I
need to make sure to test partitions more next time.

thanks again for testing this.

greg k-h

# fix segfaults when dealing with partitions.

diff -Nru a/udev-add.c b/udev-add.c
--- a/udev-add.c	Fri Oct 17 11:26:37 2003
+++ b/udev-add.c	Fri Oct 17 11:26:37 2003
@@ -169,13 +169,13 @@
 	}
 	memset(&dbdev, 0, sizeof(dbdev));
 	strncpy(dbdev.name, attr.name, NAME_SIZE);
-	strncpy(dbdev.sysfs_path, class_dev->sysdevice->directory->path,
-		PATH_SIZE);
+	if (class_dev->sysdevice) {
+		strncpy(dbdev.sysfs_path, class_dev->sysdevice->directory->path, PATH_SIZE);
+		strncpy(dbdev.bus_id, class_dev->sysdevice->bus_id, ID_SIZE);
+	}
 	strncpy(dbdev.class_dev_name, class_dev->name, NAME_SIZE);
-	if ((sysfs_get_name_from_path(subsystem, dbdev.class_name, NAME_SIZE))
-	    != 0)
+	if ((sysfs_get_name_from_path(subsystem, dbdev.class_name, NAME_SIZE)) != 0)
 		strcpy(dbdev.class_name, "unkown");
-	strncpy(dbdev.bus_id, class_dev->sysdevice->bus_id, ID_SIZE);
 	strcpy(dbdev.bus_name, "unknown");
 	if (class_dev->driver != NULL)
 		strncpy(dbdev.driver, class_dev->driver->name, NAME_SIZE);
