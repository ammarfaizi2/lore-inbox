Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbWBFJ6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWBFJ6E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 04:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWBFJ6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 04:58:03 -0500
Received: from [84.204.75.166] ([84.204.75.166]:26753 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP
	id S1750908AbWBFJ6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 04:58:01 -0500
Message-ID: <43E71DA8.3020103@yandex.ru>
Date: Mon, 06 Feb 2006 12:58:00 +0300
From: "Artem B. Bityutskiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [QUESTION/sysfs] strange refcounting
References: <1139040821.13125.4.camel@sauron.oktetlabs.ru> <43E4985D.3070708@yandex.ru> <43E4AD2F.1020703@yandex.ru>
In-Reply-To: <43E4AD2F.1020703@yandex.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As &struct device structure has no @owner field, and corresponding 
functions rely on the @owner field at &struct device_driver, I conclude 
that I cannot use &struct device objects without bus and device driver 
objects, just by design.

On the other hand, 'device_register()' accepts &struct device objects 
with NULL-filled @bus and @driver fields perfectly fine, does not 
complain, does not return any error, and I even see corresponding 
entries at /sys/devices/. But there is a refcounting problem described 
at my first mail.

This is obviously a confusing discrepancy. Sysfs has to either reject 
bus-less and driver-less &struct device objects or deal with them 
correctly. The latter is impossible due to lack of an @owner field in 
&struct device.

In connection with this, I have a question. There is a whole bunch of 
drivers which do not directly relate to hardware devices, but which 
still want to expose their parameters via sysfs. For example, this could 
be a filesystem, LVM, a compression layer on top of a file system of a 
block device, whatever. These are "virtual" devices and they are not 
physically connected to any bus. How should they deal with sysfs?

I see there is the "class" stuff in sysfs, but it seems that it is far 
not as flexible as the "device, driver, and bus" stuff, because I cannot 
create many nested layers within classes. I can create a class, which 
goes to /sys/class/, and devices within this class, which go to 
/sys/class/myclass/mydev/. But I cannot create a class, devices within 
that class, and daughter devices within them, like:

/sys/class/myclass/
            |-- mydev1/
                | -- doughterdev1/
                | -- doughterdev1/
                | -- ...
            |-- mydev2/
            |-- mydev3/
            |-- ...

Please, comment this.

Thanks.

-- 
Best Regards,
Artem B. Bityutskiy,
St.-Petersburg, Russia.
