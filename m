Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755168AbWKMP6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755168AbWKMP6F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 10:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755173AbWKMP6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 10:58:04 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:2457 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1755168AbWKMP6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 10:58:04 -0500
Date: Mon, 13 Nov 2006 10:57:58 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: David Brownell <david-b@pacbell.net>
cc: arvidjaar@mail.ru, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.6.19-rc5 regression: can't disable OHCI
 wakeup via sysfs
In-Reply-To: <200611121521.22105.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.44L0.0611131040590.2260-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Nov 2006, David Brownell wrote:

> > Or are you trying to say that the original device_may_wakeup() value would 
> > be 0 if the bug were detected?
> 
> The latter:  device_may_wakeup() never returns true.  There are three paths
> for that:
> 
>   (a) userspace workaround, which is the regression that was reported;
>   (b) the AMD 756 workaround, and
>   (c) that board-specific quirk code.
> 
> Of course (c) hasn't been submitted yet because it didn't work ... evidently
> because of the regression where device_may_wakeup(root_hub) was ignored.

Well, I would argue that part of the problem has to do with the use of 
device_may_wakeup.  It is tied to a sysfs API and therefore administrative 
in nature, but now you say it's also being used to record hardware quirks.

> > If you think autostop should also check for device_may_wakeup(), I'll make 
> > it do so.  Remember though that autostop is intended to work even when 
> > CONFIG_PM is off.
> 
> The original autosuspend logic would never kick in without PM; after all,
> it's purely a power saving mechanism!  And testing device_may_wakeup() will
> be restoring that behavior, since without PM that's always false.

It would restore that behavior, and it would be silly way of doing so.  
There are better ways to prevent autostop without PM, such as making
ohci_rh_suspend() and ohci_rh_resume() depend on CONFIG_PM!

However it was always my intention that autostop should operate without
PM.  It's not only about saving power, it also is about reducing load on
system resources -- primarily DMA, although this may be a lot less severe
with OHCI than with UHCI.  Does OHCI do any DMA at all when no devices are
plugged in and the schedule is empty?

My quick impression from the spec is that it does not, in which case 
there is no point in keeping autostop when CONFIG_PM is off.

Alan Stern

