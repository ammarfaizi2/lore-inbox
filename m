Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753501AbWKLXjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501AbWKLXjj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 18:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753506AbWKLXjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 18:39:39 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:35511 "EHLO
	adelie.ubuntu.com") by vger.kernel.org with ESMTP id S1753501AbWKLXjj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 18:39:39 -0500
Subject: [RFC] Pushing device/driver binding decisions to userspace
From: Ben Collins <ben.collins@ubuntu.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 12 Nov 2006 15:39:22 -0800
Message-Id: <1163374762.5178.285.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email brought to you by Sunday afternoon coding frustration.

As I move forward with Ubuntu's next release, I keep running into very
familiar problems, more and more often. The issues stem from userspace
not having enough control over what the kernel decides to do with a
device, and possible drivers to bind it with.

Here's a common case I'm trying to address:

Driver foo supports devices a, b
Driver bar supports devices    b, c

For devices 'a' and 'c', the answer is simple. The correct driver always
gets loaded. However, the answer is not always simple for device 'b'. At
first glance, you could assume that either driver would be correct, but
that's wrong.

There's two main reasons why foo and bar may not be interchangeable for
device 'b'.

First, foo may not work correctly with all variations of device 'b', and
the same for driver bar. Since driver loading and binding only works
based on the identity 'b', there's no more information to base the
decision on, other than the user deciding it for us.

Secondly, foo and bar may be different ways of handling the same device.
An example that comes to mind is a bt878 chipset where the audio portion
can be handled by a media driver or a sound driver. The user has to
decide which driver they want handling that device based on how they use
it.

So this then becomes a decision that the kernel cannot make. As a
distro, we have to provide both drivers, but the endless support for
people who have broken systems because driver foo doesn't work with
their device, or because driver foo doesn't use their device in the way
they want, are having to be told to blacklist foo so bar will be used.

I don't think blacklisting is very ideal. For example let's say they
have device 'a' and 'b'. Since 'a' needs foo, we then need to tell them
how to make sure bar gets loaded first (usually by force loading rather
than the tidy udev handling) so that their 'b' device binds with it
first.

If this is a hot-pluggable device, they're just fucked. If both drivers
are already loaded into the kernel, userspace has no control over which
one the kernel decides to bind with, and the kernel doesn't have all the
info needed.

Either way, we've butchered their system to work around a lack of
functionality. Upgrades are likely going to be broken, or become
difficult, etc.

So my ultimate goal is to somehow move this decision making to udev. My
plan is something along these lines:

- udev is started, and if it supports this new model, somehow tells the
driver core to disable its internal binding of drivers.

- udev gets notification of new device

- udev loads all drivers capable of handling device (if it doesn't
support this new model, then it works like it used to, and the next step
is skipped).

- udev checks it's rules, if a specific driver is requested for a
device, emit a sysfs write to bind with it. If no driver specific
request is made, then emit an "any" bind, to let the kernel do whatever
it wants.

Internally in the kernel, binding would still be enforced by driver core
matching/probing. The above setup would also intermix well with udev
rules that forced binding (e.g. new_id for PCI drivers/devices).

What I haven't done is figure out what this interface between udev and
driver core will look like.

Comments welcome. And if there's already a clean way to do this that I
just don't know about, please kick me toward it.

