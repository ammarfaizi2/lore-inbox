Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUISUmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUISUmK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 16:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUISUmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 16:42:10 -0400
Received: from pop.gmx.net ([213.165.64.20]:49082 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263795AbUISUlz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 16:41:55 -0400
X-Authenticated: #7318305
Date: Sun, 19 Sep 2004 22:44:24 +0200
From: Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: benh@kernel.crashing.org, keithp@keithp.com,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Design for setting video modes, ownership of sysfs attributes
Message-Id: <20040919224424.72457afe.felix@trabant>
In-Reply-To: <9e47339104091909465c9a483f@mail.gmail.com>
References: <9e47339104091811431fb44254@mail.gmail.com>
	<1095569137.6580.23.camel@gaston>
	<9e47339104091909465c9a483f@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2004 12:46:13 -0400
Jon Smirl <jonsmirl@gmail.com> wrote:

> On Sun, 19 Sep 2004 14:45:37 +1000, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > One issue here... When we discussed all of this with Keith, we wanted
> > a mecanism where the user can set the mode without "owning" the device.
> 
> The owning part is for multiuser systems. If I have four users logged
> into the same system I have to assign them ownership of their video
> devices so that they can't mess with each other.  I want to avoid
> needing root priv to change the monitor mode.
> 
> > Typically, with X: We don't want X itself to have to be the one setting
> > the mode, but rather set the mode and have X be notified properly before
> > and after it happens so it can "catch up".
> 
> This is going to require some more thought. Mode setting needs two
> things, a description of the mode timings and a location of the scan
> out buffer.  With multiple heads you can't just assume that the buffer
> starts at zero.  There also the problem of the buffer increasing in
> size and needing to be moved since it won't fit where it is.
> 
> Keith, how should this work for X? We have to make sure all DRI users
> of the buffer are halted, get a new location for the buffer, set the
> mode, free the old buffer, notify all of the DRI clients that their
> target has been wiped and has a new size.

Sounds a lot like moving and resizing GL windows in X. A similar (if not
the same mechanism) could be used here. Whenever a client takes the lock
and detects that someone else had the lock in the mean time it checks
for a new window position and size. Checking for a changed mode or frame
buffer layout would fit in nicely. AFAIK these kind of changes are
communicated through the sarea which is shared by all DRI clients, the
Xserver and the kernel driver, so the checks are pretty low cost (no
system calls or context switches required).

You only have to take the lock before changing the mode. DRI clients and
X will detect the change when they take the lock the next time and
adjust to the new conditions.

> 
> I was wanting to switch mode setting into an atomic operation where
> you passed in both the mode timings and buffer location.
> 
> -- 
> Jon Smirl
> jonsmirl@gmail.com

| Felix Kühling <fxkuehl@gmx.de>                     http://fxk.de.vu |
| PGP Fingerprint: 6A3C 9566 5B30 DDED 73C3  B152 151C 5CC1 D888 E595 |
