Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbVAGT5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVAGT5Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 14:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVAGT5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:57:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58759 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261554AbVAGTyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:54:37 -0500
Date: Fri, 7 Jan 2005 14:53:44 -0500
From: Dave Jones <davej@redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andreas Hartmann <andihartmann@01019freenet.de>,
       linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: Re: 2.4.x oops with X
Message-ID: <20050107195343.GH22299@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Andreas Hartmann <andihartmann@01019freenet.de>,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
References: <fa.m16skii.8mkd12@ifi.uio.no> <fa.f3n91fn.b42ahv@ifi.uio.no> <41DED15E.1070706@pD9F87953.dip0.t-ipconnect.de> <20050107170152.GI29176@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050107170152.GI29176@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 03:01:52PM -0200, Marcelo Tosatti wrote:

 > > Well, what do you mean with "disable AGP"? I can't disable it in the BIOS.
 > > I disabled DRI in the XF86Config-file. agpgart and r128 haven't been
 > > loaded (they are built as modules). The behaviour of the X-starting
 > > doesn't change and it's always the same: 
 > 
 > I meant not loading the agpgart/r128 modules, but it seems they are loaded 
 > on demand and X actually can't work without them.

If he disabled DRI in the X config file, they shouldn't be getting
loaded, so I'm curious why agp is in the picture..

 > Well the problem is the core dumping code (elf_core_dump function) is trying to write
 > your ATI card memory to disk, which is wrong. 
 > 
 > agp's mmap() method does not mark the memory region it creates as VM_IO to 
 > indicate its a device memory mapped region, and it should AFAICS.
 > 
 > The following corrects the situation and should stop the BUG() from happening, 
 > however the SIGSEGV which X is receiving seems to be a different thing.
 > 
 > Please try the following patch
 > 
 > Davej?
 > 
 > 
 > --- linux-2.4.28/drivers/char/agp/agpgart_fe.c.orig	2005-01-07 16:42:24.732957320 -0200
 > +++ linux-2.4.28/drivers/char/agp/agpgart_fe.c	2005-01-07 16:42:30.329106576 -0200
 > @@ -651,6 +651,7 @@
 >  			unlock_kernel();
 >  			return -EAGAIN;
 >  		}
 > +		vma->vm_flags |= VM_IO;
 >  		AGP_UNLOCK();
 >  		unlock_kernel();
 >  		return 0;
 > @@ -667,6 +668,7 @@
 >  			unlock_kernel();
 >  			return -EAGAIN;
 >  		}
 > +		vma->vm_flags |= VM_IO;
 >  		AGP_UNLOCK();
 >  		unlock_kernel();
 >  		return 0;

Looks ok on a first glance.

		Dave

