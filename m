Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWBCO3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWBCO3R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 09:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbWBCO3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 09:29:17 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:20234 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1750892AbWBCO3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 09:29:16 -0500
Date: Fri, 3 Feb 2006 15:29:15 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Dave Jones <davej@redhat.com>, Nigel Cunningham <nigel@suspend2.net>,
       Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060203142915.GA44720@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Pavel Machek <pavel@ucw.cz>, Dave Jones <davej@redhat.com>,
	Nigel Cunningham <nigel@suspend2.net>,
	Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602022131.59928.nigel@suspend2.net> <84144f020602020344p228e20b2x34226f341c296578@mail.gmail.com> <200602022228.20032.nigel@suspend2.net> <20060202154319.GA96923@dspnet.fr.eu.org> <20060202202527.GC2264@elf.ucw.cz> <20060202203155.GE11831@redhat.com> <20060202205148.GE2264@elf.ucw.cz> <20060203011839.GA58691@dspnet.fr.eu.org> <20060203104129.GC2830@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203104129.GC2830@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 11:41:29AM +0100, Pavel Machek wrote:
> > I don't even want to think about the interactions
> > between freezing the userspace memory pages and running some processes
> > which may malloc/mmap at the same time.
> 
> There are none. userspace helper is mlocked, and rest of userspace is
> stopped.

Unless the userspace code is as tight as mission-critical RT code, I
don't see how that can work reliably.  Some problems I see:

- What happens if the helper faults in new pages, changes its brk or
mmaps things?  Can we actually swap at that point?  mlocking takes
care of the fault in, not of the rest.

- What happens if the helper reads files?  Where will the pages with
the file data be put?  Are we saving the dcache in the image, and if
yes which state of the dcache?

- What happens if the helper writes files?  What state are we saving,
before starting the helper or after?  Will the fs be in a coherent
state after resume?

- What about IPC?  What if for instance the helper tries to contact
HAL to get some system information?

And if you decide on rules on what the userspace can and can't do, how
do you plan to enforce them?  We have filesystems on the line there,
you don't want them destroyed at resume because the latest version of
kdome-resume-progress-bar thought it was cool to generate an picture
of the desktop at suspend time to show at resume.

The idea of trying to save a state that can be modified dynamically
while you're saving in unpredictable ways makes me very, very afraid.
At least when you're in the kernel you can have complete control over
the machine when needed.

  OG.

