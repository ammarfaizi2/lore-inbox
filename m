Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755154AbWKMQjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755154AbWKMQjS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755156AbWKMQjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:39:18 -0500
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:45964 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1755154AbWKMQjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:39:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=upeVYJEXW/78gzRKMuRXmFCUFGptbcZMgtoncRuDUUaZwasTeVQ6vx0TJ4eBqKUGK1pLtRv7aQEC0DfjbU1bfLYnaCDwUlBhM54fYsT+LIIDJEEneVsiPrGW4Fnni+zw2rgoPUvr2JD+ZRYzMxNJbnDfOSdwh+54iXT5G0RVKv8=  ;
From: David Brownell <david-b@pacbell.net>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] 2.6.19-rc5 regression: can't disable OHCI wakeup via sysfs
Date: Mon, 13 Nov 2006 08:39:11 -0800
User-Agent: KMail/1.7.1
Cc: arvidjaar@mail.ru, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0611131040590.2260-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0611131040590.2260-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611130839.11459.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 November 2006 7:57 am, Alan Stern wrote:
> On Sun, 12 Nov 2006, David Brownell wrote:
> 
> > > Or are you trying to say that the original device_may_wakeup() value would 
> > > be 0 if the bug were detected?
> > 
> > The latter:  device_may_wakeup() never returns true.  There are three paths
> > for that:
> > 
> >   (a) userspace workaround, which is the regression that was reported;
> >   (b) the AMD 756 workaround, and
> >   (c) that board-specific quirk code.
> > 
> > Of course (c) hasn't been submitted yet because it didn't work ... evidently
> > because of the regression where device_may_wakeup(root_hub) was ignored.
> 
> Well, I would argue that part of the problem has to do with the use of 
> device_may_wakeup.  It is tied to a sysfs API 

It's a *driver model* API, which is also accessible from sysfs ... to support
per-device policies, for example the (a) workaround.  The mechanism exists
even on kernels that don't include sysfs ... although on such systems, there
is no way for users to do things like say "ignore the fact that this mouse
claims to issue wakeup events, its descriptors lie".


> and therefore administrative  
> in nature, but now you say it's also being used to record hardware quirks.

No; I'm saying the driver model is used to record that the hardware mechanism
isn't available.   The fact that it's because of an implementation artifact
(bad silicon, or board layout, etc) versus a design artifact (silicon designed
without that feature) is immaterial ... in either case, the system can't use
the mechanism.


> > > If you think autostop should also check for device_may_wakeup(), I'll make 
> > > it do so.  Remember though that autostop is intended to work even when 
> > > CONFIG_PM is off.
> > 
> > The original autosuspend logic would never kick in without PM; after all,
> > it's purely a power saving mechanism!  And testing device_may_wakeup() will
> > be restoring that behavior, since without PM that's always false.
> 
> It would restore that behavior, and it would be silly way of doing so.  
> There are better ways to prevent autostop without PM, such as making
> ohci_rh_suspend() and ohci_rh_resume() depend on CONFIG_PM!

ISTR they do that too.  :)

 
> However it was always my intention that autostop should operate without
> PM.  It's not only about saving power, it also is about reducing load on
> system resources -- primarily DMA, although this may be a lot less severe
> with OHCI than with UHCI.  Does OHCI do any DMA at all when no devices are
> plugged in and the schedule is empty?

That's not an issue at all with OHCI; it only DMAs when the relevant
schedule is enabled.  Which it isn't, unless it has work to do.

 
> My quick impression from the spec is that it does not, in which case 
> there is no point in keeping autostop when CONFIG_PM is off.

Exactly.  That's why I said it's purely a power saving mechanism.

- Dave
