Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWBCOQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWBCOQZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 09:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWBCOQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 09:16:25 -0500
Received: from [84.204.75.166] ([84.204.75.166]:9159 "EHLO shelob.oktetlabs.ru")
	by vger.kernel.org with ESMTP id S1750845AbWBCOQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 09:16:25 -0500
Message-ID: <43E365B6.4060005@oktetlabs.ru>
Date: Fri, 03 Feb 2006 17:16:22 +0300
From: "Artem B. Bityutskiy" <dedekind@oktetlabs.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Subject: [QUESTION/sysfs] strange refcounting
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Then, I see /sys/devices/mydev/ in sysfs. I open pre-defined 
/sys/devices/mydev/power/state in userspace and don't close it.

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
Best regards, Artem B. Bityutskiy
Oktet Labs (St. Petersburg), Software Engineer.
+78124286709 (office) +79112449030 (mobile)
E-mail: dedekind@oktetlabs.ru, web: http://www.oktetlabs.ru
