Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVCYJWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVCYJWn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 04:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVCYJWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 04:22:43 -0500
Received: from mx1.suse.de ([195.135.220.2]:58821 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261558AbVCYJWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 04:22:40 -0500
Message-ID: <4243D854.2010506@suse.de>
Date: Fri, 25 Mar 2005 10:22:28 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Isaacson <adi@hexapodia.org>
Cc: dtor_core@ameritech.net, kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
References: <20050323184919.GA23486@hexapodia.org> <4242CE43.1020806@suse.de> <20050324181059.GA18490@hexapodia.org> <4243252D.6090206@suse.de> <20050324235439.GA27902@hexapodia.org>
In-Reply-To: <20050324235439.GA27902@hexapodia.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson wrote:

> OK, anything else I should try?

not really, i just wait for Vojtech and Pavel :-)

> Why does it only fail when I have *both* intel_agp and i8042 aux?

later...

> In the SysRq-T trace I see one interesting process: most things are
> in D state in refrigerator(), but sh shows the following traceback:
> 
> wait_for_completion
> call_usermodehelper
> kobject_hotplug
> kobject_del
> class_device_del
> class_device_unregister
> mousedev_disconnect
> input_unregister_device
> alps_disconnect
> psmouse_disconnect
> serio_driver_remove
> device_release_driver
> serio_release_driver

i think the following happens (but i am in no case an expert for this):
 - alps driver suspends
 - alps driver unregisters the device
 - udev is called via call_usermodehelper (which fails since userspace
   is stopped)
 - now somebody wants to wait for udev which does not work right.

Why only with the ALPS driver and intel_agp?
I think this is an accident. For me, it happens only with init=/bin/bash
and _no_ other drivers loaded (only IDE drivers and psmouse built-in).
As soon as i load any other drivers (i have only tried ehci_hcd and
8139too, to be honest) it works fine again. This leads me to believe it
is a race condition since the extra driver that has to be suspended may
give the ALPS driver the extra time needed to finish the race. For you,
it may be the other way round.

This is mostly guesswork, i am no kernel expert at all.
-- 
seife
                                 Never trust a computer you can't lift.
