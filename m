Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263585AbUFCMV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbUFCMV0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 08:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263603AbUFCMV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 08:21:26 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:33680 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S263585AbUFCMVV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 08:21:21 -0400
To: Tuukka Toivonen <tuukkat@ee.oulu.fi>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: SERIO_USERDEV patch for 2.6
References: <xb7r7t2b3mb.fsf@savona.informatik.uni-freiburg.de>
	<20040530111847.GA1377@ucw.cz>
	<xb71xl2b0to.fsf@savona.informatik.uni-freiburg.de>
	<20040530124353.GB1496@ucw.cz>
	<xb7aczq9he1.fsf@savona.informatik.uni-freiburg.de>
	<20040530134246.GA1828@ucw.cz>
	<Pine.GSO.4.58.0406011105330.6922@stekt37>
	<Pine.GSO.4.58.0406031241330.8752@stekt37>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 03 Jun 2004 14:21:14 +0200
In-Reply-To: <Pine.GSO.4.58.0406031241330.8752@stekt37>
Message-ID: <xb74qps4yth.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Tuukka" == Tuukka Toivonen <tuukkat@ee.oulu.fi> writes:


    >> On Sun, 30 May 2004, Vojtech Pavlik wrote:
    >>> Coexisting would mean that when someone wants to open the raw
    >>> device, the serio layer would disconnect the psmouse driver,
    >>> and give control to the raw device instead. I believe that
    >>> could work.

    Tuukka> Done, with slight modification: if the device is opened in
    Tuukka> read-only mode, the kernel drivers are not
    Tuukka> disconnected. This way the serio port could be controlled
    Tuukka> via IOCTL even when assigned to kernel drivers, if it ever
    Tuukka> becomes useful. Useful also for debugging etc.

Thanks for the great work, Tuukka!  :)

I've  just   tried  it.   I   loaded  'psmouse'  and   'mousedev'  and
/proc/bus/input/devices does show the PS/2 AUX port being treated as a
mouse  device,   handled  by  'mousedev'.    Then,  I  start   gpm  on
/dev/misc/isa0060_serio1, and it works successfully.  The mouse device
disappears from /proc/bus/input/devices.  When  I kill gpm, the kernel
gets  control   again  and  the   mouse  device  shows  up   again  in
/proc/.../devices.



    Tuukka> The last change I made converts slashes '/' into
    Tuukka> underscores '_' (so eg. isa0060/serio0 is changed to
    Tuukka> isa0060_serio0 in /proc/misc, /dev with devfs, and /sys)
    Tuukka> because Sau Dan Lee reported that slashes don't work well
    Tuukka> with sysfs.

It now works in sysfs.

        $ cat /sys/class/misc/psaux/dev 
        10:1
        $ cat /sys/class/misc/isa0060_serio1/dev 
        10:63


    Tuukka> I tested the patch in a couple of machines, especially the
    Tuukka> new features.  Seems to work finely.

Works fine on mine, too.



    Tuukka> Compared to Dmitry's rawdev patch, this has a number of
    Tuukka> advantages:

    Tuukka> - Supports all serio ports without any additional kernel
    Tuukka> parameters. Binding between kernel/user driver is done
    Tuukka> automatically.

This is wonderful!  Or consider  my serio_switch patch.  We don't need
to want for  2.6.10 when they would eventually  add that together with
the sysfs interface.


    Tuukka> - Supports multiple drivers on the same port, unlike
    Tuukka> Dmitry's rawdev, which works just similarly as 2.4.x psaux
    Tuukka> which didn't work with e.g.  X11 and gpm together without
    Tuukka> a repeater feed, because multiple drivers are fighting for
    Tuukka> the byte streams.

On my system X and gpm do live with each other without conflicts, both
accessing  /dev/psaux  (either  on  2.4 or  2.6+SERIO_USERDEV).   Both
programs  can detect  VT  switching  and close  the  port when  losing
"focus".


    Tuukka> (Doesn't still allow multiple kernel drivers nor a kernel
    Tuukka> driver with a complete user drivers with write access
    Tuukka> since the required infrastructure is missing in serio.c
    Tuukka> aka serio-core.c: kernel internal drivers can't lock a
    Tuukka> port).

That's a part of the design  of the whole serio subsystem.  Unless the
design is reworked, you can't  do much about it.  The basic assumption
is: each port can be connected  to only one device, whether the device
is in kernel  or userland.  That our SERIO_USERDEV  allows userland to
overhear (O_RDONLY) the traffic is a special bonus feature.



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

