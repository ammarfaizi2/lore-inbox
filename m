Return-Path: <linux-kernel-owner+w=401wt.eu-S964927AbXALTcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbXALTcR (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 14:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbXALTcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 14:32:17 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:22608 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964927AbXALTcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 14:32:16 -0500
Message-ID: <45A7E23A.6000100@tls.msk.ru>
Date: Fri, 12 Jan 2007 22:32:10 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Thunderbird 1.5.0.5 (X11/20060813)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: /sys/$DEVPATH/uevent vs uevent attributes
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not-so-recently already, device directories in /sys started providing
files like modalias, which corresponds to $MODALIAS env. variable at
uevent time.  Also not-so-recently, uevent file appeared, which, when
written, triggers re-execution of an uevent corresponding to the
device.  So far so good.

But there's an inconsistency at least: why modalias file is here,
while other attributes of an uevent aren't?

If the proper way to refresh everything which has been detected during
kernel boot (before userspace) is to use `uevent' triggers in sysfs,
modalias files aren't needed - proper $MODALIAS will be here when an
event will re-trigger.

But if it's possible to refresh the things  by just walking over /sys
finding all device dirs, modalias file isn't sufficient.

Current udev way of populating /dev at startup looks.. hackish at
least.  We start udevd, and start sending it uevents - all we find
in /sys at that time.  Kernel spews tons of events, and udevd has
to serialize them somehow.  Next, we're waiting for the storm to
calm down, again using a hackish way - by waiting while current
SEQNUM will be the same as last processed by udevd (which might
never be a case by the way, due to, say, udevd crash or somesuch).

What I was thinking is -- how about making uevent file readable
too, to be able to sequentially walk over /sys, read environment
from uevent files, and - again - sequentially execute things with
that environment, without all the hackery currently implemented
in udev, in a stright, clean and understandable way?

Something like:

 . /etc/hotplug/config
 find /sys -name uevent | while read path; do
  ( read x < $path; eval $x; process_event; )

This way, it will also be possible to bring the ol'good
udev-free days back (and did I mention I *detest* udev,
and prefer simple, clean shell script instead, as far as
I'm forced to use something to handle hotplug events?),
without too much speed problems for example...

(No patch at this time, -- just asking about an.. idea ;)

Thanks.

/mjt
