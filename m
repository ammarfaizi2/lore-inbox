Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264591AbTLKJmU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 04:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264592AbTLKJmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 04:42:19 -0500
Received: from massena-4-82-67-197-146.fbx.proxad.net ([82.67.197.146]:65179
	"EHLO perso.free.fr") by vger.kernel.org with ESMTP id S264591AbTLKJmR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 04:42:17 -0500
From: Duncan Sands <baldrick@free.fr>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Thu, 11 Dec 2003 10:42:15 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0312081754480.2034-100000@ida.rowland.org> <200312101422.40088.baldrick@free.fr> <3FD75621.7010606@pacbell.net>
In-Reply-To: <3FD75621.7010606@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312111042.15310.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 December 2003 18:21, David Brownell wrote:
> [ CC list trimmed, most folk are on one of the cc'd lists ]
>
> > By the way, here is the list of routines that cause trouble for usbfs:

Hi Dave, by "they cause trouble" I meant: they may take, or lead to
taking, dev->serialize.  This means that before my patch they could
lead to occasional deadlocks, and with my patch will always cause
deadlocks.

> > usb_probe_interface
>
> In proc_resetdevice() ... after usb_reset_device().
> If usb_reset_device() worked sanely, it wouldn't be
> necessary to try fixing up its result.  Plus, last I
> looked, I don't think usbfs fixed it up correctly.
>
> Actually that call is dangerous and probably should
> fail if usbfs isn't controlling all the interfaces
> on the device ... checking before it tries.
>
> > usb_reset_device
>
> We've known for some time this routine needs a rewrite.
> It's never quite worked right, and it doesn't handle
> DFU style devices (like the most common USB 802.11b
> adapters) well at all.
>
> > usb_set_configuration
>
> That is, you're saying that _if_ usbfs is modified to
> get rid of ps->devsem and use dev->serialize instead,
> then you'd need some other way to guard proc_setconfig()
> against disconnect?  That still seems like a chicken/egg
> issue to me.

No.  usb_set_configuration takes dev->serialize, which is
already taken.  There is no other problem.

> > usb_unbind_interface
>
> See the patch I posted yesterday evening, with usbfs parts
> of the updates to driver binding.  It's incorrect for usbfs
> ever to be calling that ... device_release_driver() is the
> thing to call, for drivers that weren't bound using the
> usb_driver_claim_interface() call.  That way the sysfs
> state also gets cleaned up ...

Yeah, these things are a mess.  My patch only fixes the
locking problems, not the fact that they never worked
anyway.  Even so, it may be hard to get it into 2.6.0.

Duncan.
