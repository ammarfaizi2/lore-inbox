Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268355AbUGXH67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268355AbUGXH67 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 03:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268356AbUGXH67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 03:58:59 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:47280 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S268355AbUGXH6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 03:58:54 -0400
Date: Sat, 24 Jul 2004 00:58:52 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Robert Love <rml@ximian.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       zaitcev@redhat.com
Subject: Re: [patch] kernel events layer, updated
Message-ID: <20040724075852.GA21299@plexity.net>
Reply-To: dsaxena@plexity.net
References: <1090604517.13415.0.camel@lucy> <20040723200335.521fe42a.akpm@osdl.org> <1090638679.2296.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090638679.2296.9.camel@localhost>
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 23 2004, at 23:11, Robert Love was caught saying:
> @@ -59,9 +60,15 @@
>  	if (l & 0x1) {
>  		printk(KERN_EMERG "CPU%d: Temperature above threshold\n", cpu);
>  		printk(KERN_EMERG "CPU%d: Running in modulated clock mode\n",
> -				cpu);
> +			cpu);
> +		send_kevent(KMSG_POWER,
> +			"/org/kernel/devices/system/cpu/temperature", "high",
> +			"Cpu: %d\n", cpu);
>  	} else {
>  		printk(KERN_INFO "CPU%d: Temperature/speed normal\n", cpu);
> +		send_kevent(KMSG_POWER,
> +			"/org/kernel/devices/system/cpu/temperature", "normal",
> +			"Cpu: %d\n", cpu);

Robert,

What is the the specified naming scheme for objects and in the case of 
devices, why not use the sysfs path as part of the object path? For example:

	"/org/kernel/system/cpu/cpu0"

Since we have unique paths for devices in syfs, this would remove the need 
of having the anxiliary "CPU: %d" as it is embedded in the object name. 

Also, why the "/org/kernel"? Since all message from the kernel
can only come from the kernel, why do we need this as part of the object
name?  Looking at the D-BUS spec, it looks like the "org.foo" is part of the 
D-BUS/HAL/freedesktop naming scheme, but this should not be pushed into
the kernel IMHO. As you yourself mentioned in your talk today, D-BUS
is just one daemon that could use the kevents interface, so I don't
think we want to push it's naming scheme into the kernel messages.
The kernel should use an object name that is unique in the context 
of the kernel (hence my suggestion to use sysfs path, but perhaps there
is something else?) and D-BUS should generate the appropriate object 
name that it expects.  The kernel is never going to send messages for 
objects in org.freedesktop or anything !org.kernel, so we are just 
stuffing extra bytes in the message that are very specific to a given 
userland implementation.

You also mentioned some interesting usage examples of HAL/D-BUS/kevents 
in your talk. Any possibility of getting a patch with the kernel specific
changes?  I ask b/c I would like to see how you imagine this being used in 
the context of things like device add/remove and other things device driver 
writers would be dealing with it.

Tnx,
~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
