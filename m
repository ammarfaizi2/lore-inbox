Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263768AbTLJRNS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 12:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbTLJRNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 12:13:18 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:37537 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S263768AbTLJRNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 12:13:15 -0500
Message-ID: <3FD75621.7010606@pacbell.net>
Date: Wed, 10 Dec 2003 09:21:37 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Duncan Sands <baldrick@free.fr>
CC: linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
References: <Pine.LNX.4.44L0.0312081754480.2034-100000@ida.rowland.org> <200312101422.40088.baldrick@free.fr>
In-Reply-To: <200312101422.40088.baldrick@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ CC list trimmed, most folk are on one of the cc'd lists ]

> By the way, here is the list of routines that cause trouble for usbfs:
> 
> usb_probe_interface

In proc_resetdevice() ... after usb_reset_device().
If usb_reset_device() worked sanely, it wouldn't be
necessary to try fixing up its result.  Plus, last I
looked, I don't think usbfs fixed it up correctly.

Actually that call is dangerous and probably should
fail if usbfs isn't controlling all the interfaces
on the device ... checking before it tries.

> usb_reset_device

We've known for some time this routine needs a rewrite.
It's never quite worked right, and it doesn't handle
DFU style devices (like the most common USB 802.11b
adapters) well at all.

> usb_set_configuration

That is, you're saying that _if_ usbfs is modified to
get rid of ps->devsem and use dev->serialize instead,
then you'd need some other way to guard proc_setconfig()
against disconnect?  That still seems like a chicken/egg
issue to me.

> usb_unbind_interface

See the patch I posted yesterday evening, with usbfs parts
of the updates to driver binding.  It's incorrect for usbfs
ever to be calling that ... device_release_driver() is the
thing to call, for drivers that weren't bound using the
usb_driver_claim_interface() call.  That way the sysfs
state also gets cleaned up ...

- Dave


