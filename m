Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992436AbWJTRiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992436AbWJTRiO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 13:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992464AbWJTRiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 13:38:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:50577 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S2992436AbWJTRiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 13:38:12 -0400
Date: Fri, 20 Oct 2006 10:37:57 -0700
From: Greg KH <gregkh@suse.de>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Martin Bligh <mbligh@mbligh.org>, Badari Pulavarty <pbadari@us.ibm.com>,
       jgarzik@pobox.com, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sukadev@us.ibm.com
Subject: Re: Panic in pci_call_probe from 2.6.18-mm2 and 2.6.18-mm3
Message-ID: <20061020173757.GA21427@suse.de>
References: <4528A26F.9000804@mbligh.org> <1160414389.17103.7.camel@dyn9047017100.beaverton.ibm.com> <452A85D8.70806@mbligh.org> <4539025B.301@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4539025B.301@shadowen.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 06:07:39PM +0100, Andy Whitcroft wrote:
> Martin Bligh wrote:
> > Badari Pulavarty wrote:
> >> On Sun, 2006-10-08 at 00:02 -0700, Martin J. Bligh wrote:
> >>
> >>> Not sure if you've seen this already ... catching up on test results.
> >>>
> >>> This was on NUMA-Q, on both -mm2 and -mm3. -mm1 didn't suffer from this
> >>> problem.
> >>>
> >>> Full logs:
> >>>
> >>> mm2 - http://test.kernel.org/abat/50727/debug/console.log
> >>> mm3 - http://test.kernel.org/abat/51442/debug/console.log
> >>>
> >>> config - http://test.kernel.org/abat/51442/build/dotconfig
> >>>
> >>> I'm guessing from the 00000004 that the pcibus_to_node(dev->bus)
> >>> is failing because bus->sysdata is NULL. The disassembly and
> >>> structure offsets seem to line up for that.
> >>>
> >>> #define pcibus_to_node(bus) (
> >>>     (struct pci_sysdata *)((bus)->sysdata))->node
> >>>
> >>> struct pci_sysdata {
> >>>         int             domain;         /* PCI domain */
> >>>         int             node;           /* NUMA node */
> >>> };
> >>>
> >>
> >>
> >> Martin,
> >>
> >> Jeff moved "node" to a proper field in sysdata, instead
> >> of overloading sysdata itself. I think this is causing the
> >> problem. I guess we could end up with sysdata = NULL in some
> >> cases ? Since you are the NUMA-Q expert, where does sysdata gets set
> >> for NUMA-Q ? :)
> >>
> >> -mm2 changed:
> >>
> >> #define pcibus_to_node(bus) ((long) (bus)->sysdata)
> >>
> >> to
> >> #define pcibus_to_node(bus) ((struct pci_sysdata *)((bus)->sysdata))-
> >>
> >>> node
> > 
> > Buggered if I know, that's some strange pci thing ;-)
> > 
> > But can we revert whatever patch that was until it gets fixed, please?
> 
> Unless I am going very very mad, this has came up once before some
> months ago.  We went through lots of pain finding the cause of this for
> NUMA-Q and fixing it.  Something about not having a sysdata and needing
> to initialise it.
> 
> Thought so, this was all discussed back in December 2005.
> 
>   http://lkml.org/lkml/2005/12/20/226
> 
> I'll go see if I can forward port the patch and address the remaining
> issues with it.

Yes, and I explicitly asked if this issue had been addressed again in
these patches.  That is why I rejected them oh so long ago...

bleah.

greg k-h
