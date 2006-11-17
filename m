Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932943AbWKQQWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932943AbWKQQWt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 11:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933698AbWKQQWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 11:22:49 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:51873 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932943AbWKQQWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 11:22:48 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: David Chinner <dgc@sgi.com>
Subject: Re: [PATCH -mm 0/2] Use freezeable workqueues to avoid suspend-related XFS corruptions
Date: Fri, 17 Nov 2006 17:19:30 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <nigel@suspend2.net>
References: <200611160912.51226.rjw@sisk.pl> <20061117005052.GK11034@melbourne.sgi.com>
In-Reply-To: <20061117005052.GK11034@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611171719.31389.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 17 November 2006 01:50, David Chinner wrote:
> On Thu, Nov 16, 2006 at 09:12:49AM +0100, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > The following two patches introduce a mechanism that should allow us to
> > avoid suspend-related corruptions of XFS without the freezing of bdevs which
> > Pavel considers as too invasive (apart from this, the freezing of bdevs may
> > lead to some undesirable interactions with dm and for now it seems to be
> > supported for real by XFS only).
> 
> Has this been tested and proven to fix the problem with XFS? It's
> been asserted that this will fix XFS and suspend, but it's
> not yet been proven that this is even the problem.

The worker threads of the XFS work queues need not run after all of the other
tasks have been frozen.  In particular, they need not run after the suspend
image has been created, so making them freeze is reasonsble anyway.
[BTW, I'm going to do the same with all of the worker threads in the system
that need not run during the suspend.]

The question remains whether it's _sufficient_ to freeze these worker threads
and my opinion is that yes, it should be sufficient.

> I think the problem is a race between sys_sync, the kernel thread
> freeze and the xfsbufd flushing async, delayed write metadata
> buffers resulting in a inconsistent suspend image being created.
> If this is the case, then freezing the workqueues does not
> fix the problem. i.e:
> 
> suspend				xfs
> -------				---
> sys_sync completes
> 				xfsbufd flushes delwri metadata
> kernel thread freeze
> workqueue freeze

freeze device
disable IRQs
freeze system devices (including APICs etc.)

> suspend image start
> 				async I/O starts to complete

Now please tell me how this is possible?

> suspend image finishes
> 				async I/O all complete
> 
> The problem here is the memory image has an empty delayed write
> metadata buffer queue, but the I/O completion queue will be missing
> some (or all) of the I/O that was issued, and so on resume we have
> a memory image that still thinks the I/Os are progress but they
> are not queued anywhere for completion processing.

Everything that was in memory before the suspend image has been created
will also be there right after the resume, because the only thing that can
access memory while the image is being created is the suspend thread.

I think the only problem that _may_ happen (without the patch) is this:

suspend				xfs
-------				----
suspend image start
suspend image finishes
thaw system devices
enable IRQs
thaw devices
				xfsbufd flushes delwri metadata
 				async I/O starts to complete
save image

Now, after a successful resume xfsbufd will attempt to flush the metadata
_once_ _again_, because it doesn't know of what has happend after
creating the image.
 
Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
