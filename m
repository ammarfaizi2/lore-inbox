Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275804AbTHOIv4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 04:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275805AbTHOIv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 04:51:56 -0400
Received: from AMarseille-201-1-4-67.w217-128.abo.wanadoo.fr ([217.128.74.67]:17191
	"EHLO gaston") by vger.kernel.org with ESMTP id S275804AbTHOIvy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 04:51:54 -0400
Subject: Re: [PATCH] call drv->shutdown at rmmod
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Greg KH <greg@kroah.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0308140929180.916-100000@localhost.localdomain>
References: <Pine.LNX.4.33.0308140929180.916-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060937467.13316.39.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 15 Aug 2003 10:51:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You're assuming that a driver can always bring a device out a shutdown
> state. That's one of the things we talked about at OLS, and the other half
> of the justification behind such a feature, not just making sure the
> device is queisced. Your argument against my suggestion are some of the
> same arguments for a feature like you're introducing. 

There is a problem of semantics here. Is shutdown() supposed to shutdown
the hardware device (ie. low power) or just the driver ? If yes, then
it's duplicate of the PM callbacks. My understanding of the shutdown()
callback is that it was more than "stop driver activity, put device into
idle state" to prepare for a shutdown/reboot (though we do also sleep
IDE drives in this case, but this is because of that nasty cache flush
issue).

The problem with kexec is just that. What it needs isn't low power devices,
it needs device back in "idle" state, but if possible powered up (or at
least in whatever state the driver found them on boot). The most important
thing is to actually stop pending bus mastering activities.

On PPC, we have a name for that which comes from Open Firmware (since we
need to ask the firmware to stop bus mastering & idle devices the same way
when we take over it and before we get control of the system memory) and
it's called "quiesce".

Ben.

