Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbUHJILd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUHJILd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 04:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUHJILW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 04:11:22 -0400
Received: from cantor.suse.de ([195.135.220.2]:9448 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261682AbUHJIKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 04:10:03 -0400
Message-ID: <411882DA.5090400@suse.de>
Date: Tue, 10 Aug 2004 10:10:02 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] hotplug resource limitation
References: <41177703.5070202@suse.de> <20040810001016.GC7131@kroah.com>
In-Reply-To: <20040810001016.GC7131@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Mon, Aug 09, 2004 at 03:07:15PM +0200, Hannes Reinecke wrote:
> 
>>Hi all,
>>this is the second patch to implement hotplug resource limitation 
>>(relative to 2.6.7-rc2-mm2).
>>
>>In some cases it is preferrable to adapt the number of concurrent 
>>hotplug processes on the fly in addition to set the number statically 
>>during boot.
> 
> 
> Why?  This should be "auto-tuning".  We don't want to provide
> yet-another-knob-for-people-to-tweak-from-userspace, right?
> 
In principle you're right. But as we don't really now how much resources 
the installed hotplug program will require I don't really see another way.

> 
>>Additionally, it might be required to disable hotplug / 
>>kmod event delivery altogether for debugging purposes (e.g. if a module 
>>loaded automatically is crashing the machine).
> 
> 
> Ugh, that's just not a good thing at all.  You can do that by running:
> 	echo /bin/true > /proc/sys/kernel/hotplug
> today if you have to.  I don't like the ability to stop the kernel from
> running properly, like this patch allows you to.
> 
But then you'll lose all events which happen in the meantime.

The dynamic setting is mainly intended for two scenarios:
- Booting. You can disable all events on boot with the kernel 
commandline and re-enable them once your hotplug subsystem is up and 
running. This way you can handle all (ok, all devices appearing in 
sysfs) device with hotplug events; there is no need to regenerate / fake 
all events which might have been missed. Currently you need two sets of 
scripts, one for configuring all devices until hotplug is running and 
another one used by hotplug.
- Debugging. Especially laptops or legacy free machines do have the 
problem that hotplug scripts might misconfigure the machine, e.g. by 
loading the wrong module. Of course it's possible to keep this 'disable 
hotplug events on request' (which should event available during boot) 
entirely in userspace. But it would increase the size of /sbin/hotplug 
(and hence the running time) by quite a bit; and this would bite us on 
every hotplug event generated resulting in a general slowdown of the 
hotplug subsystem. If we can stop the hotplug event delivery from within 
the kernel, we can keep the main hotplug script as small as possible 
while retaining the functionality of temporarily disabling all hotplug 
events.

What we could do, though, is to implement two semaphores, one for kmod 
calls and another one for hotplug calls. Then we can queue or event 
delay all hotplug events while any kmod call would just be blocked until 
the semaphore is free again.

Better approach?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de
