Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269989AbUIDAMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269989AbUIDAMl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 20:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269994AbUIDAMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 20:12:41 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:13722 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S269989AbUIDAMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 20:12:18 -0400
Date: Sat, 4 Sep 2004 01:12:16 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: dri-devel@lists.sf.net
Cc: linux-kernel@vger.kernel.org
Subject: New proposed DRM interface design
Message-ID: <Pine.LNX.4.58.0409040107190.18417@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay I've had some thoughts about the DRM interfaces and did some code
hacking (drmlib-0-0-1 branch on DRM CVS , very incomplete)

Below is my proposal for an interface that does introduce a major new
binary interface (the biggest issue with a straight core/personality split
for DRI developers, we have enough binary interfaces in our lives)...

Any comments are appreciated, the document is also available at:
http://dri.sourceforge.net/cgi-bin/moin.cgi/DRMRedesign

Dave.


This documents a proposed new design for the DRM internal kernel interfaces.

The current DRM suffers from a number of issues with multiple drivers in
the same kernel (the mess that is the drm_stub.h and parts of drm_drv.h)
along with the DRM() macros show this up. This design tries to address
this issue without introducing any major new binary interface.

I propose a 3 way code split-
	DRM core
	DRM library
	DRM driver

This is slightly along the lines of the fb where the core is fbmem + co,
the library is the cfb* object and the driver is the graphics chipset
specific.

What I would like to do for the DRM is not as extreme as the fb approach.
I propose the following type split:

	DRM core - just the stub registration procedure and handling any
shared resources like the device major number, and perhaps parts of sysfs
and class code. This interface gets set in stone as quickly as possible
and is as minimal as can be, (Jon Smirls dyn-minor patch will help a fair
bit also). All the core does is allow DRMs to register and de-register in
a nice easy fashion and not interfere with each other. This drmcore.o can
either be linked into the kernel (ala the fb core) or a module, but in
theory it should only really be shipped with the kernel - (for compat
reasons the DRM tree will ship it for older systems).

	DRM library - this contains all the non-card specific code, AGP
interface, buffers interface, memory allocation, context handling etc.
This is mostly stuff that is in templated header files now moved into C
files along the lines of what I've done in the drmlib-0-0-1-branch. This
file gets linked into each drm module, if you build two drivers into the
kernel it gets shared automatically as far as I can see, if you build as
modules they both end up with the code, for the DRM the single card is the
primary case so I don't mind losing some resources for having different
cards in a machine.

	DRM driver - the current driver files converted to the new
interfaces, I don't mind retaining some of the templating work, I like the
fact that we don't have 20 implementations of the drm probe or PCI tables
or anything like that, so I think some small uses of DRM() may still be
acceptable from a maintenance point of view.

