Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753329AbWKLV7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329AbWKLV7M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 16:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753309AbWKLV7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 16:59:12 -0500
Received: from mx2.rowland.org ([192.131.102.7]:26379 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1753329AbWKLV7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 16:59:11 -0500
Date: Sun, 12 Nov 2006 16:59:09 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: David Brownell <david-b@pacbell.net>
cc: arvidjaar@mail.ru, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.6.19-rc5 regression: can't disable OHCI 
 wakeup via sysfs
In-Reply-To: <20061112180021.60DE11C6042@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Message-ID: <Pine.LNX.4.44L0.0611121647490.8422-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Nov 2006, David Brownell wrote:

> > Undoubtedly this change in behavior is caused by the "autostop" code I 
> > added to ohci-hcd.  It doesn't check the "wakeup" attribute.
> 
> That's the basic bug ... it needs to do that, like it does in a 2.6.18
> kernel I happen to still have sitting around.

It's not so clear whether this behavior is a bug.  Remember, autostop is 
different from autosuspend.  For instance, the root hub will never be in 
autostop mode during a system sleep (suspend to RAM or suspend to disk) -- 
hence autostop doesn't have to worry about waking up the system.

> > Dave, is there any clue about exactly what triggers the immediate wakeup?  
> > If you could tell me what to test for, I could try writing a patch to fix 
> > it.  Perhaps the driver needs a "resume_detect_is_broken" quirk.
> 
> It's an implementation bug in some silicon, or in some case some boards.
> 
> That's why the original OHCI autosuspend code initialized the "can this
> root hub autosuspend" by testing the root hub wakeup flag:
> 
>         can_suspend = device_may_wakeup(&hcd->self.root_hub->dev);
> 
> and then cleared it if any enabled port wasn't suspended, any schedule
> was active, or any deletions were pending.

But the silicon or board-level implementation bug you mentioned wouldn't 
cause any of those tests to succeed, would it?  Hence it wouldn't prevent 
an unwanted root-hub suspend.

Or are you trying to say that the original device_may_wakeup() value would 
be 0 if the bug were detected?

>   A quick glance at your new
> "autostop" code shows that it only checks whether ports are enabled;
> those other important constraints have been removed.

No, you must have misread the code.  It retains the checks for active 
schedules or pending deletions.  There's no need to check for unsuspended 
enabled ports, since autostop kicks in only when no ports are enabled.

> Knowing this is a regression probably explains why that one patch adding
> the "broken suspend" board-specific quirk for the Tohsiba Portege 4000
> didn't work:  the mechanism it relied on (root hub marked as "can't wakeup")
> is broken.
> 
> I expect the AMD756 erratum 10 workaround is also broken, since that makes
> a point of initializing the root hub so that device_may_wakeup() prevents
> the autosuspend mechanism from kicking in.

If you think autostop should also check for device_may_wakeup(), I'll make 
it do so.  Remember though that autostop is intended to work even when 
CONFIG_PM is off.

Alan Stern

