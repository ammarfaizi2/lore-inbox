Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422893AbWKFAhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422893AbWKFAhV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 19:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422897AbWKFAhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 19:37:21 -0500
Received: from tim.rpsys.net ([194.106.48.114]:22759 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1422888AbWKFAhR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 19:37:17 -0500
Subject: Re: [PATCH] backlight: do not power off backlight when
	unregistering
From: Richard Purdie <rpurdie@rpsys.net>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       Antonino Daplas <adaplas@pol.net>, Holger Macht <hmacht@suse.de>
In-Reply-To: <20061105225429.GE14295@khazad-dum.debian.net>
References: <20061105225429.GE14295@khazad-dum.debian.net>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 00:36:34 +0000
Message-Id: <1162773394.5473.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-05 at 20:54 -0200, Henrique de Moraes Holschuh wrote:
> ACPI drivers like ibm-acpi are moving to the backlight sysfs infrastructure.
> During ibm-acpi testing, I have noticed that backlight_device_unregister()
> sets the display brightness and power to zero.
> 
> This causes the display to be dimmed on ibm-acpi module removal.  It will
> affect all other ACPI drivers that are being converted to use the backlight
> class, as well.
> 
> This annoying behaviour in backlight_device_unregister() can either be
> reverted, or it can be worked around on acpi drivers by doing a
> backlightdevice->props->update_status = NULL before calling
> backlight_device_unregister().
> 
> Given the, AFAIK, lack of a good reason to disable display backlight as the
> _general_ behaviour for the entire sysfs class, the attached patch changes
> backlight.c to not do so anymore.

The reason the corgi code does this is quite simple. If you don't turn
off the backlight when unloading the backlight driver, nothing can turn
the backlight off. The backlight is the biggest power consumer on corgi
and would cause some power drain even if for example you then suspend
the device. I never want to end up with those bug reports. I reasoned
that other devices would have a similar set of constraints (all the
existing users at the time did). On such hardware, deinitialising
anything you initialised is the norm and makes sense but the PC/ACPI
world is different.

Setting backlightdevice->props->update_status = NULL before
unregistering is a horrible idea and I don't want to see hacks like that
so yes, lets move it back into the drivers. 

> Since the commit that introduced this behaviour (commit
> 6ca017658b1f902c9bba2cc1017e301581f7728d) apparently did so because the
> corgi_bl.c driver powered off the backlight, the attached patch also makes
> sure that the corgi_bl.c driver will not have its behaviour changed.

Those commits were designed to standardise several behaviours amongst
several drivers and this specific case was added to the core rather than
coding it in each of several drivers. We therefore really need to update
those other drivers too (locomo at the very least).

Richard


