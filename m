Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263898AbUEXE7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbUEXE7p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 00:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbUEXE7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 00:59:45 -0400
Received: from mail.kroah.org ([65.200.24.183]:37819 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263898AbUEXE7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 00:59:43 -0400
Date: Sun, 23 May 2004 21:58:54 -0700
From: Greg KH <greg@kroah.com>
To: Erik Steffl <steffl@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev and /dev/sda1 not found during boot (it's there right after boot)
Message-ID: <20040524045853.GA27216@kroah.com>
References: <408A1945.1030506@bigfoot.com> <20040424155507.GA11273@kroah.com> <40B0C9BB.4020304@bigfoot.com> <20040523162546.GA6500@kroah.com> <40B16C16.9000203@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B16C16.9000203@bigfoot.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2004 at 08:29:26PM -0700, Erik Steffl wrote:
>   I was hoping for something that would shed some light on _why_ this 
> happens on my (debian) system. The fact that it doesn't happen on your 
> systems that happen to be non-debian doesn't mean much... because I 
> don't see anything debian specific in debian package (which is the same 
> thing debian maintainer wrote, see link below).

It's all up to the init scripts, which are _very_ distro specific.

>   it looks like the problem is that after the modprobe is done the 
> device is still not available. that _seems_ like a serious problem of 
> udev.

No, it's not a serious problem.  The device will show up soon, but it's
not available _right_ after modprobe returns.  A lot of async events
need to happen before the node shows up.  That is the main change a lot
of different init scripts in distros have had to accommodate (alsa is
one specific example of this.)

> Maybe I am missing something but after the modprobe is done and 
> reports success

Wait, how does modprobe report success?  All it can return is if the
module loaded or not.  Not if a device actually was bound to that driver
or not (see the thread on lkml a week or so ago about how you can
determine this if you really want to.)

Lots of stuff happens in the kernel after modprobe returns successfully,
and for some kinds of drivers the device is not set up until a
measurable amount of time afterwards.

> the device should be available, ortherwise the programs 
> have no way to find out what's going on. Adding random sleeps (for how 
> long?) doesn't seem like a solution.

Don't randomly sleep, smartly sleep.  Sleep until you see the device
node you care about, or you time out after some longer amount of time
has gone by.  That's all that is needed to change in your init script
package.  As I don't run Debian on any of my boxes anymore, I really
can't be of much help here to try to debug this and change the proper
one to work in this manner.

So to summarize:
	- this isn't a kernel issue (so why talk about it on lkml?)
	- this isn't a udev issue (it creates the node as fast as it is
	  told to.)
	- this _is_ a startup script issue.  Please go bug your distro
	  to fix it in the manner described above.

Hope this helps,

greg k-h
