Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVC2QST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVC2QST (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 11:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVC2QSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 11:18:18 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:30198 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261179AbVC2QSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 11:18:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=WMz/tE75JRakoMjcVhprzdHYCz2Nq0JKLDdvYXVWVvO8/bw2ZWWBqN1/iRAu4MdGI6eFEGlYealQuMU14JeAXgtjMf3xKRRhMbOpqZKn1aGX/c9YtYkhRheBHlrkK4iVcgHYKJW3/h/Shjl3a3sPbmmAeZe1iDhl3f1AtYPqX14=
Message-ID: <d120d50005032908183b2f622e@mail.gmail.com>
Date: Tue, 29 Mar 2005 11:18:12 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Stefan Seyfried <seife@suse.de>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Cc: Andy Isaacson <adi@hexapodia.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <4243D854.2010506@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050323184919.GA23486@hexapodia.org> <4242CE43.1020806@suse.de>
	 <20050324181059.GA18490@hexapodia.org> <4243252D.6090206@suse.de>
	 <20050324235439.GA27902@hexapodia.org> <4243D854.2010506@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2005 10:22:28 +0100, Stefan Seyfried <seife@suse.de> wrote:
> Andy Isaacson wrote:
> 
> > In the SysRq-T trace I see one interesting process: most things are
> > in D state in refrigerator(), but sh shows the following traceback:
> >
> > wait_for_completion
> > call_usermodehelper
> > kobject_hotplug
> > kobject_del
> > class_device_del
> > class_device_unregister
> > mousedev_disconnect
> > input_unregister_device
> > alps_disconnect
> > psmouse_disconnect
> > serio_driver_remove
> > device_release_driver
> > serio_release_driver
> 
> i think the following happens (but i am in no case an expert for this):
> - alps driver suspends
> - alps driver unregisters the device
> - udev is called via call_usermodehelper (which fails since userspace
>   is stopped)
> - now somebody wants to wait for udev which does not work right.

The thing is that kobject_uevent calls call_usermodehelper with
wait=0. That means that it conly waits for execve("/sbin/hotplug")
call to complete, it does not wait for the entire process ti complete.

If you look at Andy's second trace you will see that we are waiting
for the disk I/O to get /sbin/hotplug from the disk. Pavel, do you
know why IO does not complete? khelper is a kernel thread so it is
marked with
PF_NOFREEZE. Could it be that we managed to freeze kblockd?

-- 
Dmitry
