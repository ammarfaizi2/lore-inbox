Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbUD1Xjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbUD1Xjp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 19:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUD1Xjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 19:39:44 -0400
Received: from mail.kroah.org ([65.200.24.183]:42669 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261497AbUD1Xjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 19:39:42 -0400
Date: Wed, 28 Apr 2004 16:38:13 -0700
From: Greg KH <greg@kroah.com>
To: Brian King <brking@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: userspace pci config space accesses
Message-ID: <20040428233812.GA365@kroah.com>
References: <409026CE.8050905@us.ibm.com> <20040428225236.GA27250@kroah.com> <40903DBD.1000704@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40903DBD.1000704@us.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 06:26:53PM -0500, Brian King wrote:
> Greg KH wrote:
> >On Wed, Apr 28, 2004 at 04:49:02PM -0500, Brian King wrote:
> >
> >>I recently ran into a problem where lspci was trying to read pci config 
> >>space
> >>of a pci adapter while the device driver for that adapter was running BIST
> >>on it. On ppc64, this resulted in a PCI error and puts the slot into an 
> >>error state making it unusable for the remainder of that system boot.
> >>Should there be some blocking in place so that userspace pci config
> >>reads will not occur in these windows or is using tools like lspci
> >>user beware?
> >
> >
> >There already is a pci_config_lock that should be grabbed when accessing
> >pci config space.  It sounds like the driver needs to play a bit nicer
> >when it's running a self test :)
> 
> Found the lock. Unfortunately, its not exported, so a device driver can't 
> use it without changing that. Additionally, its a spinlock, and it
> takes 2 seconds to complete BIST, which seems a bit too long to hold a
> spinlock.

Yes, a driver shouldn't mess with that lock anyway.  I was pointing out
that there is already a lock to prevent reading and writing config
errors from happening.

> >What driver is doing this?
> 
> The ipr driver, a scsi device driver for ppc64.
> 
> http://marc.theaimsgroup.com/?l=linux-scsi&m=108144942527994&w=2
> 
> The driver runs BIST at device initialization time to ensure that the device
> is in a clean state.

Ick.  It sounds like "clean state" isn't always true if userspace can
mess the device up by simply reading its config space :)

Worse case thing, stop the whole machine while doing BIST if you want to
prevent this from happening (not that I'm actually suggesting you do it,
but if you really think it's the only way...)

Is there any way you can not run BIST all the time, except when
explicitly asked for from the user?

thanks,

greg k-h
