Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751544AbWCZU4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbWCZU4U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 15:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWCZU4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 15:56:20 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:728 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751544AbWCZU4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 15:56:19 -0500
From: Rob Landley <rob@landley.net>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
Date: Sun, 26 Mar 2006 15:55:51 -0500
User-Agent: KMail/1.8.3
Cc: Arjan van de Ven <arjan@infradead.org>, nix@esperi.org.uk,
       mmazur@kernel.pl, linux-kernel@vger.kernel.org,
       llh-discuss@lists.pld-linux.org
References: <200603141619.36609.mmazur@kernel.pl> <1143376008.3064.0.camel@laptopd505.fenrus.org> <F31089B5-0915-439D-B218-009384E2148F@mac.com>
In-Reply-To: <F31089B5-0915-439D-B218-009384E2148F@mac.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603261555.51504.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 March 2006 7:34 am, Kyle Moffett wrote:
> Well I guess you could call it UABI, but that might also imply that
> it's _userspace_ that defines the interface, instead of the kernel.
> Since the headers themselves are rather tightly coupled with the
> kernel, I think I'll stick with the KABI name for now (unless
> somebody can come up with a better one, of course :-D).

Ok, question, using an example I'm familiar with.  What's affected by the 
prefix?

The busybox code for associating loopback devices with files was a problem for 
_years_.  The standard advice was not to include linux/loop.h, but instead 
cut and paste the structure out of the header into your own code.  
(Apparently, you're allowed to be uncomfortable if somebody suggests that 
this is the right way to get portability between bsd/cygwin/linux, but 
between 2.4 and 2.6 it's best practices.  Ok.)

Unfortunately, the cut and paste approach turned out to be incredibly painful 
because busybox needs to be portable between hardware platforms and between 
kernel versions.

Problem 1: The actual type of __kernel_dev_t varies between 
x86/arm/alpha/ppc/etc.  Any attempt to define our own loop ioctl structure 
meant we needed to either use the kernel-defined data type for this, or have 
an #ifdef forest for every possible platform somebody might want to build 
busybox on.  (This was exploded into a mess instantly.)

But using the kernel kdev_t type sucked too, because between 2.4 and 2.6 it 
got renamed to old_kdev_t so then we needed #ifdefs to check the kernel 
version of the headers we'd imported to see which name it was using.  (And it 
still broke anyway in strange various corner cases depending on which distro 
people were building under.)

We wandered through dozens of different approaches trying to avoid "#include 
<linux/loop.h>".  We had #ifdefs for glibc and #ifdefs for uclibc...  It was 
terrible.  About half the suggestions got checked into the tree at various 
points:
http://www.busybox.net/cgi-bin/viewcvs.cgi/trunk/busybox/libbb/loop.c?rev=14554&view=log

There were more that merely showed up on the list...

We eventually got it all untangled.  Now we check if we're on 2.6 and if so 
use the 64 bit API (which is stable on 2.6), and otherwise use a copy of the 
32 bit structure that predates __kernel_dev_t being renamed.  And we trust 
the darn kernel headers to supply the types for us, because there's just no 
alternative.

My question is: will your new approach work with our existing code, or are you 
saying we need another #ifdef to check for yet another gratuitously 
incompatible name, ala _kabi__kernel_dev_t?  Because I _really_ don't want to 
go there.  Nobody will be able to build existing versions of busybox (at 
least the mount/umount/losetup commands) against your new thing.  New 
versions that actually depended on _kabi_blah wouldn't build on any older 
distros unless we add another #ifdef...

This is just an example.  There is currently no existing program out in 
userspace that is tries to talk to the kernel using names with _kabi_ 
prepended to them, that I am aware of.  If you're adding this prefix, you're 
writing a brand new interface which currently has exactly zero users.  Is 
this the intent?

> Cheers,
> Kyle Moffett

Rob
-- 
Never bet against the cheap plastic solution.
