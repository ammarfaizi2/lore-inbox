Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265119AbTLKPT7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 10:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265123AbTLKPT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 10:19:59 -0500
Received: from ida.rowland.org ([192.131.102.52]:4356 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S265119AbTLKPTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 10:19:53 -0500
Date: Thu, 11 Dec 2003 10:19:51 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Duncan Sands <baldrick@free.fr>
cc: Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
In-Reply-To: <200312111036.33115.baldrick@free.fr>
Message-ID: <Pine.LNX.4.44L0.0312111016230.1227-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Dec 2003, Duncan Sands wrote:

> On Wednesday 10 December 2003 19:19, Alan Stern wrote:
> >
> > I don't understand the problem.  What's wrong with dropping dev->serialize
> > before calling usb_reset_device() or usb_set_configuration() and then
> > reacquiring it afterward?
> 
> The problem is that between dropping the lock and usb_set_configuration (or
> whatever) picking it up again, the device may be disconnected, so usb_set_configuration
> needs to handle the case of being called after disconnect (it doesn't seem to
> check for that right now, but I only had a quick look).

It should handle that okay (provided you retain a reference to the 
usb_device so that it doesn't get deallocated).  Although it wouldn't hurt 
to change one of the tests from

	if (dev->state != USB_STATE_ADDRESS)

to

	if (dev->state > USB_STATE_ADDRESS)

>  Also, after usbfs picks up
> the lock again it needs to check for disconnect.  None of this is a big deal, but
> it could all be avoided by a simpler change: provide a usb_physical_set_configuration
> (or whatever), which is usb_set_configuration without taking dev->serialize.

I agree that it would ease things to provide entry points for set_config 
and reset_device that require the caller to hold dev->serialize already.  
The issue you and Oliver noted about holding the bus semaphore will go 
away when I finally get around to rewriting usb_reset_device().

Alan Stern

