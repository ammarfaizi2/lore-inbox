Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266837AbUIOQnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266837AbUIOQnM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 12:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266820AbUIOQmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 12:42:52 -0400
Received: from mail.gmx.de ([213.165.64.20]:29360 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266244AbUIOQlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 12:41:25 -0400
X-Authenticated: #1725425
Date: Wed, 15 Sep 2004 18:51:16 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: "Giacomo A. Catenazzi" <cate@debian.org>
Cc: tonnerre@thundrix.ch, icampbell@arcom.com, greg@kroah.com, md@Linux.IT,
       linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
Message-Id: <20040915185116.24fca912.Ballarin.Marc@gmx.de>
In-Reply-To: <4148637F.9060706@debian.org>
References: <41474926.8050808@nortelnetworks.com>
	<20040914195221.GA21691@kroah.com>
	<414757FD.5050209@pixelized.ch>
	<20040914213506.GA22637@kroah.com>
	<20040914214552.GA13879@wonderland.linux.it>
	<20040914215122.GA22782@kroah.com>
	<20040914224731.GF3365@dualathlon.random>
	<20040914230409.GA23474@kroah.com>
	<414849CE.8080708@debian.org>
	<1095258966.18800.34.camel@icampbell-debian>
	<20040915152019.GD24818@thundrix.ch>
	<4148637F.9060706@debian.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004 17:45:03 +0200
"Giacomo A. Catenazzi" <cate@debian.org> wrote:

> It is right.
> But an option --wait would be sufficient.
> This option will require modprobe to wait (with a timeout of
> x seconds) that hotplug event finish (so if device is created or
> not is no more a problem).
> Ideally this should be done modifing only hotplug and IMHO
> should be enabled by default.

At the moment th hotplug event finishes nothing is guaranteed. In fact,
the device node is never created at this point. All you know is that udev
will now *begin* to create the node. You don't know how long it will take
or if it will succeed at all.
As i understand, udev definitely has to be involved in this process. It
would need a way to inform modprobe of its state.

Maybe something like an udev state could be added. The script would
pass a cookie to modprobe, which would in turn pass it to the kernel (or
to udevd?), which would add it to the hotplug event. udev would then place
the cookie in a defined file that is checked by modprobe. If that cookie's
state is set to "done" modprobe would return and the script would
continue.

Example:
modprobe blah -c cookie-123
"cookie-123" is passed to the kernel and returned by all hotplug events
this modprobe triggers.
udev will then place something like "cookie-123=>processing" in
/dev/udev-state.
modprobe is still running and will poll this file until it contains
"cookie-123=>finished". When that happens modprobe will tell udevd to
remove this entry and return succesfully. If the timeout is reached
modprobe will return an error code instead.

(Of course, modprobe could handle the cookie generation internally.)

This sound complicated and requires changes in many places. Maybe there is
an easier solution.

Regards
