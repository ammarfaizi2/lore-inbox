Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264939AbSKNQJM>; Thu, 14 Nov 2002 11:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264945AbSKNQJM>; Thu, 14 Nov 2002 11:09:12 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:1019 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S264939AbSKNQJL>; Thu, 14 Nov 2002 11:09:11 -0500
Date: Thu, 14 Nov 2002 08:19:20 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: 2.5.47bk2 + current modutils == broken hotplug
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Message-id: <3DD3CD08.7080003@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <20021114111904.9A5312C25F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is about another of the limitations/flaws of the current
module framework, which I'm hoping the new one could fix...


>>Is it true that the infrastructure newly in place can easily be
>>made to provide (from user-space) the policy of "driver remains
>>loaded until the devices it's bound to are all unplugged"?
> 
> 
> That should always be true, unless I'm missing something.  What kind
> of devices?

Any device whose driver gets modprobed through hotplug ... it'd
be good to have the module unload automatically when the hardware
is gone.  The pcmcia tools do this already, with a more limited
problem domain, by tracking device-to-driver associations in the
kernel.  But other hotpluggable frameworks can't do it today, and
it seems to be the module framework which gets in the way.


Consider two instances of such a device.  Hotplug one, the driver
is loaded, refcount zero since it's not opened.  Then rmmod on
unplug would be appropriate:  the hardware is gone.

But instead of unplugging it, plug in a second.  Now rmmod is no
longer an appropriate default policy on unplug, even though the
module "refcount" is still zero, since the user could still try
access the other device.  (Maybe they were plugging in devices
until they found the one with the data they were after, and just
hadn't looked at that the other one yet.)


It's a case where the current modprobe/rmmod scheme is counting
the wrong kinds of things.  Changing module refcounts to track the
device bindings would be a "hard" policy, interfering with driver
developer and sysadmins (gotta reboot or unplug to change drivers).
Tracking such device-to-driver bindings in userland is fragile.
Today's workaround is not to rmmod ... an undesirable answer.

So I keep thinking the right answer is to have a separate count
to track hardware bindings, or at any rate some "soft" policy
hook is needed to prevent rmmod in such cases.  Sysadmins and
driver developers would be able to override the policy, but
Joe Tux-user would just stick to the default.

- Dave


>>That'd be a user-friendly policy, but we'd still need to handle
>>today's developer-oriented "sysadmin can always remove module"
>>policy.  (Me, I'd run with the "user friendly" policy except
>>when hacking a driver.  Then I'd debug/rmmod/update/modprobe.)
> 
> 
> rmmod -f is about as unfriendly as you can get, really 8)
> 
> Cheers,
> Rusty.
> --
>   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
> 



