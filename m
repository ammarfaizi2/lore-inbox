Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264663AbSJOQ4Z>; Tue, 15 Oct 2002 12:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264670AbSJOQ4Y>; Tue, 15 Oct 2002 12:56:24 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1146 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S264663AbSJOQzg>; Tue, 15 Oct 2002 12:55:36 -0400
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: Patrick Mochel <mochel@osdl.org>, eblade@blackmagik.dynup.net,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
References: <200210150253.TAA02434@adam.yggdrasil.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 15 Oct 2002 10:59:56 -0600
In-Reply-To: <200210150253.TAA02434@adam.yggdrasil.com>
Message-ID: <m13cr74oz7.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" <adam@yggdrasil.com> writes:

> Eric W. Biederman writes:

> >If there is non-trivial work to detect if a card is present it
> >probably makes sense to factor remove into
> >->quiet() and ->remove()
> >Where quiet would put the device into a quiescent state, and
> >remove would simply clean up the driver state.
> 
>         Splitting into ->quiet() and ->removed() would be helpful
> in any case, where removed() would normally not touch the hardware,
> since it is quite possible the device has already been removed,
> since the callers of these routines generally know if they are
> calling because the device has been removed or because they want
> just want to turn it off, while ->remove() currently has to guess,
> which not only wastes time but also can be difficult to do safely
> when you don't know if the device that you're talking to is even
> present anymore.

Except for the case when a device is physically swapped before ->remove()
which is really, really, nasty.  But it is quiet unlikely anyone will
actually be that fast.  Whatever talks to the hardware has to check to
see if it's device  is present.  But if usb is anything like PCI it 
should be a very inexpensive check to see if a driver is present.  And
writes to a non-existent device should be safe.

Splitting ->remove() into quiet() and ->removed() will be racy.  So
unless there is shown to be a compelling reason to do the split I
don't want to go there.  It appears easier to write correct code
with a single ->remove() method than two separate methods in the
hot-plug case.

Eric
