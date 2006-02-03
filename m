Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWBCR2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWBCR2S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 12:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWBCR2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 12:28:18 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:49562 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751266AbWBCR2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 12:28:17 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Olivier Galibert <galibert@pobox.com>
Subject: Re: [ 00/10] [Suspend2] Modules support.
Date: Fri, 3 Feb 2006 18:24:44 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Dave Jones <davej@redhat.com>,
       Nigel Cunningham <nigel@suspend2.net>,
       Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060203104129.GC2830@elf.ucw.cz> <20060203142915.GA44720@dspnet.fr.eu.org>
In-Reply-To: <20060203142915.GA44720@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602031824.45467.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 February 2006 15:29, Olivier Galibert wrote:
> On Fri, Feb 03, 2006 at 11:41:29AM +0100, Pavel Machek wrote:
> > > I don't even want to think about the interactions
> > > between freezing the userspace memory pages and running some processes
> > > which may malloc/mmap at the same time.
> > 
> > There are none. userspace helper is mlocked, and rest of userspace is
> > stopped.
> 
> Unless the userspace code is as tight as mission-critical RT code, I
> don't see how that can work reliably.

I use it on a daily basis.  It works.

> Some problems I see: 
> 
> - What happens if the helper faults in new pages, changes its brk or
> mmaps things?  Can we actually swap at that point?

Yes.

> mlocking takes care of the fault in, not of the rest.
> 
> - What happens if the helper reads files?  Where will the pages with
> the file data be put?  Are we saving the dcache in the image, and if
> yes which state of the dcache?

The suspending helper should not use mounted filesystems after it
calls the atomic snapshot ioctl().  The resuming helper should be run from
an initrd and all filesystems should be unmounted at that time (of course
it should not attempt to mount them).

Please read the Documentation/power/userland-swsusp.txt file in the latest -mm
and you'll get an idea of how it works.

> - What happens if the helper writes files?  What state are we saving,
> before starting the helper or after?

After.

> Will the fs be in a coherent state after resume?

Yes, it will, as long as the helpers follow some strict rules (above).

> - What about IPC?  What if for instance the helper tries to contact
> HAL to get some system information?

That doesn't matter.

> And if you decide on rules on what the userspace can and can't do, how
> do you plan to enforce them?  We have filesystems on the line there,
> you don't want them destroyed at resume because the latest version of
> kdome-resume-progress-bar thought it was cool to generate an picture
> of the desktop at suspend time to show at resume.
> 
> The idea of trying to save a state that can be modified dynamically
> while you're saving in unpredictable ways makes me very, very afraid.
> At least when you're in the kernel you can have complete control over
> the machine when needed.

Not necessarily.  For example, if you suspend the box and then start it with
a wrong kernel that is unable to read the image, it will mount the file
systems and you loose the saved state.

Greetings,
Rafael
