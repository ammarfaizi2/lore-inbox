Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265247AbTFEX2W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 19:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265254AbTFEX2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 19:28:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31960 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265247AbTFEX2V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 19:28:21 -0400
Date: Fri, 6 Jun 2003 00:41:50 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@digeo.com>
Cc: Pavel Machek <pavel@suse.cz>, mochel@osdl.org, greg@kroah.com,
       hannal@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFT/C 2.5.70] Input class hook up to driver model/sysfs
Message-ID: <20030605234150.GY6754@parcelfarce.linux.theplanet.co.uk>
References: <20030605220716.GF608@elf.ucw.cz> <Pine.LNX.4.44.0306051511350.13077-100000@cherise> <20030605224535.GH608@elf.ucw.cz> <20030605155642.68179245.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030605155642.68179245.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 03:56:42PM -0700, Andrew Morton wrote:
 
> Al Viro has asked that sysfs conversions such as this be placed on hold
> until we sort through the newly-added bugs arising from the sysfsification
> of netdevs and request queues.  
> 
> So yeah, do the work, but please make sure that you understand what went
> wrong with netdevs and queues, and make sure that the input sysfsification
> addresses those problems.  Preferably in the same way...

It doesn't - note the absense of ->release() in the introduced objects,
lack of refcount in current ones and chunks like
+               class_device_unregister(&dev->class_dev);
+               kfree(dev);
in the patch.  The last one is obvious breakage, no matter what else is
going on - if ->class_dev is registered, it could be held by opened
sysfs file and we are doing kfree() of a busy object.  If it is not,
unregister will be unhappy _and_ we still might have it held by opened
sysfs file since the time when it used to be registered.

IOW, before something like that we'd need to make lifetime rules
for evdev et.al. refcounting-based, make drivers/input/* OK with
zombies ("I want it gone, but sysfs holds it") and when that is
done - have freeing done from ->release() of kobject.

Note that things like evdev->open are _not_ immediately usable for
refcounts - the lifetime is controlled by combination of ->exist
and ->open and we do non-trivial work when current ->open hits
zero, so just adding offset to ->open won't do.
