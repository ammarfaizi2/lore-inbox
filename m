Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753168AbWKLUr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbWKLUr2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 15:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753177AbWKLUr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 15:47:28 -0500
Received: from aun.it.uu.se ([130.238.12.36]:4815 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1753168AbWKLUr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 15:47:27 -0500
Date: Sun, 12 Nov 2006 21:47:08 +0100 (MET)
Message-Id: <200611122047.kACKl8KP004895@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: mingo@elte.hu, rmk+lkml@arm.linux.org.uk
Subject: Re: [patch] floppy: suspend/resume fix
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Nov 2006 19:40:01 +0000, Russell King wrote:
> On Sun, Nov 12, 2006 at 07:09:53PM +0100, Ingo Molnar wrote:
> > 
> > * Mikael Pettersson <mikpe@it.uu.se> wrote:
> > 
> > > Sorry, no joy. The first access post-resume still fails and generates:
> > 
> > ok, then someone who knows the floppy driver better than me should put 
> > the right stuff into the suspend/resume hooks :-)
> 
> At a guess, what's probably happening is that the floppy drive, when
> powered on after resume, reports "disk changed" because it doesn't
> know any better.
> 
> We interpret "disk changed" to mean the disk has been removed and
> possibly changed (which _is_ correct) and thereby abort any further
> IO (irrespective of resume.)
> 
> Now, consider the following two scenarios:
> 
> 1. You suspend and then resume, leaving the disk in the floppy drive.
> 
> 2. You suspend, remove the floppy disk, insert a totally different disk
>    in the same drive, and then resume.
> 
> What should you do?  (Hint: without reading the disk and comparing it
> with what you have cached you don't know if the disk has been changed
> or not.)
> 
> If you argue that in case (1) you should continue to allow IO, then
> you potentially end up scribbling over a disk when someone does (2).
> 
> So I'd argue that the behaviour being seen by Mikael is the _safest_
> behaviour, and the most correct behaviour given the limitations of
> the hardware.

Note that my usage scenario consists of separate I/O commands:

1. boot
2. tar cf /dev/fd0 somefile
3. tar tvf /dev/fd0
4. suspend (close lid) and later resume (open lid) 
5. tar tvf /dev/fd0 (this one fails since 2.6.18-rc1)

Ages and ages ago the floppy driver would cache data so that
after e.g. one "tar tvf /dev/fd0" command, a new "tar tvf /dev/fd0"
wouldn't actually do any I/O. But nowadays, at least in all 2.6
kernels, that's not done and both "tar tvf /dev/fd0" commands
will read the media.

Thus I don't see any excuse for the kernel failing step 5 above.

/Mikael
