Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWAFANL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWAFANL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWAFANL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:13:11 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62653 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932311AbWAFANI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:13:08 -0500
Date: Fri, 6 Jan 2006 01:12:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       Andrew Morton <akpm@osdl.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Message-ID: <20060106001252.GE3339@elf.ucw.cz>
References: <20060104213405.GC1761@elf.ucw.cz> <Pine.LNX.4.50.0601051329590.17046-100000@monsoon.he.net> <20060105215528.GF2095@elf.ucw.cz> <20060105221334.GA925@isilmar.linta.de> <20060105222338.GG2095@elf.ucw.cz> <20060105222705.GA12242@isilmar.linta.de> <20060105230849.GN2095@elf.ucw.cz> <20060105234629.GA7298@isilmar.linta.de> <20060105235838.GC3339@elf.ucw.cz> <Pine.LNX.4.50.0601051602560.10428-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.50.0601051602560.10428-100000@monsoon.he.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 05-01-06 16:04:07, Patrick Mochel wrote:
> 
> On Fri, 6 Jan 2006, Pavel Machek wrote:
> 
> > On Pá 06-01-06 00:46:29, Dominik Brodowski wrote:
> > > On Fri, Jan 06, 2006 at 12:08:49AM +0100, Pavel Machek wrote:
> > > > Ok, so lets at least add value-checking to .../power file, and prevent
> > > > userspace see changes to PM_EVENT_SUSPEND value. 2 and 0 are now
> > > > "arbitrary cookies". I'd like to use "on" and "off", but pcmcia
> > > > apparently depends on "2" and "0", so...
> > > >
> > > > Any objections?
> > >
> > > Sorry, but yes -- the same as before, minus the PCMCIA breakage.
> >
> > I don't understand at this point.
> >
> > Current code takes value from user, and passes it down to driver,
> > without any checking. If user writes 666 into the file, it will
> > happily pass down 666 to the driver. Driver does not expect 666 in
> > pm_message_t.event. It may oops, BUG_ON() or anything like that.
> >
> > Shall I change
> >
> > #define PM_EVENT_SUSPEND 2
> >
> > to
> >
> > #define PM_EVENT_SUSPEND 1324
> >
> > to get my point across? This is kernel-specific value, it should not
> > be exported to userland.
> 
> A better point, and one that would actually be useful, would be to remove
> the file altogether. Let Dominik export a power file, with complete
> control over the values, for each pcmcia device. Then you never have to
> worry about breaking PCMCIA again.

Fine with me.

[except that now you we went from supporting 2 runtime device states
to supporting just 1... I don't think this is much of progress...]

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -6,49 +6,6 @@
 #include <linux/string.h>
 #include "power.h"
 
-
-/**
- *	state - Control current power state of device
- *
- *	show() returns the current power state of the device. '0' indicates
- *	the device is on. Other values (1-3) indicate the device is in a low
- *	power state.
- *
- *	store() sets the current power state, which is an integer value
- *	between 0-3. If the device is on ('0'), and the value written is
- *	greater than 0, then the device is placed directly into the low-power
- *	state (via its driver's ->suspend() method).
- *	If the device is currently in a low-power state, and the value is 0,
- *	the device is powered back on (via the ->resume() method).
- *	If the device is in a low-power state, and a different low-power state
- *	is requested, the device is first resumed, then suspended into the new
- *	low-power state.
- */
-
-static ssize_t state_show(struct device * dev, struct device_attribute *attr, char * buf)
-{
-	return sprintf(buf, "%u\n", dev->power.power_state.event);
-}
-
-static ssize_t state_store(struct device * dev, struct device_attribute *attr, const char * buf, size_t n)
-{
-	pm_message_t state;
-	char * rest;
-	int error = 0;
-
-	state.event = simple_strtoul(buf, &rest, 10);
-	if (*rest)
-		return -EINVAL;
-	if (state.event)
-		error = dpm_runtime_suspend(dev, state);
-	else
-		dpm_runtime_resume(dev);
-	return error ? error : n;
-}
-
-static DEVICE_ATTR(state, 0644, state_show, state_store);
-
-
 /*
  *	wakeup - Report/change current wakeup option for device
  *
@@ -122,7 +79,6 @@ static DEVICE_ATTR(wakeup, 0644, wake_sh
 
 
 static struct attribute * power_attrs[] = {
-	&dev_attr_state.attr,
 	&dev_attr_wakeup.attr,
 	NULL,
 };

-- 
Thanks, Sharp!
