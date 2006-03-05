Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbWCEPJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWCEPJK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 10:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWCEPJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 10:09:09 -0500
Received: from tim.rpsys.net ([194.106.48.114]:53927 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751435AbWCEPJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 10:09:09 -0500
Subject: RFC: Backlight Class sysfs attribute behaviour
From: Richard Purdie <rpurdie@rpsys.net>
To: "Antonino A. Daplas" <adaplas@gmail.com>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Andrew Zabolotny <zap@homelink.ru>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 05 Mar 2006 15:08:53 +0000
Message-Id: <1141571334.6521.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At present, the backlight class presents two attributes to sysfs,
brightness and power. I'm a little confused as to whether these
attributes are currently doing the right things.

Taking brightness, at any one time we have several different brightness
values:

* User requested brightness (echo y > /sys/class/backlight/xxx/brightness)
* Driver determined brightness which accounts for things like FB 
  blanking, low battery backlight limiting (an example from corgi_bl), 
  user requested power state, device suspend/resume.

The solution might be to have brightness always return the user
requested value y and have a new attribute returning the brightness as
determined by the driver once it accounts for all the factors it needs
to consider. Naming of such an attribute is tricky - "driver_brightness"
perthaps?

The same problem applies to the power attribute. This could easily
confused with the other forms of power attribute in sysfs but ignoring
that, should this report:

* The last user requested power state
* The current power state accounting for FB blanking.
* The current power state for device suspend/resume

Should the FB blanking override the user requested values? At the moment
it only does unless a user changes an attributes whilst the display is
blanked in which case the user's change overrides. This could be classed
as a bug but solving it as straight forward as it sounds using only the
existing backlight class functions.

Also, at the moment this attribute reports VESA power states which can
be confusing (0 = on, [1-3] = off).

Again, the solution would appear to be to return the last user requested
power state. The driver_brightness attribute would tell you if the
display was blanked for any other reason (although not why).

I have various patches that implement these changes but before I finish
them, does anyone have an views on what the correct behaviour should be?

Richard


