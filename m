Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWDRTdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWDRTdF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 15:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWDRTdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 15:33:05 -0400
Received: from service.sh.cvut.cz ([147.32.127.214]:53637 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP id S932280AbWDRTdE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 15:33:04 -0400
Message-ID: <44453EB6.4060907@sh.cvut.cz>
Date: Tue, 18 Apr 2006 21:32:06 +0200
From: Rudolf Marek <r.marek@sh.cvut.cz>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Cc: wim@iguana.be, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Watchdog device class
References: <4443EED9.30603@sh.cvut.cz> <200604180254.47827.arnd@arndb.de>
In-Reply-To: <200604180254.47827.arnd@arndb.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arnd,

> Wim used to have an experimental tree with a similar idea. Did you look
> at that before you started this? Is that tree still maintained?

No I did not, I thought if the class exist it is already there ...
Instead I have taken the RTC class which was fairly similar to the watchdog
needs and changed it to a watchdog one. I think this may answer some of your
questions ;)

Now we have something that works and might be used as the base for the watchdog
class. Many thanks for your comments.

>>+#include <linux/module.h>
>>+#include "watchdog.h"
>>+
>>+static struct class *watchdog_dev_class;
>>+static dev_t watchdog_devt;
>>+
>>+#define WATCHDOG_DEV_MAX 8 /* 8 watchdogs should be enough for everyone... */
>
> What's the point in having more than one watchdog active?
> If you want more than one, why hardcode a specific limit?

I thought there might be such future need, nowdays it used
to test the stuff.

If nobody here wants it I have no problem to change the class just to allow
one active watchdog.

> 
> Existing user space typically depends on the watchdog device being called
> /dev/watchdog, which breaks if your devices are called watchdog%d.
> I can see two ways out of this:
> 
> 1. add a udev rule that creates /dev/watchdog as an alias for /dev/watchdog0.
> 2. add a misc device /dev/watchdog that works as a multiplexer for all others,
>    similar to the idea of /dev/input/mice as a multiplexer for /dev/input/mouse%d.

True, this depends if someone wants this multi watchdog stuff.

>>+#define WATCHDOG_DEVICE_NAME_SIZE 20
>>+
>>+struct watchdog_device {
>>+       struct class_device class_dev;
>>+       struct module *owner;
>>+
>>+       int id;
>>+       char name[WATCHDOG_DEVICE_NAME_SIZE];
>
> Can this be the embedded name in class_device?

I copied this from the RTC, and because it is already in kernel I assumed it is
OK to have it this way.

>>+
>>+       struct watchdog_class_ops *ops;
>>+       struct mutex ops_lock;
>>+
>>+       struct class_device *watchdog_dev; 
> 
> 
> Having two classes (watchdog_class and watchdog_dev_class) as well as
> two class_devices (class_dev and watchdog_dev) per device seems wrong.
> What is the reason for splitting these?

Again, this was taken from the RTC subsystem and I left the modularity of the
stuff. But for the watchdog case it might go without the additional class.
As for the watchdog_dev it depends how tight we want to integrate it into the class.

>>+/* watchdog_device_register_simple, will register device into watchdog class
>>+   just with default timeout from kernel configuration.
>>+   
>>+   watchdog_device_register_selfping, will register the watchdog device same 
>>+   way as above function, but the device will be pinged every selfping interval
>>+   (useful for watchdog with damm fast timeouts)
>>+*/
>>+
>>+#define watchdog_device_register_simple(name, dev, ops)  \
>>+           _watchdog_device_register(name, dev, ops, THIS_MODULE, CONFIG_WATCHDOG_DEFAULT_TIMEOUT, 0)
>>+
>>+#define watchdog_device_register_selfping(name, dev, ops, selfping)  \
>>+           _watchdog_device_register(name, dev, ops, THIS_MODULE, CONFIG_WATCHDOG_DEFAULT_TIMEOUT, selfping)
> 
> 
> All callers of this seem to have constant arguments (except dev), so you
> could easily put name, owner, timeout and selfping into the ops structure.
> Maybe the structure could use a different name then.

Hmm even to think the name is a bit problem, because the in it will be used for
two different things, for the ops and as the data container.

>>+static ssize_t watchdog_sysfs_show_name(struct class_device *dev, char *buf)
>>+{
>>+       return sprintf(buf, "%s\n", to_watchdog_device(dev)->name);
>>+}
>>+static CLASS_DEVICE_ATTR(name, S_IRUGO, watchdog_sysfs_show_name, NULL);
> 
> 
> Why do you need a name attribute? Should the name of the class_device
> itself not be enough as an identifier?

True, RTC has it this way too so I thought there must be some reason...

> What's the point in making the sysfs stuff an extra module? I guess it
> would be a lot simpler to just always add the files. We might want to
> make the dev interface optional, but then again it is what all applications
> to date are using, so you may just as well have a single base module
> and no infrastructure for multiple interfaces at all.

Well the sysfs seemed still bit a future for watchdog and embedded devices might
want to save some space. I even did not know that sysfs interface will be on
the topic so quickly. So this was the reason I left it as it was in RTC...


Thanks,
Regards
Rudolf

PS: please CC me.
