Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264643AbSJTUea>; Sun, 20 Oct 2002 16:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264644AbSJTUea>; Sun, 20 Oct 2002 16:34:30 -0400
Received: from air-2.osdl.org ([65.172.181.6]:11136 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S264643AbSJTUe2>;
	Sun, 20 Oct 2002 16:34:28 -0400
Date: Sun, 20 Oct 2002 13:43:43 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: "Adam J. Richter" <adam@yggdrasil.com>, <linux-kernel@vger.kernel.org>,
       <eblade@blackmagik.dynup.net>, Russell King <rmk@arm.linux.org.uk>
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend
 devices
In-Reply-To: <m1of9pwjt3.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.44.0210201330380.963-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Mostly I want a comment from Patrick Mochel why he made the change,
> and roughly what he was thinking.  So I have a good idea about which
> code I need to dig into and send patches to fix.  If he makes a good
> case for an independent shutdown, method I am fine with that, just
> every driver in the kernel needs to change, and that is a heck of a
> lot of work before 2.6.  Otherwise we can go back to calling remove.

The main problem is locking and refcounting on the device objects. 
->remove() is removing objects from the device tree and freeing them. This 
is not good when we expect the list to remain intact while we iterate over 
it. 

This is fine when a device is unplugged or a module is removed, but 
completely unnecessary during a power transition. Nothing is going away; 
we're just turning everything off. And, we don't we don't have to mess 
with getting the list traversal right, since we can assume it's intact. 

In short, it's about the data structures, not the hardware. It is going to
require modification to drivers, but the changes should be small and make
the code cleaner. It can also happen gradually. There is going to be a lot
of cleanup of drivers in the coming months as more things are converted to
exploit the driver model, anyway. 

In general, I agree with the patch that you sent later in the thread. I'll 
apply it, at least for now. 

	-pat

