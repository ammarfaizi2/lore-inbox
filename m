Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262143AbUKDJVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbUKDJVd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 04:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbUKDJVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 04:21:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18398 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262143AbUKDJUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 04:20:15 -0500
Date: Thu, 4 Nov 2004 01:19:32 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Wolfgang Scheicher <worf@sbox.tu-graz.ac.at>, linux-kernel@vger.kernel.org,
       zaitcev@redhat.com
Subject: Re: 2.6.9 USB storage problems
Message-ID: <20041104011932.0b5d2aae@lembas.zaitcev.lan>
In-Reply-To: <41895583.10604@tmr.com>
References: <200410121424.59584.worf@sbox.tu-graz.ac.at>
	<20041101164615.13a04a7c@lembas.zaitcev.lan>
	<41895583.10604@tmr.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Nov 2004 17:02:43 -0500, Bill Davidsen <davidsen@tmr.com> wrote:

> I just got information on this in another thread, in case you didn't see 
> my note there, is this behaviour a bug, design choice, or unavoidable 
> hardware issue? I can turn it off now, but I'm supposed to be getting a 
> flash key thing to test, which is why I turned it on in the first place.

The explanation may be a little long.

On most distributions, drivers are loaded with hotplug. Nobody, and I do
mean it, for all practical reasons nobody loads their drivers from
/etc/rc.d/rc.local anymore. (Side note: it is possible to load ub from
/etc/modprobe.conf, but not usb-storage, because of too many layers
between a block device and usb-storage: an open is a non-event there)

The hotplug is controlled by match lists, generated from C source (indirectly;
actually from object files, compiled from C source). This way, what is loaded
by hotplug would match what is present if same things were linked in, among
other things. The hotplug has no preference mechanism aside from hand-editing
those match lists. They have to be non-conflicting.

Given the above, it's hurtful to allow drivers to conflict, so such conflicts
are rare. I know of bcm5700 vs. tg3, eepro100 vs. e100, 812x vs 8130too.
AFAIK, in all such cases if one is configured, another cannot be configured
and vice versa. The USB contains an exception, curiously enough. In 2.4
kernels, it was possible to configure both uhci (ALT) and usb-uhci as
modules. It was annoying; Red Hat resolved it by loading usb-uhci from
/etc/rc.d/rc.sysinit (also marked in /etc/modules.conf, but that was
just a tag for kudzu and other tools).

So, when ub is configured to service certain classes of devices, usb-storage
relinquishes its control of them, resolving the conflict. This is assymmetric
in its implementation, but it's an artefact; no implication is made about
which driver is first among equals. In an ideal world we'd have something
like CONFIG_USB_STORAGE_PREF with two values "ub" and "usb-storage", or such.

I thought about the coexistence between the two at some length, and it seems
to me that the current scheme is the simplest workable scheme. I even thought
it as "least confusing" until messages from Wolfgang and others made it clear
that relationship between ub and usb-storage is not obvious enough to them.
I'm always open to patches, too.

-- Pete
