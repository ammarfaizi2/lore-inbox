Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752288AbWCFIpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288AbWCFIpp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 03:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752290AbWCFIpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 03:45:45 -0500
Received: from tim.rpsys.net ([194.106.48.114]:14209 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1752288AbWCFIpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 03:45:44 -0500
Subject: Re: RFC: Backlight Class sysfs attribute behaviour
From: Richard Purdie <rpurdie@rpsys.net>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Andrew Zabolotny <zap@homelink.ru>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <440B89AB.3020203@gmail.com>
References: <1141571334.6521.38.camel@localhost.localdomain>
	 <440B89AB.3020203@gmail.com>
Content-Type: text/plain
Date: Mon, 06 Mar 2006 08:45:28 +0000
Message-Id: <1141634729.6524.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-06 at 09:00 +0800, Antonino A. Daplas wrote:
> Why not just agree on a normal range of values (ie, 0-255), and let the
> driver "denormalize" them?  Thus, a driver that has only 2 levels of
> brightness, will treat 0-127 as 0 and 128-255 as 1, and will return only
> two possible values 0 and 255.
>
> If a user requests max brightness (255), and the driver is capable of setting
> it, then it returns 255.  But if for some reason it can't (ie low power state),
> it returns the current max brightness, normalized, (ie 128 instead of 255 and
> because that the scale is 0-255, a value of 128 tells the user that only
> half of max brightness was set).

We already have a max_brightness attribute and brightness can vary
between 0 and max_brightness (hence avoiding scaling issues which we
leave to userspace).

> And instead of a new "driver_brightness" attribute, why not just a new
> attribute that returns the number of brightness levels?

The idea of the driver_brightness attribute is to separate the user
requested brightness value from the actual brightness value decided by
the driver. The driver determines the real brightness by combining:

* the user supplied power sysfs attribute
* the user supplied brightness sysfs attribute
* the current FB blanking state
* any other driver specific factors

At present, the user specified values through the sysfs attributes can
easily get lost as other factors overwrite it (FB blanking overwrites
user specified power for example). This leads to a class interface with
unpredictable behaviour.

I'm therefore suggesting separation of the values so each attribute
reads and writes in a predicable manner and the actual state determined
by the driver becomes a new readonly sysfs attribute
("driver_brightness" although I'm open to suggestions of a better name).

Richard

