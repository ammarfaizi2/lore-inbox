Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267620AbUHEKVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267620AbUHEKVx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 06:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267625AbUHEKVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 06:21:52 -0400
Received: from mail5.tpgi.com.au ([203.12.160.101]:62109 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S267620AbUHEKUp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 06:20:45 -0400
Subject: Re: Solving suspend-level confusion
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: David Brownell <david-b@pacbell.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Oliver Neukum <oliver@neukum.org>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <200408041829.45298.david-b@pacbell.net>
References: <20040730164413.GB4672@elf.ucw.cz>
	 <200408031928.08475.david-b@pacbell.net>
	 <1091586381.3189.14.camel@laptop.cunninghams>
	 <200408041829.45298.david-b@pacbell.net>
Content-Type: text/plain
Message-Id: <1091701150.2964.229.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 05 Aug 2004 20:19:10 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-08-05 at 11:29, David Brownell wrote:
> On Tuesday 03 August 2004 19:26, Nigel Cunningham wrote:
> 
> > > There's now some partial-tree code in CONFIG_USB_SUSPEND (for
> > > developers only), but jumping from USB into the next level driver
> > > (SCSI, video, etc) raises questions.
> > 
> > I've also done partial-tree support for suspend2 by making a new list
> > (along side the active, off and off_irq lists) and simply moving devices
> > I want to keep on (plus their parents) to this list prior to calling
> > device_suspend. Works well for keeping alive the ide devices being used
> > write the image.
> 
> What I'd need out of the PM framework would be "suspend this subtree",
> and its cousin "resume this subtree".  Where the subtree starts with a
> given device ... and, if it's got a driver, any abstract devices created
> by that driver.  (And their children, etc.)

I've just finished implementing a 'suspend this subtree' patch, which
I'll happily post for comments/testing. I'll try to do that shortly.

> I'm not sure what to think about the desire of "suspend2" to prevent
> a subtree from suspending.  In fact, I'm not at all sure how to even
> interpret a "can't suspend" failure code... device in trouble, likely.

I didn't implement it as devices saying 'can't suspend'. Instead, I
added a layer of abstraction. Imagine the current dpm_active, dpm_off
and dpm_off_irq lists as representing the states of a subtree of the
devices. We pop them into a struct partial_device_tree (device_subtree
better?) and provide facilities for creating and destroying new struct
partial_device_trees, moving a-device-and-its-parents between trees and
merging trees back. We also adjust the current suspend, resume, power-up
and power-down routines so they're tree-aware and set up a
'default_device_tree' that the devices sit in for normal operation.
That's what my patch does. I kept the existing api untouched so that:

device_resume();

is actually a wrapper for

device_resume_tree(&default_device_tree);

Proof of the pudding coming :>

Nigel

