Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWGDQXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWGDQXz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 12:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWGDQXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 12:23:55 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:2795 "EHLO
	out3.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932269AbWGDQXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 12:23:54 -0400
X-Sasl-enc: 9Eyu70KPpfaLZCtn6e29t/pGfD3//zkwdXmovlu+QQ7M 1152030231
Date: Tue, 4 Jul 2006 13:23:46 -0300
From: Henrique de Moraes Holschuh <hmh@debian.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net, Stelian Pop <stelian@popies.net>,
       Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: Generic interface for accelerometers (AMS, HDAPS, ...)
Message-ID: <20060704162346.GE9447@khazad-dum.debian.net>
References: <20060703124823.GA18821@khazad-dum.debian.net> <20060704075950.GA13073@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060704075950.GA13073@elf.ucw.cz>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jul 2006, Pavel Machek wrote:
> Just use input infrastructure and be done with that? You can do
> parking from userspace.

The command to execute the freeze (and for how long) can certaily come from
userspace, and the logic behind that command can be an userspace
high-priority task, yes (that's how it is done in HDAPS anyway).  However,
to implement the disk head unload you need kernel code (you need to freeze
the IO queues for a while too, not just unload the heads).

Anyway, the input infrastructure is good to emulate a mouse/joystick, but we
probably want to support the following generic data channels:

1. Absolute acceleration output stream (either in hardware units, or
   normalized to G or mG if at all possible) for X, Y, Z.  Does the input
   infrastructure work well for reporting absolute numbers in a reasonably
   constant rate?
   
   This is what HD head unload policy daemons want to know, and the stream
   usually needs to offer datapoints somewhere between 20Hz and 100Hz
   without excessive jitter to be useful for more advanced filtering (like
   masking-off periodic movement such as the one caused by train tracks).

2. As easy-to-use as possible joystick and mouse emulation (for toys and 
   gaming), which probably means auto-calibrating ones when possible
   and thus making them unsuitable channels for (1) above.

3. Control of accelerometer parameters:
   3a. Report of accelerometer type (hdaps, ams, etc) and other metadata
       (name, location, what it is measuring (system accel, hd-bay 
       accel...))
   3b. Accelerometer polling frequency
   3c. Enable/disable joystick and mouse emulation control
   etc.

And, of course, userspace must be able to easily find the accelerometer
outputs and diferentiate them from other joystick/mouse interfaces.  This is
a task for udev, I suppose.

It is also very helpful to be able to know when something is using any of
the accelerometer output channels, so as to shut it down (or stop talking to
it) when it is uneeded.  I don't know about AMS, but talking to HDAPS when
you don't need to does waste enough system resources and power to actually
justify implementing this.

If we cannot detect automatically when userspace is paying attention to the
accelerometer through the input layer, then that means we will need the
enable/disable functionality already provided by the device model through
sysfs.

> Only piece of puzzle missing is marking that input device as "this
> accelerometer actually watches the whole device".

Well, it is very important to be able to easily find all data and channels
pertaining for a given accelerometer, and the accelerometer metadata should
indeed give userspace an idea of WHAT it is measuring the acceleration of
:-)

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
