Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752918AbWKLTkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbWKLTkM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 14:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752926AbWKLTkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 14:40:12 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:54028 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1752918AbWKLTkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 14:40:10 -0500
Date: Sun, 12 Nov 2006 19:40:01 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mikael Pettersson <mikpe@it.uu.se>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] floppy: suspend/resume fix
Message-ID: <20061112194000.GC14005@flint.arm.linux.org.uk>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Mikael Pettersson <mikpe@it.uu.se>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <200611121753.kACHrDDi004283@harpo.it.uu.se> <20061112180953.GA3266@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061112180953.GA3266@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2006 at 07:09:53PM +0100, Ingo Molnar wrote:
> 
> * Mikael Pettersson <mikpe@it.uu.se> wrote:
> 
> > Sorry, no joy. The first access post-resume still fails and generates:
> 
> ok, then someone who knows the floppy driver better than me should put 
> the right stuff into the suspend/resume hooks :-)

At a guess, what's probably happening is that the floppy drive, when
powered on after resume, reports "disk changed" because it doesn't
know any better.

We interpret "disk changed" to mean the disk has been removed and
possibly changed (which _is_ correct) and thereby abort any further
IO (irrespective of resume.)

Now, consider the following two scenarios:

1. You suspend and then resume, leaving the disk in the floppy drive.

2. You suspend, remove the floppy disk, insert a totally different disk
   in the same drive, and then resume.

What should you do?  (Hint: without reading the disk and comparing it
with what you have cached you don't know if the disk has been changed
or not.)

If you argue that in case (1) you should continue to allow IO, then
you potentially end up scribbling over a disk when someone does (2).

So I'd argue that the behaviour being seen by Mikael is the _safest_
behaviour, and the most correct behaviour given the limitations of
the hardware.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
