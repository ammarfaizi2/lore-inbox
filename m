Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751492AbWBLXvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbWBLXvy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 18:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWBLXvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 18:51:54 -0500
Received: from ozlabs.org ([203.10.76.45]:44940 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751492AbWBLXvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 18:51:53 -0500
Date: Mon, 13 Feb 2006 10:46:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Stephane Eranian <eranian@hpl.hp.com>
Cc: Philip Mucci <mucci@cs.utk.edu>, "Bryan O'Sullivan" <bos@serpentine.com>,
       perfmon@napali.hpl.hp.com, perfctr-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Perfctr-devel] Re: [perfmon] perfmon2 code review: 32-bit ABI on 64-bit OS
Message-ID: <20060212234606.GC24291@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Stephane Eranian <eranian@hpl.hp.com>,
	Philip Mucci <mucci@cs.utk.edu>,
	Bryan O'Sullivan <bos@serpentine.com>, perfmon@napali.hpl.hp.com,
	perfctr-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <1138221212.15295.35.camel@serpentine.pathscale.com> <20060125222844.GB10451@frankl.hpl.hp.com> <1138649612.4077.50.camel@localhost.localdomain> <1138651545.4487.13.camel@camp4.serpentine.com> <1139155731.4279.0.camel@localhost.localdomain> <1139245253.27739.8.camel@camp4.serpentine.com> <20060210153608.GC28311@frankl.hpl.hp.com> <1139596023.9646.111.camel@serpentine.pathscale.com> <1139681785.4316.33.camel@localhost.localdomain> <20060211223354.GA30327@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060211223354.GA30327@frankl.hpl.hp.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2006 at 02:33:54PM -0800, Stephane Eranian wrote:
> Hello,
> 
> On Sun, Feb 12, 2006 at 12:16:25AM +0600, Philip Mucci wrote:
> > > 
> > > On some 64-bit arches (e.g. x86_64), most userspace code is 64-bit,
> > > while on others (e.g. powerpc), most is 32-bit.  Reducing the number of
> > > things that a userspace tool or library writer can trip over seems like
> > > a good thing here, even if it slightly complicates perfmon's internals.
> > > 
> > > > Note that there are similar issues with the remapped sampling buffer.
> > > > There, you need to explicitly compile your tool with a special option
> > > > to force certain types to be 64-bit (size_t, void *).
> > > 
> > > It's pretty normal to just use 64-bit quantities in these cases, and
> > > cast appropriately.
> > 
> > I agree with Bryan. Stephane, do you have any quantitative data for how
> > much more expensive going to 64 bit quantities would be? Which
> > performance critical operations access this structure? AFAIK, any
> > performance monitoring system call is already slow by nature...and thus
> > an additional dozen cycles isn't going to make a difference. Of course,
> > if this structure needs to be read/written by get_pmd, including the
> > userspace version (+ mmap offset), then the extra overhead should be
> > considered. 
> > 
> I think I can easily convert the bitmasks to be u64 on all platforms.
> I don't think it will negatively impact performance on 32-bit applications.
> 
> The sampling buffer is another matter. It is directly remapped. The default
> format, exposes size_t and void *. The size_t is not on the critical
> path, it is used to specify the buffer size. If we expose as 64-bit,
> we need to check on 32-bit system that the value is below 4GB and cast
> to size_t.
> 
> The most challenging piece is the IP (program pointer) that is in every
> sample. Today it is defined as unsigned long because this is fairly
> natural for a code address. The 64bit OS captures addresses as 64-bit,
> the 32-bit monitoring tool running on top has to consume them as 64-bit
> addresses, so u64 would be fine. 
> 
> But not on a 32-bit kernel with a 32-bit tool, addresses exported as u64
> would certainly work but consume double to buffer space, and that is a
> more serious issue in my mind.

Hmm.. does the sampling buffer collect on userspace PC values, or
kernel ones as well?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
