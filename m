Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264932AbUFHJVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264932AbUFHJVr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 05:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264929AbUFHJV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 05:21:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2746 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264916AbUFHJVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 05:21:15 -0400
Date: Tue, 8 Jun 2004 05:20:55 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Mike McCormack <mike@codeweavers.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040608092055.GX4736@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <40C2B51C.9030203@codeweavers.com> <20040606052615.GA14988@elte.hu> <40C2D5F4.4020803@codeweavers.com> <1086507140.2810.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086507140.2810.0.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2004 at 09:32:21AM +0200, Arjan van de Ven wrote:
> On Sun, 2004-06-06 at 10:29, Mike McCormack wrote:
> > Hi Ingo,
> > 
> > Ingo Molnar wrote:
> > 
> > > there are multiple methods in FC1 to turn this off:
> > > 
> > > - FC1 has PT_GNU_STACK support and all binaries that have no
> > >   PT_GNU_STACK program header will have the stock Linux VM layout. 
> > >   (including executable stack/heap) So by stripping the PT_GNU_STACK 
> > >   header from the wine binary you get this effect.
> > 
> > As far as we can tell, this alone does not stop the kernel from loading 
> > stuff at the addresses we need.  Even without PT_GNU_STACK ld-linux.so.2 
> > and libc are loaded below 0x01000000, which is the region that Wine 
> > assumes is free.  I think this may be due to prelinking...
> 
> that is prelink yes, not the kernel execshield.

But prelink only allocates in the area below executable if
/proc/sys/kernel/exec-shield exist (and only for i386; there is also
--exec-shield/--no-exec-shield to override).

Really the most safe way for Wine is to create a PT_LOAD segment with
p_flags 0 covering the whole area below the executable.  The kernel first
maps the executable, then the dynamic linker, so no matter what address
are ld.so and shared libraries prelinked to, they will not be mapped to the
area Wine reserves.
Unfortunately, there is no easy way in ld to create the segment ATM,
see http://sources.redhat.com/ml/binutils/2003-12/msg00211.html
In current binutils, perhaps creating a special linker script from the
default on the fly and assigning segments there could work, but maybe
far easier would be to just create one allocated PT_LOAD segment somewhere
and using libelf change it's location and p_flags.

Making Wine a PIE is also a possible solution (at least in FC2 for
non-prelinked PIEs kernel doesn't honor ld.so's prelinked address), but
then you cannot be sure the kernel doesn't choose the addresses Wine wishes
to reserve while randomizing.

	Jakub
