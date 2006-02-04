Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946343AbWBDINn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946343AbWBDINn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 03:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946350AbWBDINn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 03:13:43 -0500
Received: from [84.204.75.166] ([84.204.75.166]:42446 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP
	id S1946346AbWBDINn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 03:13:43 -0500
Subject: [QUESTION/sysfs] strange refcounting
From: "Artem B. Bityutskiy" <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: MTD
Date: Sat, 04 Feb 2006 11:13:41 +0300
Message-Id: <1139040821.13125.4.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks, 

I'm writing a simple device driver and want to expose some of its
attributes to userspace via sysfs. 

As usually, I have main device description structure "struct
mydev_info". I've embedded a struct device object there. What I do is: 

struct mydev_info mydev 
{ 
    struct device *dev; 
    ... bla bla bla ... 
} mydev; 


mydev->dev=kzalloc(sizeof(struct device), GFP_KERNEL); 
mydev->dev->bus_id = "mydev"; 
mydev->dev->release = mydev_release; 
err = device_register(&mydev->dev); 

Then, I see /sys/devices/mydev/ in sysfs. I open
pre-defined /sys/devices/mydev/power/state in userspace and don't close it. 

Then I run lsmod, and see zero refcount to my module. Well, I run rmmod
mymod, module is unloaded. 

Then I close /sys/devices/mydev/power/state, and enjoy segfault. 

I thought sysfs subsystem have to increase module refcount when one
opens its sysfs files. Well, there is a release function, but it is also
unloaded with the module. 

May be there is a problem because of I have mydev->dev->parent == NULL,
mydev->dev->bus == NULL, mydev->dev->driver == NULL? But I really don't
have any bus, any parent and I don't want to introduce struct
device_driver ... 

Kernel is 2.6.15.1. 

Although this is my first meet with sysfs, this looks strange. 

Thanks.

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.

