Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTEVODu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 10:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbTEVODu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 10:03:50 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:38691 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S261872AbTEVODs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 10:03:48 -0400
From: Jos Hulzink <josh@stack.nl>
To: Andrew Morton <akpm@digeo.com>, "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: must-fix list, v5
Date: Thu, 22 May 2003 16:23:22 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <F760B14C9561B941B89469F59BA3A84725A2B5@orsmsx401.jf.intel.com> <20030522013101.7181cdb0.akpm@digeo.com>
In-Reply-To: <20030522013101.7181cdb0.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305221623.22403.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 May 2003 10:31, Andrew Morton wrote:
> "Grover, Andrew" <andrew.grover@intel.com> wrote:
> > > From: Andrew Morton [mailto:akpm@digeo.com]
> >
> > Hi just wanted to add some comments below:
>
> Appreciated, thanks.
>
> > >  drivers/acpi/
> > >  ~~~~~~~~~~~~~
> > >
> > >  o davej: ACPI has a number of failures right now.  There are
> >
> > ...
> >
> > Working on these (they're all in bugzilla), more help needed of course
> >
> > :)
>
> OK, well if they're safely bugzilla'd I shall remove them from here.
> Unless you think they're drop-dead stop-ship material.
>
> > > +o mochel: it seems the acpi irq routing code could use a
> > > serious rewrite.
> >
> > No the problem is the ACPI irq routing code is trying to piggyback on
> > the existing MPS-specific data structures, and it's generally a hack. So
> > yes mochel is right, but it is also purging MPS-ities from common code
> > as well. I've done some preliminary work in this area and it doesn't
> > seem to break anything (yet) but a rewrite in this area imho should not
> > be rushed out the door. And, I think the above bugs can be fixed w/o the
> > rewrite.
>
> Where do you think this work sits on the seriousness scale?  Is it
> affecting a lot of people?  Is it a large-scale restructure?

This is what bug 699 is all about I think. As far as I can see, it is a 
serious issue for people with MPS 1.4 systems: The system is unusable due to 
wrong IRQ mappings. MPS 1.4 is used in most (all ?) PPro and PII SMP systems, 
though often can be disabled. I can't say how many systems really rely on MPS 
1.4. Workaround that works for most people is booting with pci=noacpi, though 
I have reports of systems where this isn't the solution. MPS 1.1 systems 
work, though this is more a coincidence than well coded ACPI behaviour.

The amount of people that can't possibly get Linux booting with ACPI enabled 
will not be big. The amount of people that think it's annoying they have to 
disable MPS 1.4 or ACPI to get a running system might be somewhat bigger. My 
box only shuts down with ACPI, and thanks to MPS 1.4 my soundcard doesn't 
glitch when there is heavy SCSI activity. (Onboard SCSI & Soundcard share the 
interrupt when MPS 1.4 is disabled). 

Basically, what happens is that ACPI forgets to look for MPS tables when no 
MADT is found. It assumes the APIC should be set up in PIC mode, though the 
APIC has been rerouted already. As a result, the irq entries in pci_dev are 
filled with the "below 15" values, while the APIC generates "above 15" 
interrupts.

Jos
