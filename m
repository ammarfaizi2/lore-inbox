Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbTFTA3x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 20:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbTFTA3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 20:29:53 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48397 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262032AbTFTA3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 20:29:52 -0400
Date: Thu, 19 Jun 2003 17:43:26 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Steven Dake <sdake@mvista.com>
cc: Werner Almesberger <wa@almesberger.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] udev enhancements to use kernel event queue
In-Reply-To: <3EF250EF.1010802@mvista.com>
Message-ID: <Pine.LNX.4.44.0306191717120.1987-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 19 Jun 2003, Steven Dake wrote:
>
> Serialization is important for the case of a device state change 
> occuring rapidly.  An example is a device add and then remove, which 
> results in (if out of order) the add occuring after the remove, leaving 
> a dead device node in the filesystem.  This is tolerable.  What isn't as 
> tolerable is a remove and then an add, where the add occurs out of order 
> first.  In this case, a device node should exist on the filesystem, but 
> instead doesn't because the remove has come along and removed it.

This still isn't a global serialization thing, though. For example,
there's no reason _another_ device should be serialized with the disk
discovery.

And there are lots and lots of reasons why they should not EVER be
serialized, especially since full serialization (like through a shared
event deamon) results is _serious_ problems if one of the events end up
being a slow thing that needs to query and/or spin up hardware.

In other words, once you start talking about device nodes, you really want
to handle the serialization on a per-node basis. Having some kind of 
kernel support for that is quite possible a good idea, but care should be 
taken that non-dependent events shouldn't be serialized.

An easy way to do partial serialization is something like this:

 - each "call_usermodehelper()" gets associated with two numbers: the 
   "class number" and the "sequence number within a class". We keep track 
   of outstanding usermodehelpers.

   Add the class and sequence number to the environment of the hotplug 
   execution so that the user-mode hotplug code can query them.

 - we add a simple interface to allow a user mode helper to ask the kernel 
   to "please wait until class X has no pending sequence numbers smaller 
   than Y"

See what I'm aiming at? The class numbers shouldn't have any particular
meaning, they're just a random number (it might be the bus number of the
device that hotplugged, for example). But this allows a hotplug thing to
say "if there are other outstanding hotplug things in my class that were
started before me, wait here".

		Linus

