Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVC2SS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVC2SS7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 13:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVC2SS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 13:18:59 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43490 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261288AbVC2SSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 13:18:44 -0500
Date: Tue, 29 Mar 2005 20:18:31 +0200
From: Pavel Machek <pavel@suse.cz>
To: dtor_core@ameritech.net
Cc: Stefan Seyfried <seife@suse.de>, Andy Isaacson <adi@hexapodia.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Message-ID: <20050329181831.GB8125@elf.ucw.cz>
References: <20050323184919.GA23486@hexapodia.org> <4242CE43.1020806@suse.de> <20050324181059.GA18490@hexapodia.org> <4243252D.6090206@suse.de> <20050324235439.GA27902@hexapodia.org> <4243D854.2010506@suse.de> <d120d50005032908183b2f622e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50005032908183b2f622e@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > In the SysRq-T trace I see one interesting process: most things are
> > > in D state in refrigerator(), but sh shows the following traceback:
> > >
> > > wait_for_completion
> > > call_usermodehelper
> > > kobject_hotplug
> > > kobject_del
> > > class_device_del
> > > class_device_unregister
> > > mousedev_disconnect
> > > input_unregister_device
> > > alps_disconnect
> > > psmouse_disconnect
> > > serio_driver_remove
> > > device_release_driver
> > > serio_release_driver
> > 
> > i think the following happens (but i am in no case an expert for this):
> > - alps driver suspends
> > - alps driver unregisters the device
> > - udev is called via call_usermodehelper (which fails since userspace
> >   is stopped)
> > - now somebody wants to wait for udev which does not work right.
> 
> The thing is that kobject_uevent calls call_usermodehelper with
> wait=0. That means that it conly waits for execve("/sbin/hotplug")
> call to complete, it does not wait for the entire process ti complete.
> 
> If you look at Andy's second trace you will see that we are waiting
> for the disk I/O to get /sbin/hotplug from the disk. Pavel, do you
> know why IO does not complete? khelper is a kernel thread so it is
> marked with
> PF_NOFREEZE. Could it be that we managed to freeze kblockd?

Uf, no idea about kblockd freezing -- we certainly should not.

*But*, if we are doing execve while system is frozen, something is
very wrong. We should not be doing execve in the first place.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
